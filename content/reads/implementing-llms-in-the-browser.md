---
title: "Implementing LLMs in the Browser"
description: "LLMs are coming to the browser. While it’s still really slow, running these computations on clientside is much cheaper. And the browser is the ultimate delivery mechanism — no downloading packages, setting up a programming environment, or getting an API key. But, of course, they won’t be used clientside for everything — initially just testing, playgrounds, and freemium getting-started experiences for products."
summary: "The following is an highlight to a feature that many ML platforms will start to integrate: Large Language Models in the browser. This will allow people to train or use LLMs in a \"free manner\", since they are the ones paying the computation costs for training these models."
keywords: ['matt rickard', 'browser', 'llms', 'webgpu', 'crypto']
date: 2023-05-01T08:26:13.296Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'browser', 'llms', 'webgpu', 'crypto']
---

The following is an highlight to a feature that many ML platforms will start to integrate: **Large Language Models** in the browser. This will allow people to train or use LLMs in a "free manner", since they are the ones paying the computation costs for training these models.

I feel like there will be a wave of silent JS embedded tags that will train these models on websites for free without the user permission. Just like in the early days when people used to mine crypto in the browser.

https://blog.matt-rickard.com/p/implementing-llms-in-the-browser

---

LLMs are coming to the browser. While it’s still really slow, running these computations on clientside is much cheaper. And the browser is the ultimate delivery mechanism — no downloading packages, setting up a programming environment, or getting an API key. But, of course, they won’t be used clientside for everything — initially just testing, playgrounds, and freemium getting-started experiences for products. 

There are generally two strategies for getting LLMs working in the browser:

**Compile C/C++ or Rust to WebAssembly.** Take a fairly vanilla library like [ggml](https://github.com/ggerganov/ggml) and use emscripten to convert it to WebAssembly (Wasm fork of ggml, [WasmGPT](https://github.com/lxe/wasm-gpt/tree/wasm-demo)). Optionally, target the new WebGPU runtime like [WebLLM](https://github.com/mlc-ai/web-llm).

**Implement transformers in vanilla JavaScript.** [Transformers.js](https://github.com/xenova/transformers.js). These models don’t have the most complicated architecture. Typically, they can be implemented in less than a thousand lines of code (nanoGPT is 369 lines, with comments). You might also target WebGPU with this strategy, like [WebGPT](https://github.com/0hq/WebGPT).

Now, combine a WebAssembly LLM in the browser with a WebAssembly Python interpreter in the browser, and you might get some interesting applications that are sandboxed by default. 

WebGPU will ship on May 2nd in Chrome. WebGPU exposes more advanced GPU features and general computation primitives (unlike WebGL). 