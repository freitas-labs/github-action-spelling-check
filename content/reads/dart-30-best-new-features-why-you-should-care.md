---
title: "Dart 3.0: Best New Features & Why You Should Care"
description: "I’ve seen a few articles that were pretty lengthy, so figured I’d give my abridged take on the best new features coming to Dart and why you should care (in order of my excitement). You should be able…"
summary: "The following is a summary of the new features introduced to the Dart programming language, now that it hit version 3.0."
keywords: ['kyle venn', 'dart', 'summary']
date: 2023-05-21T22:56:11.570Z
draft: false
categories: ['reads']
tags: ['reads', 'kyle venn', 'dart', 'summary']
---

The following is a summary of the new features introduced to the Dart programming language, now that it hit version 3.0.

https://medium.com/@kvenn/dart-3-0-best-new-features-why-you-should-care-429e739f2690

---

I’ve seen a few articles that were pretty lengthy, so figured I’d give my abridged take on the best new features coming to Dart and why you should care (in order of my excitement). You should be able to copy and paste each example into [DartPad](https://dartpad.dev/) to play around with it. To use Dart 3.0, upgrade [Flutter to 3.10.0](https://dart.dev/resources/dart-3-migration).

This article covers a quick summary of:

*   sealed classes
*   records (tuples)
*   switches in widgets
*   destructuring
*   new list extensions
*   new class modifiers (and how the heck they work)

This doesn’t cover everything, so for all the details check out:

*   [The changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md#310) (the best short summary)
*   The official docs (linked in each header)
*   [This great post](https://biplabdutta.com.np/posts/pattern-matching-dart/)

[Sealed Classes](https://dart.dev/language/class-modifiers#sealed)
------------------------------------------------------------------

*   **What they are:** A class modifier where the compiler ensures that switches on values of that type [exhaustively cover](https://dart.dev/language/branches#exhaustiveness-checking) every subtype and give compile-time assurance of sub-type fields
*   **Why you should care:** They’re particularly good for relaying state between your layers (data➡️presentation & presentation️️️➡️view). Each state can have its own (different) properties that are compile-time safe

This example shows how you could wrap a response type and access `data` or `error` safely without an instance-of check.

```dart
sealed class Response{}  
  
class Success<Type> extends Response {  
  final Type data;  
  Success(this.data);  
}  
  
class Failure extends Response {  
  final Error error;  
  Failure(this.error);  
}  
  
String toString(Response response) => switch (response) {  
      // Can access \`response.data\` without an instance check!  
      Success \_ => response.data.toString(),  
      Failure \_ => response.error.toString(),  
    };  
String toTypeString(Response response) => switch (response) {  
      Success \_ => 'Success',  
      Failure \_ => 'Failure',  
    };
```

[Records (aka n-tuple)](https://dart.dev/language/records)
----------------------------------------------------------

*   **What they are:** Allow you to return multiple values from one function / assign to one variable
*   **Why you should care:** They’re a great shorthand that allows you not to need to write a full class. It can be great for simple stuff (like lat/lon and x/y). But can also be good for more [complicated use cases](https://stackoverflow.com/a/71178612/1759443) involving threading.

```dart
// Function return  
(double lat, double lon) geoLocation(String name) =>  
    (231.23, 36.8219);  
  
void examples() {  
  // Variable declaration / assignment  
  (String, int) record;  
  record = ('A string', 123);  
  
  // Named-args  
  ({int a, bool b}) record;  
  record = (a: 123, b: true);  
  
  // Accessing them!  
  var record = ('first', a: 2, b: true, 'last');  
  print(record.$1); // Prints 'first'  
  print(record.a); // Prints 2  
  print(record.b); // Prints true  
  print(record.$2); // Prints 'last'  
}
```

[Switches inside of widgets (instead of ternary and if()…\[\])](https://dart.dev/language/branches#switch-expressions)
----------------------------------------------------------------------------------------------------------------------

*   **What they are:** Use patterns and multi-way branching in contexts where a statement isn’t allowed
*   **Why you should care:** Using if/elses (or chained ternaries) in Flutter’s `build` is pretty awkward. Now you can use a switch statement that behaves like an if using the new pattern-matching syntax that lets you do cool stuff because `_` is a wildcard match.

```dart
switch (state) {  
  \_ when state == 'loading' => const Text('Loading...'),  
  \_ when state == 'content' => const Text('My content widget goes here'),  
  // Else case  
  \_ => const Text('Unknown state encountered'),  
},

return TextButton(  
  onPressed: \_goPrevious,  
  child: Text(switch (page) {  
    0 => 'Exit story',  
    1 => 'First page',  
    \_ when page == \_lastPage => 'Start over',  
    \_ => 'Previous page',  
  }),  
);
```

[Destructuring via pattern matching](https://dart.dev/language/patterns)
------------------------------------------------------------------------

*   **What they are:** Shorthand to extract properties from classes, records, and lists and assign them to individual variables
*   **Why you should care:** You may be tempted to pass an entire object around because it's more verbose to access each of its properties. Now you can assign multiple variables at once.

```dart
class Person {  
  String name;  
  int age;  
  Person({this.name = 'John', this.age = 30});  
}  
  
void examples() {  
  // Records  
  final (lat, lon) = geoLocation('Nairobi');  
  // Class  
  final Person person = Person(name: 'John', age: 30);  
  final Person(:name, :age) = person;  
  print('Name $name, age $age');  
  // Lists  
  var numList = \[1, 2, 3\];  
  var \[a, b, c\] = numList;  
}
```

New list extensions
-------------------

*   **What they are:** Helper functions you can call on list
*   **Why you should care:** No more index out-of-bounds issues when trying to access first, last, or finding elements!

nonNulls, firstOrNull, lastOrNull, singleOrNull, elementAtOrNull and indexed on Iterables.

```dart
final list = \[\]  
// Do this  
final lastElement = list.lastOrNull()  
// Instead of this  
final lastElement = list\[list.length - 1\]
```

[Class modifiers](https://dart.dev/language/class-modifiers#sealed)
-------------------------------------------------------------------

TL;DR: Use `abstract interface` for a traditional `interface` . Use `abstract` for traditional abstract class. Use `final` for regular classes if they shouldn’t be overridden.

This table is a simplified version of the [full spec table](https://github.com/dart-lang/language/blob/main/accepted/future-releases/class-modifiers/feature-specification.md#syntax)
>
{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/dart-3-0-best-new-features-why-you-should-care/1_Y2RRXyRwfazdWDUpsPcmew.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

I already found class modifiers weird in Dart, and now they’re weirder (but in a powerful way!). I’m going to cover only the new stuff.

The first thing you need to get is the [difference](https://stackoverflow.com/a/55296588/1759443) between `implements` and `extends` . These concepts existed in Dart 2.x, but get expanded on.

*   `implements` = Your sub-class has the exact same “shape” (fields/functions) as the parent class but must define all its own behavior. You do not inherit any functionality from the parent's functions or fields. It’s similar to other languages, but you can `implement` just about any class (regardless of modifier)
*   `extends` = Your sub-class can extend (override) behavior, **inherit behavior**, and implement behavior

**final**

*   **What it is:** You cannot extend or implement the class outside of the file it's defined in
*   **Why you should care:** This is core for the concept of [encapsulation](https://en.wikipedia.org/wiki/Encapsulation_(computer_programming)). By preventing a class from being subclassed, you ensure that the class behavior can’t be altered in unexpected ways, and you can keep the internals of the class hidden.

```dart
// -- File a.dart  
final class FinalClass {}  
  
// -- File b.dart  
// Not allowed  
class ExtensionClass extends FinalClass{}  
// Not allowed  
class ExtensionClass implements FinalClass{}
```

**interface**

*   **What it is:** Can only be implemented (not extended) outside the file it’s defined in. But you still have to define function bodies (that get thrown out?)
*   **Why you should care:** Similar to ‘final’, it makes your system more predictable. If you implement an interface, you’re not getting functionality from anywhere else other than the class you’re looking at.

```dart
// -- File a.dart  
interface class InterfaceClass {  
  String name = 'Dave'; // Allowed  
  void body() { print('body'); } // Allowed  
  
  int get myField; // Not allowed  
  void noBody(); // Not allowed  
} 
// -- File b.dart  
// Not allowed  
class ExtensionClass extends InterfaceClass{}  
// Allowed  
class ConcreteClass implements InterfaceClass{  
  // Have to override everything  
  @override  
  String name = 'ConcreteName';  
  @override  
  void function() { print('body'); }  
}
```

**abstract interface**

*   **What is it:** More like a traditional interface. Can only be implemented (not extended). But you can define functions without bodies.
*   **Why you should care**: You can define just the “shape” without defining **any** functionality. There’s nothing hidden in the parent class.

```dart
// -- File a.dart  
abstract interface class AbstractInterfaceClass {  
  String name = 'Dave'; // Allowed  
  void body() { print('body'); } // Allowed  
    
  // This is a more traditional implementation  
  int get myField; // Allowed  
  void noBody(); // Allowed  
}  
  
// -- File b.dart  
// Not allowed  
class ExtensionClass extends AbstractInterfaceClass{}  
// Allowed  
class ConcreteClass implements InterfaceClass{  
  // Have to override everything  
  @override  
  String name = 'ConcreteName';  
  @override  
  void function() { print('body'); }  
  
  @override  
  int get myField => 5  
  @override  
  void noBody() = print('concreteBody')  
}

```

**abstract class**

*   **What is it:** Can be implemented and extended. Can have bodies with functionality the children inherit or no bodies the children have to implement.
*   **Why you should care**: You can build very powerful class hierarchies that define reusable bits of logic. But this also comes with the curse of the unpredictability of how something behaves (based on where you are in the hierarchy)

```dart
// -- File a.dart  
abstract class AbstractClass {  
  String name = 'Dave'; // Allowed  
  void body() { print('body'); } // Allowed  
  
  int get myField; // Allowed  
  void noBody(); // Allowed  
}  
  
// -- File b.dart  
// Allowed!  
class ExtensionClass extends AbstractClass{...}  
// Allowed  
class ConcreteClass implements AbstractClass {  
  // Only have to override things with no body  
  @override  
  int get myField => 5  
  @override  
  void noBody() = print('concreteBody')  
}
```