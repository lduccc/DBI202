USE EducateDB
GO

---Clear data if exists
DELETE FROM Grade
DELETE FROM Payment
DELETE FROM Class_Student
DELETE FROM Exam
DELETE FROM Course_Material
DELETE FROM Class
DELETE FROM Course
DELETE FROM AuditLog
DELETE FROM Student
DELETE FROM Teacher
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
('ST001', N'An', N'Nguyễn Văn', '2003-05-15', N'Nam', 'an.nv@email.com', '0911111111', N'123 Đường Láng, Đống Đa', N'Hà Nội', 'annv', 'pass123', 15000000.00, '2023-01-10'),
('ST002', N'Bình', N'Trần Thị', '2004-02-20', N'Nữ', 'binh.tt@email.com', '0922222222', N'456 Phố Huế, Hai Bà Trưng', N'Hà Nội', 'binhtt', 'pass123', 10000000.00, '2023-01-11'),
('ST003', N'Cường', N'Lê Văn', '2002-09-01', N'Nam', 'cuong.lv@email.com', '0933333333', N'789 Kim Mã, Ba Đình', N'Hà Nội', 'cuonglv', 'pass123', 7500000.00, '2023-01-12'),
('ST004', N'Dung', N'Phạm Thị', '2003-11-30', N'Nữ', 'dung.pt@email.com', '0944444444', N'101 Cầu Giấy, Cầu Giấy', N'Hà Nội', 'dungpt', 'pass123', 8000000.00, '2023-01-13'),
('ST005', N'Giang', N'Hoàng Văn', '2001-07-14', N'Nam', 'giang.hv@email.com', '0955555555', N'212 Nguyễn Trãi, Thanh Xuân', N'Hà Nội', 'gianghv', 'pass123', 12000000.00, '2023-01-14'),
('ST006', N'Hà', N'Vũ Thu', '2002-11-03', N'Nữ', 'ha.vt@email.com', '0917778888', N'5 Đường Láng Hạ, Ba Đình', N'Hà Nội', 'havt', 'pass123', 0, '2023-02-20'),
('ST007', N'Sơn', N'Đặng Bá', '1999-07-30', N'Nam', 'son.db@email.com', '0916669999', N'18 Phố Huế, Hai Bà Trưng', N'Hà Nội', 'sondb', 'pass123', 9000000.00, '2023-03-01'),
('ST008', N'Thảo', N'Đỗ Phương', '2003-03-25', N'Nữ', 'thao.dp@email.com', '0915556666', N'Khu tập thể Thành Công, Ba Đình', N'Hà Nội', 'thaodp', 'pass123', 2500000.00, '2023-03-15'),
('ST009', N'Minh Anh', N'Phạm', '2002-09-10', N'Nữ', 'minhanh.p@email.com', '0933333333', N'12 Đường Thanh Niên, Tây Hồ', N'Hà Nội', 'minhanhp', 'pass123', 6000000.00, '2023-04-01'),
('ST010', N'Khải', N'Trần Đăng', '2000-01-20', N'Nam', 'khai.td@email.com', '0922222222', N'45 Phố Xã Đàn, Đống Đa', N'Hà Nội', 'khaitd', 'pass123', NULL, '2023-04-10'),
('ST011', N'Ngọc', N'Lê Thị Bích', '2003-05-05', N'Nữ', 'ngoc.ltb@email.com', '0944444444', N'100 Phố Hàng Gai, Hoàn Kiếm', N'Hải Phòng', 'ngocltb', 'pass123', 5500000.00, '2023-05-01'),
('ST012', N'Tuấn Anh', N'Vũ', '2001-10-10', N'Nam', 'tuananh.v@email.com', '0955555555', N'25 Đường Lê Hồng Phong', N'Nam Định', 'tuananhv', 'pass123', 0., '2023-05-05'),
('ST013', N'Giang', N'Hoàng Thùy', '2002-07-14', N'Nữ', 'giang.ht@email.com', '0988777666', N'24 Phố Lý Thái Tổ, Hoàn Kiếm', N'Hà Nội', 'gianght', 'pass123', NULL, '2023-05-10'),
('ST014', N'Hiếu', N'Đinh Trung', '1999-01-08', N'Nam', 'hieu.dt@email.com', '0977888999', N'99 Phố Nguyễn Khuyến, Đống Đa', N'Hà Nội', 'hieudt', 'pass123', 4000000.00, '2023-05-11'),
('ST015', N'Trang', N'Vũ Huyền', '2003-11-30', N'Nữ', 'trang.vh@email.com', '0966555444', N'3 Ngõ 15, Duy Tân, Cầu Giấy', N'Hà Nội', 'trangvh', 'pass123', NULL, '2023-05-12'),
('ST016', N'Duy', N'Nguyễn Quang', '2004-06-20', N'Nam', 'duy.nq@email.com', '0955444333', N'1 Trần Phú', N'Bắc Ninh', 'duynq', 'pass123', 0, '2023-05-13'),
('ST017', N'Hương', N'Bùi Thị', '2000-02-19', N'Nữ', 'huong.bt@email.com', '0944333222', N'2 Bạch Đằng', N'Đà Nẵng', 'huongbt', 'pass123', 8000000.00, '2023-05-14'),
('ST018', N'Việt', N'Lý Hoàng', '1997-08-01', N'Nam', 'viet.lh@email.com', '0933222111', N'88 Phố Hàng Bông, Hoàn Kiếm', N'Hà Nội', 'vietlh', 'pass123', 0, '2023-05-15'),
('ST019', N'Nga', N'Ngô Thị', '2003-10-02', N'Nữ', 'nga.nt@email.com', '0922111000', N'11 Ngõ 19, Lạc Long Quân', N'Hà Nội', 'ngant', 'pass123', 2000000.00, '2023-05-16'),
('ST020', N'Thành', N'Phạm Công', '2001-04-12', N'Nam', 'thanh.pc@email.com', '0911000111', N'7 Phố Tràng Tiền, Hoàn Kiếm', N'Hà Nội', 'thanhpc', 'pass123', 5000000.00, '2023-05-17'),
('ST021', N'Yến', N'Nguyễn Hải', '2002-03-08', N'Nữ', 'yen.nh@email.com', '0912121212', N'10 Phan Chu Trinh, Hoàn Kiếm', N'Hà Nội', 'yennh', 'pass123', 7000000.00, '2023-06-01'),
('ST022', N'Bảo', N'Lý Quốc', '1999-06-15', N'Nam', 'bao.lq@email.com', '0913131313', N'20 Đường Kim Mã, Ba Đình', N'Hà Nội', 'baolq', 'pass123', 15000000.00, '2023-06-02'),
('ST023', N'Chi', N'Đinh Thùy', '2004-01-01', N'Nữ', 'chi.dt@email.com', '0914141414', N'30 Phố Đội Cấn, Ba Đình', N'Hà Nội', 'chidt', 'pass123', 5000000.00, '2023-06-03'),
('ST024', N'Đạt', N'Nguyễn Tiến', '2001-12-24', N'Nam', 'dat.nt@email.com', '0915151515', N'40 Đường Láng, Đống Đa', N'Hà Nội', 'datnt', 'pass123', 4500000.00, '2023-06-04'),
('ST025', N'Oanh', N'Hoàng Kiều', '2002-08-30', N'Nữ', 'oanh.hk@email.com', '0916161616', N'50 Phố Thái Thịnh, Đống Đa', N'Hà Nội', 'oanhhk', 'pass123', NULL, '2023-06-05'),
('ST026', N'Dũng', N'Nguyễn Chí', '2000-05-18', N'Nam', 'dung.nc@email.com', '0917171717', N'60 Trần Duy Hưng, Cầu Giấy', N'Hà Nội', 'dungnc', 'pass123', 5000000.00, '2023-06-06'),
('ST027', N'Hằng', N'Lê Thu', '2003-09-12', N'Nữ', 'hang.lt@email.com', '0918181818', N'70 Nguyễn Lương Bằng, Đống Đa', N'Hà Nội', 'hanglt', 'pass123', 6500000.00, '2023-06-07'),
('ST028', N'Long', N'Vũ Hải', '2001-07-07', N'Nam', 'long.vh@email.com', '0919191919', N'80 Phố Tây Sơn, Đống Đa', N'TP. Hồ Chí Minh', 'longvh', 'pass123', 7500000.00, '2023-06-08'),
('ST029', N'Mai', N'Trần Thị', '2002-04-04', N'Nữ', 'mai.tt@email.com', '0920202020', N'90 Phố Giảng Võ, Ba Đình', N'Hà Nội', 'maitt', 'pass123', 8000000.00, '2023-06-09'),
('ST030', N'Tùng', N'Hoàng Phi', '1998-02-02', N'Nam', 'tung.hp@email.com', '0921212121', N'100 Ô Chợ Dừa, Đống Đa', N'Hà Nội', 'tunghp', 'pass123', 9000000.00, '2023-06-10'),
('ST031', N'Anh', N'Lê Ngọc', '2003-01-25', N'Nữ', 'anh.ln@email.com', '0923232323', N'P1201 Chelsea Park, Cầu Giấy', N'Hà Nội', 'anhln', 'pass123', 10000000.00, '2023-06-11'),
('ST032', N'Bình', N'Trần An', '2000-11-11', N'Nam', 'binh.ta@email.com', '0924242424', N'11 Phố Bà Triệu, Hoàn Kiếm', N'Hà Nội', 'binhta', 'pass123', 0, '2023-06-12'),
('ST033', N'Châu', N'Nguyễn Ngọc', '2004-07-19', N'Nữ', 'chau.nn@email.com', '0925252525', N'23 Phố Hoàng Cầu, Đống Đa', N'Hà Nội', 'chaunn', 'pass123', 5000000.00, '2023-06-13'),
('ST034', N'Dương', N'Phạm Thùy', '2001-08-14', N'Nữ', 'duong.pt@email.com', '0926262626', N'44 Tôn Đức Thắng, Đống Đa', N'Hải Phòng', 'duongpt', 'pass123', 8500000.00, '2023-06-14'),
('ST035', N'Hải', N'Lê Văn', '1999-03-30', N'Nam', 'hai.lv@email.com', '0927272727', N'55 Phố Xã Đàn, Đống Đa', N'Hà Nội', 'hailv', 'pass123', 6000000.00, '2023-06-15'),
('ST036', N'Hoa', N'Đặng Thị', '2002-10-09', N'Nữ', 'hoa.dt@email.com', '0928282828', N'66 Nguyễn Du, Hai Bà Trưng', N'Hà Nội', 'hoadt', 'pass123', NULL, '2023-06-16'),
('ST037', N'Khánh', N'Võ Duy', '2003-05-15', N'Nam', 'khanh.vd@email.com', '0929292929', N'77 Lê Duẩn, Hoàn Kiếm', N'Đà Nẵng', 'khanhvd', 'pass123', NULL, '2023-06-17'),
('ST038', N'Loan', N'Bùi Thị', '2000-09-01', N'Nữ', 'loan.bt@email.com', '0930303030', N'88 Trần Nhân Tông, Hai Bà Trưng', N'Hà Nội', 'loanbt', 'pass123', 3000000.00, '2023-06-18'),
('ST039', N'Nam', N'Nguyễn Thành', '2001-02-18', N'Nam', 'nam.nt@email.com', '0931313131', N'99 Đại Cồ Việt, Hai Bà Trưng', N'Hà Nội', 'namnt', 'pass123', 11000000.00, '2023-06-19'),
('ST040', N'Phương', N'Vũ Thu', '2004-12-25', N'Nữ', 'phuong.vt@email.com', '0932323232', N'P505 Indochina Plaza, Cầu Giấy', N'Hà Nội', 'phuongvt', 'pass123', 7500000.00, '2023-06-20'),
('ST041', N'Quang', N'Trần Minh', '2000-08-10', N'Nam', 'quang.tm@email.com', '0934343434', N'121 Chùa Bộc, Đống Đa', N'Hà Nội', 'quangtm', 'pass123', 8200000.00, '2023-07-01'),
('ST042', N'Quỳnh', N'Lê Thị', '2002-06-22', N'Nữ', 'quynh.lt@email.com', '0935353535', N'234 Phạm Ngọc Thạch, Đống Đa', N'Hà Nội', 'quynhlt', 'pass123', 4800000.00, '2023-07-02'),
('ST043', N'Tâm', N'Ngô Thanh', '1999-04-18', N'Nam', 'tam.nt@email.com', '0936363636', N'345 Giải Phóng, Thanh Xuân', N'Hà Nội', 'tamnt', 'pass123', 9300000.00, '2023-07-03'),
('ST044', N'Thủy', N'Hoàng Thị', '2003-10-15', N'Nữ', 'thuy.ht@email.com', '0937373737', N'456 Minh Khai, Hai Bà Trưng', N'Hà Nội', 'thuyht', 'pass123', 5800000.00, '2023-07-04'),
('ST045', N'Toàn', N'Phan Văn', '2001-03-05', N'Nam', 'toan.pv@email.com', '0938383838', N'567 Trường Chinh, Đống Đa', N'Hà Nội', 'toanpv', 'pass123', 7700000.00, '2023-07-05'),
('ST046', N'Trúc', N'Mai Thanh', '2002-01-20', N'Nữ', 'truc.mt@email.com', '0939393939', N'678 Nguyễn Văn Cừ, Long Biên', N'Hà Nội', 'trucmt', 'pass123', 0, '2023-07-06'),
('ST047', N'Uyên', N'Nguyễn Phương', '2004-09-09', N'Nữ', 'uyen.np@email.com', '0940404040', N'789 Lạc Long Quân, Tây Hồ', N'Hà Nội', 'uyennp', 'pass123', 8800000.00, '2023-07-07'),
('ST048', N'Vinh', N'Đỗ Quang', '2000-12-01', N'Nam', 'vinh.dq@email.com', '0941414141', N'890 Quang Trung, Hà Đông', N'Hà Nội', 'vinhdq', 'pass123', 10500000.00, '2023-07-08'),
('ST049', N'Xuân', N'Hồ Thị', '1998-02-14', N'Nữ', 'xuan.ht@email.com', '0942424242', N'901 Nguyễn Lương Bằng, Đống Đa', N'Hà Nội', 'xuanht', 'pass123', NULL, '2023-07-09'),
('ST050', N'Phúc', N'Trần Hữu', '2001-05-25', N'Nam', 'phuc.th@email.com', '0943434343', N'111 Tây Hồ, Tây Hồ', N'Hà Nội', 'phucth', 'pass123', 11200000.00, '2023-07-10'),
('ST051', N'Thắng', N'Nguyễn Bá', '2003-04-11', N'Nam', 'thang.nb@email.com', '0944556677', N'222 Lê Văn Lương, Cầu Giấy', N'Hà Nội', 'thangnb', 'pass123', 7800000.00, '2023-08-01'),
('ST052', N'Nhung', N'Lê Hồng', '2002-08-19', N'Nữ', 'nhung.lh@email.com', '0955667788', N'333 Xuân Thủy, Cầu Giấy', N'Hà Nội', 'nhunglh', 'pass123', NULL, '2023-08-02'),
('ST053', N'Đức', N'Trần Minh', '2000-11-07', N'Nam', 'duc.tm@email.com', '0966778899', N'444 Hoàng Hoa Thám, Ba Đình', N'Hà Nội', 'ductm', 'pass123', 9100000.00, '2023-08-03'),
('ST054', N'Hạnh', N'Nguyễn Thị', '2004-01-23', N'Nữ', 'hanh.nt@email.com', '0977889900', N'555 Thụy Khuê, Tây Hồ', N'Hà Nội', 'hanhnt', 'pass123', 4200000.00, '2023-08-04'),
('ST055', N'Huy', N'Lê Quang', '2001-09-16', N'Nam', 'huy.lq@email.com', '0988990011', N'666 Hoàng Quốc Việt, Cầu Giấy', N'Hà Nội', 'huylq', 'pass123', NULL, '2023-08-05'),
('ST056', N'Kiên', N'Phạm Trung', '2002-05-30', N'Nam', 'kien.pt@email.com', '0912233445', N'777 Nguyễn Phong Sắc, Cầu Giấy', N'Hà Nội', 'kienpt', 'pass123', 5300000.00, '2023-08-06'),
('ST057', N'Lan', N'Vũ Thị', '2003-03-12', N'Nữ', 'lan.vt@email.com', '0923344556', N'888 Trần Cung, Bắc Từ Liêm', N'Hà Nội', 'lanvt', 'pass123', 7100000.00, '2023-08-07'),
('ST058', N'Linh', N'Ngô Thùy', '2000-07-28', N'Nữ', 'linh.nt@email.com', '0934455667', N'999 Phạm Văn Đồng, Bắc Từ Liêm', N'Hà Nội', 'linhnt', 'pass123', 9800000.00, '2023-08-08'),
('ST059', N'Mạnh', N'Đỗ Hùng', '2001-12-04', N'Nam', 'manh.dh@email.com', '0945566778', N'1122 Láng, Đống Đa', N'Hà Nội', 'manhdh', 'pass123', NULL, '2023-08-09'),
('ST060', N'Nga', N'Trần Thị', '2002-10-21', N'Nữ', 'nga.tt@email.com', '0956677889', N'1234 Đường Bưởi, Ba Đình', N'Hà Nội', 'ngatt', 'pass123', 10200000.00, '2023-08-10'),
('ST061', N'Phong', N'Lý Đức', '1999-05-14', N'Nam', 'phong.ld@email.com', '0967788990', N'543 Kim Ngưu, Hai Bà Trưng', N'Hà Nội', 'phongld', 'pass123', 13000000.00, '2023-08-11'),
('ST062', N'Quân', N'Nguyễn Minh', '2003-08-08', N'Nam', 'quan.nm@email.com', '0978899001', N'654 Bạch Mai, Hai Bà Trưng', N'Hà Nội', 'quannm', 'pass123', 2000000.00, '2023-08-12'),
('ST063', N'Tú', N'Trần Anh', '2004-03-03', N'Nam', 'tu.ta@email.com', '0989900112', N'765 Thanh Nhàn, Hai Bà Trưng', N'Hà Nội', 'tuta', 'pass123', 6900000.00, '2023-08-13'),
('ST064', N'Thảo', N'Lê Phương', '2001-01-01', N'Nữ', 'thao.lp@email.com', '0913344556', N'876 Tam Trinh, Hoàng Mai', N'Hà Nội', 'thaolp', 'pass123', 8300000.00, '2023-08-14'),
('ST065', N'My', N'Vũ Thị Trà', '2002-02-02', N'Nữ', 'my.vtt@email.com', '0924455667', N'987 Tân Mai, Hoàng Mai', N'Hà Nội', 'myvtt', 'pass123', NULL, '2023-08-15');
GO

