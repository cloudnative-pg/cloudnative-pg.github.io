---
title: "CloudNativePG 1.23.0, 1.22.3 and 1.21.5 Released!"
date: 2024-04-25T16:04:04+02:00
draft: false
image:
    url: wildlife-zoo-mammal-fauna-elephant-sri-lanka-988769-pxhere.com.jpg
    attribution: from <strong><a href="https://pxhere.com/en/photo/988769?utm_content=clipUser&utm_medium=referral&utm_source=pxhere">PxHere</a></strong>
author: gbartolini
tags:
 - release
 - postgresql
 - postgres
 - kubernetes
 - k8s
 - cloudnativepg
 - pdb
 - imagecatalog
summary: The CloudNativePG community has released the new 1.23 minor version and a new update for the supported 1.22 and 1.21 versions of the CloudNativePG operator.
---
The **CloudNativePG Community** is excited to announce the release of version
1.23.0 of the **CloudNativePG Operator**!

This release brings a host of new features and enhancements, including support
for PostgreSQL image catalogs, synchronization of user-defined replication
slots, and Pod Disruption Budget (PDB) configuration.

We've revised our Community support policy to prioritize one minor release at a
time, enhancing our focus and resources. Furthermore, we've extended the
supplementary support period for the prior minor release to three months.

## What's New in 1.23

PostgreSQL Image Catalogs
:   Say goodbye to PostgreSQL version management headaches! With image catalogs
    based on major versions, managing your database fleet has never been easier.
    Simply request the PostgreSQL major version you need and control how your
    databases stay up-to-date. We've introduced two new resources
    (`ClusterImageCatalog` and `ImageCatalog`) and a new stanza
    (`spec.imageCatalogRef`), setting the stage for simpler management of default images.
    The Community will provide catalogs, and you could also use third-party ones,
    or even build your own.

Synchronization of User-Defined Replication Slots
:   Ensure seamless failover with extended physical replication slot
    synchronization, now covering persistence of user-defined slots after failover.

Pod Disruption Budget (PDB) Configuration
:   Customize PDB settings with the new `.spec.enablePDB` field. Disable PDBs
    on primary instances for single-instance deployments, ensuring smooth pod
    eviction during maintenance operations. This marks our first step towards
    deprecating the node maintenance window feature.

## Upgrade and Maintenance

Before upgrading, carefully review the
[detailed instructions](https://cloudnative-pg.io/documentation/current/installation_upgrade/#upgrading-to-1230-1223-or-1215).
New patch releases are now available for all supported versions, including
1.22.3 and 1.21.5.

We recommend upgrading to CloudNativePG 1.23.0 at your earliest convenience.
Alternatively, update to the latest patch version within your current minor
release.

## End of Life Announcement

With the release of 1.23.0, the 1.21.x minor version will reach its [end of
life](https://cloudnative-pg.io/documentation/1.23/supported_releases/#support-status-of-cloudnativepg-releases)
on May 24, 2024. Plan your upgrade to ensure continued support and
security.

## Join the Community

Become a valued member of our expanding open-source, vendor-neutral, and openly
governed Community! Engage with fellow users, exchange insights, and receive
support! Join our [Slack channel](https://cloudnativepg.slack.com/join/shared_invite/zt-237bhehx3-htDW2kz2hKJxEhn1W4VTnw#/shared-invite/email)
and follow us on [Twitter](https://twitter.com/CloudNativePg) to stay informed
about the latest news and announcements.

## Release Notes

For a comprehensive list of changes and bug fixes, check out the release notes
for:

- [1.23.0](https://cloudnative-pg.io/documentation/1.23/release_notes/v1.23/)
- [1.22.3](https://cloudnative-pg.io/documentation/1.22/release_notes/v1.22/)
- [1.21.5](https://cloudnative-pg.io/documentation/1.21/release_notes/v1.21/)

Thank you for your ongoing support and engagement with CloudNativePG! Upgrade
today and unlock the full potential of your PostgreSQL deployments.

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
Excited to announce the release of #CloudNativePG versions 1.23.0, 1.22.3, and 1.21.5! 🚀 Update now for new features like image catalogs, user-defined replication slots synchronization, and PDB configuration. Enhance usability and squash bugs with the latest upgrade.

Learn more: https://cloudnative-pg.io/blog/cloudnative-pg-1-23.0-released/!

#PostgreSQL #operator #Kubernetes #databases #postgres

--->
