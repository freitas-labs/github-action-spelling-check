---
title: "I'm betting on HTML"
description: "AI Use Disclaimer: I wrote this post and then GPT-4 fixed my grammer and spelling"
summary: "The following is a review on new official HTML elements that power a more semantic web. The author believes that building websites with these elements will make it more easier for scrapers and furthermore LLMs to interpret data, and ultimately, help humans."
keywords: ['catskull', 'semantic web', 'chatgpt']
date: 2023-08-01T15:48:37.921Z
draft: false
categories: ['reads']
tags: ['reads', 'catskull', 'semantic web', 'chatgpt']
---

The following is a review on new official HTML elements that power a more semantic web. The author believes that building websites with these elements will make it more easier for scrapers and furthermore LLMs to interpret data, and ultimately, help humans.

https://catskull.net/html.html 

---

> AI Use Disclaimer:  
> I wrote this post and then GPT-4 fixed my grammer and spelling

With the advent of large language model-based artificial intelligence, semantic HTML is more important now than ever. At its core, the internet is used to transmit data that helps humans interact with the world as they perceive it. The freedom that HTML/CSS/JS provide is a double-edged sword because access to data has become limited. Instead of open and accessible data formats and APIs, we’re kept within the walled gardens of major technology companies that operate mass social media sites. Because of this, interoperability between these platforms is effectively impossible, further complicated by these companies’ hesitance to allow easy data porting. After all, that’s their entire product, and without it, they can’t make money. The recent instability of our social media sites has renewed interest in decentralized platforms like the “fediverse”. Both Meta’s Threads and Jack Dorsey’s (Twitter founder) Bluesky claim interoperability with the larger fediverse. This is great!

But guess what? The general population doesn’t care!

What I mean is that people are not typically motivated to adopt new social media platforms for reasons that may not be entirely clear. I’m not condemning these efforts - I believe there’s a future there, and I’m watching as the development progresses. However, I believe we’re already sitting on a tried and tested solution: HTML.

Historically, heavy use of CSS was needed to prevent HTML content from looking terrible when rendered in a browser. Luckily, it’s not 1997 anymore! There are many new HTML elements that I wasn’t aware of until recently. I believe we now have virtually a complete set of all UI elements needed to build any modern web application. I don’t foresee corporate designers giving up their fancy JavaScript date picker that, _in a shock to nobody_ actually breaks the entire site on mobile, anytime soon. But we’re on the fringe, and we can do whatever we want. In fact, recently I’ve become acutely aware of reader mode. All time spent on styling will be obliterated by reader mode, and that’s a great thing!

Moreover, proper tagging is extremely descriptive in a machine-readable format. This is likely a more compelling reason for adopting modern HTML than saving design time. The shift from primary data interfaces to secondary interfaces is already underway. RSS refuses to die. ChatGPT-like interfaces are likely the future of human data access. We’re going back to the beginning. Advertisers may be scared, but I’m not! Let’s start the revolution and set the world on fire with modern HTML.

Below are a few examples of UI elements I found novel or useful. No style has been applied to these beyond the browser’s built-in style. Note that because of this, these examples may look vastly different (or be completely unsupported) in various browsers. It’s well worth your time browsing the full list on MDN: [https://developer.mozilla.org/en-US/docs/Web/HTML/Element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element)

#### [`<abbr>`: The Abbreviation element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/abbr)

Wrap any abbreviation in this! You can apply a style to highlight them. Mostly useful for machine reading.

#### [`<datalist>`: The HTML Data List element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/datalist)

Is that a typeahead I see? 🧐 Doesn’t seem to have built in validation, but the UI is there at least. Note that Safari requires `option` tags to be closed, or it just gives up. 😮‍💨

Choose a King Gizzard album: 

#### [`<details>`: The Details disclosure element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details)

A little dropdown thing for disclosoures and stuff. Can by styled quite aggressively.

PRIVACY DISCLOSURE You are being watched.

#### [`<dialog>`: The Dialog element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog)

Say the magic word and make me disappear!

No

This isn’t exactly a modal, but it is a built-in element that can be opened and closed with buttons, forms, attributes, and JavaScript. If you’re building a modal, you should use this as a base. Apparently, it renders on top of the next element.

#### [`<i>` vs. `<em>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/em#i_vs._em)

Know the difference!

#### [`<iframe>`: The Inline Frame element](https://www.youtube.com/watch?v=Htc-XeJwHyk)

Just kidding.

#### [`<input>`: The Input (Form Input) element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input)

Please, please, please, please, please label and use inputs appropriately! This is _essential_ for mobile users as the OS will open variations of the keyboard depending on context. I have an old post on that. There is a plethora of time inputs. No more datepickers please! Check out these inputs:

color:   
range:   
datetime-local: 

#### [`<mark>`: The Mark Text element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/mark)

Pretty much you can highlight text. By default Safari shows a yellow highlight. I like it!

#### [`<meter>`: The HTML Meter element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meter)

Now what exactly is this cute little guy for? Safari will show it as red/yellow/green depending on parameters that can be set. You can even get fancy and set the “optimum” value. Could be very useful. Let’s get a JS demo going to make a music visualizer at 60fps!

#### [`<progress>`: The Progress Indicator element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/progress)

Here’s a native HTML progress bar! If that’s not progress, I don’t know what is. Can be given a fixed value or indeterminate. On Safari, it’s blue when the window is active and grey when it’s not. By default it will follow the system’s accent color, or can be set with the `accent-color` CSS property.

70 %