---
title: "Kotlin Equality"
description: "Why do we have two equality checks?"
summary: "Short, but interesting read. I've been using Kotlin for some time and didn't know it also had the `===` equals operator, which shares the same syntax as JavaScript, but have meanings completely different."
keywords: ['kotlinbits', 'kotlin', 'equality']
date: 2023-06-19T18:28:56.119Z
draft: false
categories: ['reads']
tags: ['reads', 'kotlinbits', 'kotlin', 'equality']
---

Short, but interesting read. I've been using Kotlin for some time and didn't know it also had the `===` equals operator, which shares the same syntax as JavaScript, but have completely different meanings (strict equality (JS) vs referential equality (Kt)).

tl;dr: `===` in Kotlin compares objects by reference


### _Why do we have two equality checks?_[​](#why-do-we-have-two-equality-checks "Direct link to why-do-we-have-two-equality-checks")

Because sometimes you want to check more than if the two object have the same value.

> \== checks if two objects have the same value

> \=== checks if two objects have the same reference

|Type|Check|Name|
|----|-----|----|
| `==` | same **value** | `structural`|
| `===` | same **reference** | `referential` |
 
### What do you mean?[​](#what-do-you-mean "Direct link to What do you mean?")

Let's use an example

```kotlin
data class Author(val name: String = "Yoda")
>
val first = Author()
val second = Author()

println(first == second)  // structural equality check

true
```

> With structural equality it checks if the values in the two classes are the same, in this case it checks if second is of type `Author` and if `second.name` is the same with `first.name`. That's what we mean when we say it checks they have the same `value`

### _How does it work_?[​](#how-does-it-work "Direct link to how-does-it-work")

> When we call `==` for any two objects it is translated to `first?.equals(second) ?: (second === null)` under the hood

*   it checks if `first` is null
*   if `first` **IS null**, it checks if `second` also references null
*   if `first` **IS NOT null** it checks if all the values in `first` are the same with all the values in `second`

### _What about reference checks?_[​](#what-about-reference-checks "Direct link to what-about-reference-checks")

Okay, let's go back to our example

```kotlin
data class Author(val name: String = "Yoda")
>
val first = Author()
val second = Author()
>
println(first === second)  // referential equality check

false
```

> A referential check validates if two variables point to the same object in memory. In the case above `first` and `second` point to different objects so it evaluates to `false`.

What if they point to the same object?

```kotlin
data class Author(val name: String = "Yoda")

val first = Author()
val second = first
>
println(first === second)  // referential equality check
>
true
```

> In this case, `first` and `second` point to the same object in memory, if the `name` property changes for the value both first and second will be updated. And this is what we mean when we say it checks the **_reference_** of two objects.

### _Anything else I should know_ ?[​](#anything-else-i-should-know- "Direct link to anything-else-i-should-know-")

Structural equality checks work different with data classes.