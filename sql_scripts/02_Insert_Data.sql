/*For testing
SELECT * FROM Teacher ORDER BY id;
SELECT * FROM Student ORDER BY id;
SELECT * FROM Course ORDER BY id;
SELECT * FROM Course_Material ORDER BY id;
SELECT * FROM Class ORDER BY course_id, id;
SELECT * FROM Class_Student ORDER BY class_id, student_id;
SELECT * FROM Exam ORDER BY class_id, date;s
SELECT * FROM Exam_Result ORDER BY student_id, exam_id;
SELECT * FROM Payment ORDER BY id;
*/

USE EducateDB
GO

---Clear data if exists
DELETE FROM Exam_Result;
DELETE FROM Payment;
DELETE FROM Exam; 
DELETE FROM Class_Student;
DELETE FROM Course_Material;
DELETE FROM Class;
DELETE FROM Course;
DELETE FROM AuditLog;
DELETE FROM Student;
DELETE FROM Teacher;
GO


INSERT INTO Teacher (id, first_name, last_name, date_birth, gender, email, phone, address, city, description, user_name, password) VALUES
('TE001', N'Mai', N'Nguyễn Thị Lan', '1985-03-12', N'Nữ', 'mai.ntl@educenter.vn', '0912345678', N'10 Vạn Bảo, Ba Đình', N'Hà Nội', N'IELTS (8.5), 10 năm kinh nghiệm', 'maintl', 'pass123'),
('TE002', N'David', N'Smith', '1978-07-20', N'Nam', 'david.smith@educenter.vn', '0987654321', N'P201 Times City, Hai Bà Trưng', N'Hà Nội', N'Giáo viên bản ngữ (Mỹ), Phát âm', 'davids', 'pass123'),
('TE003', N'Hùng', N'Trần Mạnh', '1990-11-05', N'Nam', 'hung.tm@educenter.vn', '0903334444', N'55 Chùa Láng, Đống Đa', N'Hà Nội', N'Tiếng Anh Trẻ em, TESOL', 'hungtm', 'pass123'),
('TE004', N'Phương', N'Lê Thu', '1982-06-25', N'Nữ', 'phuong.lt@educenter.vn', '0901112222', N'8 Xuân Thủy, Cầu Giấy', N'Hà Nội', N'Chuyên TOEIC, cựu giám khảo', 'phuonglt', 'pass123'),
('TE005', N'John', N'Baker', '1980-09-17', N'Nam', 'john.baker@educenter.vn', '0902223333', N'12 Lý Thường Kiệt, Hoàn Kiếm', N'Hà Nội', N'Bản ngữ (Anh), Tiếng Anh Kinh doanh', 'johnb', 'pass123'),
('TE006', N'Emily', N'White', '1995-04-18', N'Nữ', 'emily.white@educenter.vn', '0904445555', N'302 The Link Ciputra, Tây Hồ', N'Hà Nội', N'Bản ngữ (Úc), Tiếng Anh Sáng tạo', 'emilyw', 'pass123'),
('TE007', N'Tuấn', N'Trần Quốc', '1989-12-01', N'Nam', 'tuan.tq@educenter.vn', '0905556666', N'28 Hàng Chuối, Hai Bà Trưng', N'Hà Nội', N'Viết Luận Học thuật', 'tuantq', 'pass123'),
('TE008', N'Linh', N'Hoàng Thùy', '1991-08-11', N'Nữ', 'linh.ht@educenter.vn', '0906667777', N'33 Trúc Bạch, Ba Đình', N'Hà Nội', N'IELTS Reading & Listening', 'linhht', 'pass123'),
('TE009', N'Chris', N'Jones', '1983-05-20', N'Nam', 'chris.jones@educenter.vn', '0907778888', N'18 Huỳnh Thúc Kháng, Đống Đa', N'Hà Nội', N'Bản ngữ (Canada), Tiếng Anh Phản xạ', 'chrisj', 'pass123'),
('TE010', N'Ngân', N'Vũ Thị Kim', '1987-10-25', N'Nữ', 'ngan.vtk@educenter.vn', '0908889999', N'42 Nhà Thờ, Hoàn Kiếm', N'Hà Nội', N'TOEIC Bridge, Tiếng Anh Mất gốc', 'nganvtk', 'pass123'),
('TE011', N'An', N'Nguyễn Bình', '1992-01-15', N'Nam', 'an.nb@educenter.vn', '0919876543', N'15 Nguyễn Chí Thanh, Ba Đình', N'Hà Nội', N'IELTS Speaking & Writing', 'annb', 'pass123'),
('TE012', N'Jessica', N'Miller', '1993-09-02', N'Nữ', 'jessica.m@educenter.vn', '0928765432', N'P1105 Keangnam, Nam Từ Liêm', N'Hà Nội', N'Bản ngữ (Mỹ), Tiếng Anh Doanh nghiệp', 'jessicam', 'pass123'),
('TE013', N'Quang', N'Đỗ Vinh', '1988-06-18', N'Nam', 'quang.dv@educenter.vn', '0937654321', N'78 Kim Mã, Ba Đình', N'Hà Nội', N'Chuyên gia SAT, 7 năm kinh nghiệm', 'quangdv', 'pass123'),
('TE014', N'Sophia', N'Chen', '1994-02-20', N'Nữ', 'sophia.c@educenter.vn', '0946543210', N'P801 Royal City, Thanh Xuân', N'Hà Nội', N'Bản ngữ (Anh), Tiếng Anh Học thuật', 'sophiac', 'pass123'),
('TE015', N'Thắng', N'Lê Việt', '1990-07-07', N'Nam', 'thang.lv@educenter.vn', '0965432109', N'21 Hoàng Quốc Việt, Cầu Giấy', N'Hà Nội', N'Luyện thi TOEIC, 990/990', 'thanglv', 'pass123'),
('TE016', N'Michael', N'Brown', '1986-11-30', N'Nam', 'michael.b@educenter.vn', '0911223344', N'50A Mai Hắc Đế, Hai Bà Trưng', N'Hà Nội', N'Bản ngữ (Mỹ), Chuyên gia GMAT/GRE', 'michaelb', 'pass123'),
('TE017', N'Hà', N'Phan Thu', '1992-08-19', N'Nữ', 'ha.pt@educenter.vn', '0988776655', N'102 Thái Hà, Đống Đa', N'Hà Nội', N'Luyện thi IELTS, tập trung Speaking', 'hapt', 'pass123'),
('TE018', N'Liam', N'Wilson', '1996-01-25', N'Nam', 'liam.w@educenter.vn', '0977665544', N'P602 Mandarin Garden, Cầu Giấy', N'Hà Nội', N'Bản ngữ (New Zealand), Giao tiếp', 'liamw', 'pass123'),
('TE019', N'Dung', N'Nguyễn Thùy', '1984-04-05', N'Nữ', 'dung.nt@educenter.vn', '0966554433', N'34T Hoàng Đạo Thúy, Cầu Giấy', N'Hà Nội', N'Chuyên gia Tiếng Anh Thương mại', 'dungnt', 'pass123'),
('TE020', N'Oliver', N'Taylor', '1975-12-10', N'Nam', 'oliver.t@educenter.vn', '0955443322', N'Biệt thự S5, Vinhomes Riverside', N'Hà Nội', N'Bản ngữ (Anh), Luyện giọng', 'olivert', 'pass123'),
('TE021', N'Châu', N'Trần Minh', '1993-02-14', N'Nữ', 'chau.tm@educenter.vn', '0944332211', N'99 Láng Hạ, Đống Đa', N'Hà Nội', N'Luyện thi PTE & IELTS', 'chautm', 'pass123');
GO

