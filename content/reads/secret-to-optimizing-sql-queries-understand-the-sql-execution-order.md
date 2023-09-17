---
title: "Secret To Optimizing SQL Queries - Understand The SQL Execution Order 🚀"
description: "In this article, we will learn how SQL queries are executed by the database engine and how we can use... Tagged with sql, optimization, performance, beginners."
summary: "The following is an explanation on how SQL Queries work and you can leverage their internals to optimize query performance."
keywords: ['kanani nirav', 'sql', 'performance']
date: 2023-06-07T09:52:15.524Z
draft: false
categories: ['reads']
tags: ['reads', 'kanani nirav', 'sql', 'performance']
---

The following is an explanation on how SQL Queries work and you can leverage their internals to optimize query performance.

https://dev.to/kanani_nirav/secret-to-optimizing-sql-queries-understand-the-sql-execution-order-28m1

---

In this article, we will learn how SQL queries are executed by the database engine and how we can use this knowledge to optimize our queries for better performance and accuracy. We will also learn about some common techniques and best practices for writing efficient and SARGABLE queries. 😎

[](#what-is-sql-execution-order)What is SQL Execution Order? 🤔
---------------------------------------------------------------

SQL execution order is the actual sequence in which the database engine processes the different components of an SQL query. It is not the same as the order in which we write the query. By following a specific execution order, the database engine can minimize disk I/O, use indexes effectively, and avoid unnecessary operations. This results in faster query execution and lower resource consumption.

Let's take an example of an SQL query and see how it is executed:  

    SELECT
    customers.name,
    COUNT(order_id) as Total_orders,
    SUM(order_amount) as total_spent
    FROM customers
    JOIN orders ON customers.id = orders.customer_id
    WHERE order_date >= '2023-01-01'
    GROUP BY customers.name
    HAVING total_spent >= 1000
    ORDER BY customers.name
    LIMIT 100;
    

Enter fullscreen mode Exit fullscreen mode

The execution order of this query is as follows:

1.  **FROM Clause**: The first step is to identify the tables involved in the query. In this case, they are customers and orders.
    
2.  **JOIN Clause**: The next step is to perform the join operation based on the join condition. In this case, it is customers.id = orders.customer\_id, which connects the two tables by matching customer IDs.
    
3.  **WHERE Clause**: The third step is to apply the filter condition to the joined table. In this case, it is order\_date >= '2023-01-01', which selects only orders made on or after January 1, 2023. Now, it's important to write a SARGABLE query to leverage indexes effectively, SARGABLE means Searched ARGUment ABLE and it refers to queries that can use indexes for faster execution. We Deep-Dive into SARGABLE Queries later in the article post.
    
4.  **GROUP BY Clause**: The fourth step is to group the rows by the specified columns. In this case, it is customers.name, which creates groups based on customer names.
    
5.  **HAVING Clause**: The fifth step is to filter the groups by a condition. In this case, it is total\_spent >= 1000, which selects only groups with a total spent amount of 1000 or more.
    
6.  **SELECT Clause**: The sixth step is to select the columns and aggregate functions from each group. In this case, they are customers.name, COUNT(order\_id) as Total\_orders, and SUM(order\_amount) as total\_spent.
    
7.  **ORDER BY Clause**: The seventh step is to sort the rows by the specified columns. In this case, it is customers.name, which sorts the rows alphabetically by customer names.
    
8.  **LIMIT Clause**: The final step is to skip a number of rows from the sorted result set. In this case, it limits the result to a maximum of 100 rows.
    

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/secret-to-optimizing-sql-queries-understand-the-sql-execution-order/q3jd9vgyghf0keq7tm1i.webp"
    caption=""
    alt=`SQL Execution Order`
    class="row flex-center"
>}}

