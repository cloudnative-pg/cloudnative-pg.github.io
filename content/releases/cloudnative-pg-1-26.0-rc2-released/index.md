---
title: "CloudNativePG 1.26.0 RC2 Released!"
date: 2025-04-17T09:11:57+02:00
draft: false
author: gbartolini
image:
    url: "58364dde1adc4a0a8.37186404-2048x1445.jpg"
    attribution: from <a href="https://wordpress.org/photos/photo/58364dde1a/">Saurabh</a>
tags:
 - release
 - postgresql
 - postgres
 - kubernetes
 - k8s
 - cloudnativepg
 - preview
 - cnpg
summary: "The CloudNativePG community is excited to announce the second release candidate of CloudNativePG 1.26! This version fixes a few issues in the major upgrade process as well as in the integration of volume snapshot recovery with WALs via plugin. Join us in testing these updates to shape the final release."
---

The **CloudNativePG Community** is excited to announce the second release
candidate of **CloudNativePG 1.26.0**!

This release addresses a couple of issues identified during the first round of
large-scale testing—particularly in the areas of major upgrades and the Barman
Cloud plugin. You can find the complete list of changes in the
[1.26.0 RC2 release notes](https://cloudnative-pg.io/documentation/preview/release_notes/v1.26/).

We’d like to thank everyone who participated in the preview program and
provided valuable feedback. Your input has been instrumental in shaping this
release.

We kindly ask for your continued support in testing **1.26.0 RC2** in your
**non-production environments**. Your feedback will help us finalise a robust
and stable release and ensure that CloudNativePG 1.26 continues to set the
standard for PostgreSQL on Kubernetes.

[Learn more about testing and contributing](https://cloudnative-pg.io/documentation/preview).

## Testing

The stability of every CloudNativePG release depends on active community
involvement. By testing this release candidate against your workloads, you help
us catch bugs and regressions early.

- Explore [open issues for the 1.26 release](https://github.com/cloudnative-pg/cloudnative-pg/milestone/25).
- [Report any bugs or feedback on GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Release Timeline

RC2 is the latest in our series of release candidates. Additional RCs may
follow if necessary before the final release, which is currently scheduled for
**late April or early May 2025**.

## Join the Community

Be part of our open, vendor-neutral community!
[Connect with us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
and help shape the future of Kubernetes-native PostgreSQL.

Thank you for your continued trust and support.
Together, we’re building the future of Postgres on Kubernetes.

<!--
# About CloudNativePG

[CloudNativePG](https://cloudnative-pg.io) is an open-source Kubernetes
Operator specifically designed for PostgreSQL workloads. It manages the entire
lifecycle of a PostgreSQL cluster, including bootstrapping, configuration, high
availability, connection routing, and comprehensive backup and disaster
recovery mechanisms. By leveraging PostgreSQL's native streaming replication,
CloudNativePG efficiently distributes data across pods, nodes, and zones using
standard Kubernetes patterns, enabling seamless scaling of replicas in a
Kubernetes-native manner. Originally developed and supported by
[EDB](https://www.enterprisedb.com/), CloudNativePG is a
[CNCF Sandbox project](https://www.cncf.io/projects/cloudnativepg/)
and the sole PostgreSQL operator in this category.

-->
<!--
Tweet
🚀 Exciting news! CloudNativePG 1.26.0 RC2 is here! Help us test exciting new features like major in-place upgrades, startup and readiness probes for replicas, and declarative extensions management.

LINK

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource

--->
<!--
LinkedIn
🚀 CloudNativePG 1.26.0 RC2 is Here! 🚀

We’re excited to announce the release of the second release candidate for CloudNativePG 1.26.0! 🎉

This milestone helps us test and refine key new features coming in the final release:

🔹 Declarative Offline In-Place Major Upgrades of PostgreSQL
🔹 Improved Startup and Readiness Probes for replicas
🔹 Declarative Management of Extensions and Schemas

We’re calling on the community to try out this preview version in non-production environments and share your feedback. Your input is crucial to ensuring a robust and reliable release!

LINK

Let’s build the future of PostgreSQL on Kubernetes—together.

Follow us for updates and join our community to get involved!

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource #RC2 #CloudNative #DataOps #ReleaseCandidate
-->
