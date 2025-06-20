﻿-- Use an existing database or create one if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'EducateDB')
BEGIN
    CREATE DATABASE EducateDB;
END
GO

USE EducateDB;
GO

-- Drop existing objects in reverse order of dependency for clean re-runs
IF OBJECT_ID('usp_ProcessCoursePayment', 'P') IS NOT NULL
    DROP PROCEDURE usp_ProcessCoursePayment;
IF OBJECT_ID('Grade', 'U') IS NOT NULL DROP TABLE Grade;
IF OBJECT_ID('Payment', 'U') IS NOT NULL DROP TABLE Payment;
IF OBJECT_ID('Exam', 'U') IS NOT NULL DROP TABLE Exam;
IF OBJECT_ID('Class_Student', 'U') IS NOT NULL DROP TABLE Class_Student;
IF OBJECT_ID('Course_Material', 'U') IS NOT NULL DROP TABLE Course_Material;
IF OBJECT_ID('Class', 'U') IS NOT NULL DROP TABLE Class;
IF OBJECT_ID('Course', 'U') IS NOT NULL DROP TABLE Course;
IF OBJECT_ID('Student', 'U') IS NOT NULL DROP TABLE Student;
IF OBJECT_ID('Teacher', 'U') IS NOT NULL DROP TABLE Teacher;
GO

-- Create Tables (Schema from previous version - no changes here)
CREATE TABLE Teacher (
    id VARCHAR(5) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_birth DATE,
    gender NVARCHAR(3) CHECK (gender IN (N'Nam', N'Nữ')),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address NVARCHAR(255),
    city NVARCHAR(50),
    description NVARCHAR(255),
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL -- Store HASHED passwords in a real application!
);
GO
CREATE TABLE Student (
    id VARCHAR(5) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_birth DATE,
    gender NVARCHAR(3) CHECK (gender IN (N'Nam', N'Nữ')),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address NVARCHAR(255),
    city NVARCHAR(50),
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    balance DECIMAL(12,2),
    created_date DATE
);
GO
CREATE TABLE Course (
    id NVARCHAR(50) PRIMARY KEY,
    description NVARCHAR(MAX),
    last_modified DATETIME2,
    tuition_fee DECIMAL(12,2)
);
GO
CREATE TABLE Course_Material (
    id VARCHAR(5) PRIMARY KEY,
    course_id NVARCHAR(50) NOT NULL,
    description NVARCHAR(MAX),
    material_type NVARCHAR(50),
    material_url VARCHAR(255),
    date_add DATE,
    FOREIGN KEY (course_id) REFERENCES Course(id)
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
    FOREIGN KEY (course_id) REFERENCES Course(id)
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
    FOREIGN KEY (class_id) REFERENCES Class(id)
);
GO
CREATE TABLE Grade (
    id VARCHAR(5) PRIMARY KEY,
    value DECIMAL(5,2) NOT NULL,
    student_id VARCHAR(5) NOT NULL,
    exam_id VARCHAR(5) NOT NULL,
    class_id NVARCHAR(20),
    date DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (exam_id) REFERENCES Exam(id),
    FOREIGN KEY (class_id) REFERENCES Class(id)
);
GO
CREATE TABLE Payment (
    id VARCHAR(5) PRIMARY KEY,
    payment_date DATE,
    amount DECIMAL(12,2) NOT NULL,
    status NVARCHAR(20) NOT NULL CHECK (status IN (N'Success', N'Failed')),
    student_id VARCHAR(5) NOT NULL,
    course_id NVARCHAR(50) NOT NULL,
    payment_method NVARCHAR(50),
    notes NVARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id)
);
GO

