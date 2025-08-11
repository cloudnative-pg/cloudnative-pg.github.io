---
title: "CloudNativePG 1.27.0 Released!"
date: 2025-08-12
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
 - cnpg
summary: The CloudNativePG community is excited to announce version 1.27.0, featuring powerful new capabilities for PostgreSQL on Kubernetes.
---

The **CloudNativePG Community** is excited to announce the release of
**CloudNativePG 1.27.0**, bringing powerful new features, stability
improvements, and extended capabilities for running PostgreSQL in Kubernetes.

---

## Highlights in 1.27.0

### Dynamic Loading of PostgreSQL Extensions

You can now use the new `.spec.postgresql.extensions` field to mount PostgreSQL
extensions—packaged as OCI-compliant container images—as **read-only, immutable
volumes** in instance pods.
This enables [dynamic extension management](/documentation/1.27/imagevolume_extensions/)
without rebuilding base images, offering faster, more flexible extension
deployments.

### Logical Decoding Slot Synchronization

A new `synchronizeLogicalDecoding` option under
`spec.replicationSlots.highAvailability` introduces
[automatic synchronization of logical decoding slots](/documentation/1.27/replication/#logical-decoding-slot-synchronization)
across high-availability clusters. This ensures that logical replication
subscribers can continue seamlessly after a publisher failover, **improving
reliability and integration with Change Data Capture (CDC) tools**.

### Primary Isolation Check — Now Stable

The **liveness pinger**, introduced experimentally in 1.26, is now a stable
feature.  With `.spec.probes.liveness.isolationCheck` enabled by default, the
liveness probe now performs
[primary isolation checks](/documentation/1.27/instance_manager/#primary-isolation)
to improve detection and handling of primary connectivity issues in Kubernetes
environments.

---

## Other Enhancements

This release also includes:

- **Quorum-based failover** *(experimental)* — an opt-in feature that improves
  safety and data durability during failover events through synchronous replication.
  [Learn more](/documentation/1.27/failover/#failover-quorum-quorum-based-failover).
- **User maps for predefined users** — including `streaming_replica`, enabling
  the use of self-managed client certificates with different Common Names in
  environments with strict security policies or shared certificate authorities.
- **Improved plugin failure observability** — with a new `PhaseFailurePlugin`
  phase in `Cluster status` to better track plugin-related errors.

Full details are available in the
[release notes](https://cloudnative-pg.io/documentation/1.27/release_notes/v1.27/).

---

## Upgrade Guidance

We recommend upgrading to **1.27.0** to benefit from the latest features,
enhancements, and long-term stability.

If you’re on **1.26.x**, upgrade to **1.26.1** to get the latest fixes in that series.

Support for the **1.25.x** series ends on **22 August 2025** — plan your
migration to 1.27 or 1.26 soon.

Follow the [upgrade instructions](https://cloudnative-pg.io/documentation/1.27/installation_upgrade/#upgrades)
for a smooth transition.

---

## Get Involved with the Community

CloudNativePG is a **vendor-neutral, open-source** project backed by a vibrant
community of PostgreSQL and Kubernetes enthusiasts.
[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

Thank you for your continued support! Upgrade today and discover how
CloudNativePG can elevate your PostgreSQL experience to new heights.

Join our vibrant community, share your insights, and stay updated on the latest
developments by following us and joining our Slack channel.
