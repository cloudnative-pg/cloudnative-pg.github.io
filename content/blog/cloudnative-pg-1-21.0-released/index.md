---
title: "CloudNativePG 1.21.0, 1.20.3 and 1.19.5 Released!"
date: 2023-10-12T13:46:12+02:00
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
 - volumesnapshots
summary: The CloudNativePG community has released the new 1.21 minor version and a new update for the supported 1.20 and 1.19 versions of the CloudNativePG operator.
---
The **CloudNativePG Community** has announced version 1.21.0, a new minor
release of the **CloudNativePG Operator**, which introduces **volume snapshot
support for backup and recovery** along several enhancements in the default
behavior in terms of usability, security and resilience.

By leveraging the [standard Kubernetes API on Volume Snapshots](https://kubernetes.io/blog/2020/12/10/kubernetes-1.20-volume-snapshot-moves-to-ga/),
you can now take advantage of capabilities like incremental and differential
copy for both backup and recovery operations of PostgreSQL databases, opening
up the frontier of very large databases (VLDB).  CloudNativePG is the first
PostgreSQL operator that natively supports Kubernetes volume snapshots.
This implementation covers cold backups from a standby, waiting for 1.22 to
complete the feature with hot backups using the PostgreSQL API.

CloudNativePG 1.21 also introduces support for Operator Lifecycle Manager (OLM)
via OperatorHub.io (through the `stable` channel, which is limited to the
latest patch version of the latest minor release). Many thanks to
[EDB](https://enterprisedb.com) for donating the bundle of their "EDB Postgres
for Kubernetes" operator and adapting it for CloudNativePG.

As an exceptional measure, some important changes to the default behavior of
the operator have been made in this release with the goal to keep improving the
out-of-the-box usability, security and resilience of the operator.
The most relevant changes on new PostgreSQL clusters are:

- network access as `postgres` superuser is forbidden unless requested, for
  better security-by-default (1.21.0 only)
- replication slots for the High Availability cluster are enabled by default,
  improving resilience (1.21.0 only)
- more realistic default values for timeouts and delays that control start,
  stop, switchover, and fencing operations, suitable for most production
  environments (all patch releases).

We apologize with our existing users for any inconvenience but, as the user
base of CloudNativePG keeps expanding, postponing them would have generated
more issues in the long term. Before upgrading, please make sure you
[read the detailed instructions](https://cloudnative-pg.io/documentation/current/installation_upgrade/#upgrading-to-1210-1203-or-1195).

New patch releases are available for all the supported versions, including
1.20.3 and 1.19.5.

Before of the above changes, we recommend to upgrade at your earliest possible
convenience to 1.21.0, or, alternatively, at least to the latest patch version
for your current minor release.

With the release of 1.21.0, the 1.19.x minor version will be
[end of life](https://cloudnative-pg.io/documentation/1.21/supported_releases/#support-status-of-cloudnativepg-releases)
from 11 November, 2023.

Several bugs have also been fixed.

For a complete list of changes, please refer to:

- [release notes for 1.21.0](https://cloudnative-pg.io/documentation/1.21/release_notes/v1.21/)
- [release notes for 1.20.3](https://cloudnative-pg.io/documentation/1.20/release_notes/v1.20/)
- [release notes for 1.19.5](https://cloudnative-pg.io/documentation/1.19/release_notes/v1.19/)

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
Proud to announce #CloudNativePG 1.21.0, 1.20.3 and 1.19.5 are out! Update now!

First #PostgreSQL #operator to introduce native #Kubernetes #VolumeSnapshot API support for #incremental
#differential #backup and #recovery, suitable for very large #databases (#VLDB)

Read more https://cloudnative-pg.io/blog/cloudnative-pg-1-21.0-released/!

#k8s #postgres #oss #cloudnative
--->
