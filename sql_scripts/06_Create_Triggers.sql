USE EducateDB
GO

IF OBJECT_ID('trg_UpdateCourseLastModified', 'TR') IS NOT NULL DROP TRIGGER trg_UpdateCourseLastModified
IF OBJECT_ID('trg_LogStudentCreation', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentCreation
IF OBJECT_ID('trg_LogStudentUpdate', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentUpdate
IF OBJECT_ID('trg_LogStudentDeletion', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentDeletion
IF OBJECT_ID('trg_SetInitialStudentBalance', 'TR') IS NOT NULL DROP TRIGGER trg_SetInitialStudentBalance
IF OBJECT_ID('trg_DeleteExamsOnClassDelete', 'TR') IS NOT NULL DROP TRIGGER trg_DeleteExamsOnClassDelete
IF OBJECT_ID('trg_HashStudentPassword', 'TR') IS NOT NULL DROP TRIGGER trg_HashStudentPassword
IF OBJECT_ID('trg_HashTeacherPassword', 'TR') IS NOT NULL DROP TRIGGER trg_HashTeacherPassword

IF OBJECT_ID('AuditLog', 'U') IS NOT NULL DROP TABLE AuditLog
GO

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(128) NOT NULL,
    RecordID VARCHAR(50) NOT NULL,
    ActionType NVARCHAR(50) NOT NULL,
    ChangeDetails NVARCHAR(MAX),
    ChangedAt DATETIME2 DEFAULT GETDATE()
)
GO


-- Trigger to intercept inserts, hash the password, and store it in the same column
CREATE TRIGGER trg_HashStudentPassword
ON Student
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Student (id, first_name, last_name, user_name, password, date_birth, gender, email, phone, address, city, balance, created_date)
    SELECT
        i.id, i.first_name, i.last_name, i.user_name,
        CONVERT(NVARCHAR(128), HASHBYTES('SHA2_512', i.password + i.user_name), 2),
        i.date_birth, i.gender, i.email, i.phone, i.address, i.city, i.balance, i.created_date
    FROM inserted i;
END
GO

/*
BEGIN TRANSACTION

INSERT INTO Student (id, first_name, last_name, email, user_name, password, balance, created_date) VALUES
('ST998', 'Multi', 'One', 'multi1@test.com', 'multitest1', 'samePassword', 2000.00, GETDATE()),
('ST997', 'Multi', 'Two', 'multi2@test.com', 'multitest2', 'samePassword', 3000.00, GETDATE())

SELECT id, user_name, password FROM Student WHERE id IN ('ST998', 'ST997')
GO

ROLLBACK TRANSACTION
*/

CREATE TRIGGER trg_HashTeacherPassword
ON Teacher
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Teacher (id, first_name, last_name, user_name, password, date_birth, gender, email, phone, address, city, description)
    SELECT
        i.id, i.first_name, i.last_name, i.user_name,
        CONVERT(NVARCHAR(128), HASHBYTES('SHA2_512', i.password + i.user_name), 2),
        i.date_birth, i.gender, i.email, i.phone, i.address, i.city, i.description
    FROM inserted i;
END
GO
/*
BEGIN TRANSACTION

INSERT INTO Teacher (id, first_name, last_name, email, user_name, password, description)
VALUES ('TE999', 'Teacher', 'Test', 'teacher@test.com', 'teachertest', 'teacherPass!', 'Test description')

SELECT id, user_name, password FROM Teacher WHERE id = 'TE999'
GO

ROLLBACK TRANSACTION
*/

-- Updates the 'last_modified' timestamp on a Course when its material is updated.
CREATE TRIGGER trg_UpdateCourseLastModified 
ON Course_Material
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON
    UPDATE Course SET last_modified = GETDATE()
    WHERE id IN (SELECT course_id FROM inserted)
END
GO
/*
-- Test Case
-- Check original timestamp
SELECT id, last_modified FROM Course WHERE id = 'GE_A1'
UPDATE Course_Material SET description = 'Updated English File Beginner Student Book' WHERE id = 'CM001'

-- Verify the timestamp has changed
SELECT id, last_modified FROM Course WHERE id = 'GE_A1'
*/

-- Logs the creation of a new student record into the AuditLog.
CREATE TRIGGER trg_LogStudentCreation 
ON Student
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails)
    SELECT 'Student', i.id, 'INSERT', 'A new student was created: ' + i.last_name + N' ' + i.first_name
    FROM inserted i
END
GO

/*
-- Test Case for trg_LogStudentCreation:
INSERT INTO Student (id, first_name, last_name, email, user_name, password)
VALUES ('ST999', 'Test', 'User', 'test.user@email.com', 'testuser999', 'password')

SELECT * FROM AuditLog WHERE RecordID = 'ST999'

DELETE FROM Student WHERE id = 'ST999'
*/

-- Logs student updates into the AuditLog with before and after values.
CREATE TRIGGER trg_LogStudentUpdate 
ON Student
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON

    IF UPDATE(balance)
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails)
        SELECT
            'Student', i.id, 'UPDATE',
            'Balance changed from ' + ISNULL(CONVERT(NVARCHAR(30), d.balance, 1), 'NULL') + 
            ' to ' + ISNULL(CONVERT(NVARCHAR(30), i.balance, 1), 'NULL') + '.'
        FROM inserted i JOIN deleted d ON i.id = d.id
        WHERE ISNULL(d.balance, -1) <> ISNULL(i.balance, -1)
    END

    IF UPDATE(email)
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails)
        SELECT 'Student', i.id, 'UPDATE', 'Email changed from ''' + d.email + ''' to ''' + i.email + '''.'
        FROM inserted i JOIN deleted d ON i.id = d.id
        WHERE d.email <> i.email
    END

    IF UPDATE(phone)
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails)
        SELECT 'Student', i.id, 'UPDATE', 'Phone changed from ''' + ISNULL(d.phone, 'NULL') + ''' to ''' + ISNULL(i.phone, 'NULL') + '''.'
        FROM inserted i JOIN deleted d ON i.id = d.id
        WHERE ISNULL(d.phone, '') <> ISNULL(i.phone, '')
    END
END
GO

/*
-- Test Case for trg_LogStudentUpdate:
UPDATE Student SET phone = '0999888777', email = 'new.email@st001.com' WHERE id = 'ST001'

SELECT * FROM AuditLog WHERE RecordID = 'ST001' AND ActionType = 'UPDATE' ORDER BY LogID DESC
*/

-- Logs the deletion of a student record into the AuditLog.
CREATE TRIGGER trg_LogStudentDeletion 
ON Student
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO AuditLog (TableName, RecordID, ActionType, ChangeDetails)
    SELECT 'Student', d.id, 'DELETE', 'Student record deleted. Name: ' + d.last_name + N' ' + d.first_name + N', Email: ' + d.email
    FROM deleted d
END
GO
/*
-- Test Case for trg_LogStudentDeletion:
INSERT INTO Student (id, first_name, last_name, email, user_name, password) 
VALUES('ST998', 'ToDelete', 'User', 'todelete.user@email.com', 'todelete998', 'password')

DELETE FROM Student WHERE id = 'ST998'

SELECT * FROM AuditLog WHERE RecordID = 'ST998'
*/

-- Automatically sets a new student's balance to 0 if it is NULL.
CREATE TRIGGER trg_SetInitialStudentBalance
ON Student
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON
    UPDATE Student
    SET balance = 0
    WHERE id IN (SELECT id FROM inserted) AND balance IS NULL
END
GO
/*
-- Test Case for trg_SetInitialStudentBalance:
INSERT INTO Student (id, first_name, last_name, email, user_name, password, balance)
VALUES ('ST997', 'NoBalance', 'User', 'nobalance.user@email.com', 'nobalance997', 'password', NULL)

SELECT id, balance FROM Student WHERE id = 'ST997'

DELETE FROM Student WHERE id = 'ST997'
*/

-- Deletes related exams, results, payments, and enrollments when a class is deleted.
CREATE TRIGGER trg_DeleteExamsOnClassDelete
ON Class
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON
    DELETE Payment FROM Payment p 
	JOIN deleted d ON p.class_id = d.id

    DELETE Exam_Result FROM Exam_Result g
	JOIN Exam e ON g.exam_id = e.id 
	JOIN deleted d ON e.class_id = d.id

    DELETE Exam FROM Exam e
	JOIN deleted d ON e.class_id = d.id

    DELETE Class_Student FROM Class_Student cs
	JOIN deleted d ON cs.class_id = d.id

    DELETE Class FROM Class c 
	JOIN deleted d ON c.id = d.id
END
GO

/*
BEGIN TRANSACTION

    -- 1. See what exists for a test class before deletion
    SELECT * FROM Class WHERE id = 'IELTS70-2401B'
    SELECT * FROM Payment WHERE class_id = 'IELTS70-2401B'
    SELECT * FROM Class_Student WHERE class_id = 'IELTS70-2401B'
    SELECT * FROM Exam WHERE class_id = 'IELTS70-2401B'
    
    -- 2. Delete the class
    DELETE FROM Class WHERE id = 'IELTS70-2401B'

    -- 3. Verify that all related data is gone
    SELECT * FROM Class WHERE id = 'IELTS70-2401B'
    SELECT * FROM Payment WHERE class_id = 'IELTS70-2401B'
    SELECT * FROM Class_Student WHERE class_id = 'IELTS70-2401B'
    SELECT * FROM Exam WHERE class_id = 'IELTS70-2401B'

ROLLBACK TRANSACTION 
GO
*/

