---
title: "CloudNativePG 1.26.0 and 1.25.2 Released!"
date: 2025-05-22
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
summary: The CloudNativePG community is excited to announce version 1.26.0, featuring powerful new capabilities for PostgreSQL on Kubernetes, alongside the maintenance release 1.25.2. This release also includes 1.24.4, the final patch for the now-retired 1.24.x series.
---

The **CloudNativePG Community** is pleased to announce the release of:

- CloudNativePG 1.26.0, featuring major enhancements and new capabilities
- CloudNativePG 1.25.2, a maintenance update for the 1.25.x series
- CloudNativePG 1.24.4, the final patch for the now unsupported 1.24.x series

This is our first release since CloudNativePG officially entered the
[CNCF Sandbox](https://www.cncf.io/sandbox-projects/), a major milestone that
reinforces our commitment to sustainable, community-driven innovation.

---

## What’s New in CloudNativePG 1.26.0?

### Declarative Offline In-Place Major Upgrades of PostgreSQL

You can now declaratively trigger
[offline in-place major upgrades](https://cloudnative-pg.io/documentation/1.26/postgres_upgrades/)
of PostgreSQL by simply updating the container image to a newer major version.
The cluster shuts down safely, and `pg_upgrade` performs the upgrade, ensuring
consistency. This long-awaited feature simplifies major upgrades while
maintaining declarative workflows.

### Enhanced Startup and Readiness Probes for Replicas

We've enhanced [startup and readiness probes](https://cloudnative-pg.io/documentation/1.26/instance_manager/)
for replicas, enabling both startup and readiness to be gated by replication
lag. This means you can restrict promotion to only lag-free, synchronous
replicas—greatly improving your high availability posture.

### Declarative Management of Extensions and Schemas

The `Database` resource now supports the declarative creation of:

- [PostgreSQL extensions](https://cloudnative-pg.io/documentation/1.26/declarative_database_management/#managing-extensions-in-a-database)
- [`SCHEMA` objects](https://cloudnative-pg.io/documentation/1.26/declarative_database_management/#managing-schemas-in-a-database)

This makes it easier to manage consistent database configurations across
environments.

---

## Important Changes

### Barman Cloud Deprecation Begins

With the 1.26 release, the **deprecation period** for in-tree Barman Cloud
support officially begins. While it remains fully functional in 1.26, we
**strongly encourage** users to begin planning the migration to the
[Barman Cloud Plugin](https://cloudnative-pg.io/plugin-barman-cloud/)
as early as possible and to adopt it for all new deployments.
To help with this, we’ve published a comprehensive
[migration guide](https://cloudnative-pg.io/plugin-barman-cloud/docs/migration/).

In CloudNativePG 1.28, Barman Cloud will be fully removed from CloudNativePG’s
core. You have until then to complete your migration.

This marks a significant milestone in CloudNativePG’s evolution—the culmination
of a multi-year effort that introduced CNPG-I, our extensible plugin interface.
It is a crucial step toward making CloudNativePG a backup-agnostic solution
while enabling leaner operand images by removing the need to bundle Barman
Cloud directly. It also paves the way for future plugin support for volume
snapshot backups and restores.

### Declarative Hibernation Support for the Plugin

The `hibernate` command of the plugin now leverages the declarative hibernation
capability. Instead of executing an imperative hibernation process that
destroyed replica PVCs, it will now annotate the cluster, aligning with
CloudNativePG’s declarative approach.

---

## Additional Enhancements in 1.26.0

Explore other improvements in this release, including:

- A new annotation to enable/disable webhook validation.
- A configuration option to set the TCP timeout for replicas, improving
  failover recovery speed.
- Integration with autoscalers like Karpenter for better node drain management.
- Experimental enhancement to the liveness probe to detect network isolation on
  primaries—allowing self-demotion in split-brain scenarios.

Dive into the full details in the
[release notes](https://cloudnative-pg.io/documentation/1.26/release_notes/v1.26/).

---

## Upgrade Guidance

We recommend all users:

- Upgrade to 1.26.0 for the latest features and long-term stability.
- If you're on 1.25.x, upgrade to 1.25.2 to stay up to date with fixes and
  improvements.

Support for the 1.25.x series continues until **22 August 2025**.

Refer to the [upgrade instructions](https://cloudnative-pg.io/documentation/1.26/installation_upgrade/#upgrades)
for a smooth transition.

---

## Get Involved with the Community

CloudNativePG is a **vendor-neutral, open-source** project backed by a vibrant
community of PostgreSQL and Kubernetes enthusiasts.
[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

Thank you for your continued support! Upgrade today and discover how
CloudNativePG can elevate your PostgreSQL experience to new heights.

Join our vibrant community, share your insights, and stay updated on the latest developments by following us and joining our Slack channel.

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource
-->

