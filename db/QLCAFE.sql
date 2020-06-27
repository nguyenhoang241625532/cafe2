﻿CREATE DATABASE QLCAFE
GO
USE QLCAFE
GO
CREATE TABLE NHANVIEN
(
	MANV VARCHAR(5) PRIMARY KEY,
	HOTEN NVARCHAR(50),
	NGAYSINH SMALLDATETIME,
	DIACHI NVARCHAR(100),
	CMND VARCHAR(12),
	SDT VARCHAR(11),
	NGAYVAOLAM SMALLDATETIME,
	PASSWORDS VARCHAR(20),
	LOAINV VARCHAR(2), -- NV, QL
)
GO
CREATE TABLE BAN
(
	MABAN INT PRIMARY KEY,
	TENBAN NVARCHAR(10),
	TRANGTHAI NVARCHAR(20) -- free, serving, waitting
)
GO
CREATE TABLE ORDERS
(
	MAORDER VARCHAR(5) PRIMARY KEY,
	NGAYLAP SMALLDATETIME,
	MABAN INT, -- REFERENCES BAN(MABAN)
	TRANGTHAI NVARCHAR(20), -- order (chưa thanh toán), invoice (đã thanh toán)
	TRIGIA MONEY,
	MAKM VARCHAR(5),
	PHAITRA MONEY
)
GO
CREATE TABLE LOAIDOUONG
(
	MALOAIDOUONG VARCHAR(5) PRIMARY KEY,
	TENLOAIDOUONG NVARCHAR(30),
	HINHANH VARCHAR(50)
)
GO
CREATE TABLE DOUONG
(
	MADOUONG VARCHAR(5) PRIMARY KEY,
	TENDOUONG NVARCHAR(30),
	GIABAN MONEY,
	MALOAIDOUONG VARCHAR(5), -- REFERENCES LOAIDOUONG(MALOAIDOUONG)
	HINHANH VARCHAR(50)
)
GO
CREATE TABLE CTORDERS
(
	MAORDER VARCHAR(5), -- REFERENCES ORDERS
	MADOUONG VARCHAR(5), -- REFERENCES DOUONG
	GIABAN MONEY,
	SOLUONG INT,
	THANHTIEN MONEY,

	PRIMARY KEY(MAORDER, MADOUONG)
)
GO
CREATE TABLE NGUYENVATLIEU
(
	MANVL VARCHAR(5) PRIMARY KEY,
	TENNVL NVARCHAR(30),
	SOLUONG INT,
	DONGIA MONEY,
	DONVITINH NVARCHAR(15),
)
GO
CREATE TABLE PHIEUNHAPHANG
(
	MAPHIEUNHAP VARCHAR(5) PRIMARY KEY,
	NGAYLAP SMALLDATETIME,
	NHANVIENLAPPHIEU VARCHAR(5), -- REFERENCES NHANVIEN(MANV)
	TRANGTHAI NVARCHAR(20), -- chờ nhận hàng, đã nhận hàng (BỎ)
	TRIGIA MONEY
)
GO
CREATE TABLE CTPHIEUNHAPHANG
(
	MAPHIEUNHAP VARCHAR(5), -- REFERENCES PHIEUNHAPHANG
	MANVL VARCHAR(5), -- REFERENCES NGUYENVATLIEU
	SOLUONG INT,
	DONGIA MONEY,
	
	PRIMARY KEY (MAPHIEUNHAP, MANVL)
)
GO
CREATE TABLE KHUYENMAI
(
	MAKM VARCHAR(5) PRIMARY KEY,
	TENKM NVARCHAR(50),
	NGAYBATDAU SMALLDATETIME,
	NGAYKETTHUC SMALLDATETIME,
	LOAIKM NVARCHAR(20),
	TRIGIAAPDUNG MONEY,
	TRIGIAKM MONEY
)
GO
CREATE TABLE PHIEUXUATHANG
(
	MAPHIEUXUAT VARCHAR(5) PRIMARY KEY,
	NGAYLAP SMALLDATETIME,
	NHANVIENLAPPHIEU VARCHAR(5),
	TRIGIA MONEY
)
GO
CREATE TABLE CTPHIEUXUATHANG
(
	MAPHIEUXUAT VARCHAR(5),
	MANVL VARCHAR(5),
	SOLUONG INT,
	DONGIA INT,
	PRIMARY KEY (MAPHIEUXUAT, MANVL)
)
GO
ALTER TABLE ORDERS
ADD CONSTRAINT FK_MABAN FOREIGN KEY (MABAN) REFERENCES BAN(MABAN)
GO
ALTER TABLE ORDERS
ADD CONSTRAINT FK_MAKM FOREIGN KEY (MAKM) REFERENCES KHUYENMAI(MAKM)
GO
ALTER TABLE DOUONG
ADD CONSTRAINT FK_MALOAIDOUONG FOREIGN KEY (MALOAIDOUONG) REFERENCES LOAIDOUONG(MALOAIDOUONG)
GO
ALTER TABLE CTORDERS
ADD CONSTRAINT FK_MAORDER FOREIGN KEY (MAORDER) REFERENCES ORDERS(MAORDER)
GO
ALTER TABLE CTORDERS
ADD CONSTRAINT FK_MADOUONG FOREIGN KEY (MADOUONG) REFERENCES DOUONG(MADOUONG)
GO
ALTER TABLE PHIEUNHAPHANG
ADD CONSTRAINT FK_MANHANVIENLAPPHIEU FOREIGN KEY (NHANVIENLAPPHIEU) REFERENCES NHANVIEN(MANV)
GO
ALTER TABLE CTPHIEUNHAPHANG
ADD CONSTRAINT FK_MAPHIEUNHAP FOREIGN KEY (MAPHIEUNHAP) REFERENCES PHIEUNHAPHANG(MAPHIEUNHAP)
GO
ALTER TABLE CTPHIEUNHAPHANG
ADD CONSTRAINT FK_MANVL FOREIGN KEY (MANVL) REFERENCES NGUYENVATLIEU(MANVL)
GO
ALTER TABLE PHIEUXUATHANG
ADD CONSTRAINT FK_MANVLAPPHIEU FOREIGN KEY (NHANVIENLAPPHIEU) REFERENCES NHANVIEN(MANV)
GO
ALTER TABLE CTPHIEUXUATHANG
ADD CONSTRAINT FK_MAPHIEUXUAT FOREIGN KEY (MAPHIEUXUAT) REFERENCES PHIEUXUATHANG(MAPHIEUXUAT)
GO
ALTER TABLE CTPHIEUXUATHANG
ADD CONSTRAINT FK_MANVLXUAT FOREIGN KEY (MANVL) REFERENCES NGUYENVATLIEU(MANVL)


