---
title: "SQLite-based databases on the postgres protocol? Yes we can!"
description: 'libSQL “server mode” (sqld) enables access to SQLite-based databases using Postgres and HTTP network protocols.'
summary: "The author presents the latest features of `libsql`: an open source + contribution fork of `sqlite`, that aims to bring modern databases features to sqlite. The presented features are the extension of network support in sqlite, in the sense that it can be accessed over the internet using Postgres wire protocol and HTTP."
keywords: ['glauber costa', 'sqlite', 'postgres', 'database']
date: 2023-01-27T07:42:25+0000
draft: false
categories: ['reads']
tags: ['reads', 'glauber costa', 'sqlite', 'postgres', 'database']
---

The author presents the latest features of `libsql`: an open source + contribution fork of `sqlite`, that aims to bring modern databases features to sqlite. The presented features are the extension of network support in sqlite, in the sense that it can be accessed over the internet using Postgres wire protocol and HTTP.

https://blog.chiselstrike.com/sqlite-based-databases-on-the-postgres-protocol-yes-we-can-358e61171d65

---

>
{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/sqlite_based_databases_on_postgres_wire_protocol/0_UOka05V50JLaTxn1.webp"
    caption=""
    alt=``
    class="row flex-center"
>}}
libSQL “server mode” (sqld) enables access to SQLite-based databases using Postgres and HTTP network protocols.
============================================================

Applications built on SQLite are very easy to get started with. SQLite requires no setup, no maintenance, and no scaling, and the result of that execution lies entirely in a single file that you could drop into your CI/CD for quick verification. What’s not to like?

But it’s not a common choice for production backends because of its lack of network accessibility for things like monitoring and backups. Most modern applications also need replicas for availability. And thanks to platforms such as Netlify, Vercel, and Cloudflare. applications are moving to the edge: they are now deployed _everywhere_, instead of _somewhere_.

Historically, these situations have made SQLite an infeasible option. But no more!

SQLite gets network accessibility
=================================

Aside from any technical consideration, the SQLite project is Open Source, but not Open Contribution, which prevents the creation of a community of people and organizations pushing the project in new directions.

In October 2022, we [announced a fork of SQLite](https://medium.com/p/aedad19c9a1c) that is also Open Contribution and distributed under an Open Source License (MIT), indicating our intent to evolve the project into some new and spicy directions. We call it [libSQL](https://github.com/libsql).

The latest addition is called “server mode” (known as \`[sqld](https://github.com/libsql/sqld)\`) that enables network access to libSQL, as well as replication to multiple instances.

With this first iteration, we support:

*   The Postgres wire protocol
*   The Postgres wire protocol over websocket
*   HTTP

sqld in action
==============

To see how it works, we start the server and indicate we want to serve it over http and postgres. The `-d`switch specifies the database file.

`$ sqld -d foo.db -p 127.0.0.1:5432 --http-listen-addr=127.0.0.1:8000`

Since sqld supports the Postgres wire protocol, standard Postgres tooling works, including the `psql`command shell. We’ll use it to create a table and insert a row. The commands use SQLite syntax and types:

```
$ psql \-q postgres://127.0.0.1  
glaubercosta\=\> create table databases (name text);  
 \-   
(0 rows)  
glaubercosta\=\> insert into databases (name) values ('libsql');  
 \-   
(0 rows)  
glaubercosta\=\> select \* from databases;  
name  
 \- \- \- \-   
libsql  
(1 row)
```

SQLite standard tooling also works, so we can use the `sqlite3`command shell to inspect the resulting file:

```
$ sqlite3 foo.db  
SQLite version 3.37.0 2021–12–09 01:34:53  
Enter ".help" for usage hints.  
sqlite> select \* from databases;  
libsql
``` 

HTTP and a native client
========================

Last, but not least, you can issue commands over HTTP, so you can just `curl`to it with a JSON payload, without managing connection pools or anything of the sort.

```
$ curl -s -d "{\\"statements\\": \[\\"SELECT \* from databases;\\"\] }" \\  
  http://127.0.0.1:8000  
\[\[{"name":"libsql"}\]\]
```

HTTP support was added to support restricted environments, such as edge functions, where very little besides HTTP is present. To make that even easier, we also provide a native TypeScript client that encapsulates the details of the protocol:

Transpiling and executing the following code:

```
import { connect } from "@libsql/client"  
async function example() {  
  const config = {  
    url: process.env.DB\_URI  
  };  
  const db = connect(config);  
  const rs = await db.execute("SELECT \* FROM databases");  
  console.log(rs);  
}  
example()
```

Will yield output similar to the prior examples:

```
$ DB\_URI=http://127.0.0.1:8000 node index.js  
{  
  results: \[ { name: 'libsql' } \],  
  success: true,  
  meta: { duration: 0 }  
}

```

Is a fork really needed?
========================

A fair question to ask is this: “There are other projects attempting to merge SQLite and networking, and they don’t fork SQLite. So is a fork really needed?”

A full explanation of how SQLite writes and reads data is out of the scope of this article. There are many [other sources](https://www.compileralchemy.com/books/sqlite-internals/#rollback-wal) that go into great detail about that.

Suffice to say, there are two entities that are relevant when interacting with SQLite’s storage: the VFS, and the WAL (Write-Ahead Log).

WAL Virtualization
==================

While SQLite does offer a virtualized interface for the VFS, it does not allow for the virtualization of the WAL methods. The main work in the core of libSQL was to [allow for WAL virtualization](https://github.com/libsql/libsql/pull/53).

Once the WAL is virtualized, we can capture any new updates to the database as they happen. This gives us the flexibility of VFS, but with a log-structured API.

Log-structured APIs are easier to replicate, since it is a natural point for streaming changes. In WAL mode, a writer can work in parallel with readers, which provides better concurrency guarantees for mixed and read-intensive workloads, compared to the default rollback journal mode.

Moreover, SQLite has a very interesting feature that isn’t generally available yet — [BEGIN CONCURRENT](https://www.sqlite.org/cgi/src/doc/begin-concurrent/doc/begin_concurrent.md) transactions, which use the power of optimistic concurrency control to allow multiple writers to work in parallel. This feature is built on top of WAL mode only.

For us, it’s more than sqld
===========================

This is as good a time as any to remember the primary reason for our fork: our goals with libSQL go beyond server mode. Many projects extend SQLite, making it hard to unify these efforts.

As an example, before server-mode, we had already integrated [WASM user-defined functions](/webassembly-functions-for-your-sqlite-compatible-database-7e1ad95a2aa7), allowing users to to write close-to-the-data functions and [triggers](/webassembly-triggers-in-libsql-b5eb62cc1c6) in WASM. libSQL also allows for [randomized row ids](https://github.com/libsql/libsql/pull/56), among other features, [with even more planned in the future](https://github.com/libsql/libsql/issues).

What next?
==========

We would love to hear how you might like to use libSQL’s server mode in your next project. Give us a shout out on [Twitter](https://twitter.com/libsqlhq) and join our [Discord community](https://discord.gg/TxwbQTWHSr).

More importantly, we aim to be a welcoming home for new contributions around the idea of what an embeddable database can be, as described in our [motivations](https://libsql.org/about). Your support is welcome on our [Github](https://github.com/libsql/)!