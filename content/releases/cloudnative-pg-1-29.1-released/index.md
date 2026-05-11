---
title: "Security and reliability release: CloudNativePG 1.29.1 and 1.28.3"
date: 2026-05-08
draft: false
authors:
 - gbartolini
image:
    url: 58364dde1adc4a0a8.37186404-2048x1445.jpg
    attribution: from <a href="https://wordpress.org/photos/photo/58364dde1a/">Saurabh</a>
tags:
  - release
  - postgresql
  - postgres
  - kubernetes
  - k8s
  - cloudnativepg
  - cnpg
  - security
  - CVE
  - high-availability
summary: "CloudNativePG 1.29.1 and 1.28.3 are now available. These releases address CVE-2026-44477 (Critical, CVSS 9.4) in the metrics exporter, remediate additional CVEs in pgx and the Go runtime, and ship important HA fixes including two data-safety failover bugs. All users should upgrade immediately."
---

The CloudNativePG community is releasing **maintenance updates for all
currently supported series**: **1.29.1** and **1.28.3**.

This is a high-priority release. It addresses **[CVE-2026-44477](https://github.com/cloudnative-pg/cloudnative-pg/security/advisories/GHSA-423p-g724-fr39)**
— the first CVE officially assigned against CloudNativePG, rated **Critical**
with a CVSS v4 score of **9.4** — alongside additional CVE remediations in
dependencies and the Go runtime.

On the reliability side, three independent bugs in the HA failover path are
resolved, including a label retention issue that could route writes to a former
primary during a network partition
([#10409](https://github.com/cloudnative-pg/cloudnative-pg/pull/10409)), a
condition that prevented failover from triggering when a node became
unreachable
([#10448](https://github.com/cloudnative-pg/cloudnative-pg/pull/10448)), and a
guard against spurious failovers from transient HTTP endpoint failures
([#10445](https://github.com/cloudnative-pg/cloudnative-pg/pull/10445)). Both
releases also include a number of correctness and robustness fixes — see the
release notes for the full list.

**All users should upgrade immediately.**

---

## Security

### CVE-2026-44477: metrics exporter privilege escalation and OS RCE

The metrics exporter previously opened its PostgreSQL connection as the
`postgres` superuser and demoted the session with `SET ROLE pg_monitor`. That
demotion is insufficient: `session_user` remains `postgres`, and any SQL
evaluated inside the scrape session can call `RESET ROLE` to recover full
superuser privileges, then use `COPY ... TO PROGRAM` to spawn an arbitrary OS
process inside the primary pod.

Two independent paths exploit this root cause. The first requires a custom
metric query with an unqualified relation or function reference; the attack
completes within one scrape interval (≤ 30 s). The second requires no custom
metrics at all: the shipped `pg_extensions` metric was sufficient to let the
default `app` role — created automatically by `bootstrap.initdb` — trigger
the full escalation chain on a completely stock deployment. The combined impact
is superuser privilege escalation plus arbitrary OS command execution inside
the primary pod from a low-privileged database role.

The fix introduces a dedicated `cnpg_metrics_exporter` PostgreSQL role with
`pg_monitor` privileges only, mapped via `pg_ident.conf` peer authentication
(the same pattern used for `cnpg_pooler_pgbouncer`). The exporter now connects
as this role, so `RESET ROLE` has no escalation effect. All shipped monitoring
queries have also been hardened with explicit `pg_catalog.` qualification
([#10576](https://github.com/cloudnative-pg/cloudnative-pg/pull/10576)).

For the full technical analysis, exploitation paths, workarounds and upgrade
impact, refer to the
[security advisory](https://github.com/cloudnative-pg/cloudnative-pg/security/advisories/GHSA-423p-g724-fr39).

### Additional CVE remediations

These releases also pick up:

- **`github.com/jackc/pgx/v5` v5.9.2**: fixes `CVE-2026-33816`
  (memory-safety in `pgproto3`) and `GHSA-j88v-2chj-qfwx` (SQL injection via
  dollar-quoted string handling in the simple protocol).

- **Go 1.26.3 runtime**: fixes across `crypto/x509`, `crypto/tls`,
  `net/http`, and `net` (CVE-2026-32280, CVE-2026-32281, CVE-2026-33810,
  CVE-2026-33811, CVE-2026-33814, CVE-2026-39825), plus CVE-2026-42501 in
  `cmd/go` module-checksum validation during release builds.

- **Discoverable SBOM and provenance attestations**
  ([#10601](https://github.com/cloudnative-pg/cloudnative-pg/pull/10601)):
  attestations attached to operator images now follow the OCI 1.1 Referrers
  spec, making them automatically discoverable by standard registry tooling and
  supply-chain scanners.

---

## Acknowledgement

We thank **Mehmet Ince** ([@mdisec](https://github.com/mdisec)) for
responsibly disclosing CVE-2026-44477, providing a thorough analysis of both
exploitation paths and a working proof of concept.

---

## Upgrade

Follow the upgrade instructions specific to your series:

- **1.29.x → 1.29.1:** [upgrade guide](https://cloudnative-pg.io/docs/1.29/installation_upgrade#upgrading-to-1291-or-1283)
- **1.28.x → 1.28.3:** [upgrade guide](https://cloudnative-pg.io/docs/1.28/installation_upgrade#upgrading-to-1291-or-1283)

For deployments with replica clusters, upgrade the source primary cluster
first — see the [security advisory](https://github.com/cloudnative-pg/cloudnative-pg/security/advisories/GHSA-423p-g724-fr39)
for sequencing details.

For the complete list of changes, see the release notes:

- [Release notes for 1.29.1](https://cloudnative-pg.io/docs/1.29/release_notes/v1.29/#version-1291)
- [Release notes for 1.28.3](https://cloudnative-pg.io/docs/1.28/release_notes/v1.28/#version-1283)

---

## Get Involved with the Community

[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

If you're using CloudNativePG in production, consider
[adding your organization as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project's growth and evolution.

Thank you for your continued support! Upgrade today and discover how
CloudNativePG can elevate your PostgreSQL experience to new heights.

<!--
## About CloudNativePG

[CloudNativePG](https://cloudnative-pg.io) is an open-source Kubernetes
Operator specifically designed for PostgreSQL workloads. It manages the entire
lifecycle of a PostgreSQL cluster, including bootstrapping, configuration, high
availability, connection routing, and comprehensive backup and disaster
recovery mechanisms. By leveraging PostgreSQL's native streaming replication,
CloudNativePG efficiently distributes data across pods, nodes, and zones using
standard Kubernetes patterns, enabling seamless scaling of replicas in a
Kubernetes-native manner. Originally developed and supported by
[EDB](https://www.enterprisedb.com/), CloudNativePG is a CNCF Sandbox project
and the sole PostgreSQL operator in this category.
-->
