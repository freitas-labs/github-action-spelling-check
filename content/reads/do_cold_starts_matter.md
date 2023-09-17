---
title: "Do Cold Starts Matter?"
description: 'Since serverless runtimes came to be, developers have agonized over "cold starts", the delay between when a request is received and when the runtime is ready to process the request...'
summary: "The author provides his view on the impact of cold starts and some tips to reduce its time"
keywords: ['matt rickard', 'cloud', 'serverless', 'AWS', 'cold start']
date: 2022-12-01T10:43:57+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'cloud', 'serverless', 'AWS', 'cold start']
---

The following is a retrospective on cold starts, **the delay between receiving a request and processing it**, in a serverless runtime environment. The author provides some tips on reducing this delay period but also attempts the reader to reflect if cold start times are really crucial to their product.

https://matt-rickard.ghost.io/do-cold-starts-matter/

---

Since serverless runtimes came to be, developers have agonized over "cold starts", the delay between when a request is received and when the runtime is ready to process the request.

It’s hard to benchmark exactly how long cold start durations are across runtimes as they are very sensitive to workloads. Using the NodeJS Lambda runtime on AWSS, you might see cold starts anywhere from 400ms to 1 second, depending on your function, memory, and network configuration.
>
But how much do cold starts matter? For the heaviest use cases, there are probably optimizations that you can make directly in the serverless runtime (see AWS’s newly announced Lambda SnapStart for Java Functions that reduces startup time for Spring apps from 6 seconds down to 200ms).
>
But for the majority of cases, there are really easy alternatives if you’re willing to step a little outside the serverless-scale-to-zero-everything paradigm.

- Provisioned concurrency in a serverless runtime. The cost to keep a handler “warm” is fairly minimal (about $10/mo for a 1GB Lambda). Most serverless runtimes have this built-in already (AWS Lambda, Fargate, Cloud Run).
- Keep functions warm by invoking them every few minutes or warming the cache on machines.
- Use autoscaled containers or VMs for critical paths.
- Edge runtimes for small functions that can be run in v8 isolates.
>
In the majority of workloads, your Lambda cold start time is probably the least of your worries, even though it is one of the most obvious (performance comes last, unfortunately). Small architectural changes can solve cold start latencies. Maybe there's a new class of workloads that's enabled by being able to run large tasks with a low cold start time and zero provisioned infrastructure. But for now, the cost differential isn't that large with just running a small set of services all the time.