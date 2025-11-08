---

# Triggers

## 1. Introduction

A **trigger** is a procedural database object executed automatically in response to specific events on a table or view.
Triggers are tightly integrated with the transactional engine and enforce rule-based behaviors such as auditing, validation, cascaded updates, and automated derivations.

Triggers operate at the row or statement level and execute before or after an INSERT, UPDATE, or DELETE.

---

# 2. Trigger Types

## 2.1 Based on Execution Timing

* **BEFORE Trigger**
  Executes prior to the triggering event.
  Used for validation or transformation.

* **AFTER Trigger**
  Executes after the event completes.
  Used for logging, auditing, or cross-table propagation.

## 2.2 Based on Event

* **INSERT Trigger**
* **UPDATE Trigger**
* **DELETE Trigger**

## 2.3 Based on Granularity

* **Row-Level Trigger**
  Executes once per affected row (`FOR EACH ROW`).
  Provides access to `NEW` and `OLD` pseudo-records.

* **Statement-Level Trigger**
  Executes once per triggering SQL statement, irrespective of affected row count.

---

# 3. Syntax and Usage

## 3.1 Creating a BEFORE INSERT Trigger

Ensures data validation before insertion.

```
CREATE TRIGGER trg_validate_marks
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
    IF NEW.Marks < 0 OR NEW.Marks > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid marks range';
    END IF;
END;
```

---

## 3.2 AFTER INSERT Trigger (Auditing)

```
CREATE TRIGGER trg_log_student_insert
AFTER INSERT ON Student
FOR EACH ROW
BEGIN
    INSERT INTO StudentLog(RollNo, Action, Timestamp)
    VALUES (NEW.RollNo, 'INSERT', NOW());
END;
```

---

## 3.3 BEFORE UPDATE Trigger (Data Normalization)

```
CREATE TRIGGER trg_normalize_email
BEFORE UPDATE ON Student
FOR EACH ROW
BEGIN
    SET NEW.Email = LOWER(NEW.Email);
END;
```

---

## 3.4 AFTER DELETE Trigger (Archiving)

```
CREATE TRIGGER trg_archive_deleted_student
AFTER DELETE ON Student
FOR EACH ROW
BEGIN
    INSERT INTO DeletedStudents(RollNo, Name, DeletedAt)
    VALUES (OLD.RollNo, OLD.Name, NOW());
END;
```

---

# 4. Accessing OLD and NEW Values

| Event Type | OLD       | NEW       |
| ---------- | --------- | --------- |
| INSERT     | NULL      | Available |
| UPDATE     | Available | Available |
| DELETE     | Available | NULL      |

These pseudo-records expose row values before and after the triggering event.

---

# 5. Enabling/Disabling Triggers (DB-Specific)

### Disable a trigger:

```
ALTER TABLE Student DISABLE TRIGGER trg_name;
```

### Enable a trigger:

```
ALTER TABLE Student ENABLE TRIGGER trg_name;
```

(MySQL requires dropping and recreating; PostgreSQL supports enabling/disabling.)

---

# 6. Common Use Cases

### 6.1 Auditing and Logging

Track changes across critical tables.

### 6.2 Data Validation

Enforce data constraints beyond CHECK limitations.

### 6.3 Cascading Actions

Propagate updates or deletes to related tables.

### 6.4 Derived Attributes

Automatically compute or update derived values.

### 6.5 History Tracking

Maintain historical snapshots of data.

---

# 7. Performance Considerations

* Triggers add overhead to DML operations.
* Excessive or complex triggers can slow down high-throughput systems.
* Cascaded triggers may cause unintended recursion or logic chains.
* Debugging becomes harder due to hidden execution logic.

Well-designed triggers should be minimal, predictable, and documented.

---

# 8. Limitations

* Cannot commit or rollback within triggers (transaction-scoped).
* May cause side effects if business logic is tightly coupled to triggers.
* Not ideal for bulk operations requiring high performance.
* Some DBMS restrict triggers on views or require INSTEAD OF triggers.

---

# 9. Dropping a Trigger

```
DROP TRIGGER trg_validate_marks;
```

---

# 10. Summary

Triggers provide powerful mechanisms for implementing automated, rule-driven behaviors within a relational database. They support auditing, validation, and derived updates but must be used judiciously due to performance and maintenance overhead. Understanding trigger timing, scope, and pseudo-record semantics is essential for designing robust database systems.

---

