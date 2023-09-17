---
title: "Why Do Configuration Changes Cause Outages?"
description: "From a glance, a good percentage of outages are caused by bad configuration changes – the 2021 global Facebook outage, the $440mm bad configuration that brought down Knight…"
summary: "The author provides his view on how configuration changes impact software production lines and how they can be evil."
keywords: ["matt rickard", "sre", "cloud"]
date: 2022-11-26T20:37:54+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'sre', 'cloud']
---

The following is a retrospective on recent configuration changes outages and how they can impact software production lines, although being designed to be **failproof**:

https://matt-rickard.ghost.io/why-do-configuration-changes-cause-outages/

---

From a glance, a good percentage of outages are caused by bad configuration changes – the 2021 global Facebook outage, the $440mm bad configuration that brought down Knight Capital in 2012, numerous global outages at Google Cloud, Microsoft Azure, Cloudflare, and other companies with serious engineering cultures.  Why do configuration changes cause so many outages?
>
- **Configuration breaks production/development parity** – ideally, services in development and production are deploying similar code and have similar but separate infrastructure. No matter how close you get to production, there will always be the configuration that needs to be different (e.g., deploying to development.matt-rickard.com vs. matt-rickard.com).
- **Some configuration isn't testable** – The Facebook outage was caused by bad BGP configuration. Internet configuration is often the hardest to test – how to do emulate BGP routes, DNS, or other global infrastructure in a way that mimics the real world. Much like models, all staging environments are wrong, but some are useful.
- [Every sufficiently advanced configuration language is wrong](https://matt-rickard.com/advanced-configuration-languages-are-wrong). There are significant problems that can occur in the configuration itself – most configuration languages are untyped, templated, manually duplicated, or synced by hand.
>
What helps prevent outages due to bad configuration?
>
- [The SRE book by Google](https://sre.google/workbook/configuration-design/) touches on some practical properties of safe configuration changes – (1) gradual configuration changes, (2) rollback-safe changes, and (3) automatic rollback or canary deploys.
- Infrastructure-as-code likely helps. Configuration that is code is easier to test, validate, and deploy. This usually means that configuration is owned by the right teams and goes through the right reviews (e.g., code reviews).
- Limited blast radius for configuration – control planes that are cleanly separated from data planes and configuration with clearly associated services.
- Immutable infrastructure – configuration that goes through multiple changes is likely to end up in a state that is hard to emulate from scratch in test environments.  
>
>But configuration change outages are anything but a solved problem.