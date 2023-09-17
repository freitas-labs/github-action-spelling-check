---
title: "Stack Shift"
description: 'When containers emerged as the new paradigm, we had a new way to quickly isolate and limit application resources like CPU, memory, and disk I/O via cgroups. Containers were by far the best way to do it for most languages. But, for Java programmers, the JVM did that already.'
summary: "The following is a retrospective on the current trend to shift to the usage of SQLite, a local file database, instead of traditional remote database management systems."
keywords: ['matt rickard', 'sre', 'devops', 'docker', 'jvm', 'sqlite']
date: 2023-02-12T19:58:55+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'sre', 'devops', 'docker', 'jvm', 'sqlite']
---

The following is a retrospective on the current trend to shift to the usage of SQLite, a local file database, instead of traditional remote database management systems. The author goes on to detail previous stack shifts for controling system resources schedule and Kubernetes, ending by comparing them with the usage of SQLite.

https://matt-rickard.ghost.io/stack-shift/

---

When containers emerged as the new paradigm, we had a new way to quickly isolate and limit application resources like CPU, memory, and disk I/O via cgroups. Containers were by far the best way to do it for most languages. But, for Java programmers, the JVM did that already.

Most DevOps and SRE organizations support more than just Java applications within a company, so consistently treating resource limits and isolation made more sense. However, there was a short but painful period where the Java programmers needed to configure the JVM to defer to container limits and vice versa.

The stack shift — we took an important but language-specific feature — resource limits and isolation — and made their language agnostic and easier to configure in a cloud-native world.

The stack shift happened again with Kubernetes. Distributed applications long had to build their own primitives — leader election, consensus, and service discovery. What happened when Kubernetes and other generic layers solved those problems in a different part of the stack? Kubernetes did adapt (StatefulSets), but new applications took advantage of these primitives from the start (which is why we see such a separation of data/control plane).

Simultaneously this happened with the separation of storage and compute in enterprise data warehouses. Now it’s starting to emerge on a smaller scale with SQLite — companies are building out the distributive primitives on top of the local-first database: multi-writer, locks, replication, and more.