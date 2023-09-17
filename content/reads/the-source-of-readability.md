---
title: "The Source of Readability"
description: "Readability is more objective than you'd think."
summary: "The following is an article on software source-code readability. It explains why readability isn't just a common agreement between team members, ways to promote readability and provides examples of how things can go wrong if software principles are not applied."
keywords: ['loup vaillant', 'software readability', 'software engineering', 'software principles']
date: 2023-08-14T11:00:52.012Z
draft: false
categories: ['reads']
tags: ['reads', 'loup vaillant', 'software readability', 'software engineering', 'software principles']
---

The following is an article on software source-code readability. It explains why readability isn't just a common agreement between team members, ways to promote readability and provides examples of how things can go wrong if software principles are not applied.

https://loup-vaillant.fr/articles/source-of-readability

---

Readability is often treated as a subjective thing. When someone says code is more readable, what they really mean is _they_ can more easily read it. The straw-man goes, this is all taste and convention, just follow the team’s rules and use the auto-formatter.

There is however, one very objective criterion: _we have a limited working set_.

We humans have little short term memory, and tend to forget things over time. Our screens offers only a small window, and even the smartest IDE can’t give us instant access to everything. It’s easier for us to act upon code that we’ve just read. It’s even easier to act upon code we can _see_ right there on the screen. How much code that is, is fundamentally limited.

Therefore, to efficiently grow and maintain programs, _code that is read together should be written together_.

I like to call this rule “code locality”. It’s a simple rule, it applies pretty much everywhere, and lot of actionable advice can be derived from it. Here’s a list of what I could come up with:

*   Maintain high cohesion and low coupling
*   Write less code
*   Keep your modules deep
*   Avoid repeating yourself
*   Avoid global variables
*   Prefer composition over inheritance
*   Define variables close to their point of use
*   Don’t waste vertical space
*   Consider inlining variables that are used only once
*   Consider inlining functions that are used only once

Nothing new of course. My contribution isn’t novelty, it’s showing how these ideas may be derived from code locality.

Maintain high cohesion and low coupling
---------------------------------------

This one is more a rewording of code locality than an actual guideline.

_High cohesion_ is about making sure all the code in a given module is related, so it forms a coherent whole. In practice this means that understanding parts of the module likely requires understanding most of it. Most such modules tend to have a single purpose, but that’s not the focus here.

_Low coupling_ on the other hand is about minimising dependencies _between_ modules. Understanding how a given module is implemented should require minimum understanding of other modules. Modifying a given module should have minimum impact upon other modules.

Note that “module” here means pretty much any meaningful unit of code. Functions, classes, actual modules, or even components. Also, the bigger the unit, the more important is its independence from other modules. If the thing itself is big, we won’t have much brain space left to understand the surrounding context. The less that context matters the better.

Write less code
---------------

More precisely, keep the code base small. In general, when we can achieve the same functionality with less code, things get better pretty much across the board: fewer bugs, easier maintenance, shorter time to market, even better runtime performance. Now don’t go cheating with Code Golf. Counting source lines of code only works if you honestly observe similar coding conventions.

You might go “duh, of course” on this one, but I noticed I could trivially shave off 30% of most code I come across on the job. Often I can reduce it in half. My record so far was a factor of five, but that was a fluke.

I bet this happens to other people. How do we do it? I believe our main advantage here is _hindsight_. It’s easy when reviewing code to muse about alternative designs, spot a small mistake here and sloppy code there. It’s just hard for authors to edit their own work.

There is however a way to cheat our way into getting it right the first time: instead of designing a (piece of) program once, we can design it two or three times over, compare, and keep the best approach. Nobody has to know about our embarrassing failures. This takes time and effort, but I believe all significant projects deserve it. That said, I understand why in practice most of the code I see is just a rushed first draft: stopping as soon as it “works” is just too damn tempting.

Keep your modules deep
----------------------

Obviously there’s a limit to how small programs can be. In many cases there inevitably comes a point where we cannot hold the entire program in our head, let alone in our short term memory. We _need_ low coupling at some point.

The easiest and most potent way to achieve low coupling in my opinion is to keep your modules (functions, classes, components) _deep_: small interfaces packing significant functionality. The idea here is to give users of the module the biggest benefit for the least learning. This makes sure that when you work on a piece of code, you won’t be forced to understand loads of complicated interfaces.

For instance if you have a class that solves a difficult problem with, say, only 2 methods with no more than 3 arguments each, you’re in good shape. Conversely, there are a number of red flags to watch out for:

