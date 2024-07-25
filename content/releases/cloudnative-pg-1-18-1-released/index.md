---
title: "CloudNativePG 1.18.1, 1.17.3 and 1.16.5 Released!"
date: 2022-12-21T17:58:34+02:00
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
summary: The CloudNativePG community has released a new update for the supported 1.18, 1.17 and 1.16 versions of the CloudNativePG operator. Version 1.16 has reached End-of-Life (EOL).
---
The **CloudNativePG Community** has released a new update for the supported
1.18, 1.17 and 1.16 versions of the **CloudNativePG Operator**.

**Versions 1.18.1, 1.17.3 and 1.16.5** are *patch releases* containing a few
bug fixes and minor enhancements, including:

- better integration with identity management authentication in GKE or EKS via
  customization of labels and annotations for the service account
- support for `nodeAffinity`
- support for Istio's quit endpoint to prevent jobs like init and recovery from
  running indefinitely
- `fio` command in the `cnpg` plugin for `kubectl`

With this release, version 1.16 has reached End-of-Life (EOL): version 1.16.5
is the last that will be released for the 1.16 minor version.

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.18.1](https://cloudnative-pg.io/documentation/1.18/release_notes/v1.18/)
- [release notes for 1.17.3](https://cloudnative-pg.io/documentation/1.17/release_notes/v1.17/)
- [release notes for 1.16.5](https://cloudnative-pg.io/documentation/1.16/release_notes/v1.16/)

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
