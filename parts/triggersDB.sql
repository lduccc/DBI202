USE EducateDB
GO

-- Drop triggers if they exist
IF OBJECT_ID('trg_UpdateCourseLastModified', 'TR') IS NOT NULL DROP TRIGGER trg_UpdateCourseLastModified
IF OBJECT_ID('trg_LogStudentCreation', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentCreation
IF OBJECT_ID('trg_LogStudentUpdate', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentUpdate
IF OBJECT_ID('trg_LogStudentDeletion', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentDeletion
IF OBJECT_ID('trg_PreventDuplicateEnrollment', 'TR') IS NOT NULL DROP TRIGGER trg_PreventDuplicateEnrollment
IF OBJECT_ID('trg_SetInitialStudentBalance', 'TR') IS NOT NULL DROP TRIGGER trg_SetInitialStudentBalance
IF OBJECT_ID('trg_DeleteExamsOnClassDelete', 'TR') IS NOT NULL DROP TRIGGER trg_DeleteExamsOnClassDelete
GO

IF OBJECT_ID('AuditLog', 'U') IS NOT NULL DROP TABLE AuditLog
GO

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(128) NOT NULL,
    RecordID VARCHAR(50) NOT NULL,
    ActionType NVARCHAR(50) NOT NULL,
    ChangeDetails NVARCHAR(MAX),
    ChangedBy NVARCHAR(128) DEFAULT SUSER_SNAME(),
    ChangedAt DATETIME2 DEFAULT GETDATE()
)
GO
--SELECT * FROM AuditLog

-- Updates the 'last_modified' timestamp on a Course when its material is updated.
CREATE TRIGGER trg_UpdateCourseLastModified 
ON Course_Material
AFTER UPDATE
AS
BEGIN
    UPDATE Course SET last_modified = GETDATE()
    WHERE id IN (SELECT course_id FROM inserted)
END
GO
-- Test Case:
-- UPDATE Course_Material SET description = 'Updated Description' WHERE id = 'CM001'
-- SELECT id, last_modified FROM Course WHERE id = (SELECT course_id FROM Course_Material WHERE id = 'CM001')


-- Logs the creation of a new student record into the AuditLog.
CREATE TRIGGER trg_LogStudentCreation 
ON Student
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails, ChangedBy)
    SELECT 'Student', i.id, 'INSERT', 'A new student was created: ' + i.last_name + N' ' + i.first_name, SUSER_SNAME()
    FROM inserted i
END
GO
-- Test Case:
-- INSERT INTO Student (id, first_name, last_name, email, user_name, password) VALUES ('ST999', 'Test', 'User', 'test.user@email.com', 'testuser999', 'password')
-- SELECT * FROM AuditLog WHERE RecordID = 'ST999'
-- DELETE FROM Student WHERE id = 'ST999'


-- Logs student update into the AuditLog.
CREATE TRIGGER trg_LogStudentUpdate 
ON Student
AFTER UPDATE
AS
BEGIN
    DECLARE @details NVARCHAR(MAX) = N''

    IF UPDATE(email)
        SELECT @details = @details + 'Email changed from "' + d.email + '" to "' + i.email + '". '
        FROM inserted i JOIN deleted d ON i.id = d.id
    IF UPDATE(phone)
        SELECT @details = @details + 'Phone changed from "' + ISNULL(d.phone, 'NULL') + '" to "' + ISNULL(i.phone, 'NULL') + '". '
        FROM inserted i JOIN deleted d ON i.id = d.id

    IF @details <> ''
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails, ChangedBy)
        SELECT 'Student', id, 'UPDATE', @details, SUSER_SNAME()
        FROM inserted
    END
END
GO
-- Test Case:
-- UPDATE Student SET phone = '0999999999' WHERE id = 'ST001'
-- SELECT * FROM AuditLog WHERE RecordID = 'ST001' AND ActionType = 'UPDATE'


