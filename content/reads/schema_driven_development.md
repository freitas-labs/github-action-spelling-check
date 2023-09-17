---
title: "Schema Driven Development"
description: 'How do you design an API? Most APIs are a mishmash of "REST-like" and freeform dynamic typed JSON. However, some more mature organizations have...'
summary: "The following is a retrospective on the concept of developing around a schema. Modern development is based on dynamic APIs (as in you never know exactly what is the output of the API), however toolchains are being built to enforce validations with schemas, which allows safer consuption by clients."
keywords: ['matt rickard', 'schema', 'api', 'protobuf']
date: 2023-03-02T21:04:41+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'schema', 'api', 'protobuf']
---

The following is a retrospective on the concept of developing around a schema. Modern development is based on *dynamic APIs* (as in you never know exactly what is the output of the API), however toolchains are being built to enforce validations with schemas, which allows safer consuption by clients.

The article was written in 2022 and mentions **protobufs** + **gRPC** as the best environment for API development, however new tools are emerging (such as `tRPC`).

https://matt-rickard.com/schema-driven-development

---

How do you design an API? Most APIs are a mishmash of "REST-like" and freeform dynamic typed JSON. However, some more mature organizations have API-style guides.

Schema-driven development is a better alternative. APIs are defined programmatically with schemas. These schemas are often written in JSON (OpenAPI) or some interface definition language (IDL) – e.g., `.proto` or `.thrift`. These files are then compiled into language or platform-specific stubs for clients and servers.

Schema-driven development means that teams only take a dependency on the actual API definition. You can do style enforcement and build tooling on the schemas (linting, client/server code generation, etc.).

I think we're in the early days of schema-driven development. Unfortunately, there isn't a clear "right" answer today. OpenAPI is complex and suffers from scope creep – more client and server options find their way into the specification. Google's protobufs and gRPC are the best options today, yet they are too tied to the Google way of doing things. As a result, they both suffer from being second-class open-source citizens as projects are thrown over the corporate fence (see bazel).

Then there's also the question of generating code with these compilers – see my post on [Source Code Generation](https://matt-rickard.com/generated-code/). Using `protoc` is notoriously tricky – the protobuf compiler requires a deep toolchain and dependencies (it's best to use a Docker container). Maybe we can generate context-aware protocols with some help from something like Copilot.