INSERT INTO Student (id, first_name, last_name, date_birth, gender, email, phone, address, city, user_name, password, balance, created_date) VALUES
('ST001', N'An', N'Nguyễn Văn', '2003-05-15', N'Nam', 'an.nv@email.com', '0911111111', N'123 Đường Láng, Đống Đa', N'Hà Nội', 'annv', 'pass123', 25000000.00, '2023-01-10'),
('ST002', N'Bình', N'Trần Thị', '2004-02-20', N'Nữ', 'binh.tt@email.com', '0922222222', N'456 Phố Huế, Hai Bà Trưng', N'Hà Nội', 'binhtt', 'pass123', 20000000.00, '2023-01-11'),
('ST003', N'Cường', N'Lê Văn', '2002-09-01', N'Nam', 'cuong.lv@email.com', '0933333333', N'789 Kim Mã, Ba Đình', N'Hà Nội', 'cuonglv', 'pass123', 18000000.00, '2023-01-12'),
('ST004', N'Dung', N'Phạm Thị', '2003-11-30', N'Nữ', 'dung.pt@email.com', '0944444444', N'101 Cầu Giấy, Cầu Giấy', N'Hà Nội', 'dungpt', 'pass123', 15000000.00, '2023-01-13'),
('ST005', N'Giang', N'Hoàng Văn', '2001-07-14', N'Nam', 'giang.hv@email.com', '0955555555', N'212 Nguyễn Trãi, Thanh Xuân', N'Hà Nội', 'gianghv', 'pass123', 22000000.00, '2023-01-14'),
('ST006', N'Hà', N'Vũ Thu', '2002-11-03', N'Nữ', 'ha.vt@email.com', '0917778888', N'5 Đường Láng Hạ, Ba Đình', N'Hà Nội', 'havt', 'pass123', 0, '2023-02-20'),
('ST007', N'Sơn', N'Đặng Bá', '1999-07-30', N'Nam', 'son.db@email.com', '0916669999', N'18 Phố Huế, Hai Bà Trưng', N'Hà Nội', 'sondb', 'pass123', 19000000.00, '2023-03-01'),
('ST008', N'Thảo', N'Đỗ Phương', '2003-03-25', N'Nữ', 'thao.dp@email.com', '0915556666', N'Khu tập thể Thành Công, Ba Đình', N'Hà Nội', 'thaodp', 'pass123', 8000000.00, '2023-03-15'),
('ST009', N'Minh Anh', N'Phạm', '2002-09-10', N'Nữ', 'minhanh.p@email.com', '0933333333', N'12 Đường Thanh Niên, Tây Hồ', N'Hà Nội', 'minhanhp', 'pass123', 16000000.00, '2023-04-01'),
('ST010', N'Khải', N'Trần Đăng', '2000-01-20', N'Nam', 'khai.td@email.com', '0922222222', N'45 Phố Xã Đàn, Đống Đa', N'Hà Nội', 'khaitd', 'pass123', NULL, '2023-04-10'),
('ST011', N'Ngọc', N'Lê Thị Bích', '2003-05-05', N'Nữ', 'ngoc.ltb@email.com', '0944444444', N'100 Phố Hàng Gai, Hoàn Kiếm', N'Hải Phòng', 'ngocltb', 'pass123', 15500000.00, '2023-05-01'),
('ST012', N'Tuấn Anh', N'Vũ', '2001-10-10', N'Nam', 'tuananh.v@email.com', '0955555555', N'25 Đường Lê Hồng Phong', N'Nam Định', 'tuananhv', 'pass123', 8000000.00, '2023-05-05'),
('ST013', N'Giang', N'Hoàng Thùy', '2002-07-14', N'Nữ', 'giang.ht@email.com', '0988777666', N'24 Phố Lý Thái Tổ, Hoàn Kiếm', N'Hà Nội', 'gianght', 'pass123', 7000000.00, '2023-05-10'),
('ST014', N'Hiếu', N'Đinh Trung', '1999-01-08', N'Nam', 'hieu.dt@email.com', '0977888999', N'99 Phố Nguyễn Khuyến, Đống Đa', N'Hà Nội', 'hieudt', 'pass123', 14000000.00, '2023-05-11'),
('ST015', N'Trang', N'Vũ Huyền', '2003-11-30', N'Nữ', 'trang.vh@email.com', '0966555444', N'3 Ngõ 15, Duy Tân, Cầu Giấy', N'Hà Nội', 'trangvh', 'pass123', 10000000.00, '2023-05-12'),
('ST016', N'Duy', N'Nguyễn Quang', '2004-06-20', N'Nam', 'duy.nq@email.com', '0955444333', N'1 Trần Phú', N'Bắc Ninh', 'duynq', 'pass123', 9000000.00, '2023-05-13'),
('ST017', N'Hương', N'Bùi Thị', '2000-02-19', N'Nữ', 'huong.bt@email.com', '0944333222', N'2 Bạch Đằng', N'Đà Nẵng', 'huongbt', 'pass123', 8000000.00, '2023-05-14'),
('ST018', N'Việt', N'Lý Hoàng', '1997-08-01', N'Nam', 'viet.lh@email.com', '0933222111', N'88 Phố Hàng Bông, Hoàn Kiếm', N'Hà Nội', 'vietlh', 'pass123', 13000000.00, '2023-05-15'),
('ST019', N'Nga', N'Ngô Thị', '2003-10-02', N'Nữ', 'nga.nt@email.com', '0922111000', N'11 Ngõ 19, Lạc Long Quân', N'Hà Nội', 'ngant', 'pass123', 12000000.00, '2023-05-16'),
('ST020', N'Thành', N'Phạm Công', '2001-04-12', N'Nam', 'thanh.pc@email.com', '0911000111', N'7 Phố Tràng Tiền, Hoàn Kiếm', N'Hà Nội', 'thanhpc', 'pass123', 15000000.00, '2023-05-17'),
('ST021', N'Yến', N'Nguyễn Hải', '2002-03-08', N'Nữ', 'yen.nh@email.com', '0912121212', N'10 Phan Chu Trinh, Hoàn Kiếm', N'Hà Nội', 'yennh', 'pass123', 7000000.00, '2023-06-01'),
('ST022', N'Bảo', N'Lý Quốc', '1999-06-15', N'Nam', 'bao.lq@email.com', '0913131313', N'20 Đường Kim Mã, Ba Đình', N'Hà Nội', 'baolq', 'pass123', 15000000.00, '2023-06-02'),
('ST023', N'Chi', N'Đinh Thùy', '2004-01-01', N'Nữ', 'chi.dt@email.com', '0914141414', N'30 Phố Đội Cấn, Ba Đình', N'Hà Nội', 'chidt', 'pass123', 5000000.00, '2023-06-03'),
('ST024', N'Đạt', N'Nguyễn Tiến', '2001-12-24', N'Nam', 'dat.nt@email.com', '0915151515', N'40 Đường Láng, Đống Đa', N'Hà Nội', 'datnt', 'pass123', 14500000.00, '2023-06-04'),
('ST025', N'Oanh', N'Hoàng Kiều', '2002-08-30', N'Nữ', 'oanh.hk@email.com', '0916161616', N'50 Phố Thái Thịnh, Đống Đa', N'Hà Nội', 'oanhhk', 'pass123', 18000000.00, '2023-06-05'),
('ST026', N'Dũng', N'Nguyễn Chí', '2000-05-18', N'Nam', 'dung.nc@email.com', '0917171717', N'60 Trần Duy Hưng, Cầu Giấy', N'Hà Nội', 'dungnc', 'pass123', 5000000.00, '2023-06-06'),
('ST027', N'Hằng', N'Lê Thu', '2003-09-12', N'Nữ', 'hang.lt@email.com', '0918181818', N'70 Nguyễn Lương Bằng, Đống Đa', N'Hà Nội', 'hanglt', 'pass123', 6500000.00, '2023-06-07'),
('ST028', N'Long', N'Vũ Hải', '2001-07-07', N'Nam', 'long.vh@email.com', '0919191919', N'80 Phố Tây Sơn, Đống Đa', N'TP. Hồ Chí Minh', 'longvh', 'pass123', 17500000.00, '2023-06-08'),
('ST029', N'Mai', N'Trần Thị', '2002-04-04', N'Nữ', 'mai.tt@email.com', '0920202020', N'90 Phố Giảng Võ, Ba Đình', N'Hà Nội', 'maitt', 'pass123', 18000000.00, '2023-06-09'),
('ST030', N'Tùng', N'Hoàng Phi', '1998-02-02', N'Nam', 'tung.hp@email.com', '0921212121', N'100 Ô Chợ Dừa, Đống Đa', N'Hà Nội', 'tunghp', 'pass123', 9000000.00, '2023-06-10'),
('ST031', N'Anh', N'Lê Ngọc', '2003-01-25', N'Nữ', 'anh.ln@email.com', '0923232323', N'P1201 Chelsea Park, Cầu Giấy', N'Hà Nội', 'anhln', 'pass123', 20000000.00, '2023-06-11'),
('ST032', N'Bình', N'Trần An', '2000-11-11', N'Nam', 'binh.ta@email.com', '0924242424', N'11 Phố Bà Triệu, Hoàn Kiếm', N'Hà Nội', 'binhta', 'pass123', 7500000.00, '2023-06-12'),
('ST033', N'Châu', N'Nguyễn Ngọc', '2004-07-19', N'Nữ', 'chau.nn@email.com', '0925252525', N'23 Phố Hoàng Cầu, Đống Đa', N'Hà Nội', 'chaunn', 'pass123', 15000000.00, '2023-06-13'),
('ST034', N'Dương', N'Phạm Thùy', '2001-08-14', N'Nữ', 'duong.pt@email.com', '0926262626', N'44 Tôn Đức Thắng, Đống Đa', N'Hải Phòng', 'duongpt', 'pass123', 18500000.00, '2023-06-14'),
('ST035', N'Hải', N'Lê Văn', '1999-03-30', N'Nam', 'hai.lv@email.com', '0927272727', N'55 Phố Xã Đàn, Đống Đa', N'Hà Nội', 'hailv', 'pass123', 16000000.00, '2023-06-15'),
('ST036', N'Hoa', N'Đặng Thị', '2002-10-09', N'Nữ', 'hoa.dt@email.com', '0928282828', N'66 Nguyễn Du, Hai Bà Trưng', N'Hà Nội', 'hoadt', 'pass123', 4000000.00, '2023-06-16'),
('ST037', N'Khánh', N'Võ Duy', '2003-05-15', N'Nam', 'khanh.vd@email.com', '0929292929', N'77 Lê Duẩn, Hoàn Kiếm', N'Đà Nẵng', 'khanhvd', 'pass123', 18800000.00, '2023-06-17'),
('ST038', N'Loan', N'Bùi Thị', '2000-09-01', N'Nữ', 'loan.bt@email.com', '0930303030', N'88 Trần Nhân Tông, Hai Bà Trưng', N'Hà Nội', 'loanbt', 'pass123', 13000000.00, '2023-06-18'),
('ST039', N'Nam', N'Nguyễn Thành', '2001-02-18', N'Nam', 'nam.nt@email.com', '0931313131', N'99 Đại Cồ Việt, Hai Bà Trưng', N'Hà Nội', 'namnt', 'pass123', 21000000.00, '2023-06-19'),
('ST040', N'Phương', N'Vũ Thu', '2004-12-25', N'Nữ', 'phuong.vt@email.com', '0932323232', N'P505 Indochina Plaza, Cầu Giấy', N'Hà Nội', 'phuongvt', 'pass123', 17500000.00, '2023-06-20'),
('ST041', N'Quang', N'Trần Minh', '2000-08-10', N'Nam', 'quang.tm@email.com', '0934343434', N'121 Chùa Bộc, Đống Đa', N'Hà Nội', 'quangtm', 'pass123', 8200000.00, '2023-07-01'),
('ST042', N'Quỳnh', N'Lê Thị', '2002-06-22', N'Nữ', 'quynh.lt@email.com', '0935353535', N'234 Phạm Ngọc Thạch, Đống Đa', N'Hà Nội', 'quynhlt', 'pass123', 8000000.00, '2023-07-02'),
('ST043', N'Tâm', N'Ngô Thanh', '1999-04-18', N'Nam', 'tam.nt@email.com', '0936363636', N'345 Giải Phóng, Thanh Xuân', N'Hà Nội', 'tamnt', 'pass123', 9300000.00, '2023-07-03'),
('ST044', N'Thủy', N'Hoàng Thị', '2003-10-15', N'Nữ', 'thuy.ht@email.com', '0937373737', N'456 Minh Khai, Hai Bà Trưng', N'Hà Nội', 'thuyht', 'pass123', 9800000.00, '2023-07-04'),
('ST045', N'Toàn', N'Phan Văn', '2001-03-05', N'Nam', 'toan.pv@email.com', '0938383838', N'567 Trường Chinh, Đống Đa', N'Hà Nội', 'toanpv', 'pass123', 7700000.00, '2023-07-05'),
('ST046', N'Trúc', N'Mai Thanh', '2002-01-20', N'Nữ', 'truc.mt@email.com', '0939393939', N'678 Nguyễn Văn Cừ, Long Biên', N'Hà Nội', 'trucmt', 'pass123', 0, '2023-07-06'),
('ST047', N'Uyên', N'Nguyễn Phương', '2004-09-09', N'Nữ', 'uyen.np@email.com', '0940404040', N'789 Lạc Long Quân, Tây Hồ', N'Hà Nội', 'uyennp', 'pass123', 8800000.00, '2023-07-07'),
('ST048', N'Vinh', N'Đỗ Quang', '2000-12-01', N'Nam', 'vinh.dq@email.com', '0941414141', N'890 Quang Trung, Hà Đông', N'Hà Nội', 'vinhdq', 'pass123', 10500000.00, '2023-07-08'),
('ST049', N'Xuân', N'Hồ Thị', '1998-02-14', N'Nữ', 'xuan.ht@email.com', '0942424242', N'901 Nguyễn Lương Bằng, Đống Đa', N'Hà Nội', 'xuanht', 'pass123', 9000000.00, '2023-07-09'),
('ST050', N'Phúc', N'Trần Hữu', '2001-05-25', N'Nam', 'phuc.th@email.com', '0943434343', N'111 Tây Hồ, Tây Hồ', N'Hà Nội', 'phucth', 'pass123', 18200000.00, '2023-07-10'),
('ST051', N'Thắng', N'Nguyễn Bá', '2003-04-11', N'Nam', 'thang.nb@email.com', '0944556677', N'222 Lê Văn Lương, Cầu Giấy', N'Hà Nội', 'thangnb', 'pass123', 17800000.00, '2023-08-01'),
('ST052', N'Nhung', N'Lê Hồng', '2002-08-19', N'Nữ', 'nhung.lh@email.com', '0955667788', N'333 Xuân Thủy, Cầu Giấy', N'Hà Nội', 'nhunglh', 'pass123', 11000000.00, '2023-08-02'),
('ST053', N'Đức', N'Trần Minh', '2000-11-07', N'Nam', 'duc.tm@email.com', '0966778899', N'444 Hoàng Hoa Thám, Ba Đình', N'Hà Nội', 'ductm', 'pass123', 19100000.00, '2023-08-03'),
('ST054', N'Hạnh', N'Nguyễn Thị', '2004-01-23', N'Nữ', 'hanh.nt@email.com', '0977889900', N'555 Thụy Khuê, Tây Hồ', N'Hà Nội', 'hanhnt', 'pass123', 14200000.00, '2023-08-04'),
('ST055', N'Huy', N'Lê Quang', '2001-09-16', N'Nam', 'huy.lq@email.com', '0988990011', N'666 Hoàng Quốc Việt, Cầu Giấy', N'Hà Nội', 'huylq', 'pass123', 6000000.00, '2023-08-05'),
('ST056', N'Kiên', N'Phạm Trung', '2002-05-30', N'Nam', 'kien.pt@email.com', '0912233445', N'777 Nguyễn Phong Sắc, Cầu Giấy', N'Hà Nội', 'kienpt', 'pass123', 15300000.00, '2023-08-06'),
('ST057', N'Lan', N'Vũ Thị', '2003-03-12', N'Nữ', 'lan.vt@email.com', '0923344556', N'888 Trần Cung, Bắc Từ Liêm', N'Hà Nội', 'lanvt', 'pass123', 17100000.00, '2023-08-07'),
('ST058', N'Linh', N'Ngô Thùy', '2000-07-28', N'Nữ', 'linh.nt@email.com', '0934455667', N'999 Phạm Văn Đồng, Bắc Từ Liêm', N'Hà Nội', 'linhnt', 'pass123', 9800000.00, '2023-08-08'),
('ST059', N'Mạnh', N'Đỗ Hùng', '2001-12-04', N'Nam', 'manh.dh@email.com', '0945566778', N'1122 Láng, Đống Đa', N'Hà Nội', 'manhdh', 'pass123', 0, '2023-08-09'),
('ST060', N'Nga', N'Trần Thị', '2002-10-21', N'Nữ', 'nga.tt@email.com', '0956677889', N'1234 Đường Bưởi, Ba Đình', N'Hà Nội', 'ngatt', 'pass123', 22200000.00, '2023-08-10'),
('ST061', N'Phong', N'Lý Đức', '1999-05-14', N'Nam', 'phong.ld@email.com', '0967788990', N'543 Kim Ngưu, Hai Bà Trưng', N'Hà Nội', 'phongld', 'pass123', 13000000.00, '2023-08-11'),
('ST062', N'Quân', N'Nguyễn Minh', '2003-08-08', N'Nam', 'quan.nm@email.com', '0978899001', N'654 Bạch Mai, Hai Bà Trưng', N'Hà Nội', 'quannm', 'pass123', 12000000.00, '2023-08-12'),
('ST063', N'Tú', N'Trần Anh', '2004-03-03', N'Nam', 'tu.ta@email.com', '0989900112', N'765 Thanh Nhàn, Hai Bà Trưng', N'Hà Nội', 'tuta', 'pass123', 16900000.00, '2023-08-13'),
('ST064', N'Thảo', N'Lê Phương', '2001-01-01', N'Nữ', 'thao.lp@email.com', '0913344556', N'876 Tam Trinh, Hoàng Mai', N'Hà Nội', 'thaolp', 'pass123', 18300000.00, '2023-08-14'),
('ST065', N'My', N'Vũ Thị Trà', '2002-02-02', N'Nữ', 'my.vtt@email.com', '0924455667', N'987 Tân Mai, Hoàng Mai', N'Hà Nội', 'myvtt', 'pass123', 9000000.00, '2023-08-15'),
('ST066', N'Linh', N'Trần Diệu', '2001-08-20', N'Nữ', 'linh.td@email.com', '0912345066', N'101 Nguyễn Khang, Cầu Giấy', N'Hà Nội', 'linhtd', 'pass123', 25000000.00, '2023-09-01'),
('ST067', N'Khoa', N'Võ Đăng', '2003-04-14', N'Nam', 'khoa.vd@email.com', '0912345067', N'202 Trần Bình, Mỹ Đình', N'Hà Nội', 'khoavd', 'pass123', 18000000.00, '2023-09-02'),
('ST068', N'Vy', N'Hồ Thị', '2002-11-25', N'Nữ', 'vy.ht@email.com', '0912345068', N'303 Phố Vọng, Hai Bà Trưng', N'Hà Nội', 'vyht', 'pass123', 15000000.00, '2023-09-03'),
('ST069', N'Thiện', N'Phan Công', '2000-01-30', N'Nam', 'thien.pc@email.com', '0912345069', N'404 Lê Trọng Tấn, Thanh Xuân', N'Hà Nội', 'thienpc', 'pass123', 20000000.00, '2023-09-04'),
('ST070', N'Trâm', N'Nguyễn Ngọc', '2004-06-18', N'Nữ', 'tram.nn@email.com', '0912345070', N'505 Minh Khai, Hai Bà Trưng', N'Hà Nội', 'tramnn', 'pass123', 12000000.00, '2023-09-05'),
('ST071', N'Tài', N'Huỳnh Hữu', '1999-09-05', N'Nam', 'tai.hh@email.com', '0912345071', N'606 Đường Bưởi, Ba Đình', N'Hà Nội', 'taihh', 'pass123', 22000000.00, '2023-09-06'),
('ST072', N'Thư', N'Đỗ Anh', '2003-02-11', N'Nữ', 'thu.da@email.com', '0912345072', N'707 Kim Mã, Ba Đình', N'Hà Nội', 'thuda', 'pass123', 9000000.00, '2023-09-07'),
('ST073', N'Bách', N'Lê Quang', '2001-05-19', N'Nam', 'bach.lq@email.com', '0912345073', N'808 Láng Hạ, Đống Đa', N'Hà Nội', 'bachlq', 'pass123', 17000000.00, '2023-09-08'),
('ST074', N'Ngọc', N'Hoàng Bích', '2002-12-01', N'Nữ', 'ngoc.hb@email.com', '0912345074', N'909 Xã Đàn, Đống Đa', N'Hà Nội', 'ngochb', 'pass123', 13000000.00, '2023-09-09'),
('ST075', N'Phát', N'Trần Tấn', '2000-07-22', N'Nam', 'phat.tt@email.com', '0912345075', N'111 Tây Sơn, Đống Đa', N'Hà Nội', 'phattt', 'pass123', 10000000.00, '2023-09-10'),
('ST076', N'Trinh', N'Mai Nữ', '2003-03-03', N'Nữ', 'trinh.mn@email.com', '0912345076', N'222 Nguyễn Chí Thanh, Ba Đình', N'Hà Nội', 'trinhmn', 'pass123', 19500000.00, '2023-09-11'),
('ST077', N'Tâm', N'Vũ Thanh', '2001-10-10', N'Nam', 'tam.vt@email.com', '0912345077', N'333 Thái Hà, Đống Đa', N'Hà Nội', 'tamvt', 'pass123', 5000000.00, '2023-09-12'),
('ST078', N'Huyền', N'Lê Thị', '2004-01-20', N'Nữ', 'huyen.lt@email.com', '0912345078', N'444 Chùa Bộc, Đống Đa', N'Hà Nội', 'huyenlt', 'pass123', 11000000.00, '2023-09-13'),
('ST079', N'Đăng', N'Ngô Hải', '2002-06-15', N'Nam', 'dang.nh@email.com', '0912345079', N'555 Phạm Ngọc Thạch, Đống Đa', N'Hà Nội', 'dangnh', 'pass123', 16000000.00, '2023-09-14'),
('ST080', N'Ánh', N'Vũ Thị', '2000-09-01', N'Nữ', 'anh.vt@email.com', '0912345080', N'666 Giảng Võ, Ba Đình', N'Hà Nội', 'anhvt', 'pass123', 14000000.00, '2023-09-15'),
('ST081', N'Vũ', N'Trần Công', '1998-05-25', N'Nam', 'vu.tc@email.com', '0912345081', N'777 Kim Liên, Đống Đa', N'Hà Nội', 'vutc', 'pass123', 23000000.00, '2023-09-16'),
('ST082', N'Yến', N'Phạm Hải', '2003-11-12', N'Nữ', 'yen.ph@email.com', '0912345082', N'888 Hàng Bột, Đống Đa', N'Hà Nội', 'yenph', 'pass123', 8500000.00, '2023-09-17'),
('ST083', N'Khang', N'Lê An', '2001-04-01', N'Nam', 'khang.la@email.com', '0912345083', N'999 Tôn Đức Thắng, Đống Đa', N'Hà Nội', 'khangla', 'pass123', 17500000.00, '2023-09-18'),
('ST084', N'Chi', N'Nguyễn Thùy', '2002-08-08', N'Nữ', 'chi.nt@email.com', '0912345084', N'1010 Hàng Gai, Hoàn Kiếm', N'Hà Nội', 'chint', 'pass123', 12500000.00, '2023-09-19'),
('ST085', N'Kiệt', N'Lý Anh', '2000-03-15', N'Nam', 'kiet.la@email.com', '0912345085', N'1212 Hàng Trống, Hoàn Kiếm', N'Hà Nội', 'kietla', 'pass123', 0, '2023-09-20'),
('ST086', N'Nhi', N'Trần Yến', '2003-07-07', N'Nữ', 'nhi.ty@email.com', '0912345086', N'1313 Hàng Mã, Hoàn Kiếm', N'Hà Nội', 'nhity', 'pass123', 21000000.00, '2023-09-21'),
('ST087', N'Duy', N'Phan Anh', '2001-12-12', N'Nam', 'duy.pa@email.com', '0912345087', N'1414 Hàng Bông, Hoàn Kiếm', N'Hà Nội', 'duypa', 'pass123', 11500000.00, '2023-09-22'),
('ST088', N'My', N'Lê Trà', '2004-05-05', N'Nữ', 'my.lt@email.com', '0912345088', N'1515 Hàng Đào, Hoàn Kiếm', N'Hà Nội', 'mylt', 'pass123', 9500000.00, '2023-09-23'),
('ST089', N'Sơn', N'Nguyễn Hoàng', '2002-10-18', N'Nam', 'son.nh@email.com', '0912345089', N'1616 Đồng Xuân, Hoàn Kiếm', N'Hà Nội', 'sonnh', 'pass123', 18500000.00, '2023-09-24'),
('ST090', N'Thảo', N'Vũ Phương', '2000-06-20', N'Nữ', 'thao.vp@email.com', '0912345090', N'1717 Nhà Thờ, Hoàn Kiếm', N'Hà Nội', 'thaovp', 'pass123', 13500000.00, '2023-09-25'),
('ST091', N'Minh', N'Đặng Quang', '1999-01-01', N'Nam', 'minh.dq@email.com', '0912345091', N'1818 Tràng Tiền, Hoàn Kiếm', N'Hà Nội', 'minhdq', 'pass123', 24000000.00, '2023-09-26'),
('ST092', N'Hân', N'Nguyễn Ngọc', '2003-08-19', N'Nữ', 'han.nn@email.com', '0912345092', N'1919 Bà Triệu, Hai Bà Trưng', N'Hà Nội', 'hannn', 'pass123', 7500000.00, '2023-09-27'),
('ST093', N'Long', N'Hoàng Phi', '2001-03-23', N'Nam', 'long.hp@email.com', '0912345093', N'2020 Phố Huế, Hai Bà Trưng', N'Hà Nội', 'longhp', 'pass123', 19000000.00, '2023-09-28'),
('ST094', N'Quỳnh', N'Lê Diễm', '2002-07-14', N'Nữ', 'quynh.ld@email.com', '0912345094', N'2121 Bạch Mai, Hai Bà Trưng', N'Hà Nội', 'quynhld', 'pass123', 11000000.00, '2023-09-29'),
('ST095', N'Tú', N'Vũ Anh', '2000-11-11', N'Nam', 'tu.va@email.com', '0912345095', N'2222 Thanh Nhàn, Hai Bà Trưng', N'Hà Nội', 'tuva', 'pass123', 16500000.00, '2023-09-30'),
('ST096', N'Anh', N'Trần Tuấn', '2003-01-25', N'Nam', 'anh.tt@email.com', '0912345096', N'2323 Lò Đúc, Hai Bà Trưng', N'Hà Nội', 'anhtt', 'pass123', NULL, '2023-10-01'),
('ST097', N'Hà', N'Phan Thanh', '2001-09-09', N'Nữ', 'ha.pt@email.com', '0912345097', N'2424 Kim Ngưu, Hai Bà Trưng', N'Hà Nội', 'hapt2', 'pass123', 14500000.00, '2023-10-02'),
('ST098', N'Khôi', N'Nguyễn Nguyên', '2002-04-04', N'Nam', 'khoi.nn@email.com', '0912345098', N'2525 Trần Khát Chân, Hai Bà Trưng', N'Hà Nội', 'khoinn', 'pass123', 20500000.00, '2023-10-03'),
('ST099', N'Mai', N'Đỗ Phương', '2004-07-28', N'Nữ', 'mai.dp@email.com', '0912345099', N'2626 Đại Cồ Việt, Hai Bà Trưng', N'Hà Nội', 'maidp', 'pass123', 9800000.00, '2023-10-04'),
('ST100', N'Tùng', N'Lê Thanh', '2000-12-31', N'Nam', 'tung.lt@email.com', '0912345100', N'2727 Giải Phóng, Hai Bà Trưng', N'Hà Nội', 'tunglt', 'pass123', 15500000.00, '2023-10-05')

