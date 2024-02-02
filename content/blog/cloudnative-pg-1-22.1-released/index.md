---
title: "CloudNativePG 1.22.1, 1.21.3 and 1.20.6 Released!"
date: 2024-02-02T17:10:42+01:00
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
summary: The CloudNativePG community has released a new update for the supported 1.22, 1.21 and 1.20 versions of the CloudNativePG operator. Version 1.20 has reached End-of-Life (EOL).
---

The **CloudNativePG Community** The CloudNativePG Community is excited to
announce a new update for the **CloudNativePG Operator*, now available for the
supported 1.22, 1.21, and 1.20 versions.

Key enhancements in all supported minor releases are:

- Customize ephemeral volume storage for a PostgreSQL cluster using a claim
  template
- Introduce the `pgadmin4` command in the `cnpg` plugin for `kubectl` to
  swiftly set up a demonstration-only interface for PgAdmin4. This is the most
  popular GUI for PostgreSQL, facilitating easy connection to a designated
  Postgres Cluster
- Add support for PostgreSQL's ident map file configuration

**Versions 1.22.1, 1.21.3 and 1.20.6** are *patch releases* that include
essential bug fixes, addressing issues such as:

- Prevention of an unrecoverable problem with `pg_rewind` caused by
  `postgresql.auto.conf` being read-only due to the disabled alter system
  option
- Reduction of the risk of disk space shortage when using the import facility
  of the `initdb` bootstrap method

With this update, version 1.20 has reached End-of-Life (EOL). Version 1.20.6
marks the final release for the 1.20 minor version.

We highly recommend updating the operator at your earliest convenience to
benefit from these improvements and bug fixes.

For a detailed list of changes, please refer to the following release notes:

- [release notes for 1.22.1](https://cloudnative-pg.io/documentation/1.22/release_notes/v1.22/)
- [release notes for 1.21.3](https://cloudnative-pg.io/documentation/1.21/release_notes/v1.21/)
- [release notes for 1.20.6](https://cloudnative-pg.io/documentation/1.20/release_notes/v1.20/)

Thank you for your continued support, and we look forward to your seamless
experience with the updated CloudNativePG Operator.

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
Proud to announce #CloudNativePG 1.22.1, 1.21.3 and 1.20.6 are out! Update now
for enhanced performance and bug fixes! Version 1.20 has reached EOL with
1.20.6 as the final release.

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1-22.1-released/!

#PostgreSQL #operator #Kubernetes #k8s #databases #postgres
--->
