---

# Data Control Language (DCL) & Transaction Control Language (TCL)

## 1. Introduction

This document outlines the core commands of **Data Control Language (DCL)** and **Transaction Control Language (TCL)**.
DCL manages access privileges and security policies at the database level, whereas TCL governs the transactional behavior of DML operations, ensuring consistency, recoverability, and controlled state transitions.

---

# 2. Data Control Language (DCL)

## 2.1 Purpose

DCL defines permissions that regulate which users or roles can access or manipulate specific database objects.
These commands are essential for maintaining controlled multi-user environments.

---

## 2.2 GRANT

Used to assign privileges to a user or role.

### 2.2.1 Grant Basic Privileges

```
GRANT SELECT, INSERT 
ON Student
TO userA;
```

### 2.2.2 Grant All Privileges

```
GRANT ALL PRIVILEGES
ON Department
TO adminUser;
```

### 2.2.3 Grant with Admin Option (DB-Specific)

Allows the grantee to further distribute privileges.

```
GRANT SELECT 
ON Course
TO analyst WITH GRANT OPTION;
```

---

## 2.3 REVOKE

Removes previously granted privileges.

```
REVOKE INSERT, UPDATE
ON Student
FROM userA;
```

Revoking privileges cascades according to the dependency graph defined by the DBMS.

---

## 2.4 Typical Use Cases

* Enforcing access boundaries in multi-user systems
* Restricting high-risk operations
* Implementing role-based security models
* Managing privilege hierarchies

---

# 3. Transaction Control Language (TCL)

## 3.1 Purpose

TCL commands ensure that DML operations are executed in a reliable, atomic, and consistent manner.
They facilitate commit/rollback control, savepoints, and multi-statement transactional logic.

---

## 3.2 COMMIT

Permanently saves all changes made during the current transaction.

```
COMMIT;
```

Once committed, changes become durable and visible to other sessions.

---

## 3.3 ROLLBACK

Reverts all changes in the current transaction to the most recent consistent state.

```
ROLLBACK;
```

Useful when encountering errors or failed conditions in DML operations.

---

## 3.4 SAVEPOINT

Creates an internal checkpoint within a transaction.

```
SAVEPOINT sp1;
```

Allows partial rollbacks to specific points.

---

## 3.5 ROLLBACK TO SAVEPOINT

Reverts changes back to a named savepoint without discarding the entire transaction.

```
ROLLBACK TO sp1;
```

---

## 3.6 SET TRANSACTION (Optional / DB-Specific)

Defines isolation levels and transaction modes.

```
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

Isolation levels include:

* READ UNCOMMITTED
* READ COMMITTED
* REPEATABLE READ
* SERIALIZABLE

---

# 4. DCL & TCL Interaction with DML

* DML operations (INSERT, UPDATE, DELETE) remain **uncommitted** until confirmed by a TCL command.
* Improper transaction management can lead to:

  * lost updates
  * dirty reads
  * non-repeatable reads
  * phantom reads
* DCL privileges govern *who* is permitted to run DML and TCL operations on specific objects.

---

# 5. Summary

DCL ensures secure and controlled access to database objects through explicit privilege management, while TCL governs the execution of transactional operations to maintain consistency and integrity. Together, these command sets form essential operational layers for multi-user, multi-transaction relational database environments.

---


