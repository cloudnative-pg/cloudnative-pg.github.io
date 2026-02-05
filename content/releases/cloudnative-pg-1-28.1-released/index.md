---
title: "CloudNativePG 1.28.1 and 1.27.3 released!"
date: 2026-02-05
draft: false
authors:
 - fdrees
image:
    url: 58364dde1adc4a0a8.37186404-2048x1445.jpg
    attribution: from <a href="https://wordpress.org/photos/photo/58364dde1a/">Saurabh</a>
tags:
 - release
 - postgresql
 - postgres
 - kubernetes
 - k8s
 - cloudnativepg
 - cnpg
summary: The CloudNativePG community has released new updates for the 1.28 and 1.27 versions of the CloudNativePG operator.
---

The **CloudNativePG Community** is pleased to announce the release of
**CloudNativePG Operator** versions 1.28.1 and 1.27.3.

These releases deliver important bug fixes and stability improvements, ensuring
your PostgreSQL clusters continue to run reliably in production environments.
We recommend all users upgrade at their earliest convenience, particularly
those using PgBouncer or managing replica clusters.

Specifically, these updates address several critical scenarios that directly
impact production reliability:

- **Critical fix for PgBouncer upgrades**: We resolved an issue where stale TLS
  status fields in the `Pooler` were not correctly cleared. This was
  particularly disruptive for users upgrading to version 1.28, as it could cause
  PgBouncer to use incorrect certificates, resulting in "unsupported certificate"
  errors and blocking all application connectivity.

- **Timeline protection during WAL restore**: Improved the WAL restore logic to
  prevent replicas from downloading timeline history files with IDs greater
  than the cluster's current timeline. This prevents recovery failures caused by
  incomplete promotion attempts, where PostgreSQL creates history files for
  timelines that the cluster never officially adopts.

- **Timeline reset after major upgrades**: We addressed a critical issue in the
  major version upgrade path. After a `pg_upgrade`, the operator now correctly
  resets the `TimelineID` to 1. This prevents replicas from attempting to follow
  an incompatible timeline from the previous major version, which formerly led to
  fatal recovery errors.

Read the full release notes for details:

- [Release notes for 1.28.1](https://cloudnative-pg.io/docs/current/release_notes/v1.28/#version-1281)
- [Release notes for 1.27.3](https://cloudnative-pg.io/docs/current/release_notes/v1.27/#version-1273)

---

## Upgrade guidance

We recommend upgrading to **1.28.1** to benefit from the latest features,
enhancements, and long-term stability.

If you’re on **1.27.x**, please be reminded that version 1.27 will be supported until **9 March 2026**.
Upgrade to **1.27.3** to get the latest fixes in that series and begin planning
your transition to the 1.28 minor release series.

Follow the [upgrade instructions](https://cloudnative-pg.io/docs/current/installation_upgrade/#upgrades)
for a smooth transition.

---

## Get involved with the community

[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

If you're using CloudNativePG in production, consider
[adding your organisation as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project's growth and evolution.

Thank you for your continued support and for being part of the CloudNativePG community!
