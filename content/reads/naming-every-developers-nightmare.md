---
title: "Naming: Every Developer's Nightmare"
description: "Aah.. naming things. A developer's favorite brain sport, nestled somewhere between attending endless..."
summary: "The following is a guide on how to name things in a way that is more readable for developers."
keywords: ['samuel braun', 'naming', 'software engineering']
date: 2023-04-26T07:27:07.203Z
draft: false
categories: ['reads']
tags: ['reads', 'samuel braun', 'naming', 'software engineering']
---

The following is a guide on how to name things in a way that is more readable for developers. Take in consideration that there is not silver-bullet for naming things, but of course, there are general guidelines that are approved by the majority of developers.

https://dev.to/samuel-braun/naming-every-developers-nightmare-3ge8

---

Aah.. naming things. A developer's favorite brain sport, nestled somewhere between attending endless meetings and refactoring code. As developers, we know that naming can be both a blessing and a curse. It's a critical part of our work, but it can lead to some hilarious but most likely frustrating names. In this post, I'll show a way we can think of variables and how you can use them effectively. Even if you feel confident naming your variables, are you also using their full potential? 🤔

*   [A Naming Pattern to Save the Day](#a-naming-pattern-to-save-the-day)
*   [Naming Variables Effectively](#naming-variables-effectively)

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/naming-every-developers-nightmare/jdicxn0lfclb519onkvo.gif"
    caption=""
    alt=`My name is Jeeeeff`
    class="row flex-center"
>}}

[](#a-naming-pattern-to-save-the-day)A Naming Pattern to Save the Day
---------------------------------------------------------------------

When you find yourself struggling to name a specific variable, function, or class, consider using the following pattern and ask yourself the corresponding questions. The pattern is **`[scope][typePrefix][baseName][qualifier][typeSuffix]`.**

1.  **Scope:**
    *   What is the visibility or accessibility of this variable? _(e.g., private, public, protected, internal, package-private)_
    *   Is this variable specific to any programming language features or conventions? _(e.g., double underscore prefix in Python, dollar sign in jQuery, '@' for instance variables in Ruby)_
    *   Is this variable part of a framework or library that requires a specific naming pattern? _(e.g., Angular's 'ng' prefix for directives, React's 'use' prefix for hooks)_
2.  **TypePrefix:**
    *   Is this variable a boolean or a function that returns a boolean? _(e.g., is, has, contains, are, integrates)_
    *   Does the variable represent a state, condition, or action that can be described with words like "is," "has," "contains," or "integrates"? _(e.g., isEnabled, hasAccess, containsItem)_
    *   Is this a function responsible for getting, setting, fetching, or updating data? _(e.g., get, set, fetch, update, retrieve, store, save)_
3.  **BaseName:**
    *   What is the primary purpose of this variable? _(e.g., user, distance, payment, errorMessage)_
    *   Can I describe the variable's role in the code with a clear, concise word or phrase? _(e.g., registrationStatus, totalPrice, elapsedTime)_
4.  **Qualifier:**
    *   Are there any additional details or context that would help distinguish this variable from others with a similar purpose? _(e.g., firstName, lastName, phoneNumber)_
    *   Does the variable have specific units or properties that should be included in the name, such as "InMeters" or "InSeconds"? _(e.g., distanceInMiles, timeInSeconds)_
    *   Is there a specific state or condition that this variable represents, such as "Valid" or "Removable"? _(e.g., isValidEmail, isRemovableItem)_
5.  **TypeSuffix:**
    *   What is the fundamental purpose or structure of this variable? _(e.g., Count, Index, Sum, Average, List, Map, Array, Set, Queue)_
    *   Can the variable's role be clarified by adding a suffix for the structure like "Count," "Index," "Sum," "Average," "List," or "Map"? _(e.g., itemCount, currentIndex, totalPriceSum, ratingAverage, userList, settingsMap)_

Here are 6 examples:
8r7ovwhs4gzahxdpzy8uhalf the battle. The other half? Comments. But not in the way you're thinking.

You might have heard the advice to scatter comments throughout your code to make it more understandable, especially for your future self. But, in reality, that's not always the best approach.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/naming-every-developers-nightmare/8r7ovwhs4gzahxdpzy8u.gif"
    caption=""
    alt=`Fail`
    class="row flex-center"
>}}

Consider this: if your code is incomprehensible without comments, then the problem isn't a lack of comments. And if your code is already clear, then you don't need the comments in the first place.

So, what's the point I'm trying to make? Use variables as comments.

When you store everything in a variable with a meaningful name, you can often understand the entire code just by reading those names and key control structures like if statements. Let me show you an example:

The other day, I came across a piece of code that took me about 10 minutes to grasp completely 🥴.  

    if (!row.doc[otherField]) {
    
        let val;
    
        if(currentField == "left") {
            val = row.doc[currentField].charAt(0) === "-" ? row.doc[currentField].slice(1) : row.doc[currentField];
        }
    
        if(currentField == "right") {
            val = row.doc[currentField].charAt(0) === "-" ? row.doc[currentField] : `-${row.doc[currentField]}`;
        }
    
        row.doc[otherField] = val === "-0" ? "0" : val;
        row.refreshField(otherField);
    }
    
    if (currentField === "left" && row.doc["left"] && row.doc["left"].charAt(0) !== "-") {
        row.doc["left"] = row.doc["left"] === "0" ? row.doc["left"] : `-${row.doc["left"]}`;
        row.refreshField("left");
    }
    
    if (currentField === "right" && row.doc["right"] && row.doc["right"].charAt(0) === "-") {
        row.doc["right"] = row.doc["right"].slice(1);
        row.refreshField("right");
    }
