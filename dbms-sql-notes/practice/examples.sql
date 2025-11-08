-- ============================================================
-- EXAMPLES.SQL – PRACTICE QUERIES FOR DBMS & SQL
-- Works with schema.sql provided in this repository.
-- ============================================================

---------------------------------------------------------------
-- 1. BASIC SELECT QUERIES
---------------------------------------------------------------
SELECT * FROM Student;
SELECT Name, DeptID FROM Student;
SELECT RollNo, Name, Marks FROM Student WHERE Marks > 75;
SELECT DISTINCT DeptID FROM Student;
SELECT * FROM Department ORDER BY Strength DESC;

---------------------------------------------------------------
-- 2. FILTERING (WHERE, LIKE, BETWEEN, IN, NULL)
---------------------------------------------------------------
SELECT Name FROM Student WHERE DeptID = 1;
SELECT Name FROM Student WHERE Name LIKE 'A%';
SELECT * FROM Student WHERE Semester BETWEEN 3 AND 5;
SELECT * FROM Student WHERE DeptID IN (1,3);
SELECT * FROM Student WHERE Email IS NULL;

---------------------------------------------------------------
-- 3. AGGREGATION & GROUP BY
---------------------------------------------------------------
SELECT DeptID, COUNT(*) AS TotalStudents 
FROM Student 
GROUP BY DeptID;

SELECT DeptID, AVG(Marks) AS AvgMarks 
FROM Student 
GROUP BY DeptID HAVING AVG(Marks) > 70;

SELECT Semester, MAX(Marks), MIN(Marks)
FROM Student
GROUP BY Semester;

---------------------------------------------------------------
-- 4. JOIN OPERATIONS
---------------------------------------------------------------
-- Inner Join
SELECT S.Name, D.DeptName
FROM Student S
INNER JOIN Department D ON S.DeptID = D.DeptID;

-- Left Join
SELECT S.Name, D.DeptName
FROM Student S
LEFT JOIN Department D ON S.DeptID = D.DeptID;

-- Multi-table Join
SELECT S.Name, C.Title, R.Semester
FROM Student S
JOIN Registration R ON S.RollNo = R.RollNo
JOIN Course C ON R.CourseID = C.CourseID;

-- Join with Marks Table
SELECT S.Name, C.Title, M.Internal, M.External, M.Total
FROM Student S
JOIN Marks M ON S.RollNo = M.RollNo
JOIN Course C ON M.CourseID = C.CourseID;

---------------------------------------------------------------
-- 5. SUBQUERY PRACTICE
---------------------------------------------------------------
-- Scalar Subquery
SELECT Name 
FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student);

-- IN Subquery
SELECT Name
FROM Student
WHERE DeptID IN (
    SELECT DeptID FROM Department WHERE Location = 'Block A'
);

-- EXISTS Subquery
SELECT DeptName
FROM Department D
WHERE EXISTS (
    SELECT 1 FROM Student S WHERE S.DeptID = D.DeptID
);

-- Correlated Subquery
SELECT Name
FROM Student S
WHERE Marks > (
    SELECT AVG(Marks) 
    FROM Student 
    WHERE DeptID = S.DeptID
);

-- Derived Table
SELECT DeptID, AvgMarks
FROM (
    SELECT DeptID, AVG(Marks) AS AvgMarks
    FROM Student
    GROUP BY DeptID
) T
WHERE AvgMarks > 70;

---------------------------------------------------------------
-- 6. DML COMMANDS
---------------------------------------------------------------
INSERT INTO Student(RollNo, Name, DeptID, Semester, DOB, Email, Marks)
VALUES (110, 'Sanjay', 1, 4, '2004-02-10', 'sanjay@college.com', 82);

UPDATE Student
SET Marks = 90
WHERE RollNo = 101;

DELETE FROM Student
WHERE RollNo = 110;

---------------------------------------------------------------
-- 7. ADVANCED JOIN QUERIES
---------------------------------------------------------------
-- Students with no registrations
SELECT S.Name
FROM Student S
LEFT JOIN Registration R ON S.RollNo = R.RollNo
WHERE R.RollNo IS NULL;

-- Departments with no students
SELECT D.DeptName
FROM Department D
LEFT JOIN Student S ON D.DeptID = S.DeptID
WHERE S.DeptID IS NULL;

