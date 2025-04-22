---
title: "Contributor Spotlight: Jeff Mealo"
date: 2025-05-14T14:51:43+02:00
draft: false
image:
    url: jeff.jpeg
    attribution:
author: fdrees
tags:
 - alerts
 - dashboards
 - chaos-engineering
 - performance
 - CNCF
 - postgresql
 - open-source
summary: "In a mini-series on this blog we highlight the work of the community.
  Today we meet Jeff Mealo, Senior Software Engineer at Gisual."
---

Building and maintaining and open source project takes a village. In a
mini-series on this blog we would like to highlight the work of our
maintainers, component owners, and members of the larger community.

Today's superstar: [Jeff Mealo](https://github.com/jmealo/). Jeff is a 
Senior Software Engineer at Gisual, where they specialize in detecting and 
diagnosing infrastructure outages through automation. Their outage analytics 
platform is powered by CloudNativePG, enabling organizations to quickly 
identify network issues and achieve significant truck roll reduction. 
Gisual both contributes engineering resources to CloudNativePG's development 
and relies on it to keep the lights on for themselves and their customers.

It's no wonder Jeff ended up in Tech, he has always had an insatiable 
curiosity to figure out how things work:
> "We got our first home computer at 8, and the internet at 9. The internet 
was one of those things, and I found myself creating video game fan sites 
using HTML and Perl from ages 9-10. One game wasn’t enough and this exploded 
in scope to helping create the largest database of video game cheat codes 
using PHP, and my ambitions quickly exceeded what free hosting could achieve 
at the time. So I did what any 11 year old would do, start a computer salvage 
operation on eBay using old gear that folks in my community had donated to me 
to get a dedicated server and then sell enough web hosting to keep the lights 
on!"

He tells me that because he didn’t have any real life mentors, only strangers 
helping him on IRC, he was unaware that this was a career path. While working 
two jobs to try to pay for college, a classmate observed Jeff working the 
night shift at a convenience store and asked why he wasn’t doing anything with 
computers. Thanks to that guy we now get to work with Jeff! 

Jeff first came across CloudNativePG when he was looking to achieve equivalent 
or better performance, availability, reliability than a managed service. 
CloudNativePG was the only operator that ticked all the boxes and it had a 
thriving open source community. "With CloudNativePG now under the CNCF umbrella, 
we feel like we made the right choice!"

While vetting CloudNativeNPG for production usage, Jeff did a lot of chaos 
engineering and really put it through its paces before deciding to migrate 
away from the safety of managed Postgres. "It met and exceeded our 
expectations, but we continued to have issues with volume snapshots and a 
couple of other edge cases that were very difficult to isolate and reproduce." 
Even though prior to this, Jeff hadn’t done any Go development, with the help 
of some gophers on the Go slack, he was able to find the root cause of the 
issues with the operator: connection handling in the instance manager. 
If 3 backups failed in a row, it would no longer report its status properly 
which resulted in numerous failures (luckily, none of which caused an outage 
in themselves, just reduced redundancy). 

Jeff has a wishlist for the project: 
* Support for other topologies (namely distributed Citus)
* Out of box experience: a wizard that helps you configure things to get the 
best performance/availability/reliability/recovery time – there’s so much to 
consider and it’s rare to find an individual who possesses enough knowledge 
on all the moving parts to get things right the first time!
* Polishing alerts and dashboards and gathering first hand experience and 
guidelines for production usage. 

Anyone interested working on the above topics, find Jeff in the CloudNativePG 
channels on the CNCF Slack workspace, or on [Bluesky](@jmealo.bsky.social)! 
Jeff's also active in the #postgresql channel on freenode, and while he's 
still getting used to chatting on Slack and Discord for Open Source, he is 
a member of the gophers.slack.com, victoriametrics.slack.com, 
postgresteam.slack.com, and cloud-native.slack.com.