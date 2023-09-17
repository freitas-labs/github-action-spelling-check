---
title: "The Local Development Story"
description: "How do you run software locally for testing, development, or experimentation?

This is probably the key question for most developer-focused products, and the answer often plays a significant role in the decision process.

Bad local development stories can be a source of enormous friction. So what does a bad local development experience look like?

 * Stateful APIs without a clear forking or lightweight new environment mechanism (e.g., databases)
 * Hidden errors that aren’t surfaced to the user
"
summary: "Testing software products locally is most of the times seen as an not important task. This leads to wasting time on repeating steps no one wants to automate, just because “it’s only local, not production”."
keywords: ['matt rickard', 'software development', 'software engineering']
date: 2023-05-23T21:46:34.445Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'software development', 'software engineering']
---

Testing software products locally is most of the times seen as an not important task. This leads to wasting time on repeating steps no one wants to automate, just because “it’s only local, not production”.

https://matt-rickard.com/the-local-development-story

---
 
How do you run software locally for testing, development, or experimentation?

This is probably the key question for most developer-focused products, and the answer often plays a significant role in the decision process.

Bad local development stories can be a source of enormous friction. So what does a bad local development experience look like?

*   Stateful APIs without a clear forking or lightweight new environment mechanism (e.g., databases)
*   Hidden errors that aren’t surfaced to the user
*   Needs to integrate with multiple services behind a firewall (or on a developer’s machine) but provided network path (or tools to set up on). The SaaS version of this is “whitelist these IPs.”
*   No automation or APIs for commonly automated tasks (setting up a new environment, configuration, etc.).

Potential generic solutions

*   Open-source parts and let the developers figure it out
*   Emulators that mimic production behavior (e.g., LocalStack/AWS)
*   Minified versions of the real thing (e.g., minikube/Kubernetes)
*   Stateless APIs
*   APIs for ephemeral services (e.g., spin up an AWS SQS queue for local development and then delete it)
*   Verbose and surfaced logs for parts of the service that need to be debugged.
