---
title: "CloudNativePG 1.30.2 released"
date: 2026-11-17
draft: false
authors:
 - gbartolini
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
  - cve
  - backup
  - replication
summary: "CloudNativePG 1.30.2 is now available, with PostgreSQL 18.7 as the new default image, the end of support for PostgreSQL 14, and a set of fixes that make replicas, plugins and switchovers more robust. Upgrading is recommended."
---

The CloudNativePG community is releasing **CloudNativePG 1.30.2**, a
maintenance update for the 1.30 series and the first release since the project
[became a CNCF Incubating project](https://www.cncf.io/blog/2026/11/10/cloudnativepg-becomes-a-cncf-incubating-project/).

We had planned to ship these fixes together with 1.31.0. Given the security
relevance of the PostgreSQL 18.7 release, though, we decided to make an
exception and release 1.30.2 on its own, ahead of the new minor version.

Three changes are worth knowing about before you upgrade to 1.30.2:

- **PostgreSQL 18.7 is the new default image** (`18.7-system-trixie`), which
  fixes several CVEs
  ([#11833](https://github.com/cloudnative-pg/cloudnative-pg/pull/11833)). It
  only applies to *new* clusters that don't set an image. To get the fixes on
  existing clusters, update them to 18.7, 17.12, 16.16 or 15.20 by changing
  `imageName` or the `ImageCatalog`, after reading the
  [PostgreSQL 18.7 announcement](https://www.postgresql.org/about/news/postgresql-187-1712-1616-1520-1425-and-19-rc-2-released-3442/).
- **PostgreSQL 14 is no longer supported.** The PostgreSQL community stopped
  fixing it on November 12, 2026, and CloudNativePG supports a major version
  only as long as PostgreSQL does. If you still run PostgreSQL 14, plan an
  upgrade to a newer major version
  ([#11935](https://github.com/cloudnative-pg/cloudnative-pg/pull/11935)).
- **The operator now needs the `delete` permission on `leases`.** If you
  manage RBAC manually, you must add it
  ([#11609](https://github.com/cloudnative-pg/cloudnative-pg/pull/11609)).

The release also improves the robustness of replicas and switchovers. Standbys
that stay on the WAL archive can now retry streaming replication, so they no
longer miss out on synchronous replication
([#11868](https://github.com/cloudnative-pg/cloudnative-pg/pull/11868)), and
replicas created from an online volume snapshot now honor the `backup_label`
and `tablespace_map` stored in it
([#11847](https://github.com/cloudnative-pg/cloudnative-pg/pull/11847)).
S3-compatible object stores gain support for server-side encryption with
customer-provided keys (SSE-C) through the new `sseCustomerKey` field
([#11711](https://github.com/cloudnative-pg/cloudnative-pg/pull/11711)).
There are also several other fixes and dependency updates for Go
vulnerabilities, all listed in the release notes below.

---

## Upgrade

Follow the [upgrade instructions](https://cloudnative-pg.io/docs/1.30/installation_upgrade/#upgrades)
to upgrade your clusters.

For the complete list of changes, see the release notes:

- [Release notes for 1.30.2](https://cloudnative-pg.io/docs/1.30/release_notes/v1.30/#version-1302)

---

## Get involved with the community

[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

CloudNativePG is now a **CNCF Incubating project**. Read the
[CNCF announcement](https://www.cncf.io/blog/2026/11/10/cloudnativepg-becomes-a-cncf-incubating-project/)
to learn more. This milestone follows the evolution of our
[governance model](https://github.com/cloudnative-pg/governance/blob/main/GOVERNANCE.md)
and our [contributor ladder](https://github.com/cloudnative-pg/governance/blob/main/CONTRIBUTOR_LADDER.md),
and it belongs to everyone in the community who contributed along the way.

If you're using CloudNativePG in production, consider
[adding your organization as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project.

We'd also like to thank everyone who contributed a pull request to this
release, in particular [@kabbydriver](https://github.com/kabbydriver),
[@ichibahn](https://github.com/ichibahn),
[@ardentperf](https://github.com/ardentperf) and
[@valeriodelsarto](https://github.com/valeriodelsarto). The number of
community contributions keeps growing, which is great to see.

Thank you for your continued support!

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
[EDB](https://www.enterprisedb.com/), CloudNativePG is a CNCF Incubating
project.
-->
