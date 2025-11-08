---

# Transactions

## 1. Introduction

A **transaction** is a logical unit of work that groups one or more DML operations into an atomic, consistent, and durable execution boundary.
Transactions ensure that multi-step operations behave predictably even under concurrency, failures, or system crashes.

They are the foundation of reliable database systems, enabling correctness, isolation, and crash recovery in multi-user environments.

---

# 2. The ACID Properties

## 2.1 Atomicity

A transaction’s operations must behave as a single indivisible unit:

* Either **all changes** are applied, or
* **None** are applied (rollback).

This guarantees consistency even when errors occur.

---

## 2.2 Consistency

Transactions must transition the database from one valid state to another valid state, preserving:

* Key constraints
* Referential integrity
* Business rules
* CHECK conditions

Consistency is enforced by the DBMS and user-defined constraints.

---

## 2.3 Isolation

Concurrency should not expose intermediate or partial states of a transaction.
Each transaction should behave **as if it is running alone**, even when executed concurrently.

Isolation is controlled via:

* Locks
* Timestamps
* Multi-Version Concurrency Control (MVCC)
* Isolation levels

---

## 2.4 Durability

Once a transaction commits:

* Changes must persist even in power failures, crashes, or restarts.

Durability is guaranteed through:

* Write-Ahead Logging (WAL)
* Redo logs
* Checkpointing
* Crash recovery processes

---

# 3. Transaction Lifecycle

1. **Begin / Start Transaction**
2. **Execute Operations (DML)**
3. **Temporary States (Uncommitted Changes)**
4. **COMMIT** → Persist changes.
5. **ROLLBACK** → Undo changes.
6. **Recovery** (if failure occurs mid-transaction)

Example:

```
START TRANSACTION;
UPDATE Account SET Balance = Balance - 200 WHERE AccNo = 1001;
UPDATE Account SET Balance = Balance + 200 WHERE AccNo = 1002;
COMMIT;
```

---

# 4. Transaction Anomalies (Dirty, Non-Repeatable, Phantom Reads)

## 4.1 Dirty Read

A transaction reads data written by another uncommitted transaction.

T1: UPDATE Balance = 5000
T2: SELECT Balance (reads uncommitted)

If T1 rolls back → T2 read invalid data.

---

## 4.2 Non-Repeatable Read

A row read once is modified by another transaction before being read again.

T1 reads Marks → 80
T2 updates Marks → 90
T1 reads again → 90

Value changes across reads.

---

## 4.3 Phantom Read

A transaction re-executes a range query and gets **new rows** inserted or deleted by others.

T1: SELECT * FROM Orders WHERE Amount > 100
T2: INSERT INTO Orders (Amount = 150)
T1 repeats query → sees new “phantom” row

---

# 5. Isolation Levels (ANSI/ISO Standard)

## 5.1 Read Uncommitted

* Allows dirty, non-repeatable, phantom reads
* Highest concurrency, lowest isolation

```
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

---

## 5.2 Read Committed

* Prevents dirty reads
* Allows non-repeatable and phantom reads
* Default in Oracle, SQL Server

```
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

---

## 5.3 Repeatable Read

* Prevents dirty and non-repeatable reads
* Phantoms may still occur
* Default in MySQL InnoDB (with MVCC)

```
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

---

## 5.4 Serializable

Strongest isolation level. Behaves as if transactions run one after another.

* Prevents dirty, non-repeatable, and phantom reads
* May reduce concurrency

```
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

---

# 6. Concurrency Control

Concurrency control ensures correctness when transactions run simultaneously.

## 6.1 Lock-Based Concurrency Control

### Shared Lock (S)

* Allows read
* Multiple S locks can coexist

### Exclusive Lock (X)

* Allows write
* Only one X lock allowed
* Blocks all other locks

### Lock Compatibility Table

|   | S   | X  |
| - | --- | -- |
| S | Yes | No |
| X | No  | No |

