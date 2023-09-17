---
title: "What are examples of software that may be seriously affected by a time jump?"
description: "The chrony documentation warns..."
summary: "The following is a question-answer on examples of programs that highly depend on time values and may be affected if an abnormal time jump is noticed."
keywords: ['stack overflow', 'romeo ninov', 'unix', 'linux', 'real time', 'chrony']
date: 2023-03-19T11:12:51+0000
draft: false
categories: ['reads']
tags: ['reads', 'stack overflow', 'romeo ninov', 'unix', 'linux', 'real time', 'chrony']
---

The following is a question-answer on examples of programs that highly depend on time values and may be affected if an abnormal time jump is noticed.

https://serverfault.com/questions/1123895/what-are-examples-of-software-that-may-be-seriously-affected-by-a-time-jump

---

**Question**

The chrony documentation warns

> BE WARNED: Certain software will be seriously affected by such jumps in the system time. (That is the reason why chronyd uses slewing normally.) [Documentation](https://chrony.tuxfamily.org/doc/3.5/chronyc.html)

But the documentation gives no examples. What are examples of software that will be seriously affected? Is the OS or any background processes at risk?

**Answer**

This is a bit of open question but let me give some examples:

*   databases - most of them rely a lot of precise time for storing records, indexes, etc
*   security - precise time is very important for security to map action to time and gaps or time duplication is not accepted
*   digital signing - usually part of signed document is the timestamp so wrong time may invalidate the signature
*   scheduling software - may skip or repeat twice jobs depend of time jump direction.
*   clustering software - probably any cluster will need to be in sync and any jump of one or more nodes may have unpredictable result.

**Extra**

I recently got bit by a bug that dates back to 1999 and affects both the JVM and Android Runtime: [https://bugs.java.com/bugdatabase/view\_bug.do?bug\_id=4290274](https://bugs.java.com/bugdatabase/view_bug.do?bug_id=4290274)

> ... two extra executions are fired (unexpectedly) when the system clock is set ahead one minute after the task is scheduled using scheduleAtFixedRate().

I work on a device that starts with the 1970 epoch as the current time, then receives the correct network time a little later. Occasionally a 3rd party library would initialize before the time was set, causing it to experience a 50 year time jump.

The result was `scheduleAtFixedRate` attempting to catch up on ~50 years worth of invocations... which was about 27 _million_ back-to-back invocations with no delay between them.

That would cause the GC to go haywire and generally bog down the system until it was restarted