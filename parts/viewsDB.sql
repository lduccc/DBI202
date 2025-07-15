USE EducateDB
GO

-- Drop views if exists
IF OBJECT_ID('V_Class_Details', 'V') IS NOT NULL DROP VIEW V_Class_Details
IF OBJECT_ID('V_Student_Grades', 'V') IS NOT NULL DROP VIEW V_Student_Grades
IF OBJECT_ID('V_Course_Summary', 'V') IS NOT NULL DROP VIEW V_Course_Summary
IF OBJECT_ID('V_Teacher_Workload', 'V') IS NOT NULL DROP VIEW V_Teacher_Workload
IF OBJECT_ID('V_StudentClassStats', 'V') IS NOT NULL DROP VIEW V_StudentClassStats
IF OBJECT_ID('V_Student_Enrollments', 'V') IS NOT NULL DROP VIEW V_Student_Enrollments
IF OBJECT_ID('V_Payment_History', 'V') IS NOT NULL DROP VIEW V_Payment_History
GO

--Provides a detailed overview of each class, including course name, schedule, and teacher's full name
CREATE VIEW V_Class_Details AS
SELECT
    cl.id AS ClassID,
    cl.schedule_info AS Schedule,
    cl.room_number AS Room,
    co.id AS CourseID,
    co.description AS CourseDescription,
    t.last_name + N' ' + t.first_name AS TeacherFullName
FROM Class cl
JOIN Course co ON cl.course_id = co.id
LEFT JOIN Teacher t ON cl.teacher_id = t.id
GO

--Testcase:
--SELECT * FROM V_Class_Details

--Lists all grades for every student
CREATE VIEW V_Student_Grades AS
SELECT
    s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS StudentFullName,
    e.description AS ExamDescription,
    e.exam_type AS ExamType,
    e.date AS ExamDate,
    g.value AS GradeValue
FROM Grade g
JOIN Student s ON g.student_id = s.id
JOIN Exam e ON g.exam_id = e.id
GO

--Testcase:
--SELECT * FROM V_Student_Grades

--Generates a summary for each course, showing tuition fee, number of classes, and total student enrollments.
CREATE VIEW V_Course_Summary AS
SELECT
    c.id AS CourseID,
    c.description AS CourseDescription,
    c.tuition_fee AS TuitionFee,
    COUNT(DISTINCT cl.id) AS NumberOfClasses,
    COUNT(DISTINCT cs.student_id) AS TotalEnrollments
FROM Course c
LEFT JOIN Class cl ON c.id = cl.course_id
LEFT JOIN Class_Student cs ON cl.id = cs.class_id
GROUP BY c.id, c.description, c.tuition_fee
GO

--Testcase:
--SELECT * FROM V_Course_Summary

--Summarizes the workload for each teacher,including the count of assigned classes and courses taught.
CREATE VIEW V_Teacher_Workload AS
SELECT
    t.id AS TeacherID,
    t.last_name + N' ' + t.first_name AS TeacherFullName,
    ISNULL(COUNT(DISTINCT cl.id), 0) AS AssignedClasses,
    ISNULL(COUNT(DISTINCT cl.course_id), 0) AS DistinctCoursesTaught
FROM Teacher t
LEFT JOIN Class cl ON t.id = cl.teacher_id
GROUP BY t.id, t.first_name, t.last_name
GO

--Testcase:
--SELECT * FROM V_Teacher_Workload

-- Calculates statistics for each student, including their total class count and overall average grade.
CREATE VIEW V_StudentClassStats AS
SELECT s.id, s.first_name + ' ' + s.last_name AS full_name,
	COUNT(DISTINCT cs.class_id) AS class_count,
	AVG(g.value) AS avg_grade
FROM Student s
LEFT JOIN Class_Student cs ON s.id = cs.student_id
LEFT JOIN Grade g ON s.id = g.student_id
GROUP BY s.id, s.first_name, s.last_name
GO

--Testcase:
--SELECT * FROM V_StudentClassStats


-- Displays a comprehensive list of all student enrollments, showing which student is in which class and course.
CREATE VIEW V_Student_Enrollments AS
SELECT
    s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS StudentFullName,
    co.description AS Course,
    cl.schedule_info AS Schedule,
    cl.room_number AS Room
FROM Class_Student cs
JOIN Student s ON cs.student_id = s.id
JOIN Class cl ON cs.class_id = cl.id
JOIN Course co ON cl.course_id = co.id;
GO

--Testcase:
--SELECT * FROM V_Student_Enrollments

--Make a view of all payments made, and the student who made it.
CREATE VIEW V_Payment_History AS
SELECT
    p.id AS PaymentID,
    s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS StudentFullName,
    p.amount AS AmountPaid,
    p.payment_date AS PaymentDate
FROM Payment p
JOIN Student s ON p.student_id = s.id
GO

--Testcase:
--SELECT * FROM V_Payment_History
