---
title: "CloudNativePG 1.28.0 Released!"
date: 2025-12-09
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
 - FailoverQuorum
 - FDW
 - ForeignData
 - maintenance
summary: CloudNativePG 1.28 is here! This stable release promotes Quorum-Based Failover and introduces Declarative Foreign Data Management for FDWs and foreign servers via the `Database` CRD. We also announce maintenance releases 1.27.2 and the final 1.26.3. Upgrade today for enhanced stability, security, and networking resilience.
---

The CloudNativePG Community is excited to announce the immediate availability
of **CloudNativePG 1.28.0**!

This minor release graduates a key high-availability feature to stable
and introduces powerful new capabilities for managing external data sources,
further cementing CloudNativePG as the leading operator for running PostgreSQL
workloads on Kubernetes.

We are also pleased to announce the release of maintenance versions **1.27.2**
and **1.26.3**, the latter of which is the final planned release in the 1.26.x
series. We encourage users on 1.26 to plan their upgrade to 1.27 or 1.28.

With the release of CloudNativePG 1.28.0, the End-of-Life (EOL) date for the
CloudNativePG 1.27.x series is confirmed as March 9, 2026.

---

## Highlights in 1.28.0

### Quorum-Based Failover Promoted to Stable

The quorum-based failover mechanism, introduced experimentally in 1.27, is now
a stable feature.

This data-driven approach enhances failover safety and data durability for
high-availability clusters by ensuring that a replacement primary is only
promoted when a majority of synchronous replicas are ready, preventing data
loss.

- **New Configuration:** This feature is now configured via the stable field:
  `spec.postgresql.synchronous.failoverQuorum`

### Declarative Foreign Data Management

CloudNativePG 1.28 introduces comprehensive declarative management for
Foreign Data Wrappers (FDW) and their corresponding foreign servers.

By extending the `Database` Custom Resource Definition (CRD) with `.spec.fdws`
and `.spec.servers` fields, users can now define external data connections
directly within their cluster manifest, treating them as first-class Kubernetes
objects.

- This work was contributed by Ying Zhu ([@EdwinaZhu](https://github.com/EdwinaZhu))
  as part of the LFX Mentorship Program.

---

## Enhanced Security and Resilience

This release includes significant improvements focused on stability, security,
and network resilience:

- **Granular Security Contexts:** Introduced fine-grained security contexts,
  allowing `securityContext` at the Pod level and `containerSecurityContext`
for individual containers (`postgres`, `init`, sidecars).
- **Custom PgBouncer TLS:** Allowed providing fine-grained custom TLS
  certificates for PgBouncer (client-to-pooler and pooler-to-server
  connections), overriding operator-generated certificates for better security
  control.
- **Faster Network Failure Detection:** Improved network resilience for
  replicas by setting the default `tcp_user_timeout` to 5 seconds. Replicas can
  now detect and recover from silent network drops much quicker than the previous
  default of 127 seconds.
- **Least-Privileged Reporting:** The `cnpg report operator` command now works
  with minimal, least-privileged access, gracefully handling permission errors
  and continuing to generate the report with available data.
- **TLS for Operator Metrics:** Added optional TLS support for the operator's
  metrics server (via `METRICS_CERT_DIR`).

## Other Notable Enhancements

- **Simultaneous Image and Config Changes:** The operator can now safely handle
  simultaneous updates to the container image (e.g., PostgreSQL version) and
  PostgreSQL configuration in a single operation.
- **Replica Auto-Recreation:** Introduced the
  `alpha.cnpg.io/unrecoverable=true` annotation to automatically delete and
  recreate an unrecoverable replica Pod and its PVCs.
- **Standard Kubernetes Labels:** Adopted standard Kubernetes recommended
  labels (e.g., `app.kubernetes.io/name`) for all generated resources,
  improving integration with ecosystem tools.
- **Improved Cluster Restore:** Enhanced cluster restore to wait for all init
  containers to complete, ensuring data is fully prepared before the restore
  process begins.

Dive into the full list of changes and fixes in the
[Release notes for CloudNativePG 1.28](https://cloudnative-pg.io/documentation/release_notes/v1.28/).

## Maintenance Releases: 1.27.2 & 1.26.3

In parallel with the 1.28 release, we have also shipped maintenance updates for
previous stable series:

- **CloudNativePG 1.27.2:** Includes various fixes and improvements backported
  from 1.28, such as resilience to transient Kubernetes API connectivity issues
  and improved PgBouncer image configuration.
- **CloudNativePG 1.26.3:** The final planned maintenance release for the
  1.26.x series. We strongly recommend planning an upgrade to a currently
  supported version.

We encourage all users to upgrade to the latest stable versions to benefit from
the latest features, security enhancements, and bug fixes.

Follow the [upgrade instructions](https://cloudnative-pg.io/documentation/1.28/installation_upgrade/#upgrades)
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
