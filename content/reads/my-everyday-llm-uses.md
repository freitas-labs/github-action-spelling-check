---
title: "My Everyday LLM Uses"
description: "How do I use LLMs in my personal life? I’ve found A few rote tasks useful for outside of coding or professional work.

Most of the interaction comes via hosted models.

Sorting grocery lists. Some use LLMs to generate potential recipes, given a fridge full of ingredients. I mostly know what I’m cooking, but my grocery lists are haphazardly appended as I remember what I need throughout the week. I use a simple prompt to organize the list into grocery store sections to efficiently check them off i"
summary: "The following is a list of use cases where author applies LLMs."
keywords: ['matt rickard', 'llm', 'chatgpt', 'use case']
date: 2023-08-17T06:40:23.057Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'llm', 'chatgpt', 'use case']
---

The following is a list of use cases where author applies LLMs.

https://matt-rickard.com/my-everyday-llm-uses

---

How do I use LLMs in my personal life? I’ve found A few rote tasks useful for outside of coding or professional work.

_Most of the interaction comes via hosted models._

**Sorting grocery lists.** Some use LLMs to generate potential recipes, given a fridge full of ingredients. I mostly know what I’m cooking, but my grocery lists are haphazardly appended as I remember what I need throughout the week. I use a simple prompt to organize the list into grocery store sections to efficiently check them off in order.

**Summarizing book notes.** I create many highlights when reading books (all digital, via Apple Books). I then have a script to export all the notes (Apple removed this feature from the UI, but you can access the SQLite database where the data is held). I run this through an LLM to compress the notes further.

**Dictionary lookup.** While reading, I come across several words that I don’t know. I save these for later and add them to a note. Then I run them through an LLM that defines them and formats the word and definition nicely. I store these all in a big note (I even wrote a [blog](https://matt-rickard.com/unknown-word-list) about it once).

**Task into subtasks.** While LLMs aren’t particularly great at generating tasks out of thin air, I’ve found them helpful in breaking down a task into subtasks. Primarily for non-technical things. A good first draft, if anything.

**Writing Editor.** When writing longer documents, I use it as a critical editor. The suggestions aren’t always great, but I’ve found that a critique is often more helpful than raw text generation.

**Writing Style (ongoing).** When GPT-3 fine-tuning was first released, I trained a model on my blog posts. It didn’t work that well. Now that we have a plethora of open-source models, I’ve been experimenting with fine-tuning other models to capture my writing style.

Here’s a generation from the original davinci fine-tuning:

> _The following is a mattrickard blog post about the problems with Kubernetes:_
> 
> _Kubernetes has become the "de facto" standard container orchestrator and is often a requirement when working with containers. But do you really NEED Kubernetes? Walled Garden. Kubernetes is essentially a private repository. Only officially maintained and endorsed projects are likely to be stable enough for production. Of course, you can easily deploy and manage your own k8s, but adopting the platform means adopting the vendor-lock in and specialization of your organization's means of production._

Unsuccessful attempts:

*   Generating names for projects — I’ve found that it comes up with very cliche answers, even with substantial prompt engineering.
*   Brainstorming — I’ve tried to use ChatGPT for various brainstorming activities — everything from conversational to Socratic styles. But again, even with the right prompt engineering, breaking out of the obvious path is hard.
*   Writing a fiction novel — I’ll chronicle this one at some point, but I’ve tried a few strategies to generate an entire novel. I still believe it’s possible with today’s models and the right strategy.