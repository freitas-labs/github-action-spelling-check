---
title: "If you are thinking on splitting a story in back-end and front-end please don’t!"
description: "Throughout my years as Product Owner I came across teams splitting stories having in mind a technical or implementation perspective. I let myself be caught on that trap a couple times."
summary: "The following is an explanation on why people shouldn't split user stories based on a technical perspective (e.g., frontend and backend), as that may lead to slower push of teams in getting things done, which ultimately reduces time-to-market/feedback."
keywords: ['ricardo maia', 'user story', 'scrum', 'product owner']
date: 2023-03-13T08:20:20+0000
draft: false
categories: ['reads']
tags: ['reads', 'ricardo maia', 'user story', 'scrum', 'product owner']
---

The following is an explanation on why people shouldn't split user stories based on a technical perspective (e.g., frontend and backend), as that may lead to slower push of teams in getting things done, which ultimately reduces time-to-market/feedback. The author also presents some ways on how you can efficiently split stories from a business perspective.

https://www.linkedin.com/pulse/you-thinking-splitting-story-back-end-front-end-please-ricardo-maia

---

Throughout my years as Product Owner I came across teams splitting stories having in mind a technical or implementation perspective. I let myself be caught on that trap a couple times. But every time I did it I quickly remembered why I strongly disagree with this approach.

Here are some of the reasons:

1.  It will take you at least 2 to 3 times more to be able to test the feature and get feedback from users. Let’s say that you have a story and you split it in back-end plus front-end. One sprint you do the back-end and the following you do the front-end and hopefully the integration with the back-end. But as the back-end was done first, if there is some unexpected details on the front-end or integration issues that require changes from the back-end you will probably end up as having another sprint to update the back-end - as the back-end was probably done by someone else and this is “unplanned” work. You end up with 3 sprint to have one story done.
2.  You can also start by the front-end hopping to get some feedback from the users once you complete the first user story. You put some effort on mocking data but once you try to demonstrate the feature to the users the discussion centres around the unrealistic data, the users can’t relate with what you demonstrate, and you might even get feedback on the wrong direction. Wouldn’t a quick prototype allow to get the same feedback?
3.  If for some reason, it turns out that there is an issue with that story (e.g. the feature is not used as expected, the users don’t care about it, there is an usability problem or even that architecture is not proper) you end-up spending 2, 3 or more sprints to find out that and react. Is this what agile means?

Splitting stories from business perspective is far more valuable. It will allow you to deploy a complete, though small feature at the end of the sprint and get immediate feedback from users. It might also lead you to that side effect of understanding that the small part that you’ve implemented actually covers most of the scenarios that users need (even more that the ones initially foreseen). Or on the opposite it confirms that you need all the functionality planned. For sure it will allow you to learn, validate your assumptions and help to build a solid path.

 But how to split stories business wise?

 Here are some of the patterns we discuss at our Critical TechWorks Product Vision workshop, that can be used to split user stories:

*   Splitting workflows
*   Breakdown complexity
*   Splitting on operational boundaries
*   Splitting across data boundaries
*   Splitting by different interfaces
*   Relaxing or splitting by business rules or splitting by usage scenarios
*   Defer performance requirements
*   Defer cross-cutting requirements
*   Hard code data
*   Spike