-- Simplified Stored Procedure for Processing Payments
CREATE PROCEDURE usp_ProcessCoursePayment
    @PaymentID VARCHAR(5),
    @StudentID VARCHAR(5),
    @CourseID NVARCHAR(50),
    @PaymentAmount DECIMAL(12,2),
    @PaymentMethod NVARCHAR(50) = NULL,
    @TransactionNotes NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StudentBalance DECIMAL(12,2);
    DECLARE @CourseTuition DECIMAL(12,2);
    DECLARE @PaymentStatus NVARCHAR(20);
    DECLARE @CurrentPaymentDate DATE = GETDATE();

    SELECT @StudentBalance = balance FROM Student WHERE id = @StudentID;
    SELECT @CourseTuition = tuition_fee FROM Course WHERE id = @CourseID;

    IF @StudentBalance IS NULL OR @CourseTuition IS NULL
    BEGIN
        SET @PaymentStatus = N'Failed';
        SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Lỗi: Sinh viên hoặc Khóa học không hợp lệ.';
        INSERT INTO Payment (id, payment_date, amount, status, student_id, course_id, payment_method, notes)
        VALUES (@PaymentID, @CurrentPaymentDate, @PaymentAmount, @PaymentStatus, @StudentID, @CourseID, @PaymentMethod, @TransactionNotes);
        PRINT N'Thanh toán thất bại: Sinh viên hoặc Khóa học không hợp lệ.';
        RETURN;
    END

    IF @PaymentAmount = @CourseTuition AND @StudentBalance >= @PaymentAmount
    BEGIN
        SET @PaymentStatus = N'Success';
        UPDATE Student SET balance = balance - @PaymentAmount WHERE id = @StudentID;
        SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Thanh toán thành công. Số dư đã cập nhật.';
    END
    ELSE IF @StudentBalance < @PaymentAmount
    BEGIN
        SET @PaymentStatus = N'Failed';
        SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Lý do: Số dư không đủ.';
    END
    ELSE 
    BEGIN
        SET @PaymentStatus = N'Failed';
        SET @TransactionNotes = ISNULL(@TransactionNotes + N'; ', N'') + N'Lý do: Số tiền thanh toán không khớp học phí.';
    END

    INSERT INTO Payment (id, payment_date, amount, status, student_id, course_id, payment_method, notes)
    VALUES (@PaymentID, @CurrentPaymentDate, @PaymentAmount, @PaymentStatus, @StudentID, @CourseID, @PaymentMethod, @TransactionNotes);

    IF @PaymentStatus = N'Success'
        PRINT N'Thanh toán ' + @PaymentID + N' thành công cho sinh viên ' + @StudentID + N' khóa học ' + @CourseID;
    ELSE
        PRINT N'Thanh toán ' + @PaymentID + N' thất bại cho sinh viên ' + @StudentID + N' khóa học ' + @CourseID + N'. Lý do: ' + @TransactionNotes;
END
GO

-- Insert Expanded Sample Data
INSERT INTO Teacher (id, first_name, last_name, date_birth, gender, email, phone, address, city, description, user_name, password)
VALUES
('TE001', N'Mai', N'Nguyễn Thị Lan', '1985-03-12', N'Nữ', 'mai.ntl@educenter.vn', '0912345678', N'Số 10, Ngõ 25, Phố Vạn Bảo, Ba Đình', N'Hà Nội', N'Giáo viên IELTS (8.5), 10 năm kinh nghiệm', 'maintl', 'pass123'),
('TE002', N'David', N'Smith', '1978-07-20', N'Nam', 'david.smith@educenter.vn', '0987654321', N'P201, Tòa nhà A, Times City, Hai Bà Trưng', N'Hà Nội', N'Giáo viên bản ngữ (Mỹ), chuyên Phát âm & Giao tiếp', 'davids', 'pass123'),
('TE003', N'Hùng', N'Trần Mạnh', '1990-11-05', N'Nam', 'hung.tm@educenter.vn', '0903334444', N'Số 55, Phố Chùa Láng, Đống Đa', N'Hà Nội', N'Giáo viên Tiếng Anh Trẻ em, TESOL certified', 'hungtm', 'pass123'),
('TE004', N'Phương', N'Lê Thu', '1982-06-25', N'Nữ', 'phuong.lt@educenter.vn', '0901112222', N'Số 8, Ngách 10, Đường Xuân Thủy, Cầu Giấy', N'Hà Nội', N'Chuyên luyện thi TOEIC, cựu giám khảo', 'phuonglt', 'pass123'),
('TE005', N'John', N'Baker', '1980-09-17', N'Nam', 'john.baker@educenter.vn', '0902223333', N'Số 12, Phố Lý Thường Kiệt, Hoàn Kiếm', N'Hà Nội', N'Giáo viên bản ngữ (Anh), Tiếng Anh Kinh doanh', 'johnb', 'pass123');
GO

