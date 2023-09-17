---
title: "Estimating Square Roots in Your Head"
description: "I explore an ancient algorithm, sometimes called Heron's method, for estimating square roots without a calculator."
summary: "The following is an explanation on an old method to quickly estimate the *square root* of a number in your brain."
keywords: ['gregory gundersen', 'math', 'square root']
date: 2023-02-03T10:37:56+0000
draft: false
categories: ['reads']
tags: ['reads', 'gregory gundersen', 'math', 'square root']
---

The following is an explanation on an old method to quickly estimate the *square root* of a number in your brain. The algorithm explanation is really to understand and it gives the feeling of a math hack that we can use to enhance our thinking process. The remaining sections are more about technical math stuff which can be hard to understand.

https://gregorygundersen.com/blog/2023/02/01/estimating-square-roots/

---

Imagine we want to compute the square root of a number n. The basic idea of [_Heron’s method_](https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Heron's_method), named after the mathematician and engineer, Heron of Alexandria, is to find a number g that is close to n​ and to then average that with the number n/g, which corrects for the fact that g either over- or underestimates n​.

I like this algorithm because it is simple and works surprisingly well. However, I first learned about it in [(Benjamin & Shermer, 2006)](#benjamin2006secrets), which did not provide a particularly deep explanation or analysis for _why_ this method works. The goal of this post is to better understand Heron’s method. How does it work? Why does it work? And how good are the estimates?

The algorithm
-------------

Let’s demonstrate the method with an example. Consider computing the square root of n\=33. We start by finding a number that forms a perfect square that is close to 33. Here, let’s pick g\=6, since 62\=36. Then we compute a second number, b\=n/g. In practice, computing b in your head may require an approximation. Here, we can compute it exactly as 33/6\=5.5. Then our final guess is the average of these two numbers or

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/1.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

which in our example is

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/2.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

That is pretty good. The relative error is less than 0.1%! And furthermore, this is pretty straightforward to do in your head when n isn’t too large.

Why does this work?
-------------------

Intuitively, Heron’s method works because g is either an over- or underestimate of n​. Then n/g is an under- or overestimate, respectively, of n​. So the average of g and n/g should be closer to n​ than either g or n/g is.

While this was probably Heron’s reasoning, we can offer a better explanation using calculus: Heron’s method works because we’re performing a second-order Taylor approximation around our initial guess. Put more specifically, we’re making a linear approximation of the nonlinear square root function at the point g2.

To see this, recall that the general form of a Taylor expansion about a point a is

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/3.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

where the notation f(k) denotes the k\-th derivative of f. If we define f(x)\=x​, then

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/4.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

and so the second-order Taylor approximation of x​ is

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/5.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Now choose x\=n, and let h(x) denote the Taylor expansion around a\=g2. Then we have

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/6.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

And this is exactly what we calculated above.

Geometric interpretation
------------------------

In general, the second second-order Taylor expansion approximates a possibly nonlinear function f(x) with a linear function at the point a:

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/7.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Thus, the Taylor approximation represents the tangent line to f(x) at the point (a,f(a)). We can see this for f(x)\=x​ in Figure 1. This is a useful visualization because it highlights something interesting: we expect Heron’s approximation to be worse for smaller numbers. That’s because the square root function is “more curved” (speaking loosely) for numbers closer to zero (Figure 2, left). As the square root function flattens out for larger numbers, the linear approximation improves (Figure 2, right).

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/linear_approx.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Figure 1. A visualization of Heron's method, or a second-order Taylor approximation of f(x)\=x​. We construct a linear approximation h(x) (red dashed line) to the nonlinear function f(x) (blue line). We then guess h(n) (black dot). Our error is the absolute vertical difference between h(n) (black dot) and n​ (blue dot).

How good is the approximation?
------------------------------

How good is this method? Did we just get lucky with n\=33 or does Heron’s method typically produce sensible estimates of n​?

To answer this question, I’m replicating a nice figure from an article from [MathemAfrica](http://www.mathemafrica.org/?p=13041), in which the author makes a plot with the input number n on the x\-axis and the absolute error

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/8.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

on the y\-axis (Figure 2, blue line). (Note that when programming Heron’s method, we must decide if we want to find g2 by searching numbers greater or less than n; here, I’ve set g as the first integer less than the square root of n, or as `g = floor(sqrt(n))`.) I like this figure because it captures two interesting properties of Heron’s method. First, as we discussed above, the Taylor approximation will typically be worse when n is small (when f(x)\=x​; this is not true in general). And second, the error drops to zero on perfect squares and increases roughly linearly between perfect squares.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/errors.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

Figure 2. The absolute (blue) and relative (red) errors between the true value n​ and the estimate using Heron's approximation h(n). The errors are zero when n is a perfect square and are smaller on average for small n than for large n.

The MathemAfrica post focuses on lowering this absolute error by judiciuosly picking the initial guess g. This is interesting as analysis. However, in my mind, this is unnecessarily complicated for most practical mental math scenarios, i.e. for quick sanity checking rather than in a demonstration or competition. Why it is overly complicated? Well, the _relative error_,

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/estimating-square-root-in-your-head/9.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}

rapidly decays to less than a percentage point or so (Figure 2, red line).

If you’re not using a calculator to compute a square root, you’re probably just getting a rough idea of a problem. And if we actually wanted to lower the absolute error and didn’t care about a human’s mental limits, we should just expand the Taylor approximation to higher orders.