INSERT INTO Course (id, description, tuition_fee, last_modified) VALUES
(N'GE_A1', N'Tiếng Anh Tổng quát - A1 (Beginner)', 3500000.00, GETDATE()),
(N'GE_A2', N'Tiếng Anh Tổng quát - A2 (Elementary)', 3800000.00, GETDATE()),
(N'GE_B1', N'Tiếng Anh Tổng quát - B1 (Intermediate)', 4000000.00, GETDATE()),
(N'GE_B2', N'Tiếng Anh Tổng quát - B2 (Upper-Intermediate)', 4200000.00, GETDATE()),
(N'GE_C1', N'Tiếng Anh Tổng quát - C1 (Advanced)', 4800000.00, GETDATE()),
(N'IELTS_55', N'Luyện thi IELTS Mục tiêu 5.0-5.5', 6000000.00, GETDATE()),
(N'IELTS_70', N'Luyện thi IELTS Mục tiêu 6.5-7.0+', 7500000.00, GETDATE()),
(N'IELTS_PRO', N'IELTS Chuyên sâu (Speaking & Writing)', 8500000.00, GETDATE()),
(N'TOEIC_B', N'Luyện thi TOEIC Cơ bản Mục tiêu 500+', 4500000.00, GETDATE()),
(N'TOEIC_A', N'Luyện thi TOEIC Nâng cao Mục tiêu 750+', 5500000.00, GETDATE()),
(N'BE_COM', N'Tiếng Anh Thương mại Giao tiếp', 4500000.00, GETDATE()),
(N'BE_ADV', N'Tiếng Anh Thương mại Nâng cao', 5500000.00, GETDATE()),
(N'KIDS_ENG', N'Tiếng Anh Trẻ Em (6-10 tuổi)', 3000000.00, GETDATE()),
(N'KIDS_ADV', N'Tiếng Anh Trẻ Em Nâng cao (11-14 tuổi)', 3200000.00, GETDATE()),
(N'AW_PRO', N'Viết Luận Học thuật Chuyên nghiệp', 5000000.00, GETDATE()),
(N'PTE_65', N'Luyện thi PTE Academic Mục tiêu 65+', 8000000.00, GETDATE()),
(N'SAT_PREP', N'Luyện thi SAT Toàn diện', 9000000.00, GETDATE()),
(N'GMAT_PREP', N'Luyện thi GMAT Chuyên sâu', 12000000.00, GETDATE());
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

