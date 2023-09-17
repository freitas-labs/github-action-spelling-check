---
title: "The Frontend Ouroboros"
description: 'Very roughly, there’s “frontend” engineering (building the parts of a website or application that users interact with directly) and “backend” engineering (building the parts that store...«'
summary: "The author provides his view on the separation of frontend with backend, explaining that in theory, the two are segregated of each other and can be developed separately, but in practice, the frontend is dependant of almost every backend design decision."
keywords: ['matt rickard', 'fullstack', 'frontend', 'backend', 'architecture', 'engineering']
date: 2022-12-08T09:19:38+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'fullstack', 'frontend', 'backend', 'architecture', 'engineering']
---

The following is a retrospective on the segregation of frontend and backend development, which is commonly understood as seperate development stacks. However, the autor explains that in practice, the frontend is dependant of almost every backend decision.

https://matt-rickard.ghost.io/the-frontend-ouroboros/

---

Very roughly, there’s “frontend” engineering (building the parts of a website or application that users interact with directly) and “backend” engineering (building the parts that store data and power the frontend). In practice, there’s a large gray area in between.

Any handoff creates friction. Frontend engineers might be waiting for an API route to be developed, a database schema to be migrated, or even just for their code to be deployed. Developer tools that empower engineers to do more by themselves are always in high demand.

What if the frontend is eating the backend?

The ouroboros (Greek: οὐροβόρος) is an ancient symbol of a serpent or dragon eating its own tail. It symbolizes the perpetual cycle of creation and destruction and is often used to represent the idea of something endlessly re-creating itself.

The frontend ouroboros might exist for a few reasons:

- It’s easier to commoditize the lower layers. It's why we no longer have as many database administrators (now DevOps), DevOps engineers (now platform engineers), and platform engineers (now developer-friendly cloud PaaS).
- There are a magnitude more frontend developers than backend developers. While one isn’t necessarily “easier” than the other, if a company requires any sort of user-facing software (even internal), it requires frontend engineers.
- Frontend frameworks have shorter [software half-lives](https://matt-rickard.com/software-half-life). Requirements up the stack change more often and are less generalizable.
- Frontend architecture often dictates backend architecture. A framework that deploys to the edge (e.g., NextJS) requires certain considerations for the API layer (database proxies/connection pooling, NAT gateways/network overlay design, etc.)