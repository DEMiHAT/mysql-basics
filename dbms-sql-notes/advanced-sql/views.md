---

# Views

## 1. Introduction

A **view** is a virtual table derived from one or more base tables through a stored query.
Views do not store data physically (except materialized views); instead, they present dynamic, query-based subsets or transformations of existing data.
They support abstraction, security, simplification, and logical independence across database layers.

---

# 2. Creating Views

## 2.1 Basic View

```
CREATE VIEW StudentInfo AS
SELECT RollNo, Name, DeptID
FROM Student;
```

## 2.2 View with Filtering

```
CREATE VIEW CSE_Students AS
SELECT RollNo, Name
FROM Student
WHERE DeptID = 3;
```

## 2.3 View with Joins

```
CREATE VIEW StudentDepartment AS
SELECT S.RollNo, S.Name, D.DeptName
FROM Student S
JOIN Department D ON S.DeptID = D.DeptID;
```

## 2.4 View with Aggregation

```
CREATE VIEW DeptAvgMarks AS
SELECT DeptID, AVG(Marks) AS AvgMarks
FROM Student
GROUP BY DeptID;
```

---

# 3. Updating Views

### 3.1 Updatable Views

A view is **updatable** if:

* It is derived from a single base table.
* Contains no aggregates, DISTINCT, GROUP BY, HAVING, UNION.
* Includes the primary key of the base table.

**Example:**

```
UPDATE StudentInfo
SET Name = 'Kumar'
WHERE RollNo = 101;
```

### 3.2 Non-Updatable Views

Views containing:

* Joins
* Aggregations
* Set operations
* DISTINCT
* Derived columns

are not directly updatable.

---

# 4. WITH CHECK OPTION

Ensures that updates performed through the view obey the view’s filter condition.

```
CREATE VIEW SeniorStudents AS
SELECT RollNo, Name, Semester
FROM Student
WHERE Semester >= 6
WITH CHECK OPTION;
```

Meaning: rows updated through this view must remain in `Semester >= 6`.

---

# 5. Dropping Views

```
DROP VIEW StudentInfo;
```

---

# 6. Advantages of Views

### 6.1 Security and Access Control

Expose limited columns or filtered data to specific users.

### 6.2 Logical Abstraction

Provide a simplified representation of complex schemas.

### 6.3 Query Reuse

Encapsulate commonly used joins or computed values.

### 6.4 Data Independence

Underlying table changes do not always affect view definitions.

---

# 7. Materialized Views (Conceptual)

Some DBMS (e.g., PostgreSQL with extensions, Oracle) support **materialized views**, which store results physically.

### Characteristics:

* Precomputed and stored
* Require manual or scheduled refresh
* Useful for performance-heavy queries

### Example (Oracle):

```
CREATE MATERIALIZED VIEW DeptStats
BUILD IMMEDIATE
REFRESH FAST ON COMMIT AS
SELECT DeptID, COUNT(*)
FROM Student
GROUP BY DeptID;
```

---

# 8. View Performance Considerations

* Simple views have minimal overhead; they re-execute the underlying query.
* Complex, multi-join views may degrade performance if nested repeatedly.
* Materialized views can significantly speed up analytical workloads.

---

# 9. Summary

Views provide flexible, secure, and abstraction-rich mechanisms for presenting derived data without duplicating storage. They are instrumental in hiding complexity, enforcing access policies, and facilitating reusable logical layers in relational systems. Understanding updatable vs. non-updatable views and the role of materialized views is key to effective schema design and data management.

---


