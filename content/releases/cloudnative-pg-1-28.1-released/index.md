---
title: "CloudNativePG 1.28.1 and 1.27.3 released!"
date: 2026-02-05
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
 - cnpg
summary: The CloudNativePG community has released new updates for the 1.28 and 1.27 versions of the CloudNativePG operator.
---

The **CloudNativePG Community** is pleased to announce the release of
**CloudNativePG Operator** versions 1.28.1 and 1.27.3.

These releases deliver important bug fixes and stability
improvements, ensuring your PostgreSQL clusters continue to run reliably in
production environments.

These releases introduce a few key changes:

- **Azure authentication support:** Support for Azure's `DefaultAzureCredential` 
authentication mechanism for backup and recovery operations.
- **Support for other naming conventions:** Fixed a bug with image volume 
extensions where Postgres extension container images didn't work if the 
extension had underscores in the name.

Among the fixes there was one critical issue where the `TimelineID` in the 
cluster status was not reset to 1 after a major version upgrade. causing 
replicas to attempt to restore incompatible history files from object storage, 
ultimately leading to fatal "requested timeline is not a child of this server's 
history" errors. This often caused replicas to enter an unrecoverable state which 
required manual intervention to recover by recreating the volume.
  
We encourage all users to upgrade to benefit from these enhancements.

Read the full release notes for details:

- [Release notes for 1.28.1](https://github.com/cloudnative-pg/cloudnative-pg/releases/tag/v1.28.1)
- [Release notes for 1.27.3](https://github.com/cloudnative-pg/cloudnative-pg/releases/tag/v1.27.3)

---

## Upgrade guidance

We recommend upgrading to **1.28.1** to benefit from the latest features,
enhancements, and long-term stability.

If you’re on **1.27.x**, upgrade to **1.27.3** to get the latest fixes in that
series. 

Follow the [upgrade instructions](https://cloudnative-pg.io/documentation/1.27/installation_upgrade/#upgrades)
for a smooth transition.

---

## Get involved with the community

[Join us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)
to help shape the future of cloud-native Postgres!

If you're using CloudNativePG in production, consider
[adding your organisation as an adopter](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/ADOPTERS.md)
to support the project's growth and evolution.

Thank you for your continued support and for being part of the CloudNativePG community!
