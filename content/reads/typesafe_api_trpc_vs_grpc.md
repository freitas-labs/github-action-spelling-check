---
title: "Type-Safe API Calls: tRPC vs. gRPC"
description: 'Type-safe API calls are those in which a client application can specify the exact API protocol and data types used for communicating with a server. Type-safe API calls reduce the probability of mismatched errors between clients and servers – unexpected fields, missing but expected fields, and fields of the wrong type.'
summary: "The following is a retrospective on type-safe API calls, a protocol which both client and server fully understand the data and requests schema."
keywords: ['matt rickard', 'type-safety', 'typescript', 'trpc', 'grpc']
date: 2023-01-30T08:12:03+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'type-safety', 'typescript', 'trpc', 'grpc']
---

The following is a retrospective on type-safe API calls, a protocol which both client and server fully understand the data and requests schema. One of the most recognized type-safe API protocols is `gRPC`, an RPC protocol which uses the `protobuf` schema language to generate both client and server code, and thus guaranteeing type-safety. However, there is a new player in town that is disrupting the way we see these protocols: `tRPC`. Having these kind of protocols shine belong developers is a major advancement in building error-free software, as they become more interested and knowledgeable about type-safety and functional programming.

https://matt-rickard.ghost.io/trpc-grpc-type-safety/

---

Type-safe API calls are those in which a client application can specify the exact API protocol and data types used for communicating with a server. Type-safe API calls reduce the probability of mismatched errors between clients and servers – unexpected fields, missing but expected fields, and fields of the wrong type or shape. I call this [Schema-driven development](https://matt-rickard.com/schema-driven-development).

How do you make type-safe API calls? You must type-check the request and response on both the client and server. You can't really do this in the wire protocol for two reasons. First, it's expensive to send schema information along with every request – JSON and protobuf don't send this information for that reason. Second, there's no guarantee that the client and server agree on the particular schema – i.e., it might be the right type and suitable shape for the client. Still, the server has been upgraded and is no longer backward compatible.

First, let's look at how gRPC implements this feature. First, gRPC uses protobuf, a compact wire protocol with a schema defined in a `proto` file. Next, those proto files are used to generate clients/servers in various languages (C++, Java, Go, Python). gRPC solves many other problems, but let's dig into the issues with this process.

*   Generated code is hard to read and hard to debug. In addition, it needs to be regenerated every time the schema changes.
*   Because of the bespoke protobuf toolchain (it was invented at Google), it's difficult and heavyweight to run in browser environments.

tRPC is a new library with a different approach. It's not as optimized over the wire as gRPC (it uses HTTP), but it's much easier to use. Unfortunately, it's only a TypeScript library, so you can't share code across different languages.

*   There's no code generation. Instead, the schema is defined in TypeScript and can dynamically be imported by both the client and server.
*   It is web-native rather than backend-agnostic (at the cost of only supporting TypeScript).
*   It uses the JSON-RPC specification, which can be difficult to parse for many backend languages with strict type systems.  

tRPC is interesting because it makes some (seemingly reasonable) tradeoffs for developer productivity and maintainability. Moreover, it's an interesting example of [solving the simple case](https://matt-rickard.com/solving-the-simple-case).