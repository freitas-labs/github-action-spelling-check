---
title: "Amdahl's Law and Optimization"
description: "The following is an explanation of Amdahl's Law and how its principles can be applied to achieve efficient parallel programs."
summary: "The following is an explanation of Amdahl's Law and how its principles can be applied to achieve efficient distributed systems."
keywords: ['matt rickard', 'theory', 'parallelization', 'distributed systems']
date: 2023-03-05T09:46:31+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'theory', 'parallelization', 'distributed systems']
---

The following is an explanation of Amdahl's Law and how its principles can be applied to achieve efficient parallel programs.

https://matt-rickard.ghost.io/amdahls-law-and-optimization/

---

Amdahl's Law is a formula that helps to estimate the maximum speedup that can be achieved by parallelizing a program. It's intuitive and practical. The equation is fairly simple:

`Speedup = 1 / ((1 - P) + (P / N))`

Where:

*   Speedup is the improvement in performance that can be achieved by parallelizing the program.
*   `P` is the fraction of the program that can be parallelized.
*   `N` is the number of processors used to execute the program.

What does it mean? Any improvement by parallelization (e.g., distributing work across multiple computers or processors) is limited by how much of the program can be parallelized.

*   Optimizing the longest step (parallel or serial) is a good strategy for optimization ([Andy Grove's "limiting steps"](https://matt-rickard.com/limiting-steps?ref=matt-rickard)).
*   "A system is only as fast as the slowest part."
*   You need to view optimizations in the context of the overall execution time. Big optimizations in short steps sometimes don't always contribute much to the bottom line (and the converse).
*   The bigger the program (or problem), the more opportunities to parallelize and therefore, the greater benefits to parallelization (Gustafson's Law)