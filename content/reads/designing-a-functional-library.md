---
title: "Designing a Functional Library"
description: "I am very happy to announce that my book on functional programming in Kotlin is now complete and will be available in print within a few weeks (see the link at the end). While writing it, I…"
summary: "The following article provides the basics of thinking in a functional way, by designing an implementing a templating library from scratch, in Kotlin."
keywords: ['uberto barbini', 'functional programming', 'currying', 'functions', 'kotlin', 'template']
date: 2023-09-07T07:14:38.873Z
draft: false
categories: ['reads']
tags: ['reads', 'uberto barbini', 'functional programming', 'currying', 'functions', 'kotlin', 'template']
---

The following article provides the basics of thinking in a functional way, by designing an implementing a template library from scratch, in Kotlin.

https://medium.com/pragmatic-programmers/designing-a-functional-library-4d6b94a4449a/

---

The main goal of the library is to solve a specific issue, but I want to build it in a way that it can be reused entirely or in part in other projects.

First I will present the problem, followed by a detailed walkthrough of the solution that highlights the pros and cons of each design choice.

Finally, I’ll share my thoughts on the pros and cons of developing your own library and when it’s preferable to adopt an existing one.

Defining the Problem
====================

Let’s start defining the problem we want to solve. Well, to be precise, the problem that _I_ want to solve.

My use case is to add the capability to generate a simple email with a list of tasks that are due soon for a Kotlin application. More generally, I need a function that can generate a text using a template and replacing some variables with specific values from the application.

