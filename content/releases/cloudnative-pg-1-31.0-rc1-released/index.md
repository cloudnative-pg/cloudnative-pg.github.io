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
1.30.0, **39 contributors** have landed **395 commits**, delivering
**8 new features**, **7 enhancements**, **2 security and supply chain
improvements** and **6 fixes**, along with **7 important changes** you should
read about before upgrading. Thank you to everyone who made this possible!
-->

## Key Features

### Safer failover and switchover

Building on the primary `Lease` introduced in 1.30, failover and switchover are
now faster, more predictable and easier to observe. Failovers no longer wait for
the lease duration on top of the election, replicas that diverged from the
primary's timeline are detected and fenced, and a switchover now waits for the
candidate replica to have all the data of the previous primary, with clear
options if you want to override it. This is especially valuable with
asynchronous replication.

### Export logs via OpenTelemetry, without a DaemonSet

The operator, the instance manager and the PgBouncer instance manager can now
push their logs via OTLP straight to an OpenTelemetry collector, with no
DaemonSet or sidecar required. It is enabled with the standard `OTEL_*`
environment variables, so each `Cluster` can even use its own collector.

### Improved declarative database and role support

Declarative management of databases and roles takes a big step forward. A
`DatabaseRole` can now have its password generated and rotated automatically,
and the `Database` resource can declaratively grant and revoke privileges on
databases (`CONNECT`, `CREATE`, `TEMPORARY`) and on schemas (`USAGE`, `CREATE`).
New databases are also closed by default, with `CONNECT` revoked from `PUBLIC`.

## There's More…

Explore other improvements in this release, including:

- **PostgreSQL 19 support**: new clusters that don't specify an image now
  default to `19.0-system-trixie`.
- **In-place resource resizing of instance Pods**, with no restart, through the
  new `spec.resourcesUpdateStrategy` field (Kubernetes 1.33 or later).
- **Failure domain-aware synchronous replication**, so that a single-zone
  outage cannot take out the primary and all its synchronous replicas.
- **`pg_basebackup` bootstrap improvements**: `additionalArgs` and
  `tablespaceMapping`.
- **Editor and viewer RBAC roles** for automation and read-only DBA personas.
- **Cosign signatures** for each architecture-specific image manifest.
- Support for **Kubernetes 1.37**.

## Important changes

Some defaults and behaviors change in 1.31, so please review these before
testing:

- `CONNECT` is now revoked from `PUBLIC` on the databases created by the
  operator. Existing databases are never changed.
- `automountServiceAccountToken` is now disabled on instance Pods, which causes
  a one-time rolling update when upgrading.
- The default `smartShutdownTimeout` is now 0 seconds for new clusters.
  Existing clusters keep their current value.
- Instances are now bootstrapped by an init container instead of a Kubernetes
  `Job`.
- Online volume snapshot backups no longer include the WAL volume.
- The instance status port now always uses TLS.
- The legacy synchronous replication configuration (`minSyncReplicas`,
  `maxSyncReplicas` and `syncReplicaElectionConstraint`) is deprecated and will
  be removed in 1.33.0. Please migrate to `.spec.postgresql.synchronous`.

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

- A failover no longer waits for the lease duration on top of the election, and
  an isolated primary now reacts on the same timescale as a replica waiting to
  promote.
- A replica that has diverged from the primary's timeline is detected, kept out
  of the read services and of the failover quorum, reported in the new
  `divergedInstances` status field, and fenced.
- A switchover now waits until the candidate replica has all the data published
  by the previous primary on its lease, and `kubectl cnpg promote` is aware of a
  switchover in progress.

These improvements matter most for clusters that use asynchronous replication,
where a replica can lag behind the primary. In previous releases, a switchover
promoted the candidate immediately, even while it was still catching up, giving
priority to self-healing. In 1.31, we put data consistency first: the promotion
is held back until the candidate is ready. You stay in control, with three
clear options: wait, promote anyway by removing the `cnpg.io/position`
annotation from the lease, or cancel the switchover with
`kubectl cnpg promote --force`. Failovers are not held back.

### In-place resource resizing of instance Pods

With `spec.resourcesUpdateStrategy: inPlace`, when the only difference in a
running Pod is its container resources, the operator resizes the Pod through the
`pods/resize` subresource: nothing restarts and no switchover is needed.

### Failure domain-aware synchronous replication

`podFailureDomainKeys` and `nodeFailureDomainKeys` in
`.spec.postgresql.synchronous` restrict the choice of synchronous standbys to
instances in a different failure domain (such as an availability zone) from the
primary.
-->
