---
title: "Running PostgreSQL the Kubernetes Way"
date: 2022-05-11T14:13:20+02:00
draft: false
image:
    url: 30385097358_6728a49544_c.jpg
    attribution: Photo by <a href="https://www.flickr.com/photos/21186555@N07/30385097358" target="_blank" rel="noopener noreferrer">"African Sunrise, Amboseli National Park"</a> by <a href="https://www.flickr.com/photos/21186555@N07" target="_blank" rel="noopener noreferrer">Ray in Manila</a>
author: gbartolini
tags:
 - blog
 - postgresql
 - postgres
 - kubernetes
 - k8s
 - cloudnativepg
 - operator
 - failover
 - cncf
summary: Welcome CloudNativePG as a new open source operator that orchestrates PostgreSQL clusters inside Kubernetes!
---

CloudNativePG is now a public open source project, distributed under the
Apache License 2.0, owned and [governed by a newly formed
community](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/GOVERNANCE.md)
of contributors to the project, founded on solid principles and values
inspired by the [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/).

Our goal as a community is to enable students, end users, vendors, and
organizations all over the world to run PostgreSQL workloads in
Kubernetes, alongside applications.

We've made the first step: we set the foundations for a prosperous and
healthy community and committed ourselves to go through the CNCF
graduation process, having officially submitted our request to join the
Sandbox - the first PostgreSQL project to ever do so.

The next step is yours. If you love PostgreSQL and Kubernetes like us,
join this community, and contribute at all levels. Read the code of
conduct and the
[CONTRIBUTING](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/CONTRIBUTING.md)
section to start with, or, if you want to contribute to the source code, read
the [developer's contribution guide](https://github.com/cloudnative-pg/cloudnative-pg/blob/main/contribute/README.md).

The source code for CloudNativePG is available in GitHub at
[github.com/cloudnative-pg/cloudnative-pg](https://github.com/cloudnative-pg/cloudnative-pg).

The first available version of CloudNativePG is 1.15.0, not 1.0, as the project
is derived from EDB Cloud Native Postgres, a product that's been widely
deployed in production over the past one and a half years. For this reason, the
repository contains a history of over 1400 commits.

CloudNativePG is designed with Kubernetes in mind and it is entirely
declarative, following the convention over configuration paradigm. As a
result, you can easily install CloudNativePG 1.15.0 in your Kubernetes cluster
(even with `kind` on your local machine) with:

```shell
kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/releases/cnpg-1.15.0.yaml
```

Once the operator is deployed with the `cnpg-controller-manager` name in
the `cnpg-system` namespace, you can now create your PostgreSQL cluster with a
primary instance and two read replicas, each with 1GB volume from the default
storage class, with the following YAML file (`angus.yaml`):

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
name: angus
spec:
  instances: 3
  storage:
    size: 1Gi
```

You can install it with `kubectl apply -f angus.yaml`, as with any other
Kubernetes manifest.

For more information, please refer to the [documentation for version 1.15.0](https://cloudnative-pg.io/docs/1.15.0/).
Alternatively, reach out to us on [Slack](https://join.slack.com/t/cloudnativepg/shared_invite/zt-2ij5hagfo-B04EQ9DUlGFzD6GEHDqE0g)
or use [GitHub discussions](https://github.com/cloudnative-pg/cloudnative-pg/discussions).

If you are physically in Valencia for KubeCon Europe 2022, come and say hello to us!

Don't forget to start following us on [Twitter](https://twitter.com/CloudNativePg)
and ... [add a star to the project now!](https://github.com/cloudnative-pg/cloudnative-pg)
Thank you!
