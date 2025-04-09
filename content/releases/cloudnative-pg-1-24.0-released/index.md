---
title: "CloudNativePG 1.24.0 and 1.23.4 Released!"
date: 2024-08-22
draft: false
author: gbartolini
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
summary: The CloudNativePG community has released the new 1.24 minor version and a new update for the supported 1.23 version of the CloudNativePG operator.
---


The **CloudNativePG Community** is excited to announce the release of
**CloudNativePG Operator** versions 1.24.0 and 1.23.4!

## CloudNativePG 1.24.0: What’s New?

This major update introduces powerful new features and enhancements, including:

- **Distributed PostgreSQL Topologies**: Create distributed database topologies
  across multiple Kubernetes clusters, enabling hybrid and multi-cloud
  deployments. Enjoy declarative primary control and seamless switchover between
  clusters, ensuring high availability and resilience.
- **Managed Services**: The new `managed.services` stanza allows for advanced
  service management, including the ability to disable read-only and read
  services via configuration, and the use of service templates to create custom
  service resources, such as load balancers, for accessing PostgreSQL outside
  Kubernetes—ideal for DBaaS scenarios.
- **Enhanced Synchronous Replication API**: Gain full control over PostgreSQL’s
  synchronous replication configuration with a more flexible API, supporting
  both quorum-based and priority list strategies. Customize the
  `synchronous_standby_names` option to suit your needs.
- **WAL Disk Space Exhaustion Safeguard**: A critical safety measure ensures
  that if disk space for WAL files is exhausted, the cluster will safely stop
  rather than triggering a chain of failovers. This prevents the cluster from
  entering an unrecoverable state and simplifies recovery by allowing for manual
  volume expansion.

For a detailed overview of these features and other changes, check out the
[release notes](https://cloudnative-pg.io/documentation/1.24/release_notes/v1.24/).

---

### Additional Enhancements in 1.24.0

Explore more improvements in CloudNativePG 1.24, including:

- Declarative delayed replicas
- Transparent support for PostgreSQL 17’s `allow_alter_system`
- `postInitSQLRefs` and `postInitTemplateSQLRefs`
- Observability enhancements

Check the full list of changes in the
[release notes](https://cloudnative-pg.io/documentation/1.24/release_notes/v1.24/).

---

## Upgrade and Maintenance

Before upgrading, please carefully review the
[detailed upgrade instructions](https://cloudnative-pg.io/documentation/1.24/installation_upgrade/#upgrading-to-1240-or-1234).

We strongly recommend upgrading to CloudNativePG 1.24.0 at your earliest
convenience. If you prefer to stay on version 1.23, be sure to update to 1.23.4
for continued stability and support. Note that version 1.23 will be supported
until November 22nd, 2024.

---

## Join the Community

Join our vibrant, open-source, vendor-neutral community! [Connect with us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)!

Stay informed about the latest developments by following us on
[Twitter](https://twitter.com/CloudNativePg).

Thank you for your continued support and engagement with CloudNativePG. Upgrade
today and unlock the full potential of your PostgreSQL deployments!

<!--
## About CloudNativePG

[CloudNativePG](https://cloudnative-pg.io) stands as a groundbreaking
open-source Kubernetes Operator designed explicitly for PostgreSQL workloads.
Seamlessly orchestrating the entire life cycle of a PostgreSQL cluster,
CloudNativePG takes charge from bootstrapping and configuration to ensuring
high availability, connection routing, and comprehensive backup and disaster
recovery mechanisms.
Leveraging PostgreSQL's native streaming replication, CloudNativePG efficiently
distributes data across pods, nodes, and zones, utilizing standard Kubernetes
patterns. This enables seamless scaling of replicas in a Kubernetes-native
manner, with the operator autonomously and safely reconfiguring replication as
needed.
Originally conceived and supported by [EDB](https://www.enterprisedb.com/),
CloudNativePG represents a paradigm shift in managing PostgreSQL workloads
within Kubernetes environments.

-->
<!--
Tweet
🚀 Exciting news! CloudNativePG 1.24.0 is here! New features include distributed PostgreSQL topologies, managed services, enhanced API for synchronous replication, and WAL disk space safeguards.

LINK

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource

--->
<!--
LinkedIn
🚀 **Exciting News! CloudNativePG 1.24.0 and 1.23.4 Released!** 🚀

The CloudNativePG Community is thrilled to announce the release of CloudNativePG 1.24.0! This release introduces powerful new features, including:

🔹 **Distributed PostgreSQL Topologies** for hybrid and multi-cloud deployments
🔹 **Managed Services** for custom service resources and DBaaS
🔹 **Enhanced API for Synchronous Replication**
🔹 **WAL Disk Space Exhaustion Safeguards**

LINK

Join our vibrant community, share your insights, and stay updated on the latest developments by following us and joining our Slack channel.

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource #ReleaseCandidate
-->
