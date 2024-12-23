---
title: "CloudNativePG 1.25.0 and 1.24.2 Released!"
date: 2024-12-23
draft: false
author: gbartolini
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
 - preview
 - cnpg
summary: The CloudNativePG community is thrilled to unveil the release of version 1.25.0, packed with exciting new features, along with the maintenance update 1.24.2 for the 1.24.x series.
---

The **CloudNativePG Community** is delighted to announce the release of
**CloudNativePG Operator** versions **1.25.0** and **1.24.2**!

Additionally, we have released **1.23.6** as the final patch for the
now-unsupported 1.23.x series to ensure a smooth transition for remaining
users.

---

## What’s New in CloudNativePG 1.25.0?

Version 1.25.0 introduces groundbreaking features to simplify PostgreSQL
operations and enhance data durability control.

### Major Highlights

- **Declarative Database Management**: Streamline the lifecycle of PostgreSQL
  databases with the new `Database` Custom Resource Definition (CRD).
- **Logical Replication Made Easy**: Manage logical replication with new
  `Publication` and `Subscription` CRDs. Ideal for online migrations, major
  version upgrades, and more.
- **Fine-Tuned Data Durability**: Optimize synchronous replication
  configuration strategies with the `dataDurability` option for a balanced
  approach to data safety and self-healing.

### Introducing CloudNativePG Interface (CNPG-I)

This release marks a pivotal moment for CloudNativePG with the experimental
introduction of [**CNPG-I**](https://github.com/cloudnative-pg/cnpg-i).
This new standard framework enables users to extend CloudNativePG with external
plugins, unlocking vast possibilities for customization.

The [Barman Cloud Plugin](https://github.com/cloudnative-pg/plugin-barman-cloud)
demonstrates CNPG-I's potential, showcasing how backup and recovery plugins can
be developed independently of the operator’s source code. We invite community
feedback and contributions to refine this innovative capability!

For a comprehensive overview, read the
[1.25 release notes](https://cloudnative-pg.io/documentation/1.25/release_notes/v1.25/).

---

## Additional Enhancements in 1.25.0

Explore even more improvements in this release:

- **Enhanced `pg_dump` and `pg_restore` Controls**: Accelerate data migrations
  with object exclusions and parallel processing options.
- **Parallel Reconcilers**: Boost cluster management efficiency through
  parallel operations in the cluster controller.

Check the complete list of changes in the
[release notes](https://cloudnative-pg.io/documentation/1.25/release_notes/v1.25/).

---

## Upgrade Guidance

To ensure a smooth upgrade, please refer to our
[upgrade documentation](https://cloudnative-pg.io/documentation/1.25/installation_upgrade/#upgrades).

We strongly recommend upgrading to **CloudNativePG 1.25.0** for the latest
features and long-term support. For users on the 1.24.x series, update to
**1.24.2** to maintain stability and receive updates. Remember, support for
version 1.24 will continue until **March 23, 2025**.

---

## Get Involved with the Community

Join our vibrant, open-source community to connect with fellow CloudNativePG users, share insights, and get support:

- **Slack**: Engage with us on
  [Slack](https://join.slack.com/t/cloudnativepg/shared_invite/zt-2ij5hagfo-B04EQ9DUlGFzD6GEHDqE0g).
- **Twitter**: Follow
  [@CloudNativePg](https://twitter.com/CloudNativePg) for updates and news.

Thank you for your continued support! Upgrade today and discover how
CloudNativePG can elevate your PostgreSQL experience to new heights.

<!--
# About CloudNativePG

[CloudNativePG](https://cloudnative-pg.io) stands as a groundbreaking
open-source Kubernetes Operator designed explicitly for PostgreSQL workloads.
Seamlessly orchestrating the entire life cycle of a PostgreSQL cluster,
CloudNativePG takes charge from bootstrapping and configuration to ensuring
high availability, connection routing, and comprehensive backup and disaster
recovery mechanisms.
Leveraging PostgreSQL's native streaming replication, CloudNativePG efficiently
distributes data across pods, nodes, and zones, utilizing standard Kubernetes
patterns. This enables seamless scaling of replicas in a Kubernetes-native
manner, with the operator autonomously and safely reconfiguring replication as
needed.
Originally conceived and supported by [EDB](https://www.enterprisedb.com/),
CloudNativePG represents a paradigm shift in managing PostgreSQL workloads
within Kubernetes environments.

-->
<!--
Tweet

-->
<!--
Tweet
🚀 Exciting news! CloudNativePG 1.25.0 is here! Test new features like declarative databases, logical replication publications & subscriptions, and enhanced data durability controls.

LINK

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource

--->
<!--
LinkedIn
🚀 **Exciting News! CloudNativePG 1.25.0 and 1.24.2 Released!** 🚀

The CloudNativePG Community is thrilled to announce the release of CloudNativePG 1.25.0! This release introduces powerful new features, including:

🔹 Declarative Database Management
🔹 Declarative Logical Replication
🔹 Enhanced Data Durability Controls

LINK

Join our vibrant community, share your insights, and stay updated on the latest developments by following us and joining our Slack channel.

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource
-->
