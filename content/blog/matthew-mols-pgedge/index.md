---
title: "Sticking with Open Source: pgEdge and CloudNativePG"
date: 2025-12-22
draft: false
image:
    url: pgedge_cloudnativepg.jpg
    attribution:
authors:
 - fdrees
tags:
 - helm
 - ImageCatalog
 - CNCF
 - kubernetes
 - postgresql
 - open-source
summary: "We talked to Matthew Mols, Sr. Director of Engineering at pgEdge, about how CloudNativePG enables them to meet the requirements of their customers using just open source." 
---

[Matthew Mols](https://www.linkedin.com/in/mmols/) is the Sr. Director of Engineering at pgEdge, a team of engineers and entrepreneurs on a mission to make it easy to build, deploy and manage enterprise grade applications at scale on Postgres. 

Recently pgEdge announced their [CloudNativePG integration](https://www.postgresql.org/about/news/pgedge-announces-cloudnativepg-integration-simplifying-postgres-on-kubernetes-3166/) and them joining the Cloud Native Computing Foundation (CNCF). 

We had a chance to talk to Matt about their use of CloudNativePG.

## Why CloudNativePG works for pgEdge

Matt loves learning about customers' challenges with using Postgres, and thinking about how they can build or suggest tools and approaches to make their lives easier. "I'm continuously surprised by the different ways folks are leveraging Postgres in their businesses!"

Matt's role is focused on developing tools that enable pgEdge's customers to effectively deploy Postgres, whether that’s on Kubernetes, VMs, bare metal, or in the Cloud. A lot of this work is centered around making it easier to use tools together to meet the requirements of different kinds of customers. 

"We are fully committed to open source and tend to utilize a combination of open source extensions and tools that we've developed and released, like Spock for multi-master (active-active) logical replication, combined with stable community tools like CloudNativePG." 

pgEdge uses CloudNativePG in their [Helm chart](https://docs.pgedge.com/pgedge-containers/), which allows users deploy active-active databases into multiple Kubernetes clusters, and keep them in sync. 

## Getting started with CloudNativePG

Before CloudNativePG, Matt and his team leveraged other operators, and a mix of custom Helm charts that leveraged Kubernetes primitives to deploy Postgres instances. CloudNativePG's popularity and stability, and its acceptance into the CNCF confirmed that it was the right choice to switch to as the default.

"Working with CloudNativePG has been really straightforward for us since we've moved to it exclusively. In particular, the documentation is very well done, with a combination of "start from here" examples, combined with in-depth guides for every feature. Deploying Postgres comes with a lot of choices on specific configuration, and it does a great job of laying out why you would choose from one option or the other, with sensible defaults!"

Access to stable Service endpoints that point to the current primary instance is the thing Matt mentions as "one of the most valuable aspects of deploying a CloudNativePG cluster". Matt: "Outside of Kubernetes there are many tools you need to integrate correctly to give that guarantee to applications and integrations." pgEdge leverages these stable services to enable distributed databases across multiple CloudNativePG clusters in different Kubernetes clusters, while still leveraging automatic failover with standby instances in each region.

In terms of roadmap, Matt is particularly excited about the recent introduction of dynamic loading of PostgreSQL extensions, and some of the upcoming work to extend that to the ImageCatalog CRD. "As Postgres has embraced containerization more and more, this has been a challenging area to navigate, with growing image sizes, dependency management headaches, and adherence to license requirements. In particular, this is going to go a long way towards improving how we manage supply chain risk in the Postgres community!"

## What's next?

Matt looks forward to contributing back to the project in the future. "Our hope is to look to contribute more capabilities that enable distributed deployment with CloudNativePG, potentially as part of supporting the CNPG-I approach to plugins." The goal is to make it easier to operate active-active databases that span across multiple Kubernetes clusters, enabling better support for different types of multi-region deployments. "Our thought is that it's best done through CloudNativePG interfaces."