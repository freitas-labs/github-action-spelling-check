---
title: "HTMX is the future"
description: "You don't have to put yourself through hell to make great web applications. We can use battle-tested, boring technology to create great experiences."
summary: "The author introduces the concept of *htmx*: a way to express dynamic HTML manipulation without JavaScript in the client browser. In short, htmx proposes a set of attributes that are marked in any HTML element of your webpage. Then, in your server, based on the presence of these attributes, you decide what you should do, ultimately returning rich HTML with hypermedia capabilities instead of JSON."
keywords: ['chris james', 'htmx', 'webdev', 'html', 'react']
date: 2023-05-15T07:23:16.401Z
draft: false
categories: ['reads']
tags: ['reads', 'chris james', 'htmx', 'webdev', 'html', 'react']
---

The author introduces the concept of *htmx*: a way to express dynamic HTML manipulation without JavaScript in the client browser. In short, htmx proposes a set of attributes that are marked in any HTML element of your webpage. Then, in your server, based on the presence of these attributes, you decide what you should do, ultimately returning rich HTML with hypermedia capabilities instead of JSON.

https://dev.to/quii/htmx-is-the-future-157j

---

User expectations of the web are now that you have this super-smooth no-reload experience. Unfortunately, it's an expectation that is usually delivered with single-page applications (SPAs) that rely on libraries and frameworks like React and Angular, which are very specialised tools that can be complicated to work with.

A new approach is to put the ability to deliver this UX back into the hands of engineers that built websites before the SPA-craze, leveraging their existing toolsets and knowledge, and HTMX is the best example I've used so far.

