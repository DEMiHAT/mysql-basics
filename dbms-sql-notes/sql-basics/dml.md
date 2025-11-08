---

# Data Manipulation Language (DML)

## 1. Introduction

Data Manipulation Language (DML) provides the set of operations used to **insert, update, delete, and retrieve** data stored in relational tables. Unlike DDL, which modifies schema structures, DML manipulates the actual tuple-level contents of database relations.
DML statements typically operate within transactions and obey integrity constraints defined at the schema level.

---

## 2. Core DML Commands

## 2.1 INSERT

The `INSERT` statement adds new rows into a table.

### 2.1.1 Insert a Single Row

```
INSERT INTO Student (RollNo, Name, DeptID, Email)
VALUES (101, 'Arun', 3, 'arun@example.com');
```

### 2.1.2 Insert with All Columns (Implicit Order)

```
INSERT INTO Department
VALUES (3, 'Computer Science');
```

### 2.1.3 Insert Multiple Rows

```
INSERT INTO Course (CourseID, Title, Credits)
VALUES
    (101, 'DBMS', 4),
    (102, 'OOP', 3),
    (103, 'Algorithms', 4);
```

### 2.1.4 Insert from Another Table

```
INSERT INTO Alumni (RollNo, Name, DeptID)
SELECT RollNo, Name, DeptID
FROM Student
WHERE Year = 2024;
```

---

## 2.2 UPDATE

The `UPDATE` statement modifies existing tuples.

### 2.2.1 Update Specific Attributes

```
UPDATE Student
SET Email = 'newmail@example.com'
WHERE RollNo = 101;
```

### 2.2.2 Update Multiple Columns

```
UPDATE Student
SET Name = 'Arun Kumar',
    DeptID = 4
WHERE RollNo = 101;
```

### 2.2.3 Update with Conditional Filtering

```
UPDATE Course
SET Credits = Credits + 1
WHERE DeptID = 3;
```

**Note:** Omitting the `WHERE` clause updates **all** rows in the relation.

---

## 2.3 DELETE

The `DELETE` statement removes rows from a table.

### 2.3.1 Delete Specific Rows

```
DELETE FROM Student
WHERE RollNo = 101;
```

### 2.3.2 Delete All Rows (Without Dropping Table)

```
DELETE FROM Student;
```

### 2.3.3 Delete Using Subquery

```
DELETE FROM Registration
WHERE CourseID IN (
    SELECT CourseID FROM Course WHERE Credits < 3
);
```

**Key Distinction:**
`DELETE` is a DML operation and can be rolled back, whereas `TRUNCATE` is DDL and typically cannot.

---

## 3. DML and Transactions

DML statements operate within transactional boundaries.

### ACID Compliance:

* **Atomicity:** Either all changes occur or none do.
* **Consistency:** Integrity constraints must remain valid.
* **Isolation:** Concurrent operations should not violate consistency.
* **Durability:** Committed changes persist permanently.

### Transaction Example

```
START TRANSACTION;

UPDATE Account
SET Balance = Balance - 500
WHERE AccNo = 1001;

UPDATE Account
SET Balance = Balance + 500
WHERE AccNo = 1002;

COMMIT;
```

---

## 4. Constraint Interaction

DML statements must respect constraints defined in DDL.

Examples:

* **Primary Key:** Cannot insert duplicate PK values.
* **Foreign Key:** Cannot delete parent rows without handling dependent rows.
* **Check Constraint:** Validates logical expressions.
* **Not Null:** Requires explicit value.

These constraints prevent invalid or inconsistent data manipulations.

---

## 5. Performance Considerations

* Use indexed columns in `WHERE` clauses whenever possible.
* Batch inserts are more efficient than multiple individual inserts.
* Avoid unnecessary updates that trigger cascading constraints or triggers.
* Large deletes may require partition pruning or archiving strategies.

---

## 6. Summary

DML forms the operational layer of SQL, enabling controlled manipulation of relational data through inserts, updates, and deletions. When combined with integrity constraints and transaction control, DML ensures reliable, consistent, and safe data operations within a DBMS.

---


