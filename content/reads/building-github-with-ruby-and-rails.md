---
title: "Building GitHub with Ruby and Rails"
description: 'Since the beginning, GitHub.com has been a Ruby on Rails monolith. Today, the application is nearly two million lines of code and more than 1,000 engineers collaborate on it daily. We deploy as often as 20 times a day, and nearly every week one of those deploys is a Rails upgrade.'
summary: "The following is a blog post from GitHub, where they give some internal insights in their continuous integration life cycle. GitHub weekly updates their Ruby on Rails version, which might sound absurd on a first glance. However, due to intense testing and shared collaboration with Rails team, GitHub is successful on these deployments."
keywords: ['github', 'automation', 'ruby', 'rails']
date: 2023-04-07T10:46:07.446Z
draft: false
categories: ['reads']
tags: ['reads', 'github', 'automation', 'ruby', 'rails']
---

The following is a blog post from GitHub, where they give some internal insights in their continuous integration life cycle. GitHub weekly updates their Ruby on Rails version, which might sound absurd on a first glance. However, due to intense testing and shared collaboration with Rails team, GitHub is successful on these deployments.

https://github.blog/2023-04-06-building-github-with-ruby-and-rails/

---

Since the beginning, GitHub.com has been a Ruby on Rails monolith. Today, the application is nearly two million lines of code and more than 1,000 engineers collaborate on it daily. We deploy as often as 20 times a day, and nearly every week one of those deploys is a Rails upgrade.

Upgrading Rails weekly[](#upgrading-rails-weekly)
-------------------------------------------------

Every Monday a [scheduled GitHub Action workflow](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule) triggers an automated pull request, which bumps our Rails version to the latest commit on the Rails main branch for that day. All our builds run on this new version of Rails. Once all the builds pass, we review the changes and ship it the next day. Starting an upgrade on Monday you will already have an open pull request linking the changes this Rails upgrade proposes and a completed build.

This process is a far stretch from how we did Rails upgrades only a few years ago. In the past, we spent months migrating from our custom fork of Rails to a newer stable release, and then we maintained two Gemfiles to ensure we’d remain compatible with the upcoming release. Now, upgrades take under a week. You can read more about this process in this [2018 blog post](https://github.blog/2018-09-28-upgrading-github-from-rails-3-2-to-5-2/). We work closely with the community to ensure that each Rails release is running in production before the release is officially cut.

There are real tangible benefits to running the latest version of Rails:

*   **We give developers at GitHub the very best version of our tools** by providing the latest version of Rails. This ensures users can take advantage of all the latest improvements including better database connection handling, faster view rendering, and all the amazing work happening in Rails every day.
*   **We have removed nearly all of our Rails patches**. Since we are running on the latest version of Rails, instead of patching Rails and waiting for a change, developers can suggest the patch to Rails itself.
*   **Working on Rails is now easier than ever** to share with your team! Instead of telling your team you found something in Rails that will be fixed in the next release, you can work on something in Rails and see it the following week!
*   **Maintaining more up-to-date dependencies gives us a better security posture**. Since we already do weekly upgrades, adding an upgrade when there is a security advisory is standard practice and doesn’t require any extra work.
*   **There are no “big bang” migrations**. Since each Rails upgrade incorporates only a small number of changes, it’s easier to understand and dig into if there are incompatibilities. The _worst issues from a tough upgrade are unexpected changes from an unknown location._ These issues can be mitigated by this upgrade strategy.
*   **Catching bugs in the main branch and contributing back** strengthens our engineering team and helps our developers deepen their expertise and understanding of our application and its dependencies.

Testing Ruby continuously[](#testing-ruby-continuously)
-------------------------------------------------------

Naturally, we have a similar process for Ruby upgrades. In February 2022, shortly after upgrading to Ruby 3.1, we started building and testing Ruby shas from 3.2-alpha in a parallel build. When CI runs for the GitHub Rails application, two versions of the builds run: one build uses the Ruby version we are running in production and one uses the latest Ruby commit including the latest changes in Ruby, which we update weekly.

While we build Ruby with every change, GitHub only ships numbered Ruby versions to production. The builds help us maintain compatibility with the upcoming Ruby version and give us insight into what Ruby changes are coming.

In early December 2022, with CI giving us confidence we were compatible before the usual Christmas release of Ruby 3.2, we were able to test Ruby release candidates with a portion of production traffic and give the Ruby team insights into any changes we noticed. For example, we could reproduce an increase in [allocations due to keyword argument handling](https://bugs.ruby-lang.org/issues/19165) that was fixed before the release of Ruby 3.2 due to this process. We also identified a subtle change when [`to_str` and `#to_i` is applied](https://github.com/ruby/ruby/commit/7563604fb868d87057733f52d780d841fc1ab6bb). Because we upgrade all the time, identifying and resolving these issues was standard practice.

This weekly upgrade process for Ruby allowed us to upgrade our monolith from Ruby 3.1 to Ruby 3.2 within a month of release. After all, we had already tested and run it in production! At this point, this was the **fastest Ruby upgrade we had ever done**. We broke this record with the release of Ruby 3.2.1, which we adopted **on release day**.

This upgrade process has proved to be invaluable for our collaboration with the Ruby core team. A nice side effect of having these builds is that we are able to easily test and profile our own Ruby changes before we suggest them upstream. This can make it easier for us to identify regressions in our own application and better understand the impact of changes on a production environment.

Should I do it, too?[](#should-i-do-it-too)
-------------------------------------------

Our ability to do frequent Ruby and Rails upgrades is due to some engineering maturity at GitHub. Doing weekly Rails upgrades requires a thorough test suite with many great engineers working to maintain and improve it. We also gain confidence from having great test environments along with progressive rollout deploys. Our test suite is likely to catch problems, and if it doesn’t, we are confident we will catch it during deploy before it reaches customers.

If you have these tools, you should also upgrade Rails weekly and test using the latest Ruby. GitHub is a better Rails app because of it and it has enabled work from my team that I am really proud of.

Ruby champion Eileen Uchitelle explains why investing in Rails is important in her [Rails Conf 2022 Keynote](https://www.youtube.com/watch?v=MbqJzACF-54):

Ultimately, if more companies treated the framework as an extension of the application, it would result in higher resilience and stability. Investment in Rails ensures your foundation will not crumble under the weight of your application. Treating it as an unimportant part of your application is a mistake and many, many leaders make this mistake.

Thanks to contributions from people around the world, using Ruby is better than ever. GitHub, along with hundreds of other companies, benefits from Ruby and Rails continuing to improve. Upgrading regularly and investing in our frameworks is a staple of the work we do on the Ruby Architecture team at GitHub. We are always grateful for the Ruby community and glad that we can give back in a way that improves our application and tools as much as it improves them for everyone else.