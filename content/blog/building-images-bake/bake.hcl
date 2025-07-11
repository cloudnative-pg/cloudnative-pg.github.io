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
