---
title: "CloudNativePG 1.31.0 and 1.30.3 Released!"
date: 2026-12-03
draft: true
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
 - PostgreSQL19
 - high-availability
 - failover
 - OpenTelemetry
 - DatabaseRole
 - security
 - supplychain
summary: "CloudNativePG 1.31 is here! This stable release brings safer failover and switchover, native OpenTelemetry log export, improved declarative database and role support, in-place Pod resizing and PostgreSQL 19 support. We also announce the maintenance release 1.30.3. Upgrade today."
---

The CloudNativePG Community is excited to announce the immediate availability
of **CloudNativePG 1.31.0**!

This minor release brings safer failover and switchover, native OpenTelemetry
log export, improved declarative database and role support, in-place resource
resizing of instance Pods and support for PostgreSQL 19. It is also the first
minor release since CloudNativePG
[became a CNCF Incubating project](https://www.cncf.io/blog/2026/11/10/cloudnativepg-becomes-a-cncf-incubating-project/).

<!-- REFRESH these numbers from the final v1.31.0 tag and release notes before publishing. -->
This is one of the biggest releases in the history of the project. Since
1.30.0, **41 contributors** have landed **412 commits**, delivering
**8 new features**, **6 enhancements**, **3 security and supply chain
improvements** and **4 fixes**, along with **8 important changes** you should
read about before upgrading. Thank you to everyone who made this possible, and
to all those who tested the release candidate!

We are also releasing **CloudNativePG 1.30.3**, a maintenance update for the
1.30 series.

With the release of CloudNativePG 1.31.0, the CloudNativePG 1.30.x series
remains supported until about March 2027, and 1.31.x until about June 2027.
<!-- CONFIRM the exact End-of-Life dates (supported_releases.md only has "~ Mar 2027" and "~ Jun 2027"). -->

---

## Highlights in 1.31.0

### Safer failover and switchover

Building on the primary `Lease` introduced in 1.30, failover and switchover are
more reliable, more predictable and easier to follow:

- A partitioned primary no longer makes a failover wait longer than needed: the
  new primary counts the `leaseDurationSeconds` wait from the start of the
  failover, not from the end of the election.
- The time an isolated primary takes to stop now follows the
  [`.spec.primaryLease`](https://cloudnative-pg.io/docs/1.31/failover/#tuning-the-primary-lease)
  timings, like the time a replica waits before it promotes.
- A switchover now waits until the new primary has all the data that the
  previous primary published on the `Lease`, and `kubectl cnpg promote` detects
  a switchover in progress.

These improvements matter most for clusters that use asynchronous replication,
where a replica can lag behind the primary. In previous releases, a switchover
could promote a replica that was still missing data. In 1.31, we put data
consistency first: the promotion is held back until the replica has all the
data. You stay in control, with three clear options: wait, promote anyway by
removing the `cnpg.io/position` annotation from the `Lease` (the replica then
promotes without the data that only the previous primary has), or cancel the
switchover with `kubectl cnpg promote --force`. Failovers are not held back.

### Export logs via OpenTelemetry, without a DaemonSet

The operator, the instance manager and the PgBouncer instance manager can now
send their logs via OTLP (gRPC or HTTP, with TLS and headers) directly to an
OpenTelemetry collector, with no DaemonSet or sidecar required. It is enabled
with the standard `OTEL_*` environment variables, so each `Cluster` can even use
its own collector. PostgreSQL and PGAudit records are exported as structured
attributes, and the export never slows PostgreSQL down.

### Improved declarative database and role support

Declarative management of databases and roles takes a big step forward:

- **Generated passwords**: a `DatabaseRole` can now include a `password` stanza,
  so the operator generates and rotates the password, stored in a
  `kubernetes.io/basic-auth` `Secret`.
- **Database privileges**: the new `.spec.permissions` stanza of the `Database`
  resource grants and revokes `CONNECT`, `CREATE` and `TEMPORARY` on a database,
  with no SQL scripts after creation.
- **Schema privileges**: schemas in the `Database` resource accept a
  `permissions` field to grant and revoke `USAGE` and `CREATE`.
- **Per-role certificate lifetime**: `duration` and `renewBefore` in the
  `clientCertificate` stanza of a `DatabaseRole`.

### In-place resource resizing of instance Pods

With the new `.spec.resourcesUpdateStrategy: inPlace`, when the only difference
in a running Pod is its container resources, the operator resizes the Pod
through the `pods/resize` subresource: nothing restarts and no switchover is
needed. The Pod is recreated when the change cannot be applied in place. The
default is `recreate`, and `inPlace` requires Kubernetes 1.33 or later.

### Failure domain-aware synchronous replication

The new `podFailureDomainKeys` and `nodeFailureDomainKeys` options in
`.spec.postgresql.synchronous` restrict the choice of synchronous standbys to
instances in a different failure domain (such as an availability zone) from the
primary. The outage of a single zone can no longer stop the primary and all its
synchronous replicas at once.

### PostgreSQL 19

CloudNativePG 1.31 supports PostgreSQL 19. New clusters that don't specify an
image now default to `19.0-system-trixie`. Existing clusters keep their current
image.

---

## Other notable enhancements

- **`pg_basebackup` bootstrap improvements**: `additionalArgs` and
  `tablespaceMapping` to clone sources with a custom setup.
- **A webhook warning** when a cluster with more than one instance has no
  synchronous replication configured, to make the durability trade-off visible.
- **Editor and viewer RBAC roles** for automation and read-only DBA personas.
- **Cosign signatures** for each architecture-specific image manifest, in
  addition to the multi-architecture index.
- **`Pooler` hardening**: newlines and `NUL` bytes can no longer inject settings
  into `pgbouncer.ini` through `authQuery`, `auth_user` or parameter names.

This release also adds support for Kubernetes 1.37.

---

## Before you upgrade

Some defaults and behaviors change in 1.31, so please review these, and the
"Upgrading to 1.31.0" section of the
[installation and upgrade documentation](https://cloudnative-pg.io/docs/1.31/installation_upgrade/),
before upgrading:

- `CONNECT` is now revoked from `PUBLIC` on the databases created by the
  operator: `postgres`, `template1` and the application database of a cluster
  bootstrapped with `initdb`, and every database created from a `Database`
  resource. Existing databases are never changed. Monitoring keeps working, but
  any other role must own the database or be granted `CONNECT`. A `Pooler` with
  a custom authentication method needs `CONNECT` on `postgres` for the role that
  runs its `auth_query`, or `.spec.bootstrap.initdb.allowPublicConnectToPostgres: true`.
- `automountServiceAccountToken` is now disabled on instance Pods, which causes
  a one-time rolling update when upgrading.
- The default `smartShutdownTimeout` is now 0 seconds for new clusters. Existing
  clusters keep their current value.
- Instances are now bootstrapped by an init container instead of a Kubernetes
  `Job`. Update any tooling that watches the bootstrap Jobs.
- Online volume snapshot backups no longer include the dedicated WAL volume.
  Restoring them needs a working WAL archive.
- The instance status port now always uses TLS. This affects only Pods created
  by an operator older than 1.24.
- The legacy synchronous replication configuration (`minSyncReplicas`,
  `maxSyncReplicas` and `syncReplicaElectionConstraint`) is deprecated and will
  be removed in 1.33.0. Please migrate to `.spec.postgresql.synchronous`.
- The `observed` value of the `cnpg_collector_sync_replicas` metric now counts
  the standbys attached to the primary as synchronous, so it can be higher than
  `expected`. Alerts must use `observed < expected`, not `!=`.

> **Looking ahead:** CloudNativePG 1.31 is the last minor release that ships
> with native Barman Cloud support, which is removed starting from 1.32.0.
> Releases up to and including 1.31, and their patch releases, keep it for as
> long as they are supported. Please plan your migration to the
> [Barman Cloud Plugin](https://cloudnative-pg.io/plugin-barman-cloud/docs/migration/)
> before upgrading to 1.32 or later.

Dive into the full list of changes and fixes in the
[release notes for CloudNativePG 1.31](https://cloudnative-pg.io/docs/1.31/release_notes/v1.31/).

---

## Maintenance release: 1.30.3

In parallel with 1.31.0, we have also shipped **CloudNativePG 1.30.3** for the
current stable series. It backports fixes and improvements from 1.31, including
PostgreSQL 19 support, the Cosign signing of each architecture-specific image
manifest, the hardening of the `Pooler` configuration, and several bug fixes.
<!-- VERIFY this list against the 1.30.3 section of the 1.30 release notes (inferred from the backport markers in the 1.31 notes). -->

See the
[release notes for 1.30](https://cloudnative-pg.io/docs/1.30/release_notes/v1.30/#version-1303)
for the complete list.

We encourage all users to upgrade to the latest versions to benefit from the
latest features, security enhancements and bug fixes. Follow the
[upgrade instructions](https://cloudnative-pg.io/docs/1.31/installation_upgrade/#upgrades)
for a smooth transition.

---

## Get involved with the community

[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

CloudNativePG is a **CNCF Incubating project**. Read the
[CNCF announcement](https://www.cncf.io/blog/2026/11/10/cloudnativepg-becomes-a-cncf-incubating-project/)
to learn more.

If you're using CloudNativePG in production, consider
[adding your organization as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project.

We'd also like to thank everyone who contributed a pull request to this
release, in particular [@GellertBabel](https://github.com/GellertBabel),
[@BRGOVIND](https://github.com/BRGOVIND) and
[@Vince-Chenal](https://github.com/Vince-Chenal).
<!-- ADD the other community contributors from the final release notes. -->

Thank you for your continued support! Upgrade today and discover how
CloudNativePG can elevate your PostgreSQL experience.

<!-- uncomment this section for postgresql.org announcement.
## About CloudNativePG

[CloudNativePG](https://cloudnative-pg.io) is an open-source Kubernetes
Operator specifically designed for PostgreSQL workloads. It manages the entire
lifecycle of a PostgreSQL cluster, including bootstrapping, configuration, high
availability, connection routing, and comprehensive backup and disaster
recovery mechanisms. By leveraging PostgreSQL's native streaming replication,
CloudNativePG efficiently distributes data across pods, nodes, and zones using
standard Kubernetes patterns, enabling seamless scaling of replicas in a
Kubernetes-native manner. Originally developed and supported by
[EDB](https://www.enterprisedb.com/), CloudNativePG is a CNCF Incubating
project.
-->
