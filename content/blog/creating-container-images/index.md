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

## Extensions from source code

What if there's an extension that doesn't have a package in any distribution, and you need to compile it?
Well, the answer to this may look easy: you must compile it in the image. But when we do this we will leave
some dependencies that we don't want inside our images, things like `gcc`, `make`, etc.
Tools used
to compile the image, but that someone with access to the image could use to compile malicious code
and run it inside the container. This it's something we should prevent.

The solution to this problem is using a multi-stage build process. This means that in a set of layers
we compile the extensions, and in the next one we just copy the file from the original layer that we actually
need, files like the `.so` files.
This sounds more complicated than it really is; let's try with an example.

As an example we're going to compile `pg_crash`.
The first layer will be the one to compile.

``` Dockerfile
# First step is to build the the extension
FROM debian:bullseye-slim as builder

RUN set -xe ;\
    apt update && apt install wget lsb-release gnupg2 -y ;\
    sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' ;\
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - ;\
    apt-get update ;\
    apt-get install -y postgresql-server-dev-15 build-essential git; \
    cd /tmp; \
    git clone https://github.com/cybertec-postgresql/pg_crash; \
    cd /tmp/pg_crash; \
    PG_CONFIG=/usr/lib/postgresql/15/bin/pg_config make; \
    PG_CONFIG=/usr/lib/postgresql/15/bin/pg_config make install
```

This will install all the necessary packages to download from source and compile the `pg_crash` extension. The key
section here is the `as builder` part in the `FROM` line; this helps us to identify this layer with a name for later use.
Now in the next section of the file we continue with the standard process:

``` Dockerfile
# Second step, we build the final image
FROM ghcr.io/cloudnative-pg/postgresql:15.4-3

# To install any package we need to be root user
USER root

# But this time we copy the .so file from the build process
COPY --from=builder /tmp/pg_crash/pg_crash.so /usr/lib/postgresql/15/lib/

# Change the uid of postgres to 26
RUN usermod -u 26 postgres
USER 26
```

As you can see, we used the identifier `builder` to specify the path where we are going to copy the content from. We know that we can copy the `.so` file to the postgresql `lib` folder.

Combined, our file will look like this:

``` Dockerfile
# First step is to build the the extension
FROM debian:bullseye-slim as builder

RUN set -xe ;\
    apt update && apt install wget lsb-release gnupg2 -y ;\
    sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' ;\
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - ;\
    apt-get update ;\
	apt-get install -y postgresql-server-dev-15 build-essential git; \
	cd /tmp; \
	git clone https://github.com/cybertec-postgresql/pg_crash; \
	cd /tmp/pg_crash; \
	PG_CONFIG=/usr/lib/postgresql/15/bin/pg_config make; \
	PG_CONFIG=/usr/lib/postgresql/15/bin/pg_config make install

# Second step, we build the final image
FROM ghcr.io/cloudnative-pg/postgresql:15.4-3

# To install any package we need to be root user
USER root

# But this time we copy the .so file from the build process
COPY --from=builder /tmp/pg_crash/pg_crash.so /usr/lib/postgresql/15/lib/

# Change the uid of postgres to 26
RUN usermod -u 26 postgres
USER 26
```

And that's it! now you know a way to install extensions from packages and from source code! Let's start creating
PostgreSQL clusters with many different extensions! Keep in mind that images may increase the size when you add more
extensions, and that may affect the time to download an image.

Happy Hacking!
