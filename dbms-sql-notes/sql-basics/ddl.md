---

# Data Definition Language (DDL)

## 1. Introduction

Data Definition Language (DDL) defines and manages the structural components of a database. It is used to create, modify, and delete schema-level objects such as tables, views, indexes, and constraints. DDL operations operate at the metadata layer and are typically auto-committed by most SQL engines.

---

## 2. Core DDL Commands

### 2.1 CREATE

The `CREATE` statement defines new database objects.

#### 2.1.1 Create Database

```
CREATE DATABASE CollegeDB;
```

#### 2.1.2 Create Table

```
CREATE TABLE Student (
    RollNo      INT PRIMARY KEY,
    Name        VARCHAR(50) NOT NULL,
    DeptID      INT,
    DOB         DATE,
    Email       VARCHAR(100) UNIQUE,
    CONSTRAINT fk_dept
        FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);
```

**Key elements:**

* Attribute definitions
* Data types
* Primary keys, unique keys
* Foreign key and check constraints
* Default values

---

### 2.2 ALTER

The `ALTER` statement modifies existing schema objects.

#### 2.2.1 Add a Column

```
ALTER TABLE Student
ADD Address VARCHAR(100);
```

#### 2.2.2 Modify Column Definition

```
ALTER TABLE Student
MODIFY Email VARCHAR(120);
```

#### 2.2.3 Drop a Column

```
ALTER TABLE Student
DROP COLUMN Address;
```

#### 2.2.4 Add Constraints

```
ALTER TABLE Student
ADD CONSTRAINT chk_dob CHECK (DOB <= CURRENT_DATE);
```

#### 2.2.5 Drop Constraints

```
ALTER TABLE Student
DROP CONSTRAINT chk_dob;
```

---

### 2.3 DROP

Removes an existing object and all associated data.

#### 2.3.1 Drop Table

```
DROP TABLE Student;
```

#### 2.3.2 Drop Database

```
DROP DATABASE CollegeDB;
```

**Note:** DROP is irreversible; all contained data and constraints are removed.

---

### 2.4 TRUNCATE

Deletes all rows from a table while preserving the table structure.

```
TRUNCATE TABLE Student;
```

**Characteristics:**

* Faster than `DELETE`
* Typically cannot be rolled back
* Resets auto-increment counters (DB-specific)

---

### 2.5 RENAME

Renames database objects.

```
RENAME TABLE Student TO Learner;
```

Alternate syntax depends on the SQL engine.

---

## 3. Schema-Level Constraints in DDL

### 3.1 Primary Key

```
PRIMARY KEY (RollNo)
```

### 3.2 Foreign Key

```
FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
```

### 3.3 Unique

```
UNIQUE (Email)
```

### 3.4 Not Null

```
Name VARCHAR(50) NOT NULL
```

### 3.5 Check

```
CHECK (Age >= 18)
```

### 3.6 Default

```
Status VARCHAR(10) DEFAULT 'Active'
```

---

## 4. DDL and Auto-Commit

Most RDBMS automatically commit DDL operations.
Exceptions may exist depending on:

* Transaction modes
* Vendor-specific settings

This behavior ensures metadata consistency but limits rollback capability.

---

## 5. Common Use Cases

* Designing initial schema structures
* Evolving database architecture during development cycles
* Enforcing business logic at the database layer
* Managing object lifecycle in production environments

---

## 6. Summary

DDL provides the structural foundation of a database system. By defining tables, relationships, and constraints, it shapes how data is stored, validated, and managed. A strong understanding of DDL ensures robust schema design and lays the groundwork for reliable SQL operations.

---


