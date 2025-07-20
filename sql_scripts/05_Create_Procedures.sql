USE EducateDB
GO

-- Drop if they exist
IF OBJECT_ID('usp_GetStudentEnrollments', 'P') IS NOT NULL DROP PROCEDURE usp_GetStudentEnrollments
IF OBJECT_ID('usp_ProcessCoursePayment', 'P') IS NOT NULL DROP PROCEDURE usp_ProcessCoursePayment
IF OBJECT_ID('usp_UpdateStudentBalance', 'P') IS NOT NULL DROP PROCEDURE usp_UpdateStudentBalance
IF OBJECT_ID('usp_GetStudentsByCourseAndBalance', 'P') IS NOT NULL DROP PROCEDURE usp_GetStudentsByCourseAndBalance
IF OBJECT_ID('usp_GetCoursePaymentSummary', 'P') IS NOT NULL DROP PROCEDURE usp_GetCoursePaymentSummary
IF OBJECT_ID('usp_TransferStudentBalance', 'P') IS NOT NULL DROP PROCEDURE usp_TransferStudentBalance
IF OBJECT_ID('usp_GetStudentsWithHighestTotalPayment', 'P') IS NOT NULL DROP PROCEDURE usp_GetStudentsWithHighestTotalPayment
GO

-- Get a list of all classes that a particular student is enrolled in
CREATE PROCEDURE usp_GetStudentEnrollments @StudentID VARCHAR(5)
AS
BEGIN
    SET NOCOUNT ON
    SELECT ClassID, Schedule, CourseDescription, TeacherFullName, TuitionFee
    FROM V_Class_Details
    WHERE ClassID IN (SELECT class_id FROM Class_Student WHERE student_id = @StudentID)
END
GO
-- Test Case:
-- EXEC usp_GetStudentEnrollments @StudentID = 'ST001'


-- Adds a specified amount to a student's balance
CREATE PROCEDURE usp_UpdateStudentBalance
    @StudentID VARCHAR(5),
    @AmountToAdd DECIMAL(12,2)
AS
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS (SELECT 1 FROM Student WHERE id = @StudentID)
    BEGIN
        PRINT N'Lỗi: Sinh viên với ID ' + @StudentID + ' không tồn tại.'
        RETURN
    END

    UPDATE Student SET balance = ISNULL(balance, 0) + @AmountToAdd WHERE id = @StudentID
    
    DECLARE @NewBalance DECIMAL(12,2)
    SELECT @NewBalance = balance FROM Student WHERE id = @StudentID
    
    PRINT N'Đã cập nhật số dư cho sinh viên ' + @StudentID + N'. Số dư mới: ' + FORMAT(@NewBalance, '#,##0.00')
END
GO
-- Test Case:
-- EXEC usp_UpdateStudentBalance @StudentID = 'ST001', @AmountToAdd = 500000


