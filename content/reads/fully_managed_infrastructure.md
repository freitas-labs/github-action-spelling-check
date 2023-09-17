---
title: "Fully Managed Infrastructure"
description: "There's managed infrastructure, and then there's fully managed infrastructure."
summary: "The author explains the usage of LLM/AI as an interface for developers and customers consuption. It provides real examples on these interfaces integration."
keywords: ['matt rickard', 'architecture', 'infrastructure', 'devops', 'cloud']
date: 2023-01-12T07:59:19+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'architecture', 'infrastructure', 'devops', 'cloud']
---

The author explains what he believes is a new class of infrastructure, *Fully Managed Infrastructure*. Teams that adopt this class of infrastructure won't need to worry about errors that occur outside of the application zone, as they are fail/error proof, meaning they only need to worry about their applications, since that's where errors should occur.

https://matt-rickard.ghost.io/fully-managed-infrastructure/

---

There's managed infrastructure, and then there's fully managed infrastructure.

It's the difference between a quart watch movement (which uses quartz oscillations and has very few moving parts) and a mechanical watch movement (which uses a complex series of tiny gears and springs). Then there are digital watches.

Managed SaaS infrastructure gives you most of the tools you need to not worry too much – a single pane of glass dashboard for monitoring, expert configuration and fine-tuning by default, and enterprise support for everything else. Managed ElasticSearch from Elastic or Managed Redis from Redis Labs means that you don't need _as many_ developers supporting the technology and infrastructure from your side.

But things still go wrong with managed SaaS – services go down, clusters get into bad states, and upgrades require thought.

There's a new class of infrastructure emerging that I'll call fully managed. It's either so hardened that you would never think about it (e.g., AWS S3), or there are not enough moving parts for something to go wrong (e.g., SQLite in a single-user deployment).

Some (not all) serverless products fit in the bucket. Other candidates are ones that work differently – removing the architecture that requires management: server processes, replication, and multi-master, or complex and wide APIs.

The only errors that come from these technologies are from your own app.

Why is fully managed infrastructure important? It's the ideal (focus just on your code) and the realization of the outsourcing of DevOps and SRE that the cloud started. I wouldn't be surprised to see more application infrastructure that's only "fully managed."