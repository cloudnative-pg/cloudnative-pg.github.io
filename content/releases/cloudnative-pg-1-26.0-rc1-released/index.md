---
title: "CloudNativePG 1.26.0 RC1 Released!"
date: 2025-03-28T11:03:23+01:00
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
summary: "The CloudNativePG community is excited to announce the first release candidate of CloudNativePG 1.26! This preview introduces features like declarative offline in-place major upgrades of PostgreSQL, startup and readiness probes for replicas, declarative management of extensions and schemas, and more. Join us in testing these updates to shape the final release."
---


The **CloudNativePG Community** is thrilled to announce the first release
candidate of CloudNativePG 1.26! This preview release provides an opportunity
to explore new features and enhancements before the final version is officially
launched. While refinements may still occur, here’s a look at what’s new.

## Key Features

### Declarative Offline In-Place Major Upgrades of PostgreSQL

You can now trigger an offline in-place major upgrade by specifying a new
operand container image with a higher PostgreSQL major version in a cluster,
either directly or via image catalogs. During the upgrade, the cluster is shut
down to ensure data consistency, and a `pg_upgrade` job performs the migration.
This long-awaited feature simplifies major upgrades while maintaining
reliability.

### Enhanced Startup and Readiness Probes for Replicas

We have improved Kubernetes startup and readiness probes for PostgreSQL
instances, introducing a unique capability: the readiness of a replica can now
be controlled based on its lag from the primary. For example, this allows you
to ensure that only synchronous replicas with no lag are considered ready for
promotion, improving high availability management.

### Declarative Management of Extensions and Schemas

The `Database` resource now supports ensuring the presence of one or more
extensions in a database and managing their versions. Additionally, you can
declaratively define the existence of `SCHEMA` objects within a PostgreSQL
database.

## Important Changes

Starting with this version, we are deprecating native support for Barman Cloud
on object stores. But don't worry—we've got you covered! We provide clear
instructions on how to seamlessly migrate your existing clusters to the new
[Barman Cloud Plugin](https://github.com/cloudnative-pg/plugin-barman-cloud).
A new resource, `BarmanObjectStore`, will replace the `.spec.barmanObjectStore`
stanza, incorporating the `.spec.backup.retentionPolicy` option.

In CloudNativePG 1.28, Barman Cloud will be fully removed from CloudNativePG’s
core, making the plugin the only community-supported method for continuous
backup on object stores. You have until then to complete your migration.

This marks a significant milestone in CloudNativePG’s evolution—the culmination
of a multi-year effort that introduced CNPG-I, our extensible plugin interface.
It is a crucial step toward making CloudNativePG a backup-agnostic solution
while also enabling leaner operand images by removing the need to bundle Barman
Cloud directly.

Additionally, in version 1.26, the `hibernate` command of the plugin now
leverages the declarative hibernation capability. Instead of executing an
imperative hibernation process that destroyed replica PVCs, it will now
annotate the cluster, aligning with CloudNativePG’s declarative approach.

## Get Involved and Make a Difference!

This release candidate offers a unique opportunity to test the new features in your
environment before the final release. Although **not recommended for production
use**, simulating your workloads can help uncover potential issues and validate
feature stability.

Your feedback is vital to ensuring that CloudNativePG 1.26 maintains its
reputation as the premier Kubernetes operator for PostgreSQL.

[Learn more about testing and contributing](https://cloudnative-pg.io/documentation/preview)!

## There's More...

Explore other improvements in this release, including:

- A new annotation to enable/disable webhook validation.
- A configuration option to set the TCP timeout for replicas, improving
  failover recovery speed.
- Integration with autoscalers like Karpenter for better node drain management.

Dive into the full details in the
[release notes for 1.26 RC1](https://cloudnative-pg.io/documentation/preview/release_notes/v1.26/).

## Testing

The stability of each CloudNativePG release relies on the community’s
engagement. Testing your workloads with this release candidate helps identify
bugs and regressions early.

- View the [open issues for the 1.26 release](https://github.com/cloudnative-pg/cloudnative-pg/milestone/25).
- Report bugs directly on [GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Release Timeline

CloudNativePG 1.26 RC1 is the first in a series of release candidates.
Additional RCs may follow as needed before the final release, currently planned
in the second half of April 2025.

## Join the Community

Join our vibrant, open-source, vendor-neutral community! [Connect with us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)!

Thank you for your continued support of CloudNativePG. Your contributions help
us advance the Kubernetes-native PostgreSQL experience!

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
[EDB](https://www.enterprisedb.com/), CloudNativePG is a CNCF Sandbox project
and the sole PostgreSQL operator in this category.

-->
<!--
Tweet
🚀 Exciting news! CloudNativePG 1.26.0 RC1 is here! Test new features like major in-place upgrades, startup and readiness probes for replicas, and declarative extensions management.

LINK

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource

--->
<!--
LinkedIn
🚀 **Exciting News! CloudNativePG 1.26.0 RC1 Released!** 🚀

The CloudNativePG Community is thrilled to announce the release of the first candidate for CloudNativePG 1.25! This release candidate introduces powerful new features, including:

🔹 Declarative Offline In-Place Major Upgrades of PostgreSQL
🔹 Enhanced Startup and Readiness Probes for Replicas
🔹 Declarative Management of Extensions and Schemas

We invite you to test this preview release and share your feedback to help us deliver a stable, reliable final version. Your input is invaluable to the open-source community!

LINK

Join our vibrant community, share your insights, and stay updated on the latest developments by following us and joining our Slack channel.

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource #ReleaseCandidate
-->
