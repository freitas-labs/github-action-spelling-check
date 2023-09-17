---
title: "Go Generics Cheat Sheet"
description: 'Learn how to create type-independent functions'
summary: "A in depth cheat sheet for hacking with generics in Golang"
keywords: ['gosamples.dev', 'go', 'generics', 'cheatsheet']
date: 2023-01-08T10:41:20+0000
draft: false
categories: ['reads']
tags: ['reads', 'gosamples.dev', 'go', 'generics', 'cheatsheet']
---

The following is a complete in depth cheat sheet for hacking with generics in Golang. Generics are like a *grenade*. They are expensive and can be used **in proper and improper ways**.

Some people refer generics as a way to achieve untyped functions, but they are more than that. In Go, you can type functions with **multiple types** with generics, and that's pretty neat and cool. More on that on the cheatsheet.

https://gosamples.dev/generics-cheatsheet

---

Getting started
---------------

### Generics release

Generics in Go are available since the version 1.18, released on [March 15, 2022](/check-go-version#go-golang-version-history).

### Generic function

With Generics, you can create functions with types as parameters. Instead of writing separate functions for each type like:

```golang
    func LastInt(s []int) int {
        return s[len(s)-1]
    }
    
    func LastString(s []string) string {
        return s[len(s)-1]
    }
    
    // etc.
```    

you can write a function with a type parameter:

```golang
    func Last[T any](s []T) T {
        return s[len(s)-1]
    }
```    

Type parameters are declared in square brackets. They describe types that are allowed for a given function:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/go-generics-cheatsheet/generic-function.webp"
    caption=""
    alt=`Diagram on how the generic function looks like`
    class="row flex-center"
>}}

### Generic function call

You can call a generic function like any other function:

```golang
    func main() {
        data := []int{1, 2, 3}
        fmt.Println(Last(data))
    
        data2 := []string{"a", "b", "c"}
        fmt.Println(Last(data2))
    }
```    

You do not have to explicitly declare the type parameter as in the example below, because it is inferred based on the passed arguments. This feature is called _type inference_ and applies only to functions.

```golang
    func main() {
        data := []int{1, 2, 3}
        fmt.Println(Last[int](data))
    
        data2 := []string{"a", "b", "c"}
        fmt.Println(Last[string](data2))
    }
```    

However, explicitly declaring concrete type parameters is allowed, and sometimes necessary, when the compiler is unable to unambiguously detect the type of arguments passed.

Constraints
-----------

### Definition

A constraint is an interface that describes a type parameter. Only types that satisfy the specified interface can be used as a parameter of a generic function. The constraint always appears in square brackets after the the type parameter name.

In the following example:

```golang
    func Last[T any](s []T) T {
        return s[len(s)-1]
    }
```    

the constraint is `any`. Since Go 1.18, `any` is an alias for `interface{}`:

```golang
    type any = interface{}
```    

The `any` is the broadest constraint, which assumes that the input variable to the generic function can be of any type.

### Built-in constraints

In addition to the `any` constraint in Go, there is also a built-in `comparable` constraint that describes any type whose values can be compared, i.e., we can use the `==` and `!=` operators on them.

```golang
    func contains[T comparable](elems []T, v T) bool {
        for _, s := range elems {
            if v == s {
                return true
            }
        }
        return false
    }
```    

### The `constraints` package

