---
title: "CloudNativePG 1.20.1, 1.19.3 and 1.18.5 Released!"
date: 2023-06-12T17:51:21+02:00
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
summary: The CloudNativePG community has released a new update for the supported 1.20, 1.19 and 1.18 versions of the CloudNativePG operator. Version 1.18 has reached End-of-Life (EOL).
---
The **CloudNativePG Community** has released a new update for the supported
1.20, 1.19 and 1.18 versions of the **CloudNativePG Operator**.

**Versions 1.20.1, 1.19.3 and 1.18.5** are *patch releases* containing a few
bug fixes and minor enhancements, including:

- First implementation of recovery from a set of CSI VolumeSnapshot resources
  via the `.spec.bootstrap.recovery.volumeSnapshot` stanza
- `snapshot` command for the `cnpg` plugin to create a consistent cold backup
  of a Postgres cluster from a standby using the Kubernetes `VolumeSnapshot`
  standard resource
- Support for TopologySpreadConstraints to manage scheduling of instance pods
- Management of the `pg_failover_slots` extension
- `schemaOnly` option in the `import` stanza to avoid exporting/importing data
  when you bootstrap a new Postgres Cluster from an existing one

A new and improved version of the Grafana dashboard is now supplied with
CloudNativePG.

With this release, version 1.18 has reached End-of-Life (EOL): version 1.18.5
is the last that will be released for the 1.18 minor version.

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.20.1](https://cloudnative-pg.io/documentation/1.20/release_notes/v1.20/)
- [release notes for 1.19.3](https://cloudnative-pg.io/documentation/1.19/release_notes/v1.19/)
- [release notes for 1.18.5](https://cloudnative-pg.io/documentation/1.18/release_notes/v1.18/)

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
Proud to announce #CloudNativePG 1.20.1, 1.19.3 and 1.18.5 are out! Update now!

This patch release contains several fixes as well as improvements in the backup area.

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1.20-1-released/!

#PostgreSQL #operator #Kubernetes #k8s #databases #postgres #oss
--->