It could also be used to generate simple HTML pages or any other text that need to be customized. It need to be something simple, without macros, script support, sub-templates and the other sophisticated features typical of a full template engine like [Freemarker](https://freemarker.apache.org/) or [Thymeleaf](https://www.thymeleaf.org/).

On the other side, it has to be compact (few lines of code), reasonably fast and easy to use. And I want to be free to reuse it in more than a project, so the best way to ensure all these requirements is to design it from the ground up in a functional way. What I mean with “functional way”? The short version is that it should take some inputs and returning me the generated text, in a totally stateless way. For the long version see my previous post [From Objects to Functions](https://medium.com/pragmatic-programmers/from-objects-to-functions-c317f857bcea).

In this post, I’ll share how I approach the problem of writing a library following the functional programming principles.

But firstly, I want to clear up one thing: I’ve chosen Functional Programming and the Test-Driven Development approach because they work best for me, enhancing my productivity. This isn’t about some programming-golf with artificial challenges to show off my skills.

No matter what your views are on this approach, it’s important to note that this is the same strategy I apply daily in my professional work.

Writing an Acceptance Test
==========================

As first thing, let’s start writing an acceptance test to define roughly what are our requirements:

```kotlin
val template = """  
    Dear {title} {surname},  
    we would like to bring to your attention these task due soon:  
    {tasks}  {id} - {taskname} which is due by {due}{/tasks}  
    Thank you very much {name}.  
""".trimIndent() //the text template  
  
val tags = Tags(???) //tags to be replaced like "title"= "Mr"...  
  
val text = renderTemplate(template, tags) //the actual magic  
  
val expected = """  
    Dear Mr Barbini,  
    we would like to bring to your attention these task due soon:  
      1 - buy the paint which is due by today  
      2 - paint the wall which is due by tomorrow  
    Thank you very much Uberto.  
""".trimIndent()  
  
expectThat(text).isEqualTo(expected) //test the result
```

When I start to code a new thing, I really like to start with an acceptance test. In this way, I can get an idea of how clearly I understand the requirements and how much work would be needed. The idea is that when the initial test pass, our library will be more or less finished.

I‘m using [Strikt](https://strikt.io/) and [Junit](https://junit.org/junit5/) as test libraries — this is only because I know them well — you can use [Kotest](https://kotest.io/) or other libraries.

Writing this test already helped me to define the problem more clearly: the parts to be substituted in the template are delimited by brackets. It’s a completely arbitrary choice; we could have used a different marker like `#` or `%`, as long as the result is clear, but my preference is for brackets.

The second important point is that we must also render a collection of tasks, so we need a way to define a piece of text that can be repeated for each element of the collection. In this case, I adopted the solution of having a bracket slash to delimit the text that will be repeated. In the example, this is the `{tasks}…{/tasks}` part.

As for the usage, the critical function is `renderTemplate()` — it’s taking two parameters. Why two? Well, we are still not completely sure but clearly we have to pass the text template as input, and we need to pass the values to use in the substitutions. We don’t know yet exactly what kind of type this second parameter is, but we can call it `Tags` since it represents the tags in the template.

**Thinking in Morphisms**
=========================

Ok, now we have the big picture, what next? The golden rule of functional designing is to concentrate not on the data per se but on their transformations, this is what I call **_thinking in morphisms_**.

So to visualize the transformations, I often draw a diagram with arrows that go from a type to another type (primitive or a data class). But arrows can also start or end to other arrows. Each arrow represent a function. I start from the higher level function and then trying to break it down as much as possible in a composition of simpler arrows.

But it’s not necessary to draw a diagram, we can also break a function into smaller functions by looking directly at the code.

So let’s look at our function — `renderTemplate()`— which is our starting point. It takes two parameters and its type in Kotlin can be expressed as:

`renderTemplate: (String, Tags) -> String `

Which is equivalent to the Java type:

`BiFunction<String, Tags, String> renderTemplate`

However, as general rule, it's better if each function takes just one parameter. Why? Because functions with a single parameter are simpler to compose, making them more reusable.

Refactoring
===========

So, let’s refactor our function to accept only one parameter.

> ✏️ **Takeaway 1**: It’s easier to compose pure functions with only one parameter.

How to proceed? Generally speaking to reduce the number of parameters of a function we have two choices:

1.  **Aggregate.** We create a new product type (a tuple or a data class) that keeps all the parameters together.
2.  **Partial application.** We process one parameter and we return a new function that will take care of the rest. (See [my post about currying](https://medium.com/proandroiddev/kotlin-pearls-3-its-an-object-it-s-a-function-it-s-an-invokable-bc4bfed2e63f).)

Considering that there are two possible ways of partial application we have three possible signatures for `renderTemplate` :

```kotlin
data class TemplateWithTags(val template: String, val tags: Tags)  
  
fun renderTemplate1(val template: TemplateWithTags): String //join 2 params  
fun renderTemplate2(val template: String): (Tags) -> String //apply template first  
fun renderTemplate3(val tags: Tags): String -> String //apply tags first
```

There is no right or wrong here, the best solution depends on what we need to do.

I would consider the first signature if the templates and the tags came from the same source so we can pass them together all the way. But this probably won’t be our case: templates will be written in advance and likely stored as configurations, while tags will come from user data in real time.

The third case would be the best fit if we needed to generate many texts from the same tags, keeping the user data and changing the template every time.

Finally, the second case would make most sense if we thought we could generate many texts from the same template, changing the tags every time. That’s because we can keep the intermediate function and reuse it with different tags.

Since I need to generate a lot of emails from a single template customized for each user, the second signature is probably the best choice. Of course, if we discover problems later on, we can always come back and take another path. If you have other use cases in mind, it could be that a different approach would be more suitable.

Defining Types
==============

This new function then turns tags into the final text. But here’s the tricky bit: it’s hard to tell the difference between the starting string and the ending one.

So, let’s make things more explicit. We can create specific types for all the things our functions use, especially when they have special rules or hidden requirements.

In our situation, the final text is just a regular string of characters. But the input needs to be a proper template. So we can define a `Template` type. Not only does this make things clearer, but it also lets us check right at the start if our template is valid.

> ✏️ **Takeaway 2:** It’s better to name all our types rather than using primitive types.

We can now start building the types we need for our program.

A`Template` is a piece of text that contains tags that we need to replace. Imagine a `Template`as a special cover wrapped around a text.

Next, we need to understand the second thing — the `Tags`. These `Tags`are like placeholders in our template (they’re the parts inside the brackets) that link to a value we can swap with a string.

So, we have a function that takes the tag name and returns a value for that tag, if it exists. But what if it cannot? What if we have a tag in our template but we forgot to give it a value to replace it with? The simplest solution is to just return a null value in that case.

So, this is how our types look:

```kotlin
data class Template(val text: String)  
fun String.asTemplate() = Template(this) //utility ext fun  
  
data class TagName(val value: String)  
fun String.asTagName() = TagName("{$this}") //adding brackets here  
  
typealias Tags = (TagName) -> String?
```

Just a quick thought. It might be tempting to use a map for `Tags`, something like `Map<TagName, String>`. However, let’s resist this temptation and depend only on what we really need. A `Map` interface comes with a bunch of other methods that we don't necessarily need. While using it here wouldn't be _wrong_, we'd be giving up some flexibility. By keeping our signatures as minimal as possible, we ensure our library will be more flexible and easier to reuse.

> ✏️ **Takeaway 3:** Let’s go minimal. Our library should depend on as few other types as possible.

Writing the Test Case
=====================

How to progress? We could definitely implement it as a function that returns another function, the technical name is Higher-Order function. Like this:

```kotlin
typealias Renderer = (Tags) -> String  
  
fun buildRenderer(template: Template): Renderer = { TODO() }
```

Alternatively, we could use an [invokable class](https://proandroiddev.com/kotlin-pearls-3-its-an-object-it-s-a-function-it-s-an-invokable-bc4bfed2e63f), which is often handier in Kotlin when you’re passing it around. The trick here is to create a class that inherits from a function type:

```kotlin
class RenderTemplate(val template: Template): Renderer {  
  
   override fun invoke(tags: Tags): String = TODO()   
}
```

We can now write our test simple case to replace simple strings:

```kotlin
class TemplateTests {  
  
    @Test  
    fun \`replace simple strings\`() {  
        val fullNameTemplate = """{title} {surname}""".asTemplate()  
  
        val renderer = RenderTemplate(fullNameTemplate)  
  
        val tags: Tags = { x ->  
            when (x) {  
                "{title}".asTagName() -> "Mr"  
                "{surname}".asTagName() -> "Barbini"  
                else -> null  
            }  
        }  
  
        val text = renderer(tags)  
  
        val expected = "Mr Barbini"  
  
        expectThat(text.value).isEqualTo(expected)  
    }  
}
```

To get that test passing, we’ll need to add in the actual functionality.

The simplest solution? Use a regular expression, or regex for short, which replaces everything inside the curly brackets with a call to the replacement function. You might need to tweak the actual regex if you’re not too familiar with them, but if you’re using tests, it shouldn’t be too tough to find a good solution:

`val tagRegex = """\\{(.\*?)}""".toRegex()`

So the complete code of our invokable class would be:

```kotlin
class RenderTemplate(val template: Template): Renderer {  
  
    val tagRegex = """\\{(.\*?)}""".toRegex()  
  
    override fun invoke(tags: Tags): Text =  
        tagRegex.replace(template.text){  
            mr -> tags(mr.value).orEmpty()  
        }  
}
```

> ✏️ **Takeaway 4:** Invokable classes offer a Kotlin idiomatic solution for curried functions.

Managing Errors
===============

Let’s also write a test case to handle the scenario where a tag isn’t available for replacement:

```kotlin
@Test  
fun \`missing replacement tag\`() {  
    val fullNameTemplate = """{title} {surname}""".asTemplate()  
  
    val renderer = RenderTemplate(fullNameTemplate)  
  
    val tags: Tags = { x ->  
        when (x) {  
            "title".asTagName() -> "Mr"  
            else -> null  
        }  
    }  
  
    val text = renderer(tags)  
  
    val expected = "Mr "  
  
    expectThat(text).isEqualTo(expected)  
}
```

This test case will ensure that if a replacement tag isn’t provided, the template won’t retain the original tag in the final text.

Note that while there could be more effective strategies to manage errors, we are currently happy with merely removing any unmatched tags from the final output. What’s really important is to avoid relying on exceptions to handle common scenarios like a missing tag.

Exceptions can become a significant obstacle to code reuse as they disrupt the program’s flow in ways that are hard to guess.

> ✏️ **Takeaway 5**: Avoid handling expected errors with exceptions.

You can continue with the [Part II of this post](https://medium.com/pragmatic-programmers/designing-a-functional-library-3cd7dbbea082), where we will discuss how to design and implement tags to generate elements of a list in our templates.