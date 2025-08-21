---
title: "CloudNativePG 1.19.0, 1.18.2 and 1.17.4 Released!"
date: 2023-02-14T15:53:18+01:00
draft: false
image:
    url: wildlife-zoo-mammal-fauna-elephant-sri-lanka-988769-pxhere.com.jpg
    attribution: from <strong><a href="https://pxhere.com/en/photo/988769?utm_content=clipUser&utm_medium=referral&utm_source=pxhere">PxHere</a></strong>
authors:
 - gbartolini
tags:
 - release
 - postgresql
 - postgres
 - kubernetes
 - k8s
 - cloudnativepg
summary: The CloudNativePG community has released the new 1.19 minor version and a new update for the supported 1.18 and 1.17 versions of the CloudNativePG operator.
---
The **CloudNativePG Community** has announced version 1.19.0, a new minor
release of the **CloudNativePG Operator**, which introduces support for
**backup from a standby**, which reduces the I/O impact on the primary, and
**delayed failover**, which enables you to wait for some amount of time
after a failure on the primary before triggering an automated failover.

Support for separate WAL volumes has been enhanced with the possibility to add
a separate WAL volume even on an existing PostgreSQL cluster. More metrics for
WAL usage monitoring have been added to the default Prometheus exporter.
Both functionalities have also been backported to 1.18.2.

The `cnpg` plugin for `kubectl` has been enhanced with the introduction of the
`backup` command to issue a new base backup on a selected cluster.

Some minor bugs have also been fixed.

New patch releases are available for all the supported versions, including
1.18.2 and 1.17.4.

With the release of 1.19.0, the 1.17.x minor version will be
[end of life](https://cloudnative-pg.io/documentation/1.19/supported_releases/#support-status-of-cloudnativepg-releases)
from 14 March, 2023.

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.19.0](https://cloudnative-pg.io/documentation/1.19/release_notes/v1.19/)
- [release notes for 1.18.2](https://cloudnative-pg.io/documentation/1.18/release_notes/v1.18/)
- [release notes for 1.17.4](https://cloudnative-pg.io/documentation/1.17/release_notes/v1.17/)

<!--
# About CloudNativePg

[CloudNativePG](https://cloudnative-pg.io) is an open source Kubernetes Operator for PostgreSQL workloads that orchestrates the full life cycle of a PostgreSQL cluster, from bootstrapping and configuration, through high availability and connection routing, to backups and disaster recovery. CloudNativePG relies on PostgreSQL’s native streaming replication to distribute data across pods, nodes, and zones, using standard Kubernetes patterns. Replicas can be scaled up and down in a Kubernetes native manner, and the operator automatically and safely reconfigure replication as appropriate.
[CloudNativePG is a project originally created and supported by EDB](https://www.enterprisedb.com/products/cloud-native-postgresql-kubernetes-ha-clusters-k8s-containers-scalable).
-->
<!--
Tweet
Proud to announce #CloudNativePG 1.19.0, 1.18.2 and 1.17.4 are out! Update now!

Introducing backup from standby and delayed failover, enhancing support for WAL volumes.

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1-19-0-released/!

#PostgreSQL #operator #Kubernetes #k8s #databases #postgres #oss
--->