>

So let's clean it up by putting stuff into variables and giving them meaningful names:  

    const valueOfOtherField = row.doc[otherField];
    const valueOfCurrentField = row.doc[currentField];
    const valueOfLeftField = row.doc["left"];
    const valueOfRightField = row.doc["right"];
    const isCurrentFieldOnLeft = currentField === "left";
    const isCurrentFieldOnRight = currentField === "right";
    
    const startsWithMinusSign = (str) => str.charAt(0) === "-";
    const removeMinusFromZero = (str) => str === "-0" ? "0" : str;
    const ensureMinusAtStart = (str) => startsWithMinusSign(str) ? str : `-${str}`;
    const removeMinusFromStart = (str) => str.replace(/^-/, "");
    
    if (!valueOfOtherField) {
        let val;
        if (isCurrentFieldOnLeft) {
            val = startsWithMinusSign(valueOfCurrentField) ? 
                removeMinusFromStart(valueOfCurrentField) : 
                valueOfCurrentField;
        } else if (isCurrentFieldOnRight) {
            val = startsWithMinusSign(valueOfCurrentField) ? 
                valueOfCurrentField : 
                ensureMinusAtStart(valueOfCurrentField);
        }
    
        row.doc[otherField] = removeMinusFromZero(val);
        row.refreshField(otherField);
    }
    
    if (isCurrentFieldOnLeft && valueOfLeftField && !startsWithMinusSign(valueOfLeftField)) {
        row.doc["left"] = removeMinusFromZero(ensureMinusAtStart(valueOfLeftField));
        row.refreshField("left");
    }
    
    if (isCurrentFieldOnRight && valueOfRightField && startsWithMinusSign(valueOfRightField)) {
        row.doc["right"] = removeMinusFromStart(valueOfRightField);
        row.refreshField("right");
    }
>

With this change, the code reads almost like plain English. However, upon closer inspection, we can identify some unnecessary logic steps that can be removed and simplified. Take this line, for example:  

    val = startsWithMinusSign(valueOfCurrentField) ? 
                valueOfCurrentField : 
                ensureMinusAtStart(valueOfCurrentField);
>

Logically, it can be further simplified. If the value starts with a minus sign, we keep it; otherwise, we add a new minus sign. Essentially, this means we can simply add a minus sign at the beginning. So, the line can be simplified to:  

    val = ensureMinusAtStart(valueOfCurrentField);

Assuming the performance of `row.refreshField` is negligible, the same logic can be applied to the if statements by removing the `&& startsWithMinusSign(valueOfRightField)` and `&& !startsWithMinusSign(valueOfLeftField)` conditions. The entire code should now look like this:  

    const valueOfOtherField = row.doc[otherField];
    const valueOfCurrentField = row.doc[currentField];
    const valueOfLeftField = row.doc["left"];
    const valueOfRightField = row.doc["right"];
    const isCurrentFieldOnLeft = currentField === "left";
    const isCurrentFieldOnRight = currentField === "right";
    
    const startsWithMinusSign = (str) => str.charAt(0) === "-";
    const removeMinusFromZero = (str) => str === "-0" ? "0" : str;
    const ensureMinusAtStart = (str) => removeMinusFromZero(
        startsWithMinusSign(str) ? str : `-${str}`
    );
    const removeMinusFromStart = (str) => str.replace(/^-/, "");
    
    if (!valueOfOtherField) {
    
      // If the current input field is on the left, let's remove the minus from the start
      // and if its on the right, let's add the minus at the start. And put it into the
      // other field. (NOTE: In the original code there were exactly two fields, left and right.)
        const newValue = isCurrentFieldOnLeft ?
            removeMinusFromStart(valueOfCurrentField) :
            ensureMinusAtStart(valueOfCurrentField);
    
        row.doc[otherField] = newValue;
        row.refreshField(otherField);
    }
    
    // If the current field is the left one and there is an inputted value then
    // make sure to add the minus at the start
    if (isCurrentFieldOnLeft && valueOfLeftField) {
        row.doc["left"] = ensureMinusAtStart(valueOfLeftField);
        row.refreshField("left");
    }
    
    // If the current field is the right one and there is an inputted value then
    // make sure to remove the minus from the start
    if (isCurrentFieldOnRight && valueOfRightField) {
        row.doc["right"] = removeMinusFromStart(valueOfRightField);
        row.refreshField("right");
    }

At this point, we can easily read through the code without tearing our hair out. The code accomplishes two main tasks:

1.  It ensures that when the user enters values in the left and right fields, the right one will always be positive, and the left one will be negative.
2.  If one of the fields hasn't been filled in yet, the code copies the value of the current input field to the other field.

Understanding this behavior with the original code would have been quite challenging. However, by using variables more effectively, we can abstract away the complicated syntax mess and make the code read more naturally 💪.