GO
UPDATE CTORDERS
SET THANHTIEN = SOLUONG*GIABAN
GO
UPDATE CTPHIEUNHAPHANG
SET THANHTIEN = SOLUONG*DONGIA


GO
SET DATEFORMAT DMY

-- NHẬP LIỆU

-- Nhân viên
GO
INSERT INTO NHANVIEN(MANV, HOTEN, NGAYSINH, DIACHI, CMND, SDT, NGAYVAOLAM, PASSWORDS, LOAINV) 
VALUES ('NV001', N'TRẦN THÀNH VI THANH', '02/12/1996', N'3 Phan Đăng Lưu, phường 3, quận Bình Thạnh, TPHCM', '715348625', '0964243496', '01/01/2017', '123', 'QL')
GO
INSERT INTO NHANVIEN(MANV, HOTEN, NGAYSINH, DIACHI, CMND, SDT, NGAYVAOLAM, PASSWORDS, LOAINV) 
VALUES ('NV002', N'LÊ VĂN TIỆP', '22/08/1996', N'557/12 Quốc Lộ 13, phường Hiệp Bình Phước, quận Thủ Đức, TPHCM', '742628943', '0963166238', '04/01/2017', '123', 'NV')
GO
INSERT INTO NHANVIEN(MANV, HOTEN, NGAYSINH, DIACHI, CMND, SDT, NGAYVAOLAM, PASSWORDS, LOAINV) 
VALUES ('NV003', N'PHAN THỊ TRƯỜNG THANH', '04/01/1996', N'637 Kha Vạn Cân, phường Linh Chiểu, quận Thủ Đức, TPHCM', '412143762', '01697379513', '03/01/2017', '123', 'NV')

