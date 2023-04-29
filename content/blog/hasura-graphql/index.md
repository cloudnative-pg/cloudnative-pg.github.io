---
title: "CloudNativePG and Hasura: should we be scared by demons?"
date: 2023-05-01T09:00:00+02:00
draft: true
author: leonardoce
tags:
 - cloudnativepg
 - hasura
 - graphql
 - kubernetes
 - k8s
summary: |
  How to bootstrap a development environment for a modern application
  using GraphQL
---

CloudNativePG is a production-grade PostgreSQL operator for Kubernetes and a way
to bootstrap a comfortable development environment.

In this blog post, we'll create a CloudNative-PG cluster with a few example
tables, and we'll use Hasura to bootstrap a GraphQL API to be used by your
application to load and store data efficiently.

A Kubernetes cluster is required to follow this tutorial, and Docker and Kind
are a great combo if you need to create one on your laptop.

# Installing CloudNative-PG

To install it, we'll follow the [installation and
upgrade](https://cloudnative-pg.io/documentation/latest/installation_upgrade/)
section of the CloudNative-PG website.

At the time of writing this article, the latest version is 1.20:

```shell
kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.20/releases/cnpg-1.20.0.yaml
```

To be on the safe side, we want to wait until CloudNative-PG is up and running.
It's enough to wait until the ready column shows `1/1`:

```
$ kubectl get deployments -n cnpg-system
NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
cnpg-controller-manager   1/1     1            1           6d16h
```

# Creating the PostgreSQL cluster.

The minimal CloudNative-PG cluster creates an HA architecture with one primary
and two replicas. It's enough to quickly create a sandbox:

```
$ kubectl apply -f https://cloudnative-pg.io/documentation/1.20/samples/cluster-example.yaml
cluster.postgresql.cnpg.io/cluster-example created
```

We should now wait for the cluster to be up and running:

```
$ kubectl wait --for=condition=Ready cluster/cluster-example
cluster.postgresql.cnpg.io/cluster-example condition met
```

# Installing Hasura

The Hasura GraphQL GitHub repo [hosts some Kubernetes
manifests](https://github.com/hasura/graphql-engine/tree/stable/install-manifests/kubernetes)
we can start with.

The [relative Hasura documentation
page](https://hasura.io/docs/latest/deployment/deployment-guides/kubernetes/)
contains more information about them. 

We must inject our PostgreSQL credentials into the deployment manifest, and
we'll do that using the secret automatically created by the operator.

CloudNative-PG creates an unprivileged user called `app` (you can override the
name) for applications to use. The `cluster-example-app` secret contains its
credentials.

The `cluster-example-rw` service will always target the primary instance, and we
will use that.

We will:

* Inject the password into the `PGPASSWORD` environment variable
* Use `cluster-example-app-rw` as a target hostname.
* Use `app` as the database name.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hasura
spec:
  [...]
  template:
    spec:
      containers:
      - name: hasura
        env:
        - name: HASURA_GRAPHQL_DATABASE_URL
          value: postgres://app@cluster-example-rw
        - name: PGPASSWORD
          valueFrom:
            secretKeyRef:
              name: cluster-example-app
              key: password
```

The complete manifest can be found in [hasura-deployment.yaml].

We now need a service for our applications to use. An example can be found in
[hasura-service.yaml].

# Play with Hasura's UI

Now you can create tables and play with GraphQL using Hasura's UI. All we need
is to expose Hasura's service to our computer with the following:

```
$ kubectl port-forward service/hasura 8080:80
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
``` 

We can now access Hasura at http://localhost:8080.

![hasura](hasura.png)


# Migrations

Hasura maps the GraphQL schema to the PostgreSQL tables by storing metadata
inside the database. Metadata are managed and versioned in an Hasura project
which is applied to the database via the Hasura CLI.

The project we're use for this blog article can be found
[here](https://github.com/leonardoce/hasura-blog).

Hasura projects can be scaffolded with:

```
$ hasura init
```

To create new tables, we need to create a new migration and we can do that with:

```
$ hasura migrate create init
```

Migrations are composed of two SQL files: `up.sql` and `down.sql`.

We'll put the queries creating our tables in `up.sql`:

```sql
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE
);

CREATE TABLE articles (
    id SERIAL PRIMARY KEY,
    author_id INTEGER NOT NULL REFERENCES authors (id),
    title TEXT NOT NULL,
    content TEXT NOT NULL
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    author_id INTEGER NOT NULL REFERENCES authors (id),
    article_id INTEGER NOT NULL REFERENCES articles (id),
    content TEXT NOT NULL
);
```

And the queries deleting them in `down.sql`:

```sql
DROP TABLE comments;
DROP TABLE articles;
DROP TABLE authors;
```

After having created the migration we can apply it with:

```
$ hasura migrate apply
```

[This
commit](https://github.com/leonardoce/hasura-blog/commit/e75cfbb7a262f286d818e471904da314875bef58)
contains the migrations code.

# Mapping the SQL schema to GraphQL

We need now to map the tables and the relationship in our database in a GraphQL
schema.

The easiest way to do this is to use the Hasura GUI you have at
http://localhost:8080 and:

1. click on the `Data` tab, and inside the `default` database choose the
   `public` schema

2. track all the tables

3. track all the relationships

![tracking tables](hasura-metadata-1.png)

![tracking relationships](hasura-metadata-2.png)

Having done that, we need our Hasura project to reflect what we did..

We can do that with:

```
$ hasura metadata export
```

[This commit contains the generated metadata](https://github.com/leonardoce/hasura-blog/commit/32fd8a202f42fb07fe25e2c66c1fbac26cbb2d96)

# Executing our first mutation

We can now execute our first GraphQL mutation on this database to create a new
article and a new author at the same time:

This is the mutatation we need:

```graphql
mutation AddArticle($title: String, $content: String, $author: String) {
	insert_articles_one(object: {
    title: $title,
    content: $content,
    author: {
      data: {
        name: $author,
      },
      on_conflict: {
        constraint: authors_name_key,
        update_columns: [name]
      }
    }
  }) {
     id
  }
}
```

We need to feed this JSON variables to our mutation.

```json
{
  "title": "Hasura is great!",
  "content": "Look! I can insert the author and the comment at the same time",
  "author": "Leonardo Cecchi"
}
```

The result of this mutation will be:

```json
{
  "data": {
    "insert_articles_one": {
      "id": 1
    }
  }
}
```

The easiest way to execute a GraphQL query is to use the GraphiQL instance
embedded in the Hasura web interface.

![graphiql](hasura-graphiql.png)

# GraphQL queries

With the same GraphiQL interface, we can run queries such as:

```graphql
{
  authors {
   	id
    name
  }
}
```

having this result:

```json
{
  "data": {
    "authors": [
      {
        "id": 1,
        "name": "Leonardo Cecchi"
      },
      {
        "id": 6,
        "name": "Jaime Silvela"
      }
    ]
  }
}
```

Or:

```graphql
{
  articles {
   	title
    author {
      name
    }
  }
}
```

With the following result:

```json
  {
  "data": {
    "articles": [
      {
        "title": "Hasura is great!",
        "author": {
          "name": "Leonardo Cecchi"
        }
      },
      {
        "title": "Article from Leonardo",
        "author": {
          "name": "Leonardo Cecchi"
        }
      },
      {
        "title": "Third article from Leonardo",
        "author": {
          "name": "Leonardo Cecchi"
        }
      },
      {
        "title": "Introducing Ciclops",
        "author": {
          "name": "Jaime Silvela"
        }
      }
    ]
  }
}
```
