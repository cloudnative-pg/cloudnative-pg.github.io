---
title: "Customizing the docker build bake hcl file"
date: 2025-08-22
draft: true
image:
    url: elephant_cookie.jpg
    attribution: https://www.wallpaperflare.com/cookies-elephant-breakfast-for-children-dessert-food-sweet-food-wallpaper-asujf/download
authors:
 - dchambre
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
summary: Jonathan Gonzalez wrote a guide on this blog detailing how to customize Docker images by using an override hcl file. I tried it for a spin.


---

## Summary

The other week [Jonathan Gonzalez]({{% ref "/authors/jgonzalez/" %}}) wrote an 
article on
[how to customize docker images using an override hcl file]({{% ref "/blog/building-images-bake/" %}}).
Before the [postgres-containers repo](https://github.com/cloudnative-pg/postgres-containers) 
was enhanced with the option to build the images with `docker build bake`, 
I had to follow these steps manually in order to have custom images for our workloads.

- clone the repo
- edit the dockerfile
- build the image
- push it to the registry

Edit, build and push had to be done for each PostgreSQL version.
So a lot of boring work needed to be done in order to have updated images.
The chance to avoid this work sounded promising to me, so I started with the 
[hcl file](https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg.github.io/refs/heads/main/content/blog/building-images-bake/bake.hcl) 
Jonathan wrote, and adapted it to fit my needs.
After a troubleshooting session with Jonathan, he asked me to share the changes I made.
So here are my detailed instructions, in case they could prove useful to others.

## Instructions

### Step 1: Prepare the local Bake file

To build a custom image we add the following content in a local file with name 
`bake.hcl`:

```hcl
platforms = [
  "linux/amd64",
]

extensions = [
  "dbgsym",
  "partman",
  "oracle-fdw",
  "squeeze",
  "show-plans",
  "cron",
  "tds-fdw",
]

target "myimage" {
  dockerfile-inline = <<EOT
ARG BASE_IMAGE="ghcr.io/cloudnative-pg/postgresql:16.9-standard-bookworm"
FROM $BASE_IMAGE AS myimage
ARG EXTENSIONS
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends $EXTENSIONS \
    ldap-utils \
    ca-certificates \
    openssl \
    procps \
    postgresql-plpython3-"${getMajor(pgVersion)}" \
    python3-psutil \
    pgtop \
    pg-activity \
    nmon \
    libsybdb5 \
    freetds-dev \
    freetds-common && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/* /var/cache/* /var/log/*
RUN sed -i -e 's/# de_AT.UTF-8 UTF-8/de_AT.UTF-8 UTF-8/' /etc/locale.gen && \
        locale-gen
ADD https://your.git.url/postgresql/-/blob/main/.psqlrc?ref_type=heads /var/lib/postgresql/
ADD https://your.git.url/cloudnativepg/-/blob/main/bake/files/etc/ldap/ldap.conf?ref_type=heads /etc/ldap/
ADD https://your.git.url/cloudnativepg/-/blob/main/bake/files/usr/local/share/ca-certificates/EuropeanSSLServerCA2.crt?ref_type=heads /usr/local/share/ca-certificates/
ADD https://your.git.url/cloudnativepg/-/blob/main/bake/files/usr/local/share/ca-certificates/RootCA1v0.crt?ref_type=heads /usr/local/share/ca-certificates/
ADD https://your.git.url/cloudnativepg/-/blob/main/bake/files/usr/local/share/ca-certificates/SubCA1v1.crt?ref_type=heads /usr/local/share/ca-certificates/
RUN update-ca-certificates 
USER 26
EOT
  matrix = {
    tgt = [
      "myimage"
    ]
    pgVersion = [
      "13.21",
      "14.18",
      "15.13",
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

Starting at the beginning of the file:

- The `platforms` variable is `linux/amd64` for all of my images.
- The `extensions` variable contains some extensions I use regularly.
- The `dockerfile-inline` part is extended with binaries, some of them are handy
 to have, some needed by extensions or other tools I use e.g. [pgwatch](https://github.com/cybertec-postgresql/pgwatch).
- With the `sed` command I add needed locales and build them.
- With the `ADD` commands I extend the image with
  - .psqlrc file, to have a nice psql Command-line even when connecting via 
  `kubectl cnpg psql XXX`
  - ldap.conf and the needed certs

### Step 2: Build the image

We can now build the image using the following command:

```bash
environment=production registry=your.repo.url docker buildx bake -f docker-bake.hcl -f cwd://bake.hcl "https://github.com/cloudnative-pg/postgres-containers.git" myimage
```

- The `environment` variable is set to `production` for all of my images, 
because I use the same image to stage it through dev/test/prod.
- The `registry` variable contains the repo upload url, so the images get 
uploaded there instead of the `localhost:5000` registry used in the 
[hcl file](https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg.github.io/refs/heads/main/content/blog/building-images-bake/bake.hcl).

### Step 3: Use it

The only missing step to use the images is to update your 
[Image Catalog / Cluster Image Catalog](https://cloudnative-pg.io/documentation/current/image_catalog/) 
with the newly built images.
Test them and stage them through your environment.

## Conclusion

Once you prepare the override file to fit to your needs, the only manual steps 
to build new images are

- udpate the `pgVersion` variable
- run the `docker buildx bake` command
  
I hope this helps streamline your image customization process as much as it 
did mine—feel free to build on it, and share your own improvements too! 
You can find the supportive team in the CloudNativePG channels on the CNCF Slack workspace.