-- 5. Class Data (30 Rows)
INSERT INTO Class (id, start_date, end_date, teacher_id, course_id, schedule_info, room_number) VALUES
(N'GEA1-2401', '2024-01-15', '2024-04-12', 'TE010', N'GE_A1', N'T2-4-6, 18:00-19:30', N'P101'),
(N'GEA2-2401', '2024-01-16', '2024-04-13', 'TE002', N'GE_A2', N'T3-5, 18:00-19:30', N'P102'),
(N'GEB1-2401', '2024-01-15', '2024-04-12', 'TE002', N'GE_B1', N'T2-4-6, 19:45-21:15', N'P103'),
(N'GEB2-2401', '2024-01-16', '2024-04-13', 'TE009', N'GE_B2', N'T3-5, 19:45-21:15', N'P104'),
(N'GEC1-2401', '2024-02-05', '2024-05-03', 'TE014', N'GE_C1', N'T2-6, 18:30-20:30', N'P105'),
(N'IELTS55-2401', '2024-01-20', '2024-04-20', 'TE008', N'IELTS_55', N'T7, 09:00-12:00', N'P201'),
(N'IELTS70-2401A', '2024-01-20', '2024-04-20', 'TE001', N'IELTS_70', N'T7, 13:30-16:30', N'P202'),
(N'IELTS70-2401B', '2024-01-21', '2024-04-21', 'TE017', N'IELTS_70', N'CN, 09:00-12:00', N'P203'),
(N'IELTSPRO-2401', '2024-02-03', '2024-05-04', 'TE011', N'IELTS_PRO', N'T7, 09:00-12:00', N'P204'),
(N'TOEICB-2401', '2024-01-15', '2024-04-12', 'TE004', N'TOEIC_B', N'T2-4, 18:00-19:30', N'P301'),
(N'TOEICA-2401', '2024-01-15', '2024-04-12', 'TE015', N'TOEIC_A', N'T2-4, 19:45-21:15', N'P302'),
(N'BECOM-2401', '2024-01-16', '2024-04-13', 'TE005', N'BE_COM', N'T3-5, 18:30-20:30', N'P303'),
(N'BEADV-2401', '2024-02-06', '2024-05-07', 'TE012', N'BE_ADV', N'T3-5, 19:00-21:00', N'P304'),
(N'KIDSENG-2401', '2024-01-20', '2024-04-20', 'TE003', N'KIDS_ENG', N'T7, 09:30-11:00', N'P106'),
(N'KIDSADV-2401', '2024-01-21', '2024-04-21', 'TE006', N'KIDS_ADV', N'CN, 09:30-11:00', N'P107'),
(N'AWPRO-2401', '2024-02-04', '2024-04-28', 'TE007', N'AW_PRO', N'CN, 14:00-16:00', N'P205'),
(N'PTE65-2401', '2024-02-10', '2024-05-11', 'TE021', N'PTE_65', N'T7, 13:30-16:30', N'P305'),
(N'SATPREP-2401', '2024-01-27', '2024-05-04', 'TE013', N'SAT_PREP', N'T7, 08:30-12:30', N'P306'),
(N'GMATPREP-2401', '2024-01-28', '2024-05-05', 'TE016', N'GMAT_PREP', N'CN, 08:30-12:30', N'P307'),
(N'GEA1-2401B', '2024-01-16', '2024-04-13', 'TE010', N'GE_A1', N'T3-5, 19:45-21:15', N'P101'),
(N'GEB1-2402', '2024-02-12', '2024-05-10', 'TE018', N'GE_B1', N'T2-4, 18:00-19:30', N'P108'),
(N'IELTS70-2402', '2024-02-13', '2024-05-14', 'TE001', N'IELTS_70', N'T3-5-7, 18:30-20:30', N'P202'),
(N'TOEICA-2402', '2024-02-19', '2024-05-17', 'TE015', N'TOEIC_A', N'T2-4-6, 18:00-19:30', N'P301'),
(N'BECOM-2402', '2024-02-20', '2024-05-21', 'TE019', N'BE_COM', N'T3-5, 19:00-21:00', N'P303'),
(N'KIDSENG-2402', '2024-01-21', '2024-04-21', 'TE003', N'KIDS_ENG', N'CN, 14:00-15:30', N'P106'),
(N'IELTS55-2402', '2024-02-18', '2024-05-19', 'TE008', N'IELTS_55', N'CN, 13:30-16:30', N'P201'),
(N'GEB2-2402', '2024-02-19', '2024-05-17', 'TE020', N'GE_B2', N'T2-4, 19:00-21:00', N'P104'),
(N'SATPREP-2402', '2024-02-25', '2024-06-02', 'TE013', N'SAT_PREP', N'CN, 13:30-17:30', N'P306'),
(N'AWPRO-2402', '2024-03-02', '2024-05-25', 'TE007', N'AW_PRO', N'T7, 15:00-17:00', N'P205'),
(N'IELTS70-2403', '2024-03-04', '2024-06-03', 'TE017', N'IELTS_70', N'T2-4-6, 18:00-20:00', N'P203');
GO

