---
title: "Tables Relations in SQL Server: One-to-One, One-to-Many, Many-to-Many"
description: 'In a relational database, each table is connected to another table using the Primary-Foreign Key constraints. Table relationships in SQL Server database are of three types: One-to-One, One-to-Many, Many-to-Many.'
summary: "Overview of database table relationships"
keywords: ['tutorialsteacher', 'database', 'architecture']
date: 2022-12-01T14:36:50+0000
draft: false
categories: ['reads']
tags: ['reads', 'tutorialsteacher', 'database', 'architecture']
---

The following is a summary of the associations relational database tables can have. It goes through each of them and provides examples of them using SQL Server. The author does not cover the `Many-to-One` relationship, but in a nutshell that's `One-to-Many` with the table that is referenced on the opposite side.

https://www.tutorialsteacher.com/sqlserver/tables-relations

---

Tables Relations in SQL Server: One-to-One, One-to-Many, Many-to-Many
=====================================================================
>
It is important to understand and design relationships among tables in a relational database like SQL Server. In a relational database, each table is connected to another table using the Primary-Foreign Key constraints.
>
Table relationships in SQL Server database are of three types:
>
1.  [One-to-One](#one-to-one-relation)
2.  [One-to-Many](#one-to-many-relation)
3.  [Many-to-Many](#many-to-many-relation)

One-to-One Relation
-------------------

In One-to-One relationship, one record of the first table will be linked to zero or one record of another table. For example, each employee in the `Employee` table will have a corresponding row in `EmployeeDetails` table that stores the current passport details for that particular employee. So, each employee will have zero or one record in the `EmployeeDetails` table. This is called zero or one-to-one relationship.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/database-relationships/tables-relations5.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

One-to-One Relationships

Above, `EmployeeID` column is the primary key as well as foreign key column in the `EmployeeDetails` table that linked to `EmployeeID` of the `Employee` table. This forms zero or one-to-one relation.

The following query will display data from both the tables.

    SELECT * FROM Employee
    SELECT * FROM EmployeeDetails

The following is the result of the above queries that demonstrate how each employee has none or just one corresponding record in `EmployeeDetails` table.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/database-relationships/tables-relations6.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Records in One-to-One Relationships Tables

One-to-Many Relation
--------------------

One-to-Many is the most commonly used relationship among tables. A single record from one table can be linked to zero or more rows in another table.

Let's take an example of the `Employee` and `Address` table in the `HR` database. The `Employee` table stores employee records where `EmployeeID` is the primary key. The `Address` table holds the addresses of employees where `AddressID` is a primary key and `EmployeeID` is a foreign key. Each employee will have one record in the `Employee` table. Each employee can have many addresses such as Home address, Office Address, Permanent address, etc.

The `Employee` and `Address` tables are linked by the key column `EmployeeID`. It is a foreign key in the `Address` table linking to the primary key `EmployeeID` in the `Employee` table. Thus, one record of the `Employee` table can point to multiple records in the `Address` table. This is a One-to-Many relationship.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/database-relationships/tables-relations1.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

One-to-Many Relationships

The following query will display data from both the tables.

    SELECT * FROM Employee
    SELECT * FROM Address

The following is the result of the above queries to demonstrate how the data is related in one-to-many relationship.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/database-relationships/tables-relations2.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Records in One-to-Many Relationships Tables

In the above data, each record in the `Employee` table associated with zero or more records in the `Address` table, e.g. `James Bond` has zero address, `John King` has three addresses.

Many-to-Many Relation
---------------------

Many-to-Many relationship lets you relate each row in one table to many rows in another table and vice versa. As an example, an employee in the `Employee` table can have many skills from the `EmployeeSkill` table and also, one skill can be associated with one or more employees.

The following figure demonstrates many-to-many relation between `Employee` and `SkillDescription` table using the junction table `EmployeeSkill`.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/database-relationships/tables-relations3.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Many-to-Many Relationships

Every employee in the `Employee` table can have one or many skills. Similarly, a skill in the `SkillDescription` table can be linked to many employees. This makes a many-to-many relationship.

In the example above, the `EmployeeSkill` is the junction table that contains `EmployeeID` and `SkillID` foreign key columns to form many-to-many relation between the `Employee` and `SkillDescription` table. Individually, the `Employee` and `EmployeeSkill` have a one-to-many relation and the `SkillDescription` and `EmployeeSkill` tables have one-to-many relation. But, they form many-to-many relation by using a junction table `EmployeeSkill`.

The following query will display data from all the tables.

    SELECT * FROM Employee
    SELECT * FROM EmployeeSkill
    SELECT * FROM SkillDescription

The following is the result of the above queries that demonstrate how the data is related in many-to-many relationship.

{{< center-figure
    src="https://raw.githubusercontent.com/freitzzz/cinderela/master/blog/general/database-relationships/tables-relations4.png"
    caption=""
    alt=``
    class="row flex-center"
>}}

Records in Many-to-Many Relationships Tables