-- Processes a payment for a class and automatically enrolls the student upon success.
CREATE PROCEDURE usp_ProcessCoursePayment
    @PaymentID VARCHAR(5), 
    @StudentID VARCHAR(5), 
    @ClassID NVARCHAR(20),
    @PaymentAmount DECIMAL(12,2), 
    @PaymentMethod NVARCHAR(50) = NULL, 
    @TransactionNotes NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON

    IF NOT EXISTS (SELECT 1 FROM Class WHERE id = @ClassID)
    BEGIN
        PRINT N'Giao dịch thanh toán ' + @PaymentID + ' cho SV ' + @StudentID + N' - Trạng thái: Failed. Lỗi: ClassID ''' + @ClassID + N''' không tồn tại.'
        RETURN 
    END

    IF NOT EXISTS (SELECT 1 FROM Student WHERE id = @StudentID)
    BEGIN
        PRINT N'Giao dịch thanh toán ' + @PaymentID + ' cho SV ' + @StudentID + N' - Trạng thái: Failed. Lỗi: StudentID ''' + @StudentID + N''' không tồn tại.'
        RETURN 
    END

    DECLARE @StudentBalance DECIMAL(12,2), @ClassTuition DECIMAL(12,2), @PaymentStatus NVARCHAR(20)
    DECLARE @CurrentPaymentDate DATE = GETDATE()
    DECLARE @FinalNotes NVARCHAR(MAX) = ISNULL(@TransactionNotes, '')

    SELECT @ClassTuition = tuition_fee FROM Class WHERE id = @ClassID
    SELECT @StudentBalance = ISNULL(balance, 0) FROM Student WHERE id = @StudentID

    IF @StudentBalance < @PaymentAmount
    BEGIN
        SET @PaymentStatus = N'Failed'
        SET @FinalNotes = @FinalNotes + N'; Lý do: Số dư không đủ.'
    END
    ELSE IF @PaymentAmount <> @ClassTuition
    BEGIN
        SET @PaymentStatus = N'Failed'
        SET @FinalNotes = @FinalNotes + N'; Lý do: Số tiền thanh toán không khớp học phí.'
    END
    ELSE
    BEGIN
        BEGIN TRANSACTION
        BEGIN TRY
            UPDATE Student SET balance = balance - @PaymentAmount WHERE id = @StudentID
            INSERT INTO Class_Student (class_id, student_id, enrollment_date) VALUES (@ClassID, @StudentID, GETDATE())
            COMMIT TRANSACTION
            
            SET @PaymentStatus = N'Success'
            SET @FinalNotes = @FinalNotes + N'; Thanh toán và ghi danh thành công.'
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION
            SET @PaymentStatus = N'Failed'
            SET @FinalNotes = @FinalNotes + N'; Lỗi hệ thống: ' + ERROR_MESSAGE()
        END CATCH
    END

    INSERT INTO Payment (id, payment_date, amount, status, student_id, class_id, payment_method, notes)
    VALUES (@PaymentID, @CurrentPaymentDate, @PaymentAmount, @PaymentStatus, @StudentID, @ClassID, @PaymentMethod, LTRIM(STUFF(@FinalNotes, 1, 1, '')))
    
    PRINT N'Giao dịch thanh toán ' + @PaymentID + N' cho sinh viên ' + @StudentID + N' - Trạng thái: ' + @PaymentStatus
END
GO
/* Test Case: 
EXEC usp_ProcessCoursePayment 
    @PaymentID = 'PA290', 
    @StudentID = 'ST002', 
    @ClassID = 'AWPRO-2402', 
    @PaymentAmount = 5000000.00, 
    @PaymentMethod = N'Thẻ tín dụng'

SELECT * FROM Payment WHERE ID = 'PA290'
SELECT * FROM Class_Student WHERE student_id = 'ST002' AND class_id = 'AWPRO-2402'
*/
GO
-- Gets a list of students enrolled in a specific course who have at least a minimum balance.
CREATE PROCEDURE usp_GetStudentsByCourseAndBalance
    @CourseID NVARCHAR(50),
    @MinBalance DECIMAL(12,2)
AS
BEGIN
    SET NOCOUNT ON
    SELECT
        S.id AS StudentID,
        S.last_name + N' ' + S.first_name AS StudentFullName,
        S.balance
    FROM Student S
    JOIN Class_Student CS ON S.id = CS.student_id
    JOIN Class CL ON CS.class_id = CL.id 
    WHERE CL.course_id = @CourseID AND S.balance >= @MinBalance
    ORDER BY StudentFullName
END
GO
-- Test Case:
-- EXEC usp_GetStudentsByCourseAndBalance @CourseID = N'GE_A1', @MinBalance = 1000000.00


-- Gets a payment summary for all classes belonging to a specific course.
CREATE PROCEDURE usp_GetCoursePaymentSummary
    @CourseID NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS (SELECT 1 FROM Course WHERE id = @CourseID)
    BEGIN
        PRINT N'Lỗi: Khóa học với ID ' + @CourseID + N' không tồn tại.'
        RETURN
    END

    SELECT
        C.description AS CourseName,
        COUNT(P.id) AS TotalPayments,
        ISNULL(SUM(P.amount), 0) AS TotalAmountPaid, 
        ISNULL(AVG(P.amount), 0) AS AveragePaymentAmount,
        MAX(P.payment_date) AS LastPaymentDate
    FROM Course C
    LEFT JOIN Class CL ON C.id = CL.course_id
    LEFT JOIN Payment P ON CL.id = P.class_id
    WHERE C.id = @CourseID
    GROUP BY C.description
END
GO
-- Test Case:
-- EXEC usp_GetCoursePaymentSummary @CourseID = N'IELTS_70'


-- Transfers a balance from one student to another.
CREATE PROCEDURE usp_TransferStudentBalance
    @SenderStudentID VARCHAR(5),
    @ReceiverStudentID VARCHAR(5),
    @TransferAmount DECIMAL(12,2)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SenderBalance DECIMAL(12,2);

    IF @TransferAmount <= 0
    BEGIN
        PRINT N'Lỗi: Số tiền chuyển phải lớn hơn 0.';
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Student WHERE id = @SenderStudentID)
    BEGIN
        PRINT N'Lỗi: Sinh viên gửi với ID ' + @SenderStudentID + N' không tồn tại.';
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Student WHERE id = @ReceiverStudentID)
    BEGIN
        PRINT N'Lỗi: Sinh viên nhận với ID ' + @ReceiverStudentID + N' không tồn tại.';
        RETURN;
    END;

    IF @SenderStudentID = @ReceiverStudentID
    BEGIN
        PRINT N'Lỗi: Không thể chuyển tiền cho chính mình.'
        RETURN
    END

    BEGIN TRY
        BEGIN TRANSACTION
        SELECT @SenderBalance = ISNULL(balance, 0) FROM Student WHERE id = @SenderStudentID
        IF @SenderBalance < @TransferAmount
        BEGIN
            PRINT N'Lỗi: Số dư của sinh viên ' + @SenderStudentID + N' không đủ để thực hiện giao dịch này.'
            ROLLBACK TRANSACTION
            RETURN
        END;

        UPDATE Student
        SET balance = balance - @TransferAmount
        WHERE id = @SenderStudentID

        UPDATE Student
        SET balance = ISNULL(balance, 0) + @TransferAmount
        WHERE id = @ReceiverStudentID

        COMMIT TRANSACTION
        PRINT N'Chuyển khoản thành công từ ' + @SenderStudentID + N' sang ' + @ReceiverStudentID + N' số tiền ' + CAST(@TransferAmount AS VARCHAR) + N'.'
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        PRINT N'Lỗi trong quá trình chuyển khoản: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END
GO
/*Test Case:
SELECT id, balance FROM Student WHERE id IN ('ST002', 'ST005')

EXEC usp_TransferStudentBalance @SenderStudentID = 'ST002', @ReceiverStudentID = 'ST005', @TransferAmount = 10000.00

SELECT id, balance FROM Student WHERE id IN ('ST002', 'ST005')
GO
*/

-- Gets the top N students with the highest total successful payments.
CREATE PROCEDURE usp_GetStudentsWithHighestTotalPayment
    @TopN INT = 5 
AS
BEGIN
    SET NOCOUNT ON
    SELECT TOP (@TopN)
        S.id AS StudentID,
        S.last_name + N' ' + S.first_name AS StudentFullName, 
        ISNULL(SUM(P.amount), 0) AS TotalAmountPaid 
    FROM Student S
    LEFT JOIN Payment P ON S.id = P.student_id
    WHERE P.status = 'Success' 
    GROUP BY S.id, S.first_name, S.last_name
    ORDER BY TotalAmountPaid DESC
END
GO
-- Test Case:
-- EXEC usp_GetStudentsWithHighestTotalPayment @TopN = 3