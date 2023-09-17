---
title: "How to Succeed in Open Source Without Really Trying (Really)"
description: "It is code written by an idiot, full of downloads and regex, signifying nothing."
summary: "The following is the story of a developer who published a library to NPM some years ago, which is downloaded weekly for more than one million times. Platforms classify him as an open-source maintainer, but he does not agree with that, because the library is rarely updated and maintained by him."
keywords: ['webdev', 'open source', 'npm', 'javascript']
date: 2023-05-19T17:47:08.842Z
draft: false
categories: ['reads']
tags: ['reads', 'webdev', 'open source', 'npm', 'javascript']
---

The following is the story of a developer who published a library to NPM some years ago, which is downloaded weekly for more than one million times. Platforms classify him as an open-source maintainer, but he does not agree with that, because the library is rarely updated and maintained by him.

https://dev.to/tigt/how-to-succeed-in-open-source-without-really-trying-really-55pj

---

≥8 years ago, I wrote about [an extremely niche improvement to a very specific use of SVGs.](https://codepen.io/tigt/post/optimizing-svgs-in-data-uris) It got enough positive feedback that I turned that knowledge into an NPM package: [`mini-svg-data-uri`](https://www.npmjs.com/package/mini-svg-data-uri).

Today, it’s both one of the **most** and **least important** web dev things I’ve ever done.

[](#somehow-its-important)Somehow, it’s important
-------------------------------------------------

*   As of this writing, NPM says it gets ≈1.7 million downloads/week. That also means NPM foisted 2FA onto my account that I almost never use. (If you compare the dates when the repo accepted a PR to the NPM updates, you’ll probably see _exactly_ when they did that.)
*   [Snyk rates it “Influential”](https://snyk.io/advisor/npm-package/mini-svg-data-uri), which means it’s in the top 5% of all NPM packages actually added to a `package.json`, not just a transitive dependency.
*   I know with some certainty that _lots_ of people [use `mini-svg-data-uri` solely on RunKit](https://npm.runkit.com/mini-svg-data-uri), so both Snyk and NPM don’t see a huge chunk of users. (Never underestimate how meaningful a “try online” feature is.)

Normally, I’d be super smug about this and start being insufferable in developer conversations, but…

[](#its-also-unimportant-and-ridiculous)It’s also unimportant and ridiculous
----------------------------------------------------------------------------

Snyk and NPM both have algorithms to rate packages for quality and maintenance, but in this case they should consider letting me submit a rating of “lol i dunno”.

It’s not _that_ effective.

The README points out it optimizes by as much as, uh, 20%. And unlike the README’s example, most websites don’t consist entirely of SVG `data:` URIs.

Unless you’re using `mini-svg-data-uri` in an offline build tool, it’s almost certainly not worth the download of its JS. (So [all of you `import`ing it](https://www.npmjs.com/browse/depended/mini-svg-data-uri) to use on the client-side… are you sure you want to do that?)

It has no tests.

I don’t remember where [its `index.test-d.ts`](https://github.com/tigt/mini-svg-data-uri/blob/master/index.test-d.ts) came from, but it’s certainly not clear what it accomplishes.

It rarely updates.

Snyk penalizes this, but honestly it’s kind of a feature. It rarely _needs_ to update.

It’s written in like, ES3½.

[Folks wanted to use it untranspiled](https://github.com/tigt/mini-svg-data-uri/pull/5), or something? In principle **that’s terrible** and Alex Russell will appear in your mirrors at night chanting “who made this mess”, but [in practice it’s ≈3.5kB unminified](https://unpkg.com/browse/mini-svg-data-uri@1.4.4/).

I am objectively kind of a bad maintainer.

I automated nothing, which means I must relearn how to `npm publish` each update, which means folks’ contributions can get needlessly delayed.

If you look through the issues, you’ll see me say “I don’t know” a lot. Humility’s one thing, but I wouldn’t begrudge anyone not trusting me to do things right.

There’s no code of conduct or contributing guidelines, and it still defaults to `master`. (Somehow I’ve innovated the cognitive dissonance of believing those things are important, and yet also _too_ important for my rinkydink package.)

The features it accrued are niche.

Its “types”: a function that accepts a string and returns a string. [I assume the TypeScript was for autocomplete or purism or something](https://github.com/tigt/mini-svg-data-uri/pull/15#issuecomment-624412182), because it sure doesn’t constrain much.

[Its CLI is from a dev who whipped it up for themselves then contributed back on a whim.](https://simonewebdesign.it/1req/#the-favicon) Sure, without a real shell arguments parser, it might break or be needlessly slow. But if you can identify those problems, you probably already know how to fix them with your own `#!/usr/bin/env node`.

[It sprouted a `.toSrcset()` method](https://github.com/tigt/mini-svg-data-uri/issues/9) because `srcset` uses spaces as part of its syntax, so you need `%20` escapes. [It accomplishes this with zero cleverness whatsoever](https://github.com/tigt/mini-svg-data-uri/blob/00dc78c8f77eb7b47299a9e3d564749105810c9c/index.js#L51-L53), so I suspect most of the feature’s worth is from how it emphasizes the `srcset` pitfall in the README.

To be clear, I appreciate that those devs took the time to add features that scratched their own itch. I know there’s something to be said for refusing features to keep software lean and mean. But even though I don’t use those contributed features myself, it takes up a whopping 10kB uncompressed on disk. So, like, refusing those features would have ruined a lot of peoples’ days for no real reason.

[](#nobody-really-gives-that-much-of-a-shit-about-it)Nobody _really_ gives that much of a shit about it
-------------------------------------------------------------------------------------------------------

*   The code is handy, but if it became even slightly annoying to use — say if I added whatever makes `npm fund` do its thing — people would just fork or vendor it.
*   It’s in a sweet spot of usefulness with almost no leverage, so it chugs along without any temptation for me to do anything spicy and/or money-related with it.
*   Putting its stats on my résumé would be impressive, until anyone looked closer.
*   It’s somehow avoided getting slapped with [the “regular expression denial of service” bullshit that everyone loves](https://overreacted.io/npm-audit-broken-by-design/), despite having regular expressions I authored in 3 minutes.
*   I haven’t even had people try to grift me over it, which I assume is automated based on package stats nowadays.

And yet, it’s undeniably popular. I guess it ticks all the boxes for “is this worth using?” — it handles enough annoying details that you’d rather not yourself, it has no dependencies, and you can read the entire source code almost by accident. [The UNIX philosophy is a scam](https://www.johndcook.com/blog/2012/05/25/unix-doesnt-follow-the-unix-philosophy/), but it’s a nice racket if you can get it.

[](#its-dying-but-not-howd-you-think)It’s dying, but not how’d you think
------------------------------------------------------------------------

`svg-mini-data-uri` will probably become obsolete as evergreen browsers completely take over, since their parsing is loose enough that `"data:image/svg+xml," + str.replace(/#/g, '%23')` gets you 80% there.

Honestly, it’s kind of nice that it’ll die with the problem it helped solve. It was there when needed, but not a moment longer.

[](#so-what)So what?
--------------------

Maybe the system worked this time? I wrote code for me, then shared it, and now tons of people benefit without me suffering the [usual problems of being a popular open-source maintainer](https://nolanlawson.com/2017/03/05/what-it-feels-like-to-be-an-open-source-maintainer/). The software does what it says, boringly, and is small enough that it doesn’t make developers or users suffer even when it’s not used “right”.

And it happened without me writing tests, doing any outreach, being good at code, or even [using `this` correctly](https://github.com/tigt/mini-svg-data-uri/issues/9#issuecomment-503397923).

When I put it that way, it sounds like a pretty good trick.