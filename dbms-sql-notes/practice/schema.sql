---

# **schema.sql**

```sql
-- ============================================================
-- DATABASE SCHEMA : CollegeDB (Core DBMS + SQL Practice Schema)
-- ============================================================

-- Drop existing tables (for clean re-runs)
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Registration;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;

-- ======================
-- 1. DEPARTMENT TABLE
-- ======================
CREATE TABLE Department (
    DeptID      INT PRIMARY KEY,
    DeptName    VARCHAR(100) NOT NULL UNIQUE,
    Location    VARCHAR(50) NOT NULL,
    Strength    INT DEFAULT 0 CHECK (Strength >= 0)
);

-- ======================
-- 2. STUDENT TABLE
-- ======================
CREATE TABLE Student (
    RollNo      INT PRIMARY KEY,
    Name        VARCHAR(50) NOT NULL,
    DeptID      INT NOT NULL,
    Semester    INT CHECK (Semester BETWEEN 1 AND 8),
    DOB         DATE,
    Email       VARCHAR(100) UNIQUE,
    Marks       INT DEFAULT NULL CHECK (Marks BETWEEN 0 AND 100),
    
    CONSTRAINT fk_student_dept 
        FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Useful index for join queries
CREATE INDEX idx_student_dept ON Student(DeptID);

-- ======================
-- 3. FACULTY TABLE
-- ======================
CREATE TABLE Faculty (
    FacultyID   INT PRIMARY KEY,
    Name        VARCHAR(50) NOT NULL,
    DeptID      INT NOT NULL,
    Email       VARCHAR(100) UNIQUE,
    
    CONSTRAINT fk_faculty_dept
        FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- ======================
-- 4. COURSE TABLE
-- ======================
CREATE TABLE Course (
    CourseID    INT PRIMARY KEY,
    Title       VARCHAR(100) NOT NULL,
    DeptID      INT NOT NULL,
    Credits     INT NOT NULL CHECK (Credits BETWEEN 1 AND 6),
    
    CONSTRAINT fk_course_dept
        FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- ================================
-- 5. REGISTRATION TABLE (M:N)
-- ================================
CREATE TABLE Registration (
    RollNo      INT,
    CourseID    INT,
    Semester    INT NOT NULL,
    RegisteredOn DATE DEFAULT CURRENT_DATE,
    
    PRIMARY KEY (RollNo, CourseID),
    
    CONSTRAINT fk_reg_student 
        FOREIGN KEY (RollNo) REFERENCES Student(RollNo)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_reg_course
        FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
        ON DELETE CASCADE
);

CREATE INDEX idx_reg_sem ON Registration(Semester);

-- ======================
-- 6. MARKS TABLE
-- ======================
CREATE TABLE Marks (
    RollNo      INT,
    CourseID    INT,
    Internal    INT CHECK (Internal BETWEEN 0 AND 50),
    External    INT CHECK (External BETWEEN 0 AND 50),
    Total       INT GENERATED ALWAYS AS (Internal + External) STORED,
    
    PRIMARY KEY (RollNo, CourseID),
    
    FOREIGN KEY (RollNo) REFERENCES Student(RollNo),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- ======================
-- 7. ATTENDANCE TABLE
-- ======================
CREATE TABLE Attendance (
    RollNo      INT,
    CourseID    INT,
    DateHeld    DATE NOT NULL,
    Status      ENUM('Present','Absent') NOT NULL,
    
    PRIMARY KEY (RollNo, CourseID, DateHeld),
    
    FOREIGN KEY (RollNo) REFERENCES Student(RollNo),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- ============================================================
-- SAMPLE DATA (Optional – for practice)
-- ============================================================

INSERT INTO Department VALUES
(1, 'Computer Science', 'Block A', 120),
(2, 'Electrical Engineering', 'Block B', 90),
(3, 'Mechanical Engineering', 'Block C', 110);

INSERT INTO Student (RollNo, Name, DeptID, Semester, DOB, Email, Marks) VALUES
(101, 'Arun Kumar', 1, 5, '2003-08-17', 'arun@college.com', 85),
(102, 'Meera', 1, 3, '2004-03-11', 'meera@college.com', 78),
(103, 'Rahul', 2, 5, '2003-10-07', 'rahul@college.com', 66);

INSERT INTO Faculty VALUES
(201, 'Dr. Lakshmi', 1, 'lakshmi@college.com'),
(202, 'Dr. Manoj', 2, 'manoj@college.com');

INSERT INTO Course VALUES
(301, 'DBMS', 1, 4),
(302, 'OOP', 1, 3),
(303, 'Circuits', 2, 4);

INSERT INTO Registration VALUES
(101, 301, 5, '2025-01-05'),
(101, 302, 5, '2025-01-05'),
(102, 301, 3, '2025-01-05'),
(103, 303, 5, '2025-01-05');

INSERT INTO Marks (RollNo, CourseID, Internal, External) VALUES
(101, 301, 40, 45),
(101, 302, 35, 37),
(102, 301, 38, 32);

INSERT INTO Attendance VALUES
(101, 301, '2025-01-21', 'Present'),
(101, 301, '2025-01-22', 'Absent'),
(102, 301, '2025-01-21', 'Present');
```

---

