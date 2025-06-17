---
title: "Creating a custom container image for CloudNativePG v2.0"
date: 2025-06-17
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
 - tutorial
summary: Creating a container image for CloudNativePG Operator v2.0
---

## Summary
In an almost [two years old blog post]({{% ref "/blog/creating-container-images/" %}}), we explained how
to build a custom container image for CloudNativePG. After two years, many things have changed in the world of containers.
One of those things has been the introduction of [Bake](https://docs.docker.com/build/) in Docker, which allows you to build
images using a simple configuration file. Bake is now our recommended way to build images for CloudNativePG.

We will follow a simple cooking recipe to create a custom container image or a set of container images, since Bake
allows you to build multiple images at once in a simple way.

## Ingredients

- A Bake file. We will use the one provided in the [CloudNativePG repository](https://github.com/cloudnative-pg/postgres-containers/blob/main/docker-bake.hcl)

Cooking time: 5 minutes.

## Instructions

### Step 1: Prepare local Bake file

In a local file with name `bake.hcl`, we add the following content, which is a simple Bake file that will build a custom image

```hcl
extensions = [
  "pgvector",
]
target "myimage" {
  dockerfile-inline = <<EOT
ARG BASEIMAGE="ghcr.io/cloudnative-pg/postgresql:16.9-standard-bookworm"
FROM $BASEIMAGE AS myimage
ARG EXTENSIONS
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends $EXTENSIONS && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/* /var/cache/* /var/log/*
USER 26
EOT

  matrix = {
    tgt = [
      "myimage"
    ]
    pgVersion = [
      "16.9",
      "17.5",
    ]
  }
  name = "postgresql-${index(split(".",cleanVersion(pgVersion)),0)}-standard-bookworm"
  target = "${tgt}"
  args = {
    BASE_IMAGE = "ghcr.io/cloudnative-pg/postgresql:${cleanVersion(pgVersion)}-standard-bookworm",
    EXTENSIONS = "${getExtensionsString(pgVersion, extensions)}",
  }
}
```

There are a few things that we should remark here:

- The `extensions` variable is a list of extensions that we want to include in the image. In our recipe we are using `pg_vector`,
  but you can add any other extension that you want to include in the image.
- The `dockerfile-inline` variable contains our Dockerfile definition, which cannot be used remotely. We will explain more about this later.
- The `target` and the `tgt` have the same name, you can use whatever you want here as a name
- The `pgVersion` variable is a list that contains basically the MAJOR.MINOR version of PostgreSQL
- The `name` is the name that we will use later to refer to one element of the matrix that we created
- The variable `args` lists all the arguments passed to the Dockerfile. We will talk more about this later.
- The function `getExtensionsString()` is inherited from the Bake file that we reference in the [Ingredients](#ingredients) section

### Step 2: Build the image

We can now build the image using the following command:

```bash
docker buildx bake -f docker-bake.hcl -f cwd://bake.hcl "https://github.com/cloudnative-pg/postgres-containers.git" myimage
```

This will, by default, build the image for the bake matrix we previously created, and will try to push the image to the registry at
`localhost:5000`, which is the default registry defined for testing environments in the parent Bake file. Let's explain the full command:

As is defined in the [Bake documentation about remote definitions](https://docs.docker.com/build/bake/remote-definition/)
you can use a remote Bake definition with all the functions and default targets, and attach another local one that you can use to override
all the default values.
In the command above, `-f cwd://bake.hcl` is the local file that we created in Step 1, and
`-f docker-bake.hcl` is the remote file in the git repo, that we're using to build the image.

You can explore more about all the content generated and used inside the Bake file by appending the `--print` flag, as in the following command:

```bash
docker buildx bake -f docker-bake.hcl -f cwd://bake.hcl "https://github.com/cloudnative-pg/postgres-containers.git" myimage --print
```

### Step 3: Push the image to a registry

Now you just need to push the image to a registry. You can do this by using the following command:

```bash
registry=your/registry:5000 docker buildx bake -f docker-bake.hcl -f cwd://bake.hcl "https://github.com/cloudnative-pg/postgres-containers.git" myimage --push
```

The previous command will push the images in the following format: `your/registry:5000/postgresql-testing:17-standard-bookworm`.
Using the `--print` flag you can explore the full list of tags created that are in the parent Bake file.

### Step 4: Serve the image

You can now let your clusters use the image that we've built based on the CloudNativePG operand images provided
by the CloudNativePG project.

## Deep dive into the Bake and Dockerfile

The simplicity of Bake to do even more stuff is amazing, and allows you to create custom images easily.
But, how does this magic happen? Let's take a look at the Bake and the Docker file.

### Bake file

The magic starts with our postgres-containers repository, where we have a `docker-bake.hcl` file
that is being used to build the images provided by the CloudNativePG project.
It's the base for our custom Bake file.

The `docker-bake.hcl` file contains a lot of functions that are used to build the images. One of them is the `getExtensionsString()`.
This function, given the list of extensions we provided, will return a string of the extensions with the correct package name
for a Debian-based distribution, in our case, Debian Bookworm.
For example, the `pg_vector` extension will be translated into
`postgresql-16-pgvector,` which is the name of the package for pgvector extensions for PostgreSQL 16 in the Debian
Bookworm distribution.

When we add elements to, for example, the `args` variable, those elements are processed by the Bake file, and will be
merged, meaning that the new elements will be added, and the existing ones will be overwritten.

### Dockerfile file

The Dockerfile is simply a heredoc string, because of the limitations of Bake to overwrite the remote Dockerfile with a
local one, but it allows us to change the FROM in the image, which means we can create an image that it's directly based
on the CloudNativePG images, and we can add the extensions we want to use in our image, without building all of them.

## There's more!

You may want to avoid building arm64 image by adding the following:

```hcl
platforms = ["linux/amd64"]
```

This will overwrite the platforms variable and so, will build only for one platform.

Also, if you want to build everything into your own repository and manage the same tags, it's possible. In the future
we may write another post explaining this.
