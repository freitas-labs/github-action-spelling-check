---
title: "Reflections on 10,000 Hours of DevOps - Matt Rickard"
description: 'Some reflections after putting 10,000 hours into DevOps engineering. From my early adolescence doing sysadmin work, customizing my Arch Linux installation, to running a server in the closet of my college dorm (narrator: it was loud, and my email rarely delivered), to working on open-source DevOps at Google — I’ve probably put in many more hours. It’s hard to tell how many of those counted as Malcolm Gladwell’s “deliberate practice,” but these are the lessons learned nonetheless. (Also see my more general...'
summary: The following is a reflection of 10,000 hours put in DevOps practices and work. The author presents a list of rules and tips he thinks everyone should follow if they work in a DevOps environment."
keywords: ['matt rickard', 'reflection', 'devops', 'tips']
date: 2023-04-12T06:57:56.375Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'reflection', 'devops', 'tips']
---

The following is a reflection of 10,000 hours put in DevOps practices and work. The author presents a list of rules and tips he thinks everyone should follow if they work in a DevOps environment.

https://blog.matt-rickard.com/p/reflections-on-10000-hours-of-devops

---

Some reflections after putting 10,000 hours into DevOps engineering. 

From my early adolescence doing sysadmin work, customizing my Arch Linux installation, to running a server in the closet of my college dorm (narrator: it was loud, and my email rarely delivered), to working on open-source DevOps at Google — I’ve probably put in many more hours. It’s hard to tell how many of those counted as Malcolm Gladwell’s “deliberate practice,” but these are the lessons learned nonetheless. (Also see my more general [reflections on 10,000 hours of programming](https://matt-rickard.com/reflections-on-10-000-hours-of-programming)).

1.  [Reproducibility matters](https://matt-rickard.com/spectrum-of-reproducibility). Without it, these subtle bugs burn hours of debugging time and kill productivity.
    
2.  Never reuse a flag.
    
3.  The [value of a CI/CD Pipeline](https://matt-rickard.com/an-ideal-ci-cd-system) is inversely proportional to how long the pipeline takes to run.
    
4.  [Code is better than YAML](https://matt-rickard.com/advanced-configuration-languages-are-wrong).
    
5.  Linear git history makes rollbacks easier.
    
6.  Version your APIs. Even the internal ones. No stupid breaking changes (e.g., renaming a field). Don’t reinvent the wheel. Use semantic versioning.
    
7.  Do not prematurely split a monorepo. [Monorepos have U-shaped utility](https://matt-rickard.com/monorepos) (great for extremely small or large orgs).
    
8.  Vertical scaling (bigger machines) is much simpler than horizontal scaling (sharding, distributed systems). But sometimes, the complexity of distributed systems is warranted.
    
9.  [Your integration tests are too long.](https://matt-rickard.com/your-integration-tests-are-too-long)
    
10.  Have a high bar for introducing [new dependencies](https://matt-rickard.com/nine-circles-of-dependency-hell). Especially ones that require special builds or environments.
    
11.  [Release early, release often.](https://matt-rickard.com/deploy-early-deploy-often)
    
12.  Do not tolerate flaky tests. Fix them (or delete them).
    
13.  [Make environments easy to set up from scratch](https://matt-rickard.com/environment-parity). This helps in every stage: local, staging, and production. 
    
14.  Beware [toolchain sprawl](https://matt-rickard.com/minimal-viable-frameworks). Every new tool requires expertise, management, and maintenance.
    
15.  Feature flags and gradual rollouts save headaches. 
    
16.  Internal platforms (e.g., a PaaS) can make developers more productive, but make sure you aren’t getting in the way. Only create new abstractions that could only exist in your company.
    
17.  [Don’t use Kubernetes, Yet.](https://matt-rickard.com/dont-use-kubernetes-yet) Make sure your technology's complexity matches your organization's expertise. 
    
18.  Cattle, not pets (prefer ephemeral infrastructure over golden images). Less relevant in the cloud era but important to remember.
    
19.  Avoid shiny objects but know when the paradigm shifts.
    
20.  [Technical debt isn’t ubiquitously bad](https://matt-rickard.com/good-technical-debt).
    
21.  Meaningful health checks for every service. Standardize the endpoint (e.g., /healthz) and statuses.
    
22.  [80/20 rule for declarative configuration](https://matt-rickard.com/the-declarative-trap). The last 20% usually isn’t worth it. 
    
23.  Default to closed (minimal permissions for) infrastructure.
    
24.  [Default to open for humans](https://matt-rickard.com/code-transparency). It’s usually a net benefit for developers to view code outside their own project.
    
25.  Bash scripts aren’t as terrible as their reputation. Just don’t do anything too complex. Always “set -ex” and “-o pipefail.”
    
26.  Throttle, debounce, and rate-limit external APIs. 
    
27.  Immutable infrastructure removes a whole class of bugs.
    
28.  [Makefiles are unreasonably effective](https://matt-rickard.com/the-unreasonable-effectiveness-of-makefiles). 
    
29.  If you have to do a simple task more than 3 times, automate it.
    
30.  [Be practical about vendor lock-in](https://matt-rickard.com/dont-be-scared-of-vendor-lock-in). Don’t over-engineer a generic solution when it’s incredibly costly. But proprietary solutions have a cost (developer experience, customizability, etc.)
    
31.  Structured logging (JSON) in production, plaintext in development. 