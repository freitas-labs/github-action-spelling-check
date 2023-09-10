---
title: "How To Do Anything in TypeScript With Type Guards"
description: "Type guards are conditional checks that allow types to be narrowed from general types to more specific ones. With type guards, we do run-time type checking and ensure that code is safe."
summary: "The following article explains what are type guards in TypeScript, why they are useful for compile time checks and you can use them to improve your codebase robustness."
keywords: ['cam mchenry', 'typescript', 'type guards']
date: 2023-07-20T06:48:02.409Z
draft: false
categories: ['reads']
tags: ['reads', 'cam mchenry', 'typescript', 'type guards']
---

The following article explains what are type guards in TypeScript, why they are useful for compile time checks and you can use them to improve your codebase robustness.

https://camchenry.com/blog/typescript-type-guards

---

Summary ❧ Type guards are conditional checks that allow types to be narrowed from general types to more specific ones. With type guards, we do run-time type checking and ensure that code is safe.

* * *

TypeScript is valuable because it enables us to write safe code. Because when every type in the code is known at compile time, we can compile the code with TypeScript and perform type checking, which ensures that the code will not crash or cause errors.

However, **it is not always possible to know every type at compile time**, such as when accepting arbitrary data from an external API. To check types at run-time or differentiate between different types, we to need narrow the types using a type guard.

[](#what-is-narrowing)What is narrowing?
----------------------------------------

In TypeScript, [narrowing](https://www.typescriptlang.org/docs/handbook/2/narrowing.html) is the process of refining broad types into more narrow types. Narrowing is useful because it allows code to be liberal in the types that it accepts. Then, we can use type guards to narrow the type down to something more useful.

These are some common examples of narrowing:

*   `unknown` or `any` to `string`
*   `string | object | number` to `string`
*   `number | null | undefined` to `number`
*   `string` to a custom type like `NonEmptyString`

[](#what-is-a-type-guard)What is a type guard?
----------------------------------------------

A type guard is a kind of conditional check that narrows a type. Type guards allow for run-time type checking by using expressions to see if a value is of a certain type or not.

So, what does a type guard look like? These are all examples of type guards:

*   `typeof value === 'string'`
*   `'name' in data`
*   `value instanceof MouseEvent`
*   `!value`
