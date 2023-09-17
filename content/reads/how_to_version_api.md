---
title: "How to Version an API"
description: "Imagine you have a RESTful API that has been serving thousands of users. You've been maintaining the code, and now it's time to add a critical new feature – versioning. Often overlooked, API versioning is probably the most important part of the API infrastructure."
summary: "The following is an analysis of API versioning - the process of labeling an API that will be upgraded, which the deprecating API must still properly work to existing consumers."
keywords: ['matt rickard', 'architecture', 'api', 'versioning']
date: 2023-01-23T20:01:22+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'architecture', 'api', 'versioning']
---

The following is an analysis of API versioning - the process of labeling an API that will be upgraded, which the deprecating API must still properly work to existing consumers. The author provides some questions developers should ask themselves to support API upgrading, as well as some tips on how to achieve API versioning.

https://matt-rickard.ghost.io/how-to-version-an-api/

---

Imagine you have a RESTful API that has been serving thousands of users. You've been maintaining the code, and now it's time to add a critical new feature – versioning. Often overlooked, API versioning is probably the most important part of the API infrastructure.

It's something that you should probably think about even at the earliest stages – not that all API endpoints and behavior need guarantees at that stage (and shouldn't). Still, versioning is easier earlier rather than later.  

A few considerations:

*   Will clients need to upgrade?
*   Will changes be backward compatible? Will v2 endpoints accept v1 requests?
*   Will the entire API be versioned or specific routes?
*   What happens when clients send a v2 request to a v1 endpoint? Vice versa?
*   Semantic versioning? Deprecation policy?

A few versioning strategies.

*   _Versioning in the URL structure – e.g., https://api.matt-rickard.com/v2/posts_
*   _Versioning with a URL query parameter – e.g., https://api.mattch-rickard/posts?v=2.1_
*   _Versioning with content negotiation – e.g., a_ `Content Type: application/vnd.rickard.2.param+json` _header._
*   _Versioning with other request headers – e.g.,_ `x-rickard-version:2023-01-01`