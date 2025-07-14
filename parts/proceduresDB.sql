USE EducateDB
GO

-- Drop if it exists
IF OBJECT_ID('usp_GetStudentEnrollments', 'P') IS NOT NULL DROP PROCEDURE usp_GetStudentEnrollments;
IF OBJECT_ID('usp_ProcessCoursePayment', 'P') IS NOT NULL DROP PROCEDURE usp_ProcessCoursePayment;
IF OBJECT_ID('usp_UpdateStudentBalance', 'P') IS NOT NULL DROP PROCEDURE usp_UpdateStudentBalance;
GO

-- Creating Store Procedures
CREATE PROCEDURE usp_GetStudentEnrollments @StudentID VARCHAR(5)
AS
BEGIN
    SELECT ClassID, Schedule, CourseDescription, TeacherFullName
    FROM V_Class_Details
    WHERE ClassID IN (SELECT class_id FROM Class_Student WHERE student_id = @StudentID);
END
GO

CREATE PROCEDURE usp_UpdateStudentBalance
    @StudentID VARCHAR(5),
    @AmountToAdd DECIMAL(12,2)
AS
BEGIN
    DECLARE @NewBalance DECIMAL(12,2);
    IF NOT EXISTS (SELECT 1 FROM Student WHERE id = @StudentID)
    BEGIN
        PRINT N'Lỗi: Không tìm thấy sinh viên với ID ' + @StudentID;
        RETURN;
    END
    UPDATE Student SET balance = ISNULL(balance, 0) + @AmountToAdd WHERE id = @StudentID;
    SELECT @NewBalance = balance FROM Student WHERE id = @StudentID;
    PRINT N'Đã cập nhật số dư cho sinh viên ' + @StudentID + N'. Số dư mới: ' + CAST(@NewBalance AS VARCHAR);
END
GO

CREATE PROCEDURE usp_ProcessCoursePayment
    @PaymentID VARCHAR(5), @StudentID VARCHAR(5), @CourseID NVARCHAR(50),
    @PaymentAmount DECIMAL(12,2), @PaymentMethod NVARCHAR(50) = NULL, @TransactionNotes NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StudentBalance DECIMAL(12,2), @CourseTuition DECIMAL(12,2), @PaymentStatus NVARCHAR(20);
    DECLARE @CurrentPaymentDate DATE = GETDATE();
    SELECT @StudentBalance = ISNULL(balance, 0) FROM Student WHERE id = @StudentID;
    SELECT @CourseTuition = tuition_fee FROM Course WHERE id = @CourseID;

    IF @StudentBalance IS NULL OR @CourseTuition IS NULL
    BEGIN
        SET @PaymentStatus = N'Failed'; SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Lỗi: Sinh viên hoặc Khóa học không hợp lệ.';
        INSERT INTO Payment (id, payment_date, amount, status, student_id, course_id, payment_method, notes) VALUES (@PaymentID, @CurrentPaymentDate, @PaymentAmount, @PaymentStatus, @StudentID, @CourseID, @PaymentMethod, @TransactionNotes);
        PRINT N'Thanh toán thất bại: Sinh viên hoặc Khóa học không hợp lệ.'; RETURN;
    END

    IF @PaymentAmount = @CourseTuition AND @StudentBalance >= @PaymentAmount
    BEGIN
        SET @PaymentStatus = N'Success'; UPDATE Student SET balance = balance - @PaymentAmount WHERE id = @StudentID;
        SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Thanh toán thành công. Số dư đã cập nhật.';
    END
    ELSE IF @StudentBalance < @PaymentAmount
    BEGIN
        SET @PaymentStatus = N'Failed'; SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Lý do: Số dư không đủ.';
    END
    ELSE
    BEGIN
        SET @PaymentStatus = N'Failed'; SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Lý do: Số tiền thanh toán không khớp học phí.';
    END

    INSERT INTO Payment (id, payment_date, amount, status, student_id, course_id, payment_method, notes)
    VALUES (@PaymentID, @CurrentPaymentDate, @PaymentAmount, @PaymentStatus, @StudentID, @CourseID, @PaymentMethod, @TransactionNotes);
    
    PRINT N'Thanh toán ' + @PaymentID + N' cho sinh viên ' + @StudentID + N' - Trạng thái: ' + @PaymentStatus;
END
GO