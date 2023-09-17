---
title: "Vector Search"
description: "With the renewed interest in AI, vector search is becoming popular again. LLMs and vector search rely on text embeddings — converting concepts into vectors."
summary: "The author explains what the concept of vector search is, its applications in AI and search engines."
keywords: ['matt rickard', 'search engine', 'ai']
date: 2022-12-18T22:59:16+0000
draft: false
categories: ['reads']
tags: ['reads', 'matt rickard', 'search engine', 'ai']
---

The following is an explanation of **vector search**, a technique used in search engines to search content using [vector space models](https://en.wikipedia.org/wiki/Vector_space_model). The author describes its usage in AI, general purpose search engines and provides references to startups that are working in this field right now.

https://matt-rickard.ghost.io/vector-search/

---

With the renewed interest in AI, vector search is becoming popular again. LLMs and vector search rely on text embeddings — converting concepts into vectors.

Instead of keyword matching, vector search uses vector similarity to find relevant content. It uses a vector space model to represent the documents as points in an N-dimensional space. Words closer to each other in this space are more relevant, and documents with similar words are more relevant. This allows searching for concepts and phrases instead of exact words. Models like GPT-3 have large embeddings (12288 dimensions)!

You can use vector search for

- text similarity (clustering)
- text search
- code search
- image search

Most search engines (like Google) incorporate vector search somewhere in the pipeline, but you still usually need other traditional search methods in addition. However, it’s been interesting to see the tangential advancements in vector search due to higher-dimensional embeddings.

There’s a lot of new (and old startups) in the space:

- [Weaviate](https://weaviate.io/)
- [Pinecone](https://www.pinecone.io/)
- [Vespa](https://vespa.ai/)