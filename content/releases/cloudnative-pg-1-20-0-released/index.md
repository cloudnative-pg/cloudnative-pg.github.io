---
title: "CloudNativePG 1.20.0, 1.19.2 and 1.18.4 Released!"
date: 2023-04-27T15:29:36+02:00
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
summary: The CloudNativePG community has released the new 1.20 minor version and a new update for the supported 1.19 and 1.18 versions of the CloudNativePG operator.
---
The **CloudNativePG Community** has announced version 1.20.0, a new minor
release of the **CloudNativePG Operator**, which introduces support for
**declarative role management**, allowing you to manage PostgreSQL
users and groups via configuration, and **declarative hibernation**,
which enables you to shut down all running pods in a PostgreSQL cluster
and keep only the persistent volumes.

We are also changing the default behavior with the newly created PostgreSQL
clusters:

- automated rolling updates now trigger a restart of the primary instead of a
  switchover
- if replicas are available, backups for Point-In-Time-Recovery are automatically
  taken from a standby

Some minor bugs have also been fixed.

New patch releases are available for all the supported versions, including
1.19.2 and 1.18.4.

With the release of 1.20.0, the 1.18.x minor version will be
[end of life](https://cloudnative-pg.io/documentation/1.20/supported_releases/#support-status-of-cloudnativepg-releases)
from 27 May, 2023.

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.20.0](https://cloudnative-pg.io/documentation/1.20/release_notes/v1.20/)
- [release notes for 1.19.2](https://cloudnative-pg.io/documentation/1.19/release_notes/v1.19/)
- [release notes for 1.18.4](https://cloudnative-pg.io/documentation/1.18/release_notes/v1.18/)

<!--
# About CloudNativePg

[CloudNativePG](https://cloudnative-pg.io) is an open source Kubernetes Operator for PostgreSQL workloads that orchestrates the full life cycle of a PostgreSQL cluster, from bootstrapping and configuration, through high availability and connection routing, to backups and disaster recovery. CloudNativePG relies on PostgreSQL’s native streaming replication to distribute data across pods, nodes, and zones, using standard Kubernetes patterns. Replicas can be scaled up and down in a Kubernetes native manner, and the operator automatically and safely reconfigure replication as appropriate.
[CloudNativePG is a project originally created and supported by EDB](https://www.enterprisedb.com/products/cloud-native-postgresql-kubernetes-ha-clusters-k8s-containers-scalable).
-->
<!--
Tweet
Proud to announce #CloudNativePG 1.20.0, 1.19.2 and 1.18.4 are out! Update now!

Introducing backup from standby and delayed failover, enhancing support for WAL volumes.

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1-19-0-released/!

#PostgreSQL #operator #Kubernetes #k8s #databases #postgres #oss
--->
