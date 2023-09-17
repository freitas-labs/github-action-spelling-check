---
title: "Reflections on 10,000 Hours of Programming"
description: '31 reflections from 10,000 hours of deliberate programming practice.'
summary: "The following is a reflection of 10,000 hours put in programming. The author presents a list of topics and rules he learned along the way, and shares with everyone what others should put into practice."
keywords: ['matt rickard', 'reflection', 'programming', 'tips']
date: 2023-04-16T08:28:09.783Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'reflection', 'programming', 'tips']
---

The following is a reflection of 10,000 hours put in programming. The author presents a list of topics and rules he learned along the way, and shares with everyone what others should put into practice.

Personally, I would like to highlight point 8, 10, 17, 22 and 29.

https://matt-rickard.com/reflections-on-10-000-hours-of-programming

---

> The key to achieving world-class expertise in any skill, is to a large extent, a matter of practicing the correct way, for a total of around 10,000 hours — Malcolm Gladwell in Outliers

I'm certainly not a world-class expert, but I have put my 10,000 hours of deliberate practice into programming. Here are 31 of my reflections on programming.

These are reflections only about **pure coding** — no lessons sum up to "programming is about people" or "how to be a senior technical leader" (arguably more important to a career, but not the topic of this post).

_These reflections are just about deliberately writing code for 10,000 hours_. Most don't apply to beginners. These reflections are not career advice. Think of them as lessons on being a technical guitarist, not about being a good band member. They are about becoming a better programmer for yourself.

I did a podcast with The Changelog where I talked about these more in-depth. [Listen to the episode here](https://changelog.com/podcast/463?ref=matt-rickard.com).

1.  Browsing the source is almost always faster than finding an answer on StackOverflow.
2.  In many cases, what you're working on doesn't have an answer on the internet. That usually means the problem is hard or important, or both.
3.  Delete as much code as you can.
4.  Syntactic sugar is usually bad.
5.  Simple is hard.
6.  Have a wide variety of tools and know which ones to use for the job.
7.  Know the internals of the most used ones like git and bash (I can get out of the most gnarly git rebase or merge).
8.  Build your own tools for repeated workflows. There is nothing faster than using a tool you made yourself (see: [software](https://matt-rickard.com/about/) I wrote).
9.  Only learn from the best. Not all of the best projects are worth emulating verbatim, but it's a good start.
10.  If it looks ugly, it is most likely a terrible mistake.
11.  It should probably be refactored if you have to write a comment that isn't a docstring. Every new line of comments increases this probability. (For a more nuanced take, the [Linux Kernel Documentation](https://www.kernel.org/doc/html/v4.10/process/coding-style.html?ref=matt-rickard.com#commenting))
12.  If you don't understand how your program runs in production, you don't understand the program itself. In my experience, the best engineers know how their program works in every environment.
13.  The above rule applies to the build pipeline as well.
14.  Use other people's code religiously.
15.  Corollary: Most code out there is terrible. Sometimes it's easier to write a better version yourself.
16.  A rough rule of thumb: never take a direct dependency on a small library that you could easily rewrite or a large library that should have been small.
17.  [Know when to break the rules. For rules like "don't repeat yourself," sometimes a little repetition is better than a bit of dependency.](https://matt-rickard.com/dry-considered-harmful/)
18.  Organizing your code into modules, packages, and functions is important. However, knowing where API boundaries will materialize is an art.
19.  Pick the most efficient tool most of the time and pick what you know. Is Arch Linux the most efficient operating system for the modern developer? For me, it is, but for most, probably not. Should you use acme? Only if you're Rob Pike.
20.  Avoid cyclomatic complexity. Novice coders don't even know that they've tangled the dependency graph until too late.
21.  Avoid nesting conditionals deeply. Have common sense about your conditional tests and naming convention.
22.  Name variables correctly. Again, an art.
23.  While rare, sometimes it's a problem with the compiler. Otherwise, it's always DNS.
24.  Use esoteric language features sparingly, but use them when you're supposed to, for that is the point.
25.  Technology does not diffuse equally. For example, there is a lot that frontend developers could learn from low-level engineers (especially now that everything is compiled). Likewise, there are UX and usability features that JavaScript developers could teach cloud engineers.
26.  As a result, different kinds of engineers look at the world differently.
27.  Some programmers are 10x more efficient than others. I know because I've been both a 10x programmer and a -1x programmer.
28.  There's no correlation between being a 10x programmer and a 10x employee (maybe a negative one).
29.  Good APIs are easy to use and hard to misuse.
30.  The configuration cycle goes from hardcoded values to environment variables, to CLI flags, to a configuration file, to a templated configuration file, to a DSL, to a generic bash script, and back to hardcoded values. Know where you are on this [Heptagon of Configuration](https://matt-rickard.com/heptagon-of-configuration/).
31.  All layers of abstraction are malleable. If you run into a fundamental wall, sometimes the answer is to go down an abstraction layer. You aren't confined to the surface.

**Where did I put in my 10,000 hours?** Well, I've been programming for about 15 years. I recently worked as a professional software engineer at Google on Kubernetes and Blackstone, the private equity firm. Before that, I spent most of college in the library writing programs for my projects instead of writing proofs (which I should have been doing as a math major). And before that, I was hacking away at all sorts of things — [running a botnet on RuneScape](https://matt-rickard.com/runescape-machine-learning/), writing a [Latin translation app](https://matt-rickard.com/coding-classical-latin/) for the iPhone (so I could do better on my Latin exams), [writing my own configuration language](https://matt-rickard.com/virgo-lang/), creating a web clipper, or [ricing up my desktop](https://eirenicon.org/2020/01/29/ricing-desktops/?ref=matt-rickard.com).

**What did I do for the 10,000 hours?** My most recent work was in distributed systems, but I've written code across the stack. Languages like PHP, JavaScript, Go, Ruby, Python, C#, Java, Swift. Frontend, backend, mobile, kernel, cloud, ops, and even some IT. I've worked on large-scale open-source projects like Kubernetes and maintained subprojects, which allowed me to have my code peer-reviewed by some of the best engineers.
