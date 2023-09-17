---
title: "React Components as the API"
description: "What if React Components were the new API? Meeting developers where they are today, right in their React frontends? What if state management and third-party SaaS workflows could be abstracted away in a single React component (and maybe a hook or two)?"
summary: "The following is the explanation of the idea of using React components as components with responsibility for a certain domain within an application (e.g., authentication, images, forms), promoting segregation of responsibilities, reduced coupling, testing, etc..."
keywords: ['matt rickard', 'react', 'software engineering', 'react components']
date: 2023-04-30T08:46:01.149Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'react', 'software engineering', 'react components']
---

The following is the explanation of the idea of using React components as components with responsibility for a certain domain within an application (e.g., authentication, images, forms), promoting segregation of responsibilities, reduced coupling, testing, etc...

In a nutshell, React **components** live up to their name.

https://blog.matt-rickard.com/p/react-components-as-the-api

---

What if React Components were the new API? Meeting developers where they are today, right in their React frontends? What if state management and third-party SaaS workflows could be abstracted away in a single React component (and maybe a hook or two)?

Why now? Better styling primitives for components that expose a functional skeleton UI that can be integrated with custom themes. Usually, this happens with a mix of CSS-in-JS or other theming patterns. 

**Authentication** — Most authentication applications offer a React SDK — everything from Auth0 to AWS Amplify to upstarts like Clerk. These usually include components for SignIn, SignUp, and user information.

**Real-time backends** — Not quite a component, but DriftDB exposes a useSharedState hook that acts like useState but is synchronized with other clients. Others are more specific, like Liveblocks, which exposes a createRoomContext hook that shows presence (“who else is viewing this document”)

**Search —** Algolia’s DocSearch can be added as a simple React component. 

**Chat and activity feeds —** Stream has a React Component that embeds a chat or activity feed into your application. 

**Image CDN —** Vercel’s next/image encapsulates a CDN and optimized caching workflow behind a React component. It does lazy loading, blur, resizing, and more.

**Forms —** There are many form startups that ship a React component for automatically uploading responses.