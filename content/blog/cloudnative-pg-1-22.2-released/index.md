---
title: "CloudNativePG 1.22.2 and 1.21.4 Released!"
date: 2024-03-14T16:40:27+01:00
draft: false
image:
    url: wildlife-zoo-mammal-fauna-elephant-sri-lanka-988769-pxhere.com.jpg
    attribution: from <strong><a href="https://pxhere.com/en/photo/988769?utm_content=clipUser&utm_medium=referral&utm_source=pxhere">PxHere</a></strong>
author: gbartolini
tags:
 - release
 - postgresql
 - postgres
 - kubernetes
 - k8s
 - cloudnativepg
summary: The CloudNativePG community has released a new update for the supported 1.22 and 1.21 versions of the CloudNativePG operator.
---

The **CloudNativePG Community** is thrilled to unveil the latest update for the
**CloudNativePG Operator**, now available for the supported versions 1.22 and
1.21.

Key enhancements in both supported minor releases are:

- flexibility to configure the `wal_level` GUC in PostgreSQL and disable WAL
  archiving via an annotation, granting you finer control over your PostgreSQL
  environment
  
- configurable duration of TLS certificates managed by the operator
  
- introduction of the `publication` and `subscription` command groups in the
  `cnpg` plugin for `kubectl`, facilitating seamless management of PostgreSQL
  native logical replication. This unlocks new possibilities for imperative major
  online upgrades and online imports, enriching your data management strategies.

**Versions 1.22.2 and 1.21.4** are *patch releases* that include
essential bug fixes, addressing issues such as:

- proper synchronization of PVC group labels to match those on the pods
- check for volume snapshots to be ready before initiating recovery procedures,
  ensuring smoother operations and data integrity

In adherence to Kubernetes best practices, we are transitioning from
client-side to server-side application of manifests starting from this release.
As a result, the `--server-side` option is now the preferred choice when
installing the operator.

We highly recommend updating the operator at your earliest convenience to
leverage these enhancements and bug fixes, ensuring a seamless and efficient
PostgreSQL experience.

Please refer to the following release notes for comprehensive insights into
each version:

- [release notes for 1.22.2](https://cloudnative-pg.io/documentation/1.22/release_notes/v1.22/)
- [release notes for 1.21.4](https://cloudnative-pg.io/documentation/1.21/release_notes/v1.21/)

We extend our gratitude for your continued support, and we are excited to
witness your enhanced experience with the updated CloudNativePG Operator.
Thank You.

<!--
# About CloudNativePg

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
Originally conceived and supported by
[EDB](https://www.enterprisedb.com/products/cloud-native-postgresql-kubernetes-ha-clusters-k8s-containers-scalable),
CloudNativePG represents a paradigm shift in managing PostgreSQL workloads
within Kubernetes environments.

-->
<!--
Tweet
Proud to announce #CloudNativePG 1.22.2 and 1.21.4 are out! Update now
for enhanced performance and bug fixes!

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1-22.2-released/!

#PostgreSQL #operator #Kubernetes #k8s #databases #postgres
--->
