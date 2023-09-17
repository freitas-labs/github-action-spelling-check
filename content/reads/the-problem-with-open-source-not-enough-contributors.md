---
title: "The problem with open source: not enough contributors"
description: "The annual report of GitHub seems to indicate that there are many millions of open source contributors. So why do I have the feeling that there are not enough of them?"
summary: "The following is a review on GitHub 2022 state of Open Source. The author disagrees with the statement that Open Source is popular right now, and believes GitHub is just throwing numbers to create a false sense of reality, instead of talking about real metrics that evaluate how popular GitHub and Open Source really is."
keywords: ['gabor szabo', 'open source', 'osdc', 'github']
date: 2023-03-29T12:28:50+0100
draft: false
categories: ['reads']
tags: ['reads', 'open source', 'osdc', 'github']
---

The following is a review on GitHub 2022 state of Open Source. The author disagrees with the statement that Open Source is popular right now, and believes GitHub is just throwing numbers to create a false sense of reality, instead of talking about real metrics that evaluate how popular GitHub and Open Source really is.

https://dev.to/szabgab/the-problem-with-open-source-not-enough-contributors-5gpm

---

It is clear to me that there are many problems with open source, the most important one, in my opinion, is the fact that not enough people contribute to it.

At least that's what I thought. Then I ran some searches and ended up on the [2022 The state of open source](https://octoverse.github.com/2022/developer-community) report of GitHub that seems to say something else.

[](#side-rant-about-urls)Side rant about URLs
---------------------------------------------

There is a clear URL for the main page of the [2021 report](https://octoverse.github.com/2021/) Same with the [2020 report](https://octoverse.github.com/2020/) and probably all the earlier reports. However the main page of the 2022 report is the [front page](https://octoverse.github.com/) of the whole site and if you try to visit the URL that should be the home of the [2022 report](https://octoverse.github.com/2022/) it gives yous 404 not found. I guess when they publish the 2023 report they will move the current front page to this sub-folder and then the link I just included will start to work. It is really strange. This means that every article that tries to refer to the 2022 report before the 2023 report comes out will have to link to the main page of the site and when the 2023 report comes out the link will be incorrect. As it will point to the newer report.

On the other hand if you land on an older report you don't have a link to switch to the newest report. Nor is there a clear indication (well, besides the date), that there is a newer report.

[](#numbers)Numbers
-------------------

Just a few numbers from the report to make it easy to quote.

*   94M developers are on GitHub with 27% year-over-year growth
*   413M open source contributions in 2022
*   85.7M+ new repositories with 20% year-over-year growth
*   3.5B+ total contributions to all projects on GitHub (Contributions include commits, issues, pull requests, discussions, gists, pushes, and pull requests reviews.)
*   227M+ pull requests merged
*   31M+ issues closed
*   263M automated jobs run on GitHub Actions every month (With more than 41 million build minutes a day)

[](#number-of-open-source-contributors)Number of open source contributors
-------------------------------------------------------------------------

Back to the numbers, GitHub reports that there are 94M developers on GitHub in 2022. That seems to totally contradict my feeling that not enough people contribute to open source.

I work as a contractor/consultant/trainer so I see a number of companies every year. Not a lot, usually 3-10 per year. There might be a strong selection bias, but nearly none of their employees contribute to open source projects. Well, thinking about it again, they might use GitHub for some private project. They might even push out some code to a public repository of their own, but most of that code is not used by anyone besides them. Some of them might open issues on projects, but even that seems to be limited.

So I wonder. Is this just the limited and probably biased sample I have? How come that I feel that there is not enough contribution to open source while GitHub seems to indicate that there are 94M people on their platform.

[](#multiple-and-dormant-accounts)Multiple and dormant accounts
---------------------------------------------------------------

I have at least 3 accounts on GitHub. One of them is my primary account and two others I use when I demo something. E.g. How a user without any extra rights can interact with one of my repositories. I bet I am not the only one with multiple accounts.

I am also quite sure that there are many people who signed up to GitHub but don't use it too frequently if at all. So that 94M is probably much bigger than the number of active users. And what does "active" mean, anyway?

[](#very-few-contributions-per-person)Very few contributions per person
-----------------------------------------------------------------------

There are 94M developers on GitHub and there were 413M open source contributions in 2022. So an average of **4.3 per year**. I can only assume that by "open source contribution" they mean contribution to one of the public repositories. I looked at my own [GitHub Profile](https://github.com/szabgab) and according to that I contribute somewhere between **10-120 per day**. Though when I was on vacation there were a few days without any contribution. It is also true that in my case some of those commits are generated by scripts so they don't reflect real work on my part, but they still count in that 413M open source contributions.

On another page they say there were 3.5B total contributions to all projects on GitHub. Here "contributions" include commits, issues, pull requests, discussions, gists, pushes, and pull requests reviews. It probably also includes all the private repositories as well. this brings us to roughly **37 contributions per year per person**. Still not a very big number for open source if we take in account that some of these go to private repositories.

[](#only-20-are-public-repositories)Only 20% are public repositories
--------------------------------------------------------------------

One number I found in the report is that only 20% of the GitHub repositories are public.

[](#some-very-popular-project-many-unknown-projects)Some very popular project, many unknown projects
----------------------------------------------------------------------------------------------------

In their report they show the 10 projects with the biggest number of contributors. The first one is [microsoft/vscode](https://github.com/microsoft/vscode) with 19.8K contributors in 2022 and the 10th place is [tensorflow/tensorflow](https://github.com/tensorflow/tensorflow) with 4.4K contributors. That's really nice, but my guess is that most repositories have very few contributors.

The report says "85.7M+ new repositories". In previous year there were 61, 60, 44 new repositories and in 2018 the reported that there are 96M repositories) So based on this there are a total of 346M repositories. So given there were 3.5B contributions, the average number of contributions to a repository is around 10 per year.

I think this is called a Pareto distribution. Very limited number of projects have a lot of contributions and a lot of contributors, but very quickly it gets to under 10 per year and then also under 1 per year. Meaning the project has not seen any activity for a year.

[](#conclusion)Conclusion
-------------------------

I am far from being done with this topic, but I think this is enough for now. While this report indicates that there are a lot of people registered to GitHub, I think it also shows that only a small subset of those people have contributed to open source projects and even those contributions are concentrated among a few (probably a few thousand) popular projects.

So maybe I am not that off reality with my [Open Source Developer Course](https://osdc.code-maven.com/) in which I try to teach people how to contribute to open source projects.

I will need to look for further reports and run some queries using the GitHub API to collect some data.