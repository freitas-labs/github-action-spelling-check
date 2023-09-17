---
title: "On-Demand Package Manager"
description: "What if a package manager built packages on demand? What if docker registries built images as they were requested? Today, there are a few manual steps between a developer writing code and other developers being able to use that code as a package. Some package managers allow developers to reference code by git references (e.g., a checksum or tag), but not all code is useable simply by pulling the source files. Instead, there’s usually a bundling or compilation step."
summary: "The following is the description of what a on-demand package manager would look like and its use cases."
keywords: ['matt rickard', 'package manager', 'web assembly', 'node', 'docker']
date: 2023-05-12T06:40:07.296Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'package manager', 'web assembly', 'node', 'docker']
---

The following is the description of what a on-demand package manager would look like and its use cases.

https://blog.matt-rickard.com/p/on-demand-package-manager

---

What if a package manager built packages on demand? What if docker registries built images as they were requested?

Today, there are a few manual steps between a developer writing code and other developers being able to use that code as a package. Some package managers allow developers to reference code by git references (e.g., a checksum or tag), but not all code is useable simply by pulling the source files. Instead, there’s usually a bundling or compilation step.

What if the package manager could bundle software on-demand? If a user request a docker image example:v3 that hasn’t been uploaded to the registry, the image registry could still satisfy the request by pulling the code, building the image, and serving the artifact. The end user gets the image they wanted, and the maintainer doesn’t have to worry about building, tagging, and pushing every time they make a change.

It’s not just docker images. The foundation is being built for cross-language packages — C++ code converted with emscripten and exposed to javascript via embind, or WebAssembly modules exporting functions to different runtimes. Today, the process looks something like this — fork a repo, create a project\_bindings.cpp file that exposes a few methods, compile it to JavaScript (or some other language) bindings, and push it to the appropriate package manager. What if all of this could happen automatically? What if you could just find (most) code on GitHub and just import it, regardless of language?

There’s some hand-waving here. A repository and a Dockerfile aren’t sufficient to figure out how to build the project into a Docker image (although it’s sufficient most of the time). WebAssembly or other bindings to languages aren’t always straightforward to figure out (although the process is getting easier all the time). A basic version of this is what I described as [GitHub’s missing package manager](https://matt-rickard.com/githubs-missing-package-manager), but there is a lot more that can be built.