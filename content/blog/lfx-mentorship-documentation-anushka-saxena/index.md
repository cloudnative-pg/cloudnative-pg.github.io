---
title: "Updating CloudNativePG's documentation"
date: 2026-01-12
draft: false
image:
    url: anushka-saxena.jpg
    attribution:
authors:
 - fdrees
tags:
 - mentorship
 - lfx
 - cncf
 - PostgreSQL
 - Kubernetes
 - documentation
 - docusaurus
summary: "Meet the mentee: Anushka Saxena worked with the project maintainers on transforming 
the documentation for CloudNativePG, as part of the LFX mentorship program."
---

In the summer we wrote about how CloudNativePG was back for the September-
October-November LFX term with [several projects for mentoring](https://cloudnative-pg.io/blog/2025-term3-lfx-cncf-mentorship/). One of them was around the Docs. 

[Anushka Saxena](https://www.linkedin.com/in/-anushka-saxena/) is a Google Software Application Development Apprentice at Google, and is based in Bengaluru, India. She worked on improving the project’s documentation automation and multi-version support with mentors and CloudNativePG maintainers Gabriele Bartolini, Leonardo Cecchi, and Francesco Canovai. 

I had a chat with Anushka about her work, and about how she got into Tech in the first place. 

## Start at the beginning

Anushka has always been motivated by curiosity and the desire to understand how systems work. "Over time, open source became a natural extension of that curiosity because it offered a way to learn by contributing, asking questions, and building things that real people use." What really drew her in was when she realized that great software often faces issues not because of poor engineering, but because it’s hard to understand or adopt. "That realization shaped my interest in documentation modernization and contributor experience as first-class technical problems."

Anushka is a member of several Cloud-focused Communities, as a student community leader for leading cloud providers i.e., AWS, GCP and Azure) and the Cloud Native ecosystem at large, with a particular focus on developer-centric projects where infrastructure, documentation, and community intersect. She's been active in CNCF communities, open-source initiatives (OpenSearch, AsyncAPI), and DevOps tooling.

"One community that’s especially close to my heart is Data on Kubernetes (DoK). I first got involved during my college days as a volunteer for DoK Community Days, which was my introduction to cloud-native data workloads and open-source communities by Bart Farell, a mentor and a very well-known personality in the CNCF space. Coming back to the CloudNativePG ecosystem as a mentee later on felt like a full-circle moment!"

## Docs contributions

Anushka worked on automating the import of versioned documentation into the CloudNativePG docs site so that new operator releases automatically trigger the correct documentation build. It started with a major "housekeeping" task: she wrote and executed a series of Node.js utility scripts to sanitize over 60 Markdown files. This involved converting MkDocs-style admonitions to Docusaurus syntax and fixing MDX spacing issues to ensure the build wouldn't crash.

She also worked on the Sidebar Position Multiplier, [a script](https://www.google.com/search?q=https://github.com/cloudnative-pg/docs/pull/22) that intelligently re-indexed our documentation pages (10, 20, 30...) to allow future contributors to insert new pages without breaking the order. Finally, she helped architect the [Auto-Sync Pipeline](https://www.google.com/search?q=https://github.com/cloudnative-pg/docs/pull/18), a GitHub Action that automatically pulls documentation from the main repo into the docs repo whenever a new release is published. This involved writing a reusable import script, integrating it into a GitHub Actions workflow triggered by upstream releases, and validating the output in a Docusaurus-based documentation setup. 

"A key part of my approach was treating documentation as production infrastructure: iterating locally, validating assumptions, opening pull requests, and refining solutions based on maintainer feedback. The goal was not just to make things work once, but to reduce long-term manual effort and make the documentation workflow more contributor-friendly and reliable."

Anushka says that working with Gabriele, Francesco, and Leonardo was the highlight of her mentorship. "We had a very collaborative rhythm!" Through Slack, GitHub issues, weekly sync calls and pull requests, the team was responsive and generous with feedback, making it easy to iterate and improve. Anushka appreciated that discussions were clear, constructive, and focused on long-term project health rather than quick fixes. "Gabriele and Leonardo constantly provided the high-level vision that helped me see how my small scripts would affect the project as a whole."

Seeing my contributions become part of CloudNativePG’s documentation workflow and knowing they would support future releases, is very rewarding. The trust the maintainers placed in me by always encouraging me to take ownership of increasingly complex pieces of the docs pipeline rather than limiting my scope as “just a mentee”, really made me feel included."

## What’s next 

While debugging the MDX sanitization, Anushka realized that Docusaurus is much stricter than standard Markdown. A failed build because of a single unclosed `<td>` tag taught her about how modern documentation engines render content as React components, and changed how she now views "docs as code". "Also, realizing how deeply documentation is tied to release engineering made me ponder upon how docs aren’t just reference material, but a critical part of user trust, operational safety, and adoption, especially for something as production-critical as Kubernetes-native PostgreSQL!" Certainly something she'll be taking into her next projects.

Anushka is keen to stay involved in the project, particularly around documentation tooling, automation, and contributor experience. She's excited to continue working at the intersection of Kubernetes, databases, and community-driven development. "My next big goal is to refine the SEO and AI grounding for the site by making sure that when people ask an AI for CloudNativePG help, they get the most accurate, up-to-date documentation." 
