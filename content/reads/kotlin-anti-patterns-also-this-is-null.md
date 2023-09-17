---
title: "Kotlin Anti-Patterns – Also this is Null | Blundell"
description: "Kotlin is a young language, and with that comes many untrodden paths and unknown gotchas. Let's explore one of these anti-patterns, for the sake of the article I've called it \"Also this is null\"."
summary: "The following article explains why null operators in Kotlin are an anti-pattern."
keywords: ['blundell', 'kotlin', 'null', 'anti-pattern']
date: 2023-09-06T06:45:04.728Z
draft: false
categories: ['reads']
tags: ['reads', 'blundell', 'kotlin', 'null', 'anti-pattern']
---

The following article explains why null operators in Kotlin are an anti-pattern.

https://blog.blundellapps.co.uk/kotlin-anti-patterns-also-this-is-null/

---

Kotlin is a young language, and with that comes many untrodden paths and unknown gotchas. Let’s explore one of these anti-patterns, for the sake of the article I’ve called it “Also this is null”.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/brazilian-reptile/fuschia.webp"
    caption="Kotlin Anti-Patterns – Also this is Null"
    alt=`Kotlin Anti-Patterns – Also this is Null`
    class="row flex-center"
>}}

Kotlin is an awesome language, it has a succinct powerful syntax and takes many lessons from the past 20 years of programming paradigms and languages including Java to come up with a nice to use language. However Kotlin is the newcomer, and with that comes many untrodden paths and unknown gotchas. Let’s explore one of these anti-patterns, for the sake of the article I’ve called it “Also this is null”.

[“Null, the billion dollar mistake”](https://web.archive.org/web/20220625050734/https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare), Tony Hoare explains how back in 1965 he introduced the null reference and how he wished he hadn’t. I think everyone soon learns how the null idiom can be a bane to your code, the authors of Kotlin were also wise to this, creating the language idioms so that you have to go out of your way to create variables that have the potential for being null, unfortunately, it is still possible.

As an example: You are wanting to act upon a variable, the nullability of the variable is under question, so you need to check before acting on it. In java you would:

```kotlin
if (foo != null) {
   foo.helloWorld();
}
```

Although this is a code smell of mutability (i.e. that variable `foo` has multiple states, _null or not null_). It is a legitimate code block and the explicitness here is stating it can be null and conditionally blocking on that.

In Kotlin we have some new constructs not known to Java.

The safe calls operator looks like this `?.` it allows for a method to be called on a variable if the variable is not null, otherwise the statement returns null.

```kotlin
val b: String? = null
println(b?.length) // Prints “null”
```

The also block `.also{}`, calls the specified function block with this value as its argument and returns this value. Allowing you to operate on a variable repeatedly with less boilerplate.

```kotlin
repository.also { // it: Repository
  it.something()
  it.someElseOnRepository()
  it.perhapsAThird()
}
```

The anti-pattern we are exploring here is _“Also this is null”_ and this is what it looks like in two forms, method referenced and parameter use:

```kotlin
foo?.also { //it: Foo
    it.helloWorld()
}

foo?.also { //it: Foo
    helloWorld(it)
}
```

I’ve seen this used in a few _‘hand me down’_ projects as a way to avoid null checks, to allow access to the variable if it is not null, and do nothing if it is null.

I wanted to write a positive point for this small example above, using this coding style, however without changing the example to do a lot more inside of the also block, I cannot talk positively about it. ( To be clear `.also{` that makes use of `it` multiple times – can be a good use of the language feature!)

_This is a null check in disguise_. The code is checking the nullability of the variable under question and then acting on it. It’s a null check through and through, and yet it doesn’t have a similar resemblance (_therefore you cannot at a glance fall back on your learnt knowledge_). In my opinion, this is bad.

Another negative here is the variable name context switch, using the `also` block means your variable name internally is `it` (_yes you can change the name, if you want, adding more code/effort_). This name change is a micro-context switch, [yes the scope is small](https://web.archive.org/web/20220625050734/https://softwareengineering.stackexchange.com/a/176590/34583) but context switching like this, _when it can be avoided_ is adding unnecessary [cognitive load](https://web.archive.org/web/20220625050734/https://chrismm.com/blog/writing-good-code-reduce-the-cognitive-load/) to reading the code.

With this code block not having a resemblance to past learnt code patterns, it is hiding the potential to spot it as a typical code smell. If it was recognised as the _null check code smell_, you start to think of potential combative measures such as _preferring the positive_ or _quick return statements_.

Recommended ways to write a method referenced or parameter null object, if you have to:

`foo?.helloWorld()`

Allowing you to execute the method if the reference isn’t null, but not convoluting the approach with a block statement.

`helloWorld(foo!!)`

You can be very explicit about nulls, the above converts `foo` to a non-null type and throws an exception if the value is null.

Further, don’t be scared of being explicit and highlighting the smell in the code, the below is slightly different to the use of `!!` in that `!!` will cause an exception and stop the code executing whereas the below stops a block executing and continues the rest of the program, thus the former doesn’t ever expect null where the latter does. This is still compiling Kotlin (_highlighting nulls, until you refactor away that mutability of course_):

```kotlin
if(foo != null) {
    helloWorld(foo)
}
```

In conclusion, avoid the _also this is null_ pattern, call it out when you find it and either prefer immutability or refactor to an explicit null check. The aim of Kotlin is to avoid mutability and null objects, sometimes though they are a necessary evil.

The meta-learning here is to remember that a new possible way to do something is not always better, don’t do it _just because you can_, lean on past experience (your own or others) whenever possible.