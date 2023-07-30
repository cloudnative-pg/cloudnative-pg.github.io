---
title: "Finding holes in structs and reducing memory usage. Part I"
date: 2023-07-29T11:29:52+02:00
draft: true
image:
    url: 
    attribution: 
author: jgonzalez
tags:
 - blog
 - information
 - memory
 - programming
 - pahole
 - pyroscope
 - applications
summary: Finding holes in the operator structs and reducing the memory usage of CloudNativePG operator. Part I.
---

In this small series of posts, I aim to illustrate how we reduced the memory footprint and usage of the CloudNativePG 
operator using a traditional tool, `pahole`, and a new one, [Pyroscope](https://pyroscope.io/).

The first step in any memory usage investigation should be understanding your tools. That's the aim of this first post: 
to explain and provide example usage of the tools we will later use to gather statistics and help us reduce memory  usage.

Let's dive right into it.

## The handy and useful *pahole*

Nowadays, it's very common to find programmers creating fantastic and useful tools for daily use. However, occasionally,
we find that old tools are all we need. `pahole` is one of those tools that remains as useful today as it was on its 
first day!

In 2007 Arnaldo Carvalho de Melo published the paper [The 7 dwarves: debugging information beyond gdb](https://www.kernel.org/doc/ols/2007/ols2007v2-pages-35-44.pdf)
The paper offers an excellent and concise explanation of DWARF, which we will use as a starting
point to explain how to use this tool.

The underlying concept of pahole is to identify data that is not aligned in memory to their word-size. Misaligned data 
creates *holes* in the memory because compilers align structs to match the CPU's word-size. In our case, we will 
work with a 64bit CPU, but feel free to experiment with other architectures.

Understanding this theory might be challenging initially, so let's proceed with an example using the operator. I'll 
assume you already have the operator cloned, can compile it, and have the binaries in the `bin/` directory.

The pahole tools can be installed on any Linux distribution. If you don't have it, you can look for the package with 
the same name – it's one of those tools that have its own package.

Here is the basic usage of `pahole`:

```shell
pahole bin/manager
```

As you can see, there's a lot of data that might not be so useful; let's run `pahole`
with some of those amazing arguments

```shell
pahole --prefix_filter=github.com/cloudnative-pg/cloudnative-pg  bin/manager
```

You might already have guessed it, but let's clarify it anyway: `--prefix_filter` is used to filter the structs that 
start with `github.com/cloudnative-pg/cloudnative-pg`. Luckily for us, Go prefixes the struct with the full path, so we 
can filter and examine only the bunch of structs we're interested in.

We can page through the vast amount of information by piping to a pager (say 
`less`). Let's look for the phrase  `try to pack`. The first occurrence we find
is here:

```text
struct github.com/cloudnative-pg/cloudnative-pg/internal/configuration.Data {
        struct string              WebhookCertDir;       /*     0    16 */
        struct string              WatchNamespace;       /*    16    16 */
        bool                       EnablePodDebugging;   /*    32     1 */

        /* XXX 7 bytes hole, try to pack */

        struct string              OperatorNamespace;    /*    40    16 */
        struct string              OperatorPullSecretName; /*    56    16 */
        /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
        struct string              OperatorImageName;    /*    72    16 */
        struct string              PostgresImageName;    /*    88    16 */
        struct []string            InheritedAnnotations; /*   104    24 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct []string            InheritedLabels;      /*   128    24 */
        bool                       EnableInstanceManagerInplaceUpdates; /*   152     1 */
        bool                       EnableAzurePVCUpdates; /*   153     1 */

        /* XXX 6 bytes hole, try to pack */

        struct string              MonitoringQueriesConfigmap; /*   160    16 */
        struct string              MonitoringQueriesSecret; /*   176    16 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        bool                       CreateAnyService;     /*   192     1 */

        /* size: 200, cachelines: 4, members: 14 */
        /* sum members: 180, holes: 2, sum holes: 13 */
        /* padding: 7 */
        /* last cacheline: 8 bytes */
};
```

In this structure from `github.com/cloudnative-pg/cloudnative-pg/internal/configuration.Data`, we see two holes, leading 
to a total struct size of 200 bytes, spanning across 4 [cachelines](example.com/cacheline). The presence of these 13 bytes across 2 holes shows possible areas for
optimization. It's important to remember this original size, to verify if our modifications have the intended effect.

One approach to optimizing this struct is to relocate `EnablePodDebugging` closer to `EnableAzurePVCUpdates` and move 
`CreateAnyService` nearby as well, thereby reducing the struct size. Implementing these changes and rerunning `pahole` 
results in a struct size of 184 bytes, down from 200, with only one hole remaining.

```text
struct github.com/cloudnative-pg/cloudnative-pg/internal/configuration.Data {
        struct string              WebhookCertDir;       /*     0    16 */
        struct string              WatchNamespace;       /*    16    16 */
        struct string              OperatorNamespace;    /*    32    16 */
        struct string              OperatorPullSecretName; /*    48    16 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct string              OperatorImageName;    /*    64    16 */
        struct string              PostgresImageName;    /*    80    16 */
        struct []string            InheritedAnnotations; /*    96    24 */
        struct []string            InheritedLabels;      /*   120    24 */
        /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
        bool                       EnableInstanceManagerInplaceUpdates; /*   144     1 */
        bool                       EnableAzurePVCUpdates; /*   145     1 */
        bool                       EnablePodDebugging;   /*   146     1 */
        bool                       CreateAnyService;     /*   147     1 */

        /* XXX 4 bytes hole, try to pack */

        struct string              MonitoringQueriesConfigmap; /*   152    16 */
        struct string              MonitoringQueriesSecret; /*   168    16 */

        /* size: 184, cachelines: 3, members: 14 */
        /* sum members: 180, holes: 1, sum holes: 4 */
        /* last cacheline: 56 bytes */
};
```

The offset and size of each variable are
detailed in comments. For instance, `EnablePodDebugging`, having a size of 1, leaves a 7-byte hole. This leads to an arrangement that doesn't fit the cacheline well, and results in memory wastage.

One approach to overcome this issue is by reordering the variables in the struct, particularly the boolean variables,
which are just 1 byte in size. Moving these towards the end could help optimize the structure.

The rearranged structure looks like this:

```text
struct github.com/cloudnative-pg/cloudnative-pg/internal/configuration.Data {
        struct string              WebhookCertDir;       /*     0    16 */
        struct string              WatchNamespace;       /*    16    16 */
        struct string              OperatorNamespace;    /*    32    16 */
        struct string              OperatorPullSecretName; /*    48    16 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct string              OperatorImageName;    /*    64    16 */
        struct string              PostgresImageName;    /*    80    16 */
        struct []string            InheritedAnnotations; /*    96    24 */
        struct []string            InheritedLabels;      /*   120    24 */
        /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
        struct string              MonitoringQueriesConfigmap; /*   144    16 */
        struct string              MonitoringQueriesSecret; /*   160    16 */
        bool                       EnableInstanceManagerInplaceUpdates; /*   176     1 */
        bool                       EnableAzurePVCUpdates; /*   177     1 */
        bool                       EnablePodDebugging;   /*   178     1 */
        bool                       CreateAnyService;     /*   179     1 */

        /* size: 184, cachelines: 3, members: 14 */
        /* padding: 4 */
        /* last cacheline: 56 bytes */
};
```

While this rearrangement doesn't reduce the size of the struct, it removes the 4-byte hole, ensuring better memory
usage. Despite the structure remaining 184 bytes in size, there's a 4-byte padding after the final cacheline. The
advantage is that we've moved from using 4 cachelines to just 3, improving memory usage and potentially
improving performance.

While optimizing a few bytes or cachelines might seem unnecessary due to the
advent of larger
computers, it's essential when you need to run a piece of software on a server for extended periods without facing
performance or memory issues.

This is just a simple example demonstrating the utility of pahole. In a subsequent post, we'll delve into more complex
structures and explain why pointers are so crucial. For additional improvements in the same vein, you can check out
this [pull request in CloudNativePG](https://github.com/cloudnative-pg/cloudnative-pg/pull/2458).

## Pyroscope

A quick search using your favorite search engine (duckduckgo right?) will provide you numerous ways
to install and use Pyroscope. Still, I'd like to discuss a few notable aspects.

While the tool's basic functionality might suffice, there may be instances where you'll need to dive into more advanced
features. Therefore, I suggest referring to the [Pyroscope Documentation](https://pyroscope.io/docs/) for more in-depth
usage.

Our focus will be on deploying and using Pyroscope with CloudNativePG, not other platforms, and we won't cover
installing it in more intricate environments.

Ok, but why Pyroscope? Easy! I saw the project on Twitter a long time a go and I tested it and
fell in love with its simplicity.

For those new to profiling, you might appreciate this definition:

> Profiling is an effective way of understanding which parts of your application are consuming the most resources.

And let's keep it that way, because there's more complex stuff about profiling which are not in the
scope of this post.

### First step

Firstly, ensure that CloudNativePG's pprof server is enabled (`--pprof-server=true`), without which the rest of the
setup will fail.

### History, Deployment and usage

When we started the development the operator in 2019, one of the first things we solved was the
way we automated the installation and deployment of the operator in a development environment
(laptops) so we (well mostly Marco Nenciarini) created a beautiful script called `setup-cluster.sh`
which is used for development and also to run our E2E tests.

After years of refinement, that script has become a really powerful tool, so if you're
interested in doing some testing or development on the operator, you should use that script.

Let's get our hands dirty! -- too much text isn't good!
Let's run our setup script

```shell
./hack/setup-cluster.sh -r create load deploy load-helper-images pyroscope
```

A brief explanation:

* `create`: starts a KinD cluster
* `load`: will build the operator image and load it into the KinD cluster
* `deploy`: deploy the operator using the yaml manifest
* `load-help-images`: download a bunch of useful images and load them into the KinD cluster to speed up any process
* `pyroscope`: deploys pyroscope using a helm chart in the operator namespace with a configuration to listen on the operator ports

After the script finishes you should have a local Kubernetes cluster, and the
CloudNativePG operator running, so,
let's see how pyroscope is doing over there, let's connect

```shell
kubectl -n cnpg-system port-forward services/pyroscope 4040:4040
```

Now go to your browser and open the URL [http://localhost:4040/](http://localhost:4040/).
If everything is working you should
be able to see the Pyroscope interface running.

If that's not the case, you should check if the port forward works, as that's the thing
that fails most of the time

### Destroying the cluster

When you finish playing with that beautiful dashboard, the time comes to destroy everything, you
can always use this command:

```shell
./hack/setup-cluster.sh -r destroy
```

That will destroy the entire cluster and will free the resources in your computer

## Closing words

`Pyroscope` and `pahole` are really useful tools but can only show you what's going on inside your code. The
difficult part you will have to do by hand. Honest work, as my friend Philippe says.

When we talk about performance and memory usage nowadays it is sometimes seen as arcane, but
in the next part I'll explain that this is very relevant and that you may be saving a lot of
memory.

I will not cover the CPU usage, but probably that could be a part III if people like these.
