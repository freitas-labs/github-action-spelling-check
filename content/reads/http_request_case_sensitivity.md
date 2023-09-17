---
title: "HTTP request case sensitivity"
description: "Summary of fields/components of HTTP that are case sensitive"
summary: "The author summarizes which HTTP fields/components are case sensitive and which aren't"
keywords: ['preetam jinka', 'http']
date: 2023-01-02T18:41:44+0000
draft: false
categories: ['reads']
tags: ['reads', 'preetam jinka', 'http']
---

The following is a summary of which HTTP fields/components are case sensitive.

https://misfra.me/2022/http-request-case-sensitivity/

---

I only recently learned that HTTP methods are case-sensitive. In order to save myself from future debugging headaches, I decided to do a quick search to see what else is case-sensitive.

This is what the RFC says. Real applications may treat things differently!


|Case sensitive?|Component|Reference|
|---------------|---------|---------|
| ✅ | HTTP version |[RFC](https://www.rfc-editor.org/rfc/rfc7230#section-2.6)|
|✅|Method|[RFC](https://www.rfc-editor.org/rfc/rfc7230#section-3.1.1)|
|❌|URI scheme|[RFC](https://www.rfc-editor.org/rfc/rfc7230#section-2.7.3)|
|❌|URI host|[RFC](https://www.rfc-editor.org/rfc/rfc7230#section-2.7.3)|
|✅|URI path, query, fragment|[RFC](https://www.rfc-editor.org/rfc/rfc7230#section-2.7.3)|
|❌|Header field name|[RFC](https://www.rfc-editor.org/rfc/rfc7230#section-3.2)|
|✅|Header field values|Not explicit in the RFC. See below for some exceptions.|
|❌|`Transfer-coding` header value|[RFC](https://www.rfc-editor.org/rfc/rfc7230#section-4)|
|❌|`Connection` header value|[RFC](https://www.rfc-editor.org/rfc/rfc7230#section-6.1)|
|✅|Body||

### Summary

Case-sensitive:

*   HTTP version
*   Method
*   URI path, query, fragment
*   Header field values
*   Body

Case-insensitive:

*   URI scheme
*   URI host
*   Header field name
*   `Transfer-coding` header value
*   `Connection` header value