---

### Two-Phase Locking (2PL)

#### Phase 1: Growing Phase

Acquires locks.

#### Phase 2: Shrinking Phase

Releases locks.

Strict 2PL is widely used and guarantees serializability.

---

## 6.2 Deadlocks

Occurs when two transactions wait on each other’s locks.

### Example:

* T1 locks A, waits for B
* T2 locks B, waits for A

DBMS detects deadlock and rolls back one transaction.

---

## 6.3 Timestamp Ordering (TO)

Transactions get timestamps and operate based on logical time order.

Prevents cycles but may cause frequent aborts.

---

## 6.4 Optimistic Concurrency Control (OCC)

* No locking during reads
* Validation phase on commit
* Best for read-heavy workloads

---

# 7. MVCC (Multi-Version Concurrency Control)

Most modern DBMS (PostgreSQL, MySQL InnoDB) use MVCC.

## 7.1 Core Idea

* Instead of locking rows for readers, the DBMS provides **snapshots** of data.
* Writers create new versions instead of blocking readers.

Readers see:

* The latest committed version **at the time their transaction began**.

Advantages:

* No read locks
* High concurrency
* Reduced contention

MVCC enables Phantom avoidance when combined with indexing.

---

# 8. Logging & Recovery

## 8.1 Write-Ahead Logging (WAL)

Before updating data files, the DBMS writes changes to log files.

Ensures:

* Redo on commit
* Undo on failure

---

## 8.2 Checkpoints

Periodically forces dirty pages to disk.

Reduces recovery time after crash.

---

## 8.3 Crash Recovery Procedure

1. **Analysis Phase** – identify active transactions
2. **Redo Phase** – reapply committed operations
3. **Undo Phase** – rollback uncommitted operations

Guarantees durability.

---

# 9. Distributed Transactions

## 9.1 Two-Phase Commit Protocol (2PC)

Used in distributed DBs:

### Phase 1: Prepare

Coordinator asks all nodes: *"Can you commit?"*

### Phase 2: Commit / Abort

* If all agree → commit
* If any abort → all rollback

Guarantees global ACID across nodes.

---

## 9.2 Three-Phase Commit (3PC)

Adds timeout and safety mechanisms for network failures.

---

# 10. Savepoints

Used to partially rollback inside a larger transaction.

```
SAVEPOINT s1;
UPDATE Employee SET Salary = Salary + 1000;
ROLLBACK TO s1;
```

Reduces cost of full rollbacks.

---

# 11. Autocommit Mode

Many DBMS default to autocommit:

* Every statement = implicit transaction
* Explicit transactions override this

```
SET autocommit = 0;
```

Used for manual transaction control.

---

# 12. Real-World Examples & Patterns

### 12.1 Banking Transfer

Atomic multi-step logic ensuring consistency.

### 12.2 Inventory Deduction

Prevent overselling under high concurrency.

### 12.3 Order Processing

Serializable transactions ensure correctness.

---

# 13. Best Practices (Enterprise-Grade)

* Keep transactions **short** to reduce lock contention.
* Avoid unnecessary SELECT … FOR UPDATE.
* Index columns used in WHERE clauses inside transactions.
* Use appropriate isolation levels; do not default to SERIALIZABLE without need.
* Avoid long-running transactions in OLTP systems.
* Monitor deadlocks and lock wait timeouts.
* Use retry-logic for serialization failures in MVCC systems.

---

# 14. Summary

Transactions are a foundational mechanism ensuring correctness, reliability, and concurrency in relational databases. They enforce ACID properties, mitigate anomalies, and support structured recovery after failures. Advanced concepts such as MVCC, locking, timestamp ordering, WAL, 2PL, and 2PC make modern database systems resilient and performant under a wide range of workloads.

A robust understanding of transaction theory is essential for designing scalable, fault-tolerant, and high-concurrency database applications.

---

