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