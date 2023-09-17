---
title: "IKEA-Oriented Development"
description: "To frugally furnish a codebase, imitate Ikea."
summary: "The following article is really interesting. The author compares developers as homeowners who need to maintain their property (project). Given this relationship between maintaining software and maintaining an home, we can use Ikea as an inspiration for development processes since Ikea is recognized for their excellence in the products they deliver, the simplicity for assembling things and their customer experience."
keywords: ['taylor troesh', 'software engineering', 'ikea']
date: 2023-06-21T22:38:36.209Z
draft: false
categories: ['reads']
tags: ['reads', 'taylor troesh', 'software engineering', 'ikea']
---

The following article is really interesting. The author compares developers as homeowners who need to maintain their property (project). Given this relationship between maintaining software and maintaining an home, we can use Ikea as an inspiration for development processes since Ikea is recognized for their excellence in the products they deliver, the simplicity for assembling things and their customer experience.

https://taylor.town/ikea-oriented-development

---

Every codebase is a home. Repos carry scars, arguments, memories, secrets, decorations, and sometimes [graffiti](https://twitter.com/FrostbiteEngine/status/398214869662441472).

Programmers are homeowners. They perform repairs, rearrange things, and embark on redesigns.

To frugally furnish a codebase, imitate Ikea:

1.  [Packaging is the Product](#air)
2.  [Pre-Packaged Dependencies](#deps)
3.  [Composable & Disposable](#cd)

* * *

1\. Packaging is the Product
----------------------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/ikea-oriented-development/persimmon-box.webp"
    caption=""
    alt=`shipping air`
    class="row flex-center"
>}}

> We hate air.
> 
> – Peter Agnefjäll (CEO of IKEA)

They’re not trying to cut costs on assembly labor, folks.

Air is expensive. Ikea embraces DIY furniture to save space on trucks, ships, and warehouses.

> IKEA famously eliminates air from their packages by selling their furniture in ready-to-assemble parts. In 2010, when they started selling their Ektorp sofa disassembled, IKEA eliminated enough air to reduce their package size by 50%. With this smaller packaging, IKEA was able to remove 7,477 trucks from the roads annually.
> 
> – Katelan Cunningham ([_Why IKEA Hates Air_](https://www.lumi.com/blog/ship-less-air))

It takes ~10 seconds to open the Zoom _login screen_ on my M1 Pro. Generations of software devs used Moore’s Law to deliver exponential air to our computers.

Packaging is the product; data layouts matter.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/ikea-oriented-development/k0t1e.webp"
    caption=""
    alt=`computing latencies`
    class="row flex-center"
>}}

Delivering data is expensive.

Bytes bounce between disks, RAM, caches, and networks.

How much space/time _should_ a program use in theory? Seriously, [always make an educated guess](https://www.youtube-nocookie.com/embed/Ge3aKEmZcqY).

Take any ID or value in your system. How many computers does it touch? How much time does it spend in HTTP packets? How big and how long does it spend in RAM? How many times is it copied in CPU cache? How is it moved or copied on the program stack? How is it represented in the GPU?

As an exercise for the reader, how much air is being delivered in each case?

    let points = 0;
    const usrs = await sql`select * from usr where country = 'JP'`;
    for (const usr of usrs) {
      points += usr.points;
    }

    const usrs = await sql`select * from usr where country = 'JP'`;
    const [{ points = 0 }] = await sql`
      select sum(points) as points
      from usr
      where id in ${sql(usrs.map((usr) => usr.id))}
    `;

    const [{ points = 0 }] = await sql`
      select sum(points) as points
      from usr
      where country = 'JP'
    `;

2\. Pre-Packaged Dependencies
-----------------------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/ikea-oriented-development/im-1950-flatpack-01-1256x1600.webp"
    caption=""
    alt=`ikea flatpack`
    class="row flex-center"
>}}

If you have a hammer and screwdriver, you can build Ikea furniture. Everything else comes in the box. Nobody wants to hunt for a 6.2mm allen key when what you really need is a bookshelf.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/ikea-oriented-development/ikea-screwdriver-1536x521.webp"
    caption=""
    alt=`Ikea tools`
    class="row flex-center"
>}}

In the computing world, screws are made of plaintext, HTTP, etc. Today’s shells and standard libraries offer ubiquitous screwdrivers like Regex manipulation, HTTP processing, and JSON parsing.

If you can’t bundle allen keys for your hex fasteners, stick to screws. Likewise, if you lack the engineering resources to support multiple SDKs, make damn sure your web API is easy enough to access with `curl`.

My MarioKart 64 cartridge probably won’t inform me that Python2.7 was deprecated. If your program isn’t designed to work 20 years from now, it won’t.

3\. Composable & Disposable
---------------------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/ikea-oriented-development/20-IKEA-KALLAX-Hacks-Your-Home-Needs.webp"
    caption=""
    alt=`kallax variations`
    class="row flex-center"
>}}

> Flat-pack furniture is not meant to last. It has taken me too long to understand that flimsiness is part of its appeal. Because when the door of a cabinet starts to sag off plumb and the laminate is curling off its corner, that means you get to buy another one.
> 
> – [Lionel Shriver](https://www.spectator.co.uk/article/ikea-s-real-genius-making-furniture-disposable)

[Ikea furniture is hackable.](https://www.reddit.com/r/ikeahacks/top)

Hackable things are often (1) composable and (2) disposable.

Composable systems expose extendible interfaces. For example, [Eurorack modular synths](https://en.wikipedia.org/wiki/Eurorack) offer auditory combinatorics (at exorbitant prices).

Disposable goods (i.e. commodities) are useful _because_ they aren’t special. A paper plate can be repurposed as a mask, a canvas, a paint palette, a frisbee, a paper snowflake, etc. Ceramic plates are not very versatile.

Together, composability and disposability encourage experimentation.

SQL is ugly, but there’s a good reason it’s the lingua-franca of tech. People embrace SQL’s blemishes because (1) it’s generally fast and (2) queries are disposable. Plus, whenever you need a new query, you can rifle through your trash to find snippets worth recycling! SQL is easy to cobble, remix, and edit.

To make your software hackable:

*   **Make experimentation effortless.** If tweaking and testing your codebase is a pain, devs will avoid making changes. Nobody wants to wade through spaghetti then wait 40 seconds for recompilation.
*   **Embrace reliable mainstream formats.** Use common interfaces like CSV, webhooks, JSON, and RSS. Products are way more useful when you can plug them into GNU utils, IFTTT, Siri Shortcuts, etc.
*   **Write code that can be replaced.** Writing code is easy, but editing code is hard. Make inputs and outputs extremely clear; everything between is disposable detail. We intuitively call irreplacable code “complicated” or “spaghetti”.
