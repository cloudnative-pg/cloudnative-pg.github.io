---
title: "CloudNativePG 1.18.0, 1.17.2 and 1.16.4 Released!"
date: 2022-11-10T17:45:03+01:00
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
summary: The CloudNativePG community has released the new 1.18 minor version and a new update for the supported 1.17 and 1.16 versions of the CloudNativePG operator.
---
The **CloudNativePG Community** has announced version 1.18.0, a new minor
release of the **CloudNativePG Operator**, which introduces support for
**cluster-managed physical replication slots** to automatically manage physical
replication slots for each hot standby replica in a High Availability
cluster, failover events included.

The `cnpg` plugin for `kubectl` has been enhanced with the introduction of 3
new commands:

- `hibernate`: destroy all the resources generated by a `Cluster`, except the
  PVCs that belong to the PostgreSQL primary instance (`hibernate on`), and
  re-create the cluster (`hibernate off`)
- `install`: generate manifests to override the default configuration options
  for an operator deployment, such as namespaces to watch, replicas, and so on
- `pgbench`: generate jobs to run `pgbench` against a given cluster

Some minor bugs have been fixed, in particular importing a database with
`plpgsql` functions and finding the closest backup when doing PITR.

New patch releases are available for all the supported versions, including
1.17.2 and 1.16.4.

With the release of 1.18.0, the 1.16.x minor version will be
[end of life](https://cloudnative-pg.io/documentation/1.18/supported_releases/#support-status-of-cloudnativepg-releases)
from 10 December, 2022.

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.18.0](https://cloudnative-pg.io/documentation/1.18/release_notes/v1.18/)
- [release notes for 1.17.2](https://cloudnative-pg.io/documentation/1.17/release_notes/v1.17/)
- [release notes for 1.16.4](https://cloudnative-pg.io/documentation/1.16/release_notes/v1.16/)

<!--
# About CloudNativePg

[CloudNativePG](https://cloudnative-pg.io) is an open source Kubernetes Operator for PostgreSQL workloads that orchestrates the full life cycle of a PostgreSQL cluster, from bootstrapping and configuration, through high availability and connection routing, to backups and disaster recovery. CloudNativePG relies on PostgreSQL’s native streaming replication to distribute data across pods, nodes, and zones, using standard Kubernetes patterns. Replicas can be scaled up and down in a Kubernetes native manner, and the operator automatically and safely reconfigure replication as appropriate.
CloudNativePG is the first PostgreSQL Operator to pursue the whole graduation process with the Cloud Native Computing Foundation (CNCF) by submitting the request to join the Sandbox in April 2022.
[CloudNativePG is a project originally created and supported by EDB](https://www.enterprisedb.com/products/cloud-native-postgresql-kubernetes-ha-clusters-k8s-containers-scalable).
-->