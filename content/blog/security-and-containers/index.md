---
title: "Security and containers in Cloud Native PostgreSQL"
date: 2021-03-01T16:06:00Z
draft: true
image:
    url: ali-kazal-h5VjkUqMCsc-unsplash.jpg
    attribution: Photo by <a href="https://unsplash.com/@lureofadventure?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Ali Kazal</a> on <a href="https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
author: "Gabriele"
time: 6 min read
tags: security
draft: true
avatar: 
  image: avatar_G.svg 
summary: How should you securely deploy PostgreSQL (and other tools) to Kubernetes?
---

In this blog post, we'll analyze in more depth some relevant security aspects
that [EDB's Cloud Native PostgreSQL](https://docs.enterprisedb.io/cloud-native-postgresql/)
implements at the "Container" level, the third layer of the
[4C's security model in Kubernetes](https://www.enterprisedb.com/blog/4cs-security-model-kubernetes)
--- which I covered in my last blog.

Such a layer also includes aspects that concern the security settings of the
Kubernetes' Container Runtime Interface. However, considering that they depend
on the actual container runtime implementation (containerd, or CRI-O, for
example), we won't cover them in this post.

Instead, we will be focusing more on aspects such as image building,
vulnerability scanning, image distribution as well as required user privileges
at runtime and updates/patch management of a system.

The same concepts apply to both the operator and the operand images for Cloud
Native PostgreSQL (note: the operand is the application that is managed by the
operator, in our case the PostgreSQL or EDB Postgres Advanced instance).

### From build to distribution of container images

*D.O.C.G.* is a level (the highest) of a classification system for Italian
wines. It guarantees, through a sealed cork, that a particular wine
comes from a given area, and that the whole process has followed
specific rules before it is distributed. In order to get the same DOCG
level with container images, there are some good practices that we can
follow and that derive from DevOps principles where automation is key.

Take, for example,
[*the way we build container images for PostgreSQL*](https://github.com/EnterpriseDB/docker-postgresql).
Thanks to pipelines driven by Github Actions, every day new container images are
automatically built for all the community supported versions of PostgreSQL through a
[*Dockerfile*](https://github.com/EnterpriseDB/docker-postgresql/blob/main/13/Dockerfile).
These images are based on RedHat UBI 8 --- which is signed by RedHat.
Additional layers contain RPM packages that are installed from trusted
repositories such as the PostgreSQL Community.

At the end of the process, the container images are automatically pushed
to the [public RedHat Quay.io container registry for PostgreSQL](https://quay.io/repository/enterprisedb/postgresql).
Here they are automatically scanned for known vulnerabilities by Quay
Security Scanner, the results of which are publicly available. Users can
therefore download our images from a trusted source like Quay. RedHat
periodically releases UBI security updates which are then embedded in
our container images by our daily pipelines.

The same process applies to the other container images that EDB
distributes via Quay for Cloud Native products, including the operator.
Such a system of trust for container images, which resembles the DOCG
for wine, can be further improved by signing our images - something we
are targeting for the next quarter.

### Principle of least privilege during execution

A container should be designed and built to run an application that can
exclusively access the information and the resources that are needed to
achieve its goals. In Information Technology, this is known as the
principle of least privilege (PoLP) - sometimes also referred to as the
principle of least authority (PoLA).

As a result, containers in Kubernetes should run as unprivileged users,
unless otherwise required. This is extremely important from a security
point of view as it prevents at the source any privilege escalation
attempt originating inside the container to gain control of the outer
host machine.

We designed and built Cloud Native PostgreSQL to operate in such a way,
as both the operator and the operand images are built as Immutable
Application Containers - please refer to the [*\"Why EDB chose Immutable
Application Containers\"
blog*](https://www.enterprisedb.com/blog/why-edb-chose-immutable-application-containers)
post for more details.

Leaving aside, for now, the operator container image, let's concentrate
on the more important container image for the operand/application
running PostgreSQL.

The application container paradigm requires that the operand container
runs a single process, known as the entry point: specifically, an
application called the instance manager - which is responsible for
controlling and running the main PostgreSQL server process. The instance
manager aligns the PostgreSQL server process status (the instance) with
the status of the cluster. To do that, it uses a role that is
automatically generated by the operator and that can only work on
objects that belong to the same PostgreSQL cluster. This RBAC
implementation is another application of the principle of least
privilege (PoLP).

The container exists for the sole duration of the PostgreSQL process,
which logs directly to the standard output and standard error channels
as recommended by the best practices in Kubernetes. The PostgreSQL
process does not require root privileges and can run as the "postgres"
user inside the container, adhering to PoLP.

Additionally, Cloud Native PostgreSQL supports some Kubernetes Pod
Security Policies and Security Contexts (runAsUser, runAsGroup and
FSGroup) to enforce that those containers run and access the file system
as an unprivileged user.

A final note is about system containers, the opposite of application
containers: they run other processes and services such as "sshd" or
"syslog". The fact that the OpenSSH daemon is not running prevents
remote access to the Postgres containers and is a relief from a security
standpoint. Immutability is what makes SSH access superfluous.

### Why immutability matters

We are used to accessing our machines to perform incremental system and
security updates and to operate in a "mutable" and imperative way. That
is not necessary in Kubernetes---and actually, it is highly discouraged.

Container images of the application we want to run (PostgreSQL and the
operator in our case) are versioned and designed to be immutable,
meaning that containers are not updated, they are simply replaced.
Kubernetes is designed to support application deployments in a
declarative configuration manner, by upgrading one pod at a time without
generating any service downtime.

From a security and compliance point of view, immutability and
declarative configuration in Kubernetes enable organizations to
implement stricter version control and a more effective patch management
of their systems. The concept of status in Kubernetes at any time
provides a clear snapshot of the whole infrastructure contained in the
cluster.

Our operator defines a custom resource called "Cluster" that somehow
extends the "Deployment" resource in Kubernetes, introducing the
primary/standby architecture logic of the PostgreSQL database and
managing rollout deployments and rolling updates.

For example, suppose you have a PostgreSQL 13.1 cluster made up of 3
nodes (1 primary and 2 replicas) defined with the following YAML file:

```yaml
apiVersion: postgresql.k8s.enterprisedb.io/v1
kind: Cluster
metadata:
  name: website
  namespace: website
spec:
  description: \"Backend database for our website application\"
  imageName: quay.io/enterprisedb/postgresql:13.1
  instances: 3
  storage:
    storageClass: standard
    size: 10Gi
```

Once created, Kubernetes starts the rollout deployment, by automatically
creating the primary first, then the first standby, and finally the
third.

You now want to update to PostgreSQL 13.2 as it ships with an important
security fix. All you need to do is update the configuration file and
change the "imageName" to "quay.io/enterprisedb/postgresql:13.2". Then
run "kubectl apply". The operator will initiate a rolling update
procedure, by automatically updating the standby servers one at a time
and then issuing a switchover of the primary (this can also be manually
controlled), with no perceivable downtime for the applications.

So, no more excuse not to perform a minor update of PostgreSQL in
production - as through immutability you are 100% sure that what you are
running in production is identical to what is running in staging and on
your developers' laptop.

### Conclusion

In this post, we have covered two main aspects of container images for
Cloud Native PostgreSQL from a security perspective:

-   how they are built and distributed
-   how they run, respecting the principle of least authority

We have then shifted our attention to another important aspect of
security: keeping systems updated by generating those healthy and
neglectable regular downtimes that increase the long-term uptime of a
system (and reduce the risk of the business).

Our commitment to security at the container level won't end here. We
will continue to improve our container\'s security, how they are built,
how they are distributed and ultimately deployed. We will keep looking
out for emerging best practices and guidelines such as the "[*Container
Image Creation and Deployment
Guide*](https://dl.dod.cyber.mil/wp-content/uploads/devsecops/pdf/DevSecOps_Enterprise_Container_Image_Creation_and_Deployment_Guide_2.6-Public-Release.pdf)"
developed by the Defense Information Systems Agency (DISA) for the
Department of Defense of the United States Government.

Feel free to [*try Cloud Native
PostgreSQL*](https://docs.enterprisedb.io/cloud-native-postgresql/1.0.0/evaluation/)
and inspect both the container images and the containers for security
vulnerabilities and flaws.

In the upcoming blog posts, we will provide insights on some of the
decisions we made and the solutions we adopted at the PostgreSQL cluster
level.