GO

INSERT INTO Course (id, description, last_modified) VALUES
(N'GE_A1', N'Tiếng Anh Tổng quát - A1 (Beginner)', GETDATE()),
(N'GE_A2', N'Tiếng Anh Tổng quát - A2 (Elementary)', GETDATE()),
(N'GE_B1', N'Tiếng Anh Tổng quát - B1 (Intermediate)', GETDATE()),
(N'GE_B2', N'Tiếng Anh Tổng quát - B2 (Upper-Intermediate)', GETDATE()),
(N'GE_C1', N'Tiếng Anh Tổng quát - C1 (Advanced)', GETDATE()),
(N'IELTS_55', N'Luyện thi IELTS Mục tiêu 5.0-5.5', GETDATE()),
(N'IELTS_70', N'Luyện thi IELTS Mục tiêu 6.5-7.0+', GETDATE()),
(N'IELTS_PRO', N'IELTS Chuyên sâu (Speaking & Writing)', GETDATE()),
(N'TOEIC_B', N'Luyện thi TOEIC Cơ bản Mục tiêu 500+', GETDATE()),
(N'TOEIC_A', N'Luyện thi TOEIC Nâng cao Mục tiêu 750+', GETDATE()),
(N'BE_COM', N'Tiếng Anh Thương mại Giao tiếp', GETDATE()),
(N'BE_ADV', N'Tiếng Anh Thương mại Nâng cao', GETDATE()),
(N'KIDS_ENG', N'Tiếng Anh Trẻ Em (6-10 tuổi)', GETDATE()),
(N'KIDS_ADV', N'Tiếng Anh Trẻ Em Nâng cao (11-14 tuổi)', GETDATE()),
(N'AW_PRO', N'Viết Luận Học thuật Chuyên nghiệp', GETDATE()),
(N'PTE_65', N'Luyện thi PTE Academic Mục tiêu 65+', GETDATE()),
(N'SAT_PREP', N'Luyện thi SAT Toàn diện', GETDATE()),
(N'GMAT_PREP', N'Luyện thi GMAT Chuyên sâu', GETDATE());
GO

