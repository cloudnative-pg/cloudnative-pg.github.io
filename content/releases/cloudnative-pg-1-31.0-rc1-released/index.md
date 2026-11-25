---
title: "CloudNativePG 1.31.0 RC1 Released!"
date: 2026-11-25
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
 - preview
 - cnpg
 - PostgreSQL19
 - high-availability
 - failover
 - OpenTelemetry
 - security
 - DatabaseRole
summary: "We are thrilled to announce the first release candidate of CloudNativePG 1.31! This preview brings safer failover and switchover, native OpenTelemetry log export, improved declarative database and role support, and PostgreSQL 19 support. With so much new, we need your help testing it!"
---

We are thrilled to announce the first release candidate of CloudNativePG 1.31!
This preview gives you the chance to try out new features and improvements
before the final version is released. Refinements may still happen, but here is
what we are so excited about.

<!--
Kept for the 1.31.0 launch announcement (refresh the numbers first):

CloudNativePG 1.31 is our biggest release yet by number of commits. Since
1.30.0, **39 contributors** have landed **407 commits**, delivering
**8 new features**, **6 enhancements**, **2 security and supply chain
improvements** and **3 fixes**, along with **8 important changes** you should
read about before upgrading. Thank you to everyone who made this possible!
-->

## Key Features

### Safer failover and switchover

Building on the primary `Lease` introduced in 1.30, failover and switchover are
now more reliable, more predictable and easier to follow. A replica that
diverged from the timeline of the primary is detected, excluded from the read
services, the election and the failover quorum, and fenced until you rebuild
it. A switchover now waits until the new primary has all the data that the
previous primary published on the `Lease`. You can still promote without
waiting, or cancel the switchover. This is especially valuable with
asynchronous replication.

### Export logs via OpenTelemetry, without a DaemonSet

The operator, the instance manager and the PgBouncer instance manager can now
send their logs via OTLP directly to an OpenTelemetry collector, with no
DaemonSet required. It is enabled with the standard `OTEL_*` environment
variables, so each `Cluster` can even use its own collector.

### Improved declarative database and role support

Declarative management of databases and roles takes a big step forward. A
`DatabaseRole` can now have its password generated and rotated automatically,
and the `Database` resource can declaratively grant and revoke privileges on
databases (`CONNECT`, `CREATE`, `TEMPORARY`) and on schemas (`USAGE`, `CREATE`).
The databases that the operator creates also no longer accept connections from
every role (see "Important changes" below).

## There's More…

Explore other improvements in this release, including:

- **PostgreSQL 19 support**: new clusters that don't specify an image now
  default to `19.0-system-trixie`. Existing clusters keep their image.
- **In-place resource resizing of instance Pods**, with no restart, through the
  new `.spec.resourcesUpdateStrategy` field (Kubernetes 1.33 or later).
- **Failure domain-aware synchronous replication**, so that the outage of a
  single zone cannot stop the primary and all its synchronous replicas at once.
- **`pg_basebackup` bootstrap improvements**: `additionalArgs` and
  `tablespaceMapping`.
- **Per-role client certificate lifetime**: `duration` and `renewBefore` in
  the `clientCertificate` stanza of a `DatabaseRole`.
- **A webhook warning** when a cluster with more than one instance has no
  synchronous replication configured.
- **Editor and viewer RBAC roles** for automation and read-only DBA personas.
- **Cosign signatures** for each architecture-specific image manifest.
- Support for **Kubernetes 1.37**.

## Important changes

Some defaults and behaviors change in 1.31, so please review these before
testing:

- `CONNECT` is now revoked from `PUBLIC` on the databases created by the
  operator: `postgres`, `template1` and the application database of a cluster
  bootstrapped with `initdb`, and every database created from a `Database`
  resource. A cluster bootstrapped with `recovery` or `pg_basebackup` changes
  only if the operator creates the application database. Existing databases
  are never changed. Monitoring keeps working, but any other role must own the
  database or be granted `CONNECT`. A `Pooler` with a custom authentication
  method needs `CONNECT` on `postgres` for the role that runs its `auth_query`,
  or `.spec.bootstrap.initdb.allowPublicConnectToPostgres: true`.
- `automountServiceAccountToken` is now disabled on instance Pods, which causes
  a one-time rolling update when upgrading.
- The default `smartShutdownTimeout` is now 0 seconds for new clusters.
  Existing clusters keep their current value.
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

Dive into the full details in the
[release notes for 1.31 RC1](https://cloudnative-pg.io/docs/1.31/release_notes/v1.31/),
and follow the
[installation and upgrade instructions](https://cloudnative-pg.io/docs/1.31/installation_upgrade/)
to try it out.

## Please help us test!

A release with this many changes and improvements, touching failover,
bootstrap, security defaults and more, depends on the community to get it right.
Your testing makes the difference: trying this release candidate with your own
workloads, in a non-production environment, is the best way to catch bugs and
regressions before the final release.

We especially encourage you to try:

- switchover and failover scenarios, particularly with asynchronous replication;
- upgrades of existing clusters, including the important changes listed above;
- new clusters and recoveries, given the new init container bootstrap;
- the new features that fit your environment.

How to help:

- View the [open issues for the 1.31 release](https://github.com/cloudnative-pg/cloudnative-pg/milestones).
- Report bugs directly on [GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Release Timeline

This is the first release candidate for CloudNativePG 1.31. Further candidates
will be released only as necessary before the final launch.

## Join the Community

[Connect with our community on your preferred platform](https://github.com/cloudnative-pg#getting-in-touch)!

Thank you for your continued support of CloudNativePG. Your contributions help
us advance the Kubernetes-native PostgreSQL experience.

<!--
Longer text kept for the 1.31.0 launch announcement:

### Safer failover and switchover with the primary Lease

- When a partitioned primary keeps the WAL receivers waiting, the failover
  takes less time: the new primary counts the `leaseDurationSeconds` wait from
  the start of the failover, not from the end of the election.
- The time an isolated primary takes to stop now depends on the
  `.spec.primaryLease` timings, like the time a replica waits before it
  promotes.
- A replica that has diverged from the timeline of the primary is detected,
  excluded from the read services, the election and the failover quorum,
  reported in the new `divergedInstances` status field, and fenced. Rebuild it
  with `kubectl cnpg destroy`. Replica clusters do not report or fence diverged
  instances.
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
switchover with `kubectl cnpg promote --force`. Failovers, and cases where the
position is unknown, are not held back.

### In-place resource resizing of instance Pods

With `.spec.resourcesUpdateStrategy: inPlace`, when the only difference in a
running Pod is its container resources, the operator resizes the Pod through the
`pods/resize` subresource: nothing restarts and no switchover is needed. The Pod
is recreated when the change cannot be applied in place. The default is
`recreate`, and `inPlace` requires Kubernetes 1.33 or later.

### Failure domain-aware synchronous replication

`podFailureDomainKeys` and `nodeFailureDomainKeys` in
`.spec.postgresql.synchronous` restrict the choice of synchronous standbys to
instances in a different failure domain (such as an availability zone) from the
primary. The two options are mutually exclusive. The constraint applies only
when it can be fully satisfied, otherwise the operator uses the regular
selection.
-->