INSERT INTO Student (id, first_name, last_name, date_birth, gender, email, phone, address, city, user_name, password, balance, created_date)
VALUES
('ST001', N'Quân', N'Hoàng Minh', '2000-04-10', N'Nam', 'quan.hm@email.com', '0988123456', N'Số 15, Phố Trần Hưng Đạo, Hoàn Kiếm', N'Hà Nội', 'quanhm', 'pass123', 5000000.00, '2023-01-15'),
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
('ST012', N'Tuấn Anh', N'Vũ', '2001-10-10', N'Nam', 'tuananh.v@email.com', '0955555555', N'Số 25, Đường Lê Hồng Phong', N'Thành phố Nam Định', 'tuananhv', 'pass123', 4000000.00, '2023-07-05');
GO

INSERT INTO Course (id, description, tuition_fee, last_modified)
VALUES
(N'GE_A1', N'Tiếng Anh Tổng quát - Trình độ A1 (Người mới bắt đầu)', 3500000.00, '2023-08-01 10:00:00'),
(N'GE_A2', N'Tiếng Anh Tổng quát - Trình độ A2 (Sơ cấp)', 3800000.00, '2023-08-01 10:02:00'),
(N'GE_B1', N'Tiếng Anh Tổng quát - Trình độ B1 (Trung cấp)', 4000000.00, '2023-08-01 10:05:00'),
(N'IELTS_55', N'Luyện thi IELTS Mục tiêu 5.0-5.5', 6000000.00, '2023-07-15 11:00:00'),
(N'IELTS_70', N'Luyện thi IELTS Mục tiêu 6.5-7.0+', 7500000.00, '2023-07-15 14:30:00'),
(N'TOEIC_B', N'Luyện thi TOEIC Cơ bản Mục tiêu 500+', 4500000.00, '2023-07-18 09:00:00'),
(N'TOEIC_A', N'Luyện thi TOEIC Nâng cao Mục tiêu 750+', 5500000.00, '2023-07-18 09:05:00'),
(N'BE_COM', N'Tiếng Anh Thương mại Giao tiếp', 4500000.00, '2023-07-20 09:00:00'),
(N'KIDS_ENG', N'Tiếng Anh Trẻ Em (6-10 tuổi)', 3000000.00, '2023-08-05 16:00:00');
GO

