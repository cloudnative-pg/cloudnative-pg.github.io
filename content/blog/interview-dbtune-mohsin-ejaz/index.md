---
title: ""
date: 2026-04-16
draft: false
image:
    url: 
    attribution:
authors:
 - fdrees
tags:
 - kubernetes
 - postgresql
 - open-source
summary: "We had a chance to talk to Mohsin Ejaz, Senior DevOps Engineer at DBtune, an agentic AI database optimization service." 
---

 
Mohsin Ejaz is a Senior DevOps Engineer at DBtune, where he focuses on PostgreSQL 
performance tuning across diverse infrastructure—from on-prem to managed 
services. Lately, a major part of his work involves working directly with 
DBtune’s PostgreSQL CloudNativePG integration. In fact, leading the PostgreSQL 
CloudNativePG integration was a highlight for Mohsin, he owned the feature 
end-to-end, from coding the Kubernetes agent to writing the technical 
documentation. 

## A bit of background

When Mohsin graduated back in 2005, he says he was just following the trend: 
IT was the 'place to be’. He started with EDB as a QA engineer, but he quickly 
became passionate about automation. That passion pushed him early on into 
Configuration Management, the field we now recognize as DevOps or Platform 
Engineering.  

After 17 years at EDB, Mohsin joined DBtune. "It was an opportunity to take 
decades of infrastructure experience and apply it to leading AI innovation. 
The most exciting part of working for DBTune is definitely the startup 
environment and the opportunity to wear many hats. I’m never just 'doing 
DevOps', on any given day, I might shift from deep technical benchmarking and 
research to join pre-sales or customer engagement calls." Mohnsin says it’s 
satisfying to bridge the gap between building the deep tech and seeing how it 
solves a customer's real-world business problem. 

The PostgreSQL community is Mohsin's long-term 'home'. "I have been active in 
it for years, and I always make it a point to step up for volunteer or support 
roles at events. It’s important to give back to the ecosystem that built my 
career." You might have seen Mohsin at a PostgreSQL community event before, he 
gave several public talks already. 

Mohsin has followed the CloudNativePG journey closely from its inception. He 
stays involved primarily through the conference circuit: "I attend CloudNativePG 
workshops and Kubernetes-focused PostgreSQL sessions whenever I can, to engage 
with the community." 

Beyond typical DevOps responsibilities, Mohsin recently led DBtune's SOC 2 Type 
II compliance effort to a successful completion. 

## Choosing CloudNativePG 

CloudNativePG was the obvious choice for their first Kubernetes-native integration. 
"It has rapidly become the de facto standard for PostgreSQL on Kubernetes — it's 
actively maintained, and handles complex things like failover and backups with 
incredible reliability." 

Kubernetes and DBtune share a goal-oriented philosophy, says Mohsin. "Users 
define what they want rather than how to get there. Kubernetes reconciles 
infrastructure state, while DBtune autonomously optimizes database performance 
based on the observed workload." This shared approach made CloudNativePG a 
natural fit for integration.

Several features made CloudNativePG stand out to the team: 
* Declarative configuration via CRDs: Being able to apply PostgreSQL parameter 
changes simply by patching the Kubernetes object—rather than trying to hack 
config files inside a running container—is incredibly elegant. This is crucial 
for building a safe automation tool. 
* Automatic failover: CNPG handles actual failover, promoting replicas and 
restoring cluster health. DBtune just needs to detect it and respond, not 
orchestrate it. This clean separation makes the whole integration simpler. 
It ensures that DBtune’s tuning agent operates on a solid, resilient foundation. 
* Simple pod role detection: DBtune relies heavily on standard Kubernetes labels 
(like `role=primary`) so that their agent can instantly discover and connect to 
the right target database. This makes DBtune’s service discovery logic much 
cleaner. 

## Integrating with CloudNativePG 

