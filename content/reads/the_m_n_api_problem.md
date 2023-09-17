---
title: "The M:N API Problem"
description: "The proliferation of SaaS applications has created a difficult problem: m services must connect and flow data to n different services. Each has it's own constantly changing and independent..."
summary: "The author describes the **M:N API** problem: how to ensure that *(M)* services that connect to *(N)* different services, can keep data flow during their lifetime with breaking changes on both ends."
keywords: ['matt rickard', 'architecture', 'api', 'integration engineering']
date: 2023-01-06T19:57:11+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'architecture', 'api', 'integration engineering']
---

https://matt-rickard.ghost.io/the-m-n-api-problem/

The author describes the **M:N API** problem: how to ensure that *(M)* services that connect to *(N)* different services, can keep data flow during their lifetime with breaking changes on both ends. The author also suggests platforms that try to solve this problem, but reminds everyone that there is no silver bullet.

---

The proliferation of SaaS applications has created a difficult problem: _m_ services must connect and flow data to _n_ different services. Each has it's own constantly changing and independently maintained API. Consumers need to write and maintain _m_ × _n_ connectors, which are expensive, error-prone and require never-ending maintenance. What's the solution?

There have been many attempts at solving this problem: e.g., Zapier for consumers, Mulesoft for enterprises, and Fivetran for data. The idea is to outsource the work to a third party, who then diligently keeps the connectors updated. There are variations on this theme – outsource the work to open source developers (plugin system) or try to develop a universal standard.

However, this problem will _never_ be solved for most use cases. Sure, engineering best practices can improve – semantic versioning and backward compatibility. But for many use cases, API publishers have no incentive to make this easy on the integrators. If they did want to support mission-critical API consumers, they would rather have a direct enterprise relationship with the end-user. But in many cases, the scope of the API is limited to filling in the gaps in a product suite. They don't want you checking Mulesoft for your observability dashboards when they are most likely selling their own managed product dashboards.