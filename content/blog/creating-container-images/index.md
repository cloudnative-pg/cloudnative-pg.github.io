---
title: "Finding holes in structs and reducing memory usage Part I"
date:
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

# Summary

As the users of CloudNativePG we started to see a lot of people asking on how to create an
image or if we will evern provide an image with X extension, well, we're a small team
and many times we cannot keep so many images, but we can help you create your own images
with your own custom tools, based on our primary PostgreSQL container image for CloudNativePG.

Let's start! This will be an easy an quick blog post, we will use a really famous extension
[pgvector](https://github.com/pgvector) for this example, and probably lot of people may be
able to start with this sample.

This to keep in mind:
* We will use the [postgres-containers](https://github.com/cloudnative-pg/postgres-containers) images
* It's a Debian based image, so you need to know how to use apt (you can follow the examples)
* We will use the [pgvector](https://github.com/pgvector) install instructions
* The target PostgreSQL version for this example will be 15

# How to install pgvector?

First step, go to the [pgvector](https://github.com/pgvector) page and learn how to install, we can
find there's a `apt` section to install that say this:
```
Debian and Ubuntu packages are available from the PostgreSQL APT Repository.
```
That's a really really good starting point, because we already have the PostgreSQL APT Repository
in our postgres-containers images, so we can just install, let's do that

# Creating the Dockerfile

Basically, we need to just run the command `apt install postgresql-15-pgvector` so, let's do that:

```
FROM ghcr.io/cloudnative-pg/postgresql:15.4-3

# To install any package we need to be root user
USER root

# We update the package list, install our package
# and clean up any cache from the package manager
RUN set -xe; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"postgresql-15-pgvector" ; \
	rm -fr /tmp/* ; \
	rm -rf /var/lib/apt/lists/*;

# Change the uid of postgres to 26
USER 26
```

So we update and we install the target package, but it's really important to keep the last two lines
where we keep the user 26, which is the postgres user.

Then we can build
```
docker build -t pgvector:15 .
```

In the build process, it's important to keep the `15` at the end since it's used by the operator to
detect the versions, never use `latest` as tag since the operator will reject your image.

After that you can load the image into your Kubernetes cluster and then you can just create a cluster
with that image:

```
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

And that's all you have an image with the extension inside, now you can create the extension inside
the database `app` or the name you used in the yaml file.

On the other hand, you can use `postInitTemplateSQL` with the sentence `CREATE EXTENSION vector;`
and that will work with every database created, but this may not be your use case and you want
to create it manually or you may have that `CREATE EXTESION` inside your code.
