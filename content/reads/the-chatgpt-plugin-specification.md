---
title: "The ChatGPT Plugin Specification"
description: "ChatGPT plugins can call external services to augment answers. They might run a code interpreter or access an API like OpenTable or Zapier.

There isn’t publicly available information about how ChatGPT plugins work behind the scenes — it could be something like Toolformer or a custom implementation. But the public API is interesting in itself.

Developers submit a manifest with some metadata. The interesting parts of this are:

 * Name for model and name for human (or company) — Plausibly how th"
summary: "The following is a review on the process of submission/publishing a plugin to be integrated with ChatGPT."
keywords: ['matt rickard', 'chatgpt', 'plugin', 'integration engineering', 'software engineering']
date: 2023-05-24T20:07:50.912Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'chatgpt', 'plugin', 'integration engineering', 'software engineering']
---

The following is a review on the process of submission/publishing a plugin to be integrated with ChatGPT.

With no details about the implementation behind the integration tool, the team at OpenAI managed to designed a really simple, developer friendly, API for submitting new integrations. All developers need to do is: share metadata about the plugin, a template description to be used by models and an OpenAPI spec schema.

https://matt-rickard.com/the-chatgpt-plugin-specification

---

ChatGPT plugins can call external services to augment answers. They might run a code interpreter or access an API like OpenTable or Zapier.

There isn’t publicly available information about how ChatGPT plugins work behind the scenes — it could be something like Toolformer or a custom implementation. But the public API is interesting in itself.

Developers submit a manifest with some metadata. The interesting parts of this are:

*   Name for model and name for human (or company) — Plausibly how the model refers to the tool. Maybe a simple pattern matching to understand when the generated output is deciding to use a specific tool.
*   Description for model — This most likely gets templated into the prompt somehow. You can only use 3 plugins simultaneously. Maybe that’s a result of this workflow. There’s some guidance and guardrails around this so that it doesn’t spill over into other parts of the completion (because it’s most likely templated into the prompt). This seems like a great vehicle for prompt injection (especially hard to find in a chained workflow of plugins).
*   OpenAPI specification — This is how the model understands what to call. There’s probably no fine-tuning on specific tools (maybe there’s fine-tuning like Toolformer with OpenAPI specifications, but it doesn’t seem like it). This means that they can add new plugins without any extra work. There are also some limits on the size of the OpenAPI spec.

The interesting things about the plugin specification:

*   Plugins do not know anything about the model. They are simply an API server and an API specification. This means that plugins should be theoretically compatible across different model versions.

There’s no natural language parsing or usage in the actual plugin. Just JSON or whatever your wire protocol is.