INSERT INTO Course_Material (id, course_id, description, material_type, material_url, date_add) VALUES
('CM001', N'GE_A1', N'English File Beginner Student Book', N'Sách giáo trình', NULL, '2023-01-10'),
('CM002', N'GE_A1', N'English File Beginner Workbook', N'Sách bài tập', NULL, '2023-01-12'),
('CM003', N'GE_A2', N'English File Elementary Student Book', N'Sách giáo trình', NULL, '2023-01-10'),
('CM004', N'GE_B1', N'English File Intermediate Student Book', N'Sách giáo trình', NULL, '2023-01-20'),
('CM005', N'GE_B2', N'English File Upper-Intermediate SB', N'Sách giáo trình', NULL, '2023-01-20'),
('CM006', N'GE_C1', N'English File Advanced Student Book', N'Sách giáo trình', NULL, '2023-01-20'),
('CM007', N'IELTS_55', N'The Official Cambridge Guide to IELTS', N'Sách giáo trình', NULL, '2023-08-01'),
('CM008', N'IELTS_55', N'Cambridge IELTS 16 Academic', N'Sách luyện đề', NULL, '2023-08-12'),
('CM009', N'IELTS_70', N'Cambridge IELTS 18 Academic', N'Sách luyện đề', NULL, '2023-08-01'),
('CM010', N'IELTS_70', N'IELTS Vocabulary Advanced by Collins', N'Sách từ vựng', NULL, '2023-08-01'),
('CM011', N'IELTS_PRO', N'IELTS Writing Task 2 Samples by Simon', N'Tài liệu tham khảo', 'http://example.com/simon-writing.pdf', '2023-08-05'),
('CM012', N'TOEIC_B', N'Tactics for TOEIC Listening and Reading Test', N'Sách giáo trình', NULL, '2023-07-01'),
('CM013', N'TOEIC_A', N'ETS TOEIC Test Official Prep Guide', N'Sách luyện đề', NULL, '2023-08-13'),
('CM014', N'TOEIC_A', N'600 Essential Words for the TOEIC', N'Sách từ vựng', NULL, '2023-08-14'),
('CM015', N'BE_COM', N'Market Leader Business English Intermediate', N'Sách giáo trình', NULL, '2023-03-01'),
('CM016', N'BE_COM', N'Business Vocabulary in Use: Intermediate', N'Sách từ vựng', NULL, '2023-03-02'),
('CM017', N'BE_ADV', N'Market Leader Business English Advanced', N'Sách giáo trình', NULL, '2023-03-01'),
('CM018', N'KIDS_ENG', N'Super Minds 1 Student Book', N'Sách giáo trình', NULL, '2023-08-10'),
('CM019', N'KIDS_ENG', N'Kids Box 1 Activity Book', N'Sách bài tập', NULL, '2023-08-10'),
('CM020', N'KIDS_ADV', N'Super Minds 4 Student Book', N'Sách giáo trình', NULL, '2023-08-17'),
('CM021', N'AW_PRO', N'Academic Writing for Graduate Students', N'Sách giáo trình', NULL, '2023-08-11'),
('CM022', N'AW_PRO', N'APA & MLA Citation Guide', N'Tài liệu tham khảo', 'http://example.com/citation_guide.pdf', '2023-08-11'),
('CM023', N'PTE_65', N'The Official Guide to PTE Academic', N'Sách giáo trình', NULL, '2023-08-14'),
('CM024', N'PTE_65', N'PTE Academic Testbuilder', N'Sách luyện đề', NULL, '2023-08-15'),
('CM025', N'SAT_PREP', N'The Official SAT Study Guide', N'Sách giáo trình', NULL, '2023-08-20'),
('CM026', N'SAT_PREP', N'10 Practice Tests for the SAT by Princeton Review', N'Sách luyện đề', NULL, '2023-08-21'),
('CM027', N'SAT_PREP', N'SAT Vocabulary: A New Approach', N'Sách từ vựng', NULL, '2023-08-22'),
('CM028', N'GMAT_PREP', N'The Official Guide to the GMAT', N'Sách giáo trình', NULL, '2023-08-22'),
('CM029', N'GMAT_PREP', N'Manhattan Prep 5 lb. Book of GMAT Problems', N'Sách bài tập', NULL, '2023-08-23'),
('CM030', N'IELTS_70', N'IELTS Listening Practice Tests', N'Tệp âm thanh', 'http://example.com/ielts_listening.zip', '2023-08-25'),
('CM031', N'GE_B1', N'Intermediate English Grammar in Use', N'Sách bài tập', NULL, '2023-01-22'),
('CM032', N'BE_COM', N'Video Series: Negotiating in English', N'Video Links', 'http://example.com/negotiating_videos', '2023-03-05');
GO

INSERT INTO Class (id, start_date, end_date, teacher_id, course_id, schedule_info, room_number, tuition_fee) VALUES
(N'GEA1-2401', '2024-01-15', '2024-04-12', 'TE010', N'GE_A1', N'T2-4-6, 18:00-19:30', N'P101', 3500000.00),
(N'GEA2-2401', '2024-01-16', '2024-04-13', 'TE002', N'GE_A2', N'T3-5, 18:00-19:30', N'P102', 3800000.00),
(N'GEB1-2401', '2024-01-15', '2024-04-12', 'TE002', N'GE_B1', N'T2-4-6, 19:45-21:15', N'P103', 4000000.00),
(N'GEB2-2401', '2024-01-16', '2024-04-13', 'TE009', N'GE_B2', N'T3-5, 19:45-21:15', N'P104', 4200000.00),
(N'GEC1-2401', '2024-02-05', '2024-05-03', 'TE014', N'GE_C1', N'T2-6, 18:30-20:30', N'P105', 4800000.00),
(N'IELTS55-2401', '2024-01-20', '2024-04-20', 'TE008', N'IELTS_55', N'T7, 09:00-12:00', N'P201', 6000000.00),
(N'IELTS70-2401A', '2024-01-20', '2024-04-20', 'TE001', N'IELTS_70', N'T7, 13:30-16:30', N'P202', 7500000.00),
(N'IELTS70-2401B', '2024-01-21', '2024-04-21', 'TE017', N'IELTS_70', N'CN, 09:00-12:00', N'P203', 7500000.00),
(N'IELTSPRO-2401', '2024-02-03', '2024-05-04', 'TE011', N'IELTS_PRO', N'T7, 09:00-12:00', N'P204', 8500000.00),
(N'TOEICB-2401', '2024-01-15', '2024-04-12', 'TE004', N'TOEIC_B', N'T2-4, 18:00-19:30', N'P301', 4500000.00),
(N'TOEICA-2401', '2024-01-15', '2024-04-12', 'TE015', N'TOEIC_A', N'T2-4, 19:45-21:15', N'P302', 5500000.00),
(N'BECOM-2401', '2024-01-16', '2024-04-13', 'TE005', N'BE_COM', N'T3-5, 18:30-20:30', N'P303', 4500000.00),
(N'BEADV-2401', '2024-02-06', '2024-05-07', 'TE012', N'BE_ADV', N'T3-5, 19:00-21:00', N'P304', 5500000.00),
(N'KIDSENG-2401', '2024-01-20', '2024-04-20', 'TE003', N'KIDS_ENG', N'T7, 09:30-11:00', N'P106', 3000000.00),
(N'KIDSADV-2401', '2024-01-21', '2024-04-21', 'TE006', N'KIDS_ADV', N'CN, 09:30-11:00', N'P107', 3200000.00),
(N'AWPRO-2401', '2024-02-04', '2024-04-28', 'TE007', N'AW_PRO', N'CN, 14:00-16:00', N'P205', 5000000.00),
(N'PTE65-2401', '2024-02-10', '2024-05-11', 'TE021', N'PTE_65', N'T7, 13:30-16:30', N'P305', 8000000.00),
(N'SATPREP-2401', '2024-01-27', '2024-05-04', 'TE013', N'SAT_PREP', N'T7, 08:30-12:30', N'P306', 9000000.00),
(N'GMATPREP-2401', '2024-01-28', '2024-05-05', 'TE016', N'GMAT_PREP', N'CN, 08:30-12:30', N'P307', 12000000.00),
(N'GEA1-2401B', '2024-01-16', '2024-04-13', 'TE010', N'GE_A1', N'T3-5, 19:45-21:15', N'P101', 3500000.00),
(N'GEB1-2402', '2024-02-12', '2024-05-10', 'TE018', N'GE_B1', N'T2-4, 18:00-19:30', N'P108', 4000000.00),
(N'IELTS70-2402', '2024-02-13', '2024-05-14', 'TE001', N'IELTS_70', N'T3-5-7, 18:30-20:30', N'P202', 7800000.00), 
(N'TOEICA-2402', '2024-02-19', '2024-05-17', 'TE015', N'TOEIC_A', N'T2-4-6, 18:00-19:30', N'P301', 5500000.00),
(N'BECOM-2402', '2024-02-20', '2024-05-21', 'TE019', N'BE_COM', N'T3-5, 19:00-21:00', N'P303', 4500000.00),
(N'KIDSENG-2402', '2024-01-21', '2024-04-21', 'TE003', N'KIDS_ENG', N'CN, 14:00-15:30', N'P106', 3000000.00),
(N'IELTS55-2402', '2024-02-18', '2024-05-19', 'TE008', N'IELTS_55', N'CN, 13:30-16:30', N'P201', 6200000.00),
(N'GEB2-2402', '2024-02-19', '2024-05-17', 'TE020', N'GE_B2', N'T2-4, 19:00-21:00', N'P104', 4200000.00),
(N'SATPREP-2402', '2024-02-25', '2024-06-02', 'TE013', N'SAT_PREP', N'CN, 13:30-17:30', N'P306', 9500000.00), 
(N'AWPRO-2402', '2024-03-02', '2024-05-25', 'TE007', N'AW_PRO', N'T7, 15:00-17:00', N'P205', 5000000.00),
(N'IELTS70-2403', '2024-03-04', '2024-06-03', 'TE017', N'IELTS_70', N'T2-4-6, 18:00-20:00', N'P203', 7500000.00),
(N'GEA1-2402', '2024-05-06', '2024-08-02', 'TE010', N'GE_A1', N'T2-4-6, 18:00-19:30', N'P101', 3600000.00),
(N'GEB1-2403', '2024-05-07', '2024-08-03', 'TE018', N'GE_B1', N'T3-5, 19:45-21:15', N'P108', 4100000.00),
(N'GEC1-2402', '2024-06-03', '2024-08-30', 'TE014', N'GE_C1', N'T2-6, 18:30-20:30', N'P105', 4900000.00),
(N'IELTS55-2403', '2024-06-01', '2024-08-31', 'TE008', N'IELTS_55', N'T7, 09:00-12:00', N'P201', 6300000.00),
(N'IELTS70-2404', '2024-06-08', '2024-09-07', 'TE001', N'IELTS_70', N'T7, 13:30-16:30', N'P202', 7600000.00),
(N'IELTSPRO-2402', '2024-06-01', '2024-08-31', 'TE011', N'IELTS_PRO', N'T7, 09:00-12:00', N'P204', 8800000.00),
(N'TOEICB-2402', '2024-05-06', '2024-08-02', 'TE004', N'TOEIC_B', N'T2-4, 18:00-19:30', N'P301', 4600000.00),
(N'TOEICA-2403', '2024-06-03', '2024-08-30', 'TE015', N'TOEIC_A', N'T2-4, 19:45-21:15', N'P302', 5700000.00),
(N'BECOM-2403', '2024-06-04', '2024-09-03', 'TE005', N'BE_COM', N'T3-5, 18:30-20:30', N'P303', 4700000.00),
(N'BEADV-2402', '2024-06-04', '2024-09-03', 'TE012', N'BE_ADV', N'T3-5, 19:00-21:00', N'P304', 5800000.00),
(N'KIDSENG-2403', '2024-06-01', '2024-08-31', 'TE003', N'KIDS_ENG', N'T7, 09:30-11:00', N'P106', 3100000.00),
(N'KIDSADV-2402', '2024-06-02', '2024-09-01', 'TE006', N'KIDS_ADV', N'CN, 09:30-11:00', N'P107', 3300000.00),
(N'AWPRO-2403', '2024-06-02', '2024-08-25', 'TE007', N'AW_PRO', N'CN, 14:00-16:00', N'P205', 5200000.00),
(N'PTE65-2402', '2024-06-08', '2024-09-07', 'TE021', N'PTE_65', N'T7, 13:30-16:30', N'P305', 8200000.00),
(N'GMATPREP-2402', '2024-06-09', '2024-09-08', 'TE016', N'GMAT_PREP', N'CN, 08:30-12:30', N'P307', 12500000.00)
GO

