---
title: "Saga Pattern Made Easy"
description: "So the last time your family went to the local park everyone was talking about the Saga Design Pattern, and now you want to know what it is, if you should make it part of your own distributed system design, and how to implement it..."
summary: "The following article explains the Saga pattern, commonly used to design microservice systems."
keywords: ['emily fortuna', 'saga', 'software architecture']
date: 2023-07-14T09:32:54.783Z
draft: false
categories: ['reads']
tags: ['reads', 'emily fortuna', 'saga', 'software architecture']
---

The following article explains the Saga pattern, commonly used to design microservice systems.

https://dev.to/temporalio/saga-pattern-made-easy-4j42

---

So the last time your family went to the local park everyone was talking about the Saga Design Pattern, and now you want to know what it is, if you should make it part of your own distributed system design, and how to implement it. As we all know, software design is all about fashionable[1](#fn1) trends[2](#fn2).

[](#the-case-for-sagas)The case for sagas
-----------------------------------------

If you’re wondering if the saga pattern is right for your scenario, ask yourself: **_does your logic involve multiple steps, some of which span machines, services, shards, or databases, for which partial execution is undesirable_**? Turns out, this is exactly where sagas are useful. Maybe you are checking inventory, charging a user’s credit card, and then fulfilling the order. Maybe you are managing a supply chain. The saga pattern is helpful because it basically functions as a state machine storing program progress, preventing multiple credit card charges, reverting if necessary, and knowing exactly how to safely resume in a consistent state in the event of power loss.

A common life-based example used to explain the way the saga pattern compensates for failures is trip planning. Suppose you are itching to soak up the rain in Duwamish territory, Seattle. You’ll need to purchase an airplane ticket, reserve a hotel, and get a ticket for a guided backpacking experience on Mount Rainier. All three of these tasks are coupled: if you’re unable to purchase a plane ticket there’s no reason to get the rest. If you get a plane ticket but have nowhere to stay, you’re going to want to cancel that plane reservation (or retry the hotel reservation or find somewhere else to stay). Lastly if you can’t book that backpacking trip, there’s [really no other reason](https://t.mp/3nVRUxu) to come to Seattle so you might as well cancel the whole thing. (Kidding!)

 {{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/saga-pattern-made-easy/sagas_vs_workflows__-_Algorithm_flowchart_example__1_.svg"
    caption="Above: a simplistic model of compensating in the face of trip planning failures"
    alt="a simplistic model of compensating in the face of trip planning failures"
    class="row flex-center"
>}}

There are many “do it all, or don’t bother” software applications in the real-world: if you successfully charge the user for an item but your fulfillment service reports that the item is out of stock, you’re going to have upset users if you don’t refund the charge. If you have the opposite problem and accidentally deliver items “for free,” you’ll be out of business. If the machine coordinating a machine learning data processing pipeline crashes but the follower machines carry on processing the data with nowhere to report their data to, you may have a very expensive compute resources bill on your hands[3](#fn3). In all of these cases having some sort of “progress tracking” and compensation code to deal with these “do-it-all-or-don’t-do-any-of-it” tasks is exactly what the saga pattern provides. In saga parlance, these sorts of “all or nothing” tasks are called _long-running transactions_. This doesn’t necessarily mean such actions run for a “long” time, just that they require more steps in logical time[4](#fn4) than something running locally interacting with a single database.

[](#how-do-you-build-a-saga)How do you build a saga?
----------------------------------------------------

A saga is composed of two parts:

1.  Defined behavior for “going backwards” if you need to “undo” something (i.e., [compensations](https://temporal.io/blog/compensating-actions-part-of-a-complete-breakfast-with-sagas))
2.  Behavior for striving towards forward progress (i.e., saving state to know where to recover from in the face of failure)

The avid reader of this blog will remember I recently wrote a [post about compensating actions](https://temporal.io/blog/compensating-actions-part-of-a-complete-breakfast-with-sagas). As you can see from above, compensations are but one half of the saga design pattern. The other half, alluded to above, is essentially state management for the whole system. The compensating actions pattern helps you know how to recover if an individual step (or in Temporal terminology, an _[Activity](https://docs.temporal.io/activities)_) fails. But what if the _whole system_ goes down? Where do you start back up? Since not every step might have a compensation attached, you’d be forced to do your best guess based on stored compensations. The saga pattern keeps track of where you are currently so that you can keep driving towards forward progress.

[](#so-how-do-i-implement-sagas-in-my-own-code)So how do I implement sagas in my own code?
------------------------------------------------------------------------------------------

I’m so glad you asked.

_leans forward_

_whispers in ear_

This is a little bit of a trick question because by running your code with Temporal, you _automatically_ get your state saved and retries on failure at any level. That means the saga pattern with Temporal is as simple as coding up the compensation you wish to take when a step (_Activity_) fails. The end.

The \_why \_behind this magic is Temporal, by design, automatically keeps track of the progress of your program and can pick up where it left off in the face of catastrophic failure. Additionally, Temporal will retry Activities on failure, without you needing to add any code beyond specifying a Retry Policy, e.g.,:  

    RetryOptions retryoptions = RetryOptions.newBuilder()
           .setInitialInterval(Duration.ofSeconds(1))
           .setMaximumInterval(Duration.ofSeconds(100))
           .setBackoffCoefficient(2)
           .setMaximumAttempts(500).build();
    

Enter fullscreen mode Exit fullscreen mode

To learn more about how this automagic works, stay tuned for my upcoming post on choreography and orchestration, the two common ways of implementing sagas.

So to express the high-level logic of my program with both the vacation booking steps plus compensations I wish to take on failure, it would look like the following in pseudocode:  

    try:
       registerCompensationInCaseOfFailure(cancelHotel)
       bookHotel
       registerCompensationInCaseOfFailure(cancelFlight)
       bookFlight
       registerCompensationInCaseOfFailure(cancelExcursion)
       bookExcursion
    catch:
       run all compensation activities
    

Enter fullscreen mode Exit fullscreen mode

In Java, the `Saga` class keeps track of compensations for you:  

    @Override
    public void bookVacation(BookingInfo info) {
       Saga saga = new Saga(new Saga.Options.Builder().build());
       try {
           saga.addCompensation(activities::cancelHotel, info.getClientId());
           activities.bookHotel(info);
    
           saga.addCompensation(activities::cancelFlight, info.getClientId());
           activities.bookFlight(info);
    
           saga.addCompensation(activities::cancelExcursion, 
                                info.getClientId());
           activities.bookExcursion(info);
       } catch (TemporalFailure e) {
           saga.compensate();
           throw e;
       }
    }
    

Enter fullscreen mode Exit fullscreen mode

In other language SDKs you can easily write the `addCompensation` and `compensate` functions yourself. Here's a version in Go:  

    func (s *Compensations) AddCompensation(activity any, parameters ...any) {
        s.compensations = append(s.compensations, activity)
        s.arguments = append(s.arguments, parameters)
    }
    
    func (s Compensations) Compensate(ctx workflow.Context, inParallel bool) {
        if !inParallel {
            // Compensate in Last-In-First-Out order, to undo in the reverse order that activies were applied.
            for i := len(s.compensations) - 1; i >= 0; i-- {
                errCompensation := workflow.ExecuteActivity(ctx, s.compensations[i], s.arguments[i]...).Get(ctx, nil)
                if errCompensation != nil {
                    workflow.GetLogger(ctx).Error("Executing compensation failed", "Error", errCompensation)
                }
            }
        } else {
            selector := workflow.NewSelector(ctx)
            for i := 0; i < len(s.compensations); i++ {
                execution := workflow.ExecuteActivity(ctx, s.compensations[i], s.arguments[i]...)
                selector.AddFuture(execution, func(f workflow.Future) {
                    if errCompensation := f.Get(ctx, nil); errCompensation != nil {
                        workflow.GetLogger(ctx).Error("Executing compensation failed", "Error", errCompensation)
                    }
                })
            }
            for range s.compensations {
                selector.Select(ctx)
            }
        }
    }
    

Enter fullscreen mode Exit fullscreen mode

The high level Go code of steps and compensations will look very similar to the Java version:  

    func TripPlanningWorkflow(ctx workflow.Context, info BookingInfo) (err error) {
       options := workflow.ActivityOptions{
           StartToCloseTimeout: time.Second * 5,
           RetryPolicy:         &temporal.RetryPolicy{MaximumAttempts: 2},
       }
    
       ctx = workflow.WithActivityOptions(ctx, options)
    
       var compensations Compensations
    
       defer func() {
           if err != nil {
               // activity failed, and workflow context is canceled
               disconnectedCtx, _ := workflow.NewDisconnectedContext(ctx)
               compensations.Compensate(disconnectedCtx, true)
           }
       }()
    
       compensations.AddCompensation(CancelHotel)
       err = workflow.ExecuteActivity(ctx, BookHotel, info).Get(ctx, nil)
       if err != nil {
           return err
       }
    
       compensations.AddCompensation(CancelFlight)
       err = workflow.ExecuteActivity(ctx, BookFlight, info).Get(ctx, nil)
       if err != nil {
           return err
       }
    
       compensations.AddCompensation(CancelExcursion)
       err = workflow.ExecuteActivity(ctx, BookExcursion, info).Get(ctx, nil)
       if err != nil {
           return err
       }
    
       return err
    }
    

Enter fullscreen mode Exit fullscreen mode

This high-level sequence of code above is called a Temporal _[Workflow](https://docs.temporal.io/workflows)_. _And_, as mentioned before, by running with Temporal, we don’t have to worry about implementing any of the bookkeeping to track our progress via event sourcing or adding retry and restart logic because that all comes for free. So when writing code that runs with Temporal, you only need to worry about writing compensations, and the rest is provided for free.

[](#idempotency)Idempotency
---------------------------

Well, okay, there is a second thing to “worry about.” As you may recall, sagas consist of two parts, the first part being those compensations we coded up previously. The second part, “striving towards forward progress” involves potentially retrying an activity in the face of failure. Let’s dig into one of those steps, shall we? Temporal does all the heavy lifting of retrying and keeping track of your overall progress, however because code can be retried, you, the programmer, need to make sure each Temporal Activity is _idempotent_. This means the observed result of `bookFlight` is the same, whether it is called one time or many times. To make this a little more concrete, a function that sets some field `foo=3` is idempotent because afterwards `foo` will be 3 no matter how many times you call it. The function `foo += 3` is not idempotent because the value of `foo` is dependent on the number of times your function is called. Non-idempotency can sometimes look more subtle: if you have a database that allows duplicate records, a function that calls `INSERT INTO foo (bar) VALUES (3)` will blithely create as many records in your table as times you call it and is therefore not idempotent. Naive implementations of functions that send emails or transfer money are also not idempotent by default.

If you’re backing away slowly right now because your Real World Application does a lot more complex things than set `foo=3`, take heart. There is a solution. You can use a distinct identifier, called an _idempotency key_, or sometimes called a `referenceId` or something similar to uniquely identify a particular transaction and ensure the hotel booking transaction occurs effectively once. The way this idempotency key may be defined based on your application needs. In the trip planning application, `clientId`, a field in `BookingInfo` is used to uniquely identify transactions.  

    type BookingInfo struct {
       Name     string
       ClientId string
       Address  string
       CcInfo   CreditCardInfo
       Start    date.Date
       End      date.Date
    }
    

Enter fullscreen mode Exit fullscreen mode

You also probably saw the `clientId` used to register the compensation in the above Java workflow code:  

    saga.addCompensation(activities::cancelHotel, info.getClientId());
    

Enter fullscreen mode Exit fullscreen mode

However, using `clientId` as our key limits a particular person from booking more than one vacation at once. This is probably what we want. However, some business applications may choose to build an idempotency key by combining the `clientId` and the `workflowId` to allow more than one vacation at once booked per-client. If you wanted a truly unique idempotency key you could pass in a UUID to the workflow. The choice is up to you based on your application’s needs.

[Many third-party APIs that handle money](https://stripe.com/docs/api/idempotent_requests) already accept idempotency keys for this very purpose. If you need to implement something like this yourself, use atomic writes to keep a record of the idempotency keys you’ve seen so far, and don’t perform an operation if its idempotency key is in the “already seen” set.

[](#benefits-vs-complexity)Benefits vs Complexity
-------------------------------------------------

The saga pattern does add complexity to your code, so it’s important to not implement it in your code _just_ because you have microservices. However, if you need to complete a task (like booking a trip with an airfare and hotel) that involves multiple services and partial execution is not actually a success, then a saga will be your friend. Additionally, if you find your saga getting _particularly_ unwieldy, it may be time to reconsider how your microservices are divided up, and roll up the ol’ sleeves to refactor. Overall, Temporal makes implementing the saga pattern in your code comparatively trivial since you only need to [write the compensations](https://temporal.io/blog/compensating-actions-part-of-a-complete-breakfast-with-sagas) needed for each step. Stay tuned for my next post, where I dig into sagas and subscription scenarios, where Temporal particularly shines in reducing complexity when working with sagas.

The full repository that uses the code mentioned in this article can be found [on GitHub](https://github.com/efortuna/sagas-temporal-trip-booking):

*   [Java code](https://github.com/efortuna/sagas-temporal-trip-booking/tree/main/java)
*   [Go code](https://github.com/efortuna/sagas-temporal-trip-booking/tree/main/go)

If you want to see other tutorials of sagas using Temporal, please check out the following resources:

*   [Java: Booking Saga](https://github.com/temporalio/samples-java/blob/main/src/main/java/io/temporal/samples/bookingsaga/README.md)
*   [Go: Money Transfer Saga](https://github.com/temporalio/samples-go/tree/main/saga)
*   [PHP: Money Transfer Saga](https://github.com/temporalio/samples-php/tree/master/app/src/Saga)
*   [Python: Booking Saga](https://github.com/rachfop/temporal-sagas)
*   [TypeScript: Money Transfer Saga](https://github.com/temporalio/samples-typescript/tree/main/saga)

Additionally one of my colleagues, Dominik Tornow, gave an intro to sagas on [YouTube](https://www.youtube.com/watch?v=0W8BtIwh824).

Learn more about Temporal in our [courses]([https://learn.temporal.io/courses/temporal_101/](https://learn.temporal.io/courses/temporal_101/)), [tutorials](https://learn.temporal.io/getting_started/), [docs]([https://t.mp/guide](https://t.mp/guide)), and [videos](https://www.youtube.com/@Temporalio/playlists).

[](#notes)Notes
---------------

* * *

1.  Obviously, don’t redesign your system just because it’s the new hotness. Unless it’s a new JavaScript framework. Then `npm install` that new package with due haste. 😜
    
2.  Don’t worry, sagas aren’t a trend; they’ve been around in databases [since the 80s](https://www.cs.cornell.edu/andru/cs711/2002fa/reading/sagas.pdf). You can take comfort knowing your project has a classic elegance to its design.
    
3.  Not that the author has absolutely any experience with this scenario whatsoever. _coughs in the price of a new car_ 😬
    
4.  Logical time is a notion in distributed computing to describe timing of events happening on different machines in distributed computing, since machines may not have a physical synchronous global clock. Logical timing is simply a causal ordering of events that occurred on these machines. In the case of long-running transactions, it basically boils down to having many “steps” that take place on different machines.