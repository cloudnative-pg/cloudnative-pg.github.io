---
title: "CloudNativePG 1.26.0 RC3 Released!"
date: 2025-05-13T10:50:17+02:00
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
summary: "CloudNativePG 1.26.0 RC3 is out, featuring key fixes for major upgrades and Barman Cloud plugin migration—test it now and help shape the final release!"
---

The **CloudNativePG Community** is pleased to announce the release of
**CloudNativePG 1.26.0 RC3**, the third release candidate before general
availability.

This release delivers important fixes identified during the first wave of
large-scale testing—particularly in two critical areas:

- the transition from in-tree **Barman Cloud object store** support to the new **plugin-based architecture**, and
- the **major version upgrade** process.

Read the full changelog in the
[1.26.0 RC3 release notes](https://cloudnative-pg.io/documentation/preview/release_notes/v1.26/).

## Barman Cloud Migration

With the 1.26 release, the **deprecation period** for in-tree Barman Cloud
support officially begins. While it remains fully functional in 1.26, we
**strongly encourage** users to begin planning the migration to the
[Barman Cloud Plugin](https://cloudnative-pg.io/plugin-barman-cloud/)
as early as possible and to adopt it for all new deployments.

To help with this, we’ve published a comprehensive
[migration guide](https://cloudnative-pg.io/plugin-barman-cloud/docs/migration/)—
and this RC is the perfect opportunity to test it out and share your feedback.

Also, a warning will now be triggered by the admission webhook when using the
deprecated `.spec.backup.barmanObjectStore` and `.spec.backup.retentionPolicy`
fields.

---

## New Experimental Feature: Primary Liveness Network Isolation

RC3 introduces an opt-in **experimental enhancement** to the liveness probe that
enables detection of network isolation scenarios for primary instances. When
enabled via the `alpha.cnpg.io/livenessPinger` annotation, this feature allows
a primary that is isolated to proactively shut itself down.

---

## Thank You

We’re incredibly grateful to everyone who participated in the preview program
and contributed valuable feedback. Your involvement continues to shape the
direction of CloudNativePG and helps us deliver high-quality, production-ready
features.

---

## Help Us Test

We invite you to test **CloudNativePG 1.26.0 RC3** in your **non-production
environments** and report any issues or suggestions. This is your chance to
help us fine-tune the final release!

- [View open issues for the 1.26 milestone](https://github.com/cloudnative-pg/cloudnative-pg/milestone/25)
- [Report a bug or provide feedback](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose)

Learn more about how to get involved on the [preview testing page](https://cloudnative-pg.io/documentation/preview).

---

## Release Timeline

RC3 is the latest in our release candidate series. Additional RCs may be issued
if needed, but we currently expect the **final release of 1.26.0 during the
week of May 19, 2025**.

---

## Join the Community

CloudNativePG is a **vendor-neutral, open-source** project backed by a vibrant
community of PostgreSQL and Kubernetes enthusiasts. Join us to help shape the
future of cloud-native Postgres!

- [How to connect and contribute](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)

---

Thank you for your continued trust and support.
Together, we’re building the future of **PostgreSQL on Kubernetes**.

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
🚀 Exciting news! CloudNativePG 1.26.0 RC3 is here! Help us test exciting new features like major in-place upgrades, startup and readiness probes for replicas, and declarative extensions management.

LINK

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource

--->
<!--
LinkedIn
Your post is already clear and engaging—great job! Here's a slightly refined version to improve flow, clarity, and impact, while keeping your structure and enthusiasm:

---

🚀 CloudNativePG 1.26.0 RC3 is Here! 🚀

We’re thrilled to announce the third release candidate of CloudNativePG 1.26.0! 🎉

This milestone helps us validate and polish some of the most anticipated features coming in the final release:

🔹 Declarative offline in-place PostgreSQL major upgrades
🔹 Smarter startup and readiness probes for replicas
🔹 Declarative management of extensions and schemas
🔹 The new Barman Cloud Plugin for backup and recovery via object stores

We're calling on the community to test this release in non-production environments and share your feedback. Your input is vital to help us deliver a robust and production-ready final release!

👉 LINK

Let’s build the future of PostgreSQL on Kubernetes—together.

Follow us for updates and join the community to get involved!

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource #ReleaseCandidate #RC3 #CloudNative #DataOps #DevOps
-->
