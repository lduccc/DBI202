USE EducateDB
GO

--  Find students who have paid but have not yet been assigned to a class for that course.
SELECT s.id AS StudentID,
	   dbo.fn_GetStudentFullName(s.id) AS StudentFullName,
	   p.course_id AS Unenrolled_Paid_Course
FROM Payment p
JOIN Student s ON p.student_id = s.id
WHERE p.status = 'Success' 
AND NOT EXISTS (
        SELECT 1 FROM Class_Student cs 
        JOIN Class cl ON cs.class_id = cl.id
        WHERE cs.student_id = p.student_id AND cl.course_id = p.course_id
    )
GO

--Report on the academic performance of students in the 'IELTS_70' course.
WITH StudentGradesInCourse AS (
    SELECT cs.student_id, g.value
    FROM Class_Student cs
    JOIN Class cl ON cs.class_id = cl.id
    JOIN Exam e ON cl.id = e.class_id
    JOIN Grade g ON e.id = g.exam_id AND cs.student_id = g.student_id
    WHERE cl.course_id = N'IELTS_70'
)

SELECT s.last_name + N' ' + s.first_name AS StudentFullName,
    AVG(sg.value) AS AverageScore, 
    MAX(sg.value) AS HighestScore, 
    MIN(sg.value) AS LowestScore
FROM StudentGradesInCourse sg
JOIN Student s ON sg.student_id = s.id
GROUP BY s.id, s.first_name, s.last_name
ORDER BY AverageScore DESC
GO

--Find pairs of classes that are taught by the same teacher.
SELECT t.last_name + N' ' + t.first_name AS TeacherFullName,
    c1.id AS ClassID_1,
    c2.id AS ClassID_2
FROM Class c1
JOIN Class c2 ON c1.teacher_id = c2.teacher_id
JOIN Teacher t ON c1.teacher_id = t.id
WHERE c1.id < c2.id AND c1.teacher_id IS NOT NULL;
GO

-- Get the top 2 classes with the highest and lowest average grades.
WITH Average AS (
    SELECT cl.id AS ClassID, 
        co.description AS CourseDescription, 
        t.last_name + N' ' + t.first_name AS TeacherFullName,
        AVG(g.value) AS AverageGrade FROM Grade g
    JOIN Exam e ON g.exam_id = e.id 
    JOIN Class cl ON e.class_id = cl.id
    JOIN Course co ON cl.course_id = co.id 
    LEFT JOIN Teacher t ON cl.teacher_id = t.id
    GROUP BY cl.id, co.description, t.last_name, t.first_name
), Highest AS ( SELECT TOP 2 * FROM Average ORDER BY AverageGrade DESC)
,Lowest AS (SELECT TOP 2 * FROM Average ORDER BY AverageGrade ASC)

SELECT * FROM Highest UNION ALL SELECT * FROM Lowest ORDER BY AverageGrade
GO

-- Calculate the total classes taught, total students taught, and average grade given by each teacher.
SELECT t.id AS TeacherID,
    t.last_name + N' ' + t.first_name AS TeacherName,
    COUNT(DISTINCT c.id) AS TotalClasses,
    COUNT(DISTINCT cs.student_id) AS TotalStudents,
    AVG(g.value) AS AvgGradeGiven
FROM Teacher t
LEFT JOIN Class c ON t.id = c.teacher_id
LEFT JOIN Class_Student cs ON c.id = cs.class_id
LEFT JOIN Grade g ON cs.student_id = g.student_id AND cs.class_id = g.class_id
GROUP BY t.id, t.last_name, t.first_name
GO

-- Find students who scored higher than the class average for a specific exam.
SELECT g.student_id,
    s.last_name + N' ' + s.first_name AS FullName,
    g.exam_id,
    g.value AS StudentGrade,
    AVG(g2.value) AS ClassAvg
