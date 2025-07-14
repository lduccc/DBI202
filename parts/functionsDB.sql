USE EducateDB
GO

-- Drop function if exists
IF OBJECT_ID('dbo.fn_GetStudentFullName', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_GetStudentFullName;
IF OBJECT_ID('dbo.fn_CalculateStudentAge', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_CalculateStudentAge;
IF OBJECT_ID('dbo.fn_GetClassesByTeacher', 'IF') IS NOT NULL DROP FUNCTION dbo.fn_GetClassesByTeacher;

-- Creating functions
GO

CREATE FUNCTION dbo.fn_GetStudentFullName (@StudentID VARCHAR(5))
RETURNS NVARCHAR(101)
AS
BEGIN
    DECLARE @FullName NVARCHAR(101);
    SELECT @FullName = last_name + N' ' + first_name
    FROM Student
    WHERE id = @StudentID;
    RETURN @FullName;
END
GO

CREATE FUNCTION dbo.fn_CalculateStudentAge (@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DateOfBirth, GETDATE()) -
           CASE WHEN (MONTH(@DateOfBirth) > MONTH(GETDATE())) OR
		   (MONTH(@DateOfBirth) = MONTH(GETDATE()) AND
		   DAY(@DateOfBirth) > DAY(GETDATE())) THEN 1 ELSE 0 END;
END
GO

CREATE FUNCTION dbo.fn_GetClassesByTeacher (@TeacherID VARCHAR(5))
RETURNS TABLE
AS
RETURN
(
    SELECT
        cl.id AS ClassID,
        cl.schedule_info AS Schedule,
        co.description AS CourseDescription
    FROM Class cl
    JOIN Course co ON cl.course_id = co.id
    WHERE cl.teacher_id = @TeacherID
);
GO
