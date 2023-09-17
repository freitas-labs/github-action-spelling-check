---
title: "How to lose half a billion dollars with bad feature flags"
description: 'Knight Capital was the largest trader in US equities in 2012 (~$21b/day) thanks to their high frequency trading algorithms. Poor use of feature flags caused their demise.'
summary: "The following is a story on how a trader company that was seen as the largest in US equities trading, got insolvent from day to night due to a miss-configuration on their software. They used feature flags to decide which algorithm they should use for trading, and the issue happened when a testing algorithm was selected to be used as the main algorithm."
keywords: ['vineeth madhusudanan', 'miss-configuration', 'software', 'trading', 'knight capital', 'feature flag']
date: 2023-04-13T07:11:52.482Z
draft: false
categories: ['reads']
tags: ['reads', 'vineeth madhusudanan', 'miss-configuration', 'software', 'trading', 'knight capital', 'feature flag']
---

The following is a story on how a trader company that was seen as the largest in US equities trading, got insolvent from day to night due to a miss-configuration on their software. They used feature flags to decide which algorithm they should use for trading, and the issue happened when a testing algorithm was selected to be used as the main algorithm.

https://blog.statsig.com/how-to-lose-half-a-billion-dollars-with-bad-feature-flags-ccebb26adeec

---

[Knight Capital](https://en.wikipedia.org/wiki/Knight_Capital_Group) was the largest trader in US equities in 2012 (~$21b/day) thanks to their high frequency trading algorithms. They also executed trades on behalf of retail brokers like TD Ameritrade and ETrade.

Their demise came in 2012 when they developed a new feature in their Smart Market Access Routing system to handle transactions for a new NYSE program.

Knight Capital’s stock price in 2012. KC had ~1.4k employees.

To control this new feature, they repurposed a feature gate created for a different trading algorithm called “Power Peg”. Power Peg was never meant to be used in the real world to process transactions. It was a test algorithm, specifically designed to move stock prices in test environments to enable verification of other proprietary trading algorithms.

Unfortunately, when they deployed this new code, it succeeded on seven of eight servers. Without realizing this, they flipped the feature on. Code on seven servers worked as expected. The legacy Power Peg feature came online on the eighth server and started executing trades routed to that server.

Deployments do fail, occasionally.

In a few minutes, Knight Capital assumed options positions worth $7 billion net — that resulted in a $440m loss when closed. With only $360m in assets, this made them insolvent; they had to be restructured and rescued by a set of external investors.

This proved to be a very expensive lesson in managing dead code and creating unique, well-named feature gates. Feature gates are cheap to create, never reuse them! Read more about the Knight Capital saga [here](https://www.henricodolfing.com/2019/06/project-failure-case-study-knight-capital.html), or check out unlimited feature flags in our free tier at [Statsig](https://www.statsig.com).