-- Logs the deletion of a student record into the AuditLog.
CREATE TRIGGER trg_LogStudentDeletion 
ON Student
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails, ChangedBy)
    SELECT 'Student', d.id, 'DELETE', 'Student record deleted. Name: ' + d.last_name + N' ' + d.first_name + N', Email: ' + d.email, SUSER_SNAME()
    FROM deleted d
END
GO
-- Test Case 
-- INSERT INTO Student (id, first_name, last_name, email, user_name, password) VALUES ('ST998', 'ToDelete', 'User', 'todelete.user@email.com', 'todelete998', 'password')
-- DELETE FROM Student WHERE id = 'ST998'
-- SELECT * FROM AuditLog WHERE RecordID = 'ST998'


-- Prevents a student from being enrolled into the same class more than once.
CREATE TRIGGER trg_PreventDuplicateEnrollment 
ON Class_Student
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS (
        SELECT 1 
        FROM Class_Student cs
        JOIN inserted i ON cs.student_id = i.student_id AND cs.class_id = i.class_id
    )
    BEGIN
        DECLARE @student_id_dup VARCHAR(5), @class_id_dup NVARCHAR(20)
        SELECT TOP 1 @student_id_dup = student_id, @class_id_dup = class_id FROM inserted
        PRINT N'Action Canceled: Student ' + @student_id_dup + N' is already enrolled in class ' + @class_id_dup + N'.'
        RETURN
    END
    ELSE
    BEGIN
        INSERT INTO Class_Student (class_id, student_id, enrollment_date)
        SELECT class_id, student_id, enrollment_date FROM inserted
    END
END
GO 
-- Test Case:
-- -- This will fail because ST001 is already in this class from the data script.
-- INSERT INTO Class_Student (class_id, student_id, enrollment_date) VALUES ('IELTS70-2401A', 'ST001', GETDATE())
-- -- This should succeed (assuming ST002 is not in this class).
-- INSERT INTO Class_Student (class_id, student_id, enrollment_date) VALUES ('IELTS70-2401A', 'ST002', GETDATE())


-- Automatically sets a new student's balance to 0 if it is NULL.
CREATE TRIGGER trg_SetInitialStudentBalance
ON Student
AFTER INSERT
AS
BEGIN
    UPDATE Student
    SET balance = 0
    WHERE id IN (SELECT id FROM inserted) AND balance IS NULL
END
GO
-- Test Case:
-- -- Insert a student without a balance specified (it will be NULL by default).
-- INSERT INTO Student (id, first_name, last_name, email, user_name, password) VALUES ('ST997', 'NoBalance', 'User', 'nobalance.user@email.com', 'nobalance997', 'password')
-- -- Check if the balance was set to 0.
-- SELECT id, balance FROM Student WHERE id = 'ST997'
-- DELETE FROM Student WHERE id = 'ST997'


-- Deletes related exams and grades when a class is deleted.
CREATE TRIGGER trg_DeleteExamsOnClassDelete
ON Class
INSTEAD OF DELETE
AS
BEGIN
    DELETE Grade
    FROM Grade g
    JOIN deleted d ON g.class_id = d.id

    DELETE Exam
    FROM Exam e
    JOIN deleted d ON e.class_id = d.id

	DELETE Class_Student
    FROM Class_Student cs
    JOIN deleted d ON cs.class_id = d.id

	DELETE Class
    FROM Class c
    JOIN deleted d ON c.id = d.id
END
GO
-- Test Case

-- -- First, see what exists for a test class
-- SELECT * FROM Class_Student WHERE class_id = 'GEA1-2401'
-- SELECT * FROM Exam WHERE class_id = 'GEA1-2401'
-- SELECT * FROM Grade WHERE class_id = 'GEA1-2401'
-- -- Then, delete the class

-- -- DELETE FROM Class WHERE id = 'GEA1-2401'
-- -- Verify that all related data is also gone
-- -- SELECT * FROM Class_Student WHERE class_id = 'GEA1-2401'
-- -- SELECT * FROM Exam WHERE class_id = 'GEA1-2401'
-- -- SELECT * FROM Grade WHERE class_id = 'GEA1-2401'
