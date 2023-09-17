---
title: "From Problems to Solutions: Understanding Design Patterns"
description: 'An interesting fact in software development is that you are almost always not the first person to...'
summary: "The following is a recap on some design patterns we use everyday, but don't know we are using them or don't know them by their name."
keywords: ['hana belay', 'design pattern', 'software engineering', 'gof']
date: 2023-04-19T23:00:42.163Z
draft: false
categories: ['reads']
tags: ['reads', 'hana belay', 'design pattern', 'software engineering', 'gof']
---

The following is a recap on some design patterns we use everyday, but don't know we are using them or don't know them by their name.

https://dev.to/documatic/from-problems-to-solutions-understanding-design-patterns-3b7i

---

An interesting fact in software development is that you are almost always not the first person to face a specific problem. The problem may have been occurring since the dawn of software development. In this blog post, we are going to take a look at design patterns, why we need them, and an overview of some of the design patterns.

Design patterns are a systematic approach for addressing recurring problems that programmers face. They describe a universal standard to solve those problems. The provided solution is in such a way that it can be reused despite the specific domain of the problem at hand. Therefore, next time you face a programming problem, beware that you don’t have to rediscover the solution from scratch.

[](#why-design-patterns)Why Design Patterns?
--------------------------------------------

*   Experience makes one perfect: You, as a developer, have to first understand existing good designs, their application area, and trade-offs so that you can reuse them or develop your own.
*   Shared language of design: Design patterns provide a common vocabulary for programmers. This helps to effectively communicate with one another, reducing misunderstandings and increasing productivity.
*   Better scalability: Design patterns help to make systems more scalable, allowing them to grow and adapt as needs change.
*   Improved code structure: Design patterns help to structure code in a consistent and organized manner, making it easier to understand and maintain. This can lead to improved code quality and reduced development time.

[](#elements-of-a-design-pattern)Elements of a Design Pattern
-------------------------------------------------------------

1.  **Name** - is a handle used to describe the design issue. It is necessary because it gives a common ground of understanding among programmers.
2.  **Problem** - is used to describe when the pattern can be used.
3.  **Solution** - is a template that describes elements and their relationships without providing implementation detail.
4.  **Consequence** - is used to describe the trade-offs of the pattern. Examples: time and space trade-offs, flexibility, extensibility, etc.

[](#types-of-design-patterns)Types of Design Patterns
-----------------------------------------------------

Design Patterns: Elements of Reusable Object-Oriented Software, commonly known as the **Gang of Four**, is a cornerstone in software engineering that brought design patterns into the mainstream. The book breaks down 23 different design patterns that fall into the following 3 categories:

1.  **Creational** - They are concerned with object-creation techniques.
2.  **Structural** - They are concerned with the combination of objects and classes in a flexible and effective way.
3.  **Behavioral** - They are concerned with the interaction between classes and objects and their responsibility.

[{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/from-problems-to-solutions-understanding-design-patterns/w1tmfrb1zt6bqgzu8bvv.webp"
    caption=""
    alt=`23 design patterns gang of four](https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/from-problems-to-solutions-understanding-design-patterns/w1tmfrb1zt6bqgzu8bvv.webp)`
    class="row flex-center"
>}}

[](#introduction-to-six-design-patterns)Introduction to Six Design Patterns
---------------------------------------------------------------------------

The following section is going to provide an overview of 6 software design patterns (2 from each category) and how they can be used to solve common programming challenges.

### [](#1-singleton)1\. Singleton

The Singleton pattern is a type of creational pattern that ensures the creation of a single instance of a class and provides a global point of access to that instance.

**The Why:**

Suppose you are building a Database connection class:

*   You don’t want to create a separate DB instance for every object that needs to access it. If you do so, it’s going to be costly. This concept goes for other shared resources like files as well.
*   You want to provide global and easy access to that instance. Similar to global variables, the Singleton pattern gives you access to an object from anywhere in your program.

**The How:**

There are various ways of implementing a Singleton pattern. However, all of the implementations share the following basic concepts:

*   Unlike a regular constructor that creates a new object whenever you call it, a Singleton class has a **private constructor.** A private constructor prevents other objects from instantiating an object of the Singleton class.
*   A private instance variable.
*   A static method that returns a reference to that instance. This static method basically acts as a constructor and calls the private constructor under the hood to either create an object (when requested for the first time) or return the cached one (for subsequent requests).

### [](#2-factory-method)2\. Factory Method

The factory method is also another type of creational pattern that provides an interface for creating objects but lets the subclasses decide which class to instantiate. In other words, the subclasses can change the type of objects that will be created.

**The Why:**

Suppose you are creating a logging framework by using the factory method design pattern to log different kinds of messages including, but not limited to, error messages, warning messages, and informational messages. In this use case:

*   The logger can provide a factory method for creating different types of messages.
*   The client code that uses this logger doesn’t need to know the exact implementation of the messages, it only needs to know the interface for creating them.
*   You can provide flexibility. If the object creation process changes, for example, a new class is added, only the factory method needs to be updated. No need to change the client code that uses those objects.

**The How:**

*   Replace direct object construction calls with calls to a specific factory method.
*   Create an object by calling the factory method, rather than invoking a constructor.

### [](#3-adapter)3\. Adapter

Adapter is a type of structural design pattern that allows objects with incompatible interfaces to work together. It lies at an intermediary position between the client and the interface that the client wants to communicate with.

**The Why:**

Suppose you are building a video format conversion tool by following the Adapter design pattern:

*   Your software needs to adapt between different video formats, such as MP4, AVI, and FLV. It should be able to take a video in any format as input and convert it to the desired format. Communication between the target and the client happens via the adapter.
*   If in the future you want to support new formats, the pattern makes it easier because the video format conversion is decoupled from the specific video formats.

**The How:**

*   Define an adapter class that converts the incompatible interface of a class (adaptee) into another interface (target) clients expect.
*   Use this adapter to work with (reuse) other classes that do not have the required interface.

### [](#4-decorator)4\. Decorator

Decorator is another type of structural design pattern that lets you attach new behaviors to objects without affecting the behavior of other objects from the same class. Even though inheritance can be used to alter the behavior of an object statically, a decorator helps you alter it dynamically as well.

**The Why:**

Suppose you are building a text editor:

*   The text editor can be your concrete component, and a spell checker can be your decorator.
*   The spell checker class should have the same interface as the text editor class so that it can be used as a decorator.
*   The spell-checker class can wrap the text editor and add spell-checking functionality to the editor. This makes it flexible to add new functionalities to the editor in the future.

**The How:**

*   Define an interface for the components and decorators.
*   Implement concrete components and concrete decorators that conform to the interface.
*   The decorators should have a reference to the components they decorate and delegate to the components to perform basic behaviors. The decorators will have methods that add new behavior.
*   Use the decorators to wrap the components in the desired order to attach the additional behavior.

**Note** - Adapter provides a different interface to its subject. Decorator provides an enhanced interface.

### [](#5-observer)5\. Observer

Observer is a behavioral design pattern that defines a one-to-many dependency between objects so that when one object, named the **subject**, changes its state, all of its dependents, named **observers**, are notified and updated automatically.

**The Why**

Suppose you are building a stock market website:

*   You can use the Observer pattern to update your users with the latest stock prices.
*   The website is the subject, and its users are the observers. Whenever the stock prices change, the website notifies its users.

**The How**

*   Define a Subject object.
*   Define Observer objects. An observer can subscribe or unsubscribe to a stream of events.
*   The relationship between the subject and observers shouldn’t be tightly coupled.
*   When the subject’s state changes, all registered observers are notified and updated.

### [](#6-strategy)6\. Strategy

Strategy is another type of behavioral design pattern that allows you to define a family of algorithms, encapsulate each one, and make them interchangeable. It enables the client to select the algorithm’s behavior at run time.

**The Why**

Suppose you are creating software that has sorting functionality:

*   A sorting algorithm, such as quick sort, insertion sort, or bubble sort, can be selected at runtime and used to sort a collection of items.
*   The sorting strategies can be easily replaced or modified, which makes it possible to add or remove functionality as needed

**The How**

*   Create a Strategy interface that defines common behavior.
*   Create concrete strategy classes that conform to the Strategy interface. Each concrete strategy is a variation of the algorithm.
*   Create a context class that defines a reference to a sorting strategy object.
*   The context class should have a method that accepts a strategy object and invokes the selected strategy.

[](#conclusion)Conclusion
-------------------------

In conclusion, having a solid grasp of design patterns is crucial, especially as you advance your career in software engineering.