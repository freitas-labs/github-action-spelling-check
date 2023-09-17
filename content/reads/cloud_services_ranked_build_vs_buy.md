---
title: "Cloud Services Ranked: Build vs. Buy"
description: "While many engineering teams would like to own their end-to-end stack, not all organizations have the time, money, or expertise to manage all infrastructure. There's generally four options: (1) use a cloud service (2) use a SaaS (3) run the OSS in your datacenter or cloud (4) build it from"
summary: "The following is a review on whether you should build your own infrastructure vs relying on cloud services, for different classes of computing."
keywords: ['matt rickard', 'cloud', 'infrastructure']
date: 2023-02-06T20:58:57+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'cloud', 'infrastructure']
---

The following is a review on whether you should build your own infrastructure vs relying on cloud services, for different classes of computing. The author presents his opinion on what he considers is the best option to take for each class, describing the various reasons to consider it.

https://matt-rickard.ghost.io/cloud-services-ranked-build-vs-buy/

---

While many engineering teams would like to own their end-to-end stack, not all organizations have the time, money, or expertise to manage all infrastructure. There's generally four options: (1) use a cloud service (2) use a SaaS (3) run the OSS in your datacenter or cloud (4) build it from scratch. I did a library-centric version of this question in _[When to Roll Your Own X.](https://matt-rickard.com/when-to-roll-your-own-x)_

While the answer will vary based on the type of company, I'm assuming this is a SaaS software company. If any of these is your core business, you should probably be building it yourself.

_Storage and compute_ – Choose S3/EC2. The alternatives are second-tier clouds (DigitialOcean, Hetzner, Linode) or running your own datacenter. Both services are expensive, but they come with world-class reliability. Better yet, it will be easy to find off the shelf software (and developers) that know how to use these APIs. It also gives you the ability to use things like spot instances or rightsize your infrastructure easily.

_Observability and monitoring –_ Datadog is the best in-class service here. It's expensive, but insight into your software is worth it. Consider the downtime you'd hypothetically be saving. While it doesn't seem like the most complicated solution to roll yourself, it's not worth it unless you're at Uber-scale.

_Kubernetes –_ The cloud-managed services here are mature and cheap enough where they are worth it. No sense in managing upgrades yourself. It's also something that needs tight integration with the rest of your stack, so third-party SaaS providers are a tough sell.

_Databases –_ If you need a specific flavor of database (e.g., graph, NoSQL, etc.) you might choose to go with that third-party provider. Otherwise, there's a whole host of next-generation serverless providers (Neon for Postgres, Planetscale for MySQL) that could be a good choice if your stack is mostly serverless and you have few ops. Regardless, don't try to do this one yourself either – although for developer environments or QA environments it might be OK.