More constraints are defined in the [`x/exp/constraints`](https://pkg.go.dev/golang.org/x/exp/constraints) package. It contains constraints that permit, for example, ordered types (types that support the operators `<`, `<=`, `>=`, `>`), floating-point types, integer types, and some others:

```golang
    func Last[T constraints.Complex](s []T) {}
    func Last[T constraints.Float](s []T) {}
    func Last[T constraints.Integer](s []T) {}
    func Last[T constraints.Ordered](s []T) {}
    func Last[T constraints.Signed](s []T) {}
    func Last[T constraints.Unsigned](s []T) {}
```    

Check the documentation of the [`x/exp/constraints`](https://pkg.go.dev/golang.org/x/exp/constraints) package for more information.

### Custom constraints

Constraints are interfaces, so you can use a custom-defined interface as a constraint on a function type parameter:

```golang
    type Doer interface {
        DoSomething()
    }
    
    func Last[T Doer](s []T) T {
        return s[len(s)-1]
    }
```    

However, using such an interface as a constraint is no different from using the interface directly.

As of Go 1.18, the interface definition has a new syntax. Now it is possible to define an interface with a type:

```golang
    type Integer interface {
        int
    }
```

Constraints containing only one type have little practical use. But, when combined with the union operator `|`, we can define _type sets_ without which complex constraints cannot exist.

### Type sets

Using the union `|` operator, we can define an interface with more than one type:

```golang
    type Number interface {
        int | float64
    }
```

This type of interface is a _type set_ that can contain types or other types sets:

```golang
    type Number interface {
        constraints.Integer | constraints.Float
    }
```

Type sets help define appropriate constraints. For example, all constraints in the [`x/exp/constraints`](https://pkg.go.dev/golang.org/x/exp/constraints) package are type sets declared using the union operator:

```golang
    type Integer interface {
        Signed | Unsigned
    }
```   

### Inline type sets

Type set interface can also be defined inline in the function declaration:

```golang
    func Last[T interface{ int | int8 | int16 | int32 }](s []T) T {
        return s[len(s)-1]
    }
``` 

Using the simplification that Go allows for, we can omit the `interface{}` keyword when declaring an inline type set:

```golang
    func Last[T int | int8 | int16 | int32](s []T) T {
        return s[len(s)-1]
    }
```

### Type approximation

In many of the constraint definitions, for example in the [`x/exp/constraints`](https://pkg.go.dev/golang.org/x/exp/constraints) package, you can find the special operator `~` before a type. It means that the constraint allows this type, as well as a type whose underlying type is the same as the one defined in the constraint. Take a look at the example:

```golang
    package main
    
    import (
        "fmt"
    )
    
    type MyInt int
    
    type Int interface {
        ~int | int8 | int16 | int32
    }
    
    func Last[T Int](s []T) T {
        return s[len(s)-1]
    }
    
    func main() {
        data := []MyInt{1, 2, 3}
        fmt.Println(Last(data))
    }
```

Without the `~` before the `int` type in the `Int` constraint, you cannot use a slice of `MyInt` type in the `Last()` function because the `MyInt` type is not in the list of the `Int` constraint. By defining `~int` in the constraint, we allow variables of any type whose underlying type is `int`.

Generic types
-------------

### Defining a generic type

In Go, you can also create a generic type defined similarly to a generic function:

```golang
    type KV[K comparable, V any] struct {
        Key   K
        Value V
    }
    
    func (v *KV[K, V]) Set(key K, value V) {
        v.Key = key
        v.Value = value
    }
    
    func (v *KV[K, V]) Get(key K) *V {
        if v.Key == key {
            return &v.Value
        }
        return nil
    }
```

Note that the method receiver is a generic `KV[K, V]` type.

When defining a generic type, you cannot introduce additional type parameters in its methods - the struct type parameters are only allowed.

### Example of usage

When initializing a new generic struct, you must explicitly provide concrete types:

```golang
    func main() {
        var record KV[string, float64]
        record.Set("abc", 54.3)
        v := record.Get("abc")
        if v != nil {
            fmt.Println(*v)
        }
    }
```

You can avoid it by creating a constructor function since types in functions can be inferred thanks to the _type inference_ feature:

```golang
    func NewKV[K comparable, V any](key K, value V) *KV[K, V] {
        return &KV[K, V]{
            Key:   key,
            Value: value,
        }
    }
    
    func main() {
        record := NewKV("abc", 54.3)
        v := record.Get("abc")
        if v != nil {
            fmt.Println(*v)
        }
        NewKV("abc", 54.3)
    }
```