[](#the-costs-of-spa)The costs of SPA
-------------------------------------

SPAs have allowed engineers to create some great web applications, but they come with a cost:

*   Hugely increased complexity both in terms of architecture and developer experience. You have to spend considerable time learning about frameworks.
    
    *   Tooling is an ever-shifting landscape in terms of building and packaging code.
    *   Managing state on both the client and server
    *   Frameworks, on top of libraries, on top of other libraries, on top of polyfills. [React even recommend using a framework on top of their tech](https://react.dev):

> React is a library. It lets you put components together, but it doesn’t prescribe how to do routing and data fetching. To build an entire app with React, we recommend a full-stack React framework.

*   By their nature, a fat client requires the client to execute a lot of JavaScript. If you have modern hardware, this is fine, but these applications will be unusable & slow for those on older hardware or in locations with slow and unreliable internet connections.
    
    *   It is very easy to make an SPA incorrectly, where you need to use the right approach with hooks to avoid ending up with abysmal client-side performance.
*   Some SPA implementations of SPA throw away progressive enhancement (a notable and noble exception is [Remix](https://remix.run)). Therefore, you _must_ have JavaScript turned on for most SPAs.
    
*   If you wish to use something other than JavaScript or TypeScript, you must traverse the treacherous road of transpilation.
    
*   It has created backend and frontend silos in many companies, carrying high coordination costs.
    

Before SPAs, you'd choose your preferred language and deliver HTML to a user's browser in response to HTTP requests. This is _fine_, but it offers little interactivity and, in some cases, could make an annoying-to-use UI, especially regarding having the page fully reload on every interaction. To get around this, you'd typically sprinkle varying amounts of JS to grease the UX wheels.

Whilst this approach can feel old-fashioned to some, this approach is what inspired the [original paper of **REST**](http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm), especially concerning **hypermedia**. The hypermedia approach of building websites led to the world-wide-web being an incredible success.

### [](#hypermedia)Hypermedia?

The following is a response from a data API, not hypermedia.  

    {
      "sort": "12-34-56",
      "number": "87654321",
      "balance": "123.45"
    }
    

Enter fullscreen mode Exit fullscreen mode

To make this data useful in an SPA, the code must understand the structure and decide what to render and what controls to make available.

REST describes the use of hypermedia. Hypermedia is where your responses are not just raw data but are instead a payload describing the media (think HTML tags like `<p>`, headers, etc.) _and_ how to manipulate it (like `form`, `input`).

A server returning HTML describing a bank account, with some form of controls to work with the resource, is an example of hypermedia. The server is now responsible for deciding how to render the data (with the slight caveat of CSS) and _what_ controls should be displayed.  

    <dl>
      <dt>Sort</dt><dd>12-34-56</dd>
      <dt>Number</dt><dd>87654321</dd>
      <dt>Balance</dt><dd>£123.45</dd>
    </dl>
    <form method="POST" action="/transfer-funds">
      <label>Amount <input type="text" /></label>
      <!-- etc -->
      <input type="submit" value="Do transfer" />
    </form>
    

Enter fullscreen mode Exit fullscreen mode

The approach means you have one universal client, the web browser; it understands how to display the hypermedia responses and lets the user work with the "controls" to do whatever they need.

[Carson Gross on The Go Time podcast](https://changelog.com/gotime/266)

> ...when browsers first came out, this idea of one universal network client that could talk to any application over this crazy hypermedia technology was really, really novel. And it still is.
> 
> If you told someone in 1980, “You know what - you’re gonna be using the same piece of software to access your news, your bank, your calendar, this stuff called email, and all this stuff”, they would have looked at you cross-eyed, they wouldn't know what you were talking about, unless they happened to be in one of the small research groups that was looking into this sort of stuff.

Whilst ostensibly, people building SPAs talk about using "RESTful" APIs to provide data exchange to their client-side code, the approach is not RESTful in the purist sense because it does not use hypermedia.

Instead of one universal client, _scores of developers create bespoke clients_, which have to understand the raw data they fetch from web servers and then render controls according to the data. With this approach, the browser is more of a JavaScript, HTML and CSS runtime.

By definition, a fatter client will carry more effort and cost than a thin one. However, the "original" hypermedia approach arguably is not good enough for all of today's needs; the controls that the browser can work with and the way it requires a full page refresh to use them mean the user experience isn't good enough for many types of web-app we need to make.

### [](#htmx-and-hypermedia)HTMX and hypermedia

Unlike SPAs, HTMX **doesn't throw away the architectural approach of REST**; it _augments the browser_, **improving its hypermedia capabilities** and making it simpler to deliver a rich client experience without having to write much JavaScript if any at all.

You can use **whatever programming language you like** to deliver HTML, just like we used to. This means you can use battle-tested, mature tooling, using a "true RESTful" approach, resulting in a far more straightforward development approach with less accidental complexity.

HTMX allows you to design pages that fetch **fragments of HTML** from your server to update the user's page as needed without the annoying full-page load refresh.

We'll now see this in practice with the classic TODO-list application.

[](#clojure-htmx-todo)Clojure HTMX TODO
---------------------------------------

First-of-all, please don't get overly concerned with this being written in Clojure. I did it in Clojure for fun, but the beauty of this approach is that you can use whatever language you like, so long as it responds to HTTP requests.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/htmx-is-the-future/mJCwSLf.gif"
    caption=""
    alt=`The todo list app demo`
    class="row flex-center"
>}}

Nothing special here, but it **does feel like a SPA**. There are no full-page reloads; it's buttery smooth, just like all the other SPA demos you would've seen.

The difference here is:

*   I did not write any JavaScript.
*   I also didn't cheat by transpiling Clojure into JavaScript. (see [ClojureScript](https://clojurescript.org))

I made a web server that responds to HTTP requests with hypermedia.

HTMX adds the ability to define **richer hypermedia** by letting you annotate _any HTML element_ to ask the browser to make HTTP requests to fetch fragments of HTML to put on the page.

### [](#the-edit-control)The edit control

The most exciting and impressive part of this demo is the edit action. The way an input box instantly appears for you to edit and then quickly update it again _feels_ like it would require either a lot of vanilla JS writing or a React-esque approach to achieve, but what you'll see is it's absurdly simple.

Let's start by looking at the markup for a TODO item. I have clipped the non-edit markup for clarity.  

    <li hx-target="closest li">
      <form action="/todos/2a5e549c-c07e-4ed5-b7d4-731318987e05" method="GET">
          <button hx-get="/todos/2a5e549c-c07e-4ed5-b7d4-731318987e05" hx-swap="outerHTML">📝</button>
      </form>
    </li>
    

Enter fullscreen mode Exit fullscreen mode

It maybe looks a lot, but the main things to focus on for understanding how the edit functionality works:

*   On the `<li>`, an attribute `hx-target` tells the browser, "When you get a fragment to render, this is the element I want you to replace". The children inherit this attribute, so for any HTMX actions inside this `<li>`, the `HTML` returned will replace the contents of the `<li>`.
*   `hx-get` on the edit button means when you click it, `HTMX` with tell the browser to do an `HTTP GET` to the `URL` and fetch some new markup to render to the `<li>` in place of what's there.
*   The form is not essential for the example, but it allows us to support the functionality for non-JavaScript users, which will be covered later.

When you start working with HTMX, an easy way to understand what's going on is to look at the network in the browser's developer tools.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/htmx-is-the-future/lnobOm5.png"
    caption=""
    alt=`the browser is requesting the todo resource`
    class="row flex-center"
>}}

When a user clicks the edit button, the browser does an `HTTP GET` to the _specific todo resource_. The server returns a hypermedia response, which is a representation of that resource with some hypermedia controls.  

    <form action="/todos/45850279-bf54-4e2e-a95c-c8c25866a744/edit"
          hx-patch="/todos/45850279-bf54-4e2e-a95c-c8c25866a744" hx-swap="outerHTML" method="POST">
      <input name="done" type="hidden" value="false"/>
      <input name="name" type="text" value="Learn Rust"/>
      <input type="submit"/>
    </form>
    

Enter fullscreen mode Exit fullscreen mode

HTMX then takes that HTML and replaces whatever we defined as the `hx-target`. So the user now sees these hypermedia controls for them to manipulate the resource, instead of the row pictured before.

You'll notice the form has a `hx-patch` attribute, which means when it is submitted, the browser will send a `PATCH` with the data to update the resource. The server then responds with the updated item to render.

[](#embracing-the-web)Embracing the web
---------------------------------------

There's more to HTMX, but this is the crux of the approach, which is the same as the approach that most websites were made before SPAs became popular.

*   The user goes to a `URL`
*   The server returns hypermedia (HTML), which is content with controls.
*   Browser renders hypermedia
*   Users can use the controls to do work, which results in an HTTP request sent from the browser to the server.
*   The server does business logic, and then returns new hypermedia for the user to work with

All HTMX does, is make the browser **better** at hypermedia by giving us more options regarding **what can trigger an HTTP request** and **allowing us to update a part of the page rather than a full page reload**.

By embracing the hypermedia and not viewing the browser as merely a JavaScript runtime, we get a lot of simplicity benefits:

*   We can use any programming language.
*   We don't need lots of libraries and other cruft to maintain what were basic benefits of web development.
    *   Caching
    *   SEO-friendliness
    *   The back button working as you'd expect
    *   etc.
*   It is very easy to support users who do not wish to, or cannot use JavaScript

This final point is crucial to me and to my current employer. I work for a company that works on products used worldwide, and our content and tools must be as usable by as many people as possible. It is unacceptable for us to exclude people through poor technical choices.

This is why we adopt the approach of [**progressive enhancement**](https://developer.mozilla.org/en-US/docs/Glossary/Progressive_Enhancement).

> **Progressive enhancement** is a design philosophy that provides a baseline of essential content and functionality to as many users as possible, while delivering the best possible experience only to users of the most modern browsers that can run all the required code.

All the features in the TODO app (search, adding, editing, deleting, marking as complete) all work with JavaScript turned off. HTMX doesn't do this for "free", it still requires engineering effort, but because of the approach, it is inherently simpler to achieve. It took me around an hour's effort and did not require significant changes.

### [](#how-it-supports-nonjavascript)How it supports non-JavaScript

When the browser sends a request that was prompted by HTMX, it adds a header `HX-Request: true` , which means on the server, we can send different responses accordingly, very much like [content negotiation](https://developer.mozilla.org/en-US/docs/Web/HTTP/Content_negotiation).

The rule of thumb for a handler is roughly:  

    parseAndValidateRequest()
    myBusinessLogic()
    
    if request is htmx then
        return hypermedia fragment
    else
        return a full page
    end
    

Enter fullscreen mode Exit fullscreen mode

Here's a concrete example of the HTTP handler for dealing with a new TODO:  

    (defn handle-new-todo [get-todos, add-todo]
      (fn [req] (let [new-todo (-> req :params :todo-name)]
                  (add-todo new-todo)
                  (htmx-or-vanilla req
                                   (view/todos-fragment (get-todos))
                                   (redirect "/todos")))))
    

Enter fullscreen mode Exit fullscreen mode

The third line is our "business logic", calling a function to add a new TODO to our list.

The fourth line is some code to determine what kind of request we're dealing with, and the subsequent lines either render a fragment to return or redirect to the page.

So far, this seems a recurring theme when I've been developing hypermedia applications with HTMX. By the very architectural nature, if you can support updating part of a page, return a fragment; otherwise, the browser _needs_ to do a full page reload, so either redirect or just return the entire HTML.

HTML templating on the server is in an incredibly mature state. There are many options and excellent guides on how to structure and add automated tests for them. Importantly, they'll all offer some composition capabilities, so the effort to return a fragment or a whole page is extremely simple.

[](#why-is-it-the-future-)Why is it _The Future_ ?
--------------------------------------------------

Obviously, I cannot predict the future, but I do believe HTMX (or something like it) will become an increasingly popular approach for making web applications in the following years.

Recently, [HTMX was announced as one of 20 projects in the GitHub Accelerator](https://github.blog/2023-04-12-github-accelerator-our-first-cohort-and-whats-next/)

### [](#it-makes-the-frontend-more-accessible)It makes "the frontend" more accessible.

Learning React is an industry in itself. It moves quickly and changes, and there are tons to learn. I sympathise with developers who _used_ to make fully-fledged applications being put off by modern frontend development and instead were happy to be pigeonholed into being a "backend" dev.

I've made reasonably complex systems in React, and whilst some of it was pretty fun, **the amount you have to learn to be effective is unreasonable for most applications**. React has its place, but it's overkill for many web applications.

The hypermedia approach with HTMX is not hard to grasp, especially if you have some REST fundamentals (which many "backend" devs should have). It opens up making rich websites to a broader group of people who don't want to learn how to use a framework and then keep up with its constantly shifting landscape.

### [](#less-churn)Less churn

Even after over 10 years of React being around, it still doesn't feel settled and mature. A few years ago, hooks were the new-fangled thing that everyone had to learn and re-write all their components with. In the last six months, my Twitter feed has been awash with debates and tutorials about this new-fangled "RSC" - react server components. Joy emoji.

Working with HTMX has allowed me to leverage things I learned 15-20 years ago **that still work**, [like my website](https://quii.dev/How_my_website_works). The approach is also well-understood and documented, and the best practices are independent of programming languages and frameworks.

I have made the example app in Go _and_ Clojure with no trouble at all, and I am a complete Clojure novice. Once you've figured out the basic syntax of a language and learned how to respond to HTTP requests, you have enough to get going; and you can re-use the architectural and design best practices without having to learn a new approach over and over again.

How much of your skills would be transferable from React if you had to work with Angular? Is it easy to switch from one react framework to another? How did you feel when class components became "bad", and everyone wanted you to use hooks instead?

### [](#cheaper)Cheaper

It's just less effort!

[Hotwire](https://hotwired.dev) is a library with similar goals to HTMX, driven by the Ruby on Rails world. DHH tweeted the following.

> [Hotwiring Rails expresses the desire to gift a lone full-stack developer all the tools they need to build the next Basecamp, GitHub, or Shopify. Not what a team of dozens or hundreds can do if they have millions in VC to buy specialists. Renaissance tech for renaissance people.](https://twitter.com/dhh/status/1341758748717510659)
> 
> That's why it's so depressing to hear the term "full stack" be used as a derogative. Or an impossible mission. That we HAVE to be a scattered band of frontend vs backend vs services vs whatever group of specialists to do cool shit. Absolutely fucking not.

Without the cognitive overload of understanding a vast framework from the SPA world and the inherent complexities of making a fat client, you can realistically create rich web applications with far fewer engineers.

### [](#more-resilient)More resilient

As described earlier, using the hypermedia approach, making a web application that works without JavaScript is relatively simple.

It's also important to remember that the browser is an **untrusted environment**, so when you build a SPA, you have to work extremely defensively. You have to implement lots of business logic client side; but because of the architecture, this same logic needs to be replicated on the server too.

For instance, let's say we wanted a rule saying you cannot edit a to-do if it is marked as done. In an SPA world, I'd get raw JSON, and I'd have to have business logic to determine whether to render the edit button on the client code somewhere. However, if we wanted to ensure a user couldn't circumvent this, I'd have to have this same protection on the server. This sounds low-stakes and simple, but this complexity adds up, and the chance of misalignment increases.

With a hypermedia approach, the browser is "dumb" and doesn't need to worry about this. As a developer, I can capture this rule in one place, the server.

### [](#reduced-coordination-complexity)Reduced coordination complexity

**The complexity of SPAs has created a shift into backend and frontend silos**, which carries a cost.

The typical backend/frontend team divide causes a lot of inefficiencies in terms of teamwork, with hand-offs and miscommunication, and **makes getting stuff done harder**. Many people mistake individual efficiencies as the most critical metric and use that as justification for these silos. They see lots of PRs being merged, and lots of heat being generated, but ignoring the coordination costs.

For example, let's assume you want to add a new piece of data to a page or add a new button. For many teams, that'll involve meetings between teams to discuss and agree on the new API, creating fakes for the frontend team to use and finally coordinating releases.

In the hypermedia approach, you **don't have this complexity at all**. If you wish to add a button to the page, you can add it, and you don't need to coordinate efforts. You don't have to worry so much about API design. You are free to change the markup and content as you please.

Teams exchanging data via JSON can be **extremely brittle** without care and always carries a coordination cost. Tools like consumer-driven contracts can help, but this is just _another_ tool, _another_ thing to understand and _another_ thing that goes wrong.

This is not to say there is no room for specialisation. I've worked on teams where the engineers built the web application "end to end", but we had people who were experts on semantic, accessible markup who helped us make sure the work we did was of good quality. It is incredibly freeing not to have to negotiate APIs and hand off work to one another to build a website.

### [](#more-options)More options

Rendering HTML on the server is a very well-trodden road. Many battle-tested and mature tools and libraries are available to generate HTML from the server in every mainstream programming language and most of the more niche ones.

[](#wrapping-up)Wrapping up
---------------------------

I encourage developers looking to reduce the costs and complexities of web application development to check out HTMX. If you've been reluctant to build websites due to the fair assessment that front-end development is difficult, HTMX can be a great option.

I'm not trying to claim that SPAs are now redundant; there will still be a real need for them when you need very sophisticated and fast interactions where a roundtrip to the server to get some markup won't be good enough.

[In 2018 I asserted that a considerable number of web applications could be written with a far simpler technological approach](https://quii.dev/The_Web_I_Want) than SPAs. Now with the likes of HTMX, this assertion carries even more weight. The frontend landscape is dominated by waiting for a new framework to relieve the problems of the previous framework you happened to be using. The SPA approach is **inherently more complicated than a hypermedia approach**, and piling on more tech might not be the answer, give hypermedia a go instead.

Check out some of the links below to learn more.

[](#further-reading-and-listening)Further reading and listening
---------------------------------------------------------------

*   The author of HTMX has written an excellent, [free book, explaining hypermedia](https://hypermedia.systems). It's an easy read and will challenge your beliefs on how to build web applications. If you've only ever created SPAs, this is an essential read.
*   [HTMX](https://htmx.org). The examples section, in particular, is very good in showing you what's possible. The essays are also great.
*   I was lucky enough to be invited onto [The GoTime podcast with the creator of HTMX, Carson Gross to discuss it](https://changelog.com/gotime/266)! Even though it's a Go podcast, the majority of the conversation was about the hypermedia approach.
*   [The Go version](https://github.com/quii/todo) was my first adventure with HTMX, creating the same todo list app described in this post
*   I worked on [The Clojure version](https://github.com/ndchorley/todo) with my colleague, Nicky
*   [DHH on Hotwire](https://world.hey.com/dhh/the-time-is-right-for-hotwire-ecdb9b33)
*   [Progressive enhancement](https://developer.mozilla.org/en-US/docs/Glossary/Progressive_Enhancement)
*   Five years ago, I wrote [The Web I Want](https://quii.dev/The_Web_I_Want), where I bemoaned the spiralling costs of SPAs. It was originally prompted by watching my partner's 2-year-old ChromeBook grind to a halt on a popular website that really could've been static HTML. In the article, I discussed how I wished more of the web stuck to the basic hypermedia approach, rendering HTML on the server and using progressive enhancement to improve the experience. Reading back on this has made me very relieved the likes of HTMX have arrived.