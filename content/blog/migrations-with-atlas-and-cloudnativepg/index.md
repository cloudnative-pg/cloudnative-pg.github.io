---
title: "Migrations With Atlas and CloudNativePG"
date: 2025-03-19T11:47:56+01:00
draft: false
image:
    url: elephant-migration.jpg
    attribution: from <strong><a href="https://commons.wikimedia.org/w/index.php?curid=101232202">Wikimedia Commons</a></strong>
author: jsilvela
tags:
 - blog
 - tutorial
 - migrations
 - devops
summary: Doing schema migrations on CloudNativePG clusters using the Atlas operator
---

One of the most important practices when developing code that relies on
databases is to use *database migration tools* for change management.
It's something you *will* learn, even if it has to be the hard way.
(Another thing I see too many newcomers learning the hard way is to take backups
often, and to test those backups regularly.)

In the post [*Developing webapps with CloudNativePG*]({{% ref "/blog/developing-webapps-with-cloudnative-pg" %}}),
we mentioned [Liquibase](https://www.liquibase.com), which is one of the most
popular database migration tools.

Traditional database migration tools assume a connection is available to the
target database. In the context of Kubernetes,
and of Postgresql clusters built using CloudNativePG, to use such a tool
we would need to expose the database *service* outside the Kubernetes cluster,
for example via
[port forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/),
an [ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/),
or similar solutions.

The [Atlas database migration tool](https://atlasgo.io) includes a Kubernetes
operator that lets us manage database migrations within Kubernetes.
Let's see an example of how to do that:

## Step 0:  install CloudNativePG and create a Postgres cluster

First of all, you should have CloudNativePG running on your kubernetes cluster,
and a Postgres cluster created with CloudNativePG.
If you don't yet have this, you can follow the
[CloudNativePG quickstart](https://cloudnative-pg.io/documentation/current/quickstart/).

Whether you follow the quickstart or you already had a CloudNativePG/Postgres
cluster up and running, we'll assume for the rest of this post that your
CloudNativePG cluster is called `cluster-example`.

## Step 1: install the Atlas operator

To install the Atlas operator, you can use Helm:

``` console
helm install atlas-operator oci://ghcr.io/ariga/charts/atlas-operator
```

Note that you may need an access token to retrieve the image from
the GHCR registry (please see the [GHCR documentation](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry)
for details).

After Atlas is installed, you will notice new CRDs in your Kubernetes
installation:

``` console
> kubectl get crd | grep atlas
atlasmigrations.db.atlasgo.io                    <timestamp>
atlasschemas.db.atlasgo.io                       <timestamp>
```

## Step 2: make changes to the database using Atlas

We will use the *Atlas Schema* CRD to manage migrations. You may want
to open the [Atlas operator quickstart](https://atlasgo.io/integrations/kubernetes/quickstart)
for reference, though we're not going to follow it exactly.

To apply a migration, we need credentials to access our target database.
The Atlas operator quickstart uses the `urlFrom`
stanza, but with CloudNativePG there is a more convenient way.

From Step 0, we have assumed we have a CloudNativePG cluster called
`cluster-example`.
CloudNativePG, by default, creates a database called `app` on clusters, and
a user `app` whose credentials are held in a Secret called
`cluster-example-app`:

``` console
> kubectl get secrets | grep app
cluster-example-app                    kubernetes.io/basic-auth   9      18h
```

You can inspect the contents of the secret running
`kubectl get secrets cluster-example-app -o yaml`,
and you will find that it contains a key called `password`, holding of course
the password for the `app` user (base64 encoded).
In addition to the `cluster-example-app` Secret, the CloudNativePG operator
creates Services for Postgres. In particular, we will want to use the ReadWrite
service, called `cluster-example-rw`, for the migrations.

We're going to use the [`credentials` object](https://atlasgo.io/integrations/kubernetes/declarative#credentials-object)
from the AtlasSchema CRD to reference
the password and the service. Following along the Atlas Operator Quickstart, we
create a migration defining a table called `t1`. Save the following to a file
named `atlas-schema.yaml`.
Notice how CloudNativePG automatically produced the values we need to put
in the `passwordFrom` and `host` fields:

``` yaml
apiVersion: db.atlasgo.io/v1alpha1
kind: AtlasSchema
metadata:
  name: atlasschema-pg
spec:
  credentials:
    scheme: postgres
    host: cluster-example-rw.default
    user: app
    passwordFrom:
      secretKeyRef:
        key: password
        name: cluster-example-app
    database: app
    port: 5432
    parameters:
      sslmode: disable
  schema:
    sql: |
      create table t1 (
        id int
      );
```

Then apply it: `kubectl apply -f atlas-schema.yaml`.

In a few seconds, you should be able to see the Schema has been reconciled:

``` console
> kubectl get atlasschemas.db.atlasgo.io
NAME                 READY   REASON
atlasschema-pg       True    Applied
```

To verify the effects on the database, let's get a `psql` session open on one
of our instances:

``` console
> kubectl exec -ti cluster-example-1 -- psql app
Defaulted container "postgres" out of: postgres, bootstrap-controller (init)
psql (17.4 (Debian 17.4-1.pgdg110+2))
Type "help" for help.

app=# \dt
       List of relations
 Schema | Name | Type  | Owner
--------+------+-------+-------
 public | t1   | table | app
(1 row)

app=# \d t1
                 Table "public.t1"
 Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
 id     | integer |           |          |
```

As suggested in the Atlas Quickstart, we can modify the schema in the
`atlas-schema.yaml` file, and then re-apply with
`kubectl apply -f atlas-schema.yaml`, and the Atlas operator will again
reconcile the database to the desired state.

## What's the point? DevOps

Let's say you have an application that uses a database. In production, the
database may hold your customers's data, purchase history, financial
transactions, perhaps maps using PostGIS, etc.

Application developers will regularly need to add functionality, and often
that will involve creating new tables, schemas, procedures, indexes, perhaps
doing some `INSERT` statements to populate static data, etc.
The developers will be using a development database, probably hosted in their
dev machines.
There might be another database for the purpose of automated testing, and
of course there's the production database, where the changes will need to be
applied in the end. These different databases will have different data in them,
and different loads.
Add time and other developers, and you have a big chance for snafus of the type
*"but it worked on my machine!"*

Database migration tools help manage this, bringing DevOps to this area of
databases. Atlas, by working as a Kubernetes operator, makes the dev/prod
transition even smoother. \
But it's not enough to use good tools. Remember the Agile manifesto:
*"individuals and interactions over processes and tools"*.
You can find an overview of the challenges posed by database change management
at [DORA](https://dora.dev/capabilities/database-change-management/).

Using CloudNativePG, with its services and credentials secrets created out of
the box, together with Atlas, will enable the developers to create migrations
in their development Kubernetes installations, update the YAML
files for Atlas in version control to share with the other devs, and eventually
apply to the production database smoothly.

---

This intro was just to whet your appetite. There is plenty more to learn with
Atlas.
