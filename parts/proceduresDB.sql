USE EducateDB
GO

-- Drop if it exists
IF OBJECT_ID('usp_GetStudentEnrollments', 'P') IS NOT NULL DROP PROCEDURE usp_GetStudentEnrollments
IF OBJECT_ID('usp_ProcessCoursePayment', 'P') IS NOT NULL DROP PROCEDURE usp_ProcessCoursePayment
IF OBJECT_ID('usp_UpdateStudentBalance', 'P') IS NOT NULL DROP PROCEDURE usp_UpdateStudentBalance
IF OBJECT_ID('usp_GetStudentsByCourseAndBalance', 'P') IS NOT NULL DROP PROCEDURE usp_GetStudentsByCourseAndBalance
IF OBJECT_ID('usp_EnrollStudentInClass', 'P') IS NOT NULL DROP PROCEDURE usp_EnrollStudentInClass
IF OBJECT_ID('usp_GetCoursePaymentSummary', 'P') IS NOT NULL DROP PROCEDURE usp_GetCoursePaymentSummary
IF OBJECT_ID('usp_TransferStudentBalance', 'P') IS NOT NULL DROP PROCEDURE usp_TransferStudentBalance
IF OBJECT_ID('usp_GetStudentsWithHighestTotalPayment', 'P') IS NOT NULL DROP PROCEDURE usp_GetStudentsWithHighestTotalPayment
GO

-- Get a list of all classes that a particular student is enrolled in
CREATE PROCEDURE usp_GetStudentEnrollments @StudentID VARCHAR(5)
AS
BEGIN
    SELECT ClassID, Schedule, CourseDescription, TeacherFullName
    FROM V_Class_Details
    WHERE ClassID IN (SELECT class_id FROM Class_Student WHERE student_id = @StudentID)
END
GO
-- Test Case:
-- EXEC usp_GetStudentEnrollments @StudentID = 'ST001'


-- Update a student's balance
CREATE PROCEDURE usp_UpdateStudentBalance
    @StudentID VARCHAR(5),
    @AmountToAdd DECIMAL(12,2)
AS
BEGIN
    DECLARE @NewBalance DECIMAL(12,2)
    IF NOT EXISTS (SELECT 1 FROM Student WHERE id = @StudentID)
    BEGIN
        PRINT N'Error: Student with ID ' + @StudentID + ' not found.'
        RETURN
    END
    UPDATE Student SET balance = ISNULL(balance, 0) + @AmountToAdd WHERE id = @StudentID
    SELECT @NewBalance = balance FROM Student WHERE id = @StudentID
    PRINT N'Balance updated for student ' + @StudentID + '. New balance: ' + CAST(@NewBalance AS VARCHAR)
END
GO
-- Test Case:
-- EXEC usp_UpdateStudentBalance @StudentID = 'ST001', @AmountToAdd = 500000


-- Process a course payment
CREATE PROCEDURE usp_ProcessCoursePayment
    @PaymentID VARCHAR(5), @StudentID VARCHAR(5), @CourseID NVARCHAR(50),
    @PaymentAmount DECIMAL(12,2), @PaymentMethod NVARCHAR(50) = NULL, @TransactionNotes NVARCHAR(255) = NULL
