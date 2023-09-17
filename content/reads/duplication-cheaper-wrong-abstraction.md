---
title: "Why I don’t buy “duplication is cheaper than the wrong abstraction”"
description: "“Duplication is cheaper than the wrong abstraction” is a saying I often hear repeated in the Rails community. I don’t really feel like the expression makes complete sense. I fear that it may lead developers to make poor decisions. Here’s what I take the expression to mean, why I can’t completely get on board with it, and what I would advise instead."
summary: "The following is a response to \"The Wrong Abstraction\" article. The author takes on the bit saying that, there's no such thing as wrong abstraction, it's just bad code. Following up on this premise, duplicated code is just wrong."
keywords: ['jason swett', 'software engineering', 'refactoring', 'code duplication', 'abstraction']
date: 2023-09-05T07:45:18+0100
draft: false
categories: ['reads']
tags: ['reads', 'jason swett', 'software engineering', 'refactoring', 'code duplication', 'abstraction']
---

The following is a response to ["The Wrong Abstraction"](the-wrong-abstraction.md) article. The author takes on the bit saying that, there's no such thing as wrong abstraction, it's just bad code. Following up on this premise, duplicated code is just wrong.

https://www.codewithjason.com/duplication-cheaper-wrong-abstraction/

---

My understanding of the “duplication is cheaper than the wrong abstraction” idea, based on [Sandi Metz’s post about it](https://sandimetz.com/blog/2016/1/20/the-wrong-abstraction), is as follows. When a programmer refactors a piece of code to be less duplicative, that programmer replaces the duplicative code with a new, non-duplicative abstraction. So far so good, perhaps. But, by creating this new abstraction, the programmer signals to posterity that this new abstraction is “the way things should be” and that this new abstraction ought not to be messed with. As a result, this abstraction gets bastardized over time as maintainers of the code need to change it yet simultaneously feel compelled to preserve it. The abstraction gets littered with conditional logic to behave different ways in different scenarios, and eventually becomes an unreadable mess.

I hope this is a fair and reasonably faithful paraphrasing of Sandi’s idea. Here are the parts of the idea that I agree with, followed by the parts of the idea that I take issue with.

The parts I agree with
----------------------

In my experience it’s absolutely true that existing code has a certain inertia to it. Whether it’s out of caution or laziness or some other motive, it seems that a common approach to existing code is “don’t mess with it too much”. This is often a pretty reasonable approach, especially in codebases with poor [test coverage](https://www.codewithjason.com/test-coverage/) where broad refactorings aren’t very safe. Unfortunately the “don’t mess with it too much” approach (as Sandi correctly points out) often makes bad code even worse.

I also of course agree that it’s bad when an abstraction gets cluttered up with a bunch of conditional logic to behave differently in different scenarios. Once that happens, the abstraction can hardly be called an abstraction anymore. It’s like two people trying to live in one body.

I also agree with Sandi’s approach to cleaning up poorly-deduplicated code. First, back out the “improvements” and return to the duplicated state. Then begin the de-duplication work anew. Good approach.

The parts I take issue with
---------------------------

### What exactly is meant by “the wrong abstraction”?

I think “the wrong abstraction” is a confused way of referring to poorly-de-duplicated code. Here’s why.

It seems to me that what’s meant by “the wrong abstraction” is “a confusing piece of code littered with conditional logic”. I don’t really see how it makes sense to call that an abstraction at all, let alone the wrong abstraction.

Not every piece of code is an abstraction of course. To me, an [abstraction](https://www.codewithjason.com/abstraction-in-rails/) is a piece of code that’s expressed in high-level language so that the distracting details are abstracted away. If I were to see a confusing piece of code littered with conditional logic, I wouldn’t see it and think “oh, there’s an incorrect abstraction”, I would just think, “oh, there’s a piece of crappy code”. It’s neither an abstraction nor wrong, it’s just bad code.

So instead of “duplication is cheaper than the wrong abstraction”, I would say “duplication is cheaper than confusing code littered with conditional logic”. But I actually wouldn’t say that, because I don’t believe duplication is cheaper. I think it’s usually much more expensive.

### When duplication is dearer

I don’t see how it can be said, without qualification, that duplication is cheaper than the wrong abstraction. Some certain things must be considered. How bad is the duplication? How bad is the de-duplicated code? Sometimes the duplication is cheaper but sometimes it’s more expensive. How do you know unless you know how good or bad each alternative is? It depends on the scenario.

If the duplication is very small and obvious, and the alternative is to create a puzzling mess, then that duplication is absolutely cheaper than the bad code. But if the duplication is horrendous (for example, the same several lines of code duplicated across distant parts of the codebase dozens of times, and with inconsistent names which make the duplication hard to notice or track down) and the alterna<read>tive is a piece of code that’s merely imperfect, then I would say that the duplication is more expensive.

In general, I find duplication to typically be more much expensive than the de-duplicated alternative. Duplication can bite you, hard. The worst is when there’s a piece of code that’s duplicated but you don’t know it’s duplicated. In that case you risk changing the code in one place without realizing you’re creating an inconsistency. It’s hard for a poor abstraction to have consequences worse than that.

### Programmers’ reluctance to refactor isn’t a good justification for not DRYing up code

If a programmer “feels honor-bound to retain the existing abstraction” (to quote Sandi’s post), then to me that sounds like a symptom of a problem that’s distinct from duplication or bad abstractions. If developers are afraid to clean up poor code, then I don’t think the answer is to hold off on fixing duplication problems. I think the answer is to address the reasons why developers are reluctant to clean up existing code. Maybe that reason is a lack of automated tests and code review, or a lack of a culture of [collective ownership](https://openpracticelibrary.com/practice/code-review/). Whatever the underlying problem is, fixing that problem surely must be a better response than allowing duplication to live in your codebase.

My alternative take, summarized
-------------------------------

Instead of “duplication is cheaper than the wrong abstraction”, I would say the following.

Duplication is bad. In fact, duplication is one of the most dangerous mistakes in coding. Except in very minor cases, duplication is virtually always worth fixing. But not all possible ways of addressing duplication are equally good. Don’t replace a piece of duplicative code with a confusing piece of code that’s made out of if statements.

When you find yourself adding if statements to a piece of code in order to get it to behave differently under different scenarios, you’re creating a confusion. Don’t try to make one thing act like two things. Instead, separate it into two things.

If you feel reluctant to modify someone else’s code, ask why that is. Is it because you feel like you’ll get in trouble if you do? Is it because you don’t understand the code, and there’s little test coverage, and you’re afraid you’ll break something if you make changes that are too drastic? Whatever the underlying reason for your reluctance is, it’s a problem, because it’s holding your organization back from improving its code. Instead of adding more bad code on top of the existing bad code, see if there’s anything you can do to try to address these underlying issues.

Takeaways
---------

*   As Sandi Metz says (but in my words), confusing code littered with conditionals is not a good way to address duplicative code.
*   A piece of code filled with conditionals isn’t really an abstraction or even “wrong”, it’s just a confusing piece of code.
*   Duplication is one of the most dangerous mistakes in coding, and almost always worth fixing. Unless someone really botches the job when de-duplicating a piece of code, the duplicated version is almost always more expensive to maintain than the de-duplicated version.
*   Try to foster a culture of collective ownership in your organization so that developers aren’t afraid to question or change existing code when the existing code gets out of sync with current needs.
*   Try to use risk-mitigating practices like automated testing, small changes, and continuous deployment so that when refactorings are needed, you’re not afraid to do them.