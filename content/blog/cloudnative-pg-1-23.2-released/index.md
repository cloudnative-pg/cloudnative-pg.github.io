---
title: "CloudNativePG 1.23.2, 1.22.4 and 1.21.6 Released!"
date: 2024-06-12T23:49:11+02:00
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
summary: The CloudNativePG community has released a new update for the supported 1.23, 1.22 and 1.21 versions of the CloudNativePG operator. Version 1.21 has reached End-of-Life (EOL).
---
The **CloudNativePG Community** is thrilled to announce a new update for the
**CloudNativePG Operator**, now available for the supported versions 1.23,
1.22, and 1.21.

Thanks to comprehensive refactoring and enhancement activities, we've
significantly improved the reliability of our automated End-to-End (E2E) tests.
With contributions from [EDB](https://enterprisedb.com), we've tested the
operator on all major cloud providers, identified several defects, and resolved
them in these new releases, ensuring a more stable and resilient software.

**Versions 1.23.2, 1.22.4, and 1.21.6** are patch releases that contain crucial
bug fixes, addressing issues such as:

- Unnecessary reloads and shutdowns of PostgreSQL
- Excessive CPU usage due to unnecessary loops
- The primary instance manager hanging indefinitely after a stop and subsequent
  failure
- Autovacuum not working correctly due to an issue between
  `hot_standby_feedback` and our managed cluster-level replication slots
  implementation
- `pgaudit.log_rows` not functioning as intended

With this update, version 1.21 has reached End-of-Life (EOL). Version 1.21.6
marks the final release for the 1.21 minor version.

We highly recommend updating the operator at your earliest convenience to
benefit from these improvements and bug fixes.

For a detailed list of changes, please refer to the release notes:

- [Release notes for 1.23.2](https://cloudnative-pg.io/documentation/1.23/release_notes/v1.23/)
- [Release notes for 1.22.4](https://cloudnative-pg.io/documentation/1.22/release_notes/v1.22/)
- [Release notes for 1.21.6](https://cloudnative-pg.io/documentation/1.21/release_notes/v1.21/)

Additionally, we are pleased to announce that macOS users can now install the
`cnpg` plugin for `kubectl` via Homebrew with the command: `brew install
kubectl-cnpg`.

Thank you for your continued support. We look forward to your seamless
experience with the updated CloudNativePG Operator.
If you are using it in production, please consider
[adding your organization as an adopter of the project](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md).

Your support helps us grow and improve!

<!--
# About CloudNativePG

[CloudNativePG](https://cloudnative-pg.io) stands as a groundbreaking
open-source Kubernetes Operator designed explicitly for PostgreSQL workloads.
Seamlessly orchestrating the entire life cycle of a PostgreSQL cluster,
CloudNativePG takes charge from bootstrapping and configuration to ensuring
high availability, connection routing, and comprehensive backup and disaster
recovery mechanisms.
Leveraging PostgreSQL's native streaming replication, CloudNativePG efficiently
distributes data across pods, nodes, and zones, using standard Kubernetes
patterns. This enables seamless scaling of replicas in a Kubernetes-native
manner, with the operator autonomously and safely reconfiguring replication as
needed.
Originally conceived and supported by [EDB](https://www.enterprisedb.com/),
CloudNativePG represents a paradigm shift in managing PostgreSQL workloads
within Kubernetes environments.

-->
<!--
Tweet
Excited to announce the release of #CloudNativePG versions 1.23.2, 1.22.4, and 1.21.6! 🚀

Update now for better stability and resilience. Check out the enhancements and changes!

Learn more: https://cloudnative-pg.io/blog/cloudnative-pg-1-23.2-released/!

#PostgreSQL #operator #Kubernetes #databases #postgres

--->
