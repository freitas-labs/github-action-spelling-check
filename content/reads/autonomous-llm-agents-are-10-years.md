---
title: "Autonomous LLM Agents Are At Least 10 Years Out"
description: 'There are a host of “autonomous” LLM agents that have taken GitHub by storm — BabyAGI, AutoGPT, Jarvis. The promise? Goal-driven self-executing software. An example of an exclamatory software interface. Autonomous AI developers, assistants, and other white-collar workers replaced by software that can generate, execute, and prioritize tasks given a certain goal.'
summary: "The following is a review on the recent trend of \"fully autonomous robots\" that are powered by LLM. The author disproves the hype around this tool and says that we are at least 10 years at seeing some of these tools become a reality, and beginning to reduce the need for certain professions, such as computer engineers."
keywords: ['matt rickard', 'chatgpt', 'llm', 'open ai', 'autonomous']
date: 2023-04-22T10:49:17.651Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'chatgpt', 'llm', 'open ai', 'autonomous']
---

The following is a review on the recent trend of "fully autonomous robots" that are powered by LLM. The author disproves the hype around this tool and says that we are at least 10 years at seeing some of these tools become a reality, and beginning to reduce the need for certain professions, such as computer engineers.

https://blog.matt-rickard.com/p/autonomous-llm-agents-are-10-years

---

There are a host of “autonomous” LLM agents that have taken GitHub by storm — [BabyAGI](https://github.com/yoheinakajima/babyagi), [AutoGPT](https://github.com/Significant-Gravitas/Auto-GPT), [Jarvis](https://github.com/microsoft/JARVIS). The promise? Goal-driven self-executing software. An example of an [exclamatory software interface](https://matt-rickard.com/imperative-declarative-interrogative-and-exclamatory-interfaces). Autonomous AI developers, assistants, and other white-collar workers replaced by software that can generate, execute, and prioritize tasks given a certain goal.

But fully autonomous LLM agents aren’t going to be deployed anytime soon. Much like the level 5 self-driving autonomy progress, we’re over-optimistic on how quickly this technology can be deployed with complete autonomy.

_I predict we’re at least 10 years out from this vision of complete LLM autonomy._

But what would we need to get there? A look at some of the steps towards a real “Baby AGI.” 

1.  **Reliably translating natural language prompts to actions.** Today, the best models are OK at doing this. Smaller models (such as LLaMa, aren’t as good). Instruction-tuned models are better at doing this. But natural language is fickle to parse into code. Libraries like LangChain are stuck doing manual lexing and parsing of interleaved natural language and code (variables, “tools”, etc.). The obvious path here is to generate code instead of natural language. Code is parseable, debuggable, and can easily represent schema around inputs and outputs.
    
2.  **A replacement for prompt engineering.** Prompt engineering with natural language is [more art than science](https://matt-rickard.com/more-art-than-science). It’s hard to do gradient descent on textual changes in a prompt (as a human or machine). [Self-modifying](https://natanyellin.com/posts/self-modifying-prompts/) and self-optimizing prompts might be helpful here, but I imagine the real answer is some abstraction that sits over prompts that can easily be debugged, versioned and benchmarked more easily. Whether this is a DSL or a more specialized model, I’m not sure.
    
3.  **Infrastructure around actions.** Today, action frameworks are basic. They rely on already-pristine and bespoke environments that have installed libraries and tools and provide little customization as to where the execution happens (what is the filesystem? what are the environment variables?). Becomes necessary when 
    
4.  **A sandbox for actions.** Generated code is unsafe. Code interpreters and LLM tools are easy vectors for malicious actors. Sandboxing the actions themselves is table-stakes for execution. We have the technology (pick your favorite software isolation layer — containers, VMs, microVMs, WebAssembly), but we don’t have the bridge yet.
    
5.  **An authorization layer on actions.** In addition to sandboxing the prompt, you must have a robust authorization layer for what an agent can and can’t do. In the beginning, we might have users authorize most actions — the equivalent to the “manual judgment” found in a lot of “continuous” deployment frameworks. Humans in the loop are still expensive and slow. 
    
6.  **Dynamic workflows that are fast, reliable, and debuggable.** We have workflow systems, but they are slow and designed for static workflows. What would a workflow system built for dynamic workflows look like? They must be fast, reliable, and debuggable (agents might have to debug it themselves!). 
    
7.  **Self-healing infrastructure and workflows.** We already have self-healing infrastructure (pick your favorite enterprise-grade serverless framework or Kubernetes), and we have some version of fault-tolerant and interruptable long-running workflows, but we don’t have any technology that seamlessly ties them together for LLM agents. 
    
8.  **Cost must decrease.** Let’s say agents are running 8K context prompts at a blended $0.05 per 1K tokens. That’s $0.40 per prompt. At 2,087 average work hours in a year and 1 prompt per second, that would mean an agent would cost $3,005,280/year to run even if you only ran it during work hours. Costs will decrease, but the question is — how fast?
    
9.  **More APIs for more things.** Autonomous agents will find it easiest to interact via APIs. But even in 2023, most services don’t have APIs. It’s a chicken-and-egg: companies will rush to build APIs if agents become ubiquitous (or else lose the distribution from agents). Agents will be more valuable if they can take more actions and they only reliably take action via APIs (there’s a chance that LLM-based RPA works, but it will always be slower than APIs). 
    

I’m excited at the idea of autonomous agents, but I also believe that building stepwise infrastructure towards them will be both interesting and rewarding. We don’t have full-self driving, but my base model Honda Civic comes equipped with lane-assist and adaptive cruise control. Already, that delivers a ton of value to me. Software engineers won’t be replaced any time soon. But they are already made much more effective with GitHub Copilot.