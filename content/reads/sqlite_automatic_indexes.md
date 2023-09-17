---
title: "SQLite automatic indexes on JOIN queries"
description: "SQLite's optimizer creates indexes automatically to improve query performance with only nested loop joins."
summary: "The author explains why and how SQLite creates indexes automatically to increase JOIN queries performance, and compares the behaviour to PostgreSQL"
keywords: ['preetam jinka', 'sqlite', 'indexes']
date: 2023-01-01T22:02:40+0000
draft: false
categories: ['reads']
tags: ['reads', 'preetam jinka', 'sqlite', 'indexes']
---

The following is an explanation on why SQLite automatically creates new indexes to increase JOIN queries performance. The author also compares the results to PostgreSQL and even describes some algorithmic complexity behind the queries.

https://misfra.me/2022/sqlite-automatic-indexes/

---

If you look at SQLite’s EXPLAIN output, you sometimes may notice something unusual if you’re coming from other SQL databases like PostgreSQL or MySQL.

Here’s an example:

    sqlite> create table foo (a);
    sqlite> create table bar (b, a);
    sqlite> explain select * from foo join bar on foo.a = bar.a;
    addr  opcode         p1    p2    p3    p4             p5  comment      
    ----  -------------  ----  ----  ----  -------------  --  -------------
    0     Init           0     29    0                    0   Start at 29
    1     OpenRead       0     2     0     1              0   root=2 iDb=0; foo
    2     OpenRead       1     3     0     2              0   root=3 iDb=0; bar
    3     Explain        3     0     0     SCAN foo       0   
    4     Rewind         0     28    0                    0   
    5       Once           0     16    0                    0   
    6       OpenAutoindex  2     3     0     k(3,B,,)       0   nColumn=3; for bar
    7       Blob           10000  1     0                    0   r[1]= (len=10000)
    8       Rewind         1     16    0                    0   
    9         Column         1     1     3                    0   r[3]=bar.a
    10        Column         1     0     4                    0   r[4]=bar.b
    11        Rowid          1     5     0                    0   r[5]=bar.rowid
    12        MakeRecord     3     3     2                    0   r[2]=mkrec(r[3..5])
    13        FilterAdd      1     0     3     1              0   filter(1) += key(3)
    14        IdxInsert      2     2     0                    16  key=r[2]
    15      Next           1     9     0                    3   
    16      Explain        16    0     0     SEARCH bar USING AUTOMATIC COVERING INDEX (a=?)  0   
    17      Column         0     0     6                    0   r[6]=foo.a
    18      IsNull         6     27    0                    0   if r[6]==NULL goto 27
    19      Filter         1     27    6     1              0   if key(6) not in filter(1) goto 27
    20      SeekGE         2     27    6     1              0   key=r[6]
    21        IdxGT          2     27    6     1              0   key=r[6]
    22        Column         0     0     7                    0   r[7]=foo.a
    23        Column         2     1     8                    0   r[8]=bar.b
    24        Column         2     0     9                    0   r[9]=bar.a
    25        ResultRow      7     3     0                    0   output=r[7..9]
    26      Next           2     21    0                    0   
    27    Next           0     5     0                    1   
    28    Halt           0     0     0                    0   
    29    Transaction    0     0     2     0              1   usesStmtJournal=0
    30    Goto           0     1     0                    0   
    

It’s the `SEARCH bar USING AUTOMATIC COVERING INDEX (a=?)`. To execute this simple JOIN query SQLite is creating a covering index automatically.

For reference, here’s the output from PostgreSQL:

    postgres=*# EXPLAIN SELECT * FROM foo JOIN bar ON foo.a = bar.a;
                                QUERY PLAN                             
    -------------------------------------------------------------------
     Merge Join  (cost=338.29..781.81 rows=28815 width=12)
       Merge Cond: (bar.a = foo.a)
       ->  Sort  (cost=158.51..164.16 rows=2260 width=8)
             Sort Key: bar.a
             ->  Seq Scan on bar  (cost=0.00..32.60 rows=2260 width=8)
       ->  Sort  (cost=179.78..186.16 rows=2550 width=4)
             Sort Key: foo.a
             ->  Seq Scan on foo  (cost=0.00..35.50 rows=2550 width=4)
    (8 rows)
    

Why is it that SQLite automatically creates an index for this join and PostgreSQL doesn’t?

In this case PostgreSQL is first sorting the rows from each table and using a `Merge Join`. This is O(N log N).

> _merge join:_ Each relation is sorted on the join attributes before the join starts. Then the two relations are scanned in parallel, and matching rows are combined to form join rows. This kind of join is attractive because each relation has to be scanned only once. The required sorting might be achieved either by an explicit sort step, or by scanning the relation in the proper order using an index on the join key.  
> — [https://www.postgresql.org/docs/current/planner-optimizer.html](https://www.postgresql.org/docs/current/planner-optimizer.html)

Why doesn’t SQLite use a merge join too? It’s because SQLite implements joins only as [nested loops](https://www.sqlite.org/optoverview.html#order_of_tables_in_a_join). Nested loops are O(N \* N) – worse than a merge join.

In order to reduce the complexity of the join down to O(N log N), an index is automatically created _just for the duration of the query_.

Does that sound expensive?

> Using an automatic index will make a two-way join O(N log N). That’s better than the O(N\*N) that would occur without the automatic index, but you could have O(logN) if an appropriate persistent index is available.  
> — Richard Hipp’s [response on the SQLite mailing list](https://sqlite-users.sqlite.narkive.com/IEIT0YxL/performance-regression-sqlite-3-8-4-3-is-not-using-an-automatic-covering-index-when-joining-with-a#post4).

PostgreSQL supports hash joins too. The SQLite optimizer documentation has an interesting comment [comparing hash joins to an automatic index](https://www.sqlite.org/optoverview.html#hash_joins):

> An automatic index is about the same thing as a [hash join](https://en.wikipedia.org/wiki/Hash_join). The only difference is that a B-Tree is used instead of a hash table. If you are willing to say that the transient B-Tree constructed for an automatic index is really just a fancy hash table, then a query that uses an automatic index is just a hash join.  
> — [Hash Joins](https://www.sqlite.org/optoverview.html#hash_joins)

* * *

In order to reduce code complexity SQLite only implements nested loop joins. Instead of trading off performance, it takes advantage of its robust B-tree implementation to create automatic indexes to achieve the same big-O complexity as other join types.

Read more about SQLite’s automatic indexes in the SQLite optimizer documentation: [Automatic Indexes](https://www.sqlite.org/optoverview.html#automatic_indexes)