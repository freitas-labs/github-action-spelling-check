---
title: "The Missing Semester of CS"
description: "MIT has a pragmatic course that covers proficiency with software tools. The idea is that you utilize these tools so often that they move past being a fact of the vocation to being a problem-solving technique. While my advice is that you should focus on theory and first principles at..."
summary: "The following is a description of MIT's free Computer Science (CS) course, which covers many topics ungraduates and graduates lack knowledge of, and are vital for real jobs."
keywords: ['matt rickard', 'mit', 'computer science', 'course']
date: 2023-03-24T21:51:12+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'mit', 'computer science', 'course']
---

The following is a description of MIT's free Computer Science (CS) course, which covers many topics ungraduates and graduates lack knowledge of, and are vital for real jobs.

https://matt-rickard.ghost.io/the-missing-semester-of-cs/

---

MIT has a pragmatic course that covers proficiency with software tools. The idea is that you utilize these tools so often that they move past being a fact of the vocation to being a problem-solving technique. While my advice is that you should focus on theory and first principles at school, knowing these concepts can help you learn (and extend) the theory.

Here's what would be in my course (you can see MIT's [here](https://missing.csail.mit.edu/?ref=matt-rickard.ghost.io)):

*   **[Command line essentials](https://matt-rickard.com/mastering-the-command-line?ref=matt-rickard.ghost.io).** The terminal is still the entry point for most developer tasks. Learn it. Understand the [UNIX philosophy](https://matt-rickard.com/instinct-and-culture?ref=matt-rickard.ghost.io). Essential: string manipulation, SSH, git, grep, tar, cURL, UNIX pipes. (I don't think you need to learn vim or emacs anymore).
*   **Package management.** Understand your system's default package manager (e.g., apt on Ubuntu or brew on macOS). How to install, remove, and query packages. Have a good understanding of language-level package managers: installing, removing, and querying. Are you install packages globally or locally? What runtime are you using? A lot of wasted time here.
*   **Build system.** You don't need to know them all, but have a good idea of what files, modules, or packages are getting compiled when you run a build command. How to write a simple [Makefile](https://matt-rickard.com/the-unreasonable-effectiveness-of-makefiles?ref=matt-rickard.ghost.io).
*   **Basic networking.** How to expose a service to the internet (any method you prefer). How to connect to a remote machine. How to forward a port.
*   **One scripting language –**  You should know at least one (1) scripting language – whether that's bash or Python, or something else. It doesn't matter what it is, but you should be able to do quick manipulations and batch operations in it.
*   **One data analysis tool –** Pandas would be my choice, but R or Excel is acceptable. You should be able to quickly generate some obvious insights from structured data (e.g., JSON or CSV) – means, medians, unique values, etc. You should be able to do basic data cleaning. Be able to graph basic data.
*   **One SQL dialect.** You don't have to know complex aggregate functions or common table expressions, but you should know how to SELECT, INSERT, GROUP, and filter data.
*   **Debugging.** I don't think understanding how to use a language-specific debugger would be on the curriculum. Instead, general-purpose debugging techniques. How to read a stack trace. Print debugging (effectively). Methods for identifying and solving different bugs – finding when a bug was introduced (bisect), tracing a bug across multiple services, runtime vs. build time bugs.