---
title: "CloudNativePG 1.24.1 and 1.23.5 Released!"
date: 2024-10-16T12:27:58+02:00
draft: false
image:
    url: 58364dde1adc4a0a8.37186404-2048x1445.jpg
    attribution: from <a href="https://wordpress.org/photos/photo/58364dde1a/">Saurabh</a>
author: gbartolini
tags:
 - release
 - postgresql
 - postgres
 - kubernetes
 - k8s
 - cloudnativepg
summary: The CloudNativePG community has released new updates for the 1.24 and 1.23 versions of the CloudNativePG operator.
---

The **CloudNativePG Community** is excited to announce the release of updates
for the **CloudNativePG Operator**, now available in versions 1.24.1 and
1.23.5.

These patch releases bring key bug fixes and enhancements, including the
default deployment of PostgreSQL 17 and the addition of the `logs pretty`
command in the `cnpg` plugin, which provides a human-readable format for log
streams and filtering options for more efficient troubleshooting.

For more details, please review the full release notes:

- [Release notes for 1.24.1](https://cloudnative-pg.io/documentation/1.24/release_notes/v1.24/)
- [Release notes for 1.23.5](https://cloudnative-pg.io/documentation/1.23/release_notes/v1.23/)

We highly recommend updating the operator to take advantage of these
improvements. 

Thank you for your continued support. If you're using CloudNativePG in
production, consider [adding your organization as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to help the project grow and evolve.

Your support is greatly appreciated!

---

## Upgrade and Maintenance

Before upgrading, please review the [upgrade instructions](https://cloudnative-pg.io/documentation/1.24/installation_upgrade/#upgrading-to-124-from-a-previous-minor-version)
carefully.

We strongly recommend upgrading to version 1.24.1 as soon as possible. For
users remaining on version 1.23, be sure to update to 1.23.5 for continued
stability and support.
Note that 1.23 will be supported until **November 22, 2024**.

---

## Join the Community

Join our vibrant, open-source, vendor-neutral community! [Connect with us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)!

Stay informed about the latest developments by following us on
[Twitter](https://twitter.com/CloudNativePg).

Thank you for supporting CloudNativePG. Upgrade today to unlock the full
potential of your PostgreSQL clusters!

<!--
## About CloudNativePG

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

🚀 Exciting news! #CloudNativePG versions 1.24.1 and 1.23.5 are out now! 🚀

Upgrade today for enhanced stability, improved performance, and new features like the `logs pretty` command! 

Learn more and update here: https://cloudnative-pg.io/blog/cloudnative-pg-1-24.1-released/!

#PostgreSQL #Kubernetes #databases #operator #CNPG #k8s #postgres

--->
