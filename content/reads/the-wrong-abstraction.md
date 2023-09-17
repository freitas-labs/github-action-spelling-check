---
title: "The Wrong Abstraction"
description: "I've been thinking about the consequences of the \"wrong abstraction.\"  My RailsConf 2014 \"all the little things\" talk included a section where I asserted..."
summary: "The following is an explanation on why abstracting code when facing code duplication may turn into bad idea, since the domain area where duplication lives may not be *abstractable*."
keywords: ['sandi metz', 'abstraction', 'software engineering', 'code duplication']
date: 2023-05-04T06:53:31.395Z
draft: false
categories: ['reads']
tags: ['reads', 'sandi metz', 'abstraction', 'software engineering', 'code duplication']
---

The following is an explanation on why abstracting code when facing code duplication may turn into bad idea, since the domain area where duplication lives may not be *abstractable*.

https://sandimetz.com/blog/2016/1/20/the-wrong-abstraction

---

I've been thinking about the consequences of the "wrong abstraction." My RailsConf 2014 "[all the little things](https://youtu.be/8bZh5LMaSmE)" talk included a section where [I asserted](https://youtu.be/8bZh5LMaSmE?t=893):

> duplication is far cheaper than the wrong abstraction

And in the summary, [I went on to advise](https://youtu.be/8bZh5LMaSmE?t=2142):

> prefer duplication over the wrong abstraction

This small section of a much bigger talk invoked a surprisingly strong reaction. A few folks suggested that I had lost my mind, but many more expressed sentiments along the lines of:

> This, a million times this! "[@BonzoESC](https://twitter.com/BonzoESC): "Duplication is far cheaper than the wrong abstraction" [@sandimetz](https://twitter.com/sandimetz) [@rbonales](https://twitter.com/rbonales) [pic.twitter.com/3qMI0waqWb](http://t.co/3qMI0waqWb)"
> 
> — 41 shades of blue (@pims) [March 7, 2014](https://twitter.com/pims/status/442010383725760512)

The strength of the reaction made me realize just how widespread and intractable the "wrong abstraction" problem is. I started asking questions and came to see the following pattern:

1.  Programmer A sees duplication.
    
2.  Programmer A extracts duplication and gives it a name.
    
    _This creates a new abstraction. It could be a new method, or perhaps even a new class._
    
3.  Programmer A replaces the duplication with the new abstraction.
    
    _Ah, the code is perfect. Programmer A trots happily away._
    
4.  Time passes.
    
5.  A new requirement appears for which the current abstraction is _almost_ perfect.
    
6.  Programmer B gets tasked to implement this requirement.
    
    _Programmer B feels honor-bound to retain the existing abstraction, but since isn't exactly the same for every case, they alter the code to take a parameter, and then add logic to conditionally do the right thing based on the value of that parameter._
    
    _What was once a universal abstraction now behaves differently for different cases._
    
7.  Another new requirement arrives.  
    _Programmer X.  
    Another additional parameter.  
    Another new conditional.  
    Loop until code becomes incomprehensible._
    
8.  You appear in the story about here, and your life takes a dramatic turn for the worse.
    

Existing code exerts a powerful influence. Its very presence argues that it is both correct and necessary. We know that code represents effort expended, and we are very motivated to preserve the value of this effort. And, unfortunately, the sad truth is that the more complicated and incomprehensible the code, i.e. the deeper the investment in creating it, the more we feel pressure to retain it (the "[sunk cost fallacy](https://en.wikipedia.org/wiki/Sunk_costs#Loss_aversion_and_the_sunk_cost_fallacy)"). It's as if our unconscious tell us "Goodness, that's so confusing, it must have taken _ages_ to get right. Surely it's really, really important. It would be a sin to let all that effort go to waste."

When you appear in this story in step 8 above, this pressure may compel you to proceed forward, that is, to implement the new requirement by changing the existing code. Attempting to do so, however, is brutal. The code no longer represents a single, common abstraction, but has instead become a condition-laden procedure which interleaves a number of vaguely associated ideas. It is hard to understand and easy to break.

If you find yourself in this situation, resist being driven by sunk costs. When dealing with the wrong abstraction, _the fastest way forward is back_. Do the following:

1.  Re-introduce duplication by inlining the abstracted code back into every caller.
2.  Within each caller, use the parameters being passed to determine the subset of the inlined code that this specific caller executes.
3.  Delete the bits that aren't needed for this particular caller.

This removes both the abstraction _and_ the conditionals, and reduces each caller to only the code it needs. When you rewind decisions in this way, it's common to find that although each caller ostensibly invoked a shared abstraction, the code they were running was fairly unique. Once you completely remove the old abstraction you can start anew, re-isolating duplication and re-extracting abstractions.

I've seen problems where folks were trying valiantly to move forward with the wrong abstraction, but having very little success. Adding new features was incredibly hard, and each success further complicated the code, which made adding the next feature even harder. When they altered their point of view from "I must preserve our investment in this code" to "This code made sense for a while, but perhaps we've learned all we can from it," and gave themselves permission to re-think their abstractions in light of current requirements, everything got easier. Once they inlined the code, the path forward became obvious, and adding new features become faster and easier.

The moral of this story? Don't get trapped by the sunk cost fallacy. If you find yourself passing parameters and adding conditional paths through shared code, the abstraction is incorrect. It may have been right to begin with, but that day has passed. Once an abstraction is proved wrong the best strategy is to re-introduce duplication and let it show you what's right. Although it occasionally makes sense to accumulate a few conditionals to gain insight into what's going on, you'll suffer less pain if you abandon the wrong abstraction sooner rather than later.

When the abstraction is wrong, the fastest way forward is back. This is not retreat, it's advance in a better direction. Do it. You'll improve your own life, and the lives of all who follow.