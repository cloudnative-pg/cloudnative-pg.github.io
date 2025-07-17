---
title: "Creating a custom container image for CloudNativePG v2.0"
date: 2025-07-22
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
 - bake
 - docker
summary: Using Docker's Bake to create container images for the CloudNativePG Operator v2.0.
---

## Summary
Nearly two years ago, we shared a [blog post on building custom container 
images for CloudNativePG]({{% ref "/blog/creating-container-images/" %}}). Since then, the container ecosystem has evolved 
significantly—one notable development being the introduction of [Docker Bake]((https://docs.docker.com/build/bake/)).

Docker Bake simplifies image builds using a straightforward configuration file, 
and it’s now our recommended approach for building CloudNativePG images.

In this post, we’ll walk through a simple baking recipe to create a custom 
container image. With Bake, you can also easily build multiple images in 
parallel.

## Ingredients

- A Bake file, using the one provided in the [CloudNativePG repository](https://github.com/cloudnative-pg/postgres-containers/blob/main/docker-bake.hcl) as a base.
- A second, local Bake file to override the base configuration—this lets you apply your custom changes and build the container images accordingly.

Baking time: 5 minutes.

## Instructions

### Step 1: Prepare local Bake file

To build a custom image we add the following content in a local file with name [bake.hcl](bake.hcl):

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

There are a few important points to highlight:

- The `extensions` variable is a list of extensions that we want to include in the image. In our recipe we are using `pgvector`, but you can add any others as needed.
- The `dockerfile-inline` variable contains our Dockerfile definition, which cannot be used remotely. We will explain why later.
- The `target` and the `tgt` values share the same name, but you can use any name you prefer.
- The `pgVersion` variable is a list specifying the PostgreSQL version(s) in MAJOR.MINOR format.
- The `name` field is used to identify individual entries in the matrix we’ve defined.
- The `args` variable contains the arguments passed to the Dockerfile—more on this later.
- The `getExtensionsString()` function is inherited from the base Bake file mentioned in the [Ingredients](#ingredients) section


### Step 2: Build the image

We can now build the image using the following command:

```bash
docker buildx bake -f docker-bake.hcl -f cwd://bake.hcl "https://github.com/cloudnative-pg/postgres-containers.git" myimage
```

This will build the image for the bake matrix we previously created, and will try to push the image to the registry at
`localhost:5000`, which is the default registry defined for testing environments in the parent Bake file. Let's explain the full command:

As outlined in the [Bake documentation on remote definitions](https://docs.docker.com/build/bake/remote-definition/), you can use a remote Bake file that includes functions and default targets, then attach a local Bake file to override any default values as needed.

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

You can now use the image that we've built for your clusters.  

## Deep dive into the Bake and Dockerfile

The simplicity of Bake to do even more stuff is amazing, and allows you to create custom images easily.  

### Bake file

The magic starts with our [postgres-containers repository](https://github.com/cloudnative-pg/postgres-containers),
where we have a `docker-bake.hcl` file that is being used to build the images for the CloudNativePG project.
It's the base for our custom Bake file.

The `docker-bake.hcl` file contains a lot of functions that are used to build the images. One of them is the `getExtensionsString()`.
This function, given the list of extensions we provided, will return a string of the extensions with the correct package name
for a Debian-based distribution, in our case, Debian Bookworm.
For example, the `pgvector` extension will be translated into
`postgresql-16-pgvector,` which is the name of the package for pgvector extensions for PostgreSQL 16 in the Debian
Bookworm distribution.

When we add elements to, for example, the `args` variable, those elements are processed by the Docker bake command, and will be
merged, meaning that the new elements will be added, and the existing ones will be overwritten.

### Dockerfile file

The Dockerfile is defined as a heredoc string due to Bake's limitation in overriding a remote Dockerfile with a local one. However, this approach still lets us modify the FROM directive, allowing us to base our image directly on the CloudNativePG images and add only the specific extensions we need—without rebuilding all of them.

## There's more!

You may want to avoid building arm64 images by adding the following:

```hcl
platforms = ["linux/amd64"]
```

This will override the platforms variable, so the image will be built for a single platform only.

If you’d like to build everything into your own repository while managing the same tags, that’s also possible. We may cover that in a future post.
