---
title: "The Heptagon of Configuration"
description: "A pattern I've observed in software configuration of complex systems and that explains why bash scripts are everywhere, even at Google."
summary: "The following is a description of the pattern \"Heptagon of Configuration\", a term which the author invented to describe the endless life cycle of program configuration. The author says that we start from simple, but that is less flexible, and end up increasing complexity in trade of flexibility. When we notice that we start being in a less simple but more flexible environment, we start reducing complexity and in trade, also less flexibility."
keywords: ['matt rickard', 'software development', 'configuration']
date: 2023-04-17T06:53:59.681Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'software development', 'configuration']
---

The following is a description of the pattern "Heptagon of Configuration", a term which the author invented to describe the endless life cycle of program configuration. The author says that we start from simple, but that is less flexible, and end up increasing complexity in trade of flexibility. When we notice that we start being in a less simple but more flexible environment, we start reducing complexity and in trade, also less flexibility.

https://matt-rickard.com/heptagon-of-configuration

---

The _Heptagon of Configuration_ is a term I'm coining to describe a pattern I've observed in software configuration, where configuration evolves through specific, increasing levels of flexibility and complexity before returning to the restrictive and simple implementation.

How does the cycle work?

Hardcoded values are the simplest configuration - but provide very little flexibility. The program surface increases, and with it, the configuration, incorporating environment variables\* and flags, and when that becomes cumbersome, a configuration file encodes the previous.

When multiple environments require similar configuration files, a [templating language](https://en.wikipedia.org/wiki/Template_processor?ref=matt-rickard.com) is used to eliminate repetition and promote the reuse of templates.

The templates grow in complexity until nearly every option in the configuration file is templated - rendering the reusability useless.

A [Domain Specific Language (DSL)](https://en.wikipedia.org/wiki/Domain-specific_language?ref=matt-rickard.com) is invented to promote the reuse of logical blocks instead of using an inflexible, static template.

Since the DSL incorporates domain-specific knowledge by definition, every new function added increases the complexity for the end user. The code eventually becomes unreadable and unmaintainable, and the remaining programs are rewritten in Bash. Bash provides ultimate flexibility with a guise of reusability.

However, the Bash scripts are difficult to prove correctness and rely on fragile text manipulation to generate a configuration file or template.

The most used Bash scripts evolve into new CLIs with hard-coded behavior. The cycle continues.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/heptagon-of-configuration/IMG_0007.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Coincidence?

**\*Fun fact**: Environment variables celebrated their 40th birthday this year.