---
title: "Unix Philosophy for AI"
description: "Text processing was the initial pitch for the development of Unix at Bell Labs (see An Oral History of Unix). It became more than that. Spell checkers in ed used the sort command. Then there was AWK, the text processing language used by the awk tool by Aho, Weinberger, and Kernighan. Then there were Unix pipes — the development that made the Unix philosophy a reality.

Language models are following a similar trajectory. Text processing and manipulation are core to the product again. Text process"
summary: "The following is the analysis on how Unix design can be applied in AI."
keywords: ['matt rickard', 'unix', 'ai', 'chatgpt']
date: 2023-05-14T22:34:19.669Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'unix', 'ai', 'chatgpt']
---

The following is the analysis on how Unix design can be applied in AI.

https://matt-rickard.com/unix-philosophy-for-ai

---

Text processing was the initial pitch for the development of Unix at Bell Labs (see [An Oral History of Unix](https://web.archive.org/web/20230509073604/https://www.princeton.edu/~hos/frs122/unixhist/finalhis.htm)). It became more than that. Spell checkers in `ed` used the `sort` command. Then there was `AWK`, the text processing language used by the `awk` tool by Aho, Weinberger, and Kernighan. Then there were Unix pipes — the development that made the [Unix philosophy](https://matt-rickard.com/instinct-and-culture) a reality.

Language models are following a similar trajectory. Text processing and manipulation are core to the product again. Text processing is expanding to tool use (e.g., Toolformer, ReAct, etc.). Simple scripting is emerging around these tools in agent frameworks like AutoGPT and BabyAGI, just like shell.

We still don’t have the equivalent of Unix pipes to tie everything together.

The Unix philosophy might be the right ethos to build a philosophy for LLMs. Here’s a modified version of the Unix philosophy for LLMs.

(i) Make each program do one thing well. To do a new job, build afresh

rather than complicate old programs by adding new features.

> Make each prompt do one thing well. To do a new job, build afresh rather than complicate old prompts by adding new features.

(ii) Expect the output of every program to become the input to another, as yet unknown, program. Don't clutter output with extraneous information. Avoid stringently columnar or binary input formats. Don't insist on interactive input.

> Expect the output of one language model to become the input to another, unknown, language model. Don't clutter output with irrelevant information. Avoid imposing rigid input formats. Don't insist on interactive input, but design models to process and generate structured or unstructured text data as needed.

(iii) Design and build software, even operating systems, to be tried early, ideally within weeks. Don't hesitate to throw away the clumsy parts and rebuild them.

> Design and train models to be tested early, ideally within days. Don't hesitate to discard less efficient models or strategies and retrain them.

(iv) Use tools in preference to unskilled help to lighten a programming task, even if you have to detour to build the tools and expect to throw some of them out after you've finished using them."

> Use tools and plugins to lighten a text generation task, even if you have to detour to develop the tools and anticipate to discard some of them after you've finished using them.