AS
BEGIN
    DECLARE @StudentBalance DECIMAL(12,2), @CourseTuition DECIMAL(12,2), @PaymentStatus NVARCHAR(20)
    DECLARE @CurrentPaymentDate DATE = GETDATE()
    SELECT @StudentBalance = ISNULL(balance, 0) FROM Student WHERE id = @StudentID
    SELECT @CourseTuition = tuition_fee FROM Course WHERE id = @CourseID

    IF @StudentBalance IS NULL OR @CourseTuition IS NULL
    BEGIN
        SET @PaymentStatus = N'Failed'; SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Error: Invalid student or course.'
        INSERT INTO Payment (id, payment_date, amount, status, student_id, course_id, payment_method, notes) VALUES (@PaymentID, @CurrentPaymentDate, @PaymentAmount, @PaymentStatus, @StudentID, @CourseID, @PaymentMethod, @TransactionNotes)
        PRINT N'Payment failed: Invalid student or course.'
		RETURN
    END

    IF @PaymentAmount = @CourseTuition AND @StudentBalance >= @PaymentAmount
    BEGIN
        SET @PaymentStatus = N'Success'; UPDATE Student SET balance = balance - @PaymentAmount WHERE id = @StudentID
        SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Payment successful. Balance updated.'
    END
    ELSE IF @StudentBalance < @PaymentAmount
    BEGIN
        SET @PaymentStatus = N'Failed'; SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Reason: Insufficient balance.'
    END
    ELSE
    BEGIN
        SET @PaymentStatus = N'Failed'; SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Reason: Payment amount does not match tuition fee.'
    END

    INSERT INTO Payment (id, payment_date, amount, status, student_id, course_id, payment_method, notes)
    VALUES (@PaymentID, @CurrentPaymentDate, @PaymentAmount, @PaymentStatus, @StudentID, @CourseID, @PaymentMethod, @TransactionNotes)
    
    PRINT N'Payment ' + @PaymentID + N' for student ' + @StudentID + N' - Status: ' + @PaymentStatus
END
GO
-- Test Case:
-- EXEC usp_ProcessCoursePayment @PaymentID = 'PA290', @StudentID = 'ST002', @CourseID = 'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Thẻ tín dụng'
-- SELECT * FROM Payment WHERE ID = 'PA290'


-- Get students by course and balance
CREATE PROCEDURE usp_GetStudentsByCourseAndBalance
    @CourseID NVARCHAR(50),
    @MinBalance DECIMAL(12,2)
AS
BEGIN
    SELECT
        S.id AS StudentID,
        S.last_name + N' ' + S.first_name AS StudentFullName,
        S.balance AS StudentBalance,
        C.description AS CourseName
    FROM Student S
    JOIN Class_Student CS ON S.id = CS.student_id
    JOIN Class CL ON CS.class_id = CL.id 
    JOIN  Course C ON CL.course_id = C.id
    WHERE C.id = @CourseID AND S.balance >= @MinBalance
    ORDER BY  StudentFullName
END
GO
-- Test Case:
-- EXEC usp_GetStudentsByCourseAndBalance @CourseID = N'GE_A1', @MinBalance = 1000000.00


-- Enroll a student into a class
CREATE PROCEDURE usp_EnrollStudentInClass
    @StudentID VARCHAR(5),
    @ClassID NVARCHAR(20)
AS
BEGIN
    DECLARE @StudentExists INT, @ClassExists INT, @AlreadyEnrolled INT

    SELECT @StudentExists = COUNT(1) FROM Student WHERE id = @StudentID
    IF @StudentExists = 0
    BEGIN
        PRINT N'Error: Student with ID ' + @StudentID + N' does not exist.'
        RETURN
    END

    SELECT @ClassExists = COUNT(1) FROM Class WHERE id = @ClassID
    IF @ClassExists = 0
    BEGIN
        PRINT N'Error: Class with ID ' + @ClassID + N' does not exist.'
        RETURN
    END

    SELECT @AlreadyEnrolled = COUNT(1) FROM Class_Student WHERE student_id = @StudentID AND class_id = @ClassID
    IF @AlreadyEnrolled > 0
    BEGIN
        PRINT N'Notice: Student ' + @StudentID + N' is already enrolled in class ' + @ClassID + N'.'
        RETURN
    END

    INSERT INTO Class_Student (student_id, class_id, enrollment_date)
    VALUES (@StudentID, @ClassID, GETDATE())

    PRINT N'Student ' + @StudentID + N' has been successfully enrolled in class ' + @ClassID + N'.'
END
GO
-- Test Case:
-- EXEC usp_EnrollStudentInClass @StudentID = 'ST025', @ClassID = N'IELTS55-2401'


