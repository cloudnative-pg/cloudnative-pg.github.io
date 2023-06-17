---
title: "Developing Webapps With CloudNativePG, or, Unlocking DevOps"
date: 2023-06-17T11:29:52+02:00
draft: true
image:
    url: ali-kazal-h5VjkUqMCsc-unsplash.jpg
    attribution: Photo by <a href="https://unsplash.com/@lureofadventure?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Ali Kazal</a> on <a href="https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
author: jsilvela
tags:
 - blog
 - information
 - devops
 - applications
summary: Bootstrap a simple webapp developed with PostgreSQL into a scalable app with CloudNativePG.
---

In this post I'd like to take you on the full journey moving your app written
against PostrgreSQL into a containerized, scalable app on a local Kubernetes
cluster running queries against a CloudNativePG database.
It is surprisingly quick and easy. You should be able to get through this in 15
minutes.

Developing your app on a local Kubernetes cluster? Why do that? There are two
powerful reasons:

1. It unlocks DevOps for database-backed applications. One of the tenets of
  DevOps is to blur the line between development and production. A developer
  writing against PostgreSQL today may install the database locally,
  or perhaps use a `docker` image to run the database locally, when developing
  applications.
  However, those applications will be deployed into an environment that
  is very different, with hot standby replicas, availability zones, and
  backup/restore solutions.
  Developing against CloudNativePG, developers can now test the resiliency and
  responsiveness of their applications in an environment mirroring production.

