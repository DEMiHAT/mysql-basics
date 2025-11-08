# SQL & DBMS Practice Exercises

**Based on the schema defined in `schema.sql`**

This file contains **100 structured practice questions** covering DDL, DML, DQL, joins, subqueries, normalization, ER modeling, indexing, triggers, and transactions.

---

# 1. Basic SELECT Queries (10)

1. Retrieve all rows from the Student table.
2. Display RollNo, Name, and Marks of all students.
3. List all departments sorted by Strength in descending order.
4. Get distinct department IDs from Student.
5. Display students whose Marks are greater than 80.
6. Retrieve students of Semester 5.
7. Show all students whose name starts with 'A'.
8. Display all departments located in ‘Block A’.
9. List all courses with 4 credits.
10. Display all students whose email is NULL.

---

# 2. Filtering & Conditional Queries (10)

11. Fetch students with Semester between 3 and 6.
12. Retrieve students whose DeptID is 1 or 3.
13. Find the student with the highest marks.
14. Fetch students whose name ends with ‘a’.
15. Display courses whose CourseID is NOT IN (301, 303).
16. List faculty in Department 2.
17. Retrieve students older than 20 (use DOB).
18. Find students registered before ‘2025-01-10’.
19. Show all students who have NOT been assigned marks.
20. Get all attendance entries marked as 'Absent'.

---

# 3. Aggregation & Group By (10)

21. Count the number of students in each department.
22. Find the average marks per department.
23. Get the department with the highest student strength.
24. Find the maximum and minimum marks per semester.
25. Count registrations per course.
26. Find total internal marks awarded in the Marks table.
27. Get course-wise average external marks.
28. Retrieve departments having more than 100 students.
29. Find semesters in which more than 30 students study.
30. Get number of present and absent records per course.

---

# 4. Joins (10)

31. Retrieve student names with their department names.
32. Show student name, course title, and semester using Registration.
33. List all marks with student name and course title.
34. Show faculty names with their department names.
35. List all students and their registered courses (if any).
36. List students who do not belong to any department (if exists).
37. Display courses that do not have any registration.
38. List departments and number of students in each.
39. Show students with corresponding attendance statuses for a date.
40. Find students with more than one registration entry.

---

# 5. Subqueries (15)

41. Retrieve students whose marks are above the department average.
42. Find students who have the maximum marks in the whole table.
43. Get courses offered by the same department as ‘DBMS’.
44. List students whose department is located in 'Block A'.
45. Retrieve departments with at least one student.
46. Find departments with no faculty assigned.
47. Get students who are registered for ALL courses in their department.
48. Fetch students who have attendance less than 75%.
49. Retrieve students who share the same marks as RollNo 101.
50. List students whose total marks exceed the overall average.
51. Find top 3 students using a subquery.
52. Retrieve students who are younger than the average student age.
53. List departments with above-average strength.
54. Get students who registered for a course taught by faculty in their own department.
55. Find students who have never been absent.

---

# 6. DML Exercises (10)

56. Insert a new student into the Student table.
57. Update marks of student with RollNo 101 to 95.
58. Change the email of student 102.
59. Delete a student who has no registrations.
60. Update department strength after adding a student.
61. Insert a new department.
62. Delete a course that has no registrations.
63. Insert a record into Marks for a new evaluation.
64. Change ‘Absent’ to ‘Present’ for a mistakenly marked attendance.
65. Remove attendance older than 1 year.

---

# 7. View Exercises (5)

66. Create a view showing student name, dept name, and marks.
67. Create a view of students with marks > 80.
68. Create a view listing all registrations with student and course names.
69. Update data through an updatable view (simple table).
70. Drop the created views.

---

# 8. Indexing Exercises (5)

71. Create an index on Marks column in Student.
72. Create a composite index on (DeptID, Semester).
73. Drop the index created above.
74. Evaluate query plans (EXPLAIN) for index usage.
75. Create an index on Course.Title for faster searching.

---

# 9. Trigger Exercises (10)

76. Create a BEFORE INSERT trigger to validate Marks range (0–100).
77. Create a BEFORE UPDATE trigger to lowercase email.
78. Create an AFTER INSERT trigger for auditing student inserts.
79. Create an AFTER DELETE trigger to archive deleted students.
80. Create a trigger preventing deletion of a department if students exist.
81. Create a trigger to auto-update Department.Strength on student insert.
82. Create a trigger to deduct attendance count upon absence insertion.
83. Create a trigger to prevent course deletion if marks exist.
84. Disable a trigger (if DB supports it).
85. Drop all created triggers.

---

# 10. Transaction Exercises (10)

86. Use a transaction to transfer marks between two students safely.
87. Demonstrate ROLLBACK by updating a record and reverting it.
88. Use SAVEPOINT during a multi-step update.
89. Simulate lost update and solve using transaction isolation.
90. Execute a serializable transaction and analyze behavior.
91. Demonstrate dirty read (if DB supports READ UNCOMMITTED).
92. Show non-repeatable read scenario.
93. Simulate phantom read and avoid using SERIALIZABLE.
94. Implement retry logic on deadlock detection.
95. Use START TRANSACTION to batch multiple inserts.

---

# 11. DBMS Theory Exercises (10)

96. Define functional dependency with examples from schema.
97. Identify candidate keys in Student and Department tables.
98. Normalize a given unnormalized student dataset to 3NF.
99. Draw ER diagram for all tables in schema.sql.
100. Explain how MVCC improves concurrency in this schema.

---

# End of File


