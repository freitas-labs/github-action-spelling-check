---
title: "When should you use an Exception?"
description: 'Exceptions are useful for programming languages as they allow developers to detect and address errors gracefully.'
summary: "The following is a summary on exceptions, how and where to use them."
keywords: ['philip brown', 'exception', 'software patterns', 'software design']
date: 2023-02-10T08:10:18+0000
draft: false
categories: ['reads']
tags: ['reads', 'philip brown', 'exception', 'software patterns', 'software design']
---

The following is a summary on exceptions, how and where to use them. Personally I prefer monads, because it allows us to prevent uncaught exceptions from being thrown all over the place. However, most codebases don't have algebraic data types built in or don't follow a functional programming paradigm, so you need to rely on exceptions.

Keep in mind the author wrote this article on 2014 and software practices were a lot different back then.

https://culttt.com/2014/04/09/use-exception

---

Table of contents:

1.  [What is an Exception?](#what-is-an-exception)
2.  [The anatomy of an Exception](#the-anatomy-of-an-exception)
3.  [When should you throw an Exception?](#when-should-you-throw-an-exception)
4.  [When should you catch an Exception?](#when-should-you-catch-an-exception)
5.  [When should I use a custom exception?](#when-should-i-use-a-custom-exception)
6.  [Exception best practices](#exception-best-practices)
7.  [Conclusion](#conclusion)

Exceptions are a wonderful aspect of programming languages because they allow you to notice when something has gone wrong and deal with it gracefully. Without exceptions your application would end up presenting errors to the user and it would be much more difficult to diagnose what went wrong if your code failed silently.

Unfortunately exceptions are usually not one of the first things you learn when you start to code. In fact, you probably pick up a lot of bad habits when learning how to deal with problems because exceptions can seem like a difficult concept to get your head around.

Exceptions are actually a really simple thing to learn and they will make your code better and your life as a developer easier. Once you understand what an exception is and when and how you should use them you will find using exceptions in your code becomes second nature.

Hopefully this post will teach you everything you need to know about exceptions.

What is an Exception?
---------------------

An exception is basically an _exceptional circumstance_ that is often unrecoverable from. This means something went wrong and we can’t proceed with running the application because the program is unable to carry on executing.

For example, say you were trying to load data from the Twitter API, but Twitter was experiencing downtime. This is an exceptional circumstance because without being able to connect to Twitter we can’t carry on with trying to pull data and display it to the user. Instead we must catch the exception and display an appropriate error message to the user such as _“We can’t currently connect to Twitter_.

Our code might look something like this:

    public function getUserTweets($id)
    {
        try {
            $this->twitter->getTweets($id);
        } catch(Exception $e) {
        // Deal with error
        }
    }

The anatomy of an Exception
---------------------------

So as you can see from the code above, when we know that the method will throw an exception on failure, we should wrap the call inside a `try...catch` block.

If nothing goes wrong only the code in the `try` section will be run.

However if something goes wrong an exception is thrown, we can catch it using the `catch(Exception $e)` block.

The `$e` variable contains an instance of the exception. Exception objects have a number of useful methods such as the `$e->getMessage()` method that will return a description message of what went wrong.

The `getTweets($id)` method on the `Twitter` object might look something like this:

    public function getTweets($id)
    {
        $conn = $this->connect();
    
        if ( ! is_null($conn) {
            // Get tweets from Twitter
            return $conn->getTweets($id);
        }
    
        throw new Exception('Twitter is not available');
    }

As you can see above, we try to connect to Twitter. If we are able to connect to Twitter we can return the requested tweets.

If however we can’t connect to Twitter we can throw an exception and a descriptive message of what went wrong.

When should you throw an Exception?
-----------------------------------

Once you learn about the benefits of using exceptions, it can be tempting to start using them all over your codebase. For example, I see a lot of code where the developer is using exceptions to control the flow of logic.

Exceptions should only be used in _exceptional circumstances_ and therefore should be used sparingly.

For example, it is correct to use an exception when you are attempting to access the Twitter API and do some processing because if this fails it is an exceptional circumstance.

However, if you had a method that attempted to find if a particular Twitter username was available, you shouldn’t use an exception in this instance because the method’s purpose is to return a `true` or `false` value. This is not an exceptional circumstance.

Being able to determine which circumstances require exceptions and which ones do not can take time and experience, so don’t worry if it is not immediately clear.

When should you catch an Exception?
-----------------------------------

Generally speaking, you should attempt to catch an exception as close to where it was thrown as possible. If you don’t catch an exception it will bubble up the stack towards the browser and give an ugly error to the user.

Catching an exception as close to the point of failure as possible allows you to deal with the error gracefully but also keep your code clean and concise.

One of the benefits of using an exception over simply returning a `false` or `null` value is that the exception will immediately halt any other processing and jump up the stack to be dealt with. This can ensure that any other processing that you don’t want to run is stopped before something else breaks. For example, if you wanted to pull data from the Twitter API and then insert it into your database, you wouldn’t want broken queries hitting your database because Twitter was unavailable.

Returning a `false` or `null` value on failure instead of throwing an exception in an exceptional circumstance can make dealing with errors or problems in your application much more difficult. Failing silently is like a cancer because internal things in your code will be failing but you won’t immediately know about it.

When should I use a custom exception?
-------------------------------------

A beautiful aspect of using exceptions to deal with exceptional circumstances is that you can create custom exceptions that will be dealt with in a specific way.

For example, say you had a `TwitterConnectionException` and a `TwitterAuthenticationException` exceptions. The first exception would be used if you could not connect to Twitter, whereas the second exception would be used if your authentication credentials were invalid. This allows you to deal with these two problems in different ways by showing a relevant error to the user, but also allowing your code to deal with the error in a specific way.

Creating custom exceptions is really easy because all you have to do is to extend the `Exception` class:

    class TwitterConnectionException extends Exception
    {
    }
    
    class TwitterAuthenticationException extends Exception
    {
    }

As you can see, we don’t even have to add any methods to these classes because the class will automatically inherit the useful methods from the `Exception` class. Of course if you did want to add some custom methods to these classes, you would be free to do so.

Now when you attempt to catch exceptions, you can type hint you catch blocks so you can deal with exceptions in different ways:

    public function getUserTweets($id)
    {
        try {
            $this->twitter->getTweets($id);
        } catch(TwitterConnectionException $e) {
            // Deal with a connection error
        } catch(TwitterAuthenticationException $e) {
            // Deal with an authentication error
        }
    }

Exception best practices
------------------------

So as you can see, exceptions provide us with a fantastic way of dealing with exceptional circumstances in our code. By catching these problems, we can deal with the problem gracefully, provide the users with a safe error message and kick off the process to notify and log the error so we can diagnose the problem.

In order to better understand when, where and how to use exceptions in your code, here are some best practices that I abide by:

### 1\. Only use in exceptional circumstances

As I mentioned above, only use exceptions in exceptional circumstances. Your code shouldn’t be littered with exceptions because it will quickly become unmaintainable. Instead, only use exceptions when something is unrecoverable.

### 2\. Don’t use exceptions to control logic

If you are using exceptions to control the flow of logic, you are probably doing something wrong. If it is acceptable for a method to return a `false` or `null` value, then this doesn’t require an exception.

### 3\. Use exceptions to deal with external problems

As I mentioned in my Twitter example above, using exceptions to deal with external problems is usually a good idea. For example dealing with a database connection, a third party API or an external service that you are relying on to run your code.

### 4\. Use exceptions for package API’s

If you create a package and distribute it through open source, it’s usually a good idea to use exceptions when a developer has implemented something incorrectly.

For example, say you create a package that allowed a developer to share to multiple social sites using a single API. If the developer wrote something like:

    $twitter = Factory::create("twtter");

This would be a good example of where to use an exception because the `Twitter` class could not be found. This is a mistake on the part of the developer, not the user and so you can help them out by explicitly jumping out of the code and screaming the problem, rather than just returning `null` and failing silently.

Conclusion
----------

So hopefully that was a good introduction to exceptions, when you should use them and a couple of best practices for using them in your projects.

Exceptions are a fantastic aspect of programming languages because they enable you to deal with problems. Allowing problems to fail silently is a terrible idea because problems could be overlooked and your users could end up with a confusing or broken application.

Exceptions seem scary when you are just starting out, especially because they seem to jump out of the code and shout at you whenever something goes wrong. However correctly using exceptions and dealing with things when something inevitably does go wrong is just part of being a really good quality developer.