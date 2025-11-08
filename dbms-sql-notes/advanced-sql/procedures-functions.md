---

# Procedures and Functions

## 1. Introduction

Stored procedures and functions are programmable database objects that encapsulate reusable logic executed within the DBMS engine.
They support modularization, performance optimization, and centralized enforcement of business rules.

Although both are part of SQL’s procedural extension layer, they differ in invocation semantics, return capabilities, and side-effect permissions.

---

# 2. Stored Procedures

## 2.1 Definition

A **stored procedure** is a named block of procedural SQL code stored in the database catalog.
Procedures allow complex operations, multi-step logic, conditional branching, loops, error handling, and data manipulation.

Procedures may return:

* No value
* Multiple values via OUT parameters
* Result sets via SELECT statements

---

## 2.2 Syntax

### Basic Structure

```
DELIMITER $$

CREATE PROCEDURE AddStudent(
    IN roll INT,
    IN name VARCHAR(50),
    IN dept INT
)
BEGIN
    INSERT INTO Student(RollNo, Name, DeptID)
    VALUES (roll, name, dept);
END$$

DELIMITER ;
```

### Calling a Procedure

```
CALL AddStudent(101, 'Arun', 3);
```

---

## 2.3 Parameter Modes

| Mode      | Description                                      |
| --------- | ------------------------------------------------ |
| **IN**    | Passed by value; read-only within procedure      |
| **OUT**   | Used to return values; cannot read initial value |
| **INOUT** | Read input value and can modify output           |

### Example:

```
CREATE PROCEDURE UpdateMarks(
    IN roll INT,
    INOUT newMarks INT
)
BEGIN
    UPDATE Student SET Marks = newMarks WHERE RollNo = roll;
END;
```

---

## 2.4 Procedural Constructs

### Conditional Logic

```
IF Marks < 40 THEN
    SET Grade = 'F';
ELSE
    SET Grade = 'P';
END IF;
```

### Loops

```
WHILE counter < 10 DO
    SET counter = counter + 1;
END WHILE;
```

### Error Handling (MySQL SIGNAL)

```
SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid Input';
```

---

## 2.5 Use Cases

* Multi-step DML operations (e.g., order processing)
* Data migrations & batch processing
* Complex business rules
* Encapsulating frequently used SQL
* Auditing & system tasks

---

# 3. Functions

## 3.1 Definition

A **function** is a stored program that accepts parameters and **returns a single value**.
Functions are intended for computation, transformation, and deterministic logic.

Functions **must return exactly one value** via the RETURN statement.

Unlike procedures, functions:

* Can be used inside SELECT, WHERE, GROUP BY, etc.
* Cannot modify database state in most DBMSs
* Are expected to be deterministic unless explicitly marked otherwise

---

## 3.2 Syntax

### Basic Structure

```
DELIMITER $$

CREATE FUNCTION GetDeptName(dept INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE dname VARCHAR(50);
    SELECT DeptName INTO dname
    FROM Department
    WHERE DeptID = dept;
    RETURN dname;
END$$

DELIMITER ;
```

### Calling a Function

```
SELECT GetDeptName(3);
```

---

## 3.3 Characteristics

### Functions Must:

* Return a value
* Declare return type
* Be side-effect free (in many systems)
* Avoid DML operations unless permitted by the DB engine

### Determinism

* `DETERMINISTIC` → Always returns the same result for same input
* `NOT DETERMINISTIC` → May vary (e.g., NOW(), RAND())

---

# 4. Procedures vs Functions

| Aspect              | Procedure                        | Function                     |
| ------------------- | -------------------------------- | ---------------------------- |
| Returns value       | Optional / multiple (OUT params) | Mandatory single return      |
| Called using        | `CALL`                           | Inside queries               |
| Supports DML        | Yes                              | Often restricted             |
| Use in SELECT       | Not allowed                      | Allowed                      |
| Transaction control | Allowed (COMMIT/ROLLBACK)        | Not allowed                  |
| Primary purpose     | Jobs, operations                 | Computation, transformations |

---

# 5. Advanced Concepts

## 5.1 Stored Program Variables

Procedures and functions can declare:

* Local variables
* Cursors
* Handlers for exceptions

### Example:

```
DECLARE total INT DEFAULT 0;
```

---

## 5.2 Cursors

Used to iterate over query results row by row.

```
DECLARE cur CURSOR FOR
SELECT RollNo FROM Student;
```

```
OPEN cur;
FETCH cur INTO r;
CLOSE cur;
```

Useful for batch tasks and row-by-row transformations.

---

## 5.3 Triggers vs Procedures/Functions

| Feature     | Trigger                  | Procedure/Function            |
| ----------- | ------------------------ | ----------------------------- |
| Invocation  | Automatic (event-driven) | Manual call / query reference |
| Use case    | Auditing, enforcement    | Business logic, calculations  |
| Flexibility | Event-bound              | Fully general                 |

---

# 6. Performance Considerations

* Procedures reduce network overhead by bundling SQL logic.
* Functions inside SELECT can slow down large result sets.
* Excessive procedural logic inside DB may complicate scaling.
* Cursors are slower than set-based SQL and should be minimized.

---

# 7. Security and Permissions

### Creating:

```
CREATE ROUTINE, ALTER ROUTINE
```

### Executing:

```
EXECUTE privilege
```

### Definer vs Invoker Rights

DBMS may allow routines to run as:

* **DEFINER** (creator privileges)
* **INVOKER** (caller privileges)

Used to implement privilege control layers.

---

# 8. Dropping Routines

### Drop Procedure

```
DROP PROCEDURE AddStudent;
```

### Drop Function

```
DROP FUNCTION GetDeptName;
```

---

# 9. Summary

Stored procedures and functions enhance modularity, reusability, and performance within relational databases.
Procedures excel at multi-step operations, DML tasks, and unit-of-work patterns.
Functions serve as computational building blocks that integrate seamlessly into SQL queries.

Together, they form a powerful extension mechanism that allows the DBMS to function not only as a storage system but also as an execution engine for business logic.

---


