---
title: "Using Typescript without compilation - DEV Community"
description: 'Over the past couple of days, an article about the next major version of Svelte blew up on twitter,... Tagged with typescript, jsdoc.'
summary: "The following is a discussing on using Typescript (TS) type checking capabilities directly in JavaScript (JS) using JSDoc. The author has a very strong opinion that you can develop your entire project in JS and still get type compile features, just by creating .d.ts files for types and combining them with JSDoc."
keywords: ['pascal schilp', 'typescript', 'jsdoc', 'javascript']
date: 2023-04-02T08:42:17.883Z
draft: false
categories: ['reads']
tags: ['reads', 'pascal schilp', 'typescript', 'jsdoc', 'javascript']
---

The following is a discussing on using Typescript (TS) type checking capabilities directly in JavaScript (JS) using JSDoc. The author has a very strong opinion that you can develop your entire project in JS and still get type compile features, just by creating .d.ts files for types and combining them with JSDoc. 

The thing is: Typescript is not just about type checking. There are a ton of builtin algebraic data types, functions and other language constructors, that allow you to write more correct code by following a functional programming scheme. The author argues that you can do that in a .d.ts file, but at the end, you are still using Typescript!

https://dev.to/thepassle/using-typescript-without-compilation-3ko4

---

Using Typescript without compilation
====================================

Over the past couple of days, an [article](https://thenewstack.io/rich-harris-talks-sveltekit-and-whats-next-for-svelte/) about the next major version of Svelte blew up on twitter, and caused lots of discussion. The article states:

> The team is switching the underlying code from TypeScript to JavaScript.

Which, to be fair, is a bit misleading. Technically, the article is not wrong, the team _is_ switching the underlying code from TypeScript to JavaScript. However, they're not dropping typechecking from their code. They're just moving from writing TypeScript source code directly, to writing JavaScript source code using JSDoc in combination with `.d.ts` files. This allows them to:

*   Write typesafe code, with TypeScript doing the typechecking
*   Write and ship plain JavaScript
*   Skip TypeScript's compilation step
*   Still provide types for their end users

What's interesting about this discussion is that a lot of people found this to be _very_ upsetting, and twitter blew up with discussion about typechecking. We saw the exact same thing happen when the ESLint team [announced](https://github.com/eslint/eslint/discussions/16557) they were not interested in using TypeScript for their rewrite of ESLint, but instead were choosing the same approach the Svelte team is going for; plain JavaScript with JSDoc for typechecking. In these twitter discussions it has become very clear that lots of people, even some of those who call themselves "educators", don't understand how capable JSDoc actually is and will unfortunately just spread blatant untruths about this way of working.

It should be noted here that neither of those teams are disregarding typesafety. They just chose a different way of utilizing typesafety, without having to use a compile step to achieve this. This is a _preference_. There is no right or wrong answer; you get typesafety by using TypeScript in either approach. This discussion and these decisions are not about _not_ using TypeScript. And unless you're directly working on, or contributing to, either of those projects, these decisions do not involve you. It is, frankly stated, none of your business. If _you_ want to use TypeScript with a compilation step; go for it! There's no need for animosity. These projects still utilize TypeScript to ensure typesafety in their code, and can still ship types to their end users. In this blog we'll take a look at the benefits of skipping TypeScripts compilation step, clarify some of the myths I've seen spread around, and emphasize the importance of understanding and being respectful of different preferences and methodologies.

> In this blog, I won't go into detail on how to setup your project to enable typechecking with JSDoc, there are many great resources on that [like this one here](https://medium.com/@trukrs/type-safe-javascript-with-jsdoc-7a2a63209b76)

Before we dive in, I'd like to reiterate one more time that using types via JSDoc allows people to _still_ write typesafe JavaScript, by using TypeScript's typechecker. It just skips the compilation step. You'll also be able to still use `.d.ts` files when necessary (but you don't have to!), and provide types for your users. And yes, this approach _is still using TypeScript_.