FROM Grade g
JOIN Student s ON g.student_id = s.id
JOIN Grade g2 ON g.class_id = g2.class_id AND g.exam_id = g2.exam_id
GROUP BY g.student_id, s.last_name, s.first_name, g.exam_id, g.value
HAVING g.value > AVG(g2.value)
GO

-- Find students who have taken 3 or more exams and have an average score greater than 7.
SELECT s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS FullName,
    COUNT(g.id) AS ExamCount,
    AVG(g.value) AS AvgScore
FROM Student s
JOIN Grade g ON s.id = g.student_id
GROUP BY s.id, s.last_name, s.first_name
HAVING COUNT(g.id) >= 3 AND AVG(g.value) > 7
GO

--Find courses with a tuition fee higher than the system average and more than 5 enrollments.
SELECT c.id AS CourseID,
    c.description,
    c.tuition_fee,
    COUNT(DISTINCT cs.student_id) AS TotalEnrollments
FROM Course c
JOIN Class cl ON c.id = cl.course_id
JOIN Class_Student cs ON cl.id = cs.class_id
GROUP BY c.id, c.description, c.tuition_fee
HAVING c.tuition_fee > (SELECT AVG(tuition_fee) FROM Course)
   AND COUNT(DISTINCT cs.student_id) > 5
GO

/* Bonus queries based on views/ functions */

-- Find teachers who only teach one type of course.
WITH TeacherCourseCounts AS (
    SELECT t.id AS TeacherID,
        t.last_name + N' ' + t.first_name AS TeacherName,
        (SELECT COUNT(DISTINCT cl.course_id) 
         FROM Class cl 
         WHERE cl.teacher_id = t.id) AS DistinctCourseCount
    FROM Teacher t
)
SELECT tcc.TeacherName, MIN(c.description) AS SoleCourseTaught 
FROM TeacherCourseCounts tcc
JOIN Class cl ON tcc.TeacherID = cl.teacher_id
JOIN Course c ON cl.course_id = c.id
WHERE tcc.DistinctCourseCount = 1 
GROUP BY tcc.TeacherName
GO


-- Find students enrolled in 3 or more classes whose 
-- overall average grade is below the average grade of all students in the system.
WITH StudentPerformance AS (
    SELECT s.id AS StudentID,
        dbo.fn_GetStudentFullName(s.id) AS StudentName,
        COUNT(DISTINCT cs.class_id) AS EnrolledClasses,
        AVG(g.value) AS AverageGrade
    FROM Student s
    LEFT JOIN  Class_Student cs ON s.id = cs.student_id
    LEFT JOIN  Grade g ON s.id = g.student_id
    GROUP BY  s.id, s.last_name, s.first_name
)
SELECT
    sp.StudentID,
    sp.StudentName,
    sp.EnrolledClasses,
    ROUND(sp.AverageGrade, 2) AS StudentAverageGrade,
    ROUND((SELECT AVG(value) FROM Grade), 2) AS SystemAverageGrade
FROM StudentPerformance sp
WHERE sp.EnrolledClasses >= 2 AND sp.AverageGrade < (SELECT AVG(value) FROM Grade) 
ORDER BY sp.AverageGrade 
GO



-- Find how much total tuition fee revenue each teacher is responsible for
-- based on the number of students in their classes and the fee for each course.

WITH TeacherRevenueData AS (
    SELECT t.id AS TeacherID,
        t.last_name + N' ' + t.first_name AS TeacherName,
        co.tuition_fee
    FROM Teacher t
    JOIN Class cl ON t.id = cl.teacher_id
    JOIN Class_Student cs ON cl.id = cs.class_id
    JOIN Course co ON cl.course_id = co.id
)

SELECT
    trd.TeacherName,
    SUM(trd.tuition_fee) AS TotalPotentialRevenue,
    COUNT(*) AS TotalStudentSeatsTaught
FROM TeacherRevenueData trd
GROUP BY trd.TeacherName
ORDER BY TotalPotentialRevenue DESC
GO
