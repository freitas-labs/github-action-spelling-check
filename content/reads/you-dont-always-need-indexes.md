---
title: "You Don't Always Need Indexes"
description: "Sometimes you have a lot of data, and one approach to support quick searches is pre-processing it to build an index so a search can involve only looking at a small fraction of the total data. The threshold at which it's worth switching to indexing, though, might be higher than you'd guess. Here are some cases I've worked on where full scans were better engineering choices:     Ten years ago I wrot"
summary: "The following discusses the importance of indexing data for efficient searches and highlights cases where full scans prove to be better engineering choices than implementing indexing. "
keywords: ['tech', 'database', 'indexes', 'jeff kaufman']
date: 2023-05-25T20:44:55.846Z
draft: false
categories: ['reads']
tags: ['reads', 'tech', 'database', 'indexes', 'jeff kaufman']
---

The following discusses the importance of indexing data for efficient searches and highlights cases where full scans prove to be better engineering choices than implementing indexing. The author presents several examples to support this perspective.

The article concludes by advising that unless dealing with hundreds of millions of records, it is recommended to start with simple scans and only resort to indexing if acceptable performance cannot be achieved. Furthermore, even in scenarios where indexing becomes necessary, if queries are rare and diverse, it may still be more advantageous to perform the work at query time rather than during data ingestion.

https://www.jefftk.com/p/you-dont-always-need-indexes

---
Sometimes you have a lot of data, and one approach to support quick searches is pre-processing it to build an index so a search can involve only looking at a small fraction of the total data. The threshold at which it's worth switching to indexing, though, might be higher than you'd guess. Here are some cases I've worked on where full scans were better engineering choices:

*   Ten years ago I wrote an interoffice messaging application for a small billing service. Messages were stored in MySQL and I was going to add indexing if full-text searches got slow or we had load issues, but even with ten years worth of messages to search it stayed responsive.
    
*   I recently [came across](https://news.ycombinator.com/item?id=35840944) someone maintaining a 0.5GB full text index to support searching their shell history, 100k commands. I [use](https://www.jefftk.com/p/logging-shell-history-in-zsh) `grep` on a flat file, and testing now it takes 200ms for a query across my 180k history entries.
    
*   My [contra dance search tool](https://www.trycontra.com/) ranks each dance in response to your query, with no geospatial indexing, because there are just ~350 dances.
    
*   The [viral counts explorer](https://www.jefftk.com/mgs-counts/) I've been playing with for work searches the taxonomic tree of human viruses in real time, scanning ~15k names with JS's "includes" command about as fast as you can type.
    
*   When I worked in ads I would often need to debug issues using production logs, and would use Dremel ([Melnik 2010](https://research.google/pubs/pub36632.pdf), [Melnik 2020](https://research.google/pubs/pub49489.pdf)) to run a distributed scan of very large amounts of data at interactive speeds. Because queries were relatively rare, an index would have been far more expensive to maintain.
    

Unless you know from the start that you'll be searching hundreds of millions of records, consider starting with simple scans and only add indexing if you can't get acceptable performance. And even then, if queries are rare and highly varied you may still do better to do the work at query time instead of ingestion time.