EXEC usp_ProcessCoursePayment @PaymentID = 'PA001', @StudentID = 'ST001', @ClassID = N'IELTS70-2401A', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA002', @StudentID = 'ST002', @ClassID = N'GEA1-2401', @PaymentAmount = 3500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA003', @StudentID = 'ST003', @ClassID = N'GEB1-2401', @PaymentAmount = 4000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA004', @StudentID = 'ST004', @ClassID = N'BECOM-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA005', @StudentID = 'ST005', @ClassID = N'GMATPREP-2401', @PaymentAmount = 12000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA006', @StudentID = 'ST006', @ClassID = N'KIDSENG-2401', @PaymentAmount = 3000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA007', @StudentID = 'ST007', @ClassID = N'IELTS70-2401B', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA008', @StudentID = 'ST008', @ClassID = N'GEA1-2401B', @PaymentAmount = 3500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA009', @StudentID = 'ST009', @ClassID = N'KIDSADV-2401', @PaymentAmount = 3200000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA010', @StudentID = 'ST010', @ClassID = N'GEA2-2401', @PaymentAmount = 3800000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA011', @StudentID = 'ST011', @ClassID = N'IELTS55-2402', @PaymentAmount = 6200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA012', @StudentID = 'ST012', @ClassID = N'TOEICB-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA013', @StudentID = 'ST013', @ClassID = N'IELTS70-2402', @PaymentAmount = 7800000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA014', @StudentID = 'ST014', @ClassID = N'GEB2-2401', @PaymentAmount = 4200000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA015', @StudentID = 'ST015', @ClassID = N'IELTS70-2403', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA016', @StudentID = 'ST016', @ClassID = N'AWPRO-2402', @PaymentAmount = 5000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA017', @StudentID = 'ST017', @ClassID = N'GEB1-2402', @PaymentAmount = 4000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA018', @StudentID = 'ST018', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA019', @StudentID = 'ST019', @ClassID = N'GEC1-2401', @PaymentAmount = 4800000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA020', @StudentID = 'ST020', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA021', @StudentID = 'ST021', @ClassID = N'GEB2-2402', @PaymentAmount = 4200000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA022', @StudentID = 'ST022', @ClassID = N'IELTSPRO-2401', @PaymentAmount = 8500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA023', @StudentID = 'ST023', @ClassID = N'KIDSENG-2402', @PaymentAmount = 3000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA024', @StudentID = 'ST024', @ClassID = N'PTE65-2401', @PaymentAmount = 8000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA025', @StudentID = 'ST025', @ClassID = N'BECOM-2402', @PaymentAmount = 4500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA026', @StudentID = 'ST026', @ClassID = N'TOEICA-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA027', @StudentID = 'ST027', @ClassID = N'IELTS55-2402', @PaymentAmount = 6200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA028', @StudentID = 'ST028', @ClassID = N'BEADV-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA029', @StudentID = 'ST029', @ClassID = N'AWPRO-2402', @PaymentAmount = 5000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA030', @StudentID = 'ST030', @ClassID = N'IELTS70-2401B', @PaymentAmount = 7500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA031', @StudentID = 'ST001', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA032', @StudentID = 'ST002', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA033', @StudentID = 'ST003', @ClassID = N'TOEICB-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA034', @StudentID = 'ST004', @ClassID = N'TOEICA-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA035', @StudentID = 'ST005', @ClassID = N'AWPRO-2401', @PaymentAmount = 5000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA036', @StudentID = 'ST007', @ClassID = N'PTE65-2401', @PaymentAmount = 8000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA037', @StudentID = 'ST014', @ClassID = N'AWPRO-2402', @PaymentAmount = 5000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA038', @StudentID = 'ST017', @ClassID = N'BECOM-2402', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA039', @StudentID = 'ST019', @ClassID = N'BECOM-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA040', @StudentID = 'ST020', @ClassID = N'TOEICA-2402', @PaymentAmount = 5500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA041', @StudentID = 'ST021', @ClassID = N'IELTS70-2402', @PaymentAmount = 7800000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA042', @StudentID = 'ST022', @ClassID = N'GEC1-2401', @PaymentAmount = 4800000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA043', @StudentID = 'ST023', @ClassID = N'GEA1-2401', @PaymentAmount = 3500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA044', @StudentID = 'ST024', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA045', @StudentID = 'ST025', @ClassID = N'IELTSPRO-2401', @PaymentAmount = 8500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA046', @StudentID = 'ST027', @ClassID = N'GEB1-2402', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA047', @StudentID = 'ST028', @ClassID = N'TOEICA-2402', @PaymentAmount = 5500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA048', @StudentID = 'ST029', @ClassID = N'KIDSADV-2401', @PaymentAmount = 3200000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA049', @StudentID = 'ST030', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA050', @StudentID = 'ST031', @ClassID = N'GEA1-2401B', @PaymentAmount = 3500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA051', @StudentID = 'ST033', @ClassID = N'BEADV-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA052', @StudentID = 'ST034', @ClassID = N'IELTS70-2401A', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA053', @StudentID = 'ST035', @ClassID = N'IELTS55-2402', @PaymentAmount = 6200000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA054', @StudentID = 'ST038', @ClassID = N'BECOM-2402', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA055', @StudentID = 'ST039', @ClassID = N'GMATPREP-2401', @PaymentAmount = 12000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA056', @StudentID = 'ST040', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA057', @StudentID = 'ST041', @ClassID = N'IELTS70-2401B', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA058', @StudentID = 'ST042', @ClassID = N'GEB2-2401', @PaymentAmount = 4200000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA059', @StudentID = 'ST043', @ClassID = N'IELTSPRO-2401', @PaymentAmount = 8500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA060', @StudentID = 'ST044', @ClassID = N'BEADV-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA061', @StudentID = 'ST045', @ClassID = N'GEB1-2402', @PaymentAmount = 4000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA062', @StudentID = 'ST047', @ClassID = N'KIDSENG-2402', @PaymentAmount = 3000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA063', @StudentID = 'ST048', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA064', @StudentID = 'ST050', @ClassID = N'IELTS70-2401A', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA065', @StudentID = 'ST051', @ClassID = N'TOEICA-2402', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA066', @StudentID = 'ST053', @ClassID = N'BECOM-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA067', @StudentID = 'ST054', @ClassID = N'IELTS70-2403', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA068', @StudentID = 'ST056', @ClassID = N'GMATPREP-2401', @PaymentAmount = 12000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA069', @StudentID = 'ST057', @ClassID = N'BEADV-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA070', @StudentID = 'ST058', @ClassID = N'GEB2-2402', @PaymentAmount = 4200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA071', @StudentID = 'ST060', @ClassID = N'IELTS70-2401A', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA072', @StudentID = 'ST061', @ClassID = N'PTE65-2401', @PaymentAmount = 8000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA073', @StudentID = 'ST062', @ClassID = N'TOEICB-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA074', @StudentID = 'ST063', @ClassID = N'IELTS70-2401B', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA075', @StudentID = 'ST064', @ClassID = N'GEB1-2401', @PaymentAmount = 4000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA076', @StudentID = 'ST031', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA077', @StudentID = 'ST034', @ClassID = N'GEA1-2401B', @PaymentAmount = 3500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA078', @StudentID = 'ST035', @ClassID = N'BEADV-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA079', @StudentID = 'ST039', @ClassID = N'TOEICA-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA080', @StudentID = 'ST040', @ClassID = N'IELTS55-2402', @PaymentAmount = 6200000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA081', @StudentID = 'ST041', @ClassID = N'AWPRO-2401', @PaymentAmount = 5000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA082', @StudentID = 'ST042', @ClassID = N'IELTS70-2402', @PaymentAmount = 7800000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA083', @StudentID = 'ST043', @ClassID = N'PTE65-2401', @PaymentAmount = 8000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA084', @StudentID = 'ST044', @ClassID = N'GEA1-2401', @PaymentAmount = 3500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA085', @StudentID = 'ST045', @ClassID = N'TOEICA-2402', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA086', @StudentID = 'ST048', @ClassID = N'IELTSPRO-2401', @PaymentAmount = 8500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA087', @StudentID = 'ST050', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA088', @StudentID = 'ST051', @ClassID = N'GEB1-2401', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA089', @StudentID = 'ST053', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA090', @StudentID = 'ST057', @ClassID = N'IELTS70-2401A', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA091', @StudentID = 'ST058', @ClassID = N'IELTS70-2402', @PaymentAmount = 7800000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA092', @StudentID = 'ST060', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA093', @StudentID = 'ST061', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA094', @StudentID = 'ST062', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA095', @StudentID = 'ST063', @ClassID = N'KIDSENG-2402', @PaymentAmount = 3000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA096', @StudentID = 'ST064', @ClassID = N'GEB1-2402', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA097', @StudentID = 'ST065', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA098', @StudentID = 'ST001', @ClassID = N'AWPRO-2401', @PaymentAmount = 5000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA099', @StudentID = 'ST002', @ClassID = N'BECOM-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA100', @StudentID = 'ST003', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA101', @StudentID = 'ST004', @ClassID = N'GEB2-2402', @PaymentAmount = 4200000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA102', @StudentID = 'ST005', @ClassID = N'IELTS70-2402', @PaymentAmount = 7800000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA103', @StudentID = 'ST007', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA104', @StudentID = 'ST008', @ClassID = N'TOEICB-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA105', @StudentID = 'ST009', @ClassID = N'KIDSENG-2402', @PaymentAmount = 3000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA106', @StudentID = 'ST011', @ClassID = N'GEA2-2401', @PaymentAmount = 3800000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA107', @StudentID = 'ST014', @ClassID = N'IELTSPRO-2401', @PaymentAmount = 8500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA108', @StudentID = 'ST017', @ClassID = N'GEC1-2401', @PaymentAmount = 4800000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA109', @StudentID = 'ST019', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA110', @StudentID = 'ST020', @ClassID = N'BEADV-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA111', @StudentID = 'ST021', @ClassID = N'IELTS70-2403', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA112', @StudentID = 'ST022', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA113', @StudentID = 'ST023', @ClassID = N'GEB1-2402', @PaymentAmount = 4000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA114', @StudentID = 'ST026', @ClassID = N'GEA1-2401B', @PaymentAmount = 3500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA115', @StudentID = 'ST027', @ClassID = N'IELTS55-2402', @PaymentAmount = 6200000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA116', @StudentID = 'ST028', @ClassID = N'PTE65-2401', @PaymentAmount = 8000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA117', @StudentID = 'ST029', @ClassID = N'AWPRO-2402', @PaymentAmount = 5000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA118', @StudentID = 'ST030', @ClassID = N'IELTS70-2402', @PaymentAmount = 7800000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA119', @StudentID = 'ST031', @ClassID = N'GEB2-2401', @PaymentAmount = 4200000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA120', @StudentID = 'ST033', @ClassID = N'TOEICA-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA121', @StudentID = 'ST034', @ClassID = N'BECOM-2402', @PaymentAmount = 4500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA122', @StudentID = 'ST035', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA123', @StudentID = 'ST038', @ClassID = N'IELTS70-2401B', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA124', @StudentID = 'ST039', @ClassID = N'IELTSPRO-2401', @PaymentAmount = 8500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA125', @StudentID = 'ST040', @ClassID = N'IELTS70-2401A', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA126', @StudentID = 'ST041', @ClassID = N'GEB2-2402', @PaymentAmount = 4200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA127', @StudentID = 'ST042', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA128', @StudentID = 'ST043', @ClassID = N'AWPRO-2402', @PaymentAmount = 5000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA129', @StudentID = 'ST044', @ClassID = N'GEA1-2401B', @PaymentAmount = 3500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA130', @StudentID = 'ST045', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA131', @StudentID = 'ST047', @ClassID = N'GEB1-2401', @PaymentAmount = 4000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA132', @StudentID = 'ST048', @ClassID = N'IELTS70-2403', @PaymentAmount = 7500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA133', @StudentID = 'ST050', @ClassID = N'BECOM-2402', @PaymentAmount = 4500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA134', @StudentID = 'ST051', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA135', @StudentID = 'ST053', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA136', @StudentID = 'ST054', @ClassID = N'TOEICB-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA137', @StudentID = 'ST056', @ClassID = N'IELTS70-2402', @PaymentAmount = 7800000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA138', @StudentID = 'ST057', @ClassID = N'GEB2-2401', @PaymentAmount = 4200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA139', @StudentID = 'ST058', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA140', @StudentID = 'ST060', @ClassID = N'TOEICA-2402', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA141', @StudentID = 'ST061', @ClassID = N'GEB1-2402', @PaymentAmount = 4000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA142', @StudentID = 'ST062', @ClassID = N'AWPRO-2401', @PaymentAmount = 5000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA143', @StudentID = 'ST063', @ClassID = N'GEA1-2401B', @PaymentAmount = 3500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA144', @StudentID = 'ST064', @ClassID = N'BECOM-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA145', @StudentID = 'ST065', @ClassID = N'IELTS70-2403', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA146', @StudentID = 'ST006', @ClassID = N'GEA1-2401', @PaymentAmount = 3500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA147', @StudentID = 'ST012', @ClassID = N'GEA2-2401', @PaymentAmount = 3800000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA148', @StudentID = 'ST013', @ClassID = N'PTE65-2401', @PaymentAmount = 8000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA149', @StudentID = 'ST015', @ClassID = N'TOEICB-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA150', @StudentID = 'ST016', @ClassID = N'GEB2-2401', @PaymentAmount = 4200000.00, @PaymentMethod = N'Momo';

