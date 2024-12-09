---
title: "CloudNativePG 1.25.0 RC1 Released!"
date: 2024-12-09T09:00:00+01:00
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
summary: "The CloudNativePG community is excited to announce the first release candidate of CloudNativePG 1.25! This preview introduces features like declarative databases, logical replication publications and subscriptions, enhanced control over data durability in synchronous replication, and more. Join us in testing these updates to shape the final release."
---

The **CloudNativePG Community** is proud to unveil the first release candidate
of CloudNativePG 1.25! This release provides an opportunity to explore the
exciting features and enhancements slated for the final version. While some
refinements may still occur during this phase, here’s a glimpse of what’s new:

- **Declarative Database Management:** Simplify PostgreSQL database lifecycle
  management with the new `Database` Custom Resource Definition (CRD).

- **Declarative Logical Replication:** Use the new `Publication` and
  `Subscription` CRDs to manage logical replication, enabling tasks like online
   migrations, major version upgrades, and more, all through a declarative
   approach.

- **Enhanced Data Durability Controls:** Fine-tune your synchronous replication
  strategy with the `dataDurability` option, balancing data safety and
  self-healing capabilities.

For a complete overview of features and updates, see the [release
notes](https://cloudnative-pg.io/documentation/preview/release_notes/v1.25/).

## Get Involved and Make a Difference!

This release candidate offers a unique opportunity to test the new features in your
environment before the final release. Although **not recommended for production
use**, simulating your workloads can help uncover potential issues and validate
feature stability.

Your feedback is vital to ensuring that CloudNativePG 1.25 maintains its
reputation as the premier Kubernetes operator for PostgreSQL.

Learn more about testing and contributing
[here](https://cloudnative-pg.io/documentation/preview).

## There's More...

Explore other improvements in this release, including:

- Enhanced `pg_dump` and `pg_restore` Control: Streamline import phases by
  excluding specific objects or using parallel operations for faster data
  transfers.
- Parallel Reconcilers: Increase efficiency through parallel processing in the
  cluster controller.

Dive into the full details in the
[release notes for 1.25 RC1](https://cloudnative-pg.io/documentation/preview/release_notes/v1.25/).

## Testing

The stability of each CloudNativePG release relies on the community’s
engagement. Testing your workloads with this release candidate helps identify
bugs and regressions early.

- View the [open issues for the 1.25 release](https://github.com/cloudnative-pg/cloudnative-pg/milestone/24).
- Report bugs directly on [GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Release Timeline

CloudNativePG 1.25 RC1 is the first in a series of release candidates.
Additional RCs may follow as needed before the final release, planned in December 2024.

## Join the Community

Join our vibrant, open-source, vendor-neutral community! Connect with us on:

- [Slack](https://join.slack.com/t/cloudnativepg/shared_invite/zt-237bhehx3-htDW2kz2hKJxEhn1W4VTnw) for discussions and support.
- [Twitter](https://twitter.com/CloudNativePg) for the latest updates and
  announcements.

Thank you for your continued support of CloudNativePG. Your contributions help
us advance the Kubernetes-native PostgreSQL experience!

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
🚀 Exciting news! CloudNativePG 1.25.0 RC1 is here! Test new features like declarative databases, logical replication publications & subscriptions, and enhanced data durability controls.

LINK

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource

--->
<!--
LinkedIn
🚀 **Exciting News! CloudNativePG 1.25.0 RC1 Released!** 🚀

The CloudNativePG Community is thrilled to announce the release of the first candidate for CloudNativePG 1.25! This release candidate introduces powerful new features, including:

🔹 Declarative Database Management
🔹 Declarative Logical Replication
🔹 Enhanced Data Durability Controls

We invite you to test this preview release and share your feedback to help us deliver a stable, reliable final version. Your input is invaluable to the open-source community!

LINK

Join our vibrant community, share your insights, and stay updated on the latest developments by following us and joining our Slack channel.

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource #ReleaseCandidate
-->
