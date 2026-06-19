---
title: "CloudNativePG 1.30.0 RC1 Released!"
date: 2026-06-19
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
 - DatabaseRole
 - primaryLease
 - high-availability
 - security
 - GitOps
 - PgBouncer
 - ImageCatalogs
summary: "The CloudNativePG community is excited to announce the first release candidate of CloudNativePG 1.30! This preview introduces the DatabaseRole CRD for declarative, GitOps-friendly role management and a Lease-based primary election primitive for safer failover. Join us in testing these updates to shape the final release."
---

The CloudNativePG Community is thrilled to announce the first release candidate
of CloudNativePG 1.30! This preview release provides an opportunity to explore
new features and enhancements before the final version is officially launched.
While refinements may still occur, here's a look at what's new.

## Key Features

### DatabaseRole CRD for declarative role management

The headline addition in 1.30 is the new
[`DatabaseRole`](https://cloudnative-pg.io/docs/1.30/declarative_role_management/#the-databaserole-resource)
custom resource, which manages a PostgreSQL role as a standalone Kubernetes
object rather than inline in the `Cluster`'s `.spec.managed.roles` stanza. Each
role now has its own lifecycle, status and RBAC, which suits GitOps workflows
and lets role definitions live next to the applications that own them. Migrating
an existing role is simply a matter of moving its stanza into a dedicated
manifest.

A `DatabaseRole` can also include a `clientCertificate` block, having the
operator automatically generate and renew a TLS client certificate signed by
the cluster's client CA and stored in a `<databaserole-name>-client-cert`
Secret. This enables password-free PostgreSQL `cert` authentication, with the
Secret cleaned up automatically when the feature is disabled or the resource is
deleted.

### Primary Lease for safe primary election

CloudNativePG 1.30 introduces a Kubernetes `Lease` object, named after the
cluster, that acts as a mutex serializing primary promotion. The instance
manager must hold the lease before acting as primary and releases it on clean
shutdown, so replicas can promote without waiting for the full TTL. Timings are
configurable through the new
[`.spec.primaryLease`](https://cloudnative-pg.io/docs/1.30/failover/#tuning-the-primary-lease)
stanza.

To be precise about the architecture: the lease is a promotion gate, not a
fence. Primary isolation remains responsible for fencing — the Lease simply
closes the window for an uncoordinated promotion during transitions.

## There's More…

Explore other improvements in this release, including:

- **In-place major upgrades with Image Volume extensions** — `pg_upgrade`
  in-place upgrades are now supported for clusters using Image Volume
  extensions, mounting the source- and target-version extension images side by
  side so a failed upgrade reverts cleanly.
- **PgBouncer image management via Image Catalogs** — the `Pooler` can now
  reference an `ImageCatalog` or `ClusterImageCatalog` entry through
  `spec.pgbouncer.imageCatalogRef`, with referencing `Poolers` automatically
  reconciled and rolled out when a catalog entry changes.
- **TLS for the Pooler metrics endpoint** via `.spec.monitoring.tls.enabled`,
  with hot certificate reloading on every handshake.
- **Cluster as a VPA/HPA target** through a new `status.selector` on the scale
  subresource, mapping a `Cluster` to its instance pods.

This release also adds support for Kubernetes 1.36 and updates the default
PostgreSQL version to 18.4.

> **Heads-up on an API change:** the `cluster` reference is now immutable on the
> `Database`, `Pooler`, `Publication`, `Subscription` and `ScheduledBackup`
> resources. Re-pointing one of these at a different cluster is now rejected by a
> CEL validation rule at the API server, as it had no well-defined semantics.

Dive into the full details in the
[release notes for 1.30 RC1](https://cloudnative-pg.io/docs/1.30/release_notes/v1.30/).

## Testing

The stability of each CloudNativePG release relies on the community's
engagement. Testing your workloads with this release candidate helps identify
bugs and regressions early.

- View the [open issues for the 1.30 release](https://github.com/cloudnative-pg/cloudnative-pg/milestones).
- Report bugs directly on [GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Release Timeline

This is the first release candidate for CloudNativePG 1.30. Further candidates
will be released only as necessary before the final launch, currently planned
before the end of June.

## Join the Community

[Connect with our community on your preferred platform](https://github.com/cloudnative-pg#getting-in-touch)!

Thank you for your continued support of CloudNativePG. Your contributions help
us advance the Kubernetes-native PostgreSQL experience.