1. It makes available a lot of powerful components built by the Kubernetes
  community. For example, in the
  [Quickstart guide](http://localhost:1313/documentation/current/quickstart/)
  for CloudNativePG you will find a section that takes you through installing
  the [Prometheus Operator](https://prometheus-operator.dev), with a
  [Grafana](https://grafana.com) dashboard to get metrics for your database.
  In a previous post, you can learn how tow deploy Hasura to provide a
  [GraphQL layer for your CloudNativePG cluster]({{< ref "hasura-graphql">}}).

We're going to be moving a very simple webapp written in Go assuming a
PostgreSQL database. You can clone it from the
[project github page](https://github.com/jsilvela/kubecon-webapp-cnpg).

It is a very simple app with two endpoints, one showing a list of stock tickers,
another updating the listing with new stock values.

The only change the app need be aware of, once we containerize it and move
it into our local Kubernetes cluster, is that the DB connection string will use
the *service* created by CloudNativePG  for the database, rather than a regular
host name. For example:

``` text
"postgres://myUser:myPass@cluster-example-rw/app?sslmode=require"
```

Of course, in a [12-factor](https://12factor.net) compliant webapp, the host,
user credentials and database names would be injected from environment
variables (or an injected
[PGPASSFILE](https://www.postgresql.org/docs/current/libpq-pgpass.html)).
If your webapp is written this way, no changes should be necessary to move it
to Kubernetes / CloudNativePG.

Here's the game plan:

1. Follow the quickstart guide to get a local Kubernetes cluster with the
  CloudNativePG operator deployed.
1. Containerize the webapp with the provided Dockerfile.
1. Deploy a PostgreSQL cluster with CloudNativePG.
1. Populate the database with the initial schema and data.
1. Install your webapp with the provided Deployment + Service YAML.
1. Start a port-forwarding so you can view the webapp from your computer's
  web browser.

### Hands-on

If you don't yet have a local Kubernetes cluster, please refer to the
[Quickstart guide](http://localhost:1313/documentation/current/quickstart/).
You will need `kind` installed, as well as `kubectl` and `docker`.
If you want to run and compile the webapp locally to kick the tires, you will
also need the [Go compiler](https://go.dev), though this is not necessary if
you will only run it containerized.

We're going to create a Kubernetes cluster from scratch using
[KinD](https://kind.sigs.k8s.io), and call it `webapp-demo`.

``` sh
kind create cluster --name webapp-demo
```

This should run quickly. You can make sure it's ready:

``` sh
% kubectl get nodes   
NAME                        STATUS   ROLES           AGE    VERSION
webapp-demo-control-plane   Ready    control-plane   114s   v1.27.1
```

It is a cluster with only one *node*, but you can easily create clusters with
several worker nodes with KinD.

#### CloudNativePG operator

Now let's install the CloudNativePG operator. As explained in the
[installation document](https://cloudnative-pg.io/documentation/current/installation_upgrade/),
you can deploy applying the latest manifest.
At the time of this writing, this is version 1.20.1:

``` sh
kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.20/releases/cnpg-1.20.1.yaml
```

The installation should take seconds, and you should find the deployment
ready:

``` sh
% kubectl get deployments -n cnpg-system 
NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
cnpg-controller-manager   1/1     1            1           18s
```

#### Containerizing the webapp

You can clone the webapp from its
[github project page](https://github.com/jsilvela/kubecon-webapp-cnpg).
From the top-level directory of the checked-out project, containerize the app
by running:

``` sh
docker build -t myapp .
```

You should now be able to see the image `myapp` in the `docker images` listing.
Now we'd like to *load* this image into our KinD cluster's nodes.

``` sh
kind load docker-image myapp:latest --name webapp-demo
```

(*) You could have uploaded your dockerfile into a public container registry,
and used its public handle in the following YAML files, but
for local development and quick iteration, directly loading may be quicker.

#### Creating a PostgreSQL cluster

Before we deploy the app, let's create the simplest possible CloudNativePG
cluster.

``` sh
kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/cluster-example.yaml
```

This YAML is part of a set of example cluster manifests provided with
CloudNativePG that show off various features and are ready to deploy.
You can find out more
[in the CloudNativePG documentation](https://cloudnative-pg.io/documentation/current/samples/).

In a few seconds, you should have the cluster `cluster-example` up and ready.
It is a 3-instance cluster, with a primary and two hot-standbys.

``` sh
% kubectl get clusters
NAME              AGE     INSTANCES   READY   STATUS                     PRIMARY
cluster-example   2m23s   3           3       Cluster in healthy state   cluster-example-1
```

#### Populating the database

The database is empty, but the webapp assumes the existence of two tables
representing stocks and stock tickers:

In the file [`example-changelog.sql`](https://raw.githubusercontent.com/jsilvela/kubecon-webapp-cnpg/main/migrations/example-changelog.sql)
you can find:

``` sql
--changeset jaime.silvela:1 labels:kubecon-demo
--comment: let's start off with 50 stocks 
create table stocks as
    select 'stock_' || generate_series as stock
    from generate_series(1, 50);
--rollback DROP TABLE stocks;

--changeset jaime.silvela:2 labels:kubecon-demo
--comment: lets add a bunch of random stock values
create table stock_values as
    with dates as (
        SELECT generate_series as date
        FROM generate_series('2020-01-01 00:00'::timestamp,
                '2022-05-15 00:00', '24 hours')
    )
    select stock, date, random() as stock_value
    from stocks cross join dates;
```

There are some comments there that are relevat for
[*Liquibase*](https://www.liquibase.org). By all means, for development of
applications, we strongly encourage that you use a **database migration tool**,
but for this demo we can just push through and apply the changes manually.

Check with `kubectl get clusters` which is the primary instance of
`cluster-example`. Let's assume it's `cluster-example-1`, and let's open
a `psql` terminal on it:

``` sh
kubectl exec -ti cluster-example-1 -- psql app
```

Once in `psql`, you can simply copy and paste the SQL above. You should now
see two tables:

``` text
# \dt
            List of relations
 Schema |     Name     | Type  |  Owner   
--------+--------------+-------+----------
 public | stock_values | table | postgres
 public | stocks       | table | postgres
(2 rows)
```

Note the owner is the superuser `postgres`. This is a bit of an anti-pattern.
Applications should run database code with a less-privileged user.
By default, CloudNativePG creates a user called `app`, and a databse owned
by it, also called `app`. This is a very reasonable default, but of course you
can configure your clusters to fit your needs.

Let's make `app` the owner of the tables.

``` sql
alter table stock_values owner to app;
alter table stocks owner to app;
```

There are 50 stocks in the `stocks` table, and 43300 stock values in
the `stock_values` table:

``` sql
# select * from stock_values;
  stock   |        date         |      stock_value       
----------+---------------------+------------------------
 stock_1  | 2020-01-01 00:00:00 |     0.6658041506531942
 stock_2  | 2020-01-01 00:00:00 |       0.99603564595136
 stock_3  | 2020-01-01 00:00:00 |    0.08328438905366786
 stock_4  | 2020-01-01 00:00:00 |     0.1798036377679988
 stock_5  | 2020-01-01 00:00:00 |    0.28340978672269146
 stock_6  | 2020-01-01 00:00:00 |    0.21413451212868462
 stock_7  | 2020-01-01 00:00:00 |    0.19692510776148553
 . . .
 . . . snipped
```

#### Deploying the webapp

OK, we're now ready to deploy our webapp!
The [webapp-deploy.yaml](https://raw.githubusercontent.com/jsilvela/kubecon-webapp-cnpg/main/webapp-deploy.yaml)
manifest contains a *deployment* and a *service* for our webapp.

The deployment specifies we want 3 replicas for our webapp, and passes
the credentials for the `app` user for `cluster-example`.
The Service builds a load balancer to route traffic to any of the 3 replicas.

Simply apply the file:

```sh
% kubectl apply -f webapp-deploy.yaml 
service/mywebapp created
deployment.apps/mywebapp created
```

Right away you can see the three pods running the web server, as well as the
three pods running our database:

``` sh
% kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
cluster-example-1           1/1     Running   0          27m
cluster-example-2           1/1     Running   0          27m
cluster-example-3           1/1     Running   0          27m
mywebapp-548d97848b-fprvh   1/1     Running   0          20s
mywebapp-548d97848b-vrv8f   1/1     Running   0          20s
mywebapp-548d97848b-whnnp   1/1     Running   0          20s
```

You can also see the load balancer for our webapp, as well as three services
for `cluster-example` (we'll say more about them shortly.)

``` sh
% kubectl get svc 
NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
cluster-example-r    ClusterIP      10.96.103.136   <none>        5432/TCP         29m
cluster-example-ro   ClusterIP      10.96.252.145   <none>        5432/TCP         29m
cluster-example-rw   ClusterIP      10.96.49.83     <none>        5432/TCP         29m
mywebapp             LoadBalancer   10.96.128.43    <pending>     8088:30016/TCP   96s
```

Our webapp is now fully running!
However, our local Kind cluster is not generally visible to the local network.
Let's do port forwarding:

``` sh
% kubectl port-forward service/mywebapp  8080:8088
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

You should now be able to see the app in
[http://localhost:8080](http://localhost:8080)

![index page](index-page.png)

Cliking on the *latest stock values* link:

![stocks page](stonks.png)

### A few points to consider

We mentioned that our web application would use the *service* associated with
our CloudNativePG cluster.

### Where to go from here

