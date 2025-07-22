-- Setup DB
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'EducateDB')
BEGIN
    CREATE DATABASE EducateDB
END
GO

USE EducateDB
GO

IF OBJECT_ID('Exam_Result', 'U') IS NOT NULL DROP TABLE Exam_Result
IF OBJECT_ID('Payment', 'U') IS NOT NULL DROP TABLE Payment
IF OBJECT_ID('Exam', 'U') IS NOT NULL DROP TABLE Exam
IF OBJECT_ID('Class_Student', 'U') IS NOT NULL DROP TABLE Class_Student
IF OBJECT_ID('Course_Material', 'U') IS NOT NULL DROP TABLE Course_Material
IF OBJECT_ID('Class', 'U') IS NOT NULL DROP TABLE Class
IF OBJECT_ID('Course', 'U') IS NOT NULL DROP TABLE Course
IF OBJECT_ID('AuditLog', 'U') IS NOT NULL DROP TABLE AuditLog
IF OBJECT_ID('Student', 'U') IS NOT NULL DROP TABLE Student
IF OBJECT_ID('Teacher', 'U') IS NOT NULL DROP TABLE Teacher
GO


-- TABLE CREATION

CREATE TABLE Teacher (
    id VARCHAR(5) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(128) NOT NULL, -- Will store the HASH as a string
    date_birth DATE, 
	gender NVARCHAR(3),
	email VARCHAR(100) UNIQUE NOT NULL, 
	phone VARCHAR(20), 
	address NVARCHAR(255),
	city NVARCHAR(50), 
	description NVARCHAR(255),
	CONSTRAINT CK_Teacher_ID CHECK (id LIKE 'TE[0-9][0-9][0-9]'),
    CONSTRAINT CK_Teacher_Gender CHECK (gender IN (N'Nam', N'Nữ')),
    CONSTRAINT CK_Teacher_Email CHECK (email LIKE '%_@__%.__%')
)
GO

CREATE TABLE Student (
    id VARCHAR(5) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(128) NOT NULL, -- Will store the HASH as a string
    date_birth DATE,
	gender NVARCHAR(3),
	email VARCHAR(100) UNIQUE NOT NULL, 
	phone VARCHAR(20), 
	address NVARCHAR(255), 
	city NVARCHAR(50), 
	balance DECIMAL(12,2),
	created_date DATE,
	CONSTRAINT CK_Student_ID CHECK (id LIKE 'ST[0-9][0-9][0-9]'),
    CONSTRAINT CK_Student_Gender CHECK (gender IN (N'Nam', N'Nữ')),
    CONSTRAINT CK_Student_Email CHECK (email LIKE '%_@__%.__%'),
    CONSTRAINT CK_Student_Balance CHECK (balance >= 0))


CREATE TABLE Course (
    id NVARCHAR(50) PRIMARY KEY,
    description NVARCHAR(MAX),
    last_modified DATETIME2
)
GO

CREATE TABLE Class (
    id NVARCHAR(20) PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    teacher_id VARCHAR(5),
    course_id NVARCHAR(50) NOT NULL,
    schedule_info NVARCHAR(100),
    room_number NVARCHAR(20),
    tuition_fee DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(id),
    FOREIGN KEY (course_id) REFERENCES Course(id),
    CONSTRAINT CK_Class_Dates CHECK (end_date >= start_date),
    CONSTRAINT CK_Class_RoomNumber CHECK (room_number LIKE 'P[1-3][0-9][0-9]'),
    CONSTRAINT CK_Class_TuitionFee CHECK (tuition_fee >= 0)
)
GO

CREATE TABLE Payment (
    id VARCHAR(5) PRIMARY KEY,
    payment_date DATE,
    amount DECIMAL(12,2) NOT NULL,
    status NVARCHAR(20) NOT NULL,
    student_id VARCHAR(5) NOT NULL,
    class_id NVARCHAR(20) NOT NULL,
    payment_method NVARCHAR(50),
    notes NVARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (class_id) REFERENCES Class(id),
    CONSTRAINT CK_Payment_ID CHECK (id LIKE 'PA[0-9][0-9][0-9]' OR id LIKE 'PTEST[0-9]'), 
    CONSTRAINT CK_Payment_Amount CHECK (amount > 0),
    CONSTRAINT CK_Payment_Status CHECK (status IN (N'Success', N'Failed')),
    CONSTRAINT CK_Payment_Method CHECK (payment_method IN (N'Tiền mặt', N'Chuyển khoản', N'Thẻ tín dụng', N'Momo'))
)
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
)
GO

CREATE TABLE Class_Student (
    class_id NVARCHAR(20) NOT NULL,
    student_id VARCHAR(5) NOT NULL,
    enrollment_date DATE,
    PRIMARY KEY (class_id, student_id),
    FOREIGN KEY (class_id) REFERENCES Class(id),
    FOREIGN KEY (student_id) REFERENCES Student(id)
)
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
)
GO

CREATE TABLE Exam_Result (
    student_id VARCHAR(5) NOT NULL,
    exam_id VARCHAR(5) NOT NULL,
    value DECIMAL(4,2) NOT NULL,
    date DATE,
    PRIMARY KEY (student_id, exam_id), 
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (exam_id) REFERENCES Exam(id),
    CONSTRAINT CK_Exam_Result_Value CHECK (value >= 0.00 AND value <= 10.00)
)
GO