EXEC usp_ProcessCoursePayment @PaymentID = 'PA151', @StudentID = 'ST066', @ClassID = N'IELTS70-2404', @PaymentAmount = 7600000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA152', @StudentID = 'ST067', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA153', @StudentID = 'ST068', @ClassID = N'GEB1-2403', @PaymentAmount = 4100000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA154', @StudentID = 'ST069', @ClassID = N'GMATPREP-2402', @PaymentAmount = 12500000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA155', @StudentID = 'ST070', @ClassID = N'TOEICA-2403', @PaymentAmount = 5700000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA156', @StudentID = 'ST071', @ClassID = N'PTE65-2402', @PaymentAmount = 8200000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA157', @StudentID = 'ST072', @ClassID = N'AWPRO-2403', @PaymentAmount = 5200000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA158', @StudentID = 'ST073', @ClassID = N'BECOM-2403', @PaymentAmount = 4700000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA159', @StudentID = 'ST074', @ClassID = N'IELTSPRO-2402', @PaymentAmount = 8800000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA160', @StudentID = 'ST075', @ClassID = N'IELTS55-2403', @PaymentAmount = 6300000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA161', @StudentID = 'ST076', @ClassID = N'GEC1-2402', @PaymentAmount = 4900000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA162', @StudentID = 'ST077', @ClassID = N'TOEICB-2402', @PaymentAmount = 4600000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA163', @StudentID = 'ST078', @ClassID = N'GEA1-2402', @PaymentAmount = 3600000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA164', @StudentID = 'ST079', @ClassID = N'BEADV-2402', @PaymentAmount = 5800000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA165', @StudentID = 'ST080', @ClassID = N'KIDSENG-2403', @PaymentAmount = 3100000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA166', @StudentID = 'ST081', @ClassID = N'GMATPREP-2401', @PaymentAmount = 12000000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA167', @StudentID = 'ST082', @ClassID = N'KIDSADV-2402', @PaymentAmount = 3300000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA168', @StudentID = 'ST083', @ClassID = N'SATPREP-2402', @PaymentAmount = 9500000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA169', @StudentID = 'ST084', @ClassID = N'IELTS70-2402', @PaymentAmount = 7800000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA170', @StudentID = 'ST085', @ClassID = N'GEA1-2401', @PaymentAmount = 3500000.00, @PaymentMethod = N'Thẻ tín dụng' -- Fails (Balance 0)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA171', @StudentID = 'ST086', @ClassID = N'TOEICA-2403', @PaymentAmount = 5700000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA172', @StudentID = 'ST087', @ClassID = N'BECOM-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA173', @StudentID = 'ST088', @ClassID = N'IELTS55-2401', @PaymentAmount = 6000000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA174', @StudentID = 'ST089', @ClassID = N'IELTSPRO-2401', @PaymentAmount = 8500000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA175', @StudentID = 'ST090', @ClassID = N'GEB2-2402', @PaymentAmount = 4200000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA176', @StudentID = 'ST091', @ClassID = N'PTE65-2402', @PaymentAmount = 8200000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA177', @StudentID = 'ST092', @ClassID = N'GEA2-2401', @PaymentAmount = 3800000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA178', @StudentID = 'ST093', @ClassID = N'AWPRO-2403', @PaymentAmount = 5200000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA179', @StudentID = 'ST094', @ClassID = N'KIDSENG-2401', @PaymentAmount = 3000000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA180', @StudentID = 'ST095', @ClassID = N'BEADV-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA181', @StudentID = 'ST096', @ClassID = N'GEB1-2401', @PaymentAmount = 4000000.00, @PaymentMethod = N'Momo' -- Fails (Balance NULL)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA182', @StudentID = 'ST097', @ClassID = N'IELTS70-2401A', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA183', @StudentID = 'ST098', @ClassID = N'GMATPREP-2402', @PaymentAmount = 12500000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA184', @StudentID = 'ST099', @ClassID = N'TOEICB-2401', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA185', @StudentID = 'ST100', @ClassID = N'IELTS55-2402', @PaymentAmount = 6200000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA186', @StudentID = 'ST001', @ClassID = N'GEC1-2402', @PaymentAmount = 4900000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA187', @StudentID = 'ST002', @ClassID = N'TOEICA-2403', @PaymentAmount = 5700000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA188', @StudentID = 'ST003', @ClassID = N'BECOM-2403', @PaymentAmount = 4700000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA189', @StudentID = 'ST004', @ClassID = N'KIDSENG-2403', @PaymentAmount = 3100000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA190', @StudentID = 'ST005', @ClassID = N'AWPRO-2403', @PaymentAmount = 5200000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA191', @StudentID = 'ST007', @ClassID = N'GEA1-2402', @PaymentAmount = 3600000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA192', @StudentID = 'ST008', @ClassID = N'GEB1-2403', @PaymentAmount = 4100000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA193', @StudentID = 'ST009', @ClassID = N'IELTS55-2403', @PaymentAmount = 6300000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA194', @StudentID = 'ST011', @ClassID = N'IELTS70-2404', @PaymentAmount = 7600000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA195', @StudentID = 'ST012', @ClassID = N'IELTSPRO-2402', @PaymentAmount = 8800000.00, @PaymentMethod = N'Chuyển khoản' -- Fails (Insufficient Balance)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA196', @StudentID = 'ST014', @ClassID = N'TOEICB-2402', @PaymentAmount = 4600000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA197', @StudentID = 'ST015', @ClassID = N'BEADV-2402', @PaymentAmount = 5800000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA198', @StudentID = 'ST016', @ClassID = N'KIDSADV-2402', @PaymentAmount = 3300000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA199', @StudentID = 'ST017', @ClassID = N'PTE65-2402', @PaymentAmount = 8200000.00, @PaymentMethod = N'Chuyển khoản' -- Fails (Insufficient Balance)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA200', @StudentID = 'ST018', @ClassID = N'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA201', @StudentID = 'ST019', @ClassID = 'GMATPREP-2402', @PaymentAmount = 12500000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA202', @StudentID = 'ST020', @ClassID = 'GEA1-2402', @PaymentAmount = 3600000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA203', @StudentID = 'ST021', @ClassID = 'GEB1-2403', @PaymentAmount = 4100000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA204', @StudentID = 'ST022', @ClassID = 'IELTS55-2403', @PaymentAmount = 6300000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA205', @StudentID = 'ST023', @ClassID = 'IELTS70-2404', @PaymentAmount = 7600000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA206', @StudentID = 'ST024', @ClassID = 'IELTSPRO-2402', @PaymentAmount = 8800000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA207', @StudentID = 'ST025', @ClassID = N'TOEICB-2402', @PaymentAmount = 4600000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA208', @StudentID = 'ST026', @ClassID = 'BECOM-2403', @PaymentAmount = 4700000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA209', @StudentID = 'ST027', @ClassID = 'KIDSENG-2403', @PaymentAmount = 3100000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA210', @StudentID = 'ST028', @ClassID = 'AWPRO-2403', @PaymentAmount = 5200000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA211', @StudentID = 'ST029', @ClassID = 'PTE65-2402', @PaymentAmount = 8200000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA212', @StudentID = 'ST030', @ClassID = 'GMATPREP-2402', @PaymentAmount = 12500000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA213', @StudentID = 'ST031', @ClassID = 'GEA2-2401', @PaymentAmount = 3800000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA214', @StudentID = 'ST032', @ClassID = 'GEB2-2401', @PaymentAmount = 4200000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA215', @StudentID = 'ST033', @ClassID = 'IELTS70-2401B', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA216', @StudentID = 'ST034', @ClassID = 'TOEICA-2401', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA217', @StudentID = 'ST035', @ClassID = 'KIDSADV-2401', @PaymentAmount = 3200000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA218', @StudentID = 'ST036', @ClassID = 'SATPREP-2401', @PaymentAmount = 9000000.00, @PaymentMethod = N'Thẻ tín dụng' -- Fails (Insufficient Balance)
EXEC usp_ProcessCoursePayment @PaymentID = 'PA219', @StudentID = 'ST037', @ClassID = 'AWPRO-2401', @PaymentAmount = 5000000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA220', @StudentID = 'ST038', @ClassID = 'GEA1-2402', @PaymentAmount = 3600000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA221', @StudentID = 'ST039', @ClassID = 'BECOM-2403', @PaymentAmount = 4700000.00, @PaymentMethod = N'Momo'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA222', @StudentID = 'ST040', @ClassID = 'IELTSPRO-2402', @PaymentAmount = 8800000.00, @PaymentMethod = N'Thẻ tín dụng'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA223', @StudentID = 'ST041', @ClassID = 'GEC1-2402', @PaymentAmount = 4900000.00, @PaymentMethod = N'Chuyển khoản'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA224', @StudentID = 'ST042', @ClassID = 'PTE65-2402', @PaymentAmount = 8200000.00, @PaymentMethod = N'Tiền mặt'
EXEC usp_ProcessCoursePayment @PaymentID = 'PA225', @StudentID = 'ST043', @ClassID = 'KIDSENG-2403', @PaymentAmount = 3100000.00, @PaymentMethod = N'Momo'
GO


