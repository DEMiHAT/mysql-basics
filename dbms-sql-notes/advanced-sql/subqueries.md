---

# Subqueries

## 1. Introduction

A subquery—also known as an inner query or nested query—is a query embedded within another SQL statement. Subqueries enable multi-step logic, conditional filtering, dependency-based comparisons, and hierarchical data retrieval. They can return single values, tuples, or full result sets depending on context.

Subqueries complement joins by providing alternative mechanisms for relational reasoning, especially when intermediate aggregation or multi-level filtering is required.

---

# 2. Types of Subqueries

## 2.1 Based on Result Cardinality

### 2.1.1 Scalar Subquery

Returns exactly one value (one row, one column).

Example:

```
SELECT Name
FROM Student
WHERE Marks = (
    SELECT MAX(Marks) FROM Student
);
```

### 2.1.2 Row Subquery

Returns a single row with multiple columns.

Example:

```
SELECT *
FROM Student
WHERE (DeptID, Semester) = (
    SELECT DeptID, Semester
    FROM TopStudent
    WHERE Rank = 1
);
```

### 2.1.3 Table Subquery

Returns multiple rows and/or multiple columns.

Example:

```
SELECT Name
FROM Student
WHERE DeptID IN (
    SELECT DeptID FROM Department WHERE Location = 'A-Block'
);
```

---

## 2.2 Based on Placement

### 2.2.1 Subquery in WHERE Clause

Most common usage; supports filtering.

```
SELECT Name
FROM Student
WHERE DeptID = (SELECT DeptID FROM Department WHERE DeptName = 'CSE');
```

### 2.2.2 Subquery in FROM Clause (Derived Table)

Used for modular query-building.

```
SELECT DeptID, AvgMarks
FROM (
    SELECT DeptID, AVG(Marks) AS AvgMarks
    FROM Student
    GROUP BY DeptID
) AS T
WHERE AvgMarks > 75;
```

### 2.2.3 Subquery in SELECT Clause

Useful for correlated metrics.

```
SELECT Name,
       (SELECT COUNT(*) FROM Registration R WHERE R.RollNo = S.RollNo) AS CourseCount
FROM Student S;
```

---

# 3. Correlated vs Non-Correlated Subqueries

## 3.1 Non-Correlated Subquery

Independent of the outer query; executed once.

```
SELECT Name
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);
```

## 3.2 Correlated Subquery

References columns from the outer query; executed once per row.

```
SELECT Name
FROM Student S
WHERE Marks > (
    SELECT AVG(Marks)
    FROM Student
    WHERE DeptID = S.DeptID
);
```

**Usage:** Context-dependent filtering, group-relative comparisons, per-row calculations.

---

# 4. Subquery Operators

## 4.1 IN

```
SELECT Name
FROM Student
WHERE DeptID IN (
    SELECT DeptID FROM Department WHERE Location = 'Block B'
);
```

## 4.2 NOT IN

```
SELECT CourseID
FROM Course
WHERE CourseID NOT IN (
    SELECT CourseID FROM Registration
);
```

## 4.3 EXISTS / NOT EXISTS

Efficient for dependency checks.

```
SELECT DeptName
FROM Department D
WHERE EXISTS (
    SELECT 1 FROM Student S WHERE S.DeptID = D.DeptID
);
```

## 4.4 ANY / SOME

```
SELECT Name
FROM Employee
WHERE Salary > ANY (
    SELECT Salary FROM Employee WHERE DeptID = 5
);
```

## 4.5 ALL

```
SELECT Name
FROM Employee
WHERE Salary > ALL (
    SELECT Salary FROM Employee WHERE DeptID = 5
);
```

---

# 5. Comparison with Joins

### Use a Join When:

* You need combined columns from multiple tables.
* You want explicit relational merging.

### Use a Subquery When:

* You need hierarchical logic (e.g., comparison against aggregates).
* You cannot express the filter cleanly using joins.
* You want modular, readable filtering conditions.

Performance varies based on index presence and optimizer decisions.

---

# 6. Common Use Cases

### 6.1 Top/Bottom Performance Queries

```
SELECT Name
FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);
```

### 6.2 Conditional Aggregations

```
SELECT DeptID
FROM Student
WHERE Marks > (
    SELECT AVG(Marks) FROM Student
);
```

### 6.3 Multi-Level Filtering

```
SELECT Name
FROM Student
WHERE DeptID IN (
    SELECT DeptID FROM Department WHERE Strength > 100
);
```

### 6.4 Existence Checks in Relational Constraints

```
SELECT DeptName
FROM Department
WHERE NOT EXISTS (
    SELECT 1 FROM Student WHERE Student.DeptID = Department.DeptID
);
```

---

# 7. Summary

Subqueries provide expressive power for multi-stage relational queries, enabling comparisons, dependency checks, and higher-level analytical constructs. Scalar, row, and table subqueries address different return shapes, while correlated variants support context-sensitive filtering. Used appropriately, subqueries enhance modularity, clarity, and querying depth beyond what simple joins can provide.

---

