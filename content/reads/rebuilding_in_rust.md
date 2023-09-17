---
title: "Rebuilding in Rust"
description: "There's a trend in developer tools and infrastructure – rebuild inefficient parts of the stack in a more high-performance language like Rust. There's ruff by Charlie Marsh, which is an extremely fast python linter that's written in Rust (10-100x faster than existing linters!). Then there's Turbopack, which is a bundler written"
summary: "The following is an explanation to the trend of picking Rust as the language to rebuild a tool or simply to create an whole new product. It goes to show that if you have a big community and hype behind a language, you can convince people to use it, despite being a language that is by nature, complex to use."
keywords: ['matt rickard', 'rust', 'devrel', 'web assembly']
date: 2023-03-09T19:09:14+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'rust', 'devrel', 'web assembly']
---

The following is an explanation to the trend of picking Rust as the language to rebuild a tool or simply to create an whole new product. It goes to show that if you have a big community and hype behind a language, you can convince people to use it, despite being a language that is by nature, complex to use.

https://matt-rickard.ghost.io/rebuilding-in-rust/

---

There's a trend in developer tools and infrastructure – rebuild inefficient parts of the stack in a more high-performance language like Rust. There's [ruff](https://github.com/charliermarsh/ruff?ref=matt-rickard) by Charlie Marsh, which is an extremely fast python linter that's written in Rust (10-100x faster than existing linters!). Then there's [Turbopack](https://turbo.build/?ref=matt-rickard), which is a bundler written in Rust that aims to replace webpack (not to mention [esbuild](https://esbuild.github.io/?ref=matt-rickard), written in Go).

It's not only a chance to take advantage of performance optimizations but to rethink the design of the tool and take advantage of a more modern programming language – NodeJS's (C++) and its successors Deno (Rust) and Bun (Zig). There's [warp](https://www.warp.dev/?ref=matt-rickard), the next-gen terminal written in Rust.

Why Rust? A correct but uninteresting answer is the community – both existing libraries and the opportunity for aspiring developers to build those libraries.

A more nuanced answer might be Rust's interoperability – it's easy to interop between C++ and Rust (at least easier than it is in Go and other modern systems languages). It also has best-in-class WebAssembly target support – again, compared to a language like Go which supports WebAssembly compilation but has its quirks (e.g., large binary size, no WASI support). For example, [RustPython](https://github.com/RustPython/RustPython?ref=matt-rickard) (the interpreter used by ruff) can be embedded as a WebAssembly module and easily run in the browser.

Performance improvements and interoperability are extremely powerful together – not only will they optimize existing workflows, but unlock completely new ones as well.