---

# Data Query Language (DQL)

## 1. Introduction

Data Query Language (DQL) is responsible for retrieving data from relational tables. The central DQL command—`SELECT`—supports filtering, projection, aggregation, ordering, grouping, and subquery execution.
DQL operations do not modify data; instead, they interpret relational structures to extract meaningful results.

---

## 2. SELECT Statement

### 2.1 Basic Select

```
SELECT * 
FROM Student;
```

Retrieves all columns and rows from the table.

### 2.2 Column Projection

```
SELECT RollNo, Name, DeptID 
FROM Student;
```

Returns only the specified attributes.

---

## 3. Filtering Results (WHERE Clause)

### 3.1 Basic Filtering

```
SELECT Name, DeptID
FROM Student
WHERE DeptID = 3;
```

### 3.2 Comparison Operators

```
WHERE Marks >= 50
WHERE Age <> 20
WHERE Salary BETWEEN 20000 AND 40000
```

### 3.3 Logical Operators

```
WHERE DeptID = 3 AND Semester = 5
WHERE DeptID = 2 OR DeptID = 4
WHERE NOT (Status = 'Inactive')
```

### 3.4 Pattern Matching

```
WHERE Name LIKE 'A%'
WHERE Email LIKE '%gmail.com'
WHERE RollNo LIKE '_5_'
```

### 3.5 IN and NOT IN

```
WHERE DeptID IN (1, 3, 5)
WHERE CourseID NOT IN (101, 103)
```

### 3.6 NULL Handling

```
WHERE Email IS NULL
WHERE Address IS NOT NULL
```

---

## 4. Sorting Results (ORDER BY)

### 4.1 Default (Ascending)

```
SELECT Name, DeptID 
FROM Student
ORDER BY Name;
```

### 4.2 Descending

```
ORDER BY Marks DESC;
```

### 4.3 Multi-Level Sorting

```
ORDER BY DeptID ASC, Name DESC;
```

---

## 5. Aggregation (GROUP BY)

### 5.1 Basic Aggregation

```
SELECT DeptID, COUNT(*) 
FROM Student
GROUP BY DeptID;
```

### 5.2 Multiple Aggregates

```
SELECT DeptID, AVG(Marks), MAX(Marks), MIN(Marks)
FROM Student
GROUP BY DeptID;
```

---

## 6. HAVING Clause

Used to filter groups after aggregation.

```
SELECT DeptID, COUNT(*)
FROM Student
GROUP BY DeptID
HAVING COUNT(*) > 50;
```

`HAVING` is applied **after** `GROUP BY`, unlike `WHERE`.

---

## 7. Aliases (AS)

### 7.1 Column Alias

```
SELECT Name AS StudentName
FROM Student;
```

### 7.2 Table Alias

```
SELECT S.Name, D.DeptName
FROM Student S
JOIN Department D ON S.DeptID = D.DeptID;
```

---

## 8. LIMIT / OFFSET (DB-Specific)

Controls the number of rows returned.

```
SELECT * FROM Student
LIMIT 10 OFFSET 5;
```

---

## 9. DISTINCT

Eliminates duplicate rows.

```
SELECT DISTINCT DeptID
FROM Student;
```

---

## 10. Subqueries (DQL within DQL)

### 10.1 Scalar Subquery

```
SELECT Name 
FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);
```

### 10.2 IN Subquery

```
SELECT Name
FROM Student
WHERE DeptID IN (
    SELECT DeptID FROM Department WHERE Location = 'Block A'
);
```

### 10.3 EXISTS

```
SELECT DeptName
FROM Department D
WHERE EXISTS (
    SELECT 1 FROM Student S WHERE S.DeptID = D.DeptID
);
```

---

## 11. Combining Results (Set Operations)

### 11.1 UNION

```
SELECT RollNo FROM Alumni
UNION
SELECT RollNo FROM Student;
```

### 11.2 UNION ALL

Includes duplicates.

### 11.3 INTERSECT

```
SELECT CourseID FROM Registered
INTERSECT
SELECT CourseID FROM Offered;
```

### 11.4 EXCEPT / MINUS

```
SELECT CourseID FROM Offered
EXCEPT
SELECT CourseID FROM Registered;
```

(Availability varies by SQL dialect.)

---

## 12. Summary

DQL provides powerful query capabilities through the `SELECT` statement, enabling precise data extraction using filtering, grouping, sorting, and subqueries. Effective DQL usage is fundamental for analytics, reporting, and application-driven data retrieval.

---


