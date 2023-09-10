---
title: "AI-driven Interfaces"
description: 'The current generation of LLMs uses natural language as an input/output. This is convenient (and impressive) for human interaction, but what about computer-to-computer...'
summary: "The author explains the usage of LLM/AI as an interface for developers and customers consuption. It provides real examples on these interfaces integration."
keywords: ['matt rickard', 'ai', 'llm', 'chatgpt']
date: 2023-01-03T19:50:46+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'ai', 'llm', 'chatgpt']
---

The following is a retrospective on the features of **LLM** (Large Language Models) in assisting both developers and customers as an *interface* (a blackbox that allows consumption). It goes on explaining how LLM can be integrated as a translator in programming, creating new compression algorithms for specific data domains, and how it can also be used to simulate interactions with other interfaces, such as a computer virtual machine.

https://matt-rickard.ghost.io/ai-interfaces/

---

The current generation of LLMs uses natural language as an input/output. This is convenient (and impressive) for human interaction, but what about computer-to-computer communication?

_Emulating wire formats_

With a simple prompt, GPT-3 can easily be coerced into accepting and outputting JSON. You can even use the prompt to specify the schema for the API responses you want (you can simply give it a few example responses). This makes it easy to build traditional systems around model inference.

Maybe this solves ETL and the [M:N API problem](https://matt-rickard.com/the-m-n-api-problem), to some degree. Fuzzy mappers can handle small unexpected changes in an API response. Of course, maybe this introduces more opportunities for hidden problems.

_Encoders/decoders_

In addition, GPT-3 is quite good at learning (or creating) encoders/decoders. This means it could plausibly generate good compression algorithms that match the data. For general-purpose models, this might not always give the right results – it would look something more like a probabilistic data structure like a bloom filter. But fine-tuned GPT-3 encoders and decoders might go a long way into being efficient ways to exchange data.

_Emulating APIs_

ChatGPT has been successful in hallucinating APIs,

*   Emulating a [Linux virtual machine](https://www.engraved.blog/building-a-virtual-machine-inside/)
*   NodeJS/Python/SQL interpreter
*   A host of other command line tools

The problem, of course, is hallucination – i.e., there's no guarantee that the results are referentially correct. But it does post the question – if you have a fuzzy interface or a simple enough interface, you might be able to replace the backend with something like GPT-3.