---
title: "Speed-Up your Flutter Web App"
description: '4 tips that might help you to increase loading performance'
summary: "The following is a small, but detailed guide, that helps reduce load times of Flutter web apps. Make sure to follow these tips if you're deploying with Flutter web!"
keywords: ['fintasys', 'flutter', 'performance']
date: 2023-02-19T10:06:20+0000
draft: false
categories: ['reads']
tags: ['reads', 'fintasys', 'flutter', 'performance']
---

The following is a small, but detailed guide, that helps reduce load times of Flutter web apps. Make sure to follow these tips if you're deploying with Flutter web!

https://medium.com/@fintasys/speed-up-your-flutter-web-app-42969c36104b

---

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%20Ekd_ULGiwzkdHtYvUxWYlQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

AI generated header image

Recently I was working on an App that will also released on the Web and the first feedback that I received from my friends & family was that the speed to load the website is way too slow. So I started to investigate and tried to look a bit outside of Flutter in order to optimize the loading time of my Web App. Let me share with you what I’ve figured out.

My Setup
========

Quick overview what I was using before I started to optimize my Project.

Flutter: 3.3.4  
Web-Server: Node-JS + Express  
Host: Heroku — Hobby-Plan

My initial loading time of the Web-App was about 30–40 seconds in average.  
(Heroku Hobby-Plan might not be the fastest server)

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%20byFS9EKCEJUUT3NoyAQy-g.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Tip 1: Use Compression / Caching
================================

The most easiest way to increase the speed is to reduce file size of the files provided by the server, especially `main.dart.js` can be multiple MB big.

**Good:** With Node-JS you can use a Middleware like [Compression](https://www.npmjs.com/package/compression) to easily return the static files compressed with `gzip`:

```javascript
var compression = require('compression')  
var express = require('express')  
var app = express()_// compress all responses_  
app.use(compression())
``` 
>
This helped me to reduce some files like the `main.dart.js` by 75%.

Beside the file size I also realized that my files were not being cached and the response header showed `max-age=0` , which means that those files are not suppose to be cached.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%20nJeKWFu0eYZSs3yMUnif1A.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Eventually this was an issue with my Node-JS setup, but it’s possible to manipulate the header for static files in order to tell the Browser to cache those files:

`app.use(express.static('www', { maxAge: 3600000 })); // 1h`

**Better:** If you aim for a more scaleable web-app I would recommend to use instead a CDN service like [CloudFront](https://aws.amazon.com/cloudfront/) or [CloudFlare](https://www.cloudflare.com/). Those services offer much more features than only compression, like Caching of static files and provide those faster to your users and reduce pressure towards your web-server.  
Also they are using mostly `Brotli` which compresses your files even better sometimes than `gzip` .

If you already use Amazon as host for your App then I would recommend to use _CloudFront_. If you hosted your app on some third party cloud service like me I would recommend to use _Cloudflare_, because you can use it for free in combination with domain provider like Google Domain (Check this [Youtube video](https://www.youtube.com/watch?v=cwlinqDqFng) for more info). In order to use it with Amazon you need to create a non-free DNS entry on Amazon Route53 which you can then add to your `custom records` .

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%20VPrijMLBiaWh6E-wxRFv7w.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Cloudfare DNS-Config Example

After setting up your Cloudflare the DNS-Settings should like like this.  
**Important**: Make sure to remove any `A` and `AAA` entries if they were pre-filled! Otherwise it can be that the service is not working correctly.

`Content` can be obtained from Heroku under Settings:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%20kkd51i6h6-gDdlmDDbbZ0g.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

With this CDN-Service in front of my Web-Server I was able to reduce the loading time down to 4–6 seconds on first load without cached files. Every following request finished within 2–3 seconds.

Awesome! But I wanted to see if I can optimize further…

Tip 2: Remove unused files / Dependencies
=========================================

One thing I’ve noticed when loading my web-app was that I was loading some fonts which I wasn’t actually using.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%20D0kbk7Di_yuuku_GYTFnmA.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Material-Icons and Cupertino-Icons font

I actually wasn’t using`Cupertino` Icons anywhere in my App, I just had it because it was there from the start when I created the Flutter App and it was loaded every time even although I wasn’t using it.  
Removing it from my dependencies help me to recover a little bit of bandwidth. So make sure to check all files that being loaded and make sure you actually need them.

Tip 3: Parallelize the download of your files
=============================================

Current Flutter initialization flow on Web is partly like a Waterfall, after one thing is finished the next thing will be loaded. This is very inefficient and I took a look what are the most time consuming files and when in the loading flow they being requested.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%20dbLutzJN3CAh0RtIiZT_oQ.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

As you can see `canvaskit.js` , `canvaskit.wasm` and `MaterialIcons-Regular.otf` are not being requested before `main.dart.js` has been fully downloaded.

If we want to go the extra step we can try to request those files already beforehand and after `main.dart.js` has been fully loaded it will get those files directly from cache and safe some time.

We can achieve this by adding the files we want to preload inside the `index.html` in our project’s web folder:

```html
<link  
   rel="preload"  
   href="./assets/fonts/MaterialIcons-Regular.otf"  
   as="font"  
/><link  
   rel="preload"  
   href="https://unpkg.com/canvaskit-wasm@0.35.0/bin/canvaskit.wasm"  
   as="fetch"  
/>
```

As you can see, we managed to load those files in parallel at the beginning of the the site loading and after `main.dart.js` was finished they were ready immediately.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%2A_ivoSLpRShHJoOjUTEUZJg.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Optimized request with pre-fetching

This works fine with files like `MaterialIcons-Regular.otf` because they won’t change over time. But as you can see in the html code that we’ve added is that `canvaskit.wasm` is version based and with every Flutter update the chance that this version changes is high and requires manual editing of the index.html every time. There is a high risk to forget about this, so be careful using this for files like that.

Tip 4: Reduce size of images
============================

I guess this is very general advice for any frontend app and is also valid for Flutter Web Apps. As you could see in the Screenshot above images are not always being loaded immediately and therefore it is helpful to make sure those have the resolution they need and not unnecessary bigger.

Conclusion
==========

I hope those tips might be helpful for some people and I think Flutter is able to make some optimizations in future to improve the behavior by default (parallel loading, compression etc.).  
Also I think there is space for more optimizations but at some point it is necessary to weigh how much effort is meaningful.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/speedup_your_flutter_web_apps/1%20tlDUtn7XAXx8Cjz5AH496Q.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Optimized Loading Time

Feel free to checkout my Project [Wai-Wai-App](https://www.wai-wai.app), which I used to for this article. Press “join Event” to get to the Flutter-App!

Please leave a comment if you have questions or if this article helped you. Thank you very much!