---
title: "CloudNativePG 1.29.0 RC1 Released!"
date: 2026-03-13
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
 - preview
 - cnpg
 - ServiceAccount
 - security
 - networking
 - ImageCatalogs
 - extensions
 - artifacts
 - podSelectorRefs
summary: "The CloudNativePG community is excited to announce the first release candidate of CloudNativePG 1.29! This preview revolutionizes extension management through Image Catalogs and the new artifacts ecosystem. Join us in testing these updates to shape the final release."
---

The CloudNativePG Community is thrilled to announce the first release candidate
of CloudNativePG 1.29! This preview release provides an opportunity to explore
new features and enhancements before the final version is officially launched.
While refinements may still occur, here’s a look at what’s new.

## Key Features

### PostgreSQL Extensions Ecosystem and Image Catalogs

The most significant architectural advancement in 1.29 is the integration of
[Image Catalogs](https://cloudnative-pg.io/docs/1.29/image_catalog#image-catalog-with-image-volume-extensions)
with a new dedicated ecosystem for PostgreSQL extensions. By leveraging the
[`postgres-extensions-containers`](https://github.com/cloudnative-pg/postgres-extensions-containers)
project and its [official extension images and catalogs](https://cloudnative-pg.io/docs/1.29/imagevolume_extensions#official-extension-images-and-catalogs),
CloudNativePG now provides a structured way to distribute and manage
extension-specific images.

This feature allows you to define these extensions within a catalog, ensuring
that the database engine and its modules are version-aligned, secure, and
treated as a single cohesive unit. This approach centralizes your image supply
chain and removes the need for users to manually build and maintain complex
custom PostgreSQL images.

### Dynamic Network Access Control via Pod Selectors

We’ve introduced a major enhancement to how PostgreSQL network security is
handled in Kubernetes. By using the new
[`podSelectorRefs`](https://cloudnative-pg.io/docs/1.29/postgresql_conf/#dynamic-address-resolution-with-podselectorrefs)
field, you can now
define `pg_hba.conf` rules that dynamically resolve the IP addresses of client
pods based on label selectors. This ensures that only authorized workloads in
the same namespace can connect to your database, eliminating the need for
manual IP management or static CIDR ranges.

### Shared ServiceAccount Support

CloudNativePG now supports referencing a pre-existing
[`ServiceAccount`](https://cloudnative-pg.io/docs/1.29/security/#using-a-shared-serviceaccount)
in `Cluster` and `Pooler` resources. This enables a more streamlined integration
with cloud provider IAM services, such as AWS IRSA, GCP Workload Identity, and
Azure Workload Identity.

## There’s More…

Explore other improvements in this release, including:

- Added granular configuration for TLS cipher suites and versions for PgBouncer.
- Improved reliability by automatically cleaning up failed `pg_upgrade` jobs when an image is reverted.

Dive into the full details in the
[release notes for 1.29 RC1](https://cloudnative-pg.io/docs/1.29/release_notes/v1.29/).

## Testing

The stability of each CloudNativePG release relies on the community’s
engagement. Testing your workloads with this release candidate helps
identify bugs and regressions early.

- View the [open issues for the 1.29 release](https://github.com/cloudnative-pg/cloudnative-pg/milestone/33).
- Report bugs directly on [GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Release Timeline

CloudNativePG 1.29 RC1 is the first in a series of release candidates.
Additional release candidates may follow as needed before the final release,
currently planned for the end of March.

## Join the Community

[Connect with our community on your preferred platform](https://github.com/cloudnative-pg#getting-in-touch)!

Thank you for your continued support of CloudNativePG. Your contributions help
us advance the Kubernetes-native PostgreSQL experience.
