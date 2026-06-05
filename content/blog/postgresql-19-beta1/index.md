---
title: "How to test PostgreSQL 19 beta in your Kubernetes cluster"
date: 2026-06-05
draft: false
image:
    url: 
    attribution: 
authors:
 - gbartolini
tags:
 - postgresql
 - postgres
 - pg19beta1
summary: Participate in the PostgreSQL 19 beta program using Kubernetes and our CloudNativePG operator
---
[PostgreSQL 19 Beta 1 was released yesterday](https://www.postgresql.org/about/news/postgresql-19-beta-1-released-3313/)
by the PostgreSQL Global Development Group, containing previews of all features
that will be available when PostgreSQL 19 is made generally available.

The CloudNativePG community has made available the operand container images for
PostgreSQL 19 beta 1 in our
[`postgres-containers` image registry](https://github.com/cloudnative-pg/postgres-containers/pkgs/container/postgresql)
to be used with the CloudNativePG operator. The images follow our current
naming convention — for example `19beta1-minimal-trixie` — and are not
intended for production use.

Please join us in testing the new features of PostgreSQL 19 with CloudNativePG,
and help us diagnose and fix bugs in Postgres before the final launch.

Here follows a quick example of a 3 instance Postgres 19 `Cluster` manifest to be
deployed in your Kubernetes cluster.


```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
 name: pg19

spec:
 imageName: ghcr.io/cloudnative-pg/postgresql:19beta1-minimal-trixie
 instances: 3
 storage:
  size: 1Gi
```

Once deployed, you can easily verify the version with:

```shell
kubectl exec -ti pg19-1 -c postgres -- psql -qAt -c 'SELECT version()'
```

Returning something similar to:

```console
PostgreSQL 19beta1 (Debian 19~beta1-1.pgdg13+1) on aarch64-unknown-linux-gnu,
  compiled by gcc (Debian 14.2.0-19) 14.2.0, 64-bit
```

If you are interested in trying CloudNativePG on your laptop with `kind`
(Kubernetes in Docker), follow the instructions you find in the
[Quickstart](https://cloudnative-pg.io/docs/devel/quickstart/).
