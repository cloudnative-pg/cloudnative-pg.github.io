---
title: "CloudNativePG 1.17.0, 1.16.2 and 1.15.4 Released!"
date: 2022-09-04T17:45:03+02:00
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
summary: The CloudNativePG community has released the new 1.17 minor version and a new update for the supported 1.16 and 1.15 versions of the CloudNativePG operator.
---
The **CloudNativePG Community** has released version 1.17.0, a new minor
version of the **CloudNativePG Operator**, which introduces the possibility to
create a new PostgreSQL cluster with a **dedicated volume for Write-Ahead Log
(WAL) files**. Separating I/O workloads of database (`PGDATA`) and WAL files
improves also vertical scalability of PostgreSQL clusters.

In this version, a new command, `destroy`, has been added to the `cnpg` plugin
for `kubectl` to help remove an instance and the associated persistent volume
claims from an existing cluster.

Two new labels, `cnpg.io/instanceName` and `cnpg.io/podRole`, are now managed
by the operator on all persistent volume claims that belong to a cluster.

Some minor bugs have been fixed, in particular in the in-place operator upgrade
process.

New patch releases are available for all the supported versions, namely:

- 1.16.2 for the 1.16 minor release
- 1.15.4 for the 1.15 minor release

**IMPORTANT:** 1.15.x will be end of life on 7 October, 2022.

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.17.0](https://cloudnative-pg.io/documentation/1.17/release_notes/v1.17/)
- [release notes for 1.16.2](https://cloudnative-pg.io/documentation/1.16/release_notes/v1.16/)
- [release notes for 1.15.4](https://cloudnative-pg.io/documentation/1.15/release_notes/v1.15/)

<!--
# About CloudNativePg

[CloudNativePG](https://cloudnative-pg.io) is an open source Kubernetes Operator for PostgreSQL workloads that orchestrates the full life cycle of a PostgreSQL cluster, from bootstrapping and configuration, through high availability and connection routing, to backups and disaster recovery. CloudNativePG relies on PostgreSQL’s native streaming replication to distribute data across pods, nodes, and zones, using standard Kubernetes patterns. Replicas can be scaled up and down in a Kubernetes native manner, and the operator automatically and safely reconfigure replication as appropriate.
CloudNativePG is the first PostgreSQL Operator to pursue the whole graduation process with the Cloud Native Computing Foundation (CNCF) by submitting the request to join the Sandbox in April 2022.
[CloudNativePG is a project originally created and supported by EDB](https://www.enterprisedb.com/products/cloud-native-postgresql-kubernetes-ha-clusters-k8s-containers-scalable).
-->