*   Functions with many arguments.
*   [Overly complex data structures](https://caseymuratori.com/blog_0025).
*   Small functions.
*   Classes with many functions.
*   Getters and setters.

You may not agree with all of those, especially small functions. Still, small functions are shallower than bigger ones. They’re justified if they’re called often enough, but that’s about it. That guy who said functions should be small, and then smaller than that? Ignore him. Even if small functions are easier to understand _in isolation_, depth is more important to the program as a whole.

Avoid repeating yourself
------------------------

Too much duplication causes two problems: this gives us more code (we want less), and every time we find a bug in one instance we need to fix _all_ instances, wherever they may be. This destroys code locality: duplicated code is code written _apart_ that must be fixed _together_.

_Sometimes_, a little duplication is okay. A small amount can shorten some programs. Some pieces of code that look similar aren’t always related. And in some cases, trying too hard to spot & merge duplicated code can lead to too many indirections, which again hurts code locality.

Mostly though, do avoid repeating yourself.

Avoid global variables
----------------------

Global variables _destroy_ code locality.

Any piece of code that reads a global variable might have to care about _every_ piece of code that writes it. Any piece of code that writes to a global variable might have to make sure it breaks _no_ piece of code that reads it. Every time we touch global mutable state, we need to jump all around the code to make sure it all still works.

A few, carefully used, global variables might be okay, but they have a tendency to spin out of control very quickly: one little global here, an innocent singleton there, and next thing you know you’ve got a tangled mess of dozens of pieces of global mutable state that break the entire system if you look at them funny.

The same goes for any kind of shared mutable state. The wider the sharing, the worse it gets. Local variables in a small functions are mostly harmless. Mutable class members are not too bad if the class is not too big. Synchronising data in a distributed system is a _nightmare_.

Prefer composition over inheritance
-----------------------------------

As a way to leverage and extend existing code, inheritance is unwieldy. Understanding derived classes generally requires constantly glancing at the base class. This back and forth between two files is fundamentally at odds with code locality.

This is not surprising: the actual interface between a base class and its derived classes is fairly big. We not only need to pay attention to the public API, we also need to know how each function interact with any override function, as well as any interaction between member variables and the methods of the two classes. This is much to take in, and a big reason why this is not the way to do code reuse.

The main way to reuse code should be to call functions. Preferably pure ones, though the important point is the lack of implicit data flow. Composition does exactly that.

Define variables close to their point of use
--------------------------------------------

Many programmers like to group declarations at the beginning of the function. In some cases this helps us find them: though we most easily scan around where we are looking at, we can quickly jump to anchor points such as the beginning of a function.

In many cases however this is a habit we picked up from limitations of the languages we use: some, like C89, used to mandate that all declarations be grouped at the beginning of a block. Others, like Python, scope local variables at the function level. This is a pity, because many variables are used only once or twice, and without these limitations could be declared right next to where they are actually used, making them even easier to find.

Also, declaring variables late often allows us to merge declaration and initialisation, thus removing an opportunity to reach an incoherent state. This has little to do with code locality, but it does help some.

Don’t waste vertical space
--------------------------

Ideally we want to cram as much code as we can in a single screen, making it easier to scan for. I’m always annoyed at code like that:

    const char* string_of_enum(enum foo e)
    {
        switch (e) {
        case FOO:
            return "FOO";
    
        case BAR:
            return "BAR";
    
        case BAZ:
            return "BAZ";
    
        default :
            return "default";
        }
    }

When it could have been _this_ instead:

    const char* string_of_enum(enum foo e)
    {
        switch (e) {
        case FOO: return "FOO";
        case BAR: return "BAR";
        case BAZ: return "BAZ";
        default : return "default";
        }
    }

The problem is not that the former is less readable than the latter. It could be if we had 30 cases instead of just 4, but that’s not the point. The problem is that the former makes code _around_ it less readable. Those 8 extra lines mean 8 more lines pushed out of the screen, forcing us to scroll or click to in cases where we could have just looked. _(Also, Maybe one day I’ll stop being a hypocrite and put the opening brace of the function at the end of the line too.)_

Similarly, I sometimes find myself wanting to write something like this (real example from [Monocypher](https://monocypher.org)):

    fe_0  (check);          int z0 = fe_isequal(x      , check);
    fe_1  (check);          int p1 = fe_isequal(quartic, check);
    fe_neg(check, check );  int m1 = fe_isequal(quartic, check);
    fe_neg(check, sqrtm1);  int ms = fe_isequal(quartic, check);

Many coding styles would forbid me to have several instructions per line, in which case the best I can do would look like that:

    fe_0(check);
    int z0 = fe_isequal(x, check);
    
    fe_1(check);
    int p1 = fe_isequal(quartic, check);
    
    fe_neg(check, check );
    int m1 = fe_isequal(quartic, check);
    
    fe_neg(check, sqrtm1);
    int ms = fe_isequal(quartic, check);

One could say no big deal, we waste a couple lines here and there, it’s more important to have a consistent coding style. Personally I have my doubts: codding style issues add up across the entire codebase, enough to have a real effect. the listing above for instance was part of a larger function:

    static int invsqrt(fe isr, const fe x)
    {
        fe t0, t1, t2;
    
        // t0 = x^((p-5)/8)
        // Can be achieved with a simple double & add ladder,
        // but it would be slower.
        fe_sq(t0, x);
        fe_sq(t1,t0);                     fe_sq(t1, t1);    fe_mul(t1, x, t1);
        fe_mul(t0, t0, t1);
        fe_sq(t0, t0);                                      fe_mul(t0, t1, t0);
        fe_sq(t1, t0);  FOR (i, 1,   5) { fe_sq(t1, t1); }  fe_mul(t0, t1, t0);
        fe_sq(t1, t0);  FOR (i, 1,  10) { fe_sq(t1, t1); }  fe_mul(t1, t1, t0);
        fe_sq(t2, t1);  FOR (i, 1,  20) { fe_sq(t2, t2); }  fe_mul(t1, t2, t1);
        fe_sq(t1, t1);  FOR (i, 1,  10) { fe_sq(t1, t1); }  fe_mul(t0, t1, t0);
        fe_sq(t1, t0);  FOR (i, 1,  50) { fe_sq(t1, t1); }  fe_mul(t1, t1, t0);
        fe_sq(t2, t1);  FOR (i, 1, 100) { fe_sq(t2, t2); }  fe_mul(t1, t2, t1);
        fe_sq(t1, t1);  FOR (i, 1,  50) { fe_sq(t1, t1); }  fe_mul(t0, t1, t0);
        fe_sq(t0, t0);  FOR (i, 1,   2) { fe_sq(t0, t0); }  fe_mul(t0, t0, x);
    
        // quartic = x^((p-1)/4)
        i32 *quartic = t1;
        fe_sq (quartic, t0);
        fe_mul(quartic, quartic, x);
    
        i32 *check = t2;
        fe_0  (check);          int z0 = fe_isequal(x      , check);
        fe_1  (check);          int p1 = fe_isequal(quartic, check);
        fe_neg(check, check );  int m1 = fe_isequal(quartic, check);
        fe_neg(check, sqrtm1);  int ms = fe_isequal(quartic, check);
    
        // if quartic == -1 or sqrt(-1)
        // then  isr = x^((p-1)/4) * sqrt(-1)
        // else  isr = x^((p-1)/4)
        fe_mul(isr, t0, sqrtm1);
        fe_ccopy(isr, t0, 1 - (m1 | ms));
    
        WIPE_BUFFER(t0);
        WIPE_BUFFER(t1);
        WIPE_BUFFER(t2);
        return p1 | m1 | z0;
    }

Most auto-formatters are liable to add a _lot_ of lines to this function, for no discernible benefit.

That being said:

*   Don’t use this as an excuse to exceed 160 columns just because you have a 12K triple width monitor. Others don’t, and even then overly long lines have their own problems.
*   Don’t delete every blank line out there. As you can see in my function above, many blank lines provide landmarks that nicely separate different sections of the code. This is not waste.
*   Don’t avoid writing comments you need just because they spend vertical space. You should see the 57-lines comment I wrote just above this function. It’s big for something that can just be called “inverse square root”, but trust me, reviewers need it.

Consider inlining variables that are used only once
---------------------------------------------------

There’s a balance between naming a variable and just using its value. Sometimes the name can help document things, other times the name hardly helps and the additional line of code was for nothing.

Consider inlining functions that are used only once
---------------------------------------------------

The reasoning is the same as variables, only magnified: function declarations often incur significant syntactic overhead, and for technical or cultural reasons rarely occur next to their point of use in most languages. If a function is used only once, inlining it is generally the shortest path to increased code locality.

Doing so systematically will likely result in some functions being very long. This happens most often for straight-line code, which needs to perform a number of steps one after the other. Such functions are okay. The best way to deal with them is to delimit sections inside, each with its own local scope, local variables, and a short comment.

In some cases however the outer function is some intricate high-level algorithm, that readers are liable to spend significant time with. Preserving code locality here means keeping the high-level algorithm close together. The best way to do that is to keep the lower-level code _out_, the exact opposite of what we should do with straight-line code.

Some may think IDE support makes this moot: we can just jump to the definition or have a pop-up displaying the function on mouse hover. But this only works when we didn’t _already_ did that. After two jumps we need to backtrack again, and the relevant code is no longer on screen. We could compensate by having 3 wide monitors with 8 files open at the same time, but this too has its limits, like having to remember which screen displays the code you wanted to look at.

As for one liners that are called only once, just inline them. The small functions guy can take a hike.

Conclusion
----------

As expected from a rule (preserving code locality) that stemmed from a human universal (limited working set), the derived advice is mostly standard and boring. What’s remarkable is how broad that advice can be. This probably makes code locality one of the most important criteria in all of computer programming.

In fact we can probably generalise this to all knowledge working.