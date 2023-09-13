---
title: "Applications, Services, and Workflows Overload"
description: "Countless products aim to abstract the \"application,\" the \"service\", or the \"workflow.\" But seeking to abstract (and by association, define) these layers won't work—a look at definitions."
summary: "The following is an attempt to define what is the meaning of application, services and workflows. Developers often tend to overly abstract concepts by thinking that everything is a black-box that can be interconnected. In practice, this is not possible because every component has its different specifications and needs."
keywords: ['matt rickard', 'software engineering', 'glossary', 'kubernetes']
date: 2023-03-06T18:50:36+0000
draft: false
categories: ['reads']
tags: ['reads', 'software engineering', 'glossary', 'kubernetes']
---

The following is an attempt to define what is the meaning of application, services and workflows. Developers often tend to overly abstract concepts by thinking that everything is a black-box that can be interconnected. In practice, this is not possible because every component has its different specifications and needs.

https://matt-rickard.ghost.io/applications-services-and-workflows-overload/

---

Countless products aim to abstract the "application," the "service," or the "workflow." But seeking to abstract (and by association, define) these layers won't work—a look at definitions.

What's an application? Possible definitions

*   The code – The most basic definition of an application. Unfortunately, you usually can't just deploy code without any other assumptions. For example, it might have to be compiled, it might have build time or runtime dependencies, and it might be a smaller part of a more extensive system (FaaS, plugin system, etc.)
*   A WebAssembly binary – Compiled code to an intermediate format that can be executed on a shared runtime. Runnable, but what happens when the binary needs to interface with the system? There's WASI (WebAssembly System Interface) but no bundling format for auxiliary files or dependencies.
*   A container – Docker went a long way in defining a somewhat standardized deployment artifact. In a glorified zip file, you could couple your runtime dependencies outside your code (binaries, packages, shared libraries, language runtimes). But containers aren't always sufficient to deploy in production. For example, you might want to modify variables at runtime via environment variables or flags.
*   A pod – A set of containers that share the same IPC namespace. The smallest deployable unit on Kubernetes.
*   A set of pods with autoscaling rules – A set of pods with rules around how many replicas should be running and a controller that enforces that configuration. Think Deployments or StatefulSets in Kubernetes.

What's a service?

*   A network process that listens on a port with a specific protocol (e.g., TCP). What happens when multiple copies of a service are listening across different nodes? What if some are ephemeral?
*   A discoverable application that listens on a port – Service often implies _service discovery –_ how can other applications find each other through DNS or load balancers? A service discovery mechanism is tightly coupled with the underlying concept of an application. It's hard to mix and match definitions.

It's possible that the underlying technologies or abstractions just aren't there to define these concepts (which is why it's so hard). An application was much harder to define before containers arrived (or Kubernetes).