INSERT INTO Class_Student (class_id, student_id, enrollment_date) VALUES
(N'IELTS70-2401A', 'ST001', '2024-01-10'), (N'SATPREP-2401', 'ST001', '2024-01-12'),
(N'GEA1-2401', 'ST002', '2024-01-08'), (N'IELTS55-2401', 'ST002', '2024-01-10'),
(N'GEB1-2401', 'ST003', '2024-01-09'), (N'TOEICB-2401', 'ST003', '2024-01-11'),
(N'BECOM-2401', 'ST004', '2024-01-10'), (N'TOEICA-2401', 'ST004', '2024-01-12'),
(N'GMATPREP-2401', 'ST005', '2024-01-15'), (N'AWPRO-2401', 'ST005', '2024-01-20'),
(N'KIDSENG-2401', 'ST006', '2024-01-05'),
(N'IELTS70-2401B', 'ST007', '2024-01-11'), (N'BEADV-2401', 'ST007', '2024-01-18'),
(N'GEA1-2401B', 'ST008', '2024-01-10'),
(N'KIDSADV-2401', 'ST009', '2024-01-12'),
(N'GEA2-2401', 'ST010', '2024-01-09'),
(N'IELTS55-2402', 'ST011', '2024-02-10'),
(N'TOEICB-2401', 'ST012', '2024-01-10'),
(N'IELTS70-2402', 'ST013', '2024-02-05'), (N'AWPRO-2402', 'ST013', '2024-02-15'),
(N'GEB2-2402', 'ST014', '2024-02-11'),
(N'IELTS70-2401A', 'ST015', '2024-01-13'),
(N'GEA1-2401', 'ST016', '2024-01-10'),
(N'GEB1-2402', 'ST017', '2024-02-08'),
(N'GMATPREP-2401', 'ST018', '2024-01-20'),
(N'GEA2-2401', 'ST019', '2024-01-12'),
(N'TOEICA-2402', 'ST020', '2024-02-15'),
(N'GEB2-2401', 'ST021', '2024-01-10'),
(N'IELTSPRO-2401', 'ST022', '2024-01-25'),
(N'KIDSENG-2402', 'ST023', '2024-01-15'),
(N'SATPREP-2402', 'ST024', '2024-02-18'),
(N'BECOM-2402', 'ST025', '2024-02-14'),
(N'TOEICA-2401', 'ST026', '2024-01-11'),
(N'GEC1-2401', 'ST027', '2024-01-28'),
(N'IELTS70-2401B', 'ST028', '2024-01-15'),
(N'BECOM-2401', 'ST029', '2024-01-12'),
(N'IELTS70-2403', 'ST030', '2024-02-25'),
(N'SATPREP-2401', 'ST031', '2024-01-18'), (N'IELTSPRO-2401', 'ST031', '2024-01-22'),
(N'GMATPREP-2401', 'ST032', '2024-01-20'),
(N'TOEICA-2402', 'ST033', '2024-02-12'),
(N'BEADV-2401', 'ST034', '2024-02-01'),
(N'GEB1-2401', 'ST035', '2024-01-10'),
(N'IELTS55-2401', 'ST036', '2024-01-14'),
(N'GEA2-2401', 'ST037', '2024-01-11'),
(N'KIDSADV-2401', 'ST038', '2024-01-16'),
(N'SATPREP-2402', 'ST039', '2024-02-20'),
(N'IELTS70-2403', 'ST040', '2024-02-28'), (N'GEC1-2401', 'ST040', '2024-01-29'),
(N'IELTS70-2401A', 'ST041', '2024-01-15'),
(N'GEB2-2401', 'ST042', '2024-01-12'),
(N'PTE65-2401', 'ST043', '2024-02-05'),
(N'GEA1-2401B', 'ST044', '2024-01-12'),
(N'TOEICA-2401', 'ST045', '2024-01-10'),
(N'KIDSENG-2401', 'ST046', '2024-01-15'),
(N'KIDSADV-2401', 'ST047', '2024-01-16'),
(N'SATPREP-2401', 'ST048', '2024-01-20'),
(N'GEA1-2401', 'ST049', '2024-01-09'),
(N'IELTSPRO-2401', 'ST050', '2024-01-28'),
(N'IELTS70-2402', 'ST051', '2024-02-08'),
(N'BECOM-2402', 'ST052', '2024-02-15'),
(N'GMATPREP-2401', 'ST053', '2024-01-21'),
(N'GEA2-2401', 'ST054', '2024-01-13'),
(N'IELTS70-2401A', 'ST055', '2024-01-16'),
(N'TOEICA-2401', 'ST056', '2024-01-13'),
(N'GEB1-2402', 'ST057', '2024-02-09'),
(N'IELTS70-2401B', 'ST058', '2024-01-17'),
(N'AWPRO-2402', 'ST059', '2024-02-25'),
(N'GEA1-2401B', 'ST060', '2024-01-14'),
(N'SATPREP-2402', 'ST061', '2024-02-19'),
(N'GEB1-2401', 'ST062', '2024-01-11'),
(N'KIDSENG-2402', 'ST063', '2024-01-18'),
(N'IELTS55-2402', 'ST064', '2024-02-12'),
(N'BECOM-2401', 'ST065', '2024-01-14'),
(N'IELTS70-2401A', 'ST013', '2024-01-11'), (N'AWPRO-2401', 'ST014', '2024-01-25'),
(N'GEB2-2401', 'ST015', '2024-01-12'), (N'TOEICB-2401', 'ST016', '2024-01-13'),
(N'BECOM-2401', 'ST017', '2024-01-14'), (N'IELTS55-2401', 'ST018', '2024-01-15'),
(N'GEC1-2401', 'ST019', '2024-02-01'), (N'SATPREP-2401', 'ST020', '2024-01-18'),
(N'IELTS70-2403', 'ST021', '2024-02-28'), (N'GEA1-2401', 'ST023', '2024-01-11'),
(N'PTE65-2401', 'ST024', '2024-02-08'), (N'AWPRO-2401', 'ST025', '2024-01-29'),
(N'IELTSPRO-2401', 'ST026', '2024-01-30'), (N'GEB1-2402', 'ST028', '2024-02-10'),
(N'TOEICA-2402', 'ST029', '2024-02-11'), (N'KIDSADV-2401', 'ST030', '2024-01-17'),
(N'SATPREP-2402', 'ST032', '2024-02-18'), (N'BEADV-2401', 'ST033', '2024-02-02'),
(N'GEA2-2401', 'ST035', '2024-01-14'), (N'IELTS55-2402', 'ST037', '2024-02-13'),
(N'KIDSENG-2402', 'ST038', '2024-01-19'), (N'GMATPREP-2401', 'ST039', '2024-01-22'),
(N'AWPRO-2402', 'ST041', '2024-02-26'), (N'IELTS70-2402', 'ST042', '2024-02-10'),
(N'TOEICB-2401', 'ST043', '2024-01-14'), (N'BECOM-2402', 'ST044', '2024-02-16'),
(N'GEB1-2401', 'ST045', '2024-01-12'), (N'KIDSENG-2401', 'ST047', '2024-01-17'),
(N'SATPREP-2401', 'ST049', '2024-01-21'), (N'IELTS70-2401A', 'ST050', '2024-01-18'),
(N'GEA1-2401B', 'ST051', '2024-01-13'), (N'IELTS55-2401', 'ST052', '2024-01-16'),
(N'GEC1-2401', 'ST053', '2024-02-03'), (N'BEADV-2401', 'ST054', '2024-02-04'),
(N'PTE65-2401', 'ST055', '2024-02-09'), (N'AWPRO-2401', 'ST056', '2024-01-31'),
(N'TOEICA-2402', 'ST057', '2024-02-13'), (N'GEB2-2402', 'ST058', '2024-02-14'),
(N'SATPREP-2402', 'ST059', '2024-02-21'), (N'IELTS70-2403', 'ST060', '2024-02-29'),
(N'GMATPREP-2401', 'ST061', '2024-01-24'), (N'KIDSADV-2401', 'ST062', '2024-01-18'),
(N'GEA2-2401', 'ST063', '2024-01-15'), (N'BECOM-2401', 'ST064', '2024-01-16'),
(N'IELTS70-2401B', 'ST065', '2024-01-19');
GO

