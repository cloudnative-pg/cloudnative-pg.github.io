---
title: "CloudNativePG 1.16.0 and 1.15.2 Released!"
date: 2022-07-06T08:04:21+02:00
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
summary: The CloudNativePG community has released the new 1.16 minor version and a new update for the supported 1.15 version of the CloudNativePG operator.
---
The **CloudNativePG Community** has released version 1.16.0, a new minor
version of the **CloudNativePG Operator**, which introduces two important
capabilities:

- offline import of data from an existing PostgreSQL instance via the network,
  also enabling PostgreSQL major upgrades
- anti-affinity rules for synchronous replication based on node labels, providing
  fine-grained control on where to run sync replicas inside a Kubernetes cluster

From this release we are starting our policy to support the last two minor
versions of CloudNativePG. This means that the 1.15 minor version will be
supported by the Community for another month after 1.17.0 is released.
We are today releasing the patch version 1.15.2 for the 1.15.x branch.
For details please refer to the
["Supported releases" section](https://cloudnative-pg.io/documentation/1.16/supported_releases/).

Version 1.16.0 also introduces a few enhacements in the backup and recovery
area, as well as in the fencing mechanism, by removing the existing limitation
that disables failover when one or more instances are fenced.

It adds support for Kubernetes 1.24, and provides several bug fixes.

Such fixes have been back-ported to the 1.15 release branch, and included in
the 1.15.2 version.

For a complete list of changes, please refer to the release notes for
[1.16.0](https://cloudnative-pg.io/documentation/1.16/release_notes/)
and for
[1.15.2](https://cloudnative-pg.io/documentation/1.15/release_notes/).

We strongly encourage you to update the operator at your earliest possible convenience.
You can either jump directly to 1.16.0 and benefit from all the new
capabilities and enhancements that have been introduced, or stay in the 1.15
minor release by moving to 1.15.2 with bug fixes only.