[Image Source](https://blog.bytebytego.com/p/ep50-visualizing-a-sql-query)

### [](#why-sargable-queries-matter)Why [SARGABLE](https://en.wikipedia.org/wiki/Sargable) Queries Matter? 🙌

**SARGABLE stands for Searched ARGUment ABLE** and it refers to queries that can use indexes for faster execution. Indexes are data structures that store a subset of columns from a table in a sorted order, allowing quick lookups and comparisons.

A query is SARGABLE if it uses operators and functions that can take advantage of indexes. For example, using equality (=), inequality (<>, !=), range (BETWEEN), or membership (IN) operators on indexed columns can make a query SARGABLE.

A query is not SARGABLE if it uses operators or functions that prevent index usage or require full table scans. For example, using negation (NOT), wildcard (LIKE), or arithmetic (+, -, \*, /) operators on indexed columns can make a query not SARGABLE.

To write SARGABLE queries, we should follow some general guidelines:

*   Avoid using functions on indexed columns in the WHERE clause, such as UPPER(), LOWER(), SUBSTRING(), etc.
*   Avoid using arithmetic operations on indexed columns in the WHERE clause, such as column + 1 > 10, column \* 2 < 20, etc.
*   Avoid using negation operators on indexed columns in the WHERE clause, such as NOT IN, NOT LIKE, NOT EXISTS, etc.
*   Avoid using wildcard operators on indexed columns in the WHERE clause with leading wildcards (%), such as LIKE '%abc', LIKE '%xyz%', etc.
*   Use appropriate data types for columns and literals to avoid implicit conversions that can affect index usage.

Here are some examples of SARGABLE and non-SARGABLE queries:  

    Bad: SELECT ... WHERE Year(myDate) = 2022
    Fixed: SELECT ... WHERE myDate >= '01-01-2022' AND myDate < '01-01-2023'
    
    Bad: Select ... WHERE SUBSTRING(DealerName,4) = 'Ford'
    Fixed: Select ... WHERE DealerName Like 'Ford%'
    
    Bad: Select ... WHERE DateDiff(mm, OrderDate, GetDate ()) >= 30
    Fixed: Select ... WHERE OrderDate < DateAdd(mm, -30, GetDate())
    

Enter fullscreen mode Exit fullscreen mode

### [](#how-to-tune-performance-at-database-level)How to Tune Performance at Database Level?

Improving performance in the SQL execution order involves optimizing the steps followed by the database engine to process and execute SQL queries. Here are some ways to enhance performance in the SQL execution order:

*   **Use appropriate indexes**: Analyze query patterns and identify columns frequently used in search, join, and filter operations. Create indexes on these columns for faster data retrieval and reduce the need for full table scans.
    
*   **Optimize join operations**: Ensure that join conditions are efficient and utilize appropriate indexes. Use INNER JOIN instead of OUTER JOIN when possible, as it typically results in better performance. Consider the order of joining multiple tables to minimize the intermediate result set size.
    
*   **Limit result set size**: Use the LIMIT clause to restrict the number of rows returned by a query. This can reduce the amount of data processed and improve query response time.
    
*   **Avoid unnecessary sorting and grouping**: Eliminate unnecessary sorting and grouping operations by only including them when required. This can be achieved by carefully analyzing the query and removing unnecessary ORDER BY and GROUP BY clauses.
    
*   **Filter early with WHERE clause**: Apply filtering conditions as early as possible in the query execution order using the WHERE clause. This reduces the number of rows processed in subsequent steps, improving performance.
    
*   **Use appropriate data types**: Choose the correct data types for columns to ensure efficient data storage and retrieval. Using appropriate data types can help reduce memory consumption and improve query execution speed.
    
*   **Avoid unnecessary calculations and functions**: Minimize the use of calculations and functions within the query, especially on indexed columns. These operations can hinder index usage and impact performance. Consider precomputing values or using derived columns when necessary.
    
*   **Query optimization tools**: Utilize database-specific query optimization tools or hints to guide the database engine in generating efficient execution plans. These tools can provide insights, recommendations, and statistics to improve performance.
    

### [](#conclusion)Conclusion 🎉

In this article, we learned SQL execution order matters for query performance and database efficiency. We can enhance it with indexing, joins, filtering, SARGABLE queries, and best practices. This will increase our SQL speed and make our database systems high-performing.