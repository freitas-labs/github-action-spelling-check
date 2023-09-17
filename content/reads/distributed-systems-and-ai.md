---
title: "Distributed Systems and AI"
description: "Jeff Dean, Google’s SVP of Google Research and AI, started his career working on compilers and profiling tools. He would go on to work on hard distributed systems that formed the basis for Google’s infrastructure, like Spanner (distributed SQL), Bigtable (a wide-column key-value analytics database), MapReduce (a system..."
summary: "The following is an explanation on how having distributed systems knowledge helps improving AI products."
keywords: ['matt rickard', 'distributed systems', 'ai']
date: 2023-04-01T17:09:01+0100
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'distributed systems', 'ai']
---

The following is an explanation on how having distributed systems knowledge helps improving AI products.

https://matt-rickard.ghost.io/distributed-systems-and-ai/

---

Jeff Dean, Google’s SVP of Google Research and AI, started his career working on compilers and profiling tools. He would go on to work on hard distributed systems that formed the basis for Google’s infrastructure, like Spanner (distributed SQL), Bigtable (a wide-column key-value analytics database), MapReduce (a system for large-scale data processing), and LevelDB (another key-value store).

He wasn’t a machine learning expert (but like all good hackers, he dabbled — he wrote his undergrad thesis on optimizing neural networks by writing some parallel training code ([read it here](https://drive.google.com/file/d/1I1fs4sczbCaACzA9XwxR3DiuXVtqmejL/view?ref=matt-rickard.ghost.io)). But first and foremost, he was a distributed systems engineer.

Greg Brockman, President, Chairman, and Co-founder of OpenAI, was also an infrastructure engineer first. He was previously the CTO of Stripe, where he gravitated toward infrastructure solutions. He talks about this in a 2019 blog post, [“How I became a machine learning practitioner](https://blog.gregbrockman.com/how-i-became-a-machine-learning-practitioner?ref=matt-rickard.ghost.io),” where he talks about using LD\_PRELOAD in a Go GRPC server to break out of the Lua sandbox to control the Dota via AI.

Correlation isn’t causation, but it’s clear that distributed systems engineering and the frontier of AI are closely intertwined. It doesn’t remove the need to understand the research — Jeff and Greg both put their time into becoming domain experts in addition to focusing on systems. But it seems that many of the hard production AI problems are hard distributed systems problems.

OpenAI uses Kubernetes to run distributed training GPT-3 and GPT-4. They most likely use it for inference as well. Integrating LLMs with other infrastructure is largely an infrastructure problem, not an AI research one. How do you efficiently wrangle large amounts of data? Parallelize algorithms? How to accelerate development with developer tools to experiment, deploy, and debug new models?

Even in a world where AI-assisted code reigns — being a distributed systems expert might be the key to unlocking AI in every program.