-- Bàn
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (1, N'Bàn số 1', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (2, N'Bàn số 2', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (3, N'Bàn số 3', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (4, N'Bàn số 4', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (5, N'Bàn số 5', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (6, N'Bàn số 6', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (7, N'Bàn số 7', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (8, N'Bàn số 8', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (9, N'Bàn số 9', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (10, N'Bàn số 10', N'Trống')
GO
INSERT INTO BAN(MABAN, TENBAN, TRANGTHAI) 
VALUES (11, N'Bàn số 11', N'Trống')

-- Loại đồ uống
GO
INSERT INTO LOAIDOUONG(MALOAIDOUONG, TENLOAIDOUONG, HINHANH) 
VALUES ('ST', N'Sinh tố', N'\src\img\Product type\vitamins.png')
GO
INSERT INTO LOAIDOUONG(MALOAIDOUONG, TENLOAIDOUONG, HINHANH) 
VALUES ('CF', N'Cafe', N'\src\img\Product type\coffee_cup.png')
GO
INSERT INTO LOAIDOUONG(MALOAIDOUONG, TENLOAIDOUONG, HINHANH) 
VALUES ('NN', N'Nước ngọt', N'\src\img\Product type\soft_drink.png')
GO
INSERT INTO LOAIDOUONG(MALOAIDOUONG, TENLOAIDOUONG, HINHANH) 
VALUES ('KH', N'Khác', N'\src\img\Product type\other.png')

-- Đồ uống
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('ST001', N'Sinh tố bơ', 20000, 'ST' ,N'\src\img\Product\ST\sinh to bo.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('ST002', N'Sinh tố dâu', 20000, 'ST' ,N'\src\img\Product\ST\sinhto dau.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('ST003', N'Sinh tố dưa hấu', 20000, 'ST' ,N'\src\img\Product\ST\sinh to dua hau.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN001', N'C2', 10000, 'NN' ,N'\src\img\Product\NN\c2.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN002', N'Coca cola', 12000, 'NN' ,N'\src\img\Product\NN\coca cola.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN003', N'Dr.Thanh', 10000, 'NN' ,N'\src\img\Product\NN\dr thanh.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN004', N'Number 1', 12000, 'NN' ,N'\src\img\Product\NN\number one.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN005', N'Nước suối', 8000, 'NN' ,N'\src\img\Product\NN\aquafina.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN006', N'Nutri dâu', 15000, 'NN' ,N'\src\img\Product\NN\nutri dau.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN007', N'0 độ', 12000, 'NN' ,N'\src\img\Product\NN\o do.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN008', N'Ô long', 12000, 'NN' ,N'\src\img\Product\NN\olong tea+.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN009', N'Pepsi', 12000, 'NN' ,N'\src\img\Product\NN\pepsi.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('NN010', N'Sting', 12000, 'NN' ,N'\src\img\Product\NN\sting.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('CF001', N'Cafe đá', 10000, 'CF' ,N'\src\img\Product\CF\cafe den da.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('CF002', N'Cafe sữa đá', 15000, 'CF' ,N'\src\img\Product\CF\cafe sua da.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('CF003', N'Cafe nóng', 10000, 'CF' ,N'\src\img\Product\CF\cafe nong.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('KH001', N'Cam ép', 15000, 'KH' ,N'\src\img\Product\KH\cam ep.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('KH002', N'Lipton đá', 15000, 'KH' ,N'\src\img\Product\KH\lipton da.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('KH003', N'Nước dừa', 15000, 'KH' ,N'\src\img\Product\KH\nuoc dua.png')
GO
INSERT INTO DOUONG(MADOUONG, TENDOUONG, GIABAN, MALOAIDOUONG, HINHANH) 
VALUES ('KH004', N'Sữa tươi', 12000, 'KH' ,N'\src\img\Product\KH\sua tuoi.png')


-- Nguyên vật liệu
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL001', N'C2', 10 , 5000, N'Chai')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL002', N'Coca cola', 24 , 6000, N'Lon')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH) 
VALUES ('NL003', N'Dr Thanh', 12 , 6000, N'Chai')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL004', N'Number One', 24 , 8000, N'Chai')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL005', N'Nước suối Awafina', 30 , 4000, N'Chai')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL006', N'Nutri dâu', 24 , 9000, N'Chai')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH) 
VALUES ('NL007', N'Trà xanh 0 độ', 10 , 8000, N'Chai')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL008', N'Ô long tea plus', 6 , 8000, N'Chai')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH) 
VALUES ('NL009', N'Pepsi', 30 , 6000, N'Lon')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL010', N'Sting', 30 , 8000, N'Chai')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL011', N'Bơ trái', 5 , 25000, N'Kilogram')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL012', N'Dừa trái', 30 , 6000, N'Trái')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL013', N'Dưa hấu', 5 , 15000, N'Kilogram')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL014', N'Dâu trái', 6 , 40000, N'Kilogram')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL015', N'Sữa hộp 1 lít', 10 , 28000, N'Hộp')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL016', N'Cam trái', 5 , 10000, N'Kilogram')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL017', N'Cafe bịch', 5 , 50000, N'Bịch')
GO
INSERT INTO NGUYENVATLIEU(MANVL, TENNVL, SOLUONG, DONGIA, DONVITINH)
VALUES ('NL018', N'Sữa đặc', 10 , 55000, N'Hộp')


-- Khuyến mãi
GO
INSERT INTO KHUYENMAI (MAKM, TENKM, NGAYBATDAU, NGAYKETTHUC, LOAIKM, TRIGIAAPDUNG, TRIGIAKM)
VALUES ('KM000', N'Không áp dụng', '01/01/2017', '01/01/2020', N'Giảm tiền mặt', 0, 0)
GO
INSERT INTO KHUYENMAI (MAKM, TENKM, NGAYBATDAU, NGAYKETTHUC, LOAIKM, TRIGIAAPDUNG, TRIGIAKM)
VALUES ('KM001', N'Giảm 10000 nhân dịp khai trương', '01/01/2017', '15/01/2017', N'Giảm tiền mặt', 100000, 10000)
GO
INSERT INTO KHUYENMAI (MAKM, TENKM, NGAYBATDAU, NGAYKETTHUC, LOAIKM, TRIGIAAPDUNG, TRIGIAKM)
VALUES ('KM002', N'Giảm 50000 nhân dịp valentine', '12/02/2017', '15/02/2017', N'Giảm tiền mặt', 200000, 50000)
GO
INSERT INTO KHUYENMAI (MAKM, TENKM, NGAYBATDAU, NGAYKETTHUC, LOAIKM, TRIGIAAPDUNG, TRIGIAKM)
VALUES ('KM003', N'Xoá', '12/02/2017', '15/02/2017', N'Giảm tiền mặt', 200000, 50000)
GO
INSERT INTO KHUYENMAI (MAKM, TENKM, NGAYBATDAU, NGAYKETTHUC, LOAIKM, TRIGIAAPDUNG, TRIGIAKM)
VALUES ('KM004', N'Xoá', '12/02/2017', '15/02/2017', N'Giảm tiền mặt', 200000, 50000)
GO
INSERT INTO KHUYENMAI (MAKM, TENKM, NGAYBATDAU, NGAYKETTHUC, LOAIKM, TRIGIAAPDUNG, TRIGIAKM)
VALUES ('KM005', N'Xoá', '12/02/2017', '15/02/2017', N'Giảm tiền mặt', 200000, 50000)
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] 
( @strInput NVARCHAR(4000) ) 
RETURNS NVARCHAR(4000) 
AS 
BEGIN 
	IF @strInput IS NULL RETURN @strInput 
	IF @strInput = '' RETURN @strInput 
	DECLARE @RT NVARCHAR(4000) 
	DECLARE @SIGN_CHARS NCHAR(136) 
	DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' 
	DECLARE @COUNTER int 
	DECLARE @COUNTER1 int SET @COUNTER = 1 
	WHILE (@COUNTER <=LEN(@strInput)) 
	BEGIN 
		SET @COUNTER1 = 1 
		WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
		BEGIN 
			IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
			BEGIN 
				IF @COUNTER=1 
					SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
				ELSE 
					SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
					BREAK 
			END 
			SET @COUNTER1 = @COUNTER1 +1 
		END 
		SET @COUNTER = @COUNTER +1 
	END 
	SET @strInput = replace(@strInput,' ','-') 
	RETURN @strInput 
END

SELECT * FROM DOUONG WHERE dbo.fuConvertToUnsign1(TENDOUONG) LIKE N'%' + dbo.fuConvertToUnsign1(N'do') + '%'

DELETE FROM DOUONG WHERE MADOUONG = 'NN011'

UPDATE DOUONG SET HINHANH = '\src\img\Product\NN\NN011.png' WHERE MADOUONG = 'NN011'

SELECT * FROM KHUYENMAI WHERE GETDATE() BETWEEN NGAYBATDAU AND NGAYKETTHUC

DELETE FROM KHUYENMAI WHERE TENKM = N'Xoá'

SELECT * FROM CTORDERS, ORDERS WHERE CTORDERS.MAORDER = ORDERS.MAORDER AND ORDERS.MAORDER = 'SO000' AND ORDERS.TRANGTHAI = N'Chưa thanh toán'