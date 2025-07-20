USE EducateDB
GO

-- Find classes with the same teacher.
SELECT 
    t.last_name + N' ' + t.first_name AS TeacherFullName,
    c1.id AS ClassID_1,
    c2.id AS ClassID_2
FROM Class c1
JOIN Class c2 ON c1.teacher_id = c2.teacher_id AND c1.id < c2.id
JOIN Teacher t ON c1.teacher_id = t.id
WHERE c1.teacher_id IS NOT NULL
GO

--Reports student performance in a specific course ('IELTS_70').
WITH StudentGradesInCourse AS (
    SELECT 
        cs.student_id, 
        er.value
    FROM Class_Student cs
    JOIN Class cl ON cs.class_id = cl.id
    JOIN Exam e ON cl.id = e.class_id
    JOIN Exam_Result er ON e.id = er.exam_id AND cs.student_id = er.student_id
    WHERE cl.course_id = N'IELTS_70'
)
SELECT 
    s.last_name + N' ' + s.first_name AS StudentFullName,
    AVG(sg.value) AS AverageScore, 
    MAX(sg.value) AS HighestScore, 
    MIN(sg.value) AS LowestScore
FROM StudentGradesInCourse sg
JOIN Student s ON sg.student_id = s.id
GROUP BY s.id, s.first_name, s.last_name
ORDER BY AverageScore DESC
GO

-- Top 2 classes with the highest and lowest average grades.
WITH ClassAverages AS (
    SELECT 
        cl.id AS ClassID, 
        co.description AS CourseDescription, 
        t.last_name + N' ' + t.first_name AS TeacherFullName,
        AVG(er.value) AS AverageGrade 
    FROM Exam_Result er
    JOIN Exam e ON er.exam_id = e.id 
    JOIN Class cl ON e.class_id = cl.id
    JOIN Course co ON cl.course_id = co.id 
    LEFT JOIN Teacher t ON cl.teacher_id = t.id
    GROUP BY cl.id, co.description, t.last_name, t.first_name
), 
Highest AS (
    SELECT TOP 2 WITH TIES * FROM ClassAverages ORDER BY AverageGrade DESC
),
Lowest AS (
    SELECT TOP 2 WITH TIES * FROM ClassAverages ORDER BY AverageGrade ASC
)
SELECT * FROM Highest 
UNION ALL 
SELECT * FROM Lowest 
ORDER BY AverageGrade DESC
GO

-- Teacher performance summary
SELECT 
    t.id AS TeacherID,
    t.last_name + N' ' + t.first_name AS TeacherName,
    COUNT(DISTINCT c.id) AS TotalClasses,
    COUNT(DISTINCT cs.student_id) AS TotalStudentsTaught,
    AVG(er.value) AS AvgGradeGiven
FROM Teacher t
LEFT JOIN Class c ON t.id = c.teacher_id
LEFT JOIN Class_Student cs ON c.id = cs.class_id
LEFT JOIN Exam e ON c.id = e.class_id
LEFT JOIN Exam_Result er ON e.id = er.exam_id AND cs.student_id = er.student_id
GROUP BY t.id, t.last_name, t.first_name
ORDER BY AvgGradeGiven DESC
GO

-- Find students who scored above the class average
WITH ExamAverages AS (
    SELECT exam_id, AVG(value) as AvgGrade
    FROM Exam_Result
    GROUP BY exam_id
)
SELECT 
    s.last_name + N' ' + s.first_name AS FullName,
    er.exam_id,
    e.description AS ExamDescription,
    er.value AS StudentGrade,
    ea.AvgGrade AS ClassAverage
FROM Exam_Result er
JOIN Student s ON er.student_id = s.id
JOIN ExamAverages ea ON er.exam_id = ea.exam_id
JOIN Exam e ON er.exam_id = e.id
WHERE er.value > ea.AvgGrade
ORDER BY ClassAverage DESC, StudentGrade DESC
GO

--List high-performing and active students
SELECT 
    s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS FullName,
    COUNT(er.exam_id) AS ExamCount,
    AVG(er.value) AS AvgScore
FROM Student s
JOIN Exam_Result er ON s.id = er.student_id
GROUP BY s.id, s.last_name, s.first_name
HAVING COUNT(er.exam_id) >= 3 AND AVG(er.value) > 7
ORDER BY AvgScore DESC
GO

-- Teacher's star student report
WITH TeacherStudentPerformance AS (
    SELECT 
        c.teacher_id,
        cs.student_id,
        AVG(er.value) AS AvgGradeInTeacherClasses
    FROM Class c
    JOIN Class_Student cs ON c.id = cs.class_id
    JOIN Exam e ON c.id = e.class_id
    JOIN Exam_Result er ON e.id = er.exam_id AND cs.student_id = er.student_id
    WHERE c.teacher_id IS NOT NULL
    GROUP BY c.teacher_id, cs.student_id
),
RankedStudents AS (
    SELECT
        teacher_id,
        student_id,
        AvgGradeInTeacherClasses,
        RANK() OVER (PARTITION BY teacher_id ORDER BY AvgGradeInTeacherClasses DESC) as RankNum
    FROM TeacherStudentPerformance
)
SELECT 
    t.last_name + N' ' + t.first_name AS TeacherName,
    s.last_name + N' ' + s.first_name AS StarStudentName,
    rs.AvgGradeInTeacherClasses
