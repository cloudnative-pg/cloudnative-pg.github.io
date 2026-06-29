---
title: "CloudNativePG 1.30.0 Released!"
date: 2026-06-29
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
 - DatabaseRole
 - primaryLease
 - high-availability
 - failover
 - security
 - RBAC
 - supplychain
 - GitOps
 - PgBouncer
 - ImageCatalogs
summary: "CloudNativePG 1.30 is here! This stable release introduces the DatabaseRole CRD for declarative, GitOps-friendly role management and a Lease-based primary election primitive for safer failover. We also announce maintenance releases 1.29.2 and the final 1.28.4. Upgrade today for enhanced stability, security, and high availability."
---

The CloudNativePG Community is excited to announce the immediate availability
of **CloudNativePG 1.30.0**!

This minor release introduces the new `DatabaseRole` CRD for declarative,
GitOps-friendly PostgreSQL role management and a Lease-based primary election
primitive for safer failover, alongside notable security and operational
improvements, further cementing CloudNativePG as the leading operator for
running PostgreSQL workloads on Kubernetes.

We are also pleased to announce the release of maintenance versions **1.29.2**
and **1.28.4**, the latter of which is the final planned release in the 1.28.x
series. We encourage users on 1.28 to plan their upgrade to 1.29 or 1.30.

With the release of CloudNativePG 1.30.0, the CloudNativePG 1.28.x series
reaches its End-of-Life (EOL) date of June 30, 2026, and the EOL date for the
CloudNativePG 1.29.x series is confirmed as September 29, 2026.

---

## Highlights in 1.30.0

### DatabaseRole CRD for declarative role management

The headline addition in 1.30 is the new
[`DatabaseRole`](https://cloudnative-pg.io/docs/1.30/declarative_role_management/#the-databaserole-resource)
custom resource, which manages a PostgreSQL role as a standalone Kubernetes
object rather than inline in the `Cluster`'s `.spec.managed.roles` stanza. Each
role now has its own lifecycle, status and RBAC, which suits GitOps workflows
and lets role definitions live next to the applications that own them. Migrating
an existing role is a matter of moving its stanza into a dedicated
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
fence. Primary isolation remains responsible for fencing — the Lease closes
the window for an uncoordinated promotion during transitions.

---

## Enhanced Security and Resilience

This release includes significant improvements focused on stability, security,
and supply-chain integrity:

- **`search_path` pinning ([CVE-2026-55769](https://github.com/cloudnative-pg/cloudnative-pg/security/advisories/GHSA-x8c2-3p4r-v9r6)):**
  Fixed a privilege-escalation vulnerability (CWE-426) where a database owner
  could plant overloaded operators in the `public` schema. The operator now
  pins `search_path = pg_catalog, public, pg_temp` on its pooled connections.
- **SCRAM-SHA-256 password encoding ([CVE-2026-55765](https://github.com/cloudnative-pg/cloudnative-pg/security/advisories/GHSA-w3gf-xc94-wvmj)):**
  The operator now SCRAM-SHA-256 encodes cleartext passwords before issuing
  `CREATE`/`ALTER ROLE` commands, so the SCRAM verifier — rather than the
  cleartext secret — is what could ever appear in logs or extension captures.
- **Authenticated instance communication ([GHSA-7qwx-x8ff-3px9](https://github.com/cloudnative-pg/cloudnative-pg/security/advisories/GHSA-7qwx-x8ff-3px9)):**
  Operator-to-instance-manager communication is now authenticated via ECDSA
  certificates. This hardening is new in 1.30.0 and is not backported; on
  earlier releases continue to restrict the instance status port with a
  `NetworkPolicy`.

## Other Notable Enhancements

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
- **Primary status visibility** — the operator now emits a
  `PrimaryStatusCheckFailed` warning event when a primary pod looks Ready to the
  kubelet but fails the operator's `/pg/status` check, surfacing failover
  deferrals via `kubectl describe cluster`.

This release also adds support for Kubernetes 1.36 and updates the default
PostgreSQL version to 18.4.

> **Heads-up on an API change:** the `cluster` reference is now immutable on the
> `Database`, `Pooler`, `Publication`, `Subscription` and `ScheduledBackup`
> resources. Re-pointing one of these at a different cluster is now rejected by a
> CEL validation rule at the API server, as it had no well-defined semantics.

Dive into the full list of changes and fixes in the
[release notes for CloudNativePG 1.30](https://cloudnative-pg.io/docs/1.30/release_notes/v1.30/).

## Maintenance Releases: 1.29.2 & 1.28.4

In parallel with the 1.30 release, we have also shipped maintenance updates for
the previous stable series. Both backport the security fixes above — including
`search_path` pinning and SCRAM-SHA-256 password encoding — along with VPA/HPA
support, primary status visibility, automatic CNPG-I plugin reloading, Kubernetes
1.36 support, the updated PostgreSQL 18.4 default, and dozens of bug fixes:

- **CloudNativePG 1.29.2:** see the
  [release notes for 1.29](https://cloudnative-pg.io/docs/1.29/release_notes/v1.29/#version-1292).
- **CloudNativePG 1.28.4:** the final planned maintenance release for the
  1.28.x series — see the
  [release notes for 1.28](https://cloudnative-pg.io/docs/1.28/release_notes/v1.28/#version-1284).
  We strongly recommend planning an upgrade to a currently supported version.

We encourage all users to upgrade to the latest stable versions to benefit from
the latest features, security enhancements, and bug fixes.

Follow the [upgrade instructions](https://cloudnative-pg.io/docs/1.30/installation_upgrade/#upgrades)
for a smooth transition.

---

## Get Involved with the Community

[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

If you're using CloudNativePG in production, consider
[adding your organization as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project's growth and evolution.

Thank you for your continued support! Upgrade today and discover how
CloudNativePG can elevate your PostgreSQL experience to new heights.

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
[EDB](https://www.enterprisedb.com/), CloudNativePG is a CNCF Sandbox project
and the sole PostgreSQL operator in this category.
-->
