---
title: "Open Source is not a business model"
description: "Which is not to say you can’t make money out of it  A common theme nowadays in the open source developers’ circles is that you can’t live..."
summary: "The following is an explanation on how to create a business model around your open-source work."
keywords: ['senko rašić', 'open source', 'business']
date: 2023-01-14T11:45:05+0000
draft: false
categories: ['reads']
tags: ['reads', 'senko rašić', 'open source', 'business']
---

*(this read is from 2016, so a lot of things have changed since then, but the core info is here!)*

The following is an explanation on how to create a business model around your open-source work. The author describes his experiencie with open-source companies and gives the reader tips on how to also take a profit from their work.

note: ALWAYS take in consideration that **open-source** is not about making money, it's about releasing information to the public, not keeping it under a private/protected wall. It's about being open to people, not using them as your profit.

https://blog.senko.net/open-source-is-not-a-business-model

---

_Which is not to say you can’t make money out of it_

A common theme nowadays in the open source developers’ circles is that you can’t live writing open source. There are sad accounts of people abandoning their (popular) open source libraries, frameworks or programs, because they suck too much of author’s time and with little or no financial gain. Others try their luck at Kickstarter or Indiegogo campaigns for funding a few milestones of their project, or set up a donation system via Gratipay, Flattr or Patreon.

This conflates several different approaches to making money off of open source, each of which requires a different way of thinking about how the money is related to the work.

One way to get paid writing open source is to work (or consult) for a company heavily involved in open source. One such example is [Collabora](http://collabora.com/), one of the world’s largest open source consultancies\[0\]. To a lesser extent, if you’re using a lot of open source software in your day job, you can try to convince your boss to allocate some hours towards contributing back\[1\]. A great thing about this approach is that you don’t need to worry about making money this way — your employer does that.

All of the other approaches require you, the developer, to actively work on getting paid. Open source, by itself, is not a business model. You can build one around it, but _you must work on it_.

One approach is [Open Core](https://en.wikipedia.org/wiki/Open_core): have the base project be open source, but then create additional proprietary products around it (or versions of the projects) and sell them. There’s a number of examples for this approach, for example, [Nginx](https://www.nginx.com/products/).

A similar approach is different licensing schemes for commercial and open source usage (for example, GPL + proprietary license for customers that can’t or won’t use GPL-licensed software). While this can work, it depends on having enough customers needing the proprietary license. Projects using this scheme (for example, [QT](http://www.qt.io/licensing/)) have trouble attracting contributors since they have to sign away their copyright.

Another approach is open source consulting. The project is entirely open source, and the revenue is brought in by charging for customisation, integration and support. If you’re an author of a popular piece of software and constantly get feature requests (or bug reports) from people demanding they need it — ask them to pay for it and voila, you’re an open source consultant. A nice thing about this approach is that you even don’t need to be the primary author of the open source product, you just need to be an expert on it.

Is there a way to just write open source and get paid? Yes — grants and fundraising. Grants, such as [Mozilla’s](https://wiki.mozilla.org/MOSS) or [Google’s](https://developers.google.com/open-source/gsoc/), or Kickstarter/Indiegogo campaigns ([Schema migrations for Django](https://www.kickstarter.com/projects/andrewgodwin/schema-migrations-for-django) or [Improved PostgreSQL support for Django](https://www.kickstarter.com/projects/mjtamlyn/improved-postgresql-support-in-django), to name two I’ve backed) allow recipients to focus on the open source project without needing to build a company around it.But they also require work: applying for the grant, preparing and promoting the campaign (it also helps if you’re already recognised in your community, so that there’s trust that you can deliver on the promise). Failure to do this less appealing work will result in failure to attract grants or donations, and you’re back to square one.

An approach that does not work is chugging along your open source development and just pasting a Gratipay, Flattr or Patreon button\[2\] on your page. You may fund your coffee-drinking habits that way, but you’re not likely to be able to live off of it. A day may come\[3\] when this becomes a viable model, but currently it is not.

Hoping that “if you build it, they will pay” is as disastrous as “if you build it, they will come”. You can make money off of open source, but you need to think it through, devise a business model that suits you (and that you like) best, and than execute on it.

* * *

\[0\] I used to contract with Collabora, they’re an awesome bunch and have a number of [job openings](https://www.collabora.com/about-us/careers.html), many of them remote.
>
\[1\] This is what we do at [Good Code](http://goodcode.io/), a company I run, where we’ve got several Django contributors and encourage community involvement.
>
\[2\] I’m not disparaging any of these. I do believe they’re great attempts (and Patreon works really well for some types of projects, for example [The Great War](https://www.patreon.com/thegreatwar?ty=h)).
>
\[3\] If it ever becomes a reality, [Basic Income](https://en.wikipedia.org/wiki/Basic_income) would be a great thing for open source. I’m not holding my breath, though. A refined Gratipay/Flattr/Patreon/Kickstarter/Charitystorm model that works is more likely.