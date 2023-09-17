---
title: "Prompt Engineering Shouldn't Exist"
description: 'Prompting LLMs is an art more than a science. Scale AI recently hired a full-time Prompt Engineer. Anthropic AI also has a job description for a "Prompt Engineer and Librarian".'
summary: "The author gives his take on recent hype about prompt engineering in Machine Learning (ML). He doesn't believe that prompt engineering is related at all to ML, but is more an alternative name to system integrations engineering."
keywords: ['matt rickard', 'ai', 'prompt engineering', 'chatgpt']
date: 2023-01-26T08:11:23+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'ai', 'prompt engineering', 'chatgpt']
---

The author gives his take on recent hype about prompt engineering in Machine Learning (ML). He doesn't believe that prompt engineering is related at all to ML, but is more an alternative name to system integrations engineering.

https://matt-rickard.ghost.io/prompt-engineering-shouldnt-exist/

---

Prompting LLMs is an art more than a science. Scale AI recently hired a full-time Prompt Engineer. Anthropic AI also has a job description for a "Prompt Engineer and Librarian."

But prompt engineering shouldn't be a thing and won't be a thing in the future.

Why?

Today, the state of the art is prompt concatenation or prompt templating. For example, take this prompt from [latent browser](https://twitter.com/flngr/status/1609616068057698304), which auto-generates web applications in real-time based on a prompt. It templates in the user's query under `${query}`:

    `You are a senior frontend engineer who needs to develop a web application using only HTML and Javascript.
    
    You are not going to code it yourself, instead you will write a valid spec of the app, in the form of JSON instructions.
    
    Here are some examples, but don't copy them verbatim! instead you need to adapt to the application brief!
    
    < A series of examples in JSON > ...
    
    Real work is starting now. Remember, you MUST respect the application brief carefully!
    Brief: ${query}
    Spec: {`

The first observation: **Good prompts specify structured data as inputs and outputs.** Unless the output is directly sent to the user (e.g., ChatGPT), the developer needs to parse out relevant information from the result. The GPT-3.5 post-Codex models are great at understanding and outputting valid JSON, YAML, or Python. I've even seen some examples that output TypeScript interfaces so that you can control the schema more.

The second observation is that the **prompt is templated**. Again, this works for simple use cases. But time has shown that simple templating quickly ends up as complicated templating, whether it's dbt's Jinja templates, Kubernetes Helm Charts, or something else.

What happens when prompts get more complex? A series of conditional statements and control flow that output a prompt? What happens when base prompts are more than concatenation but are generated on a user-by-user basis? The templates will only continue to get more complex.

The third observation: **What if one prompt isn't enough?** LLMs can solve complex tasks but only hold a relatively small context in memory. So one strategy is _a single pass with a prompt generated to break down the initial request into a series of steps – either executed by a chain of LLMs or alternative runtimes._

For example, if you ask GPT to do the following task,

    calculate the SHA3 sum of the file that belongs to the customer specified in the following text: "Bob I've uploaded the file to S3 in the s3_customers bucket"

It will indeed output (plausible) garbage or refuse to answer. So instead, you might ask it something like this:

    You have access to three runtimes to answer questions with: a unix terminal, a python repl, a large language model, and http
    Use the following JSON schema
    {
      "steps": [
        {
            "name": "name of the task",
            "description": "description of the task",
            "runtime": "python|unix|prompt",
            "command": "command to execute",
        },
        {
            "name": "name of the task",
            "description": "description of the task",
            "runtime": "python|unix|prompt",
            "command": "command to execute",
        },
        ...
      ]
    }
    
    Output the multiple steps one should take to find the answer to the following query in valid JSON:
    calculate the SHA3 sum of the file that belongs to the customer specified in the following text: "Bob I've uploaded products.csv to S3 in the s3_customers bucket"
    

Which outputs the following valid JSON.

    {
      "steps": [
        {
            "name": "Download the file from S3",
            "description": "Download the file from the S3 bucket specified in the text",
            "runtime": "unix",
            "command": "aws s3 cp s3://s3_customers/products.csv products.csv",
        },
        {
            "name": "Calculate the SHA3 sum",
            "description": "Calculate the SHA3 sum of the file",
            "runtime": "unix",
            "command": "shasum -a 256 products.csv",
        }
      ]
    }

Now, we've turned a useful prompt into something easily parsed and executed with alternative deterministic, cheap, and understandable runtimes.

NLP is a functional interface, but it isn't the ultimate one. For example, it isn't a good fit for building infrastructure building blocks and isn't a good interface for stitching systems together.

Prompt engineering looks more like a systems engineering problem, not a machine learning one.

Of course, designing an LLM-friendly workflow engine becomes the hard part. How do you efficiently dispatch workloads and steps to other runtimes or back to LLMs? How do you use the output of actions in other steps? This a classic problem in CI/CD and orchestration.

So prompt engineering as an NLP task will go away fairly quickly. Instead, we'll figure out ways to bring more structure to the input and output of querying LLMs.

Some possibilities –

*   A purpose-built DSL for prompts (see _[Prompting is Programming: A Query Language for Large Language Models (December 2022)](https://arxiv.org/abs/2212.06094)_). Turing the [Heptagon of Configuration](https://matt-rickard.com/heptagon-of-configuration), DSLs are the next step (followed by scripting and general-purpose languages). The initial benefit of this will be condensing prompt and wire context. Denser prompts mean more room for instruction, and denser output means extracting more meaning.
*   Schema around LLM I/O. Whether this is plain JSON (easiest to parse) or something more complex that can be type-safe, it's to be determined. My bet is usually [TypeScript](https://matt-rickard.com/advanced-configuration-languages-are-wrong).
*   The importance of multiple runtimes – where they can be run, what they can calculate, and how to call them. Some will be language-level (Python REPLs to compiled code), while others will be lower-level (WASM binaries runnable in the browser). Others will be APIs with a specified behavior.
*   DAGs, parallelization, map-reduce, concurrency, and ensemble models. LLMs will improve – bigger, faster, and more optimized. Until then, we can scale them in a more traditional distributed system. Not only can LLMs specify a series of tasks to perform, but they can also specify the DAG and ordering of tasks – e.g., which jobs depend on each other or which can be done in parallel.