---
title: "Creating a custom container image for CloudNativePG"
date: 2023-08-14T11:29:52
draft: false
image:
    url: 
    attribution: 
author: jgonzalez
tags:
 - blog
 - information
 - programming
 - applications
 - containers
 - postgresql
 - postgres
 - images
summary: Creating a container image for CloudNativePG Operator
---

## Summary

As adoption of CloudNativePG grows, we see more people asking how to create an
image, or if we will ever provide an image with a particular extension.
Well, we're a small team and cannot maintain so many images, but we can help you
create your own custom images
to fit your needs, based on the primary PostgreSQL container images for CloudNativePG.

Let's start! This will be an easy and quick blog post. We will use the popular extension
[pgvector](https://github.com/pgvector) to illustrate this example. I hope
this post will help people  get started.

Let's keep in mind:

* We will start from the [postgres-containers](https://github.com/cloudnative-pg/postgres-containers) images
* They are Debian based images, so you will need to use [`apt`](https://wiki.debian.org/Apt) (you can follow the examples)
* We will use the [pgvector](https://github.com/pgvector) installation instructions
* The target PostgreSQL version for this example will be 15

## How to install pgvector?

First step: in the [pgvector](https://github.com/pgvector/pgvector) page
we can find an `APT` section with this information:

> Debian and Ubuntu packages are available from the PostgreSQL APT Repository.

That's a great starting point, as we already have the PostgreSQL APT Repository
in our `postgres-containers` images; we can go ahead and use `apt`. Let's go:

## Creating the Dockerfile

We just need to run the command `apt install postgresql-15-pgvector`; we can
add that to a Dockerfile:

``` Dockerfile
FROM ghcr.io/cloudnative-pg/postgresql:15.4-3

# To install any package we need to be root
USER root

# We update the package list, install our package
# and clean up any cache from the package manager
RUN set -xe; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"postgresql-15-pgvector" ; \
	rm -fr /tmp/* ; \
	rm -rf /var/lib/apt/lists/*;

# Change to the uid of postgres (26)
USER 26
```

So we update, and we install the target package. It's really important to keep the last two lines
where we set the user 26, which is the `postgres` user.

Then we can build the image:

``` shell
docker build -t pgvector:15 .
```

In the build process, it's important to keep the `15` tag, since it's used by the CloudNativePG operator to
detect database versions. Never use `latest` as tag, since the operator will reject your image.

Once the image is built, you can load it into your Kubernetes cluster, and create a
PostgreSQL cluster with that image:

``` yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: cluster-example
spec:
  imageName: pgvector:15
  instances: 3

  storage:
    size: 1Gi
```

Now that you have an image with the extension inside, you can create the extension inside
the `app` database:

``` shell
kubectl exec -ti cluster-example-1 -- psql app

CREATE EXTENSION vector;
```

You could add the command `CREATE EXTENSION vector;` to the
`postInitTemplateSQL` section instead,
and that would automatically work with every database, which might be preferable
depending on your use case.