INSERT INTO Exam (id, date, description, class_id, exam_type, duration_minutes) VALUES
('EX001', '2024-02-26', N'Midterm Test', N'GEA1-2401', N'Midterm', 60), ('EX002', '2024-04-08', N'Final Test', N'GEA1-2401', N'Final', 90),
('EX003', '2024-02-27', N'Midterm Test', N'GEA2-2401', N'Midterm', 60), ('EX004', '2024-04-09', N'Final Test', N'GEA2-2401', N'Final', 90),
('EX005', '2024-02-26', N'Midterm Test', N'GEB1-2401', N'Midterm', 75), ('EX006', '2024-04-08', N'Final Test', N'GEB1-2401', N'Final', 100),
('EX007', '2024-02-27', N'Midterm Test', N'GEB2-2401', N'Midterm', 75), ('EX008', '2024-04-09', N'Final Test', N'GEB2-2401', N'Final', 100),
('EX009', '2024-03-18', N'Midterm Test', N'GEC1-2401', N'Midterm', 90), ('EX010', '2024-04-29', N'Final Test', N'GEC1-2401', N'Final', 120),
('EX011', '2024-03-02', N'Mock Test 1', N'IELTS55-2401', N'Mock Test', 150), ('EX012', '2024-04-13', N'Final Mock Test', N'IELTS55-2401', N'Final', 180),
('EX013', '2024-03-02', N'Mock Test 1', N'IELTS70-2401A', N'Mock Test', 180), ('EX014', '2024-04-13', N'Final Mock Test', N'IELTS70-2401A', N'Final', 180),
('EX015', '2024-03-03', N'Mock Test 1', N'IELTS70-2401B', N'Mock Test', 180), ('EX016', '2024-04-14', N'Final Mock Test', N'IELTS70-2401B', N'Final', 180),
('EX017', '2024-03-16', N'Speaking Test 1', N'IELTSPRO-2401', N'Speaking Test', 20), ('EX018', '2024-04-27', N'Writing Final Exam', N'IELTSPRO-2401', N'Final', 120),
('EX019', '2024-02-26', N'Midterm Test', N'TOEICB-2401', N'Midterm', 90), ('EX020', '2024-04-08', N'Final Test', N'TOEICB-2401', N'Final', 120),
('EX021', '2024-02-26', N'Midterm Test', N'TOEICA-2401', N'Midterm', 120), ('EX022', '2024-04-08', N'Final Test', N'TOEICA-2401', N'Final', 120),
('EX023', '2024-02-27', N'Midterm Presentation', N'BECOM-2401', N'Speaking Test', 30), ('EX024', '2024-04-09', N'Final Exam', N'BECOM-2401', N'Final', 90),
('EX025', '2024-03-19', N'Midterm Case Study', N'BEADV-2401', N'Midterm', 120), ('EX026', '2024-04-30', N'Final Negotiation Exam', N'BEADV-2401', N'Speaking Test', 45),
('EX027', '2024-03-02', N'Mid-course Test', N'KIDSENG-2401', N'Midterm', 45), ('EX028', '2024-04-13', N'Final Game Day', N'KIDSENG-2401', N'Final', 60),
('EX029', '2024-03-03', N'Mid-course Test', N'KIDSADV-2401', N'Midterm', 45), ('EX030', '2024-04-14', N'Final Project', N'KIDSADV-2401', N'Final', 60),
('EX031', '2024-03-17', N'Midterm Essay', N'AWPRO-2401', N'Midterm', 90), ('EX032', '2024-04-21', N'Final Research Paper', N'AWPRO-2401', N'Final', 120),
('EX033', '2024-03-23', N'Mock Test 1', N'PTE65-2401', N'Mock Test', 120), ('EX034', '2024-05-04', N'Final Mock Test', N'PTE65-2401', N'Final', 120),
('EX035', '2024-03-09', N'Diagnostic Test', N'SATPREP-2401', N'Mock Test', 180), ('EX036', '2024-04-27', N'Final Practice Test', N'SATPREP-2401', N'Final', 180),
('EX037', '2024-03-10', N'Diagnostic Test', N'GMATPREP-2401', N'Mock Test', 180), ('EX038', '2024-04-28', N'Final Practice Test', N'GMATPREP-2401', N'Final', 180),
('EX039', '2024-02-27', N'Midterm Test', N'GEA1-2401B', N'Midterm', 60), ('EX040', '2024-04-09', N'Final Test', N'GEA1-2401B', N'Final', 90),
('EX041', '2024-03-25', N'Midterm Test', N'GEB1-2402', N'Midterm', 75), ('EX042', '2024-05-06', N'Final Test', N'GEB1-2402', N'Final', 100),
('EX043', '2024-03-26', N'Mock Test 1', N'IELTS70-2402', N'Mock Test', 180), ('EX044', '2024-05-07', N'Final Mock Test', N'IELTS70-2402', N'Final', 180),
('EX045', '2024-04-01', N'Midterm Test', N'TOEICA-2402', N'Midterm', 120), ('EX046', '2024-05-13', N'Final Test', N'TOEICA-2402', N'Final', 120),
('EX047', '2024-04-02', N'Midterm Exam', N'BECOM-2402', N'Midterm', 90), ('EX048', '2024-05-14', N'Final Exam', N'BECOM-2402', N'Final', 90),
('EX049', '2024-03-03', N'Mid-course Test', N'KIDSENG-2402', N'Midterm', 45), ('EX050', '2024-04-14', N'Final Game Day', N'KIDSENG-2402', N'Final', 60),
('EX051', '2024-03-31', N'Mock Test 1', N'IELTS55-2402', N'Mock Test', 150), ('EX052', '2024-05-12', N'Final Mock Test', N'IELTS55-2402', N'Final', 180),
('EX053', '2024-04-01', N'Midterm Test', N'GEB2-2402', N'Midterm', 75), ('EX054', '2024-05-13', N'Final Test', N'GEB2-2402', N'Final', 100),
('EX055', '2024-04-07', N'Diagnostic Test', N'SATPREP-2402', N'Mock Test', 180), ('EX056', '2024-05-26', N'Final Practice Test', N'SATPREP-2402', N'Final', 180),
('EX057', '2024-04-13', N'Midterm Essay', N'AWPRO-2402', N'Midterm', 90), ('EX058', '2024-05-18', N'Final Research Paper', N'AWPRO-2402', N'Final', 120),
('EX059', '2024-04-15', N'Mock Test 1', N'IELTS70-2403', N'Mock Test', 180), ('EX060', '2024-05-27', N'Final Mock Test', N'IELTS70-2403', N'Final', 180),
('EX061', '2024-03-02', N'Speaking Quiz 1', N'IELTS70-2401A', N'Speaking Test', 15),
('EX062', '2024-03-02', N'Writing Quiz 1', N'IELTS70-2401A', N'Quiz', 40),
('EX063', '2024-03-03', N'Speaking Quiz 1', N'IELTS70-2401B', N'Speaking Test', 15),
('EX064', '2024-03-03', N'Writing Quiz 1', N'IELTS70-2401B', N'Quiz', 40),
('EX065', '2024-03-26', N'Speaking Quiz 1', N'IELTS70-2402', N'Speaking Test', 15),
('EX066', '2024-03-26', N'Writing Quiz 1', N'IELTS70-2402', N'Quiz', 40),
('EX067', '2024-04-15', N'Speaking Quiz 1', N'IELTS70-2403', N'Speaking Test', 15),
('EX068', '2024-04-15', N'Writing Quiz 1', N'IELTS70-2403', N'Quiz', 40),
('EX069', '2024-02-27', N'Listening Quiz', N'TOEICA-2401', N'Quiz', 45),
('EX070', '2024-04-02', N'Listening Quiz', N'TOEICA-2402', N'Quiz', 45),
('EX071', '2024-03-09', N'Math Section Test', N'SATPREP-2401', N'Quiz', 75),
('EX072', '2024-04-07', N'Verbal Section Test', N'SATPREP-2402', N'Quiz', 75),
('EX073', '2024-03-10', N'Quantitative Test', N'GMATPREP-2401', N'Quiz', 75),
('EX074', '2024-03-17', N'Essay Draft 1', N'AWPRO-2401', N'Quiz', 60),
('EX075', '2024-04-13', N'Essay Draft 1', N'AWPRO-2402', N'Quiz', 60),
('EX076', '2024-06-20', N'Midterm Test A1-2', N'GEA1-2402', N'Midterm', 60), 
('EX077', '2024-07-29', N'Final Test A1-2', N'GEA1-2402', N'Final', 90),
('EX078', '2024-06-21', N'Midterm Test B1-3', N'GEB1-2403', N'Midterm', 75), 
('EX079', '2024-07-30', N'Final Test B1-3', N'GEB1-2403', N'Final', 100),
('EX080', '2024-07-15', N'Midterm Test C1-2', N'GEC1-2402', N'Midterm', 90), 
('EX081', '2024-08-26', N'Final Test C1-2', N'GEC1-2402', N'Final', 120),
('EX082', '2024-07-13', N'Mock Test 1', N'IELTS55-2403', N'Mock Test', 150), 
('EX083', '2024-08-24', N'Final Mock Test', N'IELTS55-2403', N'Final', 180),
('EX084', '2024-07-20', N'Mock Test 1', N'IELTS70-2404', N'Mock Test', 180), 
('EX085', '2024-08-31', N'Final Mock Test', N'IELTS70-2404', N'Final', 180),
('EX086', '2024-07-13', N'Speaking Test 1', N'IELTSPRO-2402', N'Speaking Test', 20), 
('EX087', '2024-08-24', N'Writing Final Exam', N'IELTSPRO-2402', N'Final', 120),
('EX088', '2024-06-20', N'Midterm Test', N'TOEICB-2402', N'Midterm', 90), 
('EX089', '2024-07-29', N'Final Test', N'TOEICB-2402', N'Final', 120),
('EX090', '2024-07-15', N'Midterm Test', N'TOEICA-2403', N'Midterm', 120), 
('EX091', '2024-08-26', N'Final Test', N'TOEICA-2403', N'Final', 120),
('EX092', '2024-07-16', N'Midterm Presentation', N'BECOM-2403', N'Speaking Test', 30), 
('EX093', '2024-08-27', N'Final Exam', N'BECOM-2403', N'Final', 90),
('EX094', '2024-07-16', N'Midterm Case Study', N'BEADV-2402', N'Midterm', 120), 
('EX095', '2024-08-27', N'Final Negotiation Exam', N'BEADV-2402', N'Speaking Test', 45),
('EX096', '2024-07-13', N'Mid-course Test', N'KIDSENG-2403', N'Midterm', 45), 
('EX097', '2024-08-24', N'Final Game Day', N'KIDSENG-2403', N'Final', 60),
('EX098', '2024-07-14', N'Mid-course Test', N'KIDSADV-2402', N'Midterm', 45), 
('EX099', '2024-08-25', N'Final Project', N'KIDSADV-2402', N'Final', 60),
('EX100', '2024-07-14', N'Midterm Essay', N'AWPRO-2403', N'Midterm', 90), 
('EX101', '2024-08-18', N'Final Research Paper', N'AWPRO-2403', N'Final', 120),
('EX102', '2024-07-20', N'Mock Test 1', N'PTE65-2402', N'Mock Test', 120), 
('EX103', '2024-08-31', N'Final Mock Test', N'PTE65-2402', N'Final', 120),
('EX104', '2024-07-21', N'Diagnostic Test', N'GMATPREP-2402', N'Mock Test', 180), 
('EX105', '2024-09-01', N'Final Practice Test', N'GMATPREP-2402', N'Final', 180)
GO

