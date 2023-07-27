---
title: "Finding holes in structs and reducing memory usage Part I"
date: 
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
summary: Finding holes in the operator structs and reducing the memory usage of CloudNativePG operator Part I.
---

With this small series of post, I would like to explain how we reduce the memory footprint and usage
of the CloudNativePG operator using a classic tool like `pahole` and a new one like [Pyroscope](https://pyroscope.io/)

The first step on every memory usage investigation must be knowing your tools, and that's
the objective of this first part, explaining and providing some example usage of the tools we use
to later, in the second part show the stats and how the memory was reduced.

Without hesitate let's start to tell some stories

# The handy and useful pahole

Nowadays is really common to find people programming awesome and amazing tools to be used every day,
but, sometimes, old tools are all we need and `pahole` is one of those tools that after many years
still being as useful as it was the first day!

In 2007 Arnaldo Carvalho de Melo published the paper [The 7 dwarves: debugging information beyond gdb](https://www.kernel.org/doc/ols/2007/ols2007v2-pages-35-44.pdf)
were we can see a really awesome and compact explanation of DWARF, which we will use as a starting
point to explain how to use this tool.

The idea behind `pahole` is to find that data that is not aligned in memory in their word-size, 
meaning that if that data is not aligned it will create *holes* in the struct because the compilers
will align those struct to match the word-size of the CPU, we will only work with a 64bits CPU,
but if up to reader to go for other architectures and test.

That's the theory, but it's really hard to understand at first glance, so let's start with an
example using the operator, I'll presume you already have operator cloned and that you can compile
it and have the binaries in the `bin/` directory.

The `pahole` tools can be installed on any Linux distribution, but if you don't have it you can look
for the package with the same name, yes, it's one of those tools that has its own package.

Following command is the basic usage of `pahole`
```shell
pahole bin/manager
```
As you can see, there's a lot of stuff there that may not be so useful, but let's run `pahole`
with some of those amazing arguments

```shell
pahole --prefix_filter=github.com/cloudnative-pg/cloudnative-pg  bin/manager
```

The reader can guess, but let's explain it anyway `--prefix_filter` will be used to filter the
struct that start with `github.com/cloudnative-pg/cloudnative-pg`, fortunately for us, Go prefix
the struct with the full path, so we can filter and check only the bunch of struct we want.

In the big amount of information we found, we can pipe it with `less` and start looking for
the words `try to pack`, and the first match for us is here:

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

Here we can see that we have 2 holes, and as we can read at the end, the size of the struct
is 200, using 4 cachelines (this post will not cover what a cacheline is but if you want GO HERE),
but the important part is that we have 2 holes that sum 13 bytes! that's crazy, but as soon as we
see those holes we can check that there's a possible fix here. It's important that when you do this
you keep a copy of the size, so you can check if your work did actually work.

Some order in the struct will be moving that `EnablePodDebugging` close to `EnableAzurePVCUpdates`
and also move `CreateAnyService` close to too, that should reduce the size, let's make those
changes and run `pahole` again.

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
Now, we have only a hole, but this helps to explain why this happens, and why we reduce the size
of the struct from 200 to 184. The first number in the comment format indicates the offset of
that variable from the beginning of the struct and the second one, the size, as you can see in
the first example, that variable `EnablePodDebugging` had a size of `1` meaning that to match
the word-size requires another 7 bytes, at this point we had our first big hole, and moving that
down allowed that the following four elements of size 16 will fit in 64bytes using an entire
cacheline, and then reducing the size of struct. But what about those 4 bytes after the boolean,
it is possible to reduce the size and not loose those 4 bytes? Well, let's try moving those `bool`
down to the end

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
Ok, that looks much better, we don't have a 4 bytes hole, but wait, we didn't reduce the size
of the struct, why? well, because now we have a padding of 4, meaning that there's 4 bytes
to be used after the end of the 3 cacheline, but the good news is that we're using only 3
cachelines and not 4, that means that while we reduced the memory usage we also improved a little
bit the performance.

The argument I usually read/hear about these kind of improvements it's that nowadays no one cares
about 6 bytes or cachelines because we have big computers, well, my answer is always the same, is
not that works in your computer, needs to be running for months and months in a server without
having any performance or memory issues, and if for some memory leak or malfunction in the code
that struct replicates many times those 4 bytes will ended up being megabytes.

This was only an example with a clear small change to show how `pahole` works, in the second part
we will go through more complex structs, and we will explain more how pointers works and
why you should care so much about it.

By the time this was written there was a PR opened in the project showing more changes like this,
if you want to check it, read and learn more before the second part you can check it here https://github.com/cloudnative-pg/cloudnative-pg/pull/2458

# Pyroscope

A quick search using your favorite search engine (duckduckgo right?) will provide you tons of way
to install and how to use Pyroscope, but I really like to explain a couple of things.

The basic usage of the tools may be good enough, but sometimes, you'll have to go really deep into
some more cool features you may need, so please refer to the [Pyroscope Documentation](https://pyroscope.io/docs/) for more deep usage

We will show how to deploy and use it with CloudNativePG, not with any other things, and how to
install it in more complex environment it's not covered here.

Ok, but why Pyroscope? Easy! I saw the project in twitter a long time a go and I tested it and
I loved how simple and easy to use is.

So, if you don't know anything about Profiling, probably you will like this definition
```text
Profiling is an effective way of understanding which parts of your application are consuming the most resources.
```
And let's keep it that way, because there's more complex stuff about profiling and is not in the
scope of this post.

## First step
CloudNativePG has a beautiful pprof server that can be enabled by passing `--pprof-server=true`
when the operator is deployed, make sure to have this set to `true` otherwise, everything else
will fail

## History, Deploy and usage

When we started the develop the operator in 2019, one of the first things we solved was the
way we automated the installation and deployment of the operator in a development environment
(laptops) so we(well mostly Marco Nenciarini) created a beautiful script called `setup-cluster.sh` 
that is used for development and also to run our E2E tests.

Well, turns out that after a couple of years, that script is a really powerful tool, so if your
interested on start testing and do some development on the operator, you should use that script.

Hands on! because must text isn't good!, let's run our setup script 

```shell
./hack/setup-cluster.sh -r create load deploy load-helper-images pyroscope
```

A brief explanation:
* `create`: start a kind cluster
* `load`: will build the operator image and load into the kind cluster
* `deploy`: run the `kubectl apply` to deploy the operator using the yaml files
* `load-help-images`: download a bunch of useful images and load them into the kind cluster to speed up any process
* `pyroscope`: deploys pyroscope using a helm chart in the operator namespace with a configuration to listen on the operator ports

After the script finish you should have a local Kubernetes cluster and the operator running, so,
let's see how pyroscope is doing over there, let's connect

```shell
kubectl -n cnpg-system port-forward services/pyroscope 4040:4040
```

Now go to your browser and open the URL http://localhost:4040/ if everything is working you should
be able so ee a beautiful interface with Pyroscope running.

If that's not the case, you can always check if the port forward works, because that's the thing
that fails most of the time

## Destroying the cluster

When you finish playing with that beautiful dashboard, the time comes to destroy everything, you
can always use this command:
```shell
./hack/setup-cluster.sh -r destroy
```
That will destroy the entire cluster and will free the resources in your computer


# Closing words

These are really useful tools but only useful to show you what's going on inside your code you
will have to do the work by hand, honest work as my friend Philippe says.

When we talk about performance and memory usage nowadays is something known as black magic, but
in the next part I'll explain that this is not like that and that you may be saving a lot of
memory.

I will not cover the CPU usage, but probably that could be a part III if people like these.
