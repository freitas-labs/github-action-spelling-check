---
title: "New on the web: How to detect disabled JavaScript in CSS"
description: 'Learn how the "scripting" media feature enables you to detect enabled/disabled JavaScript in CSS.'
summary: "The following is a guide on how to detect if JS is enabled in a browser at the CSS level. The author mentions the way you can do this with an “hack”, and then goes on to present a new feature in media query rule that applies styling only if JS is disabled."
keywords: ['stefan judis', 'css', 'web', 'javascript', 'media query']
date: 2023-04-20T21:35:23.068Z
draft: false
categories: ['reads']
tags: ['reads', 'stefan judis', 'css', 'web', 'javascript', 'media query']
---

The following is a guide on how to detect if JS is enabled in a browser at the CSS level. The author mentions the way you can do this with an “hack”, and then goes on to present a new feature in media query selector that applies styling only if JS is disabled.

The author hacky solution reminds me on how I achieved screen breakpoint discovery without knowing the actual breakpoint values, using CSS dynamic variables and Javascript: https://github.com/nolytics/viewer/blob/master/src/lib/media-query/screen.ts

https://www.stefanjudis.com/blog/how-to-detect-disabled-javascript-in-css/

---

How many people actively disable JavaScript in their browsers? I couldn't find any recent stats to answer this question, but if my memory doesn't fail me, it's only a tiny fraction of the overall web traffic (below 1%).

And that's no surprise. Have you tried using the web without JS? If so, I doubt you've come very far. JavaScript drives everything from small widgets and form validation to full-fledged all-in JS sites.

Keep in mind that disabled JavaScript is not the primary reason why applications break. [As the friends at GOV.UK rightfully say](https://www.gov.uk/service-manual/technology/using-progressive-enhancement#do-not-assume-users-turn-off-css-or-javascript) there are plenty of reasons why JavaScript fails. A browser extension could block it, the visitor might be on a flaky network, there could be a DNS issue, ... the possibilities are endless.

That's why **progressive enhancement should be at the core of your web development**.

But still, if you want to be a good web citizen, you should inform people that your site requires enabled scripting. How can you do this?

You can use [the `noscript` element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/noscript).

```HTML
    <noscript>
      <h1>This page requires JavaScript</h1>
    </noscript>
```

The `noscript` element works fine but, unfortunately, is an HTML-only solution. You can't adjust your styles when JavaScript is disabled. But how could you detect if scripts run in CSS?

To detect if JavaScript is enabled, you can deliver your HTML with a `no-js` class that will be removed via JavaScript. When your JS runs, you can then style your page depending on the existing or removed `no-js` class.

This approach always felt hacky to me, though. And there's news! Today I learned about [the Media Queries Level 5 spec that defines a `scripting` media feature](https://www.w3.org/TR/mediaqueries-5/#scripting).

```CSS
    /* 
      The user agent will not run scripts for this document.
    */
    @media (scripting: none) {
      body {
        /* ... */
      }
    }
    
    /*  
      The user agent supports scripting of the page 
      and it's enabled during the initial page load.
      Examples are printed pages, or pre-rendering network proxies.
    */
    @media (scripting: initial-only) {
      body {
        /* ... */
      }
    }
    
    /* 
      The user agent supports scripting of the page
      and it's enabled for the lifetime of the document.
    */
    @media (scripting: enabled) {
      body {
        /* ... */
      }
    }
```

The `scripting` media feature just entered the first browser — Firefox Nightly (113). 🎉

{{< video src="https://github.com/freitzzz/cinderela/raw/master/blog/general/how-to-detect-disabled-javascript-in-css/no-scripting-small.mp4" type="video/mp4" preload="auto" >}}

This blog reacting to disabled JavaScript via the "scripting" media feature.

What about the other browsers?

It's early times for `@media (scripting: none)`, but you will find up-to-date browser support information in the table below.

MDN Compat Data ([source](https://raw.githubusercontent.com/mdn/browser-compat-data/main/css/at-rules/media.json))

Browser support info for [`scripting` media feature](https://developer.mozilla.org/docs/Web/CSS/@media/scripting)

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/how-to-detect-disabled-javascript-in-css/screen04.webp"
    caption=""
    alt=`scripting propery support in browsers as of 20/04/2023`
    class="row flex-center"
>}}

If you plan on using `@media (scripting: none)`, remember that it only detects whether JavaScript is enabled/disabled. It doesn't tell you if requests failed or you're application blew up. **You should still build your sites with progressive enhancement in mind to guarantee a good experience for all situations** or rely on the `no-js` trick to detect broken JS.

In summary, this new web addition is not the most ground-breaking feature, but still, I appreciate everything that streamlines web development and helps us to build sites that respect user preferences!

Yay for the web! _Even though it'll be only visible to the 1% of folks browsing the web without JS._ 🎉