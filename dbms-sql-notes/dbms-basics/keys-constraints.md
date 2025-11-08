# Keys and Constraints

## 1. Introduction

Keys and constraints form the integrity backbone of the relational model. They define how tuples are identified, how relationships are enforced, and how data correctness is guaranteed. This document outlines the various key types and the integrity constraints that structure well-formed relational schemas.

---

## 2. Keys in the Relational Model

### 2.1 Super Key

A super key is any set of attributes that uniquely identifies a tuple in a relation.

**Properties:**

* May contain extraneous attributes.
* Every candidate key is a super key, but not vice versa.

**Example:**
In `Student(RollNo, Name, Email)`,
`{RollNo, Email}` is a super key.

---

### 2.2 Candidate Key

A minimal super key that contains no redundant attributes.

**Characteristics:**

* Ensures uniqueness.
* Minimality is enforced.

**Example:**
`RollNo` and `Email` may both be candidate keys.

---

### 2.3 Primary Key

A candidate key selected to uniquely identify tuples within a relation.

**Features:**

* Cannot accept NULL values.
* Rarely changed due to dependence by foreign keys.

**Example:**
`RollNo` is typically chosen as the primary key for `Student`.

---

### 2.4 Alternate Key

Candidate keys that are not chosen as the primary key.

**Example:**
If `RollNo` is the primary key, then `Email` becomes an alternate key.

---

### 2.5 Composite Key

A key formed by combining multiple attributes when a single attribute cannot guarantee uniqueness.

**Example:**
`(CourseID, Semester)` may be a composite primary key in a timetable table.

---

### 2.6 Foreign Key

An attribute (or set of attributes) that establishes a referential link to the primary key of another relation.

**Purpose:**

* Maintains referential integrity.
* Represents relationships such as one-to-many or many-to-one.

**Example:**
`DeptID` in `Student` referencing `Dept(DeptID)`.

---

## 3. Integrity Constraints

### 3.1 Domain Constraints

Specify the permissible values for attributes.

**Examples:**

* Data types (INT, VARCHAR, DATE)
* Range checks (Salary > 0)
* Enumerated domains (Status ∈ {Active, Inactive})

---

### 3.2 Entity Integrity Constraint

Ensures that the primary key of a relation:

* Cannot be NULL
* Must uniquely identify each tuple

This guarantees that each row is distinguishable.

---

### 3.3 Referential Integrity Constraint

Enforces valid references between relations. A foreign key value must either:

* Match an existing primary key in the parent table, or
* Be NULL (if permitted)

**Violation Example:**
A `Student.DeptID` referencing a non-existent department.

---

### 3.4 Key Constraints

Ensure uniqueness for candidate keys and enforce non-nullability for primary keys.

**Key Constraint Rules:**

* No two tuples may share identical primary key values.
* Candidate keys (if enforced) also must remain unique.

---

### 3.5 Check Constraints

Define logical conditions that attribute values must satisfy.

**Examples:**

* `Age >= 18`
* `Marks BETWEEN 0 AND 100`
* `Quantity > 0`

These constraints help encode application-level safeguards within the schema.

---

### 3.6 Unique Constraints

Guarantee that values in an attribute (or set of attributes) remain unique across tuples, except they allow **NULL** values unless otherwise restricted.

**Example:**
`Email` may be declared UNIQUE in a user table.

---

## 4. Constraint Enforcement Actions

### 4.1 On Delete / On Update Actions

Used with foreign keys to define referential behavior:

* **CASCADE**: Propagates changes.
* **SET NULL**: Replaces with NULL.
* **SET DEFAULT**: Reverts to default value.
* **RESTRICT / NO ACTION**: Prevents modification if dependencies exist.

These actions manage relational consistency during updates and deletions.

---

## 5. Summary

Keys provide identity and structure within relations, while constraints enforce correctness, consistency, and predictable behavior. Together they define the rules that govern how data is maintained, validated, and interconnected in a relational database.

---

