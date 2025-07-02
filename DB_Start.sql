
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'EducateDB')
BEGIN
    PRINT 'Creating database EducateDB...';
    CREATE DATABASE EducateDB;
END
GO

USE EducateDB;
GO

PRINT 'Dropping existing objects...';
IF OBJECT_ID('usp_GetStudentEnrollments', 'P') IS NOT NULL DROP PROCEDURE usp_GetStudentEnrollments;
IF OBJECT_ID('usp_ProcessCoursePayment', 'P') IS NOT NULL DROP PROCEDURE usp_ProcessCoursePayment;
IF OBJECT_ID('usp_UpdateStudentBalance', 'P') IS NOT NULL DROP PROCEDURE usp_UpdateStudentBalance;
IF OBJECT_ID('dbo.fn_GetStudentFullName', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_GetStudentFullName;
IF OBJECT_ID('dbo.fn_CalculateStudentAge', 'FN') IS NOT NULL DROP FUNCTION dbo.fn_CalculateStudentAge;
IF OBJECT_ID('dbo.fn_GetClassesByTeacher', 'IF') IS NOT NULL DROP FUNCTION dbo.fn_GetClassesByTeacher;
IF OBJECT_ID('V_Class_Details', 'V') IS NOT NULL DROP VIEW V_Class_Details;
IF OBJECT_ID('V_Student_Grades', 'V') IS NOT NULL DROP VIEW V_Student_Grades;
IF OBJECT_ID('V_Course_Summary', 'V') IS NOT NULL DROP VIEW V_Course_Summary;
IF OBJECT_ID('V_Teacher_Workload', 'V') IS NOT NULL DROP VIEW V_Teacher_Workload;
IF OBJECT_ID('trg_UpdateCourseLastModified', 'TR') IS NOT NULL DROP TRIGGER trg_UpdateCourseLastModified;
IF OBJECT_ID('trg_PreventStudentDeletionWithBalance', 'TR') IS NOT NULL DROP TRIGGER trg_PreventStudentDeletionWithBalance;
IF OBJECT_ID('trg_LogStudentCreation', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentCreation;
IF OBJECT_ID('trg_LogStudentUpdate', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentUpdate;
IF OBJECT_ID('trg_LogStudentDeletion', 'TR') IS NOT NULL DROP TRIGGER trg_LogStudentDeletion;
IF OBJECT_ID('trg_PreventDuplicateEnrollment', 'TR') IS NOT NULL DROP TRIGGER trg_PreventDuplicateEnrollment;
IF OBJECT_ID('Grade', 'U') IS NOT NULL DROP TABLE Grade;
IF OBJECT_ID('Payment', 'U') IS NOT NULL DROP TABLE Payment;
IF OBJECT_ID('Exam', 'U') IS NOT NULL DROP TABLE Exam;
IF OBJECT_ID('Class_Student', 'U') IS NOT NULL DROP TABLE Class_Student;
IF OBJECT_ID('Course_Material', 'U') IS NOT NULL DROP TABLE Course_Material;
IF OBJECT_ID('Class', 'U') IS NOT NULL DROP TABLE Class;
IF OBJECT_ID('Course', 'U') IS NOT NULL DROP TABLE Course;
IF OBJECT_ID('AuditLog', 'U') IS NOT NULL DROP TABLE AuditLog;
IF OBJECT_ID('Student', 'U') IS NOT NULL DROP TABLE Student;
IF OBJECT_ID('Teacher', 'U') IS NOT NULL DROP TABLE Teacher;
GO

-- 3. TABLE CREATION
PRINT 'Creating tables with robust constraints...';

CREATE TABLE Teacher (
    id VARCHAR(5) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_birth DATE,
    gender NVARCHAR(3),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address NVARCHAR(255),
    city NVARCHAR(50),
    description NVARCHAR(255),
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    CONSTRAINT CK_Teacher_ID CHECK (id LIKE 'TE[0-9][0-9][0-9]'),
    CONSTRAINT CK_Teacher_Gender CHECK (gender IN (N'Nam', N'Nữ')),
    CONSTRAINT CK_Teacher_Email CHECK (email LIKE '%_@__%.__%')
);
GO

CREATE TABLE Student (
    id VARCHAR(5) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_birth DATE,
    gender NVARCHAR(3),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address NVARCHAR(255),
    city NVARCHAR(50),
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    balance DECIMAL(12,2),
    created_date DATE,
    CONSTRAINT CK_Student_ID CHECK (id LIKE 'ST[0-9][0-9][0-9]'),
    CONSTRAINT CK_Student_Gender CHECK (gender IN (N'Nam', N'Nữ')),
    CONSTRAINT CK_Student_Email CHECK (email LIKE '%_@__%.__%'),
    CONSTRAINT CK_Student_Balance CHECK (balance >= 0)
);
GO

CREATE TABLE Course (
    id NVARCHAR(50) PRIMARY KEY,
    description NVARCHAR(MAX),
    last_modified DATETIME2,
    tuition_fee DECIMAL(12,2),
    CONSTRAINT CK_Course_TuitionFee CHECK (tuition_fee >= 0)
);
GO

CREATE TABLE Course_Material (
    id VARCHAR(5) PRIMARY KEY,
    course_id NVARCHAR(50) NOT NULL,
    description NVARCHAR(MAX),
    material_type NVARCHAR(50),
    material_url VARCHAR(255),
    date_add DATE,
    FOREIGN KEY (course_id) REFERENCES Course(id),
    CONSTRAINT CK_Course_Material_ID CHECK (id LIKE 'CM[0-9][0-9][0-9]'),
    CONSTRAINT CK_Course_Material_Type CHECK (material_type IN (N'Sách giáo trình', N'Sách bài tập',N'Sách từ vựng', N'Tệp âm thanh', N'Video Links', N'Học liệu', N'Sách luyện đề', N'Tài liệu tham khảo'))
);
GO

CREATE TABLE Class (
    id NVARCHAR(20) PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    teacher_id VARCHAR(5),
    course_id NVARCHAR(50) NOT NULL,
    schedule_info NVARCHAR(100),
    room_number NVARCHAR(20),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(id),
    FOREIGN KEY (course_id) REFERENCES Course(id),
    CONSTRAINT CK_Class_Dates CHECK (end_date >= start_date),
    CONSTRAINT CK_Class_RoomNumber CHECK (room_number LIKE 'P[1-3][0-9][0-9]')
);
GO

CREATE TABLE Class_Student (
    class_id NVARCHAR(20) NOT NULL,
    student_id VARCHAR(5) NOT NULL,
    enrollment_date DATE,
    PRIMARY KEY (class_id, student_id),
    FOREIGN KEY (class_id) REFERENCES Class(id),
    FOREIGN KEY (student_id) REFERENCES Student(id)
);
GO

CREATE TABLE Exam (
    id VARCHAR(5) PRIMARY KEY,
    date DATE,
    description NVARCHAR(MAX),
    class_id NVARCHAR(20) NOT NULL,
    exam_type NVARCHAR(50),
    duration_minutes INT,
    FOREIGN KEY (class_id) REFERENCES Class(id),
    CONSTRAINT CK_Exam_ID CHECK (id LIKE 'EX[0-9][0-9][0-9]'),
    CONSTRAINT CK_Exam_Type CHECK (exam_type IN (N'Midterm', N'Final', N'Quiz', N'Mock Test', N'Speaking Test')),
    CONSTRAINT CK_Exam_Duration CHECK (duration_minutes > 0)
);
GO

CREATE TABLE Grade (
    id VARCHAR(5) PRIMARY KEY,
    value DECIMAL(4,2) NOT NULL,
    student_id VARCHAR(5) NOT NULL,
    exam_id VARCHAR(5) NOT NULL,
    class_id NVARCHAR(20),
    date DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (exam_id) REFERENCES Exam(id),
    FOREIGN KEY (class_id) REFERENCES Class(id),
    CONSTRAINT CK_Grade_ID CHECK (id LIKE 'GR[0-9][0-9][0-9]'),
    CONSTRAINT CK_Grade_Value CHECK (value >= 0.00 AND value <= 10.00)
);
GO

CREATE TABLE Payment (
    id VARCHAR(5) PRIMARY KEY,
    payment_date DATE,
    amount DECIMAL(12,2) NOT NULL,
    status NVARCHAR(20) NOT NULL,
    student_id VARCHAR(5) NOT NULL,
    course_id NVARCHAR(50) NOT NULL,
    payment_method NVARCHAR(50),
    notes NVARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id),
    CONSTRAINT CK_Payment_ID CHECK (id LIKE 'PA[0-9][0-9][0-9]'),
    CONSTRAINT CK_Payment_Amount CHECK (amount > 0),
    CONSTRAINT CK_Payment_Status CHECK (status IN (N'Success', N'Failed')),
    CONSTRAINT CK_Payment_Method CHECK (payment_method IN (N'Tiền mặt', N'Chuyển khoản', N'Thẻ tín dụng', N'Momo'))
);
GO

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(128) NOT NULL,
    RecordID VARCHAR(50) NOT NULL,
    ActionType NVARCHAR(50) NOT NULL,
    ChangeDetails NVARCHAR(MAX),
    ChangedBy NVARCHAR(128) DEFAULT SUSER_SNAME(),
    ChangedAt DATETIME2 DEFAULT GETDATE()
);
GO

-- 4. VIEWS
PRINT 'Creating views...';
GO

CREATE VIEW V_Class_Details AS
SELECT
    cl.id AS ClassID,
    cl.schedule_info AS Schedule,
    cl.room_number AS Room,
    co.id AS CourseID,
    co.description AS CourseDescription,
    t.last_name + N' ' + t.first_name AS TeacherFullName
FROM Class cl
JOIN Course co ON cl.course_id = co.id
LEFT JOIN Teacher t ON cl.teacher_id = t.id;
GO

CREATE VIEW V_Student_Grades AS
SELECT
    s.id AS StudentID,
    s.last_name + N' ' + s.first_name AS StudentFullName,
    e.description AS ExamDescription,
    e.exam_type AS ExamType,
    e.date AS ExamDate,
    g.value AS GradeValue
FROM Grade g
JOIN Student s ON g.student_id = s.id
JOIN Exam e ON g.exam_id = e.id;
GO

CREATE VIEW V_Course_Summary AS
SELECT
    c.id AS CourseID,
    c.description AS CourseDescription,
    c.tuition_fee AS TuitionFee,
    COUNT(DISTINCT cl.id) AS NumberOfClasses,
    COUNT(DISTINCT cs.student_id) AS TotalEnrollments
FROM Course c
LEFT JOIN Class cl ON c.id = cl.course_id
LEFT JOIN Class_Student cs ON cl.id = cs.class_id
GROUP BY c.id, c.description, c.tuition_fee;
GO

CREATE VIEW V_Teacher_Workload AS
SELECT
    t.id AS TeacherID,
    t.last_name + N' ' + t.first_name AS TeacherFullName,
    ISNULL(COUNT(DISTINCT cl.id), 0) AS AssignedClasses,
    ISNULL(COUNT(DISTINCT cl.course_id), 0) AS DistinctCoursesTaught
FROM Teacher t
LEFT JOIN Class cl ON t.id = cl.teacher_id
GROUP BY t.id, t.first_name, t.last_name;
GO

-- 5. FUNCTIONS
PRINT 'Creating functions...';
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
           CASE WHEN (MONTH(@DateOfBirth) > MONTH(GETDATE())) OR (MONTH(@DateOfBirth) = MONTH(GETDATE()) AND DAY(@DateOfBirth) > DAY(GETDATE())) THEN 1 ELSE 0 END;
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

-- 6. STORED PROCEDURES
PRINT 'Creating stored procedures...';
GO

CREATE PROCEDURE usp_GetStudentEnrollments @StudentID VARCHAR(5)
AS
BEGIN
    SET NOCOUNT ON;
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
    SET NOCOUNT ON;
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

-- ===================================================================
-- 7. TRIGGERS
-- ===================================================================
PRINT 'Creating triggers...';
GO

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
GO

-- 8. DATA INSERTION
PRINT 'Clearing existing data...';
DELETE FROM Grade; DELETE FROM Payment; DELETE FROM Exam; DELETE FROM Class_Student; DELETE FROM Course_Material; DELETE FROM Class; DELETE FROM Course; DELETE FROM AuditLog; DELETE FROM Student; DELETE FROM Teacher;
GO

PRINT 'Inserting sample data...';
INSERT INTO Teacher (id, first_name, last_name, date_birth, gender, email, phone, address, city, description, user_name, password) VALUES
('TE001', N'Mai', N'Nguyễn Thị Lan', '1985-03-12', N'Nữ', 'mai.ntl@educenter.vn', '0912345678', N'Số 10, Ngõ 25, Phố Vạn Bảo, Ba Đình', N'Hà Nội', N'Giáo viên IELTS (8.5), 10 năm kinh nghiệm', 'maintl', 'pass123'),
('TE002', N'David', N'Smith', '1978-07-20', N'Nam', 'david.smith@educenter.vn', '0987654321', N'P201, Tòa nhà A, Times City, Hai Bà Trưng', N'Hà Nội', N'Giáo viên bản ngữ (Mỹ), chuyên Phát âm & Giao tiếp', 'davids', 'pass123'),
('TE003', N'Hùng', N'Trần Mạnh', '1990-11-05', N'Nam', 'hung.tm@educenter.vn', '0903334444', N'Số 55, Phố Chùa Láng, Đống Đa', N'Hà Nội', N'Giáo viên Tiếng Anh Trẻ em, TESOL certified', 'hungtm', 'pass123'),
('TE004', N'Phương', N'Lê Thu', '1982-06-25', N'Nữ', 'phuong.lt@educenter.vn', '0901112222', N'Số 8, Ngách 10, Đường Xuân Thủy, Cầu Giấy', N'Hà Nội', N'Chuyên luyện thi TOEIC, cựu giám khảo', 'phuonglt', 'pass123'),
('TE005', N'John', N'Baker', '1980-09-17', N'Nam', 'john.baker@educenter.vn', '0902223333', N'Số 12, Phố Lý Thường Kiệt, Hoàn Kiếm', N'Hà Nội', N'Giáo viên bản ngữ (Anh), Tiếng Anh Kinh doanh', 'johnb', 'pass123'),
('TE006', N'Emily', N'White', '1995-04-18', N'Nữ', 'emily.white@educenter.vn', '0904445555', N'Căn hộ 302, The Link Ciputra, Tây Hồ', N'Hà Nội', N'Giáo viên bản ngữ (Úc), chuyên Tiếng Anh Sáng tạo', 'emilyw', 'pass123'),
('TE007', N'Tuấn', N'Trần Quốc', '1989-12-01', N'Nam', 'tuan.tq@educenter.vn', '0905556666', N'Số 28, Phố Hàng Chuối, Hai Bà Trưng', N'Hà Nội', N'Chuyên gia Luyện thi Viết Luận Học thuật', 'tuantq', 'pass123'),
('TE008', N'Linh', N'Hoàng Thùy', '1991-08-11', N'Nữ', 'linh.ht@educenter.vn', '0906667777', N'Số 33, Phố Trúc Bạch, Ba Đình', N'Hà Nội', N'Giáo viên IELTS chuyên Reading & Listening', 'linhht', 'pass123'),
('TE009', N'Chris', N'Jones', '1983-05-20', N'Nam', 'chris.jones@educenter.vn', '0907778888', N'Số 18, Ngõ 9, Phố Huỳnh Thúc Kháng, Đống Đa', N'Hà Nội', N'Giáo viên bản ngữ (Canada), chuyên Tiếng Anh Phản xạ', 'chrisj', 'pass123'),
('TE010', N'Ngân', N'Vũ Thị Kim', '1987-10-25', N'Nữ', 'ngan.vtk@educenter.vn', '0908889999', N'Số 42, Phố Nhà Thờ, Hoàn Kiếm', N'Hà Nội', N'Giáo viên TOEIC Bridge và Tiếng Anh Mất gốc', 'nganvtk', 'pass123');
GO
INSERT INTO Student (id, first_name, last_name, date_birth, gender, email, phone, address, city, user_name, password, balance, created_date) VALUES
('ST001', N'Quân', N'Hoàng Minh', '2000-04-10', N'Nam', 'quan.hm@email.com', '0988123456', N'Số 15, Phố Trần Hưng Đạo, Hoàn Kiếm', N'Hà Nội', 'quanhm', 'pass123', 8000000.00, '2023-01-15'),
('ST002', N'Linh', N'Trần Thùy', '2003-08-22', N'Nữ', 'linh.tt@email.com', '0977765432', N'P.503, Chung cư Golden Land, Thanh Xuân', N'Hà Nội', 'linhtt', 'pass123', 6000000.00, '2023-02-01'),
('ST003', N'Trung', N'Lê Đức', '1998-12-01', N'Nam', 'trung.ld@email.com', '0966998877', N'Số 30, Ngõ Thái Hà, Đống Đa', N'Hà Nội', 'trungld', 'pass123', 8000000.00, '2023-03-10'),
('ST004', N'Vy', N'Phạm Khánh', '2004-02-28', N'Nữ', 'vy.pk@email.com', '0955112233', N'Biệt thự B12, Khu đô thị Ciputra, Tây Hồ', N'Hà Nội', 'vypk', 'pass123', 7500000.00, '2023-04-05'),
('ST005', N'Phong', N'Nguyễn Tuấn', '2001-06-11', N'Nam', 'phong.nt@email.com', '0918765999', N'Số 22, Phố Hàng Bài, Hoàn Kiếm', N'Hà Nội', 'phongnt', 'pass123', 3000000.00, '2023-04-10'),
('ST006', N'Hà', N'Vũ Thu', '2002-11-03', N'Nữ', 'ha.vt@email.com', '0917778888', N'Số 5, Đường Láng Hạ, Ba Đình', N'Hà Nội', 'havt', 'pass123', 4500000.00, '2023-04-20'),
('ST007', N'Sơn', N'Đặng Bá', '1999-07-30', N'Nam', 'son.db@email.com', '0916669999', N'Số 18, Phố Huế, Hai Bà Trưng', N'Hà Nội', 'sondb', 'pass123', 9000000.00, '2023-05-01'),
('ST008', N'Thảo', N'Đỗ Phương', '2003-03-25', N'Nữ', 'thao.dp@email.com', '0915556666', N'Khu tập thể Thành Công, Ba Đình', N'Hà Nội', 'thaodp', 'pass123', 2500000.00, '2023-05-15'),
('ST009', N'Minh Anh', N'Phạm', '2002-09-10', N'Nữ', 'minhanh.p@email.com', '0933333333', N'Số 12, Đường Thanh Niên, Tây Hồ', N'Hà Nội', 'minhanhp', 'pass123', 6000000.00, '2023-06-01'),
('ST010', N'Khải', N'Trần Đăng', '2000-01-20', N'Nam', 'khai.td@email.com', '0922222222', N'Số 45, Phố Xã Đàn, Đống Đa', N'Hà Nội', 'khaitd', 'pass123', 3500000.00, '2023-06-10'),
('ST011', N'Ngọc', N'Lê Thị Bích', '2003-05-05', N'Nữ', 'ngoc.ltb@email.com', '0944444444', N'Số 100, Phố Hàng Gai, Hoàn Kiếm', N'Thành phố Hải Phòng', 'ngocltb', 'pass123', 5500000.00, '2023-07-01'),
('ST012', N'Tuấn Anh', N'Vũ', '2001-10-10', N'Nam', 'tuananh.v@email.com', '0955555555', N'Số 25, Đường Lê Hồng Phong', N'Thành phố Nam Định', 'tuananhv', 'pass123', 4000000.00, '2023-07-05'),
('ST013', N'Giang', N'Hoàng Thùy', '2002-07-14', N'Nữ', 'giang.ht@email.com', '0988777666', N'Số 24, Phố Lý Thái Tổ, Hoàn Kiếm', N'Hà Nội', 'gianght', 'pass123', 10000000.00, '2023-07-10'),
('ST014', N'Hiếu', N'Đinh Trung', '1999-01-08', N'Nam', 'hieu.dt@email.com', '0977888999', N'Số 99, Phố Nguyễn Khuyến, Đống Đa', N'Hà Nội', 'hieudt', 'pass123', 4000000.00, '2023-07-11'),
('ST015', N'Trang', N'Vũ Huyền', '2003-11-30', N'Nữ', 'trang.vh@email.com', '0966555444', N'Số 3, Ngõ 15, Phố Duy Tân, Cầu Giấy', N'Hà Nội', 'trangvh', 'pass123', 6000000.00, '2023-07-12'),
('ST016', N'Duy', N'Nguyễn Quang', '2004-06-20', N'Nam', 'duy.nq@email.com', '0955444333', N'Số 1, Đường Trần Phú', N'Thành phố Bắc Ninh', 'duynq', 'pass123', 3000000.00, '2023-07-13'),
('ST017', N'Hương', N'Bùi Thị', '2000-02-19', N'Nữ', 'huong.bt@email.com', '0944333222', N'Số 2, Phố Bạch Đằng', N'Thành phố Đà Nẵng', 'huongbt', 'pass123', 8000000.00, '2023-07-14'),
('ST018', N'Việt', N'Lý Hoàng', '1997-08-01', N'Nam', 'viet.lh@email.com', '0933222111', N'Số 88, Phố Hàng Bông, Hoàn Kiếm', N'Hà Nội', 'vietlh', 'pass123', 12000000.00, '2023-07-15'),
('ST019', N'Nga', N'Ngô Thị', '2003-10-02', N'Nữ', 'nga.nt@email.com', '0922111000', N'Số 11, Ngõ 19, Đường Lạc Long Quân, Tây Hồ', N'Hà Nội', 'ngant', 'pass123', 2000000.00, '2023-07-16'),
('ST020', N'Thành', N'Phạm Công', '2001-04-12', N'Nam', 'thanh.pc@email.com', '0911000111', N'Số 7, Phố Tràng Tiền, Hoàn Kiếm', N'Hà Nội', 'thanhpc', 'pass123', 5000000.00, '2023-07-17'),
('ST021', N'Yến', N'Nguyễn Hải', '2002-03-08', N'Nữ', 'yen.nh@email.com', '0912121212', N'Số 10, Phố Phan Chu Trinh, Hoàn Kiếm', N'Hà Nội', 'yennh', 'pass123', 7000000.00, '2023-08-01'),
('ST022', N'Bảo', N'Lý Quốc', '1999-06-15', N'Nam', 'bao.lq@email.com', '0913131313', N'Số 20, Đường Kim Mã, Ba Đình', N'Hà Nội', 'baolq', 'pass123', 15000000.00, '2023-08-02'),
('ST023', N'Chi', N'Đinh Thùy', '2004-01-01', N'Nữ', 'chi.dt@email.com', '0914141414', N'Số 30, Phố Đội Cấn, Ba Đình', N'Hà Nội', 'chidt', 'pass123', 5000000.00, '2023-08-03'),
('ST024', N'Đạt', N'Nguyễn Tiến', '2001-12-24', N'Nam', 'dat.nt@email.com', '0915151515', N'Số 40, Đường Láng, Đống Đa', N'Hà Nội', 'datnt', 'pass123', 4500000.00, '2023-08-04'),
('ST025', N'Oanh', N'Hoàng Kiều', '2002-08-30', N'Nữ', 'oanh.hk@email.com', '0916161616', N'Số 50, Phố Thái Thịnh, Đống Đa', N'Hà Nội', 'oanhhk', 'pass123', 8000000.00, '2023-08-05');
GO
INSERT INTO Course (id, description, tuition_fee, last_modified) VALUES
(N'GE_A1', N'Tiếng Anh Tổng quát - Trình độ A1 (Người mới bắt đầu)', 3500000.00, '2023-08-01 10:00:00'),
(N'GE_A2', N'Tiếng Anh Tổng quát - Trình độ A2 (Sơ cấp)', 3800000.00, '2023-08-01 10:02:00'),
(N'GE_B1', N'Tiếng Anh Tổng quát - Trình độ B1 (Trung cấp)', 4000000.00, '2023-08-01 10:05:00'),
(N'GE_B2', N'Tiếng Anh Tổng quát - Trình độ B2 (Trung-Cao cấp)', 4200000.00, '2023-08-01 10:07:00'),
(N'IELTS_55', N'Luyện thi IELTS Mục tiêu 5.0-5.5', 6000000.00, '2023-07-15 11:00:00'),
(N'IELTS_70', N'Luyện thi IELTS Mục tiêu 6.5-7.0+', 7500000.00, '2023-07-15 14:30:00'),
(N'TOEIC_B', N'Luyện thi TOEIC Cơ bản Mục tiêu 500+', 4500000.00, '2023-07-18 09:00:00'),
(N'TOEIC_A', N'Luyện thi TOEIC Nâng cao Mục tiêu 750+', 5500000.00, '2023-07-18 09:05:00'),
(N'BE_COM', N'Tiếng Anh Thương mại Giao tiếp', 4500000.00, '2023-07-20 09:00:00'),
(N'KIDS_ENG', N'Tiếng Anh Trẻ Em (6-10 tuổi)', 3000000.00, '2023-08-05 16:00:00'),
(N'AW_PRO', N'Viết Luận Học thuật Chuyên nghiệp (Academic Writing)', 5000000.00, '2023-08-06 11:00:00'),
(N'KIDS_ADV', N'Tiếng Anh Trẻ Em Nâng cao (11-14 tuổi)', 3200000.00, '2023-08-07 12:00:00');
GO
INSERT INTO Course_Material (id, course_id, description, material_type, material_url, date_add) VALUES
('CM001', N'GE_A1', N'English File Beginner Student Book 4th Ed.', N'Sách giáo trình', 'http://example.com/ef_beginner_sb.pdf', '2023-01-10'),
('CM002', N'GE_A1', N'English File Beginner Workbook 4th Ed.', N'Sách bài tập', 'http://example.com/ef_beginner_wb.pdf', '2023-01-12'),
('CM003', N'GE_A1', N'Audio CD cho English File Beginner', N'Tệp âm thanh', 'http://example.com/ef_beginner_audio.zip', '2023-01-10'),
('CM004', N'IELTS_70', N'Cambridge IELTS 18 Academic Student Book', N'Sách luyện đề', NULL, '2023-08-01'),
('CM005', N'IELTS_70', N'IELTS Vocabulary Advanced by Collins', N'Sách từ vựng', NULL, '2023-08-01'),
('CM006', N'IELTS_70', N'Tổng hợp bài mẫu IELTS Writing Task 2 Band 8+', N'Tài liệu tham khảo', 'http://example.com/ielts_writing_samples.pdf', '2023-08-05'),
('CM007', N'BE_COM', N'Market Leader Business English Intermediate Coursebook', N'Sách giáo trình', NULL, '2023-03-01'),
('CM008', N'BE_COM', N'Video Series: Negotiating in English', N'Video Links', 'http://example.com/negotiating_videos', '2023-03-05'),
('CM009', N'KIDS_ENG', N'Super Minds Starter Student Book', N'Sách giáo trình', NULL, '2023-08-10'),
('CM010', N'KIDS_ENG', N'Flashcards Từ vựng Tiếng Anh Trẻ Em', N'Học liệu', 'http://example.com/kids_flashcards.zip', '2023-08-10'),
('CM011', N'GE_B1', N'English File Intermediate Student Book 4th Ed.', N'Sách giáo trình', 'http://example.com/ef_intermediate_sb.pdf', '2023-01-20'),
('CM012', N'GE_B1', N'English File Intermediate Workbook 4th Ed.', N'Sách bài tập', 'http://example.com/ef_intermediate_wb.pdf', '2023-01-22'),
('CM013', N'AW_PRO', N'Academic Writing for Graduate Students', N'Sách giáo trình', NULL, '2023-08-11'),
('CM014', N'AW_PRO', N'APA & MLA Citation Guide', N'Tài liệu tham khảo', 'http://example.com/citation_guide.pdf', '2023-08-11'),
('CM015', N'IELTS_55', N'Cambridge IELTS 16 General Training', N'Sách luyện đề', NULL, '2023-08-12'),
('CM016', N'TOEIC_A', N'ETS TOEIC Test Official Prep Guide', N'Sách luyện đề', NULL, '2023-08-13');
GO
INSERT INTO Class (id, start_date, end_date, teacher_id, course_id, schedule_info, room_number) VALUES
(N'GEA1M1S23', '2023-09-04', '2023-12-22', 'TE003', N'GE_A1', N'Thứ 2-4-6, 18:00-19:30', N'P101'),
(N'GEA1T1S23', '2023-09-05', '2023-12-23', 'TE003', N'GE_A1', N'Thứ 3-5, 18:00-19:30', N'P102'),
(N'IELTS7S1S23', '2023-09-09', '2024-01-27', 'TE001', N'IELTS_70', N'Thứ 7, 09:00-12:00 & 13:30-16:30', N'P201'),
(N'IELTS7S2S23', '2023-09-10', '2024-01-28', 'TE001', N'IELTS_70', N'Chủ Nhật, 09:00-12:00 & 13:30-16:30', N'P202'),
(N'GEB1E1S23', '2023-09-05', '2023-12-23', 'TE002', N'GE_B1', N'Thứ 3-5, 19:45-21:15', N'P103'),
(N'BECOMW1S23', '2023-09-06', '2023-12-13', 'TE005', N'BE_COM', N'Thứ 4, 18:30-20:30', N'P203'),
(N'TOEICAS1S23', '2023-09-11', '2023-12-29', 'TE004', N'TOEIC_A', N'Thứ 2-4, 19:00-20:30', N'P301'),
(N'KIDSES1S23', '2023-09-16', '2023-12-23', 'TE003', N'KIDS_ENG', N'Thứ 7, 14:00-15:30', N'P104'),
(N'GEA2S1S23', '2023-09-12', '2023-12-30', 'TE002', N'GE_A2', N'Thứ 3-5, 17:00-18:30', N'P302'),
(N'IELTS55S1S23', '2023-09-13', '2024-01-20', 'TE008', N'IELTS_55', N'Thứ 4-6, 19:00-21:00', N'P303'),
(N'TOEICBS1S23', '2023-09-14', '2023-12-21', 'TE004', N'TOEIC_B', N'Thứ 5-7, 10:00-11:30', N'P304'),
(N'GEB2M1S23', '2023-09-04', '2023-12-22', 'TE009', N'GE_B2', N'Thứ 2-4, 19:45-21:15', N'P204'),
(N'AWPROS1S23', '2023-09-09', '2023-11-25', 'TE007', N'AW_PRO', N'Thứ 7, 10:00-12:00', N'P305'),
(N'IELTS7E1S23', '2023-09-11', '2024-01-29', 'TE001', N'IELTS_70', N'Thứ 2-4-6, 18:30-20:30', N'P201');
GO
INSERT INTO Class_Student (class_id, student_id, enrollment_date) VALUES
(N'IELTS7S1S23', 'ST001', '2023-08-20'), (N'GEB1E1S23', 'ST001', '2023-08-21'),
(N'GEA1M1S23', 'ST002', '2023-08-15'), (N'BECOMW1S23', 'ST002', '2023-08-22'),
(N'IELTS7S2S23', 'ST003', '2023-08-25'), (N'TOEICAS1S23', 'ST003', '2023-08-26'),
(N'IELTS7S1S23', 'ST004', '2023-08-21'), (N'GEA1T1S23', 'ST004', '2023-08-23'),
(N'GEA1M1S23', 'ST005', '2023-08-28'), (N'KIDSES1S23', 'ST005', '2023-08-29'),
(N'GEB1E1S23', 'ST006', '2023-08-30'),
(N'TOEICAS1S23', 'ST007', '2023-09-01'),
(N'BECOMW1S23', 'ST007', '2023-09-02'),
(N'IELTS7S1S23', 'ST008', '2023-09-03'),
(N'GEA1M1S23', 'ST008', '2023-09-04'),
(N'KIDSES1S23', 'ST009', '2023-09-05'),
(N'GEA2S1S23', 'ST010', '2023-09-06'),
(N'IELTS55S1S23', 'ST011', '2023-09-07'),
(N'TOEICBS1S23', 'ST012', '2023-09-08'),
(N'AWPROS1S23', 'ST013', '2023-09-01'), (N'IELTS7E1S23', 'ST013', '2023-09-02'),
(N'GEB2M1S23', 'ST014', '2023-09-03'), (N'BECOMW1S23', 'ST014', '2023-09-04'),
(N'IELTS7S1S23', 'ST015', '2023-09-05'),
(N'GEA1M1S23', 'ST016', '2023-09-06'),
(N'GEB1E1S23', 'ST017', '2023-09-07'),
(N'AWPROS1S23', 'ST018', '2023-09-08'),
(N'GEA2S1S23', 'ST019', '2023-09-09'),
(N'TOEICAS1S23', 'ST020', '2023-09-10'),
(N'GEB2M1S23', 'ST021', '2023-09-11'),
(N'IELTS7E1S23', 'ST022', '2023-09-12'),
(N'KIDSES1S23', 'ST023', '2023-09-13'),
(N'IELTS7S1S23', 'ST024', '2023-09-14'),
(N'GEB1E1S23', 'ST025', '2023-09-15');
GO
INSERT INTO Exam (id, date, description, class_id, exam_type, duration_minutes) VALUES
('EX001', '2023-10-16', N'Kiểm tra giữa kỳ GE A1 (Lớp T2-4-6)', N'GEA1M1S23', N'Midterm', 60),
('EX002', '2023-10-17', N'Kiểm tra giữa kỳ GE A1 (Lớp T3-5)', N'GEA1T1S23', N'Midterm', 60),
('EX003', '2023-11-20', N'Thi thử IELTS Mock Test 1 (Lớp T7)', N'IELTS7S1S23', N'Mock Test', 180),
('EX004', '2023-11-21', N'Thi thử IELTS Mock Test 1 (Lớp CN)', N'IELTS7S2S23', N'Mock Test', 180),
('EX005', '2023-10-30', N'Kiểm tra từ vựng Tiếng Anh Thương mại', N'BECOMW1S23', N'Quiz', 45),
('EX006', '2023-12-10', N'Thi cuối kỳ GE A1 (Lớp T2-4-6)', N'GEA1M1S23', N'Final', 90),
('EX007', '2023-12-11', N'Thi cuối kỳ GE A1 (Lớp T3-5)', N'GEA1T1S23', N'Final', 90),
('EX008', '2024-01-15', N'Thi thử IELTS Mock Test 2 (Lớp T7)', N'IELTS7S1S23', N'Mock Test', 180),
('EX009', '2023-11-25', N'Kiểm tra giữa kỳ TOEIC Nâng cao', N'TOEICAS1S23', N'Midterm', 120),
('EX010', '2023-11-10', N'Kiểm tra Nói Tiếng Anh Trẻ Em', N'KIDSES1S23', N'Speaking Test', 15),
('EX011', '2023-10-18', N'Kiểm tra giữa kỳ GE B1', N'GEB1E1S23', N'Midterm', 60),
('EX012', '2023-10-25', N'Kiểm tra giữa kỳ Academic Writing', N'AWPROS1S23', N'Midterm', 90),
('EX013', '2023-12-15', N'Thi cuối kỳ Academic Writing', N'AWPROS1S23', N'Final', 120),
('EX014', '2023-12-20', N'Thi cuối kỳ TOEIC Nâng cao', N'TOEICAS1S23', N'Final', 120),
('EX015', '2024-01-20', N'Thi cuối kỳ IELTS Mock Test 3 (Lớp T7)', N'IELTS7S1S23', N'Final', 180);
GO
INSERT INTO Grade (id, value, student_id, exam_id, class_id, date) VALUES
('GR001', 6.00, 'ST001', 'EX003', N'IELTS7S1S23', '2023-11-27'),
('GR002', 7.00, 'ST001', 'EX011', N'GEB1E1S23', '2023-10-25'),
('GR003', 7.50, 'ST002', 'EX001', N'GEA1M1S23', '2023-10-23'),
('GR004', 8.80, 'ST002', 'EX005', N'BECOMW1S23', '2023-11-06'),
('GR005', 8.00, 'ST004', 'EX003', N'IELTS7S1S23', '2023-11-27'),
('GR006', 8.50, 'ST004', 'EX002', N'GEA1T1S23', '2023-10-24'),
('GR007', 6.50, 'ST001', 'EX008', N'IELTS7S1S23', '2024-01-22'),
('GR008', 9.00, 'ST002', 'EX006', N'GEA1M1S23', '2023-12-18'),
('GR009', 7.50, 'ST007', 'EX009', N'TOEICAS1S23', '2023-12-02'),
('GR010', 9.00, 'ST009', 'EX010', N'KIDSES1S23', '2023-11-17'),
('GR011', 7.50, 'ST006', 'EX011', N'GEB1E1S23', '2023-10-25'),
('GR012', 8.20, 'ST007', 'EX005', N'BECOMW1S23', '2023-11-06'),
('GR013', 7.00, 'ST008', 'EX003', N'IELTS7S1S23', '2023-11-27'),
('GR014', 8.00, 'ST008', 'EX001', N'GEA1M1S23', '2023-10-23'),
('GR015', 8.50, 'ST014', 'EX005', N'BECOMW1S23', '2023-11-06'),
('GR016', 7.50, 'ST013', 'EX008', N'IELTS7E1S23', '2024-01-22'),
('GR017', 8.00, 'ST013', 'EX012', N'AWPROS1S23', '2023-11-01'),
('GR018', 8.50, 'ST018', 'EX012', N'AWPROS1S23', '2023-11-01'),
('GR019', 9.00, 'ST020', 'EX009', N'TOEICAS1S23', '2023-12-02'),
('GR020', 7.50, 'ST022', 'EX008', N'IELTS7E1S23', '2024-01-22'),
('GR021', 8.50, 'ST025', 'EX011', N'GEB1E1S23', '2023-10-25'),
('GR022', 7.00, 'ST015', 'EX003', N'IELTS7S1S23', '2023-11-28'),
('GR023', 9.50, 'ST024', 'EX003', N'IELTS7S1S23', '2023-11-28'),
('GR024', 9.00, 'ST023', 'EX010', N'KIDSES1S23', '2023-11-17');
GO

-- ===================================================================
-- 9. DATA PROCESSING
-- ===================================================================
PRINT 'Processing sample payments...';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA001', @StudentID = 'ST001', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA002', @StudentID = 'ST001', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA003', @StudentID = 'ST004', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA004', @StudentID = 'ST002', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA005', @StudentID = 'ST003', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA006', @StudentID = 'ST007', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA007', @StudentID = 'ST009', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA008', @StudentID = 'ST011', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA009', @StudentID = 'ST013', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA010', @StudentID = 'ST017', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA011', @StudentID = 'ST018', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA012', @StudentID = 'ST022', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA013', @StudentID = 'ST014', @CourseID = N'GE_B2', @PaymentAmount = 4200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA014', @StudentID = 'ST025', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA015', @StudentID = 'ST003', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
GO

-- ===================================================================
-- 10. DEMONSTRATION OF COMPLEX QUERIES
-- ===================================================================
PRINT N'--- DEMONSTRATION QUERY 1: Tìm các trường hợp học viên đã thanh toán nhưng chưa được xếp lớp ---';
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

PRINT N'--- DEMONSTRATION QUERY 2: Báo cáo hiệu suất học tập của học viên trong khóa học IELTS_70 ---';
WITH StudentGradesInCourse AS (
    SELECT cs.student_id, g.value
    FROM Class_Student cs
    JOIN Class cl ON cs.class_id = cl.id
    JOIN Exam e ON cl.id = e.class_id
    JOIN Grade g ON e.id = g.exam_id AND cs.student_id = g.student_id
    WHERE cl.course_id = N'IELTS_70'
)
SELECT s.last_name + N' ' + s.first_name AS StudentFullName,
       AVG(sg.value) AS AverageScore, MAX(sg.value) AS HighestScore, MIN(sg.value) AS LowestScore
FROM StudentGradesInCourse sg
JOIN Student s ON sg.student_id = s.id
GROUP BY s.id, s.first_name, s.last_name
ORDER BY AverageScore DESC;
GO

PRINT N'--- DEMONSTRATION QUERY 3: Tìm các Lớp học có cùng Giáo viên ---';
SELECT
    t.last_name + N' ' + t.first_name AS TeacherFullName,
    c1.id AS ClassID_1,
    c2.id AS ClassID_2
FROM Class c1
JOIN Class c2 ON c1.teacher_id = c2.teacher_id
JOIN Teacher t ON c1.teacher_id = t.id
WHERE c1.id < c2.id AND c1.teacher_id IS NOT NULL;
GO

PRINT N'--- DEMONSTRATION QUERY 4: Top 5 lớp học có điểm trung bình cao nhất và thấp nhất ---';
WITH A AS (SELECT TOP 5
    cl.id AS ClassID, co.description AS CourseDescription, t.last_name + N' ' + t.first_name AS TeacherFullName,
    AVG(g.value) AS AverageGrade, N'Điểm cao nhất' AS RankType
 FROM Grade g
 JOIN Exam e ON g.exam_id = e.id JOIN Class cl ON e.class_id = cl.id
 JOIN Course co ON cl.course_id = co.id LEFT JOIN Teacher t ON cl.teacher_id = t.id
 GROUP BY cl.id, co.description, t.last_name, t.first_name ORDER BY AverageGrade DESC),
B AS (SELECT TOP 5
    cl.id AS ClassID, co.description AS CourseDescription, t.last_name + N' ' + t.first_name AS TeacherFullName,
    AVG(g.value) AS AverageGrade, N'Điểm thấp nhất' AS RankType
 FROM Grade g
 JOIN Exam e ON g.exam_id = e.id JOIN Class cl ON e.class_id = cl.id
 JOIN Course co ON cl.course_id = co.id LEFT JOIN Teacher t ON cl.teacher_id = t.id
 GROUP BY cl.id, co.description, t.last_name, t.first_name
 ORDER BY AverageGrade ASC)

SELECT * FROM A UNION ALL SELECT * FROM B
GO


-- 11. FINAL VERIFICATION
PRINT '--- Verifying All Data After Processing ---';
PRINT '--- Teacher Data ---'; SELECT * FROM Teacher ORDER BY id;
PRINT '--- Student Data ---'; SELECT * FROM Student ORDER BY id;
PRINT '--- Course Data ---';  SELECT * FROM Course ORDER BY id;
PRINT '--- Class Data ---'; SELECT * FROM Class ORDER BY course_id, id;
PRINT '--- Class_Student Data ---'; SELECT * FROM Class_Student ORDER BY class_id, student_id;
PRINT '--- Exam Data ---'; SELECT * FROM Exam ORDER BY class_id, date;
PRINT '--- Grade Data ---'; SELECT * FROM Grade ORDER BY student_id, exam_id;
PRINT '--- Payment Data ---'; SELECT * FROM Payment ORDER BY student_id, payment_date;
PRINT '--- Audit Log Data ---'; SELECT * FROM AuditLog ORDER BY LogID;
GO

PRINT '*** Script execution completed successfully. ***';
GO
