---
title: "11 Ways to Shave a Yak"
description: "To remove magic from your system, kill the wizards."
summary: "The following is a description of Yak Shaving and a list of 11 topics that will make you shave a yak."
keywords: ['taylor troesh', 'software engineering', 'yak shaving']
date: 2023-06-26T06:52:28.126Z
draft: false
categories: ['reads']
tags: ['reads', 'taylor troesh', 'software engineering', 'yak shaving']
---

The following is a description of Yak Shaving and a list of 11 topics that will make you shave a yak.

https://taylor.town/shave-a-yak

---

> Yak Shaving is the last step of a series of steps that occurs when you find something you need to do. “I want to wax the car today.”  
> “Oops, the hose is still broken from the winter. I’ll need to buy a new one at Home Depot.”  
> “But Home Depot is on the other side of the Tappan Zee bridge and getting there without my EZPass is miserable because of the tolls.”  
> “But, wait! I could borrow my neighbor’s EZPass…”  
> “Bob won’t lend me his EZPass until I return the mooshi pillow my son borrowed, though.”  
> “And we haven’t returned it because some of the stuffing fell out and we need to get some yak hair to restuff it.”  
> And the next thing you know, you’re at the zoo, shaving a yak, all so you can wax your car.
> 
> – [Seth’s Blog](https://seths.blog/2005/03/dont_shave_that/)

1\. Use bespoke components.
---------------------------

Custom components require custom tools. Every screw needs its matching screwdriver, and [uncommon screwdrivers](https://en.wikipedia.org/wiki/List_of_screw_drives) always seem to vanish. If it’s not considered a “commodity”, it’s probably less available than you think.

To maximize maintenance pain, vary your component interfaces as much as possible. Each screw type introduces a new tool that can go missing when you need it most.

2\. Create thirsty systems.
---------------------------

“Thirsty” systems are sustained by fuel.

Consumables necessitate supply-chains; yaks run amok in uncontrolled dependencies.

If you build a thirsty system but don’t control the fuel source, expect interruptions. [Vertical integration](https://en.wikipedia.org/wiki/Vertical_integration) improves predictability, but also increases the compexity under your purview. More complexity brings more yaks, so consider the tradeoffs carefully.

Solid-state alternatives to thirsty systems reduce yak-shaving. Sailboats never run out of fuel.

3\. Spurn redundancy.
---------------------

Pilots don’t need all their engines to fly.

Urgent problems attract yaks. Redundant components increase the frequency of failures but decrease the impact of failures.

uptime = (1 - uptimei)n

Three systems with 90% uptime share a combined uptime of 99.9%.

Remember, identical systems are not fully independent – they share vulnerabilities. [Gros Michel bananas seemed redundant until Panama Disease wiped them out.](https://en.wikipedia.org/wiki/Panama_disease)

4\. Create clever architecture.
-------------------------------

> That Paris’s Pompidou Centre is to close for four years from 2023 for yet more maintenance comes as no surprise. Weeds have long sprouted from its ultra-finicky superstructure, while the job of keeping it scraped free of pigeon poo and painted in the prescribed infrastructural colour palette – red for people, blue for air, yellow for electricity and green for water – rivals the Forth Bridge for unrelenting laboriousness. This latest touch-up, at an anticipated cost of €100 million, follows on from a three-year refurbishment begun in 1997 costing €88 million. A further €19 million project to replace the famous external escalators will also be completed later this year.
> 
> Since it opened in 1977, the Pompidou has cost more to maintain than build, and is about to be off limits to the public for another four years. ‘There were two options,’ France’s culture minister Roselyne Bachelot told Le Figaro. ‘One involved renovating the centre while keeping it open, the other was closing it completely. I chose the second because it should be shorter and a little bit less expensive.’
> 
> – [Outrage: the cost of caring for the Pompidou](https://www.architectural-review.com/essays/outrage/outrage-the-cost-of-caring-for-the-pompidou)

Clever systems produce clever problems.

5\. Embrace moving parts.
-------------------------

Friction guarantees failure. To ensure catastrophe and impossible repairs, make everything spin.

Tablesaws are spinning machines. Fixing motors requires unique tools and skills. Handsaws rely on external power. Because the moving parts of a handsaw are outside the system, they can be easily adapted and maintained.

To make repairs expensive, hide your moving parts behind layers of delicate supporting materials. Every car engine has its own door for a reason.

6\. Entertain superstitions.
----------------------------

Superstitions are superfluous steps glued onto processes.

Yaks are often found in layers of busywork.

To identify superstitions, think like an alien researcher. Probe your systems at each step, asking yourself “why, human, do you do this thing?”

7\. Depend on skilled labor.
----------------------------

Yaks love skilled labor.

Systems with small [bus factors](https://en.wikipedia.org/wiki/Bus_factor) accrue idiosyncrasies, which recursively attract unique problems and special solutions.

With guidance and tooling, some skilled tasks can be reduced to unskilled tasks. To remove magic from your system, kill the wizards.

8\. Nest processes.
-------------------

Yaks roam free in [lists of lists of lists](https://en.wikipedia.org/wiki/List_of_lists_of_lists).

Subprocesses in systems (especially organizations) fail unexpectedly.

Simple, central queues explode in obvious ways; yaks have few places to hide in transparent processes.

9\. Use sophisticated tools.
----------------------------

You need more than a crane to build a tower. You need the crane, plus all its crane-repair tools, plus all the crane-repair-repair tools, and so on. And for each tool, you need somebody who knows how to use it, plus a manager and HR, and so on.

Yaks wait to be shaved at every juncture in a system.

10\. Build on others’ property.
-------------------------------

If you rely on App Store revenues, Apple can demand shaven yaks on whims.

[Lindy’s Law](https://en.wikipedia.org/wiki/Lindy_effect) states that the future life expectancy of an idea is proportional to its current age. If a platform/process/technology was built in the last decade, don’t expect it to be relevant in 20 years.

11\. Save princesses.
---------------------

Maybe Princess Peach should purchase better security.

Not all princesses need saving; sometimes it’s better to pursue a new princess.

Cherish indestructible technology. A [Nokia 3310](https://en.wikipedia.org/wiki/Nokia_3310) rarely beckons adventure.