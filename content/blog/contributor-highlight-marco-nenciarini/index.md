---
title: "Contributor Spotlight: Marco Nenciarini"
date: 2025-06-16T11:51:43+02:00
draft: false
image:
    url: marco.jpg
    attribution:
author: fdrees
tags:
 - Debian
 - Kubernetes
 - postgresql
 - open-source
 - spotlight
summary: "In a mini-series on this blog we highlight the work of the community.
  Today we meet Marco Nenciarini, one of the original creators of CloudNativePG."
---

Building and maintaining an open source project takes a village. In a
mini-series on this blog we would like to highlight the work of our
maintainers, component owners, and members of the larger community.

This week the spotlight shines on [Marco Nenciarini](https://github.com/mnencia), 
Esteemed Senior Principal Engineer at EDB. A title Marco doesn't like to use, 
since to him it sounds "a bit pretentious". Marco is one of the original creators 
of CloudNativePG. He was part of the initial team at 2ndQuadrant that, back in 2019, 
began exploring how to run PostgreSQL effectively on Kubernetes. 

Marco contributed to the initial architecture and codebase and had "countless 
discussions" with Leonardo (Cecchi) and Gabriele (Bartolini) about the 
operator’s internal mechanics. He recalls one of the earliest and most 
memorable topics to be the bold idea of removing the separate instance manager 
project—known as pgk at the time—and instead injecting the operator executable 
directly into the Pod during the bootstrap phase using an initContainer. That 
architectural choice helped streamline the deployment model and continues to 
shape how CloudNativePG works today.

If he had to choose one thing he would change in the project today, it would 
be removing the use of Kubernetes Jobs for instance initialization. "Eliminating 
them would significantly simplify the codebase and open the door to alternative 
initialization methods that aren’t feasible with the current job model."

Curiosity is what got Marco into technology in the first place. As a teenager, 
he was fascinated by electronics and computer programming. With the advent of 
the Internet, he began experimenting with Linux and open-source tools. He 
quickly fell in love with Debian and eventually became a Debian Developer.

Marco is active in the PostgreSQL, and in the Kubernetes community, but also 
in the broader cloud-native and DevOps ecosystem, especially around open-source 
tools for deployment, automation, monitoring, and system reliability. He hopes 
to support people’s growth through mentoring and collaborative open-source work. 
The man genuinely gets excited whenever someone offers up a problem to solve.

If you wanted to get in touch with Marco, you can find him in the CloudNativePG 
channels on the CNCF Slack workspace, or on [Twitter/X](https://x.com/mnencia), 
[Bluesky](https://bsky.app/profile/mnencia.bsky.social), or [LinkedIn](https://www.linkedin.com/in/mnencia/). 
