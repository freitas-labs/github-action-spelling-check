---
title: "Why DSLs Fail"
description: 'Domain-specific languages seem like an attractive solution when templating becomes too cumbersome for a set of problems. The proposition: fit the programming model space to the problem space. Just enough control flow, macros, and functions to solve a specific set of problems (infrastructure configuration, build systems, scripting, etc.)'
summary: "The author describes the pros and cons of creating and mantaining a Domain Specific Language (DSL), explaining how DSLs keep a slow pace of evolution, in contrast to system grow."
keywords: ['matt rickard', 'dsl', 'infrastructure']
date: 2023-02-24T08:04:50+0000
draft: false
categories: ['reads']
tags: ['matt rickard', 'dsl', 'infrastructure']
---

The author describes the pros and cons of creating and mantaining a Domain Specific Language (DSL), explaining how DSLs keep a slow pace of evolution, in contrast to system grow.

https://matt-rickard.ghost.io/why-dsls-fail/

---

Domain-specific languages seem like an attractive solution when templating becomes too cumbersome for a set of problems. The proposition: fit the programming model space to the problem space. Just enough control flow, macros, and functions to solve a specific set of problems (infrastructure configuration, build systems, scripting, etc.)

But DSLs have failed again and again. Why?

*   **Limited abstractions:** The future problem space is unpredictable. If you design a DSL that perfectly fits the problems today, it will be obsolete quickly. You can try to future-proof the design by budgeting in room for growth – but it’s difficult to see the future, and eventually, that too, becomes obsolete.
*   **Steep Learning Curve:** Extensive training is required. I remember attending a Puppet training for fun early in my career (after I exploited a vulnerability in our (pre-cloud) internal infrastructure provisioning system to deploy my apps without ops, they agreed to let me deploy and manage my own infrastructure if I took the training and wrote my own scripts). It’s expensive for companies to hire employees with DSL expertise and to maintain the code over time.
*   **Maintenance Burden:** DSLs often have a vaguely similar yet incompatible toolchain. DSLs often come with their own compiler, test suite, standard library, and more. These are hard to integrate with the rest of your infrastructure.

Are DSLs hopeless? Mostly. They will be slowly replaced by general-purpose programming languages. It’s why I think TypeScript is the language of infrastructure-as-code. Then, the configuration can live closer to (or inside of) the application code base. Developers can reuse libraries from the language ecosystem. Integration is simple (you might even reuse existing infrastructure). But how can you get the benefit of the restriction of DSLs with general-purpose programming languages?

*   Compiled down to intermediate representations. AWS CDK compiles to CloudFormation templates, Terraform to API calls. You can still validate, test, and analyze these frameworks, despite the fact they are in general-purpose languages.
*   Restrictions via IAM or resource isolation. If you don’t want your DSL calling specific APIs or accessing the internet, you can do that via IAM or resource isolation (e.g., Wasm or containers).