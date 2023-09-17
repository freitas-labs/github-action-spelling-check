---
title: "Prompt Engineering is Configuration Engineering"
description: "Ironically, one of the most challenging aspects of distributed systems is configuration management. Consensus, fault tolerance, leader election, and other concepts are complex but relatively straightforward. Configuration management is challenging because it’s about the convergence of the internal system state, a declarative API, and tooling that glues together that API with other adjacent systems (CI/CD, developer tools, DevOps, etc.). There’s no algorithm like Raft or Paxos to guide the implementation. And so many different concerns end up with an API that requires the knowledge of multiple roles (operators and developers)."
summary: "The following is a comparison of Prompt Engineering with Configuration Engineering. The author believes the two relate to each other because Prompt Engineering is evolving in the same cycle as the \"Heptagon of Configuration\"."
keywords: ['matt rickard', 'software engineering', 'chatgpt', 'llm', 'prompt engineering', 'configuration engineering']
date: 2023-05-27T07:39:42.647Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'software engineering', 'chatgpt', 'llm', 'prompt engineering', 'configuration engineering']
---

The following is a comparison of Prompt Engineering with Configuration Engineering. The author believes the two relate to each other because Prompt Engineering is evolving in the same cycle as the "Heptagon of Configuration".

https://blog.matt-rickard.com/p/prompt-engineering-is-configuration

---

Ironically, one of the most challenging aspects of distributed systems is configuration management. Consensus, fault tolerance, leader election, and other concepts are complex but relatively straightforward. 

Configuration management is challenging because it’s about the convergence of the internal system state, a declarative API, and tooling that glues together that API with other adjacent systems (CI/CD, developer tools, DevOps, etc.). There’s no algorithm like Raft or Paxos to guide the implementation. And so many different concerns end up with an API that requires the knowledge of multiple roles (operators and developers). 

The history of configuration management in Kubernetes is a long one. Initially, JSON and YAML exposed fairly verbose declarative APIs. Inevitably, there was duplication and complexity. Developers turned to templating (via Helm, which used Jinja). This allowed some level of packaging — reusable configurations that could be further configured for each organization’s use case. But templates soon became even more complex themselves, to the point of nearly every field becoming a variable field via the template. With control flow, it was hard to tell what the end representation of the configuration would be. Infrastructure was already hard enough to test, and it became even harder with just-in-time compiled templates that were tough to type or schema check.

There were attempts to build more advanced languages that did more. Eliminating duplication with object-orientation, schema definitions, modules, packages, scripting, and control flow (see [every sufficiently advanced configuration language is wrong](https://matt-rickard.com/advanced-configuration-languages-are-wrong)).

I called this progression [The Heptagon of Configuration](https://matt-rickard.com/heptagon-of-configuration). And we’re already seeing it in the prompt engineering world. In many ways, it’s the same problem, in a different form. Powerful but horizontal APIs that abstract away an enormous amount of complexity need to be configured for various use cases. Pipelines of applications built on single APIs.

How might prompt engineering evolve like configuration engineering?

First, we had hardcoded prompts. But developers started building applications that did more dynamic work in prompts — adding in user input, context from a database, or even scraped web results. 

Then came the prompt templates. There’s [guidance](https://github.com/microsoft/guidance) from Microsoft, which uses a Handlebars-like syntax, which is most likely the most advanced. Jinja templates embedded in Python applications. 

The next step is a full DSL around prompts. [LMQL](https://lmql.ai/) is a query language for prompting. It might abstract some aspects of prompt engineering away. Things like schema checking (you might use [ReLLM](https://matt-rickard.com/rellm)). 

Finally, we’ll probably see more fine-tuned or “hardcoded” models that expose a more specific API that requires less templating or prompt engineering. Taking patterns known to work and exposing them behind a single API.