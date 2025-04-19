---
title: "Quickstart: running CloudNativePG from scratch on your own machine"
date: 2024-04-09T14:54:11+02:00
draft: true
image:
    url: child-with-laptop.jpg
    attribution: Photo by <a href="https://www.publicdomainpictures.net/en/browse-author.php?a=2642">Alan Toniolo de Carvalho</a> on <a href="https://www.publicdomainpictures.net/en/free-download.php?image=child-with-laptop&id=6884">Child With Laptop</a>
author: jbattiato
tags:
 - blog
 - information
 - tutorial
summary: A quickstart to run CloudNativePG from scratch on your own machine.
---

This is the first of many posts for our new content's section dedicated to tutorials:
a series of hands-on guide to allow anyone learn more about CloudNativePG by doing.

This first tutorial couldn't be anything but a quickstart to run CloudNativePG
on your own machine from scratch.

# K8S setup

The first step is to have a kubernetes distribution up and running on your laptop.
I choose `kind` as it is one of the recommended Kubernetes distribution suggested by CNPG team as well.

NOTE: `kind` nodes run inside docker containers, therfore you need to have `docker` as a prerequisite.

To install `kind` visit: [https://kind.sigs.k8s.io/docs/user/quick-start#installation](https://kind.sigs.k8s.io/docs/user/quick-start#installation)

Once installed, you can create a K8S cluster by running:
``` sh
kind create cluster --name cnpg-test --config multi-node-config.yaml
```

Where `multi-node-config.yaml` contains the following:
``` yaml
# three nodes (two workers) cluster config
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
```

# Install kubectl

To interact with Kubernetes we need `kubectl` as a client tool.

The binary can be downloaded here: [https://kubernetes.io/docs/tasks/tools/#kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

Once installed you could try it by running:
``` sh
kubectl get nodes
```

It should show the list of `kind` nodes in the output.

# Install CloudNativePG

The Operator and its resources are easily retrievable inside a single YAML manifest
from github, for any releases.

Here is an example for the 1.22 version:

[https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.22/releases/cnpg-1.22.2.yaml](https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.22/releases/cnpg-1.22.2.yaml)

You can install it by running:
``` sh
kubectl apply --server-side -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.22/releases/cnpg-1.22.2.yaml
```

Since the Operator resources will be inside the newly created namespace, you can verify its deployment by running:
``` sh
kubectl get deployment -n cnpg-system cnpg-controller-manager
```

# Deploy a PG cluster

Now that we have met all the prereuisite, we can deploy our first PostgreSQL cluster in Kubernetes.

The definition of a cluster is written in YAML format, and can be passed to the `kubectl` command as
a file or as a standard input:
``` sh
kubect apply -f cluster-example.yaml
```

Or:
``` sh
cat <<EOF > kubectl apply -f -
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: cluster-example
spec:
  instances: 2

  storage:
    size: 1Gi
```

To verify the `Cluster` resource is actually deployed:
``` sh
kubectl get cluster
```

And its pods:
``` sh
kubectl get pods
```

So far so good!

Now that you have all the knowledge and the tools to run PostgreSQL in Kubernetes on your own machine, you can start experimenting CNPG, and learn more following the next tutorials.