[](#benefits-of-skipping-a-compilation-step)Benefits of skipping a compilation step
-----------------------------------------------------------------------------------

Compilation or transpilation steps in the JavaScript tooling ecosystem are often a bit of a necessary evil, like for example transpiling JSX, or in this case TypeScript code. They're often not as fast as we'd like them to be, and often take a bit of fiddling with configuration (although it should be noted that lots of tooling has improved in recent years) to get your setup working just fine. Not only for building your projects for production, but also having everything setup correctly for your local development environment, as well as your test runner. While compilation or transpilation offers conveniences (writing JSX source code, instead of React.createElement calls manually, or writing types in your source code directly), some people find these compilation steps to be undesirable, and prefer to skip them where possible.

Skipping a compilation step, in the context of TypeScript usage, has several benefits. It makes your code runtime agnostic; your code will run in Node, Deno, the browser, Worker-like environments, etc. Some of these environments, like Deno, support running TypeScript natively (which has a whole other set of worrisome implications\*). Some of those environments, like the browser, don't (not until the [types as comments proposal](https://tc39.es/proposal-type-annotations/) lands anyway). This may or may not be an issue for you depending on what you are building, but again, some people find this to be preferable.

> *   It has been pointed out to me that Deno will now run with `--no-check` by default, which mitigates some of it's issue. However, the issue still exists when using `--check`.

If your code is runtime agnostic, it also allows you to easily copy and paste snippets of code into REPLs. Shipping native JavaScript also simplifies debugging, consider the following example: You've shipped your package as native JavaScript. Somebody installs your package and discovers a bug. They can just go into their node\_modules and easily tweak some code to try to fix the bug, without having to deal with transpiled code, source maps, etc.

An added benefit of using JSDoc that I've personally found (this is a _personal preference_), is that the barrier to documenting my code is much lower as opposed to TypeScript. Consider the following example:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/using-typescript-without-compilation/ugg7861yxw7jk2va5my8.gif"
    caption=""
    alt=`A simple  raw add endraw  function is created, when typing  raw /** endraw  the code editor autocompletes the scaffolding for the types, and documentation is added to the function`
    class="row flex-center"
>}}

> Admittedly, a function named `add` probably doesn't require a whole lot of documentation, but for illustration purposes.

When I type `/**<ENTER>` on my keyboard, my editor will already scaffold the JSDoc comment for me, I just have to write my types. Note that the return type can be omitted, because TypeScript will still correctly infer the return type from the code. While I already have the JSDoc comment here anyway, I might as well add some documentation for it! Easypeasy.

[](#myths)Myths
---------------

### [](#using-jsdoc-is-unmaintainable)Using JSDoc is unmaintainable

Some people on twitter have expressed concerns about the maintainability of using JSDoc for types, and claim that using JSDoc is only viable for small projects. As someone who maintains many projects at work (some of which are _large_) that utilize types via JSDoc, I can tell you this is simply not true. It can be true that if you're only using JSDoc to declare and consume your types, this can sometimes become a bit unwieldy. However, to avoid this, you can combine JSDoc with `.d.ts` files. Declare your types in a `.d.ts` file:

`./types.d.ts`:  

```typescript
export interface User {
  username: string,
  age: number
}
```

Enter fullscreen mode Exit fullscreen mode

And import it in your source code:  
`./my-function.js`:  

```typescript
    /**
     * @typedef {import('./types').User} User
     */
    
    /**
     * @param {User}
     */
    function foo(user) {}
```

Enter fullscreen mode Exit fullscreen mode

### [](#no-type-inference-or-intellisense)No type inference or intellisense

Some people seem to think that using JSDoc somehow will cause you to lose type inference. As already demonstrated earlier above, this is also not true. Consider the following example:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/using-typescript-without-compilation/bybdtzbik27pa142yq58.png"
    caption=""
    alt=`The return type of the  raw add endraw  function is being inferred correctly`
    class="row flex-center"
>}}

The reason for this claim seems to be that people don't understand that when you're using JSDoc for types, _you're still using typescript_. TypeScript is _still_ doing the _typechecking_.

### [](#manually-writing-types-is-bothersome)Manually writing types is bothersome

Some people claimed that writing types manually is bothersome. I can only assume that this is a case of preference, or perhaps its not clear to those people that you can still `.d.ts` files. Some people will prefer `example B` over `example A`. This is fine. Both can be used when using JSDoc for types.

`example A`:  

    /**
     * @typedef {Object} User
     * @property {string} username
     * @property {number} age
     */
    

Enter fullscreen mode Exit fullscreen mode

`example B`:  

```typescript
export interface User {
  username: string,
  age: number
}
```

Enter fullscreen mode Exit fullscreen mode

### [](#but-that-still-uses-typescript)But that still uses TypeScript!

Yes, this is the point.

[](#in-conclusion)In conclusion
-------------------------------

Finally, and I'm repeating myself here, using TypeScript without compiling your code is a _preference_. There is no right or wrong answer and I challenge anyone who is skeptical of this approach to be a little bit more open minded and give it a try some time when you're starting a new project, you might find it's actually a quite nice approach of utilizing types. And if you end up not liking it, that's fine too!