---
title: "Flutter Test Ultimate Cheat Sheet"
description: 'An ultimate cheat sheet for assertions in Dart and Flutter tests with many details explained!'
summary: "A clean, interactive and in depth cheat sheet for the bultin Flutter testing framework"
keywords: ['anna leushchenko', 'flutter', 'test', 'cheatsheet']
date: 2023-01-04T22:04:37+0000
draft: false
categories: ['reads']
tags: ['anna leushchenko', 'flutter', 'test', 'cheatsheet']
---

The following is a complete in depth cheat sheet for Flutter builtin testing framework. If you ever need to craft tests in Flutter, make sure to revisit this cheat sheet.

https://invertase.io/blog/assertions-in-dart-and-flutter-tests-an-ultimate-cheat-sheet

---

Tests are essential for ensuring any software quality. Whether you are creating unit, widget, or integration tests for Flutter applications, the end goal of any test is asserting that the reality matches the expectations. Here is an ultimate cheat sheet for assertions in Dart and Flutter tests with many details explained!

Cheat sheet
-----------

Flutter Tests

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/cheat-sheet.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Each of the items in this cheat sheet is discussed in greater detail in this article.

Check the [official website](https://docs.flutter.dev/testing) for the overall approach to testing Flutter apps.

Expect
------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/expect-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

`expect()` is the main assertion function. Let’s take a look at this test:

    test('expect: value ✅', () {
      final result = 0;
      expect(result, 0);
    });

where `result` is a value that would typically come from software under test.

Here, `expect()` ensures that the result is `0`. If it is different, it will throw the `TestFailure` exception, leading to test failure.

Additionally, `expect()` prints the description of the problem to the output. For example, for this test:

    test('expect: value ❌', () {
      final result = 1;
      expect(result, 0);
    });

We’ll see the following output:

    Expected: <0>
      Actual: <1>

Here is the full signature of the `expect()` method:

    void expect(
        dynamic actual,       // actual value to be verified
        dynamic matcher, {    // characterises the expected result
        String? reason,       // added to the output in case of failure
        dynamic skip,         // true or a String with the reason to skip
    }) {...}

`expect()` accepts an optional `reason` that can be added to the output. For this test:

    test('expect: reason ❌', () {
      final result = 1;
      expect(result, 0, reason: 'Result should be 0!');
    });

The output is:

    Expected: <0>
      Actual: <1>
    Result should be 0!

`expect()` also accepts an optional `skip` that can be either `true` or a `String`:

    test('expect: skip ✅', () {
      final result = 1;
      expect(result, 0, skip: true);
      expect(result, 0, skip: 'for a reason');
    });

This test succeeds with the following output:

    Skip expect: (<0>).
    Skip expect: for a reason

**Attention!** The usage of the `skip` parameter does not skip the entire test, but only the `expect()` call it is applied to.

Next, we will focus on the `matcher` parameter of the `expect()` method and explore what values it can accept.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/Frame-18.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Matcher
-------

Matcher is an instance that validates that the value satisfies some expectation based on the matcher type. It is either a child of the `Matcher` base class or a value. Matcher is also responsible for providing a meaningful description of a mismatch in case of test failure.

Keep reading to learn about the variety of available matchers.

Matcher equals
--------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/equals-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

In the example below, we pass `0` as a `matcher` parameter:

    test('expect: value ✅', () {
      final result = 0;
      expect(result, 0);
    });

In such a case, when the value is passed, an `equals` matcher is used implicitly. It is equivalent to:

    test('matcher: equals ✅', () {
      final result = 0;
      expect(result, equals(0));
    });

It is probably the most commonly used matcher, explicitly or implicitly.

The `equals` matcher uses the equality operator to perform the comparison. By default, classes in Dart are compared “by reference” and not “by value”. Thus, if applied to custom objects like this `Result` class here:

    class Result {
      Result(this.value);
    
      final int value;
    }

`equals` matcher fails this test:

    test('expect: equals ❌', () {
      final result = Result(0);
      expect(result, equals(Result(0)));
    });

With the following output:

    Expected: <Instance of 'Result'>
      Actual: <Instance of 'Result'>

It is a good idea to override the `.toString()` method to make the output more meaningful. For this improved `Result` class implementation:

    class Result {
      Result(this.value);
    
      final int value;
    
      @override
      String toString() => 'Result{value: $value}';
    }

The test output changes to:

    Expected: Result:<Result{value: 0}>
      Actual: Result:<Result{value: 0}>

To make it pass, the `Result` class has to override the `operator ==`, for example like this:

    class Result {
      Result(this.value);
    
      final int value;
    
      @override
      String toString() => 'Result{value: $value}';
    
      @override
      bool operator ==(Object other) =>
          identical(this, other) ||
          other is Result &&
              runtimeType == other.runtimeType &&
              value == other.value;
    
      @override
      int get hashCode => value.hashCode;
    }

Equality matchers
-----------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/equality-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Apart from an `equals` matcher that compares objects with `operator ==`, and is used implicitly when an expected value is passed instead of a matcher; there are more explicit equality matchers.

### same

The `same` matcher makes sure expected and actual results are the same instance. This test:

    test('expect: same ❌', () {
      final result = Result(1);
      expect(result, same(Result(1)));
    });

Fails with the following output:

    Expected: same instance as Result:<Result{result: 1}>
      Actual: Result:<Result{result: 1}>

But this test passes:

    test('expect: same ✅', () {
      final result = Result(1);
      expect(result, same(result));
    });

Interesting observation regarding `const`. This test also passes:

    test('expect: same ✅', () {
      final result = 1;
      expect(result, same(1));
    });

Because `1` is a `const` and only one instance exists in memory. The same applies when custom classes declare `const` constructors and instances are created with `const` modifiers. If the `Result` class is updated to declare a `const` constructor:

    class Result {
      const Result(this.value);
    
      final int value;
    }

This test also passes:

    test('expect: same ✅', () {
      final result = const Result(1);
      expect(result, same(const Result(1)));
    });

But this test still fails:

    test('expect: same ❌', () {
      final result = Result(1);
      expect(result, same(Result(1)));
    });

because without using `const`, two different instances of `Result` are created.

### null matchers

The next pair of matchers is quite simple: `isNull` and `isNotNull` check `result` nullability.

    test('expect: isNull ❌', () {
      final result = 0;
      expect(result, isNull);
    });

Fails with:

    Expected: null
      Actual: <0>

And this test passes:

    test('expect: isNotNull ✅', () {
      final result = 0;
      expect(result, isNotNull);
    });

### bool matchers

The next pair of equality matchers is self-explanatory: `isTrue` and `isFalse`. These tests pass:

    test('expect: isTrue ✅', () {
      final result = 0;
      expect(result < 1, isTrue);
    });

    test('expect: isFalse ✅', () {
      final result = 0;
      expect(result > 1, isFalse);
    });

### anything

The `anything` matcher matches any value. It is used in `any` from [mockito](https://pub.dev/packages/mockito) package or `any<T>` from [mocktail](https://pub.dev/packages/mocktail), which we’ll probably discuss later. However, it’s not a commonly used matcher in client application tests.

Type matchers
-------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/type-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

### isA

The `isA<T>` matcher helps verify a variable type:

    test('expect: isA ❌', () {
      final result = 0;
      expect(result, isA<Result>());
    });

This test fails with the following output:

    Expected: <Instance of 'Result'>
      Actual: <0>

### Predefined type matchers

There are a couple of more focused type matchers: `isList` and `isMap`. These tests pass:

    test('expect: isList ✅', () {
      final result = [0];
      expect(result, isList);
    });

    test('expect: isMap ✅', () {
      final result = {0: Result(0)};
      expect(result, isMap);
    });

### Custom type matcher

It is very easy to create your focused type matcher using `TypeMatcher` class:

    const isResult = TypeMatcher<Result>();

That’s it; now it can be used in tests:

    test('expect: isResult ✅', () {
      final result = Result(0);
      expect(result, isResult);
    });

Error matchers
--------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/error-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

### Error type matchers

Error-type matchers are based on the `TypeMatcher` class from the example above, as they check for the error type: `isArgumentError`, `isException`, `isNoSuchMethodError`, `isUnimplementedError`, etc.

    test('expect: isUnimplementedError ✅', () {
      final result = UnimplementedError();
      expect(result, isUnimplementedError);
    });

### throwsA

`throwsA` is a matcher that ensures the method call resulted in an error. If the method call is supposed to throw, it’s unsafe to call it in the test body. Instead, it should be called inside the `expect()` call. `throwsA` matcher accepts another matcher that validates the error, for example, one of the error matchers above:

    test('expect: throwsA ✅', () {
      final result = (int value) => (value as dynamic).length;
      expect(() => result(0), throwsA(isNoSuchMethodError));
    });

Collection matchers
-------------------

By “collection” I mean `String`, `Iterable`, and `Map`.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/collection-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

### Size matchers

The pair of `isEmpty` and `isNotEmpty` matchers call respective `.isEmpty` or `.isNotEmpty` getters on a `result`, and expect them to return `true`:

    test('expect: isEmpty ✅', () {
      final result = [];
      expect(result, isEmpty);
    });

    test('expect: isEmpty ❌', () {
      final result = '0';
      expect(result, isEmpty);
    });

    test('expect: isNotEmpty ✅', () {
      final result = {0: '0'};
      expect(result, isNotEmpty);
    });

When used with the type that does not have `isEmpty` or `isNotEmpty` methods:

    test('expect: isEmpty ❌', () {
      final result = 0;
      expect(result, isNotEmpty);
    });

`isEmpty` and `isNotEmpty` matchers fail the test with the following output:

    Expected: non-empty
      Actual: <0>
    NoSuchMethodError: Class 'int' has no instance getter 'isNotEmpty'.
    Receiver: 0
    Tried calling: isNotEmpty

The `hasLength` matcher follows the same principle and calls `.length` getter on the passed value:

    test('expect: hasLength ✅', () {
      final result = '0';
      expect(result, hasLength(1));
    });

When the value does not have a `.length` getter:

    test('expect: hasLength ❌', () {
      final result = 0;
      expect(result, hasLength(1));
    });

The test fails:

    Expected: an object with length of <1>
      Actual: <0>
       Which: has no length property

### Content matchers

The `contains` matcher has different logic depending on the value it is applied to.

For a `String` it means substring matching:

    test('expect: contains ✅', () {
      final result = 'result';
      expect(result, contains('res'));
    });

For a `Map` it means the map has the key:

    test('expect: contains ✅', () {
      final result = {0: Result(0)};
      expect(result, contains(0));
    });

And for `Iterable` it means there is an element matching the matcher that is passed inside `contains` matcher. In this test first a `predicate` matcher is used, and then an implicit `equals`:

    test('expect: contains ✅', () {
      final result = [Result(0), Result(1)];
      expect(result, contains(predicate((r) => r.value == 0)));
      expect(result, contains(Result(1)));
    });

The `isIn` matcher is the opposite to the `contains` matcher:

    test('expect: isIn ✅', () {
      final result = 'res';
      expect(result, isIn('result'));
    });

    test('expect: isIn ✅', () {
      final result = Result(0);
      expect(result, isIn([Result(0), Result(1)]));
    });

String matchers
---------------

In addition to the collection matchers above that work for `String`, there is a couple of matchers more.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/string-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

### Content matchers

`startsWith`, `endsWith` matchers check `String` content along the edges:

    test('expect: startsWith ✅', () {
      final result = 'result';
      expect(result, startsWith('res'));
    });

    test('expect: endsWith ✅', () {
      final result = 'result';
      expect(result, endsWith('ult'));
    });

### matches

The `matches` matcher can either accept another `String`:

    test('expect: matches ✅', () {
      final result = 'result';
      expect(result, matches('esul'));
    });

or a `RegExp`:

    test('expect: matches ✅', () {
      final result = 'result';
      expect(result, matches(RegExp('r[a-z]{4}t')));
    });

Iterable matchers
-----------------

In addition to the collection matchers above that work for `List` and `Set`, there are a few more matchers.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/iterable-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

### every & any

Matchers `everyElement` and `anyElement` verify that all or some elements satisfy a matcher or equal to a value they accepted as a parameter:

    test('expect: everyElement ✅', () {
      final result = [Result(0), Result(1)];
      expect(result, everyElement(isResult));
    });

    test('expect: anyElement ✅', () {
      final result = {0, 1};
      expect(result, anyElement(0));
    }); 

### Content matchers

Matchers `containsAll` and `containsAllInOrder` verify that the `Iterable` passed as a parameter is a subset of the actual `Iterable`, optionally verifying items’ order:

    test('expect: containsAll ✅', () {
      final result = [Result(0), Result(1), Result(2)];
      expect(result, containsAll([Result(1), Result(0)]));
    });

    test('expect: containsAllInOrder ✅', () {
      final result = {0, 1, 2};
      expect(result, containsAllInOrder({0, 1}));
    });

The actual `Iterable` can have additional elements.

Matchers `orderedEquals` and `unorderedEquals` check that the actual `Iterable` is of the same length and contains the same elements as the passed `Iterable`, optionally verifying items’ order:

    test('expect: orderedEquals ✅', () {
      final result = [Result(0), Result(1)];
      expect(result, orderedEquals([Result(0), Result(1)]));
    });

    test('expect: unorderedEquals ✅', () {
      final result = {0, 1};
      expect(result, unorderedEquals({1, 0}));
    });

Map matchers
------------

In addition to collection matchers that work for `Map`, there are just a couple more.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/map-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

The `containsValue` matcher checks if the actual `.containsValue` method returns true:

    test('expect: containsValue ✅', () {
      final result = {0: Result(0)};
      expect(result, containsValue(Result(0)));
    });

The `containsPair` matcher checks both pair’s key and value, where the value can be another matcher:

    test('expect: containsPair ✅', () {
      final result = {0: Result(0)};
      expect(result, containsPair(0, isResult));
      expect(result, containsPair(0, Result(0)));
    });

Numeric matchers
----------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/numeric-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

### Zero-oriented matchers

`isZero`, `isNonZero`, `isPositive`, `isNonPositive`, `isNegative`, `isNonNegative` mathers all check how the actual value is related to `0`:

    test('expect: isZero ✅', () {
      final result = 0;
      expect(result, isZero);
    });

    test('expect: isZero ✅', () {
      final result = 1;
      expect(result, isPositive);
    });

### Range matchers

`inInclusiveRange`, `inExclusiveRange` matchers check if the actual `num` value is in the range:

    test('expect: inInclusiveRange ✅', () {
      final result = 1;
      expect(result, inInclusiveRange(0, 1));
    });

    test('expect: inExclusiveRange ❌', () {
      final result = 1;
      expect(result, inExclusiveRange(0, 1));
    });

Comparable matchers
-------------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/comparable-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Matchers `greaterThan`, `greaterThanOrEqualTo`, `lessThan`, `lessThanOrEqualTo` use `operator ==,` `operator <`, and `operator >` to compare expected and actual values:

    test('expect: greaterThan ✅', () {
      final result = 1;
      expect(result, greaterThan(0));
    });

    test('expect: lessThanOrEqualTo ✅', () {
      final result = 1;
      expect(result, lessThanOrEqualTo(1));
    });

They can be applied not only to numeric values but also to custom classes. To use them in our `Result` class, it has to be improved with `operator <` and `operator >` implementations:

    class Result {
      const Result(this.value);
    
      final int value;
    
      ...
    
      @override
      bool operator ==(Object other) =>
          identical(this, other) ||
          other is Result &&
              runtimeType == other.runtimeType &&
              value == other.value;
    
      bool operator >(Object other) =>
          other is Result &&
              value > other.value;
    
      bool operator <(Object other) =>
          other is Result &&
              value < other.value;
    }

As you see, I am comparing `Result` objects by the inner `value` field. Now, these tests also pass:

    test('expect: greaterThan ✅', () {
      final result = Result(1);
      expect(result, greaterThan(Result(0)));
    });

    test('expect: lessThanOrEqualTo ✅', () {
      final result = Result(1);
      expect(result, lessThanOrEqualTo(Result(1)));
    });

Universal matcher
-----------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/universal-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Generally speaking, most types of checks a developer might ever need to perform in `expect()` methods can be expressed with a single matcher – `predicate`. It accepts a predicate – a `Function` with one parameter that returns `bool`, where you can decide if the parameter matches your expectations. For example:

    test('expect: predicate ✅', () {
      final result = Result(0);
      expect(result, predicate((e) => e is Result && e.value == 0));
      expect(result, predicate((result) => result.value == 0));
    });

Depending on the type of required check, `predicate` might be exactly the matcher you need. But there is a bunch of more focused matchers which provide more readable code and output. Let’s compare.

A test with a `predicate` matcher:

    test('expect: predicate ❌', () {
      final result = 1;
      expect(result, predicate((e) => e == 0));
    });

It gives the following output:

    Expected: satisfies function
      Actual: <1>

It can be improved with `predicate` matcher `description` parameter. This test:

    test('expect: predicate ❌', () {
      final result = 1;
      expect(result, predicate((e) => e == 0, 'Result should be 0!'));
    });

prints:

    Expected: Result should be 0!
      Actual: <1>

While a test with an `equals` matcher:

    test('expect: equals ❌', () {
      final result = 1;
      expect(result, equals(0));
    });

gives more information about the expected result with less code:

    Expected: <0>
      Actual: <1>

Always prefer using focused matchers when available.

Custom matchers
---------------

If you did not find a matcher that satisfies your requirements, you could create your own matcher.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/custom-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

For example, let’s create a matcher that validates the `value` field. For that, we need a child of `CustomMatcher` class:

    class HasValue extends CustomMatcher {
      HasValue(Object? valueOrMatcher)
          : super(
              'an object with value field of',
              'value field',
              valueOrMatcher,
            );
    
      @override
      Object? featureValueOf(dynamic actual) => actual.value;
    }

The `HasValue` class extends `CustomMatcher` and accepts one parameter, which can be a value or another matcher. It calls the parent constructor with the feature name and description, which will be used in the output if the test fails.

It also overrides the `featureValueOf` method that attempts to get `value` property of the `actual` object passed to `expect()`. It is supposed to work with any type that declares the `value` property, like the `Result` class. In case `actual` does not declare such a property, our `featureValueOf` implementation will throw, but the base `CustomMatcher` class calls it inside `try` / `catch` bloc and will fail the test gracefully.

To be consistent with common practices of declaring a matcher, let’s also declare a factory method to create our matcher:

    Matcher hasValue(Object? valueOrMatcher) => HasValue(valueOrMatcher);

Now it can be used in any of these ways:

    test('expect: hasValue ✅', () {
      final result = Result(0);
      expect(result, hasValue(0));
      expect(result, HasValue(0));
      expect(result, hasValue(equals(0)));
    });

Notice that `hasValue` matcher can accept both `0` and `equals(0)` matcher. In fact, it can accept any other matcher:

    test('expect: hasValue ✅', () {
      final result = Result(0);
      expect(result, hasValue(isZero));
      expect(result, hasValue(lessThan(1)));
    });

In case of a failing test:

    test('expect: hasValue ❌', () {
      final result = Result(1);
      expect(result, hasValue(0));
    });

The output contains the feature name and description passed to `CustomMatcher` constructor:

    Expected: an object with value property of <0>
      Actual: Result: <Result{result: 1}>
       Which: has value property with value <1>

Matcher operators
-----------------

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/operators-i.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

### allOf

The `allOf` matcher allows combining multiple matchers and ensures all of them are satisfied. It can be used with an array of matchers or with up to 7 individual matchers:

    test('expect: allOf ✅', () {
      final result = Result(0);
      expect(result, allOf(hasValue(0), isResult));
      expect(result, allOf([hasValue(0), isResult]));
    });

In case of failure:

    test('expect: allOf ❌', () {
      final result = Result(0);
      expect(result, allOf([hasLength(1), hasValue(1)]));
    });

The output prints errors from the first failed matcher:

    Expected: (an object with length of <1> and an object with value property of <1>)
      Actual: Result:<Result{result: 0}>
       Which: has no length property

### anyOf

The `anyOf` matcher also accepts an array of matchers or up to 7 individual matchers and ensures at least one of them is satisfied:

    test('expect: anyOf ✅', () {
      final result = Result(0);
      expect(result, anyOf(hasLength(1), hasValue(0)));
      expect(result, anyOf([hasLength(1), hasValue(0)]));
    });

Even though `hasLength` matcher fails, the overall test passes.

### isNot

The `isNot` matcher calls the inner matcher and inverts its matching result:

    test('expect: isNot ✅', () {
      final result = 0;
      expect(result, isNot(1));
      expect(result, isNot(isResult));
      expect(result, isNot(allOf(isResult, hasValue(0))));
    });

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/Frame-18.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Remembering them all
--------------------

All mentioned matchers are provided by the [matcher](https://pub.dev/packages/matcher) package.

With so many matchers, it may take a lot of work to remember them all. Let alone the cheat sheet you can have at any time; it’ll be much easier if they all belonged to a single class, for example, `Matcher`. In this case, we could type in `Matcher.`, trigger code completion suggestions, and pick the suitable matcher from the list. It is unlikely ever to become true, but there is a way around which gives almost the same result.

Having `import 'package:flutter_test/flutter_test.dart';` or `import 'package:test/test.dart';` implicitly gives access to all matchers from the `matcher` package. However, importing it explicitly and assigning it a meaningful name, for example `match`, allows using code completion after typing `match.`:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/Screenshot-2022-11-12-at-20.38.54.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/flutter-test-ultimate-cheatsheet/Frame-18.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Afterword
---------

Conclusion

There is still a lot to cover in this topic, including asynchronous matchers, Flutter widget matchers, etc. Stay tuned for more!