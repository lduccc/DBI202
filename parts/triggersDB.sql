USE EducateDB
GO


-- Drop if it exists
IF OBJECT_ID('trg_UpdateCourseLastModified', 'TR') IS NOT NULL DROP TRIGGER trg_UpdateCourseLastModified
IF OBJECT_ID('trg_PreventStudentDeletionWithBalance', 'TR') IS NOT NULL DROP TRIGGER trg_PreventStudentDeletionWithBalance
IF OBJECT_ID('trg_LogStudentCreation', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentCreation
IF OBJECT_ID('trg_LogStudentUpdate', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentUpdate
IF OBJECT_ID('trg_LogStudentDeletion', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentDeletion
IF OBJECT_ID('trg_PreventDuplicateEnrollment', 'TR') IS NOT NULL DROP TRIGGER trg_PreventDuplicateEnrollment

IF OBJECT_ID('AuditLog', 'U') IS NOT NULL DROP TABLE AuditLog;

GO

--Create table for logging triggers

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(128) NOT NULL,
    RecordID VARCHAR(50) NOT NULL,
    ActionType NVARCHAR(50) NOT NULL,
    ChangeDetails NVARCHAR(MAX),
    ChangedBy NVARCHAR(128) DEFAULT SUSER_SNAME(),
    ChangedAt DATETIME2 DEFAULT GETDATE()
);

--Create Triggers
CREATE TRIGGER trg_UpdateCourseLastModified ON Course_Material
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Course SET last_modified = GETDATE()
    WHERE id IN (SELECT course_id FROM inserted);
END
GO

CREATE TRIGGER trg_PreventStudentDeletionWithBalance ON Student
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StudentIDToDelete VARCHAR(5), @StudentBalance DECIMAL(12,2);
    SELECT @StudentIDToDelete = id, @StudentBalance = balance FROM deleted;

    IF @StudentBalance > 0
    BEGIN
        PRINT N'Hành động bị hủy: Không thể xóa sinh viên ' + @StudentIDToDelete + N' vì họ vẫn còn số dư trong tài khoản.';
        RETURN;
    END
    ELSE
    BEGIN
        DELETE FROM Student WHERE id = @StudentIDToDelete;
    END
END
GO

CREATE TRIGGER trg_LogStudentCreation ON Student
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails)
    SELECT 'Student', i.id, 'INSERT', 'A new student was created: ' + i.last_name + N' ' + i.first_name
    FROM inserted i;
END
GO

CREATE TRIGGER trg_LogStudentUpdate ON Student
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @details NVARCHAR(MAX) = N'';

    IF UPDATE(email)
        SELECT @details = @details + 'Email changed from "' + d.email + '" to "' + i.email + '". '
        FROM inserted i JOIN deleted d ON i.id = d.id;

    IF UPDATE(phone)
        SELECT @details = @details + 'Phone changed from "' + ISNULL(d.phone, 'NULL') + '" to "' + ISNULL(i.phone, 'NULL') + '". '
        FROM inserted i JOIN deleted d ON i.id = d.id;
    
    IF UPDATE(balance)
        SELECT @details = @details + 'Balance changed from ' + CAST(ISNULL(d.balance, 0) AS VARCHAR) + ' to ' + CAST(ISNULL(i.balance, 0) AS VARCHAR) + '. '
        FROM inserted i JOIN deleted d ON i.id = d.id;

    IF @details <> ''
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails)
        SELECT 'Student', id, 'UPDATE', @details
        FROM inserted;
    END
END
GO

CREATE TRIGGER trg_LogStudentDeletion ON Student
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails)
    SELECT 'Student', d.id, 'DELETE', 'Student record deleted. Name: ' + d.last_name + N' ' + d.first_name + N', Email: ' + d.email
    FROM deleted d;
END
GO

CREATE TRIGGER trg_PreventDuplicateEnrollment ON Class_Student
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @student_id VARCHAR(5), @class_id NVARCHAR(20);
    SELECT @student_id = student_id, @class_id = class_id FROM inserted;

    IF EXISTS (SELECT 1 FROM Class_Student WHERE student_id = @student_id AND class_id = @class_id)
    BEGIN
        PRINT N'Hành động bị hủy: Sinh viên ' + @student_id + N' đã được ghi danh vào lớp ' + @class_id + N' rồi.';
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO Class_Student (class_id, student_id, enrollment_date)
        SELECT class_id, student_id, enrollment_date FROM inserted;
        PRINT N'Ghi danh thành công: Sinh viên ' + @student_id + N' vào lớp ' + @class_id;
    END
END