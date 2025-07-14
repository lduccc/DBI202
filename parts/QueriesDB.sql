--Queries
USE EducateDB
GO


-- DEMONSTRATION QUERY 1: Tìm các trường hợp học viên đã thanh toán nhưng chưa được xếp lớp 
SELECT
    s.id AS StudentID,
    dbo.fn_GetStudentFullName(s.id) AS StudentFullName,
    p.course_id AS Unenrolled_Paid_Course
FROM Payment p
JOIN Student s ON p.student_id = s.id
WHERE p.status = 'Success' AND NOT EXISTS (
    SELECT 1 FROM Class_Student cs JOIN Class cl ON cs.class_id = cl.id
    WHERE cs.student_id = p.student_id AND cl.course_id = p.course_id
);
GO

-- DEMONSTRATION QUERY 2: Báo cáo hiệu suất học tập của học viên trong khóa học IELTS_70 
WITH StudentGradesInCourse AS (
    SELECT cs.student_id, g.value
    FROM Class_Student cs
    JOIN Class cl ON cs.class_id = cl.id
    JOIN Exam e ON cl.id = e.class_id
    JOIN Grade g ON e.id = g.exam_id AND cs.student_id = g.student_id
    WHERE cl.course_id = N'IELTS_70')
SELECT s.last_name + N' ' + s.first_name AS StudentFullName,
       AVG(sg.value) AS AverageScore, MAX(sg.value) AS HighestScore, MIN(sg.value) AS LowestScore
FROM StudentGradesInCourse sg
JOIN Student s ON sg.student_id = s.id
GROUP BY s.id, s.first_name, s.last_name
ORDER BY AverageScore DESC;
GO

-- Tìm các Lớp học có cùng Giáo viên
SELECT
    t.last_name + N' ' + t.first_name AS TeacherFullName,
    c1.id AS ClassID_1,
    c2.id AS ClassID_2
FROM Class c1
JOIN Class c2 ON c1.teacher_id = c2.teacher_id
JOIN Teacher t ON c1.teacher_id = t.id
WHERE c1.id < c2.id AND c1.teacher_id IS NOT NULL;
GO

-- Top 2 lớp học có điểm trung bình cao nhất và thấp nhất 

WITH Average AS (SELECT 
	cl.id AS ClassID, co.description AS CourseDescription, t.last_name + N' ' + t.first_name AS TeacherFullName,
    AVG(g.value) AS AverageGrade
 FROM Grade g
 JOIN Exam e ON g.exam_id = e.id JOIN Class cl ON e.class_id = cl.id
 JOIN Course co ON cl.course_id = co.id LEFT JOIN Teacher t ON cl.teacher_id = t.id
 GROUP BY cl.id, co.description, t.last_name, t.first_name)
, A AS (SELECT TOP 2 * FROM Average ORDER BY AverageGrade DESC)
, B AS (SELECT TOP 2 * FROM Average ORDER BY AverageGrade)

SELECT * FROM A UNION ALL SELECT * FROM B ORDER BY AverageGrade