-- Students enrolled in more than one course
SELECT RollNo, COUNT(*) AS CourseCount
FROM Registration
GROUP BY RollNo
HAVING COUNT(*) > 1;

---------------------------------------------------------------
-- 8. SET OPERATIONS (DB-Specific)
---------------------------------------------------------------
-- Example Dataset (Logical)
-- UNION
SELECT RollNo FROM Student
UNION
SELECT RollNo FROM Registration;

-- EXCEPT / MINUS (Depends on SQL engine)
-- SELECT RollNo FROM Student
-- EXCEPT
-- SELECT RollNo FROM Registration;

---------------------------------------------------------------
-- 9. VIEW EXAMPLES
---------------------------------------------------------------
CREATE VIEW StudentDepartment AS
SELECT S.RollNo, S.Name, D.DeptName
FROM Student S
JOIN Department D ON S.DeptID = D.DeptID;

SELECT * FROM StudentDepartment;

DROP VIEW IF EXISTS StudentDepartment;

---------------------------------------------------------------
-- 10. INDEX EXAMPLES
---------------------------------------------------------------
CREATE INDEX idx_marks ON Student(Marks);
DROP INDEX idx_marks ON Student;

---------------------------------------------------------------
-- 11. TRANSACTION EXAMPLES
---------------------------------------------------------------
START TRANSACTION;

UPDATE Marks
SET Internal = Internal + 2
WHERE CourseID = 301 AND RollNo = 101;

UPDATE Student
SET Marks = Marks + 2
WHERE RollNo = 101;

COMMIT;

-- ROLLBACK Example
START TRANSACTION;
UPDATE Student SET Marks = 10 WHERE RollNo = 102;
ROLLBACK;

---------------------------------------------------------------
-- 12. ADVANCED FUNCTIONS & EXPRESSIONS
---------------------------------------------------------------
SELECT Name, 
       CASE 
            WHEN Marks >= 90 THEN 'A'
            WHEN Marks >= 75 THEN 'B'
            WHEN Marks >= 60 THEN 'C'
            ELSE 'D'
       END AS Grade
FROM Student;

SELECT DeptID, 
       SUM(Marks) AS TotalMarks,
       ROUND(AVG(Marks), 2) AS AvgMarks
FROM Student
GROUP BY DeptID;

---------------------------------------------------------------
-- 13. DATE & TIME QUERIES
---------------------------------------------------------------
SELECT Name, DOB, YEAR(CURDATE()) - YEAR(DOB) AS Age
FROM Student;

SELECT * FROM Attendance WHERE DateHeld BETWEEN '2025-01-21' AND '2025-01-30';

---------------------------------------------------------------
-- 14. PRACTICE QUERIES (CHALLENGE SET)
---------------------------------------------------------------
-- 1. List top 3 scoring students.
SELECT Name, Marks 
FROM Student 
ORDER BY Marks DESC 
LIMIT 3;

-- 2. Students who share the same department as 'Arun Kumar'
SELECT Name
FROM Student
WHERE DeptID = (
    SELECT DeptID FROM Student WHERE Name = 'Arun Kumar'
);

-- 3. Highest total marks per department.
SELECT DeptID, MAX(Marks) 
FROM Student
GROUP BY DeptID;

-- 4. Courses with no students registered.
SELECT C.Title
FROM Course C
LEFT JOIN Registration R ON C.CourseID = R.CourseID
WHERE R.CourseID IS NULL;

-- 5. Students with > 80% attendance in any course.
SELECT RollNo, CourseID,
       (SUM(CASE WHEN Status = 'Present' THEN 1 ELSE 0 END) * 100.0) /
       COUNT(*) AS AttendancePercentage
FROM Attendance
GROUP BY RollNo, CourseID
HAVING AttendancePercentage > 80;

-- 6. Find students with above-department-average marks.
SELECT Name, Marks
FROM Student S
WHERE Marks > (
    SELECT AVG(Marks)
    FROM Student
    WHERE DeptID = S.DeptID
);

-- 7. Students enrolled in all courses of their department (Division Query Logic)
SELECT S.RollNo
FROM Student S
WHERE NOT EXISTS (
    SELECT CourseID 
    FROM Course C
    WHERE C.DeptID = S.DeptID
    EXCEPT
    SELECT CourseID 
    FROM Registration R 
    WHERE R.RollNo = S.RollNo
);

---------------------------------------------------------------
-- END OF FILE
---------------------------------------------------------------
