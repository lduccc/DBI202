USE EducateDB;
GO

-- Drop functions if they exist
IF OBJECT_ID('dbo.fn_GetStudentFullName', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_GetStudentFullName;
IF OBJECT_ID('dbo.fn_CalculateStudentAge', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_CalculateStudentAge;
IF OBJECT_ID('dbo.fn_GetClassesByTeacher', 'IF') IS NOT NULL DROP FUNCTION dbo.fn_GetClassesByTeacher;
IF OBJECT_ID('dbo.fn_CanPayCourseStatus', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_CanPayCourseStatus;
IF OBJECT_ID('dbo.fn_GetStudentClasses', 'IF') IS NOT NULL DROP FUNCTION dbo.fn_GetStudentClasses;
IF OBJECT_ID('dbo.fn_GetClassStudents', 'IF') IS NOT NULL DROP FUNCTION dbo.fn_GetClassStudents;
IF OBJECT_ID('dbo.fn_CourseAverageGrade', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_CourseAverageGrade;
IF OBJECT_ID('dbo.fn_IsStudentEnrolledCourse', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_IsStudentEnrolledCourse;
GO

-- Returns the full name of a student.
CREATE FUNCTION fn_GetStudentFullName (@StudentID VARCHAR(5))
RETURNS NVARCHAR(101)
AS
BEGIN
    DECLARE @FullName NVARCHAR(101)
    
    SELECT @FullName = last_name + N' ' + first_name
    FROM Student WHERE id = @StudentID
    
    RETURN @FullName
END
GO
-- Test Cases for fn_GetStudentFullName:
-- SELECT dbo.fn_GetStudentFullName('ST001') AS StudentName
-- SELECT dbo.fn_GetStudentFullName('ST005') AS StudentName


-- Calculates the current age of a person based on their date of birth.
CREATE FUNCTION fn_CalculateStudentAge(@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DateOfBirth, GETDATE()) -
           CASE WHEN (MONTH(@DateOfBirth) > MONTH(GETDATE())) OR
                    (MONTH(@DateOfBirth) = MONTH(GETDATE()) AND DAY(@DateOfBirth) > DAY(GETDATE())) 
           THEN 1 ELSE 0 END
END
GO
-- Test Cases for fn_CalculateStudentAge:
-- SELECT dbo.fn_CalculateStudentAge('2003-05-15') AS Age;
-- SELECT id, dbo.fn_CalculateStudentAge(date_birth) AS CurrentAge FROM Student WHERE id = 'ST020'


-- Returns a table of classes taught by a specific teacher.
CREATE FUNCTION fn_GetClassesByTeacher (@TeacherID VARCHAR(5))
RETURNS TABLE
AS
RETURN
(
    SELECT cl.id AS ClassID, cl.schedule_info AS Schedule, co.description AS CourseDescription
    FROM Class cl
    JOIN Course co ON cl.course_id = co.id
    WHERE cl.teacher_id = @TeacherID
)
GO
-- Test Cases for fn_GetClassesByTeacher:
-- SELECT * FROM dbo.fn_GetClassesByTeacher('TE001')
-- SELECT * FROM dbo.fn_GetClassesByTeacher('TE003')


-- Checks if a student can afford a course based on their balance.
CREATE FUNCTION fn_CanPayCourseStatus(@StudentID VARCHAR(5),@CourseID NVARCHAR(50))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @balance DECIMAL(12,2)
    DECLARE @fee DECIMAL(12,2)
    DECLARE @result NVARCHAR(20)

    SELECT @balance = balance FROM Student WHERE id = @StudentID
    SELECT @fee = tuition_fee FROM Course WHERE id = @CourseID

    IF @balance IS NULL OR @fee IS NULL
        SET @result = N'Not Affordable'
    ELSE IF @balance >= @fee
        SET @result = N'Affordable'
    ELSE
        SET @result = N'Not Affordable'

    RETURN @result
END
GO
-- Test Cases for fn_CanPayCourseStatus:
-- -- Test case where student can afford
-- SELECT dbo.fn_CanPayCourseStatus('ST001', 'IELTS_70') AS PaymentStatus;
-- -- Test case where student cannot afford
-- SELECT dbo.fn_CanPayCourseStatus('ST008', 'GMAT_PREP') AS PaymentStatus;


-- Returns a table of classes and course information for a given student.
CREATE FUNCTION fn_GetStudentClasses(@StudentID VARCHAR(5))
RETURNS TABLE
AS RETURN
(
    SELECT cs.class_id, c.course_id, c.schedule_info, c.room_number
    FROM Class_Student cs
    JOIN Class c ON cs.class_id = c.id
    WHERE cs.student_id = @StudentID
);
GO
-- Test Cases for fn_GetStudentClasses:
-- SELECT * FROM dbo.fn_GetStudentClasses('ST001');
-- SELECT * FROM dbo.fn_GetStudentClasses('ST013');


-- Returns a table listing all students enrolled in a specific class.
CREATE FUNCTION fn_GetClassStudents(@ClassID NVARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT s.id, s.first_name, s.last_name, cs.enrollment_date
    FROM Class_Student cs
    JOIN Student s ON cs.student_id = s.id
    WHERE cs.class_id = @ClassID
);
GO
-- Test Cases for fn_GetClassStudents:
-- SELECT * FROM dbo.fn_GetClassStudents('IELTS70-2401A');
-- SELECT * FROM dbo.fn_GetClassStudents('GEA1-2401');

-- Calculates the average grade for all students across all classes of a specific course.
CREATE FUNCTION fn_CourseAverageGrade(@CourseID NVARCHAR(50))
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @avg DECIMAL(5,2);

    SELECT @avg = AVG(g.value) FROM Grade g
    JOIN Class c ON g.class_id = c.id
    WHERE c.course_id = @CourseID;

    RETURN @avg;
END
GO
-- Test Cases for fn_CourseAverageGrade:
-- SELECT dbo.fn_CourseAverageGrade('GE_A1') AS AvgGradeForGE_A1;
-- SELECT dbo.fn_CourseAverageGrade('IELTS_70') AS AvgGradeForIELTS_70;

-- Checks if a student is enrolled in any class associated with a specific course.
CREATE FUNCTION fn_IsStudentEnrolledCourse(@StudentID VARCHAR(5), @CourseID NVARCHAR(50))
RETURNS NVARCHAR(3)
AS BEGIN
    DECLARE @result NVARCHAR(3);

    IF EXISTS (SELECT 1
        FROM Class_Student cs
        JOIN Class c ON cs.class_id = c.id
        WHERE cs.student_id = @StudentID AND c.course_id = @CourseID
    )
        SET @result = N'Yes'
    ELSE
        SET @result = N'No'

    RETURN @result
END
GO

-- Test Cases for fn_IsStudentEnrolledCourse:
-- -- Student ST001 is enrolled in SAT_PREP
-- SELECT dbo.fn_IsStudentEnrolledCourse('ST001', 'SAT_PREP') AS IsEnrolled;
-- -- Student ST001 is NOT enrolled in GMAT_PREP
-- SELECT dbo.fn_IsStudentEnrolledCourse('ST001', 'GMAT_PREP') AS IsEnrolled;