DBtune is an agentic AI database optimization service that automatically tunes 
PostgreSQL runtime parameters for optimal performance. Their stack is built to 
handle diverse PostgreSQL environments across different infrastructure layers. 
DBTune is hosted on AWS, using RDS for their own internal PostgreSQL database 
and ECS for container management.  

On the agent side they use a Golang-based open-source agent that communicates 
with various providers like AWS RDS, Azure Flex Server, Google Cloud SQL, Aiven, 
self-hosted PostgreSQL in VMs or on bare metal, and of course CloudNativePG.  

Their PostgreSQL CloudNativePG integration, because it is Kubernetes-native, 
interacts directly with the Kubernetes API, specifically patching CloudNativePG 
Cluster CRD rather than just executing standard SQL commands. This allows DBtune 
to apply automated PostgreSQL parameter tuning on Kubernetes seamlessly through 
the operator.   

Adding CloudNativePG support to DBtune's agent required a deep dive into how 
the operator manages clusters, handles configuration changes, and applies agentic 
AI performance tuning in a Kubernetes-native way.  

Now that DBtune's offering CloudNativePG as a supported provider, Mohsin's role 
is evolving. "I have become the go-to person for troubleshooting deployments and 
helping customers configure the agent in their K8s environments. On any given day, 
I might shift from deep technical benchmarking and research to join user calls. 


## Getting started with CloudNativePG 

Reflecting on the start of the project at DBtune, Mohsin says that while 
CloudNativePG is user-friendly, the "difficulty" lies more in the underlying 
architecture than the software itself. "It's the general learning curve of 
Kubernetes operators. You have to shift your mindset to fully appreciate 
declarative configuration and reconciliation loops. That initial hurdle exists 
for anyone new to running stateful workloads on K8s, but once that mental model 
'clicks,' working with CloudNativePG feels incredibly elegant." 

The biggest head-scratcher the team hit was a conflict between what they wanted 
to tune and what CloudNativePG needs to control. The DBtune engine is used to 
having full reign over `postgresql.conf`. "But we quickly learned that 
CloudNativePG reserves certain parameters, like `archive_mode` or replication 
slots, to guarantee things like replication and high availability work correctly. 

During the development phase of our integration with CloudNativePG, the DBtune 
agent tried to patch the Cluster CRD with a new configuration, and the 
CloudNativePG admission webhook immediately blocked the request. It was 
essentially saying: "Hands off, I need to manage that specific setting myself 
to keep the cluster stable." It was confusing initially because those are 
technically valid, standard Postgres parameters. The fix was straightforward: 
we built a filter in the CloudNativePG adapter layer that excludes operator-managed 
parameters before applying any configuration. It is a clean separation of concerns: 
CloudNativePG owns infrastructure-level settings, DBtune handles performance tuning. 


## What's next?

One capability Mohsin would really like to see on the project's roadmap is 
support for staged or canary-style configuration rollouts. "Being able to 
apply a change to replicas first and explicitly validate the performance 
before committing it cluster-wide would give automation tools like ours even 
more control over the rollout process." 

Pressing him for a wishlist, Mohsin says that while DBtune already handles the 
logic for applying configuration changes, the process could be even smoother if 
the execution path is more visible at the operator level. "Having CloudNativePG 
surface more granular status information when configuration changes are being 
applied — such as which parameters were accepted, which were rejected, and why 
would make integrations easier to reason about. It’s less about shifting 
responsibility to the operator and more about improving transparency for 
systems built on top of it." 

As DBtune scales to managing hundreds of clusters, Mohsin's primary concern 
is always safety. "While we already have our own guardrails in place for safe 
tuning, having similar validation capabilities at the operator level would be 
helpful." 

Mohsin definitely plans to get more hands-on involved in the project. 
"Since my role sits right between the engineering work and daily customer 
interaction, I think my most valuable contribution would be sharing real-world 
patterns." He also looks forward to writing about what they have learned about 
automating Postgres tuning on top of CloudNativePG. "Essentially, I want to 
help bridge the gap between the core operator developers and the engineers 
who are building complex systems on top of it ‘in the wild’."