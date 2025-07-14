USE EducateDB
GO


-- Drop view if exists
IF OBJECT_ID('V_Class_Details', 'V') IS NOT NULL DROP VIEW V_Class_Details;
IF OBJECT_ID('V_Student_Grades', 'V') IS NOT NULL DROP VIEW V_Student_Grades;
IF OBJECT_ID('V_Course_Summary', 'V') IS NOT NULL DROP VIEW V_Course_Summary;
IF OBJECT_ID('V_Teacher_Workload', 'V') IS NOT NULL DROP VIEW V_Teacher_Workload;

-- 4. Creating views
GO

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
LEFT JOIN Teacher t ON cl.teacher_id = t.id;
GO

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
JOIN Exam e ON g.exam_id = e.id;
GO

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
GROUP BY c.id, c.description, c.tuition_fee;
GO

CREATE VIEW V_Teacher_Workload AS
SELECT
    t.id AS TeacherID,
    t.last_name + N' ' + t.first_name AS TeacherFullName,
    ISNULL(COUNT(DISTINCT cl.id), 0) AS AssignedClasses,
    ISNULL(COUNT(DISTINCT cl.course_id), 0) AS DistinctCoursesTaught
FROM Teacher t
LEFT JOIN Class cl ON t.id = cl.teacher_id
GROUP BY t.id, t.first_name, t.last_name;
GO