EXEC usp_ProcessCoursePayment @PaymentID = 'PA001', @StudentID = 'ST001', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA002', @StudentID = 'ST001', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA003', @StudentID = 'ST002', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA004', @StudentID = 'ST002', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA005', @StudentID = 'ST003', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA006', @StudentID = 'ST003', @CourseID = N'TOEIC_B', @PaymentAmount = 4500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA007', @StudentID = 'ST004', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA008', @StudentID = 'ST004', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA009', @StudentID = 'ST005', @CourseID = N'GMAT_PREP', @PaymentAmount = 12000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA010', @StudentID = 'ST005', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA011', @StudentID = 'ST006', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA012', @StudentID = 'ST007', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA013', @StudentID = 'ST007', @CourseID = N'BE_ADV', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA014', @StudentID = 'ST008', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA015', @StudentID = 'ST009', @CourseID = N'KIDS_ADV', @PaymentAmount = 3200000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA016', @StudentID = 'ST010', @CourseID = N'GE_A2', @PaymentAmount = 3800000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA017', @StudentID = 'ST011', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA018', @StudentID = 'ST012', @CourseID = N'TOEIC_B', @PaymentAmount = 4500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA019', @StudentID = 'ST013', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA020', @StudentID = 'ST013', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA021', @StudentID = 'ST014', @CourseID = N'GE_B2', @PaymentAmount = 4200000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA022', @StudentID = 'ST015', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA023', @StudentID = 'ST016', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA024', @StudentID = 'ST017', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA025', @StudentID = 'ST018', @CourseID = N'GMAT_PREP', @PaymentAmount = 12000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA026', @StudentID = 'ST019', @CourseID = N'GE_A2', @PaymentAmount = 3800000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA027', @StudentID = 'ST020', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA028', @StudentID = 'ST021', @CourseID = N'GE_B2', @PaymentAmount = 4200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA029', @StudentID = 'ST022', @CourseID = N'IELTS_PRO', @PaymentAmount = 8500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA030', @StudentID = 'ST023', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA031', @StudentID = 'ST024', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA032', @StudentID = 'ST025', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA033', @StudentID = 'ST026', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA034', @StudentID = 'ST027', @CourseID = N'GE_C1', @PaymentAmount = 4800000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA035', @StudentID = 'ST028', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA036', @StudentID = 'ST029', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA037', @StudentID = 'ST030', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA038', @StudentID = 'ST031', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA039', @StudentID = 'ST031', @CourseID = N'IELTS_PRO', @PaymentAmount = 8500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA040', @StudentID = 'ST032', @CourseID = N'GMAT_PREP', @PaymentAmount = 12000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA041', @StudentID = 'ST033', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA042', @StudentID = 'ST034', @CourseID = N'BE_ADV', @PaymentAmount = 5500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA043', @StudentID = 'ST035', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA044', @StudentID = 'ST036', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA045', @StudentID = 'ST037', @CourseID = N'GE_A2', @PaymentAmount = 3800000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA046', @StudentID = 'ST038', @CourseID = N'KIDS_ADV', @PaymentAmount = 3200000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA047', @StudentID = 'ST039', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA048', @StudentID = 'ST040', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA049', @StudentID = 'ST040', @CourseID = N'GE_C1', @PaymentAmount = 4800000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA050', @StudentID = 'ST041', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA051', @StudentID = 'ST042', @CourseID = N'GE_B2', @PaymentAmount = 4200000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA052', @StudentID = 'ST043', @CourseID = N'PTE_65', @PaymentAmount = 8000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA053', @StudentID = 'ST044', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA054', @StudentID = 'ST045', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA055', @StudentID = 'ST046', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA056', @StudentID = 'ST047', @CourseID = N'KIDS_ADV', @PaymentAmount = 3200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA057', @StudentID = 'ST048', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA058', @StudentID = 'ST049', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA059', @StudentID = 'ST050', @CourseID = N'IELTS_PRO', @PaymentAmount = 8500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA060', @StudentID = 'ST051', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA061', @StudentID = 'ST052', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA062', @StudentID = 'ST053', @CourseID = N'GMAT_PREP', @PaymentAmount = 12000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA063', @StudentID = 'ST054', @CourseID = N'GE_A2', @PaymentAmount = 3800000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA064', @StudentID = 'ST055', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA065', @StudentID = 'ST056', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA066', @StudentID = 'ST057', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA067', @StudentID = 'ST058', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA068', @StudentID = 'ST059', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA069', @StudentID = 'ST060', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA070', @StudentID = 'ST061', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA071', @StudentID = 'ST062', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA072', @StudentID = 'ST063', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA073', @StudentID = 'ST064', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA074', @StudentID = 'ST065', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA075', @StudentID = 'ST013', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA076', @StudentID = 'ST014', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA077', @StudentID = 'ST015', @CourseID = N'GE_B2', @PaymentAmount = 4200000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA078', @StudentID = 'ST016', @CourseID = N'TOEIC_B', @PaymentAmount = 4500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA079', @StudentID = 'ST017', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA080', @StudentID = 'ST018', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA081', @StudentID = 'ST019', @CourseID = N'GE_C1', @PaymentAmount = 4800000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA082', @StudentID = 'ST020', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA083', @StudentID = 'ST021', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA084', @StudentID = 'ST023', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA085', @StudentID = 'ST024', @CourseID = N'PTE_65', @PaymentAmount = 8000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA086', @StudentID = 'ST025', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA087', @StudentID = 'ST026', @CourseID = N'IELTS_PRO', @PaymentAmount = 8500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA088', @StudentID = 'ST028', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA089', @StudentID = 'ST029', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA090', @StudentID = 'ST030', @CourseID = N'KIDS_ADV', @PaymentAmount = 3200000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA091', @StudentID = 'ST032', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA092', @StudentID = 'ST033', @CourseID = N'BE_ADV', @PaymentAmount = 5500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA093', @StudentID = 'ST035', @CourseID = N'GE_A2', @PaymentAmount = 3800000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA094', @StudentID = 'ST037', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA095', @StudentID = 'ST038', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA096', @StudentID = 'ST039', @CourseID = N'GMAT_PREP', @PaymentAmount = 12000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA097', @StudentID = 'ST041', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA098', @StudentID = 'ST042', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA099', @StudentID = 'ST043', @CourseID = N'TOEIC_B', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA100', @StudentID = 'ST044', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA101', @StudentID = 'ST045', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA102', @StudentID = 'ST047', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA103', @StudentID = 'ST049', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA104', @StudentID = 'ST050', @CourseID = 'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA105', @StudentID = 'ST051', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA106', @StudentID = 'ST052', @CourseID = N'IELTS_55', @PaymentAmount = 6000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA107', @StudentID = 'ST053', @CourseID = N'GE_C1', @PaymentAmount = 4800000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA108', @StudentID = 'ST054', @CourseID = N'BE_ADV', @PaymentAmount = 5500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA109', @StudentID = 'ST055', @CourseID = N'PTE_65', @PaymentAmount = 8000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA110', @StudentID = 'ST056', @CourseID = N'AW_PRO', @PaymentAmount = 5000000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA111', @StudentID = 'ST057', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA112', @StudentID = 'ST058', @CourseID = N'GE_B2', @PaymentAmount = 4200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA113', @StudentID = 'ST059', @CourseID = N'SAT_PREP', @PaymentAmount = 9000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA114', @StudentID = 'ST060', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA115', @StudentID = 'ST061', @CourseID = N'GMAT_PREP', @PaymentAmount = 12000000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA116', @StudentID = 'ST062', @CourseID = N'KIDS_ADV', @PaymentAmount = 3200000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA117', @StudentID = 'ST063', @CourseID = N'GE_A2', @PaymentAmount = 3800000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA118', @StudentID = 'ST064', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA119', @StudentID = 'ST065', @CourseID = N'IELTS_70', @PaymentAmount = 7500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA120', @StudentID = 'ST001', @CourseID = N'GE_B1', @PaymentAmount = 4000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA121', @StudentID = 'ST002', @CourseID = N'TOEIC_A', @PaymentAmount = 5500000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA122', @StudentID = 'ST003', @CourseID = N'BE_COM', @PaymentAmount = 4500000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA123', @StudentID = 'ST004', @CourseID = N'GE_A1', @PaymentAmount = 3500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA124', @StudentID = 'ST005', @CourseID = N'IELTS_PRO', @PaymentAmount = 8500000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA125', @StudentID = 'ST006', @CourseID = N'KIDS_ADV', @PaymentAmount = 3200000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA126', @StudentID = 'ST007', @CourseID = N'PTE_65', @PaymentAmount = 8000000.00, @PaymentMethod = N'Momo';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA127', @StudentID = 'ST008', @CourseID = N'TOEIC_B', @PaymentAmount = 4500000.00, @PaymentMethod = N'Tiền mặt';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA128', @StudentID = 'ST009', @CourseID = N'KIDS_ENG', @PaymentAmount = 3000000.00, @PaymentMethod = N'Chuyển khoản';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA129', @StudentID = 'ST010', @CourseID = N'GE_B2', @PaymentAmount = 4200000.00, @PaymentMethod = N'Thẻ tín dụng';
EXEC usp_ProcessCoursePayment @PaymentID = 'PA130', @StudentID = 'ST011', @CourseID = N'GE_C1', @PaymentAmount = 4800000.00, @PaymentMethod = N'Momo';
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
('EX075', '2024-04-13', N'Essay Draft 1', N'AWPRO-2402', N'Quiz', 60);
GO

