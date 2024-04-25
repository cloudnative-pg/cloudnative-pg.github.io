---
title: "CloudNativePG 1.23.0, 1.22.2 and 1.21.5 Released!"
date: 2024-04-25T09:56:00+02:00
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
 - pdb
 - imagecatalog
summary: The CloudNativePG community has released the new 1.23 minor version and a new update for the supported 1.22 and 1.21 versions of the CloudNativePG operator.
---
The **CloudNativePG Community** is thrilled to unveil version 1.23.0 of the
**CloudNativePG Operator**, introducing support for PostgreSQL image catalogs,
synchronization of user-defined replication slots, and Pod Disruption Budget
(PDB) configuration.

The CloudNativePG now maintains [image catalogs for PostgreSQL](https://github.com/cloudnative-pg/postgres-containers/blob/main/Debian/ClusterImageCatalog.yaml)
based on the major version, allowing you to just request the PostgreSQL major
version and control the way your database fleet is kept up-to-date. Two new
resources have been introduced (`ClusterImageCatalog` and `ImageCatalog`), as
well as a new stanza called `.spec.imageCatalogRef` in the `Cluster` resource.
This mechanism will likely become the default in the future.

The synchronization mechanism has now been extended to user-defined replication
slots that you have created on the PostgreSQL primary, ensuring that they
resist after a failover.


Before initiating an upgrade, carefully review the
[detailed instructions](https://cloudnative-pg.io/documentation/current/installation_upgrade/#upgrading-to-1230-1223-or-1215).
New patch releases are now available for all supported versions, including
1.22.2 and 1.21.5.

We recommend upgrading to CloudNativePG 1.23.0 at your earliest convenience.
Alternatively, update to the latest patch version within your current minor
release.

With the release of 1.23.0, the 1.21.x minor version will reach its [end of
life](https://cloudnative-pg.io/documentation/1.23/supported_releases/#support-status-of-cloudnativepg-releases)
on January 21, 2024.

This release addresses several bugs for improved stability. For a comprehensive list of changes, refer to the following release notes:

- [Release notes for 1.23.0](https://cloudnative-pg.io/documentation/1.23/release_notes/v1.23/)
- [Release notes for 1.22.2](https://cloudnative-pg.io/documentation/1.22/release_notes/v1.22/)
- [Release notes for 1.21.5](https://cloudnative-pg.io/documentation/1.21/release_notes/v1.21/)

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
Proud to announce #CloudNativePG 1.23.0, 1.22.2 and 1.21.5 are out! Update now!

Introducing declarative #tablespaces, temporary tablespaces. Upgrade now for enhanced vertical scalability and bug fixes.

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1.23.0-released/!

#k8s #postgres #oss #cloudnative
--->
