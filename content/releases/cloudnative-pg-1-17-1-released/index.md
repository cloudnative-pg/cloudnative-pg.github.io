---
title: "CloudNativePG 1.17.1, 1.16.3 and 1.15.5 Released!"
date: 2022-10-06T17:58:34+02:00
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
summary: The CloudNativePG community has released a new update for the supported 1.17, 1.16 and 1.15 versions of the CloudNativePG operator. Version 1.15 has reached End-of-Life (EOL).
---
The **CloudNativePG Community** has released a new update for the supported
1.17, 1.16 and 1.15 versions of the **CloudNativePG Operator**.

**Versions 1.17.1, 1.16.3 and 1.15.5** are *patch releases* containing a few
bug fixes and minor enhancements, including:

- Improve the mechanism that checks that the backup object store is empty
  before archiving a WAL file for the first time
- Explicitly set permissions of the instance manager binary that is copied in
  the `distroless/static:nonroot` container image, by using the
  `nonroot:nonroot` user
- Make the cluster's conditions compatible with `metav1.Conditions` struct (1.15 only)
- Drop any active connection on a standby after it is promoted to primary
- Honor `MAPPEDMETRIC` and `DURATION` metric types conversion in the native Prometheus exporter

With this release, version 1.15 has reached End-of-Life (EOL): version 1.15.5
is the last that will be released for the 1.15 minor version.

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.17.1](https://cloudnative-pg.io/documentation/1.17/release_notes/v1.17/)
- [release notes for 1.16.3](https://cloudnative-pg.io/documentation/1.16/release_notes/v1.16/)
- [release notes for 1.15.5](https://cloudnative-pg.io/documentation/1.15/release_notes/v1.15/)

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
CloudNativePG is the first PostgreSQL Operator to pursue the whole graduation
process with the Cloud Native Computing Foundation (CNCF) by submitting the
request to join the Sandbox in April 2022.
[CloudNativePG is a project originally created and supported by EDB](https://www.enterprisedb.com/products/cloud-native-postgresql-kubernetes-ha-clusters-k8s-containers-scalable).

-->
