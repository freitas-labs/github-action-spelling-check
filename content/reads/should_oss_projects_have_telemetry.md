---
title: "Should OSS Projects Have Telemetry?"
description: "Russ Cox, the tech lead for the Go programming language at Google, made a case for adding opt-out telemetry to the language's toolchain in Transparent Telemetry for Open-Source Projects."
summary: "The author reflects on the usage of telemetry in OSS projects, explaining how important it is for maintainers, as it's an excellent way to get feedback from developers who are using the tools."
keywords: ['matt rickard', 'oss', 'telemetry', 'devrel']
date: 2023-02-15T07:53:54+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'oss', 'telemetry', 'devrel']
---

The author reflects on the usage of telemetry in OSS projects, explaining how important it is for maintainers, as it's an excellent way to get feedback from developers who are trying and using tools. This read changed my perspective about telemetry, because as the author says, without it OSS maintainers are walking with a blind-fold since they don't know which features are being used and what not, a feeling that all developers share when they publish an OSS project.

https://matt-rickard.ghost.io/should-oss-projects-have-telemetry/

---

Russ Cox, the tech lead for the Go programming language at Google, made a case for adding opt-out telemetry to the language's toolchain in _[Transparent Telemetry for Open-Source Projects](https://research.swtch.com/telemetry-intro)._

As a former open-source maintainer of some fairly large projects, I understand the pain. Without telemetry – you're a product manager flying blind to feedback. From more complex questions: What features are getting used? What APIs are dependent on? To table-stakes questions: How many users are using this tool? Did the last release break something?

Developers often have a viscerally adverse reaction to telemetry. It represents centralization, tracking, and everything wrong with the software industry. Maybe it's just a vocal minority, but developers' revealed preference does not match their stated preference – most developers still use VSCode as their IDE, sending thousands of telemetry events per session. Likewise, Go still collects data through the Go module proxy. And there are far more examples of telemetry in popular projects – Java, C#, .NET Core, Homebrew, Debian, Ubuntu, GitLab, and many others.