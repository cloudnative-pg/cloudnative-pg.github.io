---
title: "CloudNativePG 1.24.0 RC1 Released!"
date: 2024-07-30T10:12:26+02:00
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
summary: "The CloudNativePG community has released the first release candidate of CloudNativePG 1.24. Help us test new features in preview like distributed PostgreSQL topologies, managed services, enhanced API for synchronous replication, and WAL disk space safeguards."
---
The **CloudNativePG Community** is thrilled to announce the release of the
first candidate for CloudNativePG 1.24! This release candidate showcases all
the features expected in the final version of CloudNativePG 1.24, although some
details may still be refined during this preview phase.

For detailed information on the features and changes in CloudNativePG 1.24,
please refer to the [release notes](https://cloudnative-pg.io/documentation/preview/release_notes/v1.24/).

## Get Involved and Make a Difference!

In true open source spirit, we strongly encourage you to test the new features
of CloudNativePG 1.24 on your systems. Your testing and feedback are crucial in
helping us identify and resolve any bugs or issues. While we do not recommend
using CloudNativePG 1.24 RC1 in production environments, we urge you to
simulate your typical application workloads with this preview release.

Your involvement ensures that the final release of CloudNativePG 1.24 upholds
our high standards of stability and reliability, maintaining its status as one
of the world's most popular open source operators for PostgreSQL in Kubernetes.

For more details on our preview testing process and how you can contribute,
read more [here](https://cloudnative-pg.io/documentation/preview).

---

## CloudNativePG 1.24 Feature Highlights

### Distributed PostgreSQL Topologies

CloudNativePG 1.24 significantly enhances the replica cluster feature, enabling
the creation of distributed database topologies for PostgreSQL across multiple
Kubernetes clusters. This supports hybrid and multi-cloud deployments,
offering:

- **Declarative Primary Control**: Use declarative configuration to easily
  specify which PostgreSQL cluster acts as the primary in a distributed setup.
- **Seamless Switchover**: Demote the current primary and promote a selected
  replica cluster, typically in a different region, without needing to rebuild
  the former primary. This ensures high availability and resilience in diverse
  scenarios.

### Managed Services

CloudNativePG 1.24 introduces managed services through the `managed.services`
stanza, allowing you to:

- Disable the read-only and read services via configuration.
- Leverage the service template capability to create custom service resources,
  including load balancers, to access PostgreSQL outside
  Kubernetes—particularly useful for DBaaS purposes.

### Enhanced API for Synchronous Replication

A more powerful API has been introduced to control the configuration of
PostgreSQL synchronous replication, supporting both quorum-based and priority
list strategies. This update allows full customization of the
`synchronous_standby_names` option, providing greater control and flexibility.

### WAL Disk Space Exhaustion

Version 1.24 includes a critical safety measure to handle WAL disk space
exhaustion. Instead of a potential chain of failovers when PostgreSQL runs out
of disk space for WAL files, the cluster will safely stop. This prevents the
cluster from entering an unrecoverable state and simplifies recovery by
allowing for the manual expansion of the affected volume.

---

## There's More...

Explore the [release notes for 1.24 RC1](https://cloudnative-pg.io/documentation/preview/release_notes/v1.24/)
to discover additional enhancements in CloudNativePG, including declarative
delayed replicas, transparent support for PostgreSQL 17's `allow_alter_system`,
`postInitSQLRefs`, `postInitTemplateSQLRefs`, and numerous observability
improvements.

## Testing

The stability of each CloudNativePG minor version greatly depends on you, the
community. Test the upcoming version with your workloads and tools to identify
bugs and regressions before the general availability of CloudNativePG 1.24.
Your feedback and testing will help validate the new features, so please test
it soon. The quality of user testing helps determine when we can make a final
release.

A list of [open issues for the 1.24 release is publicly available on our GitHub project](https://github.com/cloudnative-pg/cloudnative-pg/issues?q=is%3Aopen+is%3Aissue+milestone%3A1.24.0).
You can report [bugs directly from GitHub](https://github.com/cloudnative-pg/cloudnative-pg/issues/new/choose).

## Preview Release Schedule

This is the first release candidate of CloudNativePG 1.24. The CloudNativePG
maintainers will release additional RC versions as required for testing, until
the final release, currently planned for the end of August 2024.

## Links

- [Documentation for 1.24 RC1](https://cloudnative-pg.io/documentation/preview/)
- [Release notes for 1.24 RC1](https://cloudnative-pg.io/documentation/preview/release_notes/v1.24/)

## Join the Community

Join our vibrant, open-source, vendor-neutral community! [Connect with us](https://github.com/cloudnative-pg/cloudnative-pg?tab=readme-ov-file#communications)!

Stay informed about the latest developments by following us on
[Twitter](https://twitter.com/CloudNativePg).

Thank you for your ongoing support and engagement with CloudNativePG!

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
🚀 Exciting news! CloudNativePG 1.24.0 RC1 is here! Test new features like distributed PostgreSQL topologies, managed services, enhanced API for synchronous replication, and WAL disk space safeguards. Your feedback is crucial!

LINK

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource

--->
<!--
LinkedIn
🚀 **Exciting News! CloudNativePG 1.24.0 RC1 Released!** 🚀

The CloudNativePG Community is thrilled to announce the release of the first candidate for CloudNativePG 1.24! This release candidate introduces powerful new features, including:

🔹 **Distributed PostgreSQL Topologies** for hybrid and multi-cloud deployments
🔹 **Managed Services** for custom service resources and DBaaS
🔹 **Enhanced API for Synchronous Replication**
🔹 **WAL Disk Space Exhaustion Safeguards**

This is our first attempt ever of a preview release.

We invite you to test this preview release and provide feedback to help us ensure a stable and reliable final version. Your input is invaluable!

LINK

Join our vibrant community, share your insights, and stay updated on the latest developments by following us and joining our Slack channel.

#CloudNativePG #PostgreSQL #Kubernetes #OpenSource #ReleaseCandidate
-->
