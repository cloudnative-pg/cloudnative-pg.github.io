---
title: "CloudNativePG 1.16.1 and 1.15.3 Released!"
date: 2022-08-11T19:37:13+02:00
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
summary: The CloudNativePG community has released a new update for the supported 1.16.x and 1.15.x versions of the CloudNativePG operator.
---
The **CloudNativePG Community** has released a new update for the supported
1.16.x and 1.15.x version of the **CloudNativePG Operator**.

**Versions 1.16.1 and 1.15.3** are *patch releases* containing a few bug fixes
and minor enhancements, including:

- properly manage `stopDelay` and `switchoverDelay` options which were causing
  in some cases the PostgreSQL restart process to hang
- logging of failover and switchover times
- presence of the PostgreSQL timeline in the cluster status
- configuration of the `huge_pages` option for PostgreSQL

We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to:

- [release notes for 1.16.1](https://cloudnative-pg.io/documentation/1.16/release_notes/v1.16/)
- [release notes for 1.15.3](https://cloudnative-pg.io/documentation/1.15/release_notes/v1.15/)
