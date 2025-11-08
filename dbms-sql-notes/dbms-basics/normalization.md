# Normalization

## 1. Introduction

Normalization is a systematic process used to structure relational schemas to minimize redundancy, reduce update anomalies, and ensure data integrity. It relies on **functional dependencies**, **keys**, and decomposition principles to transform relations into stable, well-defined forms.

This document outlines the major normal forms used in relational database design, their requirements, and the rationale behind each transformation.

---

## 2. Objectives of Normalization

* Eliminate redundant data.
* Prevent insertion, deletion, and update anomalies.
* Preserve functional dependencies where possible.
* Produce relations that reflect logical data groupings.
* Ensure lossless join during decomposition.

Normalization is an essential step in transforming a high-level data model into an efficient relational schema.

---

## 3. Functional Dependencies (FDs)

A functional dependency describes a relationship between attributes in a relation.

**Definition:**
An attribute set **X** functionally determines **Y** (written as `X → Y`) if each value of X is associated with exactly one value of Y.

**Examples:**

* `RollNo → Name, Dept, Year`
* `DeptID → DeptName`

Functional dependencies form the theoretical basis for detecting redundancy and performing decomposition.

---

## 4. Types of Anomalies

Normalization primarily resolves the following anomalies:

### 4.1 Update Anomaly

A change in one tuple requires updates in multiple places.

### 4.2 Insertion Anomaly

Inability to insert certain data because other data is missing.

### 4.3 Deletion Anomaly

Deleting a tuple unintentionally removes other critical information.

---

## 5. Normal Forms

---

## 5.1 First Normal Form (1NF)

A relation is in 1NF if:

* All attributes contain **atomic** values.
* No repeating groups, multivalued attributes, or nested relations exist.

**Example of Violation:**

```
Courses = {CourseID, StudentName, Marks{M1, M2}}
```

**Normalized Form:**
Split multivalued attributes into separate rows.

---

## 5.2 Second Normal Form (2NF)

A relation is in 2NF if:

* It is in 1NF, and
* **No partial dependency** exists (i.e., no non-key attribute depends on part of a composite key).

**Applies only when the primary key is composite.**

**Violation Example:**

```
Enrollment(StudentID, CourseID, StudentName)
```

Here, `StudentName` depends only on `StudentID`, not on the full key `(StudentID, CourseID)`.

---

## 5.3 Third Normal Form (3NF)

A relation is in 3NF if:

* It is in 2NF, and
* **No transitive dependency** exists between non-key attributes.

**Violation Example:**

```
Student(RollNo, DeptID, DeptName)
```

`RollNo → DeptID` and `DeptID → DeptName`, producing a transitive dependency.

**Resolution:**
Separate `Department(DeptID, DeptName)`.

---

## 5.4 Boyce–Codd Normal Form (BCNF)

A stronger form of 3NF.

A relation is in BCNF if:
For every functional dependency `X → Y`,
**X must be a super key**.

**BCNF fixes cases where 3NF is satisfied but anomalies remain.**

**Example:**
A table with overlapping candidate keys.

---

## 5.5 Fourth Normal Form (4NF)

A relation is in 4NF if:

* It is in BCNF, and
* It contains **no multivalued dependencies (MVDs)** other than trivial ones.

**Used for:**
Schemas with independent multivalued attributes.

---

## 5.6 Fifth Normal Form (5NF)

A relation is in 5NF (also known as PJ/NF) if:

* It is decomposed to eliminate **join dependencies**,
* And every join dependency is implied by candidate keys.

5NF handles highly decomposed structures in complex integration scenarios.

---

## 6. Lossless Join and Dependency Preservation

### 6.1 Lossless Join

A decomposition is lossless if:

* The original relation can be reconstructed exactly through joins.

**Lossless Join Condition:**
At least one of the decomposed relations must contain a candidate key of the original.

### 6.2 Dependency Preservation

All functional dependencies must remain enforceable after decomposition without costly joins.

**Ideal decomposition:**
Lossless join + dependency preserved.

---

## 7. Summary

Normalization is a foundational process that reshapes relational schemas into stable, anomaly-free structures. By methodically applying 1NF through BCNF and beyond, database designers achieve schemas that are logically consistent, efficient to update, and resilient to redundancy. The goal is always to balance theoretical correctness with practical performance considerations.

---


