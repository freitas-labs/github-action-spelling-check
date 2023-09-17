---
title: "Applications of Category Theory"
description: "Category theory studies mathematical structure: categories of objects (intentionally undefined, but could be a set, topological space, groups, or anything else) and the mappings of those objects between categories (morphisms). You can think of morphisms as the “arrow” that maps between categories. Morphisms can be functions (but don’t have to be) and might be composed (similar to functions)."
summary: "The following is a brief summary (with examples) of what category theory is."
keywords: ['matt rickard', 'functional programming', 'haskell', 'monad']
date: 2023-05-02T06:42:01.700Z
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'functional programming', 'haskell', 'monad']
---

The following is a brief summary (with examples) of what category theory is.

https://blog.matt-rickard.com/p/applications-of-category-theory

---

Category theory studies mathematical structure: categories of objects (intentionally undefined, but could be a set, topological space, groups, or anything else) and the mappings of those objects between categories (morphisms). 

You can think of morphisms as the “arrow” that maps between categories. Morphisms can be functions (but don’t have to be) and might be composed (similar to functions). 

Category theory is abstract enough to be applied to many concepts outside mathematics. Here are a few examples:

Some examples:

*   Functional programming languages: Haskell and other functional programming languages make use of category theory. Objects are types. Morphisms are functions. Monads come straight from category theory.
    
*   Database Schema: Tables as objects, foreign key constraints as morphisms. 
    
*   Linear algebra: Vector spaces as objects, linear transformations as morphisms. 
    
*   Graph theory: Graphs as objects, graph homomorphisms as morphisms.
    
*   Logic and type theory: propositions as objects, proofs that transform one proposition into another as morphisms. For example, modus ponens as the morphism (“If P, then Q” and P is true, then Q is true) and the implication “if P, then Q” and fact “P is true” as the objects. 
    
*   [Declarative programming](https://bartoszmilewski.com/2015/04/15/category-theory-and-declarative-programming/)
    

For more in-depth examples and analysis (yet still accessible), there’s [Category Theory for Programmers](https://bartoszmilewski.com/2014/10/28/category-theory-for-programmers-the-preface/).