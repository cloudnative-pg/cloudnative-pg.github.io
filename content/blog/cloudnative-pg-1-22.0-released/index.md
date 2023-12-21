---
title: "CloudNativePG 1.22.0, 1.21.2 and 1.20.5 Released!"
date: 2023-12-21T14:51:33+01:00
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
 - tablespaces
summary: The CloudNativePG community has released the new 1.22 minor version and a new update for the supported 1.21 and 1.20 versions of the CloudNativePG operator.
---
The **CloudNativePG Community** is thrilled to unveil version 1.22.0 of the
**CloudNativePG Operator**, a significant milestone featuring the introduction
of **declarative tablespaces** and **temporary tablespaces** alongside various
enhancements and fixes.

Tablespaces, a powerful and widely adopted feature in database management
systems, now take center stage in CloudNativePG 1.22.0. This release empowers
users to boost the vertical scalability of their databases by decoupling the
physical and logical data modeling, achieving optimal performance through
parallel on-disk read/write operations. With CloudNativePG, users can define
additional tablespace volumes, and also ensure they can be used for temporary
operations (CloudNativePG seamlessly manages the `temp_tablespaces` GUC).

This marks a pivotal step towards adopting Very Large Databases, building upon
the foundation laid by Kubernetes volume snapshots introduced in version 1.21.

Starting from version 1.22.0, the `ALTER SYSTEM` command is now disabled by
default. This ensures that changes to the PostgreSQL configuration are
orchestrated through the Kubernetes API. This streamlined approach guarantees
coherence across the entire high-availability cluster and aligns with best
practices for Infrastructure-as-Code.

In terms of security, all supported versions now require TLS 1.3 for PostgreSQL
connections by default, further bolstering the integrity of data transmission.

Before initiating an upgrade, carefully review the
[detailed instructions](https://cloudnative-pg.io/documentation/current/installation_upgrade/#upgrading-to-1220-1212-or-1205).
New patch releases are now available for all supported versions, including
1.21.2 and 1.20.5.

Considering the notable changes introduced, we strongly recommend upgrading to
CloudNativePG 1.22.0 at your earliest convenience. Alternatively, update to the
latest patch version within your current minor release.

With the release of 1.22.0, the 1.20.x minor version will reach its [end of
life](https://cloudnative-pg.io/documentation/1.22/supported_releases/#support-status-of-cloudnativepg-releases)
on January 21, 2024.

This release addresses several bugs for improved stability. For a comprehensive list of changes, refer to the following release notes:

- [Release notes for 1.22.0](https://cloudnative-pg.io/documentation/1.22/release_notes/v1.22/)
- [Release notes for 1.21.2](https://cloudnative-pg.io/documentation/1.21/release_notes/v1.21/)
- [Release notes for 1.20.5](https://cloudnative-pg.io/documentation/1.20/release_notes/v1.20/)

Thank you for your continued support and engagement with CloudNativePG!

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
Proud to announce #CloudNativePG 1.22.0, 1.21.2 and 1.20.5 are out! Update now!

Introducing declarative #tablespaces, temporary tablespaces. Upgrade now for enhanced vertical scalability and bug fixes.

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1-22.0-released/!

#k8s #postgres #oss #cloudnative
--->
