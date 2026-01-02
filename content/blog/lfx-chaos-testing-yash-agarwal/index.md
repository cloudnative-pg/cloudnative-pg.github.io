---
title: "Chaos testing the CloudNativePG project"
date: 2026-01-05
draft: false
image:
    url: yash.jpeg
    attribution:
authors:
 - fdrees
tags:
 - lfx
 - mentorship
 - kubernetes
 - postgresql
 - litmus
 - devops
summary: "Meet the mentee: Yash Agarwal worked with the project maintainers on adding 
chaos testing to CloudNativePG, as part of the LFX mentorship program." 
---

In the summer we wrote about how CloudNativePG was back for the September-
October-November LFX term with [several projects for mentoring](https://cloudnative-pg.io/blog/2025-term3-lfx-cncf-mentorship/). One of them was 
around Chaos Testing. 

Yash Agarwal worked with mentors and CloudNativePG maintainers Gabriele Bartolini, 
Marco Nenciarini, Francesco Canovai, and Jonathan Gonzalez, to enhance the 
project's test coverage. Introducing LitmusChaos, a comprehensive chaos testing 
framework, the team designed automated chaos experiments for common failure 
scenarios, integrated them into CI/CD workflows, and collected observability 
metrics like failover time and data consistency. I had a chat with Yash about 
his work, and about how he got into Tech in the first place. 

## Start at the beginning

Yash's venture into programming started when he got introduced to Python in 11th 
grade. He was always fascinated by technology, and got further inspired to pursue 
a career as a programmer by his cousin Amit, a software developer.

Today Yash is a full stack developer intern at Seeqlo, where he, among other 
things, focuses on streamlining cloud operations and optimizing performance. 
Based in Bengaluru, India, Yash is a member of Point Blank, a student-run tech 
community dedicated to learning together. 

He looks back at working with the CloudNativePG team as a "great learning experience". 
They met twice a week for 30 minutes to discuss the progress of the project. 
One thing that Yash says he learned is to have more patience. 

## Chaos testing

The new [chaos-testing repository](https://github.com/cloudnative-pg/chaos-testing) Yash worked on provides automated tools to validate 
PostgreSQL cluster resilience under failure conditions. It combines two testing 
approaches:

* Jepsen Consistency Testing - Uses the famous Jepsen framework to perform 
mathematical proofs of database consistency. It continuously runs database 
operations (50 ops/sec) and validates that no data is lost or corrupted during 
failures.
* LitmusChaos Fault Injection - Uses LitmusChaos to simulate real-world failures 
by repeatedly deleting the PostgreSQL primary pod (every 60-180 seconds), 
forcing CloudNativePG to perform automatic failover.

You can read more about the project in the repository's [README](https://github.com/cloudnative-pg/chaos-testing/blob/main/README.md). And, in case 
you're curious, here's Yash's PR: https://github.com/cloudnative-pg/chaos-testing/pull/3 


## Contributing to Litmus itself

Yash wasn't able to find how to get the chaos engine to target the primary pods 
since the appKind CloudNativePG uses isn't natively supported by Litmus. "I tried 
many things, but when I tried AppKind as "cluster" it worked! I read the Litmus 
code and found that there were some validations which prevented "Cluster" (capital 
"C") from working. This behavior was not described in Litmus' documentation, 
which meant I could submit a PR and prevent the next person from running into 
the same issue!"

## What's next?

In the second half of his 3rd year, Yash is exploring opportunities in the field 
of backend and DevOps. "I will surely try to contribute more towards CloudNativePG 
when time permits!" You can follow Yash's work on [GitHub](https://github.com/XploY04).