INSERT INTO Grade (id, value, student_id, exam_id, class_id, date) VALUES
('GR001', 7.0, 'ST001', 'EX013', 'IELTS70-2401A', '2024-03-05'), ('GR002', 6.5, 'ST001', 'EX014', 'IELTS70-2401A', '2024-04-16'),
('GR003', 7.5, 'ST001', 'EX035', 'SATPREP-2401', '2024-03-12'), ('GR004', 8.0, 'ST001', 'EX036', 'SATPREP-2401', '2024-05-01'),
('GR005', 8.0, 'ST002', 'EX001', 'GEA1-2401', '2024-02-29'), ('GR006', 8.5, 'ST002', 'EX002', 'GEA1-2401', '2024-04-11'),
('GR007', 5.0, 'ST002', 'EX011', 'IELTS55-2401', '2024-03-05'), ('GR008', 5.5, 'ST002', 'EX012', 'IELTS55-2401', '2024-04-16'),
('GR009', 7.5, 'ST003', 'EX005', 'GEB1-2401', '2024-02-29'), ('GR010', 8.0, 'ST003', 'EX006', 'GEB1-2401', '2024-04-11'),
('GR011', 6.0, 'ST003', 'EX019', 'TOEICB-2401', '2024-02-29'), ('GR012', 7.0, 'ST003', 'EX020', 'TOEICB-2401', '2024-04-11'),
('GR013', 8.5, 'ST004', 'EX023', 'BECOM-2401', '2024-03-01'), ('GR014', 8.0, 'ST004', 'EX024', 'BECOM-2401', '2024-04-12'),
('GR015', 7.0, 'ST004', 'EX021', 'TOEICA-2401', '2024-02-29'), ('GR016', 7.5, 'ST004', 'EX022', 'TOEICA-2401', '2024-04-11'),
('GR017', 8.0, 'ST005', 'EX037', 'GMATPREP-2401', '2024-03-13'), ('GR018', 8.5, 'ST005', 'EX038', 'GMATPREP-2401', '2024-05-01'),
('GR019', 7.5, 'ST005', 'EX031', 'AWPRO-2401', '2024-03-20'), ('GR020', 8.0, 'ST005', 'EX032', 'AWPRO-2401', '2024-04-24'),
('GR021', 9.0, 'ST006', 'EX027', 'KIDSENG-2401', '2024-03-05'), ('GR022', 9.5, 'ST006', 'EX028', 'KIDSENG-2401', '2024-04-16'),
('GR023', 6.5, 'ST007', 'EX015', 'IELTS70-2401B', '2024-03-06'), ('GR024', 7.0, 'ST007', 'EX016', 'IELTS70-2401B', '2024-04-17'),
('GR025', 8.0, 'ST007', 'EX025', 'BEADV-2401', '2024-03-22'), ('GR026', 8.5, 'ST007', 'EX026', 'BEADV-2401', '2024-05-03'),
('GR027', 7.0, 'ST008', 'EX039', 'GEA1-2401B', '2024-03-01'), ('GR028', 7.5, 'ST008', 'EX040', 'GEA1-2401B', '2024-04-12'),
('GR029', 9.5, 'ST009', 'EX029', 'KIDSADV-2401', '2024-03-06'), ('GR030', 9.0, 'ST009', 'EX030', 'KIDSADV-2401', '2024-04-17'),
('GR031', 6.5, 'ST010', 'EX003', 'GEA2-2401', '2024-03-01'), ('GR032', 7.0, 'ST010', 'EX004', 'GEA2-2401', '2024-04-12'),
('GR033', 6.0, 'ST011', 'EX051', 'IELTS55-2402', '2024-04-03'), ('GR034', 6.5, 'ST011', 'EX052', 'IELTS55-2402', '2024-05-15'),
('GR035', 5.5, 'ST012', 'EX019', 'TOEICB-2401', '2024-02-29'), ('GR036', 6.5, 'ST012', 'EX020', 'TOEICB-2401', '2024-04-11'),
('GR037', 7.5, 'ST013', 'EX043', 'IELTS70-2402', '2024-03-29'), ('GR038', 8.0, 'ST013', 'EX044', 'IELTS70-2402', '2024-05-10'),
('GR039', 8.0, 'ST013', 'EX057', 'AWPRO-2402', '2024-04-16'), ('GR040', 8.5, 'ST013', 'EX058', 'AWPRO-2402', '2024-05-21'),
('GR041', 7.0, 'ST014', 'EX053', 'GEB2-2402', '2024-04-03'), ('GR042', 7.5, 'ST014', 'EX054', 'GEB2-2402', '2024-05-15'),
('GR043', 6.0, 'ST015', 'EX013', 'IELTS70-2401A', '2024-03-05'), ('GR044', 6.5, 'ST015', 'EX014', 'IELTS70-2401A', '2024-04-16'),
('GR045', 7.5, 'ST016', 'EX001', 'GEA1-2401', '2024-02-29'), ('GR046', 8.0, 'ST016', 'EX002', 'GEA1-2401', '2024-04-11'),
('GR047', 7.0, 'ST017', 'EX041', 'GEB1-2402', '2024-03-28'), ('GR048', 7.5, 'ST017', 'EX042', 'GEB1-2402', '2024-05-09'),
('GR049', 8.5, 'ST018', 'EX037', 'GMATPREP-2401', '2024-03-13'), ('GR050', 9.0, 'ST018', 'EX038', 'GMATPREP-2401', '2024-05-01'),
('GR051', 6.0, 'ST019', 'EX003', 'GEA2-2401', '2024-03-01'), ('GR052', 6.5, 'ST019', 'EX004', 'GEA2-2401', '2024-04-12'),
('GR053', 7.5, 'ST020', 'EX045', 'TOEICA-2402', '2024-04-03'), ('GR054', 8.0, 'ST020', 'EX046', 'TOEICA-2402', '2024-05-15'),
('GR055', 8.0, 'ST021', 'EX007', 'GEB2-2401', '2024-03-01'), ('GR056', 8.5, 'ST021', 'EX008', 'GEB2-2401', '2024-04-12'),
('GR057', 9.0, 'ST022', 'EX017', 'IELTSPRO-2401', '2024-03-19'), ('GR058', 9.5, 'ST022', 'EX018', 'IELTSPRO-2401', '2024-05-01'),
('GR059', 8.5, 'ST023', 'EX049', 'KIDSENG-2402', '2024-03-06'), ('GR060', 9.0, 'ST023', 'EX050', 'KIDSENG-2402', '2024-04-17'),
('GR061', 8.0, 'ST024', 'EX055', 'SATPREP-2402', '2024-04-10'), ('GR062', 8.5, 'ST024', 'EX056', 'SATPREP-2402', '2024-05-29'),
('GR063', 7.5, 'ST025', 'EX047', 'BECOM-2402', '2024-04-05'), ('GR064', 8.0, 'ST025', 'EX048', 'BECOM-2402', '2024-05-17'),
('GR065', 8.0, 'ST026', 'EX021', 'TOEICA-2401', '2024-02-29'), ('GR066', 8.5, 'ST026', 'EX022', 'TOEICA-2401', '2024-04-11'),
('GR067', 8.5, 'ST027', 'EX009', 'GEC1-2401', '2024-03-21'), ('GR068', 9.0, 'ST027', 'EX010', 'GEC1-2401', '2024-05-02'),
('GR069', 7.0, 'ST028', 'EX015', 'IELTS70-2401B', '2024-03-06'), ('GR070', 7.5, 'ST028', 'EX016', 'IELTS70-2401B', '2024-04-17'),
('GR071', 8.0, 'ST029', 'EX023', 'BECOM-2401', '2024-03-01'), ('GR072', 8.5, 'ST029', 'EX024', 'BECOM-2401', '2024-04-12'),
('GR073', 7.5, 'ST030', 'EX059', 'IELTS70-2403', '2024-04-18'), ('GR074', 8.0, 'ST030', 'EX060', 'IELTS70-2403', '2024-05-30'),
('GR075', 8.5, 'ST031', 'EX035', 'SATPREP-2401', '2024-03-12'), ('GR076', 9.0, 'ST031', 'EX036', 'SATPREP-2401', '2024-05-01'),
('GR077', 9.0, 'ST031', 'EX017', 'IELTSPRO-2401', '2024-03-19'), ('GR078', 9.5, 'ST031', 'EX018', 'IELTSPRO-2401', '2024-05-01'),
('GR079', 8.0, 'ST032', 'EX037', 'GMATPREP-2401', '2024-03-13'), ('GR080', 8.5, 'ST032', 'EX038', 'GMATPREP-2401', '2024-05-01'),
('GR081', 8.5, 'ST033', 'EX045', 'TOEICA-2402', '2024-04-03'), ('GR082', 9.0, 'ST033', 'EX046', 'TOEICA-2402', '2024-05-15'),
('GR083', 7.5, 'ST034', 'EX025', 'BEADV-2401', '2024-03-22'), ('GR084', 8.0, 'ST034', 'EX026', 'BEADV-2401', '2024-05-03'),
('GR085', 8.0, 'ST035', 'EX005', 'GEB1-2401', '2024-02-29'), ('GR086', 8.5, 'ST035', 'EX006', 'GEB1-2401', '2024-04-11'),
('GR087', 5.5, 'ST036', 'EX011', 'IELTS55-2401', '2024-03-05'), ('GR088', 6.0, 'ST036', 'EX012', 'IELTS55-2401', '2024-04-16'),
('GR089', 7.0, 'ST037', 'EX003', 'GEA2-2401', '2024-03-01'), ('GR090', 7.5, 'ST037', 'EX004', 'GEA2-2401', '2024-04-12'),
('GR091', 9.0, 'ST038', 'EX029', 'KIDSADV-2401', '2024-03-06'), ('GR092', 9.5, 'ST038', 'EX030', 'KIDSADV-2401', '2024-04-17'),
('GR093', 8.0, 'ST039', 'EX055', 'SATPREP-2402', '2024-04-10'), ('GR094', 8.5, 'ST039', 'EX056', 'SATPREP-2402', '2024-05-29'),
('GR095', 8.0, 'ST040', 'EX059', 'IELTS70-2403', '2024-04-18'), ('GR096', 8.5, 'ST040', 'EX060', 'IELTS70-2403', '2024-05-30'),
('GR097', 9.0, 'ST040', 'EX009', 'GEC1-2401', '2024-03-21'), ('GR098', 9.5, 'ST040', 'EX010', 'GEC1-2401', '2024-05-02'),
('GR099', 6.5, 'ST041', 'EX013', 'IELTS70-2401A', '2024-03-05'), ('GR100', 7.0, 'ST041', 'EX014', 'IELTS70-2401A', '2024-04-16'),
('GR101', 7.5, 'ST042', 'EX007', 'GEB2-2401', '2024-03-01'), ('GR102', 8.0, 'ST042', 'EX008', 'GEB2-2401', '2024-04-12'),
('GR103', 7.0, 'ST043', 'EX033', 'PTE65-2401', '2024-03-26'), ('GR104', 7.5, 'ST043', 'EX034', 'PTE65-2401', '2024-05-07'),
('GR105', 8.0, 'ST044', 'EX039', 'GEA1-2401B', '2024-03-01'), ('GR106', 8.5, 'ST044', 'EX040', 'GEA1-2401B', '2024-04-12'),
('GR107', 7.0, 'ST045', 'EX021', 'TOEICA-2401', '2024-02-29'), ('GR108', 7.5, 'ST045', 'EX022', 'TOEICA-2401', '2024-04-11'),
('GR109', 9.5, 'ST046', 'EX027', 'KIDSENG-2401', '2024-03-05'), ('GR110', 9.0, 'ST046', 'EX028', 'KIDSENG-2401', '2024-04-16'),
('GR111', 9.0, 'ST047', 'EX029', 'KIDSADV-2401', '2024-03-06'), ('GR112', 9.5, 'ST047', 'EX030', 'KIDSADV-2401', '2024-04-17'),
('GR113', 7.5, 'ST048', 'EX035', 'SATPREP-2401', '2024-03-12'), ('GR114', 8.0, 'ST048', 'EX036', 'SATPREP-2401', '2024-05-01'),
('GR115', 7.0, 'ST049', 'EX001', 'GEA1-2401', '2024-02-29'), ('GR116', 7.5, 'ST049', 'EX002', 'GEA1-2401', '2024-04-11'),
('GR117', 8.5, 'ST050', 'EX017', 'IELTSPRO-2401', '2024-03-19'), ('GR118', 9.0, 'ST050', 'EX018', 'IELTSPRO-2401', '2024-05-01'),
('GR119', 7.0, 'ST051', 'EX043', 'IELTS70-2402', '2024-03-29'), ('GR120', 7.5, 'ST051', 'EX044', 'IELTS70-2402', '2024-05-10'),
('GR121', 8.0, 'ST052', 'EX047', 'BECOM-2402', '2024-04-05'), ('GR122', 8.5, 'ST052', 'EX048', 'BECOM-2402', '2024-05-17'),
('GR123', 8.0, 'ST053', 'EX037', 'GMATPREP-2401', '2024-03-13'), ('GR124', 8.5, 'ST053', 'EX038', 'GMATPREP-2401', '2024-05-01'),
('GR125', 7.5, 'ST054', 'EX003', 'GEA2-2401', '2024-03-01'), ('GR126', 8.0, 'ST054', 'EX004', 'GEA2-2401', '2024-04-12'),
('GR127', 7.0, 'ST055', 'EX013', 'IELTS70-2401A', '2024-03-05'), ('GR128', 7.5, 'ST055', 'EX014', 'IELTS70-2401A', '2024-04-16'),
('GR129', 8.0, 'ST056', 'EX021', 'TOEICA-2401', '2024-02-29'), ('GR130', 8.5, 'ST056', 'EX022', 'TOEICA-2401', '2024-04-11'),
('GR131', 7.5, 'ST057', 'EX041', 'GEB1-2402', '2024-03-28'), ('GR132', 8.0, 'ST057', 'EX042', 'GEB1-2402', '2024-05-09'),
('GR133', 7.5, 'ST058', 'EX015', 'IELTS70-2401B', '2024-03-06'), ('GR134', 8.0, 'ST058', 'EX016', 'IELTS70-2401B', '2024-04-17'),
('GR135', 8.0, 'ST059', 'EX057', 'AWPRO-2402', '2024-04-16'), ('GR136', 8.5, 'ST059', 'EX058', 'AWPRO-2402', '2024-05-21'),
('GR137', 7.5, 'ST060', 'EX039', 'GEA1-2401B', '2024-03-01'), ('GR138', 8.0, 'ST060', 'EX040', 'GEA1-2401B', '2024-04-12'),
('GR139', 8.5, 'ST061', 'EX055', 'SATPREP-2402', '2024-04-10'), ('GR140', 9.0, 'ST061', 'EX056', 'SATPREP-2402', '2024-05-29'),
('GR141', 7.0, 'ST062', 'EX005', 'GEB1-2401', '2024-02-29'), ('GR142', 7.5, 'ST062', 'EX006', 'GEB1-2401', '2024-04-11'),
('GR143', 9.0, 'ST063', 'EX049', 'KIDSENG-2402', '2024-03-06'), ('GR144', 9.5, 'ST063', 'EX050', 'KIDSENG-2402', '2024-04-17'),
('GR145', 6.0, 'ST064', 'EX051', 'IELTS55-2402', '2024-04-03'), ('GR146', 6.5, 'ST064', 'EX052', 'IELTS55-2402', '2024-05-15'),
('GR147', 8.0, 'ST065', 'EX023', 'BECOM-2401', '2024-03-01'), ('GR148', 8.5, 'ST065', 'EX024', 'BECOM-2401', '2024-04-12'),
('GR149', 6.0, 'ST013', 'EX013', 'IELTS70-2401A', '2024-03-05'), ('GR150', 7.0, 'ST013', 'EX014', 'IELTS70-2401A', '2024-04-16'),
('GR151', 7.0, 'ST014', 'EX031', 'AWPRO-2401', '2024-03-20'), ('GR152', 7.5, 'ST014', 'EX032', 'AWPRO-2401', '2024-04-24'),
('GR153', 8.0, 'ST015', 'EX007', 'GEB2-2401', '2024-03-01'), ('GR154', 8.5, 'ST015', 'EX008', 'GEB2-2401', '2024-04-12'),
('GR155', 6.5, 'ST016', 'EX019', 'TOEICB-2401', '2024-02-29'), ('GR156', 7.0, 'ST016', 'EX020', 'TOEICB-2401', '2024-04-11'),
('GR157', 7.5, 'ST017', 'EX023', 'BECOM-2401', '2024-03-01'), ('GR158', 8.0, 'ST017', 'EX024', 'BECOM-2401', '2024-04-12'),
('GR159', 5.0, 'ST018', 'EX011', 'IELTS55-2401', '2024-03-05'), ('GR160', 5.5, 'ST018', 'EX012', 'IELTS55-2401', '2024-04-16'),
('GR161', 8.5, 'ST019', 'EX009', 'GEC1-2401', '2024-03-21'), ('GR162', 9.0, 'ST019', 'EX010', 'GEC1-2401', '2024-05-02'),
('GR163', 7.5, 'ST020', 'EX035', 'SATPREP-2401', '2024-03-12'), ('GR164', 8.0, 'ST020', 'EX036', 'SATPREP-2401', '2024-05-01'),
('GR165', 7.0, 'ST021', 'EX059', 'IELTS70-2403', '2024-04-18'), ('GR166', 7.5, 'ST021', 'EX060', 'IELTS70-2403', '2024-05-30'),
('GR167', 8.0, 'ST023', 'EX001', 'GEA1-2401', '2024-02-29'), ('GR168', 8.5, 'ST023', 'EX002', 'GEA1-2401', '2024-04-11'),
('GR169', 7.0, 'ST024', 'EX033', 'PTE65-2401', '2024-03-26'), ('GR170', 7.5, 'ST024', 'EX034', 'PTE65-2401', '2024-05-07'),
('GR171', 8.0, 'ST025', 'EX031', 'AWPRO-2401', '2024-03-20'), ('GR172', 8.5, 'ST025', 'EX032', 'AWPRO-2401', '2024-04-24'),
('GR173', 9.0, 'ST026', 'EX017', 'IELTSPRO-2401', '2024-03-19'), ('GR174', 9.5, 'ST026', 'EX018', 'IELTSPRO-2401', '2024-05-01'),
('GR175', 7.5, 'ST028', 'EX041', 'GEB1-2402', '2024-03-28'), ('GR176', 8.0, 'ST028', 'EX042', 'GEB1-2402', '2024-05-09'),
('GR177', 8.0, 'ST029', 'EX045', 'TOEICA-2402', '2024-04-03'), ('GR178', 8.5, 'ST029', 'EX046', 'TOEICA-2402', '2024-05-15'),
('GR179', 9.0, 'ST030', 'EX029', 'KIDSADV-2401', '2024-03-06'), ('GR180', 9.5, 'ST030', 'EX030', 'KIDSADV-2401', '2024-04-17'),
('GR181', 8.0, 'ST032', 'EX055', 'SATPREP-2402', '2024-04-10'), ('GR182', 8.5, 'ST032', 'EX056', 'SATPREP-2402', '2024-05-29'),
('GR183', 7.5, 'ST033', 'EX025', 'BEADV-2401', '2024-03-22'), ('GR184', 8.0, 'ST033', 'EX026', 'BEADV-2401', '2024-05-03'),
('GR185', 7.5, 'ST035', 'EX003', 'GEA2-2401', '2024-03-01'), ('GR186', 8.0, 'ST035', 'EX004', 'GEA2-2401', '2024-04-12'),
('GR187', 6.0, 'ST037', 'EX051', 'IELTS55-2402', '2024-04-03'), ('GR188', 6.5, 'ST037', 'EX052', 'IELTS55-2402', '2024-05-15'),
('GR189', 9.5, 'ST038', 'EX049', 'KIDSENG-2402', '2024-03-06'), ('GR190', 9.0, 'ST038', 'EX050', 'KIDSENG-2402', '2024-04-17'),
('GR191', 8.5, 'ST039', 'EX037', 'GMATPREP-2401', '2024-03-13'), ('GR192', 9.0, 'ST039', 'EX038', 'GMATPREP-2401', '2024-05-01'),
('GR193', 8.5, 'ST041', 'EX057', 'AWPRO-2402', '2024-04-16'), ('GR194', 9.0, 'ST041', 'EX058', 'AWPRO-2402', '2024-05-21'),
('GR195', 7.5, 'ST042', 'EX043', 'IELTS70-2402', '2024-03-29'), ('GR196', 8.0, 'ST042', 'EX044', 'IELTS70-2402', '2024-05-10'),
('GR197', 6.5, 'ST043', 'EX019', 'TOEICB-2401', '2024-02-29'), ('GR198', 7.0, 'ST043', 'EX020', 'TOEICB-2401', '2024-04-11'),
('GR199', 7.5, 'ST044', 'EX047', 'BECOM-2402', '2024-04-05'), ('GR200', 8.0, 'ST044', 'EX048', 'BECOM-2402', '2024-05-17'),
('GR201', 8.0, 'ST045', 'EX005', 'GEB1-2401', '2024-02-29'), ('GR202', 8.5, 'ST045', 'EX006', 'GEB1-2401', '2024-04-11'),
('GR203', 9.0, 'ST047', 'EX027', 'KIDSENG-2401', '2024-03-05'), ('GR204', 9.5, 'ST047', 'EX028', 'KIDSENG-2401', '2024-04-16'),
('GR205', 8.0, 'ST049', 'EX035', 'SATPREP-2401', '2024-03-12'), ('GR206', 8.5, 'ST049', 'EX036', 'SATPREP-2401', '2024-05-01'),
('GR207', 7.0, 'ST050', 'EX013', 'IELTS70-2401A', '2024-03-05'), ('GR208', 7.5, 'ST050', 'EX014', 'IELTS70-2401A', '2024-04-16'),
('GR209', 7.5, 'ST051', 'EX039', 'GEA1-2401B', '2024-03-01'), ('GR210', 8.0, 'ST051', 'EX040', 'GEA1-2401B', '2024-04-12'),
('GR211', 5.5, 'ST052', 'EX011', 'IELTS55-2401', '2024-03-05'), ('GR212', 6.0, 'ST052', 'EX012', 'IELTS55-2401', '2024-04-16'),
('GR213', 8.5, 'ST053', 'EX009', 'GEC1-2401', '2024-03-21'), ('GR214', 9.0, 'ST053', 'EX010', 'GEC1-2401', '2024-05-02'),
('GR215', 7.5, 'ST054', 'EX025', 'BEADV-2401', '2024-03-22'), ('GR216', 8.0, 'ST054', 'EX026', 'BEADV-2401', '2024-05-03'),
('GR217', 7.0, 'ST055', 'EX033', 'PTE65-2401', '2024-03-26'), ('GR218', 7.5, 'ST055', 'EX034', 'PTE65-2401', '2024-05-07'),
('GR219', 8.0, 'ST056', 'EX031', 'AWPRO-2401', '2024-03-20'), ('GR220', 8.5, 'ST056', 'EX032', 'AWPRO-2401', '2024-04-24'),
('GR221', 8.0, 'ST057', 'EX045', 'TOEICA-2402', '2024-04-03'), ('GR222', 8.5, 'ST057', 'EX046', 'TOEICA-2402', '2024-05-15'),
('GR223', 7.0, 'ST058', 'EX053', 'GEB2-2402', '2024-04-03'), ('GR224', 7.5, 'ST058', 'EX054', 'GEB2-2402', '2024-05-15'),
('GR225', 8.0, 'ST059', 'EX055', 'SATPREP-2402', '2024-04-10'), ('GR226', 8.5, 'ST059', 'EX056', 'SATPREP-2402', '2024-05-29'),
('GR227', 7.5, 'ST060', 'EX059', 'IELTS70-2403', '2024-04-18'), ('GR228', 8.0, 'ST060', 'EX060', 'IELTS70-2403', '2024-05-30'),
('GR229', 8.5, 'ST061', 'EX037', 'GMATPREP-2401', '2024-03-13'), ('GR230', 9.0, 'ST061', 'EX038', 'GMATPREP-2401', '2024-05-01'),
('GR231', 9.0, 'ST062', 'EX029', 'KIDSADV-2401', '2024-03-06'), ('GR232', 9.5, 'ST062', 'EX030', 'KIDSADV-2401', '2024-04-17'),
('GR233', 7.0, 'ST063', 'EX003', 'GEA2-2401', '2024-03-01'), ('GR234', 7.5, 'ST063', 'EX004', 'GEA2-2401', '2024-04-12'),
('GR235', 7.5, 'ST064', 'EX023', 'BECOM-2401', '2024-03-01'), ('GR236', 8.0, 'ST064', 'EX024', 'BECOM-2401', '2024-04-12'),
('GR237', 7.0, 'ST065', 'EX015', 'IELTS70-2401B', '2024-03-06'), ('GR238', 7.5, 'ST065', 'EX016', 'IELTS70-2401B', '2024-04-17'),
('GR239', 6.0, 'ST001', 'EX061', 'IELTS70-2401A', '2024-03-05'), ('GR240', 6.5, 'ST001', 'EX062', 'IELTS70-2401A', '2024-03-05'),
('GR241', 7.0, 'ST004', 'EX069', 'TOEICA-2401', '2024-03-01'), ('GR242', 7.5, 'ST004', 'EX021', 'TOEICA-2401', '2024-02-29'),
('GR243', 8.0, 'ST005', 'EX073', 'GMATPREP-2401', '2024-03-13'), ('GR244', 8.0, 'ST005', 'EX074', 'AWPRO-2401', '2024-03-20'),
('GR245', 7.5, 'ST007', 'EX063', 'IELTS70-2401B', '2024-03-06'), ('GR246', 7.0, 'ST007', 'EX064', 'IELTS70-2401B', '2024-03-06'),
('GR247', 8.0, 'ST013', 'EX065', 'IELTS70-2402', '2024-03-29'), ('GR248', 7.5, 'ST013', 'EX066', 'IELTS70-2402', '2024-03-29'),
('GR249', 8.5, 'ST014', 'EX053', 'GEB2-2402', '2024-04-03'), ('GR250', 8.0, 'ST014', 'EX075', 'AWPRO-2402', '2024-04-16'),
('GR251', 7.0, 'ST020', 'EX070', 'TOEICA-2402', '2024-04-05'), ('GR252', 8.0, 'ST020', 'EX045', 'TOEICA-2402', '2024-04-03'),
('GR253', 8.5, 'ST024', 'EX072', 'SATPREP-2402', '2024-04-10'), ('GR254', 8.0, 'ST024', 'EX055', 'SATPREP-2402', '2024-04-10'),
('GR255', 8.0, 'ST030', 'EX067', 'IELTS70-2403', '2024-04-18'), ('GR256', 7.5, 'ST030', 'EX068', 'IELTS70-2403', '2024-04-18'),
('GR257', 9.0, 'ST031', 'EX071', 'SATPREP-2401', '2024-03-12'), ('GR258', 9.0, 'ST031', 'EX035', 'SATPREP-2401', '2024-03-12'),
('GR259', 8.5, 'ST039', 'EX072', 'SATPREP-2402', '2024-04-10'), ('GR260', 8.5, 'ST039', 'EX055', 'SATPREP-2402', '2024-04-10');
GO

/*Testing if needed
SELECT * FROM Teacher ORDER BY id
SELECT * FROM Student ORDER BY id
SELECT * FROM Course ORDER BY id
SELECT * FROM Course_Material ORDER BY id
SELECT * FROM Class ORDER BY course_id, id
SELECT * FROM Class_Student ORDER BY class_id, student_id
SELECT * FROM Exam ORDER BY class_id, date
SELECT * FROM Grade ORDER BY student_id, exam_id
SELECT * FROM Payment ORDER BY student_id, payment_date
SELECT * FROM AuditLog ORDER BY LogID */
