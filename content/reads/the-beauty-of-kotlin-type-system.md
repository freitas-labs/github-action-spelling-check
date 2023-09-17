---
title: "The beauty of Kotlin type system"
description: "How type system makes Kotlin so flexible, safe, and intuitive."
summary: "The following articles does an in-depth description of what is Kotlin type system, how it works, and why it's design promotes a seamless, fast developer experience."
keywords: ['kotlin academy', 'kotlin', 'type system']
date: 2023-07-10T07:15:04.086Z
draft: false
categories: ['reads']
tags: ['reads', 'kotlin academy', 'kotlin', 'type system']
---

The following articles does an in-depth description of what is Kotlin type system, how it works, and why it's design promotes a seamless, fast developer experience.

https://kt.academy/article/kfde-type_system

---

> This is a chapter from the book [Kotlin Essentials](https://kt.academy/book/kotlin_essentials). You can find it on [LeanPub](https://leanpub.com/kotlin_developers).

The Kotlin type system is amazingly designed. Many features that look like special cases are just a natural consequence of how the type system is designed. For instance, thanks to the type system, in the example below the type of `surname` is `String`, the type of `age` is `Int`, and we can use `return` and `throw` on the right side of the Elvis operator.

```kotlin
fun processPerson(person: Person?) {
    val name = person?.name ?: "unknown"

    val surname = person?.surname ?: return

    val age = person?.age
        ?: throw Error("Person must have age")

    // ...
}
```

The typing system also gives us very convenient nullability support, smart type inference, and much more. In this chapter, we will reveal a lot of Kotlin magic. I always love talking about this in my workshops because I see the stunning beauty of how Kotlin’s type system is so well designed that all these pieces fit perfectly together and give us a great programming experience. I find this topic fascinating, but I will also try to add some useful hints that show where this knowledge can be useful in practice. I hope you will enjoy discovering it as much as I did.

### What is a type?

Before we start talking about the type system, we should first explain what a type is. Do you know the answer? Think about it for a moment.

Types are commonly confused with classes, but these two terms represent totally different concepts. Take a look at the example below. You can see `User` used four times. Can you tell me which usages are classes, which are types, and which are something else?

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_type_vs_class_question.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

After the `class` keyword, you define a class name. A class is a template for objects that defines a set of properties and methods. When we call a constructor, we create an object. Types are used here to specify what kind of objects we expect to have in the variables[1](#definition-1).

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_type_vs_class.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

### Why do we have types?

Let's do a thought experiment for a moment. Kotlin is a statically typed language, so all variables and functions must be typed. If we do not specify their types explicitly, they will be inferred. But let's take a step back and imagine that you are a language designer who is deciding what Kotlin should look like. It is possible to drop all these requirements and eliminate all types completely. The compiler does not really need them[2](#definition-2). It has classes that define how objects should be created, and it has objects that are used during execution. What do we lose if we get rid of types? Mostly safety and developers' convenience.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_type_vs_class_crossed.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

It is worth mentioning that many languages do support classes and objects but not types. Among them, there is JavaScript[6](#definition-6) and (not long ago) Python - two of the most popular languages in the world[3](#definition-3). However, types do offer us value, which is why in the JavaScript community more and more people use TypeScript (which is basically JavaScript plus types), and Python has introduced support for types.

So why do we have types? They are mainly for us, developers. A type tells us what methods or properties we can use on an object. A type tells us what kind of value can be used as an argument. Types prevent the use of incorrect objects, methods, or properties. They give us safety, and suggestions are provided by the IDE. The compiler also benefits from types as they are used to better optimize our code or to decide which function should be chosen when its name is overloaded. Still, it is developers who are the most important beneficent of types.

So what is a type? **It can be considered as a set of things we can do with an object**. Typically, it is a set of methods and properties.

### The relation between classes and types

We say that classes generate types. Think of the class `User`. It generates two types. Can you name them both? One is `User`, but the second is not `Any` (`Any` is already in the type hierarchy). The second new type generated by the class `User` is `User?`. Yes, the nullable variant is a separate type.

There are classes that generate many more types: generic classes. The `Box<T>` class theoretically generates an infinite number of types.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_type_class_relation.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

### Class vs type in practice

This discussion might sound very theoretical, but it already has some practical implications. Note that classes cannot be nullable, but types can. Consider the initial example, where I asked you to point out where `User` is a type. Only in positions that represent types can you use `User?` instead of `User`.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_type_vs_class_nullable.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

Member functions are defined on classes, so their receiver cannot be nullable or have type arguments[4](#definition-4). Extension functions are defined on types, so they can be nullable or defined on a concrete generic type. Consider the `sum` function,, which is an extension of `Iterable<Int>`, or the `isNullOrBlank` function, which is an extension of `String?`.

```kotlin
fun Iterable<Int>.sum(): Int {
    var sum: Int = 0
    for (element in this) {
        sum += element
    }
    return sum
}

@OptIn(ExperimentalContracts::class)
inline fun CharSequence?.isNullOrBlank(): Boolean {
    contract {
        returns(false) implies (this@isNullOrBlank != null)
    }

    return this == null || this.isBlank()
}
```

### The relationship between types

Let's say that we have a class `Dog` and its superclass `Animal`.

```kotlin
open class Animal
class Dog : Animal()
```

Wherever an `Animal` type is expected, you can use a `Dog`, but not the other way around.

```kotlin
fun petAnimal(animal: Animal) {}
fun petDog(dog: Dog) {}

fun main() {
    val dog: Dog = Dog()
    val dogAnimal: Animal = dog // works
    petAnimal(dog) // works
    val animal: Animal = Animal()
    val animalDog: Dog = animal // compilation error
    petDog(animal) // compilation error
}
```

Why? Because there is a concrete relationship between these types: `Dog` is a subtype of `Animal`. By rule, when A is a subtype of B, we can use A where B is expected. We might also say that `Animal` is a supertype of `Dog`, and a subtype can be used where a supertype is expected.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_A_B.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

There is also a relationship between nullable and non-nullable types. A non-nullable can be used wherever a nullable is expected.

```kotlin
fun petDogIfPresent(dog: Dog?) {}
fun petDog(dog: Dog) {}

fun main() {
    val dog: Dog = Dog()
    val dogNullable: Dog? = dog
    petDogIfPresent(dog) // works
    petDogIfPresent(dogNullable) // works
    petDog(dog) // works
    petDog(dogNullable) // compilation error
}
```

This is because the non-nullable variant of each type is a subtype of the nullable variant.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_A_B_nullability.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

The superclass of all the classes in Kotlin is `Any`, which is similar to `Object` in Java. The supertype of all the types is not `Any`, it is `Any?`. `Any` is a supertype of all non-nullable types. We also have something that is not present in Java and most other mainstream languages: the subtype of all the types, which is called `Nothing`. We will talk about it soon.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_A_B_nullability_Any_Nothing.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

`Any` is only a supertype of non-nullable types. So, wherever `Any` is expected, nullable types will not be accepted. This fact is also used to set a type parameter’s upper boundary to accept only non-nullable types[5](#definition-5).

`fun <T : Any> String.parseJson(): T = ...`

`Unit` does not have any special place in the type hierarchy. It is just an object declaration that is used when a function does not specify a result type.

`object Unit { override fun toString() = "kotlin.Unit" }`

Let's talk about a concept that has a very special place in the typing hierarchy: let's talk about `Nothing`.

### The subtype of all the types: Nothing

`Nothing` is a subtype of all the types in Kotlin. If we had an instance of this type, it could be used instead of everything else (like a Joker in the card game Rummy). It’s no wonder that such an instance does not exist. `Nothing` is an empty type (also known as a bottom type, zero type, uninhabited type, or never type), which means it has no values. It is literally impossible to make an instance of type `Nothing`, but this type is still really useful. I will tell you more: some functions declare `Nothing` as their result type. You've likely used such functions many times already. What functions are those? They declare `Nothing` as a result type, but they cannot return it because this type has no instances. But what can these functions do? Three things: they either need to run forever, end the program, or throw an exception. In all cases, they never return, so the `Nothing` type is not only valid but also really useful.

```kotlin
fun runForever(): Nothing {
    while (true) {
        // no-op
    }
}

fun endProgram(): Nothing {
    exitProcess(0)
}

fun fail(): Nothing {
    throw Error("Some error")
}
```

I have never found a good use case for a function that runs forever, and ending a program is not very common, but we often use functions that throw exceptions. Who hasn't ever used `TODO()`? This function throws a `NotImplementedError` exception. There is also the `error` function from the standard library, which throws an `IllegalStateException`.

```kotlin
inline fun TODO(): Nothing = throw NotImplementedError()

inline fun error(message: Any): Nothing =
    throw IllegalStateException(message.toString())
```

`TODO` is used as a placeholder in a place where we plan to implement some code.

`fun fib(n: Int): Int = TODO()`

`error` is used to signal an illegal situation:

```kotlin
fun get(): T = when {
    left != null -> left
    right != null -> right
    else -> error("Must have either left or right")
}
```

This result type is significant. Let’s say that you have an if-condition that returns either `Int` or `Nothing`. What should the inferred type be? The closest supertype of both `Int` and `Nothing` is `Int`. This is why the inferred type will be `Int`.

```kotlin
// the inferred type of answer is Int
val answer = if (timeHasPassed) 42 else TODO()
```

The same rule applies when we use the Elvis operator, a when-expression, etc. In the example below, the type of both `name` and `fullName` is `String` because both `fail` and `error` declare `Nothing` as their result type. This is a huge convenience.

```kotlin
fun processPerson(person: Person?) {
    // the inferred type of name is String
    val name = person?.name ?: fail()
    // the inferred type of fullName is String
    val fullName = when {
        !person.middleName.isNullOrBlank() ->
            "$name ${person.middleName} ${person.surname}"
        !person.surname.isNullOrBlank() ->
            "$name ${person.surname}"
        else ->
            error("Person must have a surname")
    }
    // ...
}
```

### The result type from return and throw

I will start this subchapter with something strange: did you know that you can place `return` or `throw` on the right side of a variable assignment?

```kotlin
fun main() {
    val a = return
    val b = throw Error()
}
```

This doesn’t make any sense as both `return` and `throw` end the function, so we will never assign anything to such variables (like `a` and `b` in the example above). This assignment is an unreachable piece of code. In Kotlin, it just causes a warning.


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_return_return_type.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

The code above is correct from the language point of view because both `return` and `throw` are expressions, which means they declare a result type. This type is `Nothing`.

```kotlin
fun main() {
    val a: Nothing = return
    val b: Nothing = throw Error()
}
```

This explains why we can place `return` or `throw` on the right side of the Elvis operator or in a when-expression.

```kotlin
fun processPerson(person: Person?) {
    val name = person?.name ?: return
    val fullName = when {
        !person.middleName.isNullOrBlank() ->
            "$name ${person.middleName} ${person.surname}"
        !person.surname.isNullOrBlank() ->
            "$name ${person.surname}"
        else -> return
    }
    // ...
}

fun processPerson(person: Person?) {
    val name = person?.name ?: throw Error("Name is required")
    val fullName = when {
        !person.middleName.isNullOrBlank() ->
            "$name ${person.middleName} ${person.surname}"
        !person.surname.isNullOrBlank() ->
            "$name ${person.surname}"
        else -> throw Error("Surname is required")
    }
    // ...
}
```

Both `return` and `throw` declare `Nothing` as their result type. As a consequence, Kotlin will infer `String` as the type of both `name` and `fullName` because `String` is the closest supertype of both `String` and `Nothing`.

So, now you can say that you know `Nothing`. Just like John Snow.


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/Nothing_John_Snow.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

### When is some code not reachable?

When an element declares `Nothing` as a return type, it means that everything after its call is not reachable. This is reasonable: there are no instances of `Nothing`, so it cannot be returned. This means a statement that declares `Nothing` as its result type will never complete in a normal way, so the next statements are not reachable. This is why everything after either `fail` or `throw` will be unreachable.


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_fail_throw.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

It’s the same with `return`, `TODO`, `error`, etc. If a non-optional expression declares `Nothing` as its result type, everything after that is unreachable. This is a simple rule, but it’s useful for the compiler. It’s also useful for us since it gives us more possibilities. Thanks to this rule, we can use `TODO()` in a function instead of returning a value. Anything that declares `Nothing` as a result type ends the function (or runs forever), so this function will not end without returning or throwing first.

```fun fizzBuzz(): String { TODO() }```

I would like to end this topic with a more advanced example that comes from the Kotlin Coroutines library. There is a `MutableStateFlow` class, which represents a mutable value whose state changes can be observed using the `collect` method. The thing is that `collect` suspends the current coroutine until whatever it observes is closed, but a StateFlow cannot be closed. This is why this `collect` function declares `Nothing` as its result type.

```kotlin
public interface SharedFlow<out T> : Flow<T> {
    public val replayCache: List<T>
    override suspend fun collect(
        collector: FlowCollector<T>
    ): Nothing
}
```

That is very useful for developers who are not aware of how `collect` works. Thanks to the result type, IntelliJ informs them that the code they place after `collect` is unreachable.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/stateflow_unreachable.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

_SharedFlow cannot be closed, so its `collect` function will never return, therefore it declares `Nothing` as its result type._

### The type of null

Let's see another peculiar thing. Did you know that you can assign `null` to a variable without setting an explicit type? What’s more, such a variable can be used wherever `null` is accepted.

```kotlin
fun main() {
    val n = null
    val i: Int? = n
    val d: Double? = n
    val str: String? = n
}
```

This means that `null` has its type, which is a subtype of all nullable types. Take a look at the type hierarchy and guess what type this is.


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/typing_system_A_B_nullability_Any_Nothing.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

I hope you guessed that the type of `null` is `Nothing?`. Now think about the inferred type of `a` and `b` in the example below.

```kotlin
val a = if (predicate) "A" else null

val b = when {
    predicate2 -> "B"
    predicate3 -> "C"
    else -> null
}
```

In the if-expression, we search for the closest supertype of the types from both branches. The closest supertype of `String` and `Nothing?` is `String?`. The same is true about the when-expression: the closest supertype of `String`, `String`, and `Nothing?` is `String?`. Everything makes sense.

For the same reason, whenever we require `String?`, we can pass either `String` or `null`, whose type is `Nothing?`. This is clear when you take a look at the type hierarchy. `String` and `Nothing?` are the only non-empty subtypes of `String?`.


{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/beauty-of-kotlin-type-system/Socrates.webp"
    caption=""
    alt=`cover`
    class="row flex-center"
>}}

### Summary

In this chapter, we've learned the following:

*   A class is a template for creating objects. A type defines expectations and functionalities.

*   Every class generates a nullable and a non-nullable type.

*   A nullable type is a supertype of the non-nullable variant of this type.

*   The supertype of all types is `Any?`.

*   The supertype of non-nullable types is `Any`.

*   The subtype of all types is `Nothing`.

*   When a function declares `Nothing` as a return type, this means that it will throw an error or run infinitely.

*   Both `throw` and `return` declare `Nothing` as their result type.

*   The Kotlin compiler understands that when an expression declares `Nothing` as a result type, everything after that is unreachable.

*   The type of `null` is `Nothing?`, which is the subtype of all nullable types.