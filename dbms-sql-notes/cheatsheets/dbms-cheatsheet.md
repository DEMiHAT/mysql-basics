---

# DBMS Cheatsheet

**High-compression Theory Reference for Exams & Interviews**

---

# 1. Database Basics

## What is a DBMS?

Software system that enables efficient storage, retrieval, manipulation, and management of data while ensuring consistency, concurrency, integrity, and security.

## Functions of DBMS

* Data storage, retrieval, update
* Transaction management (ACID)
* Concurrency control
* Security & authorization
* Backup & recovery
* Integrity enforcement
* Data independence (logical & physical)

---

# 2. Data Models

## Types

* **Hierarchical Model** – tree based
* **Network Model** – graph based
* **Relational Model** – tables (Codd’s model)
* **Object-Oriented Model**
* **ER Model** – conceptual design

---

# 3. ER Model (Entity–Relationship)

## Components

* **Entity** – distinguishable object (Student, Course)
* **Attributes** – properties (RollNo, Name)

  * Simple / Composite
  * Single-valued / Multi-valued
  * Derived
* **Keys** – primary, super, candidate

## Relationships

* 1:1, 1:N, M:N
* Cardinality & participation constraints
* Weak entity: depends on strong entity

---

# 4. Relational Model

## Terms

* **Relation** – table
* **Tuple** – row
* **Attribute** – column
* **Domain** – valid values for attribute
* **Schema** – structure definition
* **Instance** – actual data

## Keys

* **Candidate key** – minimal uniquely identifying set
* **Primary key** – selected candidate
* **Superkey** – superset of candidate key
* **Foreign key** – maintains referential integrity

---

# 5. Relational Algebra (RA)

## Core Operators

* **σ** Selection
* **π** Projection
* **×** Cartesian Product
* **∪** Union
* **∩** Intersection
* **−** Difference
* **⨝** Join (Natural, Theta, Equi)
* **ρ** Rename

## Extended Operators

* Aggregation, outer joins, division operator

---

# 6. Functional Dependencies (FDs)

## Definition

X → Y means attribute set X determines attribute set Y.

## Types

* **Trivial**: Y ⊆ X
* **Non-trivial**
* **Fully functional dependency**
* **Partial dependency**
* **Transitive dependency**

---

# 7. Normalization

## 1NF

* No repeating groups
* Atomic values only

## 2NF

* 1NF + no partial dependency (non-key attribute depending on only part of composite key)

## 3NF

* 2NF + no transitive dependencies

## BCNF

* For every FD X → Y, X must be a superkey

## 4NF

* Remove multi-valued dependencies

## Denormalization

Used to improve read performance by intentionally adding redundancy.

---

# 8. SQL Theory Essentials

## SQL Subsets

* DDL, DML, DQL, DCL, TCL

## Integrity Constraints

* Primary key
* Foreign key
* UNIQUE
* NOT NULL
* CHECK
* DEFAULT

## Join Types

* Inner, Left, Right, Full, Cross, Natural, Self

## Set Operations

* UNION, INTERSECT, EXCEPT

---

# 9. Transactions & ACID

## ACID Properties

* **Atomicity** – all or nothing
* **Consistency** – valid state transitions
* **Isolation** – no interference
* **Durability** – persists after commit

## Transaction States

Active → Partially Committed → Committed → Failed → Aborted

---

# 10. Concurrency Control

## Problems

* Lost update
* Dirty read
* Non-repeatable read
* Phantom read

## Isolation Levels

* Read Uncommitted
* Read Committed
* Repeatable Read
* Serializable

## Concurrency Mechanisms

* **Locks**

  * Shared (S) and Exclusive (X)
  * 2PL (Two-Phase Locking)
* **Timestamp Ordering**
* **Optimistic Control**
* **MVCC (Multi-Version Concurrency Control)**

---

# 11. Deadlocks

## Conditions

1. Mutual exclusion
2. Hold & wait
3. No preemption
4. Circular wait

## Handling

* Prevention (break conditions)
* Detection (wait-for graph)
* Recovery (rollback victim)

---

# 12. Indexing

## Types

* **Primary index**
* **Secondary index**
* **Unique index**
* **Composite index**
* **Clustered / Non-clustered**
* **B+ Tree index** (most common)
* **Hash index** (exact match)
* **Bitmap index** (low cardinality)
* **Full-text index** (text search)

## When to Index

* High selectivity columns
* JOIN, WHERE, ORDER BY columns

## When NOT to Index

* Low selectivity columns
* Columns frequently updated

---

# 13. Storage & File Organization

## Page / Block Concepts

* DBMS reads in fixed-size pages (4KB, 8KB, etc.)

## File Organization

* Heap file (unordered)
* Sequential file
* Hash file

## Access Methods

* Index scan
* Sequential scan
* Multi-level indexing (B+ Trees)

---

# 14. Query Processing & Optimization

## Stages

1. Parsing
2. Query rewrite
3. Optimization (cost-based)
4. Execution plan generation

## Optimization Techniques

* Choose best join order
* Choose best join method (nested loop, hash join, merge join)
* Use indexes
* Predicate pushdown
* Projection pruning

---

# 15. Logging & Recovery

## Write-Ahead Logging (WAL)

Log is written before data pages.

## Checkpoints

Reduce recovery time by flushing pages.

## ARIES Recovery Algorithm

* Analysis
* Redo
* Undo

## Redo & Undo Logs

* Redo: ensure committed changes persist
* Undo: rollback uncommitted transactions

---

# 16. NoSQL Overview

## Types

* **Key-value stores** (Redis)
* **Document stores** (MongoDB)
* **Column Family stores** (Cassandra)
* **Graph DBs** (Neo4j)

## CAP Theorem

Cannot simultaneously provide all three:

* Consistency
* Availability
* Partition tolerance

---

# 17. ACID vs BASE

| ACID                | BASE                             |
| ------------------- | -------------------------------- |
| Strong consistency  | Soft state                       |
| Strict transactions | Eventually consistent            |
| Suitable for OLTP   | Suitable for distributed systems |

---

# 18. OLTP vs OLAP

| OLTP                 | OLAP                       |
| -------------------- | -------------------------- |
| Transaction-oriented | Analytical queries         |
| Small queries        | Large aggregations         |
| Real-time            | Batch                      |
| Normalized           | Denormalized (star schema) |

---

# 19. Other Important Concepts

* Referential Integrity
* Cascading Actions (ON DELETE/UPDATE)
* Star & Snowflake Schemas
* Materialized Views
* Stored Procedures & Functions
* Triggers
* ACID vs Eventual Consistency
* Query plans (EXPLAIN)

---

# 20. Most Common Exam Definitions (One-liners)

* **DBMS:** Software to manage data efficiently.
* **Schema:** Database structure.
* **Instance:** Data at a particular moment.
* **FD:** X → Y means X determines Y.
* **Normalization:** Removing redundancy and anomalies.
* **Transaction:** Logical unit of work.
* **Deadlock:** Circular waiting between transactions.
* **Index:** Data structure to speed search.
* **View:** Virtual table from query.

---


