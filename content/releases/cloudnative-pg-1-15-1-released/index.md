---
title: "CloudNativePG 1.15.1 Released!"
date: 2022-05-30T13:37:13+02:00
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
summary: The CloudNativePG community has released a new update for the supported 1.15.x version of the CloudNativePG operator.
---
The **CloudNativePG Community** has released a new update for the supported 1.15.x
version of the **CloudNativePG Operator**.

**Version 1.15.1** is a *patch release* containing a few bug fixes and minor
enhancements, in particular in the backup and recovery area, including:

- Ownership of Backup objects for finer control of cleanup operations in the
  Kubernetes cluster
- Configurable archive timeout parameter, by default fixed to 5 minutes, which
  is relevant to set the upper limit of the recovery point objective (RPO) of a
  Postgres cluster
- Enhanced verification of backup and recovery object stores to ensure that an
  object store can only be written by one Postgres cluster
- Automated export of the `pg_stat_wal` stats view available from PostgreSQL 14
  onwards


We encourage you to update the operator at your earliest possible convenience.

For a complete list of changes, please refer to the
[release notes](https://cloudnative-pg.io/documentation/1.15.1/release_notes/).
