---
title: "Visual Explanation and Comparison of CSR, SSR, SSG and ISR"
description: "Hello there, Next.js is a very popular React framework and one of the beautiful features is the ability to build your web application using different rendering techniques, such as..."
summary: "The following is a comparison on four different techniques used in web applications and websites to show and render content."
keywords: ['pahan pera', 'webdev', 'ssr', 'csr', 'ssg', 'isr']
date: 2023-04-28T07:44:02.491Z
draft: false
categories: ['reads']
tags: ['reads', 'pahan pera', 'webdev', 'ssr', 'csr', 'ssg', 'isr']
---

The following is a comparison on four different techniques used in web applications and websites to show and render content.

https://dev.to/pahanperera/visual-explanation-and-comparison-of-csr-ssr-ssg-and-isr-34ea

---

Hello there,

[Next.js](https://nextjs.org/) is a very popular React framework and one of the beautiful features is the ability to build your web application using different rendering techniques, such as

*   **CSR** - Client Side Rendering
*   **SSR** - Server Side Rendering
*   **SSG** - Static Site Generation
*   **ISR** - Incremental Static Regeneration

In this post, I will focus on explaining and comparing these techniques using visual diagrams with minimal texts, and my goal is to create a _short note_ that you can quickly refer when needed.

Having said that, this post does not cover advance technical details and code snippets, that you might want to learn as a web developer.

Let's get started..!

### [](#client-side-rendering)Client Side Rendering

This is what most of the web frameworks like Angular and React support out of the box. This is commonly suitable for single page applications (SPA) and applications with lot of user interactions (e.g Games) and highly dynamic content such as forms, and chat applications.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/visual-explanation-and-comparison-of-csr-ssr-ssg-and-isr/0z8cpipm5vsjlj11s6rz.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Basically web browser will initially load an empty HTML file. Javascript and styles which are loaded after, are responsible for rendering the full user friendly page in the web browser.

### [](#server-side-rendering)Server Side Rendering

Main disadvantage of CSR is that it is not Search Engine Optimized. Therefore most of the web frameworks, provide the ability to render the pages in server as well.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/visual-explanation-and-comparison-of-csr-ssr-ssg-and-isr/677s8w25jofc5g4xbuck.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Not like CSR, Each page will initiate a request to App Server, where it dynamically renders and serves full HTML for that page. Since it requests and renders the page each time user requests, page serve time is more than a CSR application.

### [](#static-site-generation)Static Site Generation

To avoid the rendering in each request, why don't we generate those files in the build time, so that we can instantly serve the pages when user requests it.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/visual-explanation-and-comparison-of-csr-ssr-ssg-and-isr/qrb8xfv81llmpghlpma9.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

This technique will come in handy if you want to build a web application with full of static content like a blog. One drawback is that the content might be out-of-date and your application is needed to build and deploy each time when you change the content. (in a CMS)

### [](#incremental-static-regeneration)Incremental Static Regeneration

ISR is the next improvement to SSG, where it periodically builds and revalidates the new pages so that content never gets too much out-dated.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/visual-explanation-and-comparison-of-csr-ssr-ssg-and-isr/2e7vk7cafaacak5glzf7.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

[](#comparison)Comparison
-------------------------

To compare these four techniques, we will consider following metrics.

*   **Build time** - Less value the better.
*   **Suitable for Dynamic Content** - If this value is high, that technique is more suitable for applications with lot of dynamic content.
*   **Search Engine Optimization** - Most cases, it is best to have a good value for SEO.
*   **Page Serve/Render Time** - How long it takes to render the full page in the web browser. Less value the better.
*   **Most Recent Content** - Indication that it always delivers the latest content. More value the better.
*   **Static Server / App Server** - Does this technique need to have a static server or an app server. Normally static servers consume lot less resources than the app servers.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/visual-explanation-and-comparison-of-csr-ssr-ssg-and-isr/8onh7r5sxmss9f87k726.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Some of the key thoughts are

*   **Page Serve/Render Time is less in CSR compared to SSR**, since after the initial assets load, CSR manage to load the rest of the pages very quickly. But in SSR, each page request will be served by the app server.
    
*   **Page Serve/Render Time is more in ISR compare to SSG**, since ISR periodically requests the updated page from the server.
    
*   **ISR does not have the most recent content**, since there can be a small window where user gets outdated content, just before the periodic content refresh.
    

Please note that, this comparison might not be accurate based on the different perspectives that you have. Feel free to correct me as well.

[](#conclusion)Conclusion
-------------------------

In Highlevel, we can divide these rendering techniques into two major categories based on the level of dynamic interactions that your app has.

*   CSR and SSR can be used to develop highly dynamic web application and both has its pros and cons depending on the scenario.
*   If you have a highly static content, you can use SSG or ISR. ISR is more advance and optimized, but it [requires specific platforms to work](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration).

❤️ Appreciate your feedback and thank you very much for reading.