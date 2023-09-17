---
title: "GitHub private repos considered private-­ish"
description: "GitHub private repos lull us into lazy thinking.

We cram our secrets into git, then shove it off to the most expansive code forge in the history of humanity, and most of the time: everything’s fine."
summary: "The following is an explanation how human behaviour leads to leak of private GitHub repos information, or in the worst case scenario, total leak of the source code. To fight this issue, the author provides some tips when working with private repos."
keywords: ['tyler cipriani', 'infosec', 'git', 'github', 'tips']
date: 2023-06-04T20:53:11.088Z
draft: false
categories: ['reads']
tags: ['reads', 'tyler cipriani', 'infosec', 'git', 'github', 'tips']
---

The following is an explanation how human behaviour leads to leak of private GitHub repos information, or in the worst case scenario, total leak of the source code. To fight this issue, the author provides some tips when working with private repos.

https://tylercipriani.com/blog/2023/03/31/private-ish-github-repos/

---

GitHub private repos lull us into lazy thinking.

We cram our secrets into git, then shove it off to the most expansive code forge in the history of humanity, and **most of the time: everything’s fine.**

But [GitHub’s ssh host key leak](https://github.blog/2023-03-23-we-updated-our-rsa-ssh-host-key/) last week demonstrates that **private repos are, at best, private-ish**.

Secrets get out. [🦖 Life finds a way](https://www.youtube.com/watch?v=kiVVzxoPTtg).

How repos become public 💀
--------------------------

There are oodles of trivial ways you can spill your git secrets to the world.

*   📢 **Publish your `.git` directory** – Exposing the entire history of your code through server misconfiguration or deployment mistakes is [alarmingly. common.](https://www.google.com/search?q=%22.git%22+intitle%3A%22index+of%22)
*   🎣 **Get phished** – Even cool kids can have their passwords stolen. Examples in the wild:
    *   [Slack](https://slack.com/intl/en-gb/blog/news/slack-security-update)
    *   [Dropbox](https://dropbox.tech/security/a-recent-phishing-campaign-targeting-dropbox).
*   🥄 **Bad fork** – Especially true with the GitHub/GitLab model—a developer forks a private repo and makes it public. Examples in the wild:
    *   [Uber’s “$57M” data breach](https://www.wired.com/story/uber-paid-off-hackers-to-hide-a-57-million-user-data-breach/)
    *   [Equifax incident](https://hackerone.com/reports/694931)
    *   [Starbucks](https://hackerone.com/reports/716292)
*   🖱️ **Click the wrong button** – You’re a handful of button clicks away from making a private repo public—miscommunication or confusing UI can leave you exposed.

Move fast, leak things 🚰
-------------------------

Most of the people at GitHub and GitLab are humans. And humans make mistakes (especially when they’re on a deadline).

Back in 2016, GitHub had an incident where private repos [exposed to unauthorized users](https://github.blog/2016-10-28-incident-report-inadvertent-private-repository-disclosure/).

And GitLab has had at least three incidents matching the search “GitLab+Private repos” in the Common Vulnerabilities and Exposures (CVE) database ([1](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22167), [2](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13277), [3](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13303)).

Mitigations 🛠️
---------------

In the spirit of [blame-aware postmortems](https://medium.com/@jpaulreed/why-blameless-postmortems-might-feel-wrong-cbeee00d51b2)—what can we do to fix this?

**Easy fixes**

*   Keep your `.git` directory to yourself. Avoid deploying it. Configure your webserver to deny access to it if you do.
*   Setup [two-factor authentication](https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/accessing-github-using-two-factor-authentication), like, Right. Now. Bonus points if your second factor is a hardware key.
*   Audit your access control on your forge of choice.

**Impossible fixes**

It’s impossible to prevent a zero-day that exposes your private repo.

So, if you’re worried about it: **stop putting sensitive data into private repositories**.

Especially the kind that would damage your reputation if it got out:

*   Passwords/production credentials
*   Personally identifying information (PII) of users
*   Any code, data, or metadata you expect to be permanently private

You can set a policy and ensure developers use secret scanners as pre-commit git hooks. Inject secrets into your application at runtime.

Beyond runtime secrets? Keep that junk out of git.