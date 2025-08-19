---
title: "CloudNativePG 1.27.0 RC1 Released!"
date: 2025-07-29
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
 - preview
 - cnpg
 - extensions
 - ImageVolume
 - FailoverQuorum
summary: "The CloudNativePG community is excited to announce the first release candidate of CloudNativePG 1.27! This preview introduces features like the dynamic loading of PostgreSQL extensions, and the automatic synchronization of logical decoding slots across high-availability clusters. Join us in testing these updates to shape the final release."
---

The CloudNativePG Community is thrilled to announce the first release candidate 
of CloudNativePG 1.27! This preview release provides an opportunity to explore 
new features and enhancements before the final version is officially launched. 
While refinements may still occur, here’s a look at what’s new.

## Key Features

### Dynamic loading of PostgreSQL extensions 

We introduced the `.spec.postgresql.extensions` field to support mounting 
PostgreSQL extensions—packaged as OCI-compliant container images—as read-only, 
immutable volumes within instance pods. This enables [dynamic extension management](/documentation/preview/imagevolume_extensions/)
without the need to rebuild base images.

### Logical decoding slot synchronization 

We added the `synchronizeLogicalDecoding` field under 
`spec.replicationSlots.highAvailability` to enable
[automatic synchronization of logical decoding slots](/documentation/preview/replication/#logical-decoding-slot-synchronization)
across high-availability clusters. This ensures seamless continuity for logical
replication subscribers after a publisher failover.

### Primary Isolation Check 

The liveness pinger, introduced as an experimental feature in 1.26, has 
been promoted to stable. A new `.spec.probes.liveness.isolationCheck` section 
enables [primary isolation checks in the liveness probe](/documentation/preview/instance_manager/#primary-isolation)
by default, improving detection and handling of primary connectivity issues in
Kubernetes environments.

## There’s More…

Explore other improvements in this release, including:

- An opt-in, experimental feature that enables [quorum-based failover](/documentation/preview/failover/#failover-quorum-quorum-based-failover)
  to improve safety and data durability during failover events.
- Added support for user maps for predefined users such as `streaming_replica`, 
  allowing the use of self-managed client certificates with different Common Names 
  in environments with strict policies or shared CAs.
- Added a new `PhaseFailurePlugin` phase in the `Cluster status` to improve 
  observability of plugin-related failures.

Dive into the full details in the
[release notes for 1.27 RC1](https://cloudnative-pg.io/documentation/preview/release_notes/v1.27/).

## Testing

The stability of each CloudNativePG release relies on the community’s 
engagement. Testing your workloads with this release candidate helps 
identify bugs and regressions early.

- View the [open issues for the 1.27 release](https://github.com/cloudnative-pg/cloudnative-pg/milestone/28).
- Report bugs directly on [GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Release Timeline

CloudNativePG 1.27 RC1 is the first in a series of release candidates. 
Additional release candidates may follow as needed before the final release, 
currently planned for the end of August.

# Join the Community

[Connect with our community on your preferred platform](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)!

Thank you for your continued support of CloudNativePG. Your contributions help 
us advance the Kubernetes-native PostgreSQL experience.
