---
title: "CloudNativePG 1.25.1 and 1.24.3 Released!"
date: 2025-02-28T21:53:07+01:00
draft: false
image:
    url: pexels-chris-clark-1933184-16116726.jpg
    attribution: from <a href="https://www.pexels.com/photo/large-elephant-on-grassland-16116726/">Chris Clark</a>
author: gbartolini
tags:
 - release
 - postgresql
 - postgres
 - kubernetes
 - k8s
 - cloudnativepg
summary: The CloudNativePG community has released new updates for the 1.25 and 1.24 versions of the CloudNativePG operator.
---

The **CloudNativePG Community** is pleased to announce the release of the
**CloudNativePG Operator** versions 1.25.1 and 1.24.3. Notably, this is our
first release since joining the CNCF Sandbox.

Key Updates in this release:

- **Operator Startup Probe:** Enhanced reliability during initialization by
  introducing a startup probe to prevent premature liveness probe failures.

- **Security Enhancements:** Strengthened the operator image build process by
  signing images with `cosign`, generating OCI attestations that include
  Software Bill of Materials (SBOM) and provenance data, and adding OCI
  annotations for improved traceability and integrity.

- **Backup Reliability Fixes:** Resolved several race conditions affecting
  volume snapshot backups, improving backup stability and consistency.

For comprehensive details, please refer to the full release notes:

- [Release notes for 1.25.1](https://cloudnative-pg.io/documentation/1.25/release_notes/v1.25/)
- [Release notes for 1.24.3](https://cloudnative-pg.io/documentation/1.24/release_notes/v1.24/)

Thank you for your continued support. Upgrade today to fully harness the
capabilities of your PostgreSQL clusters!

---

## Upgrade Recommendations

- **Version 1.25.1:** We strongly recommend upgrading to this version promptly
  to benefit from the latest improvements.

- **Version 1.24.3:** For users on version 1.24, updating to 1.24.3 is
  essential for continued stability and support. Please note that support for
  version 1.24 will conclude on **March 23, 2025**.

Before proceeding with the upgrade, ensure you review the
[upgrade instructions](https://cloudnative-pg.io/documentation/1.25/installation_upgrade/#upgrading-to-125-from-a-previous-minor-version)
carefully.

---

## Join Our Community

We invite you to become an active member of our open-source, vendor-neutral
community. Connect with us through our
[Slack channel](https://join.slack.com/t/cloudnativepg/shared_invite/zt-30a6l6bp3-u1lNAmh~N02Cfiv2utKTFg)
and stay informed about the latest developments by following us on
[Twitter](https://twitter.com/CloudNativePg).

If you're using CloudNativePG in production, consider
[adding your organization as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project's growth and evolution.

<!--
## About CloudNativePG

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

🚀 CloudNativePG 1.25.1 & 1.24.3 are out!

Our first release as a CNCF Sandbox project brings key fixes, security
improvements, and better backup reliability. Upgrade now! 🔄

🔗 Release notes: https://cloudnative-pg.io/documentation/1.25/release_notes/v1.25/

#PostgreSQL #Kubernetes #CloudNativePG

--->
