---
title: "CloudNativePG 1.28.0 RC2 Released!"
date: 2025-11-28T18:21:37+01:00
draft: false
authors:
 - gbartolini
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
 - FailoverQuorum
 - FDW
 - ForeignData
summary: "The CloudNativePG community is excited to announce the second release candidate of CloudNativePG 1.28! Join us in testing these updates to shape the final release."
---

The **CloudNativePG Community** is delighted to announce the availability of
**CloudNativePG 1.28.0 Release Candidate 2**!

This RC builds on the first round of large-scale testing by addressing several
issues and introducing targeted improvements. For full details, please refer to
the [1.28.0 RC2 release notes](https://cloudnative-pg.io/documentation/preview/release_notes/v1.28/).

A heartfelt thank you to everyone who participated in the preview programme so
far. Your insights, reports, and suggestions are directly shaping the quality
and stability of this release.

We encourage you to continue testing **1.28.0 RC2** in your **non-production
environments**. Your feedback is essential to delivering a robust, reliable
final release and ensuring that CloudNativePG 1.28 maintains its position as
the leading Kubernetes-native Postgres operator.

[Learn how to test and contribute](https://cloudnative-pg.io/documentation/preview/preview_version/).

## Testing

Each CloudNativePG release depends on thorough validation by our community.
By testing this release candidate against your real workloads, you help us
detect regressions and improve behaviour before the final release.

- Review the [open issues for the 1.28 milestone](https://github.com/cloudnative-pg/cloudnative-pg/milestone/30).
- [Report bugs or share feedback](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose)
  directly on GitHub.

## Release Timeline

RC2 is the latest step in the 1.28 release cycle.
Additional release candidates may follow if needed.
The final release is currently planned for **early December 2025**.

## Join the Community

CloudNativePG thrives thanks to a welcoming, vendor-neutral community of
contributors and practitioners.
[Join the conversation](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
and help shape the future of PostgreSQL on Kubernetes.

Thank you once again for your trust, enthusiasm, and contributions.
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
