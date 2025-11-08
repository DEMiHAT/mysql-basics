---

# Joins

## 1. Introduction

Joins are relational operations that combine tuples from two or more tables based on logical conditions. They enable retrieval of meaningful, cross-table associations by aligning related data through matching attributes.
Joins form the backbone of multi-table querying and relational integrity enforcement.

---

# 2. Types of Joins

## 2.1 Inner Join

Returns rows where the join condition evaluates to true on both tables.

### Syntax

```
SELECT columns
FROM A
INNER JOIN B ON A.key = B.key;
```

### Example

```
SELECT S.Name, D.DeptName
FROM Student S
INNER JOIN Department D
    ON S.DeptID = D.DeptID;
```

**Result:** Only students with valid departments appear.

---

## 2.2 Left Outer Join (LEFT JOIN)

Returns all rows from the left table and matched rows from the right table. Unmatched rows from the right become NULL.

### Example

```
SELECT S.Name, D.DeptName
FROM Student S
LEFT JOIN Department D
    ON S.DeptID = D.DeptID;
```

**Usage:** Identify students whose department mapping is missing.

---

## 2.3 Right Outer Join (RIGHT JOIN)

Returns all rows from the right table and matched rows from the left.

### Example

```
SELECT D.DeptName, S.Name
FROM Department D
RIGHT JOIN Student S
    ON D.DeptID = S.DeptID;
```

**Usage:** Less common; mirrors LEFT JOIN semantics.

---

## 2.4 Full Outer Join

Combines the result of left and right joins.
Returns all rows from both tables; unmatched values are filled with NULLs.

### Example (DB-Specific)

```
SELECT S.Name, D.DeptName
FROM Student S
FULL OUTER JOIN Department D
    ON S.DeptID = D.DeptID;
```

**Support Note:** MySQL does not support FULL JOIN directly; use `UNION` of left and right joins.

---

## 2.5 Cross Join (Cartesian Join)

Produces Cartesian product of two tables (every row from A paired with every row from B).

### Example

```
SELECT *
FROM Student
CROSS JOIN Course;
```

**Usage:** Rare; typically useful for generating combinations or test data.

---

# 3. Advanced Join Concepts

## 3.1 Self Join

A table joined with itself by using aliases.

### Example

```
SELECT E1.Name AS Employee, E2.Name AS Manager
FROM Employee E1
JOIN Employee E2
    ON E1.ManagerID = E2.EmpID;
```

**Usage:** Hierarchical relationships.

---

## 3.2 Natural Join

Automatically joins tables using columns with the same names.

### Example

```
SELECT *
FROM Student
NATURAL JOIN Department;
```

**Note:** Avoided in production due to implicit behavior and brittleness.

---

## 3.3 Using Clause (Alternative Syntax)

Used when both tables share a join column name.

```
SELECT *
FROM Student
JOIN Department
USING (DeptID);
```

---

## 3.4 Equi Join vs Non-Equi Join

### Equi Join

Uses equality in the join condition.

```
ON A.id = B.id
```

### Non-Equi Join

Uses inequality or range conditions.

```
SELECT E.Name, S.Grade
FROM Employee E
JOIN SalaryScale S
    ON E.Salary BETWEEN S.MinSal AND S.MaxSal;
```

**Usage:** Categorization, grading, banding.

---

## 3.5 Multi-Table Joins

Joins across more than two tables.

### Example

```
SELECT S.Name, C.Title, R.Semester
FROM Student S
JOIN Registration R ON S.RollNo = R.RollNo
JOIN Course C ON R.CourseID = C.CourseID;
```

---

# 4. Performance and Indexing Considerations

### 4.1 Indexes on Join Columns

* Speeds up join condition evaluation
* Reduces scan cost on large tables

### 4.2 Join Order

RDBMS query optimizers may reorder joins for efficiency.

### 4.3 Join Algorithms (Internal)

* Nested Loop Join
* Merge Join
* Hash Join

Understanding these helps explain runtime differences under varying conditions.

---

# 5. Summary

Joins unify relational data by aligning cross-table relationships using conditions and shared attributes. Inner, outer, and cross joins constitute the fundamental join categories, while self-joins, natural joins, and non-equi joins serve specialized roles. Correct join selection ensures accurate results, logical clarity, and efficient query performance.

---

