---
title: "Garbage In, Garbage Out"
description: "'Garbage in, garbage out' is a phrase just as old as computing. The idea is that a system with bad input will produce bad output."
summary: "The following is an analysis around the concept of producing bad output if bad input is taken. In general computing, this statement is true most of the times, but AI has been proving that it's not always true, as LLM can learn in an *unsupervised* manner, so it can correct itself if the output is not so good."
keywords: ['matt rickard', 'ai', 'ml', 'chatgpt']
date: 2023-01-16T08:32:52+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'ai', 'ml', 'chatgpt']
---

The following is an analysis around the concept of producing bad output if bad input is received. In general computing, this statement is true most of the times, but AI has been proving that it's not always true, as LLM can learn in an *unsupervised* manner, so it can correct itself if the output is not so good.

https://matt-rickard.ghost.io/garbage-in-garbage-out/

---

'Garbage in, garbage out' is a phrase just as old as computing. The idea is that a system with bad input will produce bad output.

It's why data cleaning and data quality are such important parts of most data workflows. Even the best algorithms perform poorly with poorly labeled data.

But is the idea still true in this new age of AI? GPT learns unsupervised – it doesn't need humans to label data (although human feedback can make these algorithms much better – see Reinforcement Learning from Human Feedback, RLHF). Stable Diffusion's original training set (LAION) was not the most pristine (see my post on [two approaches to prompt engineering](https://matt-rickard.com/prompt-engineering) to search the datasets). Hallucination is a problem, but is it a data problem?

ChatGPT, GPT-3, or even Grammarly will clean up your writing and ideas. In some ways, many data quality issues are solved by recent AI advancements – just like we can perform super-resolution on photos to upscale them programmatically. But figuring out the right prompts and coaxing information out of the vast network is now the problem.

It's not the data quality problems are magically solved. It's just that the kinds of data quality problems are looking different.

Now the paradigm is – Probable output from questionable input.