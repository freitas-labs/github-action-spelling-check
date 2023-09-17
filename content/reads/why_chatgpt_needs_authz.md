---
title: "Why ChatGPT Needs AuthZ"
description: "We have systems that can do a wide variety of tasks. But now we need to pair them with systems that tell us what we can't do."
summary: "The author explains what is authorization (authz) in modern systems and explains how current ChatGPT use case doesn't need it (because it's an LLM and doesn't access external systems). However, the author sees that it will need authz once ChatGPT can be integrated in workflows with external platforms."
keywords: ['matt rickard', 'ai', 'llm', 'chatgpt', 'authz']
date: 2023-02-26T09:49:23+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'ai', 'llm', 'chatgpt', 'authz']
---

The author explains what is authorization (authz) in modern systems and explains how current ChatGPT use case doesn't need it (because it's an LLM and doesn't access external systems). However, the author sees that it will need authz once ChatGPT can be integrated in workflows with external platforms.

https://matt-rickard.ghost.io/why-chatgpt-needs-authz/

---

We have systems that can do a wide variety of tasks. But now we need to pair them with systems that tell us what we can't do.

Authorization (authz) is everywhere – it's become more solidified into code with systems like Open Policy Agent (OPA) and, more generally, infrastructure-as-code (IaC). But we've been sloppy with authz. For example, before last year, a personal access token on GitHub could only grant access to all or none of the repositories and organizations a user could access. Moreover, even when fine-grained authz methods exist, we tend to give more permissions than we should – because it's easier than asking the security or operations team again when the service expands, or because it's tedious to maintain the minimal permissions, or maybe just because we don't know what the service needs.

ChatGPT doesn't need authz today. It can't act on instructions or access other systems. But that will change very quickly. LLMs are great at figuring out what tools they need (see Toolformer by FAIR or the early projects that let LLMs call APIs, access databases, and execute workflows). We'll trust these models with credentials, deploy agents behind firewalls, and let LLMs deploy, manage, and destroy infrastructure.

So what does a policy agent look like for ChatGPT? Of course, that depends on what kind of infrastructure emerges around LLMs. But it must be fine-grained, programmatic, and span many services.