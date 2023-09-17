---
title: "Wrong Sequences For Startups"
description: "I've written about the importance of sequencing before – doing things in the right order. Yet, it's hard for many to get right. Especially when they know what the \"right\" answer ultimately is. This is part of the reason why engineers at Google, Meta, and Microsoft sometimes struggle with adjusting to"
summary: "The following is a list of bad practices you shouldn't do on a typical startup environment, especially if you are one the founders."
keywords: ['matt rickard', 'startup', 'business', 'practices']
date: 2023-02-27T19:05:58+0000
draft: false
categories: ['reads']
tags: ['reads', 'startup', 'business', 'practices']
---

The following is a list of bad practices you shouldn't do on a typical startup environment, especially if you are one the founders.

https://matt-rickard.ghost.io/wrong-sequences-for-startups/

---

I've written about the importance of [sequencing](https://matt-rickard.com/sequencing) before – doing things in the right order. Yet, it's hard for many to get right. Especially when they know what the "right" answer ultimately is. This is part of the reason why engineers at Google, Meta, and Microsoft sometimes struggle with adjusting to startups.

A series of bad sequences for early-stage startups (n<15) (and how to avoid them).

Planning

*   Building before talking to customers. Even if you're an expert in the field, talk to customers. There are diminishing returns to talking to customers before you start to build, but the value of talking to a few real customers always outweighs any benefit of just building.
*   Having a bug-tracking or complex internal knowledge base with a schema. Complex systems need to evolve from simple ones over time ([Gall's Law](https://matt-rickard.com/applications-of-galls-law)). Communication issues scale exponentially, but at a small scale, they are manageable with the most basic of tools. Maybe a single Google Doc or even a shared Apple Note.
*   Complex internal permissions. Not every piece of code needs to go through a code review. The small team of developers should have access to anything they need. Again, this is hard for engineers that come from big teams, where this is absolutely the wrong thing to do.

Technology

*   Building a robust CI/CD pipeline when you have a living room (n<=3) of developers. I've spent a lot of time perfecting the build-to-deploy pipeline in a variety of environments (from open-source to enormous proprietary ones). Yes, CI/CD pipelines are ubiquitously good – they prevent bad code from going to production and catch hard-to-debug cross-environment bugs. But for the first few months, you might want to just YOLO push-to-production.
*   Learning a new technology in the process. Some of the most interesting parts of the stack are being [rewritten in Rust](https://matt-rickard.com/rebuilding-in-rust), but if you don't know Rust, a startup is not the time to learn it. Unless the technology is critical to your domain, there are better things to do.
*   Use a complex technology. [Don't use Kubernetes (yet)](https://matt-rickard.com/dont-use-kubernetes-yet). Even for a project I feel intimately familiar with; I wouldn't use it without a DevOps or SRE team. There's just too much operational work when there are only a few developers. Other technologies I would not touch early on, despite thinking that they might be the right long-term solution: gRPC, infrastructure-as-code (OK for small stacks), self-hosting any sort of infrastructure that's offered as a managed service (e.g., Postgres). Of course, if any of these are critical to your business, you should do them (e.g., you're a Kubernetes-based PaaS or database company).
*   Building for scale. Counterintuitively, doing this usually ends up with a worse end-user experience. Why? The most at-scale technologies often are the hardest to manage. Sticking with the boring deployment options like AWS Lambda over Kubernetes might pain some engineers, but is worth it in terms of velocity. When Twitter was constantly down early in its life, users kept returning. The same has been true of ChatGPT more recently.

Product

*   Complex measurements and instrumentation. Early on, you have the bandwidth to track one core metric, and that's about it. For the rest of the features, you can most likely just pore through the logs for one-off analyses if needed. No A/B tests (you probably don't have enough traffic anyways).
*   Building more features. Adding one more feature won't make customers want to use the entire product. Better solutions: iterate on market, iterate on distribution. Feature debt slows teams down considerably.