FROM RankedStudents rs
JOIN Teacher t ON rs.teacher_id = t.id
JOIN Student s ON rs.student_id = s.id
WHERE rs.RankNum = 1
ORDER BY TeacherName
GO

-- Student loyalty and course path analysis
WITH StudentCourseHistory AS (
    SELECT 
        cs.student_id,
        c.course_id
    FROM Class_Student cs
    JOIN Class c ON cs.class_id = c.id
    GROUP BY cs.student_id, c.course_id
)
SELECT
    s.last_name + N' ' + s.first_name AS StudentName,
    COUNT(sch.course_id) AS DistinctCoursesTaken,
    STRING_AGG(sch.course_id, ', ') AS CoursePath
FROM StudentCourseHistory sch
JOIN Student s ON sch.student_id = s.id
GROUP BY s.id, s.last_name, s.first_name
HAVING COUNT(sch.course_id) > 1
ORDER BY DistinctCoursesTaken DESC, StudentName
GO

-- Course profitability ranking
SELECT 
    c.description AS CourseName,
    COUNT(DISTINCT p.student_id) AS NumberOfPayingStudents,
    SUM(p.amount) AS TotalRevenue,
    AVG(p.amount) AS AveragePayment,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS ProfitabilityRank
FROM Course c
JOIN Class cl ON c.id = cl.course_id
JOIN Payment p ON cl.id = p.class_id
WHERE p.status = 'Success'
GROUP BY c.description
ORDER BY ProfitabilityRank
GO

-- At-risk student identification
SELECT 
    s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS StudentName,
    cs.class_id AS EnrolledClassID,
    c.description AS CourseDescription
FROM Student s
JOIN Class_Student cs ON s.id = cs.student_id
JOIN Class cl ON cs.class_id = cl.id
JOIN Course c ON cl.course_id = c.id
WHERE NOT EXISTS (
    SELECT 1 
    FROM Exam e
    JOIN Exam_Result er ON e.id = er.exam_id
    WHERE e.class_id = cs.class_id AND er.student_id = s.id
)
ORDER BY s.id, cs.class_id
GO

-- Exam difficulty analysis
SELECT
    e.description AS ExamName,
    cl.id AS ClassID,
    e.exam_type AS ExamType,
    AVG(er.value) AS AverageScore,
    COUNT(er.student_id) AS Participants,
    MIN(er.value) AS LowestScore,
    MAX(er.value) AS HighestScore,
    RANK() OVER (ORDER BY AVG(er.value) ASC) as DifficultyRank -- 1 = Hardest
FROM Exam e
JOIN Exam_Result er ON e.id = er.exam_id
JOIN Class cl ON e.class_id = cl.id
GROUP BY e.id, e.description, cl.id, e.exam_type
HAVING COUNT(er.student_id) >= 3 -- Only consider exams with at least 3 participants
ORDER BY DifficultyRank
GO

-- Student academic journey & teacher influence
WITH StudentExamHistory AS (
    SELECT 
        er.student_id,
        er.value,
        cl.teacher_id,
        ROW_NUMBER() OVER(PARTITION BY er.student_id ORDER BY e.date ASC, e.id ASC) as FirstExamRank,
        ROW_NUMBER() OVER(PARTITION BY er.student_id ORDER BY e.date DESC, e.id DESC) as LastExamRank
    FROM Exam_Result er
    JOIN Exam e ON er.exam_id = e.id
    JOIN Class cl ON e.class_id = cl.id
),
StudentSummary AS (
    SELECT
        student_id,
        AVG(value) as AverageScore,
        COUNT(value) as TotalExams,
        MIN(CASE WHEN FirstExamRank = 1 THEN value END) as FirstScore,
        MIN(CASE WHEN LastExamRank = 1 THEN value END) as LastScore,
        MIN(CASE WHEN FirstExamRank = 1 THEN teacher_id END) as FirstTeacherID,
        MIN(CASE WHEN LastExamRank = 1 THEN teacher_id END) as LastTeacherID
    FROM StudentExamHistory
    GROUP BY student_id
)
SELECT 
    s.id AS StudentID,
    dbo.fn_GetStudentFullName(s.id) AS StudentName,
    ss.TotalExams,
    ss.FirstScore,
    ss.LastScore,
    (ss.LastScore - ss.FirstScore) AS ScoreImprovement,
    ss.AverageScore,
    ISNULL(ft.last_name + N' ' + ft.first_name, 'N/A') AS FirstTeacher,
    ISNULL(lt.last_name + N' ' + lt.first_name, 'N/A') AS LastTeacher,
    CASE 
        WHEN (ss.LastScore - ss.FirstScore) > 1.0 THEN 'Significant Improvement'
        WHEN (ss.LastScore - ss.FirstScore) > 0 THEN 'Improved'
        WHEN (ss.LastScore - ss.FirstScore) = 0 THEN 'Consistent'
        ELSE 'Declined'
    END AS PerformanceJourney
FROM StudentSummary ss
JOIN Student s ON ss.student_id = s.id
LEFT JOIN Teacher ft ON ss.FirstTeacherID = ft.id
LEFT JOIN Teacher lt ON ss.LastTeacherID = lt.id
WHERE ss.TotalExams > 1 
ORDER BY ScoreImprovement DESC, AverageScore DESC
GO