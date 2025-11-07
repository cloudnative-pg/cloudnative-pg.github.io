---
title: "CloudNativePG 1.28.0 RC1 Released!"
date: 2025-11-07
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
 - FailoverQuorum
 - FDW
 - ForeignData
summary: "The CloudNativePG community is excited to announce the first release candidate of CloudNativePG 1.28! This preview promotes quorum-based failover to a stable feature and introduces declarative management for Foreign Data Wrappers. Join us in testing these updates to shape the final release."
---

The CloudNativePG Community is thrilled to announce the first release candidate
of CloudNativePG 1.28! This preview release provides an opportunity to explore
new features and enhancements before the final version is officially launched.
While refinements may still occur, here’s a look at what’s new.

## Key Features

### Quorum-Based Failover Promoted to Stable

The quorum-based failover feature, introduced experimentally in 1.27, has been
promoted to a stable API. This data-driven failover mechanism is now configured
via the `spec.postgresql.synchronous.failoverQuorum` field, graduating from the
previous `alpha.cnpg.io/failoverQuorum` annotation. This enhances
[failover safety and data durability](/documentation/preview/failover/#quorum-based-failover)
for high-availability clusters.

### Declarative Foreign Data Management

We introduced comprehensive declarative management for Foreign Data Wrappers
(FDW) by extending the `Database` CRD. This feature adds the `.spec.fdws`
and `.spec.servers` fields, allowing you to
[manage FDW extensions and foreign servers](/documentation/preview/declarative_database_management/#managing-foreign-data-wrappers-fdws-in-a-database)
directly from the `Database` resource.
This work was implemented by Ying Zhu ([@EdwinaZhu](https://github.com/EdwinaZhu))
as part of the [LFX Mentorship Program 2025 Term 2](https://mentorship.lfx.linuxfoundation.org/project/53fa853e-b5fa-4d68-be71-f005c75aea89).

## There’s More…

Explore other improvements in this release, including:

- Introduced granular control over [fine-grained security contexts](/documentation/preview/security/#customizing-security-contexts),
  allowing `securityContext` at the pod level and `containerSecurityContext`
  for individual containers.
- Allowed providing [custom TLS for PgBouncer](/documentation/preview/cloudnative-pg.v1/#postgresql-cnpg-io-v1-PgBouncerSpe)
  for both client-to-pooler and pooler-to-server connections,
  taking precedence over operator-generated certificates.
- Added optional [TLS support for the operator's metrics server](/documentation/preview/monitoring/#enabling-tls-for-operator-metrics),
  enabled via the `METRICS_CERT_DIR` environment variable.
- Enabled the `cnpg report operator` command to work with
  [minimal, least-privileged access](/documentation/preview/kubectl-plugin/#report),
  gracefully handling permission errors.
- Introduced the `alpha.cnpg.io/unrecoverable=true` annotation to
  [automatically delete and recreate a replica pod](/documentation/preview/labels_annotations/#predefined-annotations)
  and its PVCs.

Dive into the full details in the
[release notes for 1.28 RC1](https://cloudnative-pg.io/documentation/preview/release_notes/v1.28/).

## Testing

The stability of each CloudNativePG release relies on the community’s
engagement. Testing your workloads with this release candidate helps
identify bugs and regressions early.

- View the [open issues for the 1.28 release](https://github.com/cloudnative-pg/cloudnative-pg/milestone/30).
- Report bugs directly on [GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Release Timeline

CloudNativePG 1.28 RC1 is the first in a series of release candidates.
Additional release candidates may follow as needed before the final release,
currently planned for the second half of November.

# Join the Community

[Connect with our community on your preferred platform](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)!

Thank you for your continued support of CloudNativePG. Your contributions help 
us advance the Kubernetes-native PostgreSQL experience.
