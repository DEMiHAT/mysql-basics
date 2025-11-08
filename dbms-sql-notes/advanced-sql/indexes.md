---

# Indexes

## 1. Introduction

An **index** is a physical data structure that improves the speed of data retrieval operations on a table. It functions similarly to an index in a book—providing fast lookup access paths without scanning the entire dataset.
Indexes optimize query performance but introduce overhead during data modification operations (INSERT, UPDATE, DELETE).

---

# 2. Purpose of Indexes

* Speed up search operations (equality, range queries, joins).
* Reduce disk I/O by minimizing full table scans.
* Support constraint enforcement (primary keys, unique constraints).
* Facilitate efficient sorting and grouping in query execution plans.

---

# 3. Types of Indexes

## 3.1 Primary Index

Automatically created when a **primary key** is defined.
Ensures uniqueness and provides direct access paths.

```
PRIMARY KEY (RollNo)
```

## 3.2 Unique Index

Guarantees that indexed column values are unique.

```
CREATE UNIQUE INDEX idx_email
ON Student (Email);
```

## 3.3 Secondary Index (Non-Unique Index)

Improves lookup performance on non-key attributes.

```
CREATE INDEX idx_dept
ON Student (DeptID);
```

## 3.4 Composite Index

Covers multiple columns in a single index structure.

```
CREATE INDEX idx_dept_sem
ON Student (DeptID, Semester);
```

**Note:** Column order matters; `(DeptID, Semester)` ≠ `(Semester, DeptID)`.

---

# 4. Internal Index Structures

## 4.1 B+ Tree Index (Most Common)

* Balanced tree structure
* Excellent for equality and range queries
* Default in MySQL, PostgreSQL, Oracle

## 4.2 Hash Index (Engine-Specific)

* Best for exact-match lookups (`=`).
* Poor for range queries.
* Common in in-memory engines like PostgreSQL’s `HASH` index type.

## 4.3 Bitmap Index (Analytical Workloads)

* Used in low-cardinality attributes (e.g., gender, status).
* Common in data warehousing (Oracle, analytical DBMS).

## 4.4 Full-Text Index

Optimized for textual searching.

```
CREATE FULLTEXT INDEX idx_ft_bio
ON Users (Bio);
```

---

# 5. When to Use Indexes

### Use an index when:

* Queries frequently filter on a column (WHERE).
* Columns are used in JOIN conditions.
* Columns are used in ORDER BY or GROUP BY.
* Columns have high selectivity (many distinct values).

### Avoid indexing:

* Columns with very low selectivity (e.g., boolean flags).
* Columns frequently updated (index overhead slows writes).
* Small tables (full scans are already fast).

---

# 6. Index Selectivity

Selectivity = distinct values / total rows
Higher selectivity ⇒ better index performance.

Example:
`Email` (unique) = high selectivity
`Gender` (M/F) = low selectivity

---

# 7. Indexing Strategies

## 7.1 Single-Column Indexes

Useful for simple lookups.

## 7.2 Combined/Composite Indexes

Should align with the most common query patterns.

```
WHERE DeptID = ? AND Semester = ?
```

→ Composite index `(DeptID, Semester)` is ideal.

## 7.3 Covering Index

An index that contains all columns required by the query.

```
CREATE INDEX idx_covering
ON Student (DeptID, Semester, Marks);
```

DBMS can satisfy the query using only the index, avoiding table lookups.

---

# 8. Index Maintenance

### 8.1 Dropping an Index

```
DROP INDEX idx_email ON Student;
```

### 8.2 Rebuilding/Reorganizing (DB-Specific)

Improves performance by compacting index pages.

```
ALTER INDEX idx_email REBUILD;
```

---

# 9. Performance Implications

### Advantages:

* Significant improvement in SELECT queries.
* Faster joins, grouping, and sorting.
* Enables constraint enforcement.

### Costs:

* Slower INSERT/UPDATE/DELETE due to index maintenance.
* Additional storage space.
* Potential fragmentation requiring periodic maintenance.

Optimizers automatically decide whether to use indexes based on statistics.

---

# 10. Summary

Indexes are critical performance enhancers in relational databases.
By providing efficient access paths, they accelerate selectivity-based queries, joins, and aggregations. However, excessive or poorly chosen indexes can degrade write performance and waste storage. Effective indexing requires understanding query patterns, selectivity characteristics, and the underlying index structures used by the DBMS.

---


