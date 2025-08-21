---
title: "Unlocking full Kubernetes functionality at Brella with CloudNativePG and Hetzner"
date: 2025-08-19
draft: false
image:
    url: brella_cloudnativepg.jpg
    attribution:
authors:
 - fdrees
tags:
 - react
 - Rails
 - Hetzner
 - kubernetes
 - postgresql
 - open-source
summary: "We talked to Vito Botta, Lead Platform Architect for the event management platform 
Brella, about how CloudNativePG fits in their technology stack." 
---

[Vito Botta](https://www.linkedin.com/in/vitobotta/) is the Lead Platform Architect at Brella, an event management 
platform where he oversees all technical aspects of the product. Outside of 
work, he enjoys participating in bug bounty programs, finding and responsibly 
reporting vulnerabilities. We had a chance to talk to him about his use of 
CloudNativePG.

Brella provides event organizers with the tools to manage event access, 
schedules, sponsors, and more—while helping attendees make the most of 
their time through powerful networking features. The platform’s architecture 
includes a React frontend (for both web and mobile), a Ruby on Rails backend, 
and a PostgreSQL database. The backend runs in Kubernetes clusters on Hetzner 
Cloud, powered by Vito’s own open-source project, hetzner-k3s.

Brella previously ran on Google Cloud using Cloud SQL for PostgreSQL but 
migrated to Hetzner to reduce costs and gain flexibility. After testing multiple 
operators, Vito chose CloudNativePG for running PostgreSQL in Kubernetes due to 
its simplicity, robustness, and feature set.

## hetzner-k3s: from side project to community tool
Originally created for their specific use case, [hetzner-k3s](https://github.com/vitobotta/hetzner-k3s) enables running 
full-featured Kubernetes clusters on Hetzner Cloud at low cost. Interest from 
the community quickly grew, with companies using it to migrate from costly 
hyperscalers while retaining necessary features. The project now boasts nearly 
2,700 GitHub stars and an active, growing user base.

## Why CloudNativePG works for Brella

For Vito, CloudNativePG “just works”. It’s easy to set up, maintain, and
integrate into Brella’s architecture. The migration from Cloud SQL brought major 
benefits: better specs, three-node PostgreSQL clusters instead of one, seamless 
failovers, point-in-time recovery, S3-compatible backups, and horizontal read 
scaling.

By contrast, Cloud SQL often caused downtime, even with high availability 
enabled, limiting flexibility and delaying updates. CloudNativePG’s Kubernetes 
native design aligned perfectly with Vito’s goal of running all services 
(including the database) inside Kubernetes.

## Keeping it simple for the team

Vito, who is the Brella team member with the deepest Kubernetes experience, 
values CloudNativePG's simplicity. It helps keep Brella’s architecture 
approachable for teammates who are still learning infrastructure administration. 
Compared to other PostgreSQL operators like Zalando or Crunchy, Vito finds 
CloudNativePG more streamlined and better integrated into Kubernetes from the 
ground up.

## A lifelong passion for technology
Vito’s fascination with computers began at age six. By eight, he was developing 
simple games, but a virus that erased his source code shifted his focus to 
computer security. In his teenage years, he explored both programming and hacking
—until a teacher helped him redirect his skills toward ethical and productive work. 
Since then, Vito has built platforms and systems of all sizes, with a particular 
focus on security, eventually discovering bug bounty hunting as a way to combine 
passion and profession.

## Looking ahead

Six to seven months into production, Brella has had zero issues with 
CloudNativePG. Vito particularly appreciates features like automatic failover, 
rolling updates with no downtime, smooth replication, and S3-based WAL 
archiving. He’s looking forward to testing in-place major upgrades as the next 
enhancement for Brella’s clusters.
