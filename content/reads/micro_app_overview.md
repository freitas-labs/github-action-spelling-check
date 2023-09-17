---
title: "Micro-apps overview"
description: 'A Micro-app is a super-specialized application designed to perform one task or use case with the only objective of doing it well. They follow the single responsibility principle, which states that "a class should have one and only one reason to change." Micro applications help developers create less complex applications while reducing costs by breaking down monolithic systems into groups of independent services acting as one system.'
summary: "The following is an overview of micro apps. In short this class of apps intend to serve one functionality, so their context is bounded to a very small domain. Micro-apps are sometimes portrayed as a flavour of micro-frontends, but don't mix them: micro-apps are applications, micro-frontends is a way to build apps."
keywords: ['wikipedia', 'micro-apps', 'micro-frontends']
date: 2023-03-08T10:35:26+0000
draft: false
categories: ['reads']
tags: ['reads', 'wikipedia', 'micro-apps', 'micro-frontends']
---

The following is an overview of micro apps. In short this class of apps intend to serve one functionality, so their context is bounded to a very small domain. Micro-apps are sometimes portrayed as a flavour of micro-frontends, but don't mix them: micro-apps are applications, micro-frontends is a way to build apps.

https://en.wikipedia.org/wiki/Microapp

---

A Micro-app is a super-specialized application designed to perform one task or use case with the only objective of doing it well. They follow the single responsibility principle, which states that "a class should have one and only one reason to change." Micro applications help developers create less complex applications while reducing costs by breaking down monolithic systems into groups of independent services acting as one system [\[1\]](#cite_note-1).

Requirements and characteristics
----------------------------------------------------------------------------------------------------------------------------------------------

Micro apps usually are accessible on any device, display, or [operating system](https://wikipedia.org/wiki/Operating_system "Operating system")

without installation on the viewer's device. To qualify as a micro app, the entity must:

*   be built and deployed as an independent software module
*   bring together various media types into a single experience
*   have advanced security and compliance features
*   be functionally-extensible
*   comply with granular data demands
*   be agnostic
*   single use case oriented

Micro apps differentiate from traditional web or [mobile applications](https://wikipedia.org/wiki/Mobile_applications "Mobile applications") by how the end-user interacts with them. Consequently, they can be embedded in websites or viewed online to bypass [app stores](https://wikipedia.org/wiki/App_stores "App stores") and are typically built to provide a focused experience to the user [\[2\]](#cite_note-2).

Usage
----------------------------------------------------------------------------------------

Micro apps are typically used for commercial purposes [\[3\]](#cite_note-3) to reduce development costs for projects not requiring the large scope of a traditional web or mobile application. In addition, they are often used to showcase in-depth information or enrich marketing material with [interactivity](https://wikipedia.org/wiki/Interactivity "Interactivity") [\[4\]](#cite_note-4). Lately, micro apps are being used to boost productivity by providing quick tools to people to reuse best practices.

Users have been interacting with micro apps for a while with suites like Office365 and Google Workspace, where each one of their end-user services could be considered as a micro-app. All these micro apps share a unique identity manager to provide a unified user experience.

Benefits
----------------------------------------------------------------------------------------------

Replacing monolith systems with micro apps provide several advantages like:

*   Reduce complexity for developers and users.
*   Smaller, more cohesive, and maintainable codebases
*   Scalable organizations with decoupled, autonomous teams
*   Allows for hyper-specialization
*   Independent deployment
*   Multi-stack

Cloud-native micro apps
----------------------------------------------------------------------------------------------------------------------------

Technologies like Kubernetes, or OpenShift, allow companies to replace their monolith and legacy systems with modular software taking advantage of micro apps on reducing costs and improve reliability and security.

Micro apps vs. Microservices
--------------------------------------------------------------------------------------------------------------------------------------

There is a widespread misunderstanding between these two concepts, which is the key difference. _Microservices_ is an architectural style that is systems-centric, meaning it decouples the presentation and data layer using web services APIs. On the other side, micro apps behave more as a super-architecture style (that embraces microservices among other types), and it is user-centric, meaning they decouple the whole monolith system onto modules that are designed to interact with final users.

Both architectural styles rely on modularity to provide high performance, scalability, and resilience.

Considerations
----------------------------------------------------------------------------------------------------------

Developing Micro apps requires a different approach than traditional software, and user experience is crucial. The following considerations are essential for switching to micro-apps [\[5\]](#cite_note-5).

*   To run multiple micro-apps is required a single identity management system.
*   Microservices are well suited to make micro-apps more powerful
*   Apps with different levels of maturity might create a non-unified user experience.
*   Duplication of dependencies can create security issues and inefficiencies.
*   Suitable for well-organized teams

References
--------------------------------------------------------------------------------------------------

1. ["What is a Microapp?"](https://www.progress.com/blogs/what-is-a-microapp). _Progress Blogs_. 2019-05-22. Retrieved 2022-03-31.
>
2. ["Micro Apps: What They Are and Why You Should Not Ignore Them – DZone Mobile"](https://dzone.com/articles/micro-apps-what-they-are-and-why-you-should-not-ig). _dzone.com_. Retrieved 2018-10-23.
>
3. Swaddle, Paul (26 January 2017). ["MicroApps: One Of The Trends To Watch Out For"](https://www.digitaldoughnut.com/articles/2017/january/how-microapps-are-one-of-the-trends-to-watch). _Digital Doughnut_.
>
4.  ["- Whispir"](https://www.whispir.com/news/executing-an-effective-micro-app-strategy). _Executing An Effective Micro App Strategy | Whispir_. Retrieved 2018-10-23.
>
5.  Anaya, Jay (Jairo) (14 September 2021). ["Cloud Native Microapps - small apps that build super systems"](https://micro-applications.org/). _Micro Applications Org_.