INSERT INTO Course_Material (id, course_id, description, material_type, material_url, date_add)
VALUES
('CM001', N'GE_A1', N'English File Beginner Student Book 4th Ed.', N'Sách giáo trình', 'http://example.com/ef_beginner_sb.pdf', '2023-01-10'),
('CM002', N'GE_A1', N'English File Beginner Workbook 4th Ed.', N'Sách bài tập', 'http://example.com/ef_beginner_wb.pdf', '2023-01-12'),
('CM003', N'GE_A1', N'Audio CD cho English File Beginner', N'Tệp âm thanh', 'http://example.com/ef_beginner_audio.zip', '2023-01-10'),
('CM004', N'IELTS_70', N'Cambridge IELTS 18 Academic Student Book', N'Sách luyện đề', NULL, '2023-08-01'),
('CM005', N'IELTS_70', N'IELTS Vocabulary Advanced by Collins', N'Sách từ vựng', NULL, '2023-08-01'),
('CM006', N'IELTS_70', N'Tổng hợp bài mẫu IELTS Writing Task 2 Band 8+', N'Tài liệu tham khảo', 'http://example.com/ielts_writing_samples.pdf', '2023-08-05'),
('CM007', N'BE_COM', N'Market Leader Business English Intermediate Coursebook', N'Sách giáo trình', NULL, '2023-03-01'),
('CM008', N'BE_COM', N'Business Email Etiquette Guide', N'Tài liệu bổ trợ', 'http://example.com/email_etiquette.pdf', '2023-03-01'),
('CM009', N'KIDS_ENG', N'Super Minds Starter Student Book', N'Sách giáo trình', NULL, '2023-08-10'),
('CM010', N'KIDS_ENG', N'Flashcards Từ vựng Tiếng Anh Trẻ Em', N'Học liệu', 'http://example.com/kids_flashcards.zip', '2023-08-10'),
('CM011', N'GE_B1', N'English File Intermediate Student Book 4th Ed.', N'Sách giáo trình', 'http://example.com/ef_intermediate_sb.pdf', '2023-01-20'),
('CM012', N'GE_B1', N'English File Intermediate Workbook 4th Ed.', N'Sách bài tập', 'http://example.com/ef_intermediate_wb.pdf', '2023-01-22');
GO
INSERT INTO Class (id, start_date, end_date, teacher_id, course_id, schedule_info, room_number)
VALUES
(N'GEA1M1S23', '2023-09-04', '2023-12-22', 'TE003', N'GE_A1', N'Thứ 2-4-6, 18:00-19:30', N'P101'),
(N'GEA1T1S23', '2023-09-05', '2023-12-23', 'TE003', N'GE_A1', N'Thứ 3-5, 18:00-19:30', N'P102'),
(N'IELTS7S1S23', '2023-09-09', '2024-01-27', 'TE001', N'IELTS_70', N'Thứ 7, 09:00-12:00 & 13:30-16:30', N'P201'),
(N'IELTS7S2S23', '2023-09-10', '2024-01-28', 'TE001', N'IELTS_70', N'Chủ Nhật, 09:00-12:00 & 13:30-16:30', N'P202'),
(N'GEB1E1S23', '2023-09-05', '2023-12-23', 'TE002', N'GE_B1', N'Thứ 3-5, 19:45-21:15', N'P103'),
(N'BECOMW1S23', '2023-09-06', '2023-12-13', 'TE005', N'BE_COM', N'Thứ 4, 18:30-20:30', N'P203'),
(N'TOEICAS1S23', '2023-09-11', '2023-12-29', 'TE004', N'TOEIC_A', N'Thứ 2-4, 19:00-20:30', N'P301'),
(N'KIDSES1S23', '2023-09-16', '2023-12-23', 'TE003', N'KIDS_ENG', N'Thứ 7, 14:00-15:30', N'P104'),
-- Added Classes for the missing course enrollments:
(N'GEA2S1S23', '2023-09-12', '2023-12-30', 'TE002', N'GE_A2', N'Thứ 3-5, 17:00-18:30', N'P302'),        -- Class for GE_A2
(N'IELTS55S1S23', '2023-09-13', '2024-01-20', 'TE001', N'IELTS_55', N'Thứ 4-6, 19:00-21:00', N'P303'), -- Class for IELTS_55
(N'TOEICBS1S23', '2023-09-14', '2023-12-21', 'TE004', N'TOEIC_B', N'Thứ 5-7, 10:00-11:30', N'P304');   -- Class for TOEIC_B
GO

-- CORRECTED Class_Student Enrollments (Now using existing class IDs)
INSERT INTO Class_Student (class_id, student_id, enrollment_date)
VALUES
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
(N'GEA2S1S23', 'ST010', '2023-09-06'),   -- Corrected to use existing class_id
(N'IELTS55S1S23', 'ST011', '2023-09-07'),-- Corrected to use existing class_id
(N'TOEICBS1S23', 'ST012', '2023-09-08'); -- Corrected to use existing class_id
GO

INSERT INTO Exam (id, date, description, class_id, exam_type, duration_minutes)
VALUES
('EX001', '2023-10-16', N'Kiểm tra giữa kỳ GE A1 (Lớp T2-4-6)', N'GEA1M1S23', N'Midterm', 60),
('EX002', '2023-10-17', N'Kiểm tra giữa kỳ GE A1 (Lớp T3-5)', N'GEA1T1S23', N'Midterm', 60),
('EX003', '2023-11-20', N'Thi thử IELTS Mock Test 1 (Lớp T7)', N'IELTS7S1S23', N'Mock Test', 180),
('EX004', '2023-11-21', N'Thi thử IELTS Mock Test 1 (Lớp CN)', N'IELTS7S2S23', N'Mock Test', 180),
('EX005', '2023-10-30', N'Kiểm tra từ vựng Tiếng Anh Thương mại', N'BECOMW1S23', N'Quiz', 45),
('EX006', '2023-12-10', N'Thi cuối kỳ GE A1 (Lớp T2-4-6)', N'GEA1M1S23', N'Final', 90),
('EX007', '2023-12-11', N'Thi cuối kỳ GE A1 (Lớp T3-5)', N'GEA1T1S23', N'Final', 90),
('EX008', '2024-01-15', N'Thi thật IELTS (Lớp T7)', N'IELTS7S1S23', N'Official IELTS', 180),
('EX009', '2023-11-25', N'Kiểm tra giữa kỳ TOEIC Nâng cao', N'TOEICAS1S23', N'Midterm', 120),
('EX010', '2023-11-10', N'Kiểm tra Nói Tiếng Anh Trẻ Em', N'KIDSES1S23', N'Speaking Test', 15);
GO

