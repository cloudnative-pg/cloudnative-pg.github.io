---
title: "CloudNativePG 1.27.1, 1.26.2 and 1.25.4 released!"
date: 2025-10-23
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
summary: The CloudNativePG community has released new updates for the 1.27, 1.26 and 1.25 versions of the CloudNativePG operator.
---

The **CloudNativePG Community** is pleased to announce the release of
**CloudNativePG Operator** versions 1.27.1, 1.26.2, and 1.25.4.

Version 1.25.4 is the final patch release for the 1.25.x series, which is now
unsupported.

These maintenance releases deliver important bug fixes and stability
improvements, ensuring your PostgreSQL clusters continue to run reliably in
production environments.

While the patch releases focus on stability, the 1.27.1 release introduces
a few key changes:

- **PostgreSQL 18 Support:** Support for **PostgreSQL 18** has been introduced,
  and the default version is now `18.0-system-trixie`. This update also adopts
  the new format for `postgres-containers`, `postgis-containers`, and
  `pgbouncer-containers` images.
- **Barman Cloud Support:** The decommissioning of native in-core support for
  Barman Cloud has been delayed until at least version 1.29.
- **Monitoring Deprecation:** The `monitoring.enablePodMonitor` field in the
  `Cluster` and `Pooler` resources has been deprecated. If you rely on
  `PodMonitor` resources, you should start planning to create them manually, as
  this field will be removed in a future release.
  
We encourage all users to upgrade to benefit from these enhancements.

Read the full release notes for details:

- [Release notes for 1.27.1](https://cloudnative-pg.io/documentation/1.27/release_notes/v1.27/)
- [Release notes for 1.26.2](https://cloudnative-pg.io/documentation/1.26/release_notes/v1.26/)
- [Release notes for 1.25.4](https://cloudnative-pg.io/documentation/1.25/release_notes/v1.25/)

---

## Upgrade guidance

We recommend upgrading to **1.27.1** to benefit from the latest features,
enhancements, and long-term stability.

If you’re on **1.26.x**, upgrade to **1.26.2** to get the latest fixes in that
series. Users on the 1.25.x series should plan an upgrade to a supported
version.

Follow the [upgrade instructions](https://cloudnative-pg.io/documentation/1.27/installation_upgrade/#upgrades)
for a smooth transition.

---

## Get involved with the community

[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

If you're using CloudNativePG in production, consider
[adding your organisation as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project's growth and evolution.

Thank you for your continued support and for being part of the CloudNativePG community!

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
<!--

We've just released CloudNativePG 1.27.1, 1.26.2, and 1.25.4! 🚀

These maintenance releases deliver important stability improvements and bug
fixes to keep your production clusters running smoothly.

Key highlights in 1.27.1 include:
- Support for **PostgreSQL 18**
- Native in-core support for Barman Cloud extended
- The `monitoring.enablePodMonitor` field is now deprecated

We recommend upgrading to 1.27.1 for the latest features and long-term
stability.

Note: 1.25.4 is the final release for the unsupported 1.25.x series.

Read the full announcement: https://cloudnative-pg.io/releases/cloudnative-pg-1-27.1-released/

#CloudNativePG #PostgreSQL #Kubernetes #K8s #DevOps #Database #Operator

--->
