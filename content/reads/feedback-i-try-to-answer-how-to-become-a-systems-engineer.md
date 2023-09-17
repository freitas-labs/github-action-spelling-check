---
title: "Feedback: I try to answer \"how to become a systems engineer\""
description: "I got some anonymous feedback a while back asking if I could do an article on how to become a systems engineer. I'm not entirely sure that I can, and part of that is the ambiguity in the request...."
summary: "The following is a weird rant. The author starts talking on how he was requested to describe what a system engineer was, and that there are few system engineers on the field, because they require excellence and excellence in what they do. He then goes on to say that system engineering has nothing to do with life-cycle, because no one works through the whole life-cycle of a product."
keywords: ['system engineering', 'software engineering', 'rant', 'feedback']
date: 2023-06-03T07:10:54.098Z
draft: false
categories: ['reads']
tags: ['reads', 'system engineering', 'software engineering', 'rant', 'feedback']
---

The following is a weird rant. The author starts talking on how he was requested to describe what a system engineer was, and that there are few system engineers on the field, because they require excellence and excellence in what they do. He then goes on to say that system engineering has nothing to do with life-cycle, because no one works through the whole life-cycle of a product.

The way the rant finishes has nothing to do with the main topic.

https://rachelbythebay.com/w/2023/05/30/eng

---

I got some anonymous feedback a while back asking if I could do an article on how to become a systems engineer. I'm not entirely sure that I can, and part of that is the ambiguity in the request. To me, a "systems engineer" is a Real Engineer with actual certification and responsibilities to generally not be a clown. That's so far from the industry I work in that it's not even funny any more.

Seriously though, if you look up "systems engineering" on Wikipedia, it talks about "how to design, integrate and manage complex systems over their life cycles". That's definitely not my personal slice of the world. I don't think I've ever taken anything through a whole "life cycle", whatever that even means for software.

In the best case scenario, I suppose some of my software has gotten to where it's "feature complete" and has nothing obviously wrong with it. Then it just sits there and runs, and runs, and runs. Then, some day, I move on to some other gig, and maybe it keeps running. I've never had something go from "run for a long time" to "be shut down" while I was still around.

This is not to say that I haven't had long-lived stuff of mine get shut down. I certainly have. It's just that it's all tended to happen long enough after I left that it wasn't me managing that part of the "life cycle", so I heard about it second- or third-hand and much much later.

If anything, some things have lived far too long. My workstation at the web hosting support gig started its life with me in 2004 as a pile of parts that had formerly been a dedicated server. It had a bunch of dumb tools that I wrote and other people found useful. It should have been used to inspire the "real" programmers at that company to code up replacements, but seemingly did not. That abomination lived until \*at least\* 2011, or five years after I moved on from that company. None of that stuff was intended to run long-term, but someone kept tending it for years and years. It was awful.

But, okay, let's be charitable here. Maybe the feedback isn't asking for that exact definition, but rather something more like "how to get a job sort-of like the things I've done over the years". That's the kind of thing I definitely could take a whack at answering, assuming you like caveats.

I think it goes something like this: you start from the assumption that when you see something, you wonder why it is the way it is. Then maybe you observe it and maybe do a little research to figure out how it came to be the thing you see in front of you. This could go for just about anything: a telephone, a scale, a crusty old road surface, a forgotten grove of fruit trees, you name it. By research, I mean maybe you go poking around: try to open that scale with a screwdriver, get out of the car and walk down the old road, or turn over some of the dirt in the field to see if you can find any identifying marks.

I should also point out that this goes for trying to understand how people and groups of people came to be the way they are, too, but most tend to not respond well to being opened with screwdrivers, walked on, or turned over in the dirt. (And if they do, well, don't yuck their yum.)

Anyway, if you start from this spot, then maybe you start coming up with some hypotheses for how something happened, and then sort of mentally file that away for later. Or, maybe you even write it down. Then as more data comes down the pipe over the years, you revisit those thoughts and notes and refine them. Some notions are discarded (and noted as to why), but others are reinforced and evolved.

Do this for a while, and sooner or later you might have some working models. They might not necessarily be the actual explanation for why something is the way it is, but it gives you a starting point.

Then, one day, something breaks, and you end up getting involved. It might be a high-level system that's new to you, but it has some low-level stuff deep inside, and you recognize some of that. One of those low-level things had a history of doing a certain thing, and that never changed. They might've built a whole obscure system over top of it, but the fundamentals are still there, and they still break the same way. You go and look, and sure enough, some obscure thing has happened. Nobody else saw something like this before, and so when you point it out and flip it back to sanity to restore the rest of the system, they look at you like you just pulled off some deep magic.

The question is: did you, really? It's all relative. If you've been poking and prodding at things and have remembered the results of these experiments from over the years, it's not really new to you. It's just one of many events and might not be anything particularly special by itself. It just happened to be important on this occasion.

Some people will accept this explanation. Others will refuse it and will insist that you are a magician for fixing "the unfixable". A few others will know exactly what you did because they did it themselves once upon a time.

Then there are the one or two in every sufficiently large crowd who will see that you are being celebrated for knowing and utilizing some obscure factoid, and they will make it their mission to wreck your world. Basically, they have to make your random happenstance about them somehow, and so they make it about how it hurt them and how they need to get back at you. If this sounds pathological, it's because it is, and unfortunately you will encounter this at any company which doesn't have the ability to screen out the psychos.

This also goes for the web as a whole. Having something you've done be (temporarily!) elevated to a point of visibility somewhere public will just set these people off. This, too, is enabled by having forums which don't notice this and deal with their pests.

Now, for some examples of obscure knowledge that paid off, somehow.

`pid = fork(); ... kill(pid, SIGKILL); ...` but they didn't check for -1. "kill -9 -1" as root nukes everything on the box. This takes down the cat pictures for a couple of hours one morning because it turns out you need web servers to run a web site. Somehow, the bit in the kill(1) man page about "it indicates all processes except the kill process itself and init" stuck in my head. Also, the bit in the fork(2) man page that says "on failure, -1 is returned in the parent".

`malloc(1213486160)` is really `malloc(0x48545450)` is really `malloc("HTTP")`. I think this came from years of digging around in hex dumps and noticing that the letters in ASCII tend to bunch together (this is entirely deliberate). Seeing four of them in a row in the same range with nothing going over 0x7f suggested SOME WORD IN ALL CAPS. It was.

The fact I had seen some of this stuff before is just linked to some chance events in my life, combined with doing this kind of ridiculous work for a rather long time now. There are plenty of other times when something broke (or was generally flaky) and I had no idea what it could possibly be, and had to work up from first principles.

For someone who's just getting started, it's a given that you haven't seen many of these events yet. Don't feel too badly about it. If you keep doing it, you'll build up your own library of wacky things that could only be earned by slogging away at the job for years and years.

Also, if you think this is nuts and choose another path, I don't blame you. This \*is\* nuts, and it's entirely reasonable to seek something that doesn't require years of arcane experiences to somehow become effective.