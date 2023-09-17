---
title: "Is lock-free synchronization always superior to synchronization using locks?"
description: "In C++, there is one atomic type std::atomic<T>. This atomic type may be lock-free or maybe not depending on the type T and on the current platform. If a lock-free implementation for a type is available in a platform for a type T, then most compilers would..."
summary: "The following is a question-answer on the use of lock-based vs lock-free primitives for data synchronization algorithms. It was asked in context of C++, but the answer is mostly agnostic of the programming language in use."
keywords: ['stack overflow', 'david schwartz', 'c++', 'lock', 'lock-free', 'parallel programming']
date: 2023-03-17T08:42:34+0000
draft: false
categories: ['reads']
tags: ['reads', 'stack overflow', 'david schwartz', 'c++', 'lock', 'lock-free', 'parallel programming']
---

The following is a question-answer on the use of lock-based vs lock-free primitives for data synchronization algorithms. It was asked in context of C++, but the answer is mostly agnostic of the programming language in use.

In short, lock-based primitives are generally prefered to use, but the decision really comes down to the host hardware (CPU, Threads, cache). However, If you feel you will face synchronization problems such as deadlocks, use a lock-free algorithm.

https://stackoverflow.com/questions/75597629/is-lock-free-synchronization-always-superior-to-synchronization-using-locks

---

**Question**

In C++, there is one atomic type `std::atomic<T>`. This atomic type may be lock-free or maybe not depending on the type T and on the current platform. If a lock-free implementation for a type is available in a platform for a type T, then most compilers would provide lock-free `atomic<T>`. In this case, even if I want non-lock-free `atomic<T>` I can't have it.

C++ standards decided to keep only one `std::atomic<T>` instead of one `std::atomic<T>` and one `std::lock_free<T>` (partially implemented for specific types). Does this imply that, 'there is no case where using a non-lock-free atomic type would be a better choice over using a lock-free atomic type when the latter is available' ? (Mainly in terms of performance rather than ease-of-use).

---

**Answer**

> Does this imply that, 'there is no case where using a non-lock-free atomic type would be a better choice over using a lock-free atomic type when the latter is available' ? (Mainly in terms of performance rather than ease-of-use).

No. And that is, in general, not true.

Suppose you have two cores and three threads that are ready-to-run. Assume threads A and B are accessing the same collection and will contend significantly while thread C is accessing totally different data and will minimize contention.

If threads A and B use locks, one of those threads will rapidly wind up being de-scheduled and thread C will run on one core. This will allow whichever thread gets scheduled, A or B, to run with nearly no contention at all.

By contrast, with a lock-free collection, the scheduler never gets a chance to deschedule thread A or B. It is entirely possible that threads A and B will run concurrently through their entire timeslice, ping-ponging the same cache lines between their L2 caches the whole time.

In general, locks are more efficient than lockfree code. That's why locks are used so much more often in threaded code. However, `std::atomic` types are generally not used in contexts like this. It would likely be a mistake to use a `std::atomic` type in a context where you have reason to think a lock would be more efficient.