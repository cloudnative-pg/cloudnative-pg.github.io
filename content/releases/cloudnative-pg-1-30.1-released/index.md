---
title: "CloudNativePG 1.30.1 and 1.29.3 released"
date: 2026-09-23
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
  - high-availability
  - failover
  - cve
summary: "CloudNativePG 1.30.1 and 1.29.3 are now available, with continued improvements to failover behavior and a handful of other fixes and enhancements. Upgrading is recommended as part of your normal maintenance cycle."
---

The CloudNativePG community is releasing **maintenance updates for both
currently supported series**: **1.30.1** and **1.29.3**.

These are routine updates, and CloudNativePG remains as stable as ever. The
main thread running through both releases is continued polish to failover
and primary-election behavior, part of our ongoing investment in making
replication, including asynchronous setups, more predictable under
real-world conditions. A pending failover that could previously stall or get
silently reverted is now handled correctly
([#11336](https://github.com/cloudnative-pg/cloudnative-pg/pull/11336)), and
in **1.30.1**, PostgreSQL startup is now gated on the instance manager
actually holding the primary `Lease` introduced in 1.30, closing a small
timing window during restarts
([#11356](https://github.com/cloudnative-pg/cloudnative-pg/pull/11356)).

Alongside that, both releases pick up a handful of smaller enhancements,
such as a configurable `auth_user` for the connection pooler and a
`--dry-run` option for `cnpg backup`, plus a number of correctness and
robustness fixes.
Full details, as always, are in the release notes linked below.

Both releases also bump `google.golang.org/grpc` to fix
[CVE-2026-84304](https://nvd.nist.gov/vuln/detail/CVE-2026-84304)
(GHSA-vp52-pcj8-j9qc), a heap-exhaustion issue in gRPC-Go's HTTP/2 frame
handling.

This kind of groundwork is also paving the way for 1.31.0, which will
further solidify failover and High Availability.

---

## Upgrade

Follow the [upgrade instructions](https://cloudnative-pg.io/docs/1.30/installation_upgrade/#upgrades)
for a smooth transition.

For the complete list of changes, see the release notes:

- [Release notes for 1.30.1](https://cloudnative-pg.io/docs/1.30/release_notes/v1.30/#version-1301)
- [Release notes for 1.29.3](https://cloudnative-pg.io/docs/1.29/release_notes/v1.29/#version-1293)

---

## Get involved with the community

[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

We're also actively working with the CNCF TOC toward CloudNativePG's
acceptance into Incubation. As part of that effort, we're pleased to share
that we've been evolving our governance model to better reflect the
project's community. You can read the current
[governance model](https://github.com/cloudnative-pg/governance/blob/main/GOVERNANCE.md)
to learn more, as well as our new [contributor ladder](https://github.com/cloudnative-pg/governance/blob/main/CONTRIBUTOR_LADDER.md).

If you're using CloudNativePG in production, consider
[adding your organization as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project's growth and evolution.

Thank you for your continued support!

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