INSERT INTO Grade (id, value, student_id, exam_id, class_id, date)
VALUES
('GR001', 6.0, 'ST001', 'EX003', N'IELTS7S1S23', '2023-11-27'),
('GR002', 7.0, 'ST001', 'EX001', N'GEA1M1S23', '2023-10-23'),
('GR003', 7.5, 'ST002', 'EX001', N'GEA1M1S23', '2023-10-23'),
('GR004', 88.0, 'ST002', 'EX005', N'BECOMW1S23', '2023-11-06'),
('GR005', 8.0, 'ST004', 'EX003', N'IELTS7S1S23', '2023-11-27'),
('GR006', 8.5, 'ST004', 'EX002', N'GEA1T1S23', '2023-10-24'),
('GR007', 6.5, 'ST001', 'EX008', N'IELTS7S1S23', '2024-01-25'), -- Quân's official IELTS
('GR008', 9.0, 'ST002', 'EX006', N'GEA1M1S23', '2023-12-18'), -- Linh's GEA1 Final
('GR009', 750.0, 'ST007', 'EX009', N'TOEICAS1S23', '2023-12-02'), -- Sơn's TOEIC Midterm
('GR010', 90.0, 'ST009', 'EX010', N'KIDSES1S23', '2023-11-17'); -- Minh Anh's Kids Speaking
GO

-- Sample Payment Processing using Stored Procedure
-- Re-check initial balances if needed:
-- ST001: 5M, ST002: 4M, ST003: 1M, ST004: 7M, ST005: 3M, ST006: 4.5M, ST007: 9M, ST008: 2.5M, ST009: 6M, ST010: 3.5M, ST011: 5.5M, ST012: 4M

EXEC usp_ProcessCoursePayment @PaymentID = 'PA001', @StudentID = 'ST001', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản', @TransactionNotes = N'Học phí IELTS 7.0+'; -- Fails
EXEC usp_ProcessCoursePayment @PaymentID = 'PA002', @StudentID = 'ST001', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt', @TransactionNotes = N'Học phí GE B1'; -- Success (ST001 Bal: 1M)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA003', @StudentID = 'ST004', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng', @TransactionNotes = N'Học phí IELTS 7.0+'; -- Success (ST004 Bal: 0)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA004', @StudentID = 'ST002', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Chuyển khoản', @TransactionNotes = N'Học phí GE A1'; -- Success (ST002 Bal: 0.5M)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA005', @StudentID = 'ST003', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Momo', @TransactionNotes = N'Học phí Tiếng Anh TM'; -- Fails
EXEC usp_ProcessCoursePayment @PaymentID = 'PA006', @StudentID = 'ST007', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản', @TransactionNotes = N'Học phí TOEIC Nâng cao'; -- Success (ST007 Bal: 3.5M)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA007', @StudentID = 'ST009', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Tiền mặt', @TransactionNotes = N'Học phí Tiếng Anh Trẻ Em'; -- Success (ST009 Bal: 3M)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA008', @StudentID = 'ST011', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Thẻ tín dụng', @TransactionNotes = N'Học phí IELTS 5.5'; -- Fails
GO

-- Display data to verify all tables
PRINT '--- Teacher Data ---'; SELECT * FROM Teacher ORDER BY id;
PRINT '--- Student Data ---'; SELECT * FROM Student ORDER BY id;
PRINT '--- Course Data ---';  SELECT * FROM Course ORDER BY id;
PRINT '--- Course_Material Data ---'; SELECT * FROM Course_Material ORDER BY course_id, id;
PRINT '--- Class Data ---'; SELECT * FROM Class ORDER BY course_id, id;
PRINT '--- Class_Student Data ---'; SELECT * FROM Class_Student ORDER BY class_id, student_id;
PRINT '--- Exam Data ---'; SELECT * FROM Exam ORDER BY class_id, date;
PRINT '--- Grade Data ---'; SELECT * FROM Grade ORDER BY student_id, exam_id;
PRINT '--- Payment Data ---'; SELECT * FROM Payment ORDER BY student_id, payment_date;
GO

PRINT '*** Script execution completed. ***'