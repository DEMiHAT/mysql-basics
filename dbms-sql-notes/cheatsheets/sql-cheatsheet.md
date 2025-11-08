---

# SQL Cheatsheet

**Compact reference for DBMS + SQL concepts**

---

# 1. SQL Classification

| Category | Commands                                     | Purpose             |
| -------- | -------------------------------------------- | ------------------- |
| **DDL**  | CREATE, ALTER, DROP, TRUNCATE, RENAME        | Schema definition   |
| **DML**  | INSERT, UPDATE, DELETE                       | Data manipulation   |
| **DQL**  | SELECT                                       | Data querying       |
| **TCL**  | COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION | Transaction control |
| **DCL**  | GRANT, REVOKE                                | Access control      |

---

# 2. DDL Reference

### CREATE TABLE

```sql
CREATE TABLE Student (
  RollNo INT PRIMARY KEY,
  Name VARCHAR(50),
  DeptID INT,
  Marks INT CHECK (Marks >= 0 AND Marks <= 100)
);
```

### ALTER TABLE

```sql
ALTER TABLE Student ADD Email VARCHAR(100);
ALTER TABLE Student DROP COLUMN Email;
ALTER TABLE Student MODIFY Marks INT;
```

### DROP / TRUNCATE

```sql
DROP TABLE Student;
TRUNCATE TABLE Student;
```

---

# 3. DML Reference

### INSERT

```sql
INSERT INTO Student(RollNo, Name, DeptID)
VALUES (101, 'Arun', 1);
```

### UPDATE

```sql
UPDATE Student SET Marks = 90 WHERE RollNo = 101;
```

### DELETE

```sql
DELETE FROM Student WHERE RollNo = 101;
```

---

# 4. SELECT (DQL) Essentials

### Basic Query

```sql
SELECT * FROM Student;
```

### Filtering

```sql
SELECT * FROM Student WHERE Marks > 75;
SELECT * FROM Student WHERE Name LIKE 'A%';
SELECT * FROM Student WHERE DeptID IN (1,3);
SELECT * FROM Student WHERE Marks BETWEEN 60 AND 90;
```

### Sorting

```sql
SELECT * FROM Student ORDER BY Marks DESC;
```

### Aggregation

```sql
SELECT DeptID, AVG(Marks) FROM Student GROUP BY DeptID;
```

### HAVING

```sql
SELECT DeptID, COUNT(*) FROM Student
GROUP BY DeptID HAVING COUNT(*) > 50;
```

---

# 5. Joins

### INNER JOIN

```sql
SELECT S.Name, D.DeptName
FROM Student S
JOIN Department D ON S.DeptID = D.DeptID;
```

### LEFT JOIN

```sql
SELECT S.Name, D.DeptName
FROM Student S
LEFT JOIN Department D ON S.DeptID = D.DeptID;
```

### MULTI-TABLE JOIN

```sql
SELECT S.Name, C.Title, R.Semester
FROM Student S
JOIN Registration R ON S.RollNo = R.RollNo
JOIN Course C ON R.CourseID = C.CourseID;
```

### SELF JOIN

```sql
SELECT E1.Name, E2.Name AS Manager
FROM Employee E1
JOIN Employee E2 ON E1.ManagerID = E2.EmpID;
```

---

# 6. Subqueries

### Scalar

```sql
SELECT Name FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);
```

### IN

```sql
SELECT Name FROM Student
WHERE DeptID IN (
  SELECT DeptID FROM Department WHERE Location='Block A'
);
```

### EXISTS

```sql
SELECT DeptName FROM Department D
WHERE EXISTS (
  SELECT 1 FROM Student S WHERE S.DeptID = D.DeptID
);
```

### Correlated

```sql
SELECT Name FROM Student S
WHERE Marks >
  (SELECT AVG(Marks) FROM Student WHERE DeptID = S.DeptID);
```

---

# 7. Constraints

* **PRIMARY KEY** – unique + NOT NULL
* **FOREIGN KEY** – referential integrity
* **UNIQUE** – no duplicates
* **NOT NULL** – must contain a value
* **CHECK** – logical validation
* **DEFAULT** – auto value if null

Example:

```sql
CONSTRAINT fk_student_dept
  FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
```

---

# 8. Views

### Create

```sql
CREATE VIEW StudentInfo AS
SELECT RollNo, Name, DeptID FROM Student;
```

### Update Through View (if updatable)

```sql
UPDATE StudentInfo SET Name='Kumar' WHERE RollNo = 101;
```

### Drop

```sql
DROP VIEW StudentInfo;
```

---

# 9. Indexes

### Create

```sql
CREATE INDEX idx_marks ON Student(Marks);
CREATE INDEX idx_composite ON Student(DeptID, Semester);
```

### Drop

```sql
DROP INDEX idx_marks ON Student;
```

### When to index:

* High selectivity columns
* Columns in WHERE, JOIN, ORDER BY

Avoid indexing:

* Low-cardinality columns
* Columns frequently updated

---

# 10. Transactions & Isolation

### START TRANSACTION

```sql
START TRANSACTION;
UPDATE Student SET Marks = Marks + 2 WHERE RollNo = 101;
COMMIT;
```

### SAVEPOINT

```sql
SAVEPOINT s1;
UPDATE Student SET Marks = 10 WHERE RollNo = 102;
ROLLBACK TO s1;
```

### Isolation Levels

| Level            | Dirty | Non-Repeat | Phantom |
| ---------------- | ----- | ---------- | ------- |
| Read Uncommitted | Yes   | Yes        | Yes     |
| Read Committed   | No    | Yes        | Yes     |
| Repeatable Read  | No    | No         | Yes     |
| Serializable     | No    | No         | No      |

---

# 11. Triggers

### BEFORE INSERT

```sql
CREATE TRIGGER trg_marks_check
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
  IF NEW.Marks < 0 OR NEW.Marks > 100 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Marks';
  END IF;
END;
```

### AFTER INSERT (Audit)

```sql
CREATE TRIGGER trg_audit
AFTER INSERT ON Student
FOR EACH ROW
INSERT INTO AuditLog(RollNo, Action) VALUES(NEW.RollNo, 'INSERT');
```

---

# 12. Functions & Procedures

### Function

```sql
CREATE FUNCTION GetDept(dept INT)
RETURNS VARCHAR(50)
BEGIN
  DECLARE d VARCHAR(50);
  SELECT DeptName INTO d FROM Department WHERE DeptID = dept;
  RETURN d;
END;
```

### Procedure

```sql
CREATE PROCEDURE AddStudent(IN r INT, IN n VARCHAR(50), IN d INT)
BEGIN
  INSERT INTO Student(RollNo, Name, DeptID)
  VALUES (r, n, d);
END;
```

---

# 13. Set Operations (DB-Specific)

```sql
SELECT RollNo FROM Student
UNION
SELECT RollNo FROM Registration;

SELECT RollNo FROM Student
INTERSECT
SELECT RollNo FROM Registration;   -- DB-dependent
```

---

# 14. Window Functions (If Supported)

```sql
SELECT Name, Marks,
       RANK() OVER (ORDER BY Marks DESC) AS RankPos
FROM Student;
```

---

# 15. Quick Optimization Tips

* Prefer **JOINs** over nested subqueries where appropriate
* Index frequently filtered columns
* Avoid SELECT * in production queries
* Use LIMIT / OFFSET for pagination
* Normalize schema for update-heavy systems
* Denormalize carefully for read-heavy systems

---

