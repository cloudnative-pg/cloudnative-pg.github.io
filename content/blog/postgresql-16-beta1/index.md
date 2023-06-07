---
title: "How to test PostgreSQL 16 beta in your Kubernetes cluster"
date: 2023-06-07T08:30:33+01:00
draft: false
image:
    url: elephant-ship.png
    attribution: Photo from <a href="https://jenikirbyhistory.getarchive.net/amp/media/a-cargo-of-seventy-elephants-landing-from-burmah-during-the-1857-mutiny-3ff978">Metropolitan Museum of Art
</a>
author: Gabriele Bartolini
tags:
 - postgresql
 - postgres
 - pg16beta1
summary: Participate in the PostgreSQL 16 beta program using Kubernetes and our CloudNativePG operator
---
[PostgreSQL 16 Beta 1 was recently released](https://www.postgresql.org/about/news/postgresql-16-beta-1-released-2643/)
by the PostgreSQL Global Development Group, containing previews of all features
that will be available when PostgreSQL 16 is made generally available.

The CloudNativePG community has made available the operand container images for
PostgreSQL 16 beta 1 in our
[`postgres-container` image registry]https://github.com/cloudnative-pg/postgres-containers/pkgs/container/postgresql)
to be used with the CloudNativePG operator. The images are tagged with the
'16beta1' or '16' label, and are not intended for production.

Please join us in testing the new features of PostgreSQL 16 with CloudNativePG,
and help us diagnose and fix bugs in Postgres before the final launch.

Here follows a quick example of a 3 instance Postgres 16 'Cluster' manifest to be
deployed in your Kubernetes cluster.


```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
 name: pg16

spec:
 imageName: ghcr.io/cloudnative-pg/postgresql:16beta1
 instances: 3
 storage:
  size: 1Gi
```

Once deployed, you can easily verify the version with:

```shell
kubectl exec -ti pg16-1 -c postgres -- psql -qAt -c 'SELECT version()'
```

Returning:

```console
PostgreSQL 16beta1 (Debian 16~beta1-2.pgdg110+1) on x86_64-pc-linux-gnu,
  compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit
```

If you are interested in trying CloudNativePG on your laptop with 'kind'
(Kubernetes in Docker), follow the instructions you find in the
[Quickstart](https://cloudnative-pg.io/documentation/current/quickstart/).
