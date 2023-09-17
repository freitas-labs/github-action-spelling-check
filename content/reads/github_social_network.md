---
title: "Is GitHub a Social Network?"
description: "GitHub's original tagline was \"social code hosting,\" but are there network effects in programming? Do the social features matter? GitHub is primarily an enterprise B2B SaaS company..."
summary: "The author explains the usage of LLM/AI as an interface for developers and customers consuption. It provides real examples on these interfaces integration."
keywords: ['matt rickard', 'github', 'social network']
date: 2023-01-10T08:14:50+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'github', 'social network']
---

The following is a retrospective on Github's original premise of being a social code platform. The author goes on to prove that GitHub can't really be considered a social platform, because it doesn't offer features that impact your view or that allow you to connect more to other users, although structuring itself as a one-way following graph.

https://matt-rickard.ghost.io/social-coding/

---

GitHub's original tagline was  "[social code hosting](https://web.archive.org/web/20081111061111/http://github.com/)," but are there network effects in programming? Do the social features matter? GitHub is primarily an enterprise B2B SaaS company – how much do the consumer social features matter?

GitHub resembles many social networks –

_The social graph_ – GitHub has a one-way following graph, i.e., you can follow others without permission (compared to a bidirectional model like LinkedIn connections or Facebook friends).

_The feed_ – Like many social networks, there's an algorithmic feed. Unfortunately, it's not very useful. Events like newly created repositories, comments, pull requests, and starring appears in the feed. It's usually cluttered with CI spam,

_Stars (likes) –_ You can "like" repositories, which has zero effect other than increasing the counter.

Fortunately, we have an interesting counterfactual – GitLab, which among other things, is GitHub but de-emphasizes the social features – it's more likely to be deployed on-prem and overall has significantly fewer consumer public users and projects. GitLab's current market cap is $8.5b (Microsoft acquired GitHub in 2019 for $7.5b). Some other interesting observations.

*   [GitHub star growth is primarily linear](https://matt-rickard.com/linear-github-star-growth), even for the fastest-growing repositories. So virality happens, but always off-platform (a viral blog post, etc.)
*   GitHub is removing the trending tab at the end of this month due to low usage.
*   Anecdotally, developers choose libraries in part based on social proof from other developers.
*   Chat, a key component of social, is important for open-source projects. Most of the activity happens off GitHub (in Slack or Discord). GitLab acquired Gitter, a chat platform specifically for code repositories, in 2017. However, projects increasingly choose Discord.
*   GitHub profiles are sometimes used for recruiting and resumes. However, professional networks are rarely reflected on the GitHub follower model compared to LinkedIn (or Twitter).

So, if I were to guess, social features haven't moved the needle for GitHub. SaaS businesses with network effects are rare, but when they work, they grow huge (e.g., Figma, Slack). So there's probably something there – maybe the next generation of companies will figure it out.