-- Get a payment summary for a course
CREATE PROCEDURE usp_GetCoursePaymentSummary
    @CourseID NVARCHAR(50)
AS
BEGIN
    DECLARE @CourseExists INT
    SELECT @CourseExists = COUNT(1) FROM Course WHERE id = @CourseID

    IF @CourseExists = 0
    BEGIN
        PRINT N'Error: Course with ID ' + @CourseID + N' does not exist.'
        RETURN
    END
    SELECT
        C.description AS CourseName,
        COUNT(P.id) AS TotalPayments,
        ISNULL(SUM(P.amount), 0) AS TotalAmountPaid, 
        ISNULL(AVG(P.amount), 0) AS AveragePaymentAmount,
        MAX(P.payment_date) AS LastPaymentDate
    FROM Course C
    LEFT JOIN Payment P ON C.id = P.course_id
    WHERE C.id = @CourseID
    GROUP BY C.description
END
GO
-- Test Case:
-- EXEC usp_GetCoursePaymentSummary @CourseID = N'IELTS_70'


-- Transfer student balance
CREATE PROCEDURE usp_TransferStudentBalance
    @SenderStudentID VARCHAR(5),
    @ReceiverStudentID VARCHAR(5),
    @TransferAmount DECIMAL(12,2)
AS
BEGIN
    DECLARE @SenderBalance DECIMAL(12,2)

    IF @TransferAmount <= 0
    BEGIN
        PRINT N'Error: Transfer amount must be greater than 0.'
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Student WHERE id = @SenderStudentID)
    BEGIN
        PRINT N'Error: Sender student with ID ' + @SenderStudentID + N' does not exist.'
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Student WHERE id = @ReceiverStudentID)
    BEGIN
        PRINT N'Error: Receiver student with ID ' + @ReceiverStudentID + N' does not exist.'
        RETURN
    END

    IF @SenderStudentID = @ReceiverStudentID
    BEGIN
        PRINT N'Error: Cannot transfer funds to self.'
        RETURN
    END

    BEGIN TRY
        BEGIN TRANSACTION
        SELECT @SenderBalance = ISNULL(balance, 0) FROM Student WHERE id = @SenderStudentID

        IF @SenderBalance < @TransferAmount
        BEGIN
            PRINT N'Error: Balance for student ' + @SenderStudentID + N' is not sufficient for this transaction.'
            ROLLBACK TRANSACTION
            RETURN
        END
        UPDATE Student
        SET balance = balance - @TransferAmount
        WHERE id = @SenderStudentID

        UPDATE Student
        SET balance = ISNULL(balance, 0) + @TransferAmount
        WHERE id = @ReceiverStudentID
        COMMIT TRANSACTION
        PRINT N'Transfer successful from ' + @SenderStudentID + N' to ' + @ReceiverStudentID + N' for the amount of ' + CAST(@TransferAmount AS VARCHAR) + N'.'
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT N'Error during transfer: ' + ERROR_MESSAGE();
        THROW
    END CATCH
END
GO
-- Test Case:
-- EXEC usp_TransferStudentBalance @SenderStudentID = 'ST002', @ReceiverStudentID = 'ST005', @TransferAmount = 10000.00


-- Get students with the highest total payments
CREATE PROCEDURE usp_GetStudentsWithHighestTotalPayment
    @TopN INT = 5 
AS
BEGIN
    SELECT TOP (@TopN)
        S.id AS StudentID,
        S.last_name + N' ' + S.first_name AS StudentFullName, 
        ISNULL(SUM(P.amount), 0) AS TotalAmountPaid 
    FROM Student S
    LEFT JOIN Payment P ON S.id = P.student_id
    GROUP BY S.id, S.first_name, S.last_name
    ORDER BY TotalAmountPaid DESC
END
GO
-- Test Case:
-- EXEC usp_GetStudentsWithHighestTotalPayment @TopN = 3
