---
title: "CloudNativePG part of LFX Mentorship - sign up as a mentee!"
date: 2025-05-13T14:51:43+02:00
draft: false
image:
    url: lfx_mentorship.png
    attribution:
author: jgonzalez
tags:
 - mentorship
 - lfx
 - cncf
 - PostgreSQL
 - Kubernetes
summary: "We have proposed a project for the June cohort of the CNCF's LFX Mentorship 
    program, and we’re looking for mentees to sign up and receive a stipend for 
    their work."
---

[LFX Mentorship](https://lfx.linuxfoundation.org/tools/mentorship/) is a Cloud Native Computing Foundation mentorship 
platform that spans across the CNCF projects. More than 190 mentees have been 
accepted since the programs started in 2019, participating in 96 mentorship 
programs. We have proposed a project for the June cohort, and we’re looking 
for mentees to sign up and receive a stipend for their work!

## Implementing “Declarative Management of PostgreSQL Foreign Data Wrappers” 
The project we proposed aims to extend the CloudNativePG operator to support 
declarative configuration of foreign data wrappers through its Database custom 
resource ([Upstream Issue](http://cloudnative-pg/cloudnative-pg#4683)). 
PostgreSQL supports the SQL/MED (Management of External Data) specification, 
enabling access to external data sources through standard SQL queries. These 
sources—known as foreign data—are accessed via foreign data wrappers (FDWs), 
which are libraries that handle the connection and data exchange with the 
external systems. A variety of FDWs are available for PostgreSQL. 
Of particular interest for this project is the postgres_fdw extension, 
which facilitates access to other PostgreSQL instances.

We’re looking forward to an elaborate design discussion in the upstream issue 
in CloudNativePG GitHub repository, involving mentors, maintainers, and the 
community. And ultimately of course, a fully working pull request implementing 
support for declarative foreign data wrappers, complete with reconciliation 
logic for the Database resource controller, Documentation, and automated tests 
integrated into the CI/CD pipeline.

## Sign up as a mentee
Up for the task? You'll have to apply as a mentee on the [LFX Mentorship website](https://lfx.linuxfoundation.org/tools/mentorship/). 
Please see the [LFX Mentorship guidelines](https://docs.linuxfoundation.org/lfx/mentorship/mentee-guide) for more details. 

Applications are open from May 14 until May 27, with the selection 
notifications going out on June 4, and the program starting June 9. 
The stipend guides and amounts are listed [here](https://docs.linuxfoundation.org/lfx/mentorship/mentee-stipends).

We are specifically looking for the following skills / existing knowledge of:
* Go programming (operator development)
* Kubernetes and CRDs (Custom Resource Definitions)
* Git and GitHub workflows
* CloudNativePG
* Familiarity with PostgreSQL internals and SQL syntax

... please also see the full eligibility criteria in the [LFX Mentorship documentation](https://docs.linuxfoundation.org/lfx/mentorship/mentees).

You’ll receive the expert guidance of 4 of CloudNativePG’s maintainers: 
[Gabriele Bartolini](https://github.com/gbartolini), [Leonardo Cecchi](https://github.com/leonardoce), [Marco Nenciarini](https://github.com/mnencia), and [Armando Ruocco](https://github.com/armru). 

We look forward to seeing what we can build together!
