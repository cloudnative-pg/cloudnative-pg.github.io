---
title: "CloudNativePG 1.21.1, 1.20.4 and 1.19.6 Released!"
date: 2023-11-03T15:43:07+01:00
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
summary: The CloudNativePG community has released a new update for the supported 1.21, 1.20 and 1.19 versions of the CloudNativePG operator. Version 1.19 has reached End-of-Life (EOL).
---
The **CloudNativePG Community** has released a new update for the supported
1.21, 1.20 and 1.19 versions of the **CloudNativePG Operator**.

Version 1.21.1 removes the previous limitation of cold backups on volume
snapshots: by default, unless differently requested, volume snapshot backups
are taken while the Postgres instance is up and running, thanks to the direct
support of the PostgreSQL API for physical online backups. A few options allow
you to configure the default behavior, and apply hybrid backup strategies
based on object store, cold volume snapshots, and hot volume snapshots.

**Versions 1.21.1, 1.20.4 and 1.19.6** are *patch releases* containing a few
bug fixes, including:

- temporary suspension of WAL archiving during a switchover
- ensure `LOCAL` synchronous commit level when managing the Postgres cluster
  replication settings
- fix customization of certificates for the streaming replication user

With this release, version 1.19 has reached End-of-Life (EOL): version 1.19.6
is the last that will be released for the 1.19 minor version.

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.21.1](https://cloudnative-pg.io/documentation/1.21/release_notes/v1.21/)
- [release notes for 1.20.4](https://cloudnative-pg.io/documentation/1.20/release_notes/v1.20/)
- [release notes for 1.19.6](https://cloudnative-pg.io/documentation/1.19/release_notes/v1.19/)

<!--
# About CloudNativePg

[CloudNativePG](https://cloudnative-pg.io) is an open source Kubernetes
Operator for PostgreSQL workloads that orchestrates the full life cycle of a
PostgreSQL cluster, from bootstrapping and configuration, through high
availability and connection routing, to backups and disaster recovery.
CloudNativePG relies on PostgreSQL’s native streaming replication to distribute
data across pods, nodes, and zones, using standard Kubernetes patterns.
Replicas can be scaled up and down in a Kubernetes native manner, and the
operator automatically and safely reconfigure replication as appropriate.
[CloudNativePG is a project originally created and supported by EDB](https://www.enterprisedb.com/products/cloud-native-postgresql-kubernetes-ha-clusters-k8s-containers-scalable).

-->
<!--
Tweet
Proud to announce #CloudNativePG 1.21.1, 1.20.4 and 1.19.6 are out! Update now!

This patch release contains several fixes as well as improvements in the DR and HA areas.

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1.21-1-released/!

#PostgreSQL #operator #Kubernetes #k8s #databases #postgres #oss
--->