INSERT INTO Exam_Result (student_id, exam_id, value, date) VALUES
('ST001', 'EX013', 7.0, '2024-03-05'), ('ST001', 'EX014', 6.5, '2024-04-16'),
('ST002', 'EX001', 8.0, '2024-02-29'), ('ST002', 'EX002', 8.5, '2024-04-11'),
('ST003', 'EX005', 7.5, '2024-02-29'), ('ST003', 'EX006', 8.0, '2024-04-11'),
('ST004', 'EX023', 8.5, '2024-03-01'), ('ST004', 'EX024', 8.0, '2024-04-12'),
('ST005', 'EX037', 8.0, '2024-03-13'), ('ST005', 'EX038', 8.5, '2024-05-01'),
('ST007', 'EX015', 6.5, '2024-03-06'), ('ST007', 'EX016', 7.0, '2024-04-17'),
('ST008', 'EX039', 7.0, '2024-03-01'), ('ST008', 'EX040', 7.5, '2024-04-12'),
('ST009', 'EX029', 9.5, '2024-03-06'), ('ST009', 'EX030', 9.0, '2024-04-17'),
('ST011', 'EX051', 6.0, '2024-04-03'), ('ST011', 'EX052', 6.5, '2024-05-15'),
('ST012', 'EX019', 5.5, '2024-02-29'), ('ST012', 'EX020', 6.5, '2024-04-11'),
('ST013', 'EX043', 7.5, '2024-03-29'), ('ST013', 'EX044', 8.0, '2024-05-10'),
('ST014', 'EX007', 7.0, '2024-02-27'), ('ST014', 'EX008', 7.5, '2024-04-09'),
('ST015', 'EX059', 6.0, '2024-04-15'), ('ST015', 'EX060', 6.5, '2024-05-27'),
('ST016', 'EX057', 8.0, '2024-04-13'), ('ST016', 'EX058', 8.5, '2024-05-18'),
('ST017', 'EX041', 7.0, '2024-03-28'), ('ST017', 'EX042', 7.5, '2024-05-09'),
('ST018', 'EX013', 8.5, '2024-03-05'), ('ST018', 'EX014', 9.0, '2024-04-16'),
('ST019', 'EX009', 8.5, '2024-03-21'), ('ST019', 'EX010', 9.0, '2024-05-02'),
('ST020', 'EX055', 7.5, '2024-04-07'), ('ST020', 'EX056', 8.0, '2024-05-26'),
('ST021', 'EX053', 8.0, '2024-04-01'), ('ST021', 'EX054', 8.5, '2024-05-13'),
('ST022', 'EX017', 9.0, '2024-03-19'), ('ST022', 'EX018', 9.5, '2024-05-01'),
('ST023', 'EX049', 8.5, '2024-03-06'), ('ST023', 'EX050', 9.0, '2024-04-17'),
('ST024', 'EX033', 8.0, '2024-03-23'), ('ST024', 'EX034', 8.5, '2024-05-04'),
('ST025', 'EX047', 7.5, '2024-04-02'), ('ST025', 'EX048', 8.0, '2024-05-14'),
('ST026', 'EX021', 8.0, '2024-02-26'), ('ST026', 'EX022', 8.5, '2024-04-08'),
('ST027', 'EX009', 8.5, '2024-03-21'), ('ST027', 'EX010', 9.0, '2024-05-02'),
('ST028', 'EX025', 7.0, '2024-03-19'), ('ST028', 'EX026', 7.5, '2024-04-30'),
('ST029', 'EX007', 8.0, '2024-02-27'), ('ST029', 'EX008', 8.5, '2024-04-09'),
('ST030', 'EX025', 7.5, '2024-03-19'), ('ST030', 'EX026', 8.0, '2024-04-30'),
('ST078', 'EX076', 7.0, '2024-06-21'), ('ST078', 'EX077', 7.5, '2024-07-30'),
('ST091', 'EX076', 8.0, '2024-06-21'), ('ST091', 'EX077', 8.5, '2024-07-30'),
('ST068', 'EX078', 6.5, '2024-06-22'), ('ST068', 'EX079', 7.0, '2024-07-31'),
('ST076', 'EX080', 8.5, '2024-07-16'), ('ST076', 'EX081', 9.0, '2024-08-27'),
('ST001', 'EX080', 7.5, '2024-07-16'), ('ST001', 'EX081', 8.0, '2024-08-27'),
('ST075', 'EX082', 5.5, '2024-07-14'), ('ST075', 'EX083', 6.0, '2024-08-25'),
('ST009', 'EX082', 5.0, '2024-07-14'), ('ST009', 'EX083', 5.5, '2024-08-25'),
('ST066', 'EX084', 7.0, '2024-07-21'), ('ST066', 'EX085', 7.5, '2024-09-01'),
('ST011', 'EX084', 6.5, '2024-07-21'), ('ST011', 'EX085', 7.0, '2024-09-01'),
('ST023', 'EX084', 6.0, '2024-07-21'), ('ST023', 'EX085', 6.5, '2024-09-01'),
('ST074', 'EX086', 8.0, '2024-07-14'), ('ST074', 'EX087', 8.5, '2024-08-25'),
('ST039', 'EX086', 7.5, '2024-07-14'), ('ST039', 'EX087', 8.0, '2024-08-25'),
('ST077', 'EX088', 6.0, '2024-06-21'), ('ST077', 'EX089', 6.5, '2024-07-30'),
('ST014', 'EX088', 7.0, '2024-06-21'), ('ST014', 'EX089', 7.5, '2024-07-30'),
('ST070', 'EX090', 8.0, '2024-07-16'), ('ST070', 'EX091', 8.5, '2024-08-27'),
('ST002', 'EX090', 7.5, '2024-07-16'), ('ST002', 'EX091', 8.0, '2024-08-27'),
('ST073', 'EX092', 7.0, '2024-07-17'), ('ST073', 'EX093', 7.5, '2024-08-28'),
('ST003', 'EX092', 8.0, '2024-07-17'), ('ST003', 'EX093', 8.5, '2024-08-28'),
('ST026', 'EX092', 6.5, '2024-07-17'), ('ST026', 'EX093', 7.0, '2024-08-28'),
('ST079', 'EX094', 8.5, '2024-07-17'), ('ST079', 'EX095', 9.0, '2024-08-28'),
('ST015', 'EX094', 7.5, '2024-07-17'), ('ST015', 'EX095', 8.0, '2024-08-28'),
('ST080', 'EX096', 9.0, '2024-07-14'), ('ST080', 'EX097', 9.5, '2024-08-25'),
('ST027', 'EX096', 8.5, '2024-07-14'), ('ST027', 'EX097', 9.0, '2024-08-25'),
('ST016', 'EX098', 8.5, '2024-07-15'), ('ST016', 'EX099', 8.0, '2024-08-26'),
('ST072', 'EX100', 7.0, '2024-07-15'), ('ST072', 'EX101', 7.5, '2024-08-19'),
('ST029', 'EX100', 8.0, '2024-07-15'), ('ST029', 'EX101', 8.5, '2024-08-19'),
('ST071', 'EX102', 7.5, '2024-07-21'), ('ST071', 'EX103', 8.0, '2024-09-01'),
('ST011', 'EX102', 6.5, '2024-07-21'), ('ST011', 'EX103', 7.0, '2024-09-01'),
('ST042', 'EX102', 7.0, '2024-07-21'), ('ST042', 'EX103', 7.5, '2024-09-01'),
('ST069', 'EX104', 8.0, '2024-07-22'), ('ST069', 'EX105', 8.5, '2024-09-02'),
('ST019', 'EX104', 7.0, '2024-07-22'), ('ST019', 'EX105', 7.5, '2024-09-02'),
('ST098', 'EX104', 8.5, '2024-07-22'), ('ST098', 'EX105', 9.0, '2024-09-02'),
('ST001', 'EX071', 8.50, '2024-03-12'),
('ST002', 'EX011', 5.50, '2024-03-05'), ('ST002', 'EX012', 6.00, '2024-04-16'),
('ST003', 'EX041', 7.00, '2024-03-28'), ('ST003', 'EX042', 7.50, '2024-05-09'),
('ST004', 'EX069', 7.50, '2024-03-01'), ('ST004', 'EX053', 8.00, '2024-04-04'),
('ST005', 'EX073', 8.50, '2024-03-13'), ('ST005', 'EX074', 8.00, '2024-03-20'),
('ST007', 'EX063', 7.00, '2024-03-06'), ('ST007', 'EX064', 7.50, '2024-03-06'),
('ST008', 'EX001', 6.50, '2024-02-29'), ('ST008', 'EX002', 7.00, '2024-04-11'),
('ST009', 'EX049', 9.00, '2024-03-06'), ('ST009', 'EX050', 9.50, '2024-04-17'),
('ST013', 'EX065', 7.00, '2024-03-29'), ('ST013', 'EX066', 7.50, '2024-03-29'),
('ST014', 'EX031', 7.50, '2024-03-20'), ('ST014', 'EX032', 8.00, '2024-04-24'),
('ST015', 'EX067', 6.50, '2024-04-18'), ('ST015', 'EX068', 7.00, '2024-04-18'),
('ST016', 'EX031', 8.00, '2024-03-20'), ('ST016', 'EX032', 8.50, '2024-04-24'),
('ST017', 'EX023', 7.50, '2024-03-01'), ('ST017', 'EX024', 8.00, '2024-04-12'),
('ST018', 'EX011', 5.00, '2024-03-05'), ('ST018', 'EX012', 5.50, '2024-04-16'),
('ST019', 'EX023', 8.00, '2024-03-01'), ('ST019', 'EX024', 8.50, '2024-04-12'),
('ST020', 'EX072', 8.00, '2024-04-10'), ('ST020', 'EX070', 7.50, '2024-04-05'),
('ST021', 'EX013', 7.00, '2024-03-05'), ('ST021', 'EX014', 7.50, '2024-04-16'),
('ST022', 'EX009', 8.00, '2024-03-21'), ('ST022', 'EX010', 8.50, '2024-05-02'),
('ST023', 'EX001', 8.50, '2024-02-29'), ('ST023', 'EX002', 9.00, '2024-04-11'),
('ST024', 'EX017', 8.50, '2024-03-19'), ('ST024', 'EX018', 9.00, '2024-05-01'),
('ST025', 'EX017', 8.00, '2024-03-19'), ('ST025', 'EX018', 8.50, '2024-05-01'),
('ST027', 'EX051', 6.00, '2024-04-03'), ('ST027', 'EX052', 6.50, '2024-05-15'),
('ST028', 'EX045', 7.00, '2024-04-03'), ('ST028', 'EX046', 7.50, '2024-05-15'),
('ST029', 'EX057', 8.00, '2024-04-16'), ('ST029', 'EX058', 8.50, '2024-05-21'),
('ST030', 'EX067', 7.50, '2024-04-18'), ('ST030', 'EX068', 8.00, '2024-04-18'),
('ST031', 'EX039', 7.00, '2024-03-01'), ('ST031', 'EX040', 7.50, '2024-04-12'),
('ST035', 'EX051', 5.50, '2024-04-03'), ('ST035', 'EX052', 6.00, '2024-05-15'),
('ST038', 'EX023', 8.50, '2024-03-01'), ('ST038', 'EX024', 9.00, '2024-04-12'),
('ST039', 'EX071', 8.00, '2024-03-12'), ('ST039', 'EX037', 8.50, '2024-03-13'),
('ST040', 'EX072', 7.50, '2024-04-10'), ('ST040', 'EX051', 6.50, '2024-04-03'),
('ST041', 'EX057', 7.50, '2024-04-16'), ('ST041', 'EX058', 8.00, '2024-05-21'),
('ST042', 'EX043', 7.00, '2024-03-29'), ('ST042', 'EX044', 7.50, '2024-05-10'),
('ST043', 'EX017', 8.00, '2024-03-19'), ('ST043', 'EX018', 8.50, '2024-05-01'),
('ST044', 'EX025', 7.00, '2024-03-22'), ('ST044', 'EX026', 7.50, '2024-05-03'),
('ST045', 'EX041', 7.50, '2024-03-28'), ('ST045', 'EX042', 8.00, '2024-05-09'),
('ST047', 'EX049', 9.00, '2024-03-06'), ('ST047', 'EX050', 9.50, '2024-04-17'),
('ST048', 'EX011', 5.50, '2024-03-05'), ('ST048', 'EX012', 6.00, '2024-04-16'),
('ST050', 'EX059', 7.00, '2024-04-18'), ('ST050', 'EX060', 7.50, '2024-05-30'),
('ST051', 'EX045', 7.50, '2024-04-03'), ('ST051', 'EX046', 8.00, '2024-05-15'),
('ST056', 'EX037', 8.50, '2024-03-13'), ('ST056', 'EX038', 9.00, '2024-05-01'),
('ST057', 'EX025', 7.00, '2024-03-22'), ('ST057', 'EX026', 7.50, '2024-05-03'),
('ST058', 'EX043', 7.50, '2024-03-29'), ('ST058', 'EX044', 8.00, '2024-05-10'),
('ST060', 'EX061', 6.00, '2024-03-05'), ('ST060', 'EX062', 6.50, '2024-03-05'),
('ST062', 'EX019', 6.00, '2024-02-29'), ('ST062', 'EX020', 6.50, '2024-04-11'),
('ST063', 'EX063', 7.00, '2024-03-06'), ('ST063', 'EX064', 7.50, '2024-03-06'),
('ST064', 'EX005', 7.50, '2024-02-29'), ('ST064', 'EX006', 8.00, '2024-04-11'),
('ST070', 'EX069', 8.50, '2024-07-19'),('ST071', 'EX033', 7.00, '2024-07-24'),
('ST072', 'EX074', 8.00, '2024-07-18'),('ST073', 'EX023', 7.00, '2024-07-19'),
('ST074', 'EX061', 8.50, '2024-07-17'),('ST075', 'EX011', 5.00, '2024-07-16'),
('ST076', 'EX009', 8.00, '2024-07-18'),('ST077', 'EX019', 6.50, '2024-06-24'),
('ST078', 'EX001', 7.50, '2024-06-24'),('ST079', 'EX025', 9.00, '2024-07-19'),
('ST080', 'EX027', 9.50, '2024-07-16'),('ST081', 'EX073', 8.50, '2024-03-13'),
('ST082', 'EX029', 9.00, '2024-07-17'),('ST083', 'EX072', 8.00, '2024-04-10'),
('ST084', 'EX065', 7.50, '2024-03-29'), ('ST084', 'EX066', 8.00, '2024-03-29'),
('ST086', 'EX021', 8.00, '2024-07-18'), ('ST086', 'EX022', 8.50, '2024-08-29'),
('ST087', 'EX023', 7.50, '2024-03-01'), ('ST087', 'EX024', 8.00, '2024-04-12'),
('ST088', 'EX011', 5.00, '2024-03-05'), ('ST088', 'EX012', 5.50, '2024-04-16'),
('ST089', 'EX017', 8.50, '2024-03-19'), ('ST089', 'EX018', 9.00, '2024-05-01'),
('ST090', 'EX053', 7.00, '2024-04-04'), ('ST090', 'EX054', 7.50, '2024-05-16'),
('ST092', 'EX003', 7.00, '2024-03-01'), ('ST092', 'EX004', 7.50, '2024-04-12'),
('ST093', 'EX031', 8.00, '2024-07-17'), ('ST093', 'EX032', 8.50, '2024-08-21'),
('ST094', 'EX027', 9.00, '2024-03-05'), ('ST094', 'EX028', 9.50, '2024-04-16'),
('ST095', 'EX025', 8.00, '2024-03-22'), ('ST095', 'EX026', 8.50, '2024-05-03'),
('ST097', 'EX061', 7.00, '2024-03-05'), ('ST097', 'EX062', 7.50, '2024-03-05'),
('ST098', 'EX037', 8.00, '2024-07-24'), ('ST098', 'EX038', 8.50, '2024-09-04'),
('ST099', 'EX019', 6.50, '2024-02-29'), ('ST099', 'EX020', 7.00, '2024-04-11'),
('ST100', 'EX051', 6.00, '2024-04-03'), ('ST100', 'EX052', 6.50, '2024-05-15')
GO

/* Testing if needed 
SELECT * FROM Teacher ORDER BY id;
SELECT * FROM Student ORDER BY id;
SELECT * FROM Course ORDER BY id;
SELECT * FROM Course_Material ORDER BY id;
SELECT * FROM Class ORDER BY course_id, id;
SELECT * FROM Class_Student ORDER BY class_id, student_id;
SELECT * FROM Exam ORDER BY class_id, date;
SELECT * FROM Exam_Result ORDER BY student_id, exam_id;
SELECT * FROM Payment ORDER BY id;
GO
*/
