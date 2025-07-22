USE EducateDB
GO

-- Drop views if they exist
IF OBJECT_ID('V_Class_Details', 'V') IS NOT NULL DROP VIEW V_Class_Details
IF OBJECT_ID('V_Student_Grades', 'V') IS NOT NULL DROP VIEW V_Student_Grades
IF OBJECT_ID('V_Course_Summary', 'V') IS NOT NULL DROP VIEW V_Course_Summary
IF OBJECT_ID('V_Teacher_Workload', 'V') IS NOT NULL DROP VIEW V_Teacher_Workload
IF OBJECT_ID('V_StudentClassStats', 'V') IS NOT NULL DROP VIEW V_StudentClassStats
IF OBJECT_ID('V_Student_Enrollments', 'V') IS NOT NULL DROP VIEW V_Student_Enrollments
IF OBJECT_ID('V_Payment_History', 'V') IS NOT NULL DROP VIEW V_Payment_History
IF OBJECT_ID('V_StudentContactInfo', 'V') IS NOT NULL DROP VIEW V_StudentContactInfo
IF OBJECT_ID('V_LatestExamResults', 'V') IS NOT NULL DROP VIEW  V_LatestExamResults

GO



CREATE VIEW V_StudentContactInfo
AS
SELECT
    id AS StudentID,
    last_name + ' ' + first_name AS FullName,
    date_birth AS DateOfBirth,
    gender AS Gender,
    email AS EmailAddress,
    phone AS PhoneNumber,
    address AS HomeAddress,
    city AS City
FROM
    Student;
GO

--SELECT * FROM V_StudentContactInfo;
-- SELECT * FROM V_StudentContactInfo WHERE FullName LIKE N'Nguyễn%';


-- Provides a detailed overview of each class, including course name, schedule, teacher, and its specific tuition fee.
CREATE VIEW V_Class_Details AS
SELECT
    cl.id AS ClassID,
    cl.schedule_info AS Schedule,
    cl.room_number AS Room,
    co.id AS CourseID,
    co.description AS CourseDescription,
    t.last_name + N' ' + t.first_name AS TeacherFullName,
    cl.tuition_fee AS TuitionFee 
FROM Class cl
JOIN Course co ON cl.course_id = co.id
LEFT JOIN Teacher t ON cl.teacher_id = t.id
GO

--Testcase:
--SELECT * FROM V_Class_Details

-- Lists all exam results for every student.
CREATE VIEW V_Student_Grades AS
SELECT
    s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS StudentFullName,
    e.description AS ExamDescription,
    e.exam_type AS ExamType,
    e.date AS ExamDate,
    er.value AS GradeValue
FROM Exam_Result er
JOIN Student s ON er.student_id = s.id
JOIN Exam e ON er.exam_id = e.id
GO

--Testcase:
--SELECT * FROM V_Student_Grades

-- Generates a summary for each course, showing the range of tuition fees, number of classes, and total enrollments.
CREATE VIEW V_Course_Summary AS
SELECT
    c.id AS CourseID,
    c.description AS CourseDescription,
    MIN(cl.tuition_fee) AS MinTuitionFee,
    AVG(cl.tuition_fee) AS AvgTuitionFee, 
    MAX(cl.tuition_fee) AS MaxTuitionFee,
    COUNT(DISTINCT cl.id) AS NumberOfClasses,
    COUNT(DISTINCT cs.student_id) AS TotalEnrollments
FROM Course c
LEFT JOIN Class cl ON c.id = cl.course_id
LEFT JOIN Class_Student cs ON cl.id = cs.class_id
GROUP BY c.id, c.description
GO

--Testcase:
--SELECT * FROM V_Course_Summary

-- Summarizes the workload for each teacher, including the count of assigned classes and distinct courses taught.
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

-- Calculates statistics for each student, including their total class count and overall average grade from exam results.
CREATE VIEW V_StudentClassStats AS
SELECT 
    s.id, 
    s.first_name + ' ' + s.last_name AS full_name,
	COUNT(DISTINCT cs.class_id) AS class_count,
	AVG(er.value) AS avg_grade 
FROM Student s
LEFT JOIN Class_Student cs ON s.id = cs.student_id
LEFT JOIN Exam_Result er ON s.id = er.student_id
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
JOIN Course co ON cl.course_id = co.id
GO

--Testcase:
--SELECT * FROM V_Student_Enrollments

-- Creates a view of all payments made, showing the student who made the payment.
CREATE VIEW V_Payment_History AS
SELECT
    p.id AS PaymentID,
    s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS StudentFullName,
    p.amount AS AmountPaid,
    p.payment_date AS PaymentDate,
    p.status AS PaymentStatus
FROM Payment p
JOIN Student s ON p.student_id = s.id
GO

--Testcase:
--SELECT * FROM V_Payment_History

CREATE VIEW V_LatestExamResults
AS
SELECT
    S.id AS StudentID,
    S.first_name + ' ' + S.last_name AS StudentName,
    E.id AS ExamID,
    E.exam_type AS ExamType,
    E.description AS ExamDescription,
    ER.value AS Score,
    ER.date AS ResultDate,
    C.id AS ClassID,
    Co.description AS CourseName

FROM Exam_Result AS ER
JOIN Student AS S ON ER.student_id = S.id
JOIN Exam AS E ON ER.exam_id = E.id
JOIN Class AS C ON E.class_id = C.id
JOIN Course AS Co ON C.course_id = Co.id;
GO

--SELECT * FROM V_LatestExamResults;
-- SELECT * FROM V_LatestExamResults WHERE ExamID = 'EX001';

