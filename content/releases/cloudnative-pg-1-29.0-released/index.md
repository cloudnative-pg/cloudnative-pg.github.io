---
title: "CloudNativePG 1.29.0 Released!"
date: 2026-03-31
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
  - ImageCatalog
  - Extensions
  - Artifacts
  - maintenance
summary: CloudNativePG 1.29 is now generally available! This major update revolutionizes PostgreSQL extension management via Image Catalogs and the new artifacts ecosystem. We also announce maintenance releases 1.28.2 and the final 1.27.4. Upgrade today for enhanced security, dynamic networking, and enterprise IAM integration.
---

The CloudNativePG Community is excited to announce the immediate availability
of **CloudNativePG 1.29.0**!

This minor release introduces a paradigm shift in how PostgreSQL extensions
are managed on Kubernetes and brings powerful new capabilities for enterprise
identity and network security, further establishing CloudNativePG as the
standard for cloud-native PostgreSQL.

We are also pleased to announce the release of maintenance versions **1.28.2**
and **1.27.4**, the latter of which is the final planned release in the 1.27.x
series. We encourage users on 1.27 to plan their upgrade to 1.28 or 1.29.

With the release of CloudNativePG 1.29.0, the End-of-Life (EOL) date for the
**CloudNativePG 1.28.x** series is confirmed as **June 30, 2026**.

---

## Highlights in 1.29.0

### PostgreSQL Extensions Ecosystem and Image Catalogs

The headline feature of 1.29 is the integration of **Image Catalogs** with a
new, dedicated ecosystem for PostgreSQL extensions. By leveraging the
[postgres-extensions-containers](https://github.com/cloudnative-pg/artifacts/tree/main/image-catalogs-extensions)
project, CloudNativePG now provides a structured, automated way to distribute
and manage extension-specific images.

This approach ensures that the database engine and its modules are
version-aligned, secure, and treated as a single cohesive unit. It centralizes
the image supply chain, effectively removing the need for users to manually
build and maintain complex custom PostgreSQL images just to add required
functionality.

### Dynamic Network Access Control via Pod Selectors

We have introduced a major enhancement to PostgreSQL network security. Using
the new `podSelectorRefs` field, you can now define `pg_hba.conf` rules that
dynamically resolve the ephemeral IP addresses of client pods based on label
selectors. This ensures that only authorized workloads in the same namespace
can connect to the database, eliminating the friction of manual IP management
or static CIDR ranges.

### Shared ServiceAccount Support

CloudNativePG 1.29 now supports referencing a pre-existing `ServiceAccount` in
`Cluster` and `Pooler` resources. This enables a much smoother integration with
cloud provider IAM services. Platform engineers can now manage identity and
permissions once at the infrastructure level and share them across multiple
clusters. This work was contributed by Salih Bozkaya ([@bozkayasalihx](https://github.com/bozkayasalihx)).

---

## Notable Enhancements

- **Supply Chain Security & Artifact Signing:** We have significantly
  strengthened the project's security posture by **signing all release
  artifacts** and container images. This release also includes:

    - **SLSA Provenance:** Added Supply-chain Levels for Software Artifacts
      provenance to release binaries and images.
    - **SBOM Generation:** Enabled Software Bill of Materials (SBOM)
      generation within the GoReleaser pipeline for improved dependency transparency.
    - **OpenSSF Integration:** Integrated the OpenSSF baseline scanner and
      added a `SECURITY-INSIGHTS.yaml` file to the repository to align with
      industry-standard security reporting.

- **Advanced TLS for PgBouncer:** Added support for granular configuration of
  TLS cipher suites and minimum/maximum TLS versions for both client-to-pooler
  and pooler-to-server connections.
  Contributed by [@alex1989hu](https://github.com/alex1989hu).

Dive into the full list of changes and fixes in the
[Release notes for CloudNativePG 1.29](https://cloudnative-pg.io/documentation/1.29/release_notes/v1.29/).

## Maintenance Releases: 1.28.2 & 1.27.4

In parallel with the 1.29 release, we have also shipped maintenance updates
for previous stable series:

- **CloudNativePG 1.28.2:** Includes various fixes and improvements backported
  from 1.29, including improved resilience for volume resizes and stability
  fixes for the `cnpg` plugin.

- **CloudNativePG 1.27.4:** The final planned maintenance release for the
  1.27.x series. We strongly recommend planning an upgrade to 1.28 or 1.29.

We encourage all users to upgrade to the latest stable versions to benefit from
the latest features, security enhancements, and bug fixes.

Follow the [upgrade instructions](https://cloudnative-pg.io/docs/1.29/installation_upgrade#upgrading-to-1290-or-128x)
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
