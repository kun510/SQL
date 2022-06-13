use master
go
if exists(select * from sys.databases where name = 'QLDeAn_TCUONG')
	drop database QLDeAn_TCUONG
GO
create database QLDeAn_TCUONG
go
use QLDeAn_TCUONG
go
CREATE TABLE PHONGBAN
(
	TENPHONG NVARCHAR(30),
	MAPHG INT NOT NULL,
	TRPHG CHAR(9),
	NG_NHANCHUC DATETIME,
	constraint PK_PB PRIMARY KEY (MAPHG)
)
CREATE TABLE NHANVIEN
(
	HONV  NVARCHAR(30),
	TENLOT  NVARCHAR(30),
	TEN  NVARCHAR(30),
	MANV CHAR(9) NOT NULL,
	NGSINH DATETIME,
	DCHI NVARCHAR(50),
	PHAI NCHAR(6),
	LUONG FLOAT,
	PHG INT,
	constraint PK_NV PRIMARY KEY(MANV)
)

CREATE TABLE DIADIEM_PHG
(
	MAPHG INT NOT NULL,
	DIADIEM NVARCHAR(30) NOT NULL,
	constraint PK_DD PRIMARY KEY (MAPHG, DIADIEM)
)

CREATE TABLE PHANCONG
(
	MADA INT NOT NULL,
	MA_NVIEN CHAR(9) NOT NULL,
	VITRI NVARCHAR(50),
	constraint PK_PC PRIMARY KEY ( MADA,MA_NVIEN)
)

CREATE TABLE THANNHAN
(
	MA_NVIEN CHAR(9) NOT NULL,
	TENTN NVARCHAR(30) NOT NULL,
	PHAI NCHAR(6),
	NGSINH DATETIME,
	QUANHE NVARCHAR(16),
	constraint PK_TN PRIMARY KEY (MA_NVIEN, TENTN)
)

CREATE TABLE DEAN
(
	TENDA NVARCHAR(30),
	MADA INT NOT NULL,
	DDIEM_DA NVARCHAR(30),
	NGAYBD DATETIME,
	NGAYKT DATETIME,
	constraint PK_DA PRIMARY KEY (MADA)
)
/*TAO KHOA NGOAI CHO CAC BANG*/
/*TRPHG - NHANVIEN(MANV)*/
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_PHONGBAN 
FOREIGN KEY (PHG) REFERENCES PHONGBAN(MAPHG) 

ALTER TABLE PHONGBAN ADD CONSTRAINT FK_PHONGBAN_NHANVIEN
FOREIGN KEY (TRPHG) REFERENCES NHANVIEN(MANV) 


ALTER TABLE DIADIEM_PHG ADD CONSTRAINT FK_DIADIEM_PHG_PHONGBAN
FOREIGN KEY (MAPHG) REFERENCES PHONGBAN(MAPHG)


ALTER TABLE THANNHAN ADD CONSTRAINT FK_THANNHAN_NHANVIEN
FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)


ALTER TABLE PHANCONG ADD CONSTRAINT FK_PHANCONG_NHANVIEN
FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)

ALTER TABLE PHANCONG ADD CONSTRAINT FK_PHANCONG_DEAN
FOREIGN KEY (MADA) REFERENCES DEAN(MADA)

---NHAP DU LIEU BANG PHONG BAN
INSERT INTO PHONGBAN (TENPHONG,MAPHG,TRPHG,NG_NHANCHUC)
VALUES	(N'Phòng Triển Khai',5,NULL,'2010-05-20'),
		(N'Phòng Xây Dựng',4,NULL,'2011-01-01'),
		(N'Phòng Quản Lý',1,NULL,'2012-06-19')
		---NHAP DU LIEU BANG NHAN VIEN
INSERT INTO NHANVIEN(HONV,TENLOT,TEN,MANV,NGSINH,DCHI,PHAI,LUONG,PHG)
Values	(N'Đinh',N'Bá',N'Tiên','123456789','1970-01-09',N'TPHCM',N'Nam',30000,5),
		(N'Nguyễn',N'Thanh',N'Tùng','333445555','1975-12-08',N'TPHCM',N'Nam',40000,5),
		(N'Bùi',N'Thúy',N'Vũ','999887777','1980-07-19',N'Đà Nẵng',N'Nữ',25000,4),
		(N'Lê',N'Thị',N'Nhàn','987654321','1978-06-20',N'Huế',N'Nữ',43000,4),
		(N'Nguyễn',N'Mạnh',N'Hùng','666884444','1984-09-15',N'Quảng Nam',N'Nam',38000,5),
		(N'Trần',N'Thanh',N'Tâm','453453453','1988-07-31',N'Quảng Trị',N'Nam',25000,5),
		(N'Trần',N'Hồng',N'Quân','987987987','1990-03-29',N'Đà Nẵng',N'Nam',25000,4),
		(N'Vương',N'Ngọc',N'Quyền','888665555','1965-10-10',N'Quảng Ngãi',N'Nữ',55000,1)
Go
-----CẬP NHẬT DỮ LIỆU BẢNG PHÒNG BAN
UPDATE PHONGBAN
SET  TRPHG='333445555'
WHERE MAPHG=5
UPDATE PHONGBAN
SET  TRPHG='987987987'
WHERE MAPHG=4
UPDATE PHONGBAN
SET  TRPHG='888665555'
WHERE MAPHG=1
---NHAP DU LIEU BANG DIADIEM_PHG
INSERT INTO DIADIEM_PHG(MAPHG,DIADIEM)
VALUES	(1,N'Đà Nẵng'),
		(4,N'Đà Nẵng'),
		(5,N'Đà Nẵng'),
		(5,N'Hà Nội'),
		(5,N'Quảng Nam')
go
---NHAP DU LIEU BANG DIADIEM_PHG
INSERT INTO THANNHAN(MA_NVIEN,TENTN,PHAI,NGSINH,QUANHE)
values	('333445555',N'Quang',N'Nữ','2005-04-05',N'Con gai'),
		('333445555',N'Khang',N'Nam','2008-10-25',N'Con trai'),
		('333445555',N'Duong',N'Nữ','2078-05-03',N'Vo chong'),
		('987654321',N'Dang',N'Nam','2070-02-20',N'Vo chong'),
		('123456789',N'Duy',N'Nam','2000-01-01',N'Con trai'),
		('123456789',N'Chau',N'Nữ','2004-12-31',N'Con gai'),
		('123456789',N'Phuong',N'Nữ','2077-05-05',N'Vo chong')
Go
---NHAP DU LIEU BANG DEAN
INSERT INTO DEAN(TENDA,MADA,DDIEM_DA,NGAYBD,NGAYKT)
values	(N'Quản Lí Khách Sạn',100,N'Đà Nẵng','2012-01-01','2012-02-20'),
		(N'Quản Lí Bệnh Viện',200,N'Đà Nẵng','2013-03-15','2013-06-30'),
		(N'Quản Lí Bán Hàng',300,N'Hà Nội','2013-12-01','2014-02-01'),
		(N'Quản Lí Đào Tạo',400,N'Hà Nội','2014-03-15',null)
Go
---NHAP DU LIEU BANG PHAN CONG
INSERT INTO PHANCONG(MADA,MA_NVIEN,VITRI)
values	(100,'333445555',N'Trưởng Nhóm'),
		(100,'123456789',N'Thành Viên'),
		(100,'666884444',N'Thành Viên'),
		(200,'987987987',N'Trưởng Dự Án'),
		(200,'999887777',N'Trưởng Nhóm'),
		(200,'453453453',N'Thành Viên'),
		(200,'987654321',N'Thành Viên'),
		(300,'987987987',N'Trưởng Dự Án'),
		(300,'999887777',N'Trưởng Nhóm'),
		(300,'333445555',N'Trưởng Nhóm'),
		(300,'666884444',N'Thành Viên'),
		(300,'123456789',N'Thành Viên'),
		(400,'987987987',N'Trưởng Dự Án'),
		(400,'999887777',N'Trưởng Nhóm'),
		(400,'123456789',N'Thành Viên'),
		(400,'333445555',N'Thành Viên'),
		(400,'987654321',N'Thành Viên'),
		(400,'666884444',N'Thành Viên')
Go
select *
	from PHONGBAN
	inner join NHANVIEN
	on NHANVIEN.PHG = PHONGBAN.MAPHG 
	WHERE PHONGBAN.TENPHONG= N'Phòng triển khai'
--------------
select NHANVIEN.TEN
from NHANVIEN
	inner join PHONGBAN 
	on NHANVIEN.MANV = PHONGBAN.TRPHG
	where PHONGBAN.TENPHONG = N'Phòng Quản Lý'
----------
select NHANVIEN.HONV,NHANVIEN.TEN
from NHANVIEN
	inner join PHONGBAN on NHANVIEN.MANV = PHONGBAN.TRPHG
	inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	inner join DEAN on PHANCONG.MADA = DEAN.MADA
	where DEAN.DDIEM_DA =N'Hà Nội'

-- cho biết họ tên nhân viên có thân nhân
select NHANVIEN.HONV,NHANVIEN.TENLOT,NHANVIEN.TEN
from NHANVIEN
inner join THANNHAN on NHANVIEN.MANV = THANNHAN.MA_NVIEN

-- Cho biết họ tên nhân viên được phân công tham gia đề án
select NHANVIEN.HONV, NHANVIEN.TENLOT,NHANVIEN.TENLOT
from NHANVIEN
	inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	inner join DEAN on PHANCONG.MADA = DEAN.MADA
--Cho biết mã nhân viên (MA_NVIEN) có người thân và tham gia đề án. 
select NHANVIEN.MANV
from NHANVIEN
inner join THANNHAN on NHANVIEN.MANV = THANNHAN.MA_NVIEN
inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	inner join DEAN on PHANCONG.MADA = DEAN.MADA
--Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.
select DEAN.MADA,NHANVIEN.HONV,NHANVIEN.TEN
from NHANVIEN
	inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	inner join DEAN on PHANCONG.MADA = DEAN.MADA
	where NHANVIEN.HONV = N'Nguyễn'
--Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.
select DEAN.TENDA,NHANVIEN.HONV,NHANVIEN.TEN
from NHANVIEN
	inner join PHONGBAN on NHANVIEN.MANV = PHONGBAN.TRPHG
	inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	inner join DEAN on PHANCONG.MADA = DEAN.MADA
	where NHANVIEN.HONV = N'Nguyễn'
-- Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có
select NHANVIEN.TEN,PHONGBAN.TENPHONG
from NHANVIEN
	inner join PHONGBAN on NHANVIEN.MANV = PHONGBAN.TRPHG
--Danh sách những đề án có: 
--		 Người tham gia có họ “Đinh”
select DEAN.TENDA,NHANVIEN.HONV,NHANVIEN.TEN
from NHANVIEN
	inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	inner join DEAN on PHANCONG.MADA = DEAN.MADA
	where NHANVIEN.HONV = N'Đinh'
--		 Có người trưởng phòng chủ trì đề án họ “Đinh”
select DEAN.TENDA,NHANVIEN.HONV,NHANVIEN.TEN
from NHANVIEN
	inner join PHONGBAN on NHANVIEN.MANV = PHONGBAN.TRPHG
	inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	inner join DEAN on PHANCONG.MADA = DEAN.MADA
	where NHANVIEN.HONV = N'Đinh'
--Cho biết những nhân viên có cùng tên với người thân


--Cho biết danh sách những nhân viên có 2 thân nhân trở lên 
select NHANVIEN.HONV,NHANVIEN.TEN, COUNT(*) as soluongthannhan
from NHANVIEN inner join THANNHAN on NHANVIEN.MANV = THANNHAN.MA_NVIEN
group by NHANVIEN.HONV,NHANVIEN.TEN
having count(*) >= 2 
	
--. Cho biết những trưởng phòng có tối thiểu 1 thân nhân 
SELECT NHANVIEN.HONV,NHANVIEN.TENLOT,NHANVIEN.TEN
FROM NHANVIEN
	INNER JOIN PHONGBAN ON PHONGBAN.TRPHG = NHANVIEN.MANV
	AND EXISTS
	(SELECT MANV 
		FROM THANNHAN
		WHERE PHONGBAN.TRPHG = THANNHAN.MA_NVIEN)
--Cho biết những trưởng phòng có mức lương ít hơn (ít nhất một) nhân viên của mình
select *	
		from  (select nv1.MANV,nv1.TEN,nv1.LUONG,nv1.PHG
				from NHANVIEN as nv1 inner join
				PHONGBAN as pb on nv1.MANV=pb.TRPHG) as tp cross join--lấy toàn bộ 2 bảng
				NHANVIEN as nv2
		where tp.PHG=nv2.PHG and tp.MANV<>nv2.MANV and tp.LUONG<nv2.LUONG

		select HoNV,TENLOT,Ten
from NhanVien
where MaNV in 
		(select TRPHG
		from PhongBan
		)
			and MaNV in 
		(select MANV
		from ThanNhan
		where NhanVien.MaNV=ThanNhan.Ma_NVien)

		--a cho biet danh sach cac nhan vien thuoc phong trien khai
Select *
from PHONGBAN pb inner join NHANVIEN nv on nv.PHG = pb.MAPHG
	where pb.TENPHONG= N'Phòng triển khai'
go
--b Cho biet ho ten truong phong cua phong quan ly
Select nv.HONV, nv.TENLOT, nv.TEN
from NHANVIEN nv inner join PHONGBAN pb on nv.MANV= pb.TRPHG
	where pb.TENPHONG= N'Phòng quản lí'
go
--c Cho biet ho ten nhung truong phong tham gia de an o "Ha Noi"
Select nv.HONV, nv.TENLOT, nv.TEN
from NHANVIEN nv inner join PHONGBAN pb on nv.MANV = pb.TRPHG
				inner join PHANCONG pc on nv.MANV = pc.MA_NVIEN
				inner join DEAN da on da.MADA = pc.MADA
		where da.DDIEM_DA= N'Hà Nội'
--thầy hỏi thêm
select *
	from DEAN inner join PHANCONG on DEAN.MADA = PHANCONG.MADA
			inner join NHANVIEN on PHANCONG.MA_NVIEN = NHANVIEN.MANV
			Where NHANVIEN.HONV =N'Đinh' and NHANVIEN.TENLOT =N'Bá' and NHANVIEN.TEN = N'Tiên'
go
--d. Cho biết họ tên nhân viên có thân nhân.
Select nv.HONV, nv.TENLOT, nv.TEN
From NHANVIEN nv inner join 
		THANNHAN tn on nv.MANV = tn.MA_NVIEN
go
--e. Cho biết họ tên nhân viên được phân công tham gia đề án.
Select nv.HONV, nv.TENLOT, nv.TEN
From NHANVIEN nv inner join 
		PHANCONG pc on nv.MANV = pc.MA_NVIEN inner join
		DEAN da on da.MADA = pc.MADA
go
--f. Cho biết mã nhân viên (MANV) có người thân và tham gia đề án.
Select nv.HONV, nv.TENLOT, nv.TEN
From NHANVIEN nv inner join 
		PHANCONG pc on nv.MANV = pc.MA_NVIENinner join
		DEAN da on da.MADA = pc.MADA inner join
		THANNHAN tn on tn.MA_NVIEN = nv.MANV 
go
--g. Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.
Select da.MADA
From DEAN da inner join 
		PHANCONG pc on da.MADA = pc.MADA inner join
		NHANVIEN nv on nv.MANV = pc.MA_NVIEN
Where nv.HONV = N'Nguyễn'
go
--h. Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.
Select da.TENDA
From DEAN da inner join 
		PHANCONG pc on da.MADA = pc.MADA inner join
		NHANVIEN nv on nv.MANV = pc.MA_NVIEN inner join
		PHONGBAN pb on pb.TRPHG = nv.MANV
Where nv.HONV = N'Nguyễn'
go
--i. Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có
Select nv.HONV, nv.TENLOT, nv.TEN, pb.TENPHONG
From NHANVIEN nv inner join PHONGBAN pb on nv.PHG = pb.MAPHG
go
--j. Danh sách những đề án có:
--o Người tham gia có họ “Đinh”
Select da.MADA, da.TENDA, nv.HONV, nv.TENLOT, nv.TEN
From DEAN da inner join 
		PHANCONG pc on da.MADA = pc.MADA inner join
		NHANVIEN nv on nv.MANV = pc.MA_NVIEN
Where nv.HONV = N'Đinh'
go
--o Có người trưởng phòng chủ trì đề án họ “Đinh”
Select da.MADA, da.TENDA, nv.HONV, nv.TENLOT, nv.TEN
From DEAN da inner join 
		PHANCONG pc on da.MADA = pc.MADA inner join
		NHANVIEN nv on nv.MANV = pc.MA_NVIEN inner join
		PHONGBAN pb on pb.TRPHG = nv.MANV
Where nv.HONV = N'Đinh'
go
----------Các lệnh truy vấn lồng

---------k. Viết lại tất cả các câu trên thành các câu SELECT lồng.

      --a cho biet danh sach cac nhan vien thuoc phong trien khai
Select *
from  PHONGBAN pb inner join NHANVIEN nv on nv.PHG = pb.MAPHG
	where pb.TENPHONG  in ( select TENPHONG
							from PHONGBAN
							where pb.TENPHONG like N'Phòng triển khai'
						)
go
     --b Cho biet ho ten truong phong cua phong quan ly
Select nv.HONV, nv.TENLOT, nv.TEN
from NHANVIEN nv inner join PHONGBAN pb on nv.MANV= pb.TRPHG
	where pb.TENPHONG in ( select TENPHONG
							from PHONGBAN
							where pb.TENPHONG= N'Phòng quản lí'
						) 
go
     --c Cho biet ho ten nhung truong phong tham gia de an o "Ha Noi"
Select nv.HONV, nv.TENLOT, nv.TEN
from NHANVIEN nv inner join PHONGBAN pb on nv.MANV = pb.TRPHG
				inner join PHANCONG pc on nv.MANV = pc.MA_NVIEN
				inner join DEAN da on da.MADA = pc.MADA
	where da.DDIEM_DA in (Select DDIEM_DA
								from DEAN
							where da.DDIEM_DA = N'Hà Nội'
							)
go
      --d. Cho biết họ tên nhân viên có thân nhân.
Select nv.HONV, nv.TENLOT, nv.TEN
From NHANVIEN nv inner join 
	THANNHAN tn on nv.MANV = tn.MA_NVIEN
--e. Cho biết họ tên nhân viên được phân công tham gia đề án.
Select nv.HONV, nv.TENLOT, nv.TEN
From NHANVIEN nv inner join 
		PHANCONG pc on nv.MANV = pc.MA_NVIEN inner join
		DEAN da on da.MADA = pc.MADA
--f. Cho biết mã nhân viên (MANV) có người thân và tham gia đề án.
Select nv.HONV, nv.TENLOT, nv.TEN
From NHANVIEN nv inner join 
		PHANCONG pc on nv.MANV = pc.MA_NVIEN inner join
		DEAN da on da.MADA = pc.MADA inner join
		THANNHAN tn on tn.MA_NVIEN= nv.MANV 
--g. Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.
Select da.MADA
From DEAN da inner join 
		PHANCONG pc on da.MADA = pc.MADA inner join
		NHANVIEN nv on nv.MANV = pc.MA_NVIEN
Where nv.HONV in (Select HONV
					from NHANVIEN
					where nv.HONV = N'Nguyễn'
				  )
--h. Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.
Select da.TENDA
From DEAN da inner join 
		PHANCONG pc on da.MADA = pc.MADA inner join
		NHANVIEN nv on nv.MANV = pc.MA_NVIEN inner join
		PHONGBAN pb on pb.TRPHG = nv.MANV
Where nv.HONV in (Select HONV
					from NHANVIEN
					where nv.HONV = N'Nguyễn'
					)
--i. Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có
Select nv.HONV, nv.TENLOT, nv.TEN, pb.TENPHONG
From NHANVIEN nv inner join PHONGBAN pb on nv.PHG = pb.MAPHG
--j. Danh sách những đề án có:
--o Người tham gia có họ “Đinh”
Select da.MADA, da.TENDA, nv.HONV, nv.TENLOT, nv.TEN
From DEAN da inner join 
		PHANCONG pc on da.MADA = pc.MADA inner join
		NHANVIEN nv on nv.MANV = pc.MA_NVIEN
Where nv.HONV in (Select HONV
						from NHANVIEN
						where nv.HONV = N'Đinh'
					)
--o Có người trưởng phòng chủ trì đề án họ “Đinh”
Select da.MADA, da.TENDA, nv.HONV, nv.TENLOT, nv.TEN
From DEAN da inner join 
		PHANCONG pc on da.MADA = pc.MADA inner join
		NHANVIEN nv on nv.MANV = pc.MA_NVIEN inner join
		PHONGBAN pb on pb.TRPHG = nv.MANV
Where nv.HONV in (Select HONV
						from NHANVIEN
						where nv.HONV = N'Đinh'
					)
go
--l. Cho biết những nhân viên có cùng tên với người thân
SELECT NHANVIEN.TEN
FROM NHANVIEN 
WHERE EXISTS (
SELECT *
FROM THANNHAN 
WHERE NHANVIEN.TEN=THANNHAN.TENTN
)

--m. Cho biết danh sách những nhân viên có 2 thân nhân trở lên
Select nv.HONV, nv.TENLOT, nv.TEN
From NHANVIEN nv
where (Select Count(*)
			from THANNHAN tn
			where nv.MANV = tn.MA_NVIEN
		)>=2
go
--n. Cho biết những trưởng phòng có tối thiểu 1 thân nhân
Select nv.HONV, nv.TENLOT, nv.TEN
From NHANVIEN nv inner join PHONGBAN pb on nv.MANV = pb.TRPHG
where (Select Count(*)
			from THANNHAN tn
			where nv.MANV = tn.MA_NVIEN
		)>=1
go
--cách 2
SELECT NHANVIEN.HONV,NHANVIEN.TENLOT,NHANVIEN.TEN
FROM NHANVIEN
	INNER JOIN PHONGBAN ON PHONGBAN.TRPHG = NHANVIEN.MANV
	AND EXISTS
	(SELECT MANV 
		FROM THANNHAN
		WHERE PHONGBAN.TRPHG = THANNHAN.MA_NVIEN)
--o. Cho biết những trưởng phòng có mức lương ít hơn (ít nhất một) nhân viên của mình
select *
        from  (select nv1.MANV,nv1.TEN,nv1.LUONG,nv1.PHG
                from NHANVIEN as nv1 inner join
                PHONGBAN as pb on nv1.MANV=pb.TRPHG) as tp cross join
                NHANVIEN as nv2
        where tp.PHG=nv2.PHG and tp.MANV<>nv2.MANV and tp.LUONG<nv2.LUONG
----------Các lệnh về gom nhóm
--p. Cho biết tên phòng, mức lương trung bình của phòng đó >40000.
Select pb.TENPHONG, SoLuongNv = count(*), LuongTrungBinh = avg(LUONG)
from NHANVIEN nv, PHONGBAN pb
where nv.PHG =pb.MAPHG
group by pb.TENPHONG
having avg(LUONG)>40000
go
--q. Cho biết lương trung bình của tất các nhân viên nữ phòng số 4
Select pb.MAPHG, LuongTrungBinh = avg(LUONG)
From NHANVIEN nv inner join PHONGBAN pb on nv.PHG = pb.MAPHG
where  pb.MAPHG = 4 and nv.PHAI = N'Nữ'
group by pb.MAPHG
go
--r. Cho biết họ tên và số thân nhân của nhân viên phòng số 5 có trên 2 thân nhân
Select nv.HONV, nv.TENLOT, nv.TEN, count(*) as 'Số lượng thân nhân'
from NHANVIEN nv, THANNHAN tn, PHONGBAN pb
where nv.MANV = tn.MA_NVIEN and nv.PHG = pb.MAPHG and pb.MAPHG = 5
group by nv.HONV, nv.TENLOT, nv.TEN
having count(*)>=2
--s. Ứng với mỗi phòng cho biết họ tên nhân viên có mức lương cao nhất
Select pb.MAPHG, max(Luong) as 'Lương cao nhất'
from NHANVIEN nv, PHONGBAN pb
where nv.PHG = pb.MAPHG
group by pb.MAPHG
--t. Cho biết họ tên nhân viên nam và số lượng các đề án mà nhân viên đó tham gia
SELECT  PHANCONG.MA_NVIEN, HONV, NHANVIEN.TEN, COUNT(*) AS SL_DA
FROM PHANCONG, NHANVIEN
WHERE PHANCONG.MA_NVIEN =NHANVIEN.MANV and NHANVIEN.PHAI = N'Nam'
GROUP BY PHANCONG.MA_NVIEN, HONV, NHANVIEN.TEN

--u. Cho biết nhân viên (HONV, TENLOT, TENNV) nào có lương cao nhất.
 SELECT NV.HONV, NV.TENLOT, NV.TEN , NV.LUONG
    FROM NHANVIEN NV
    WHERE NV.LUONG = (SELECT TOP 1 NV.LUONG FROM NHANVIEN NV order by NV.LUONG DESC)
	----------------------------------------------
	Select (nv.HONV + nv.TENLOT+ nv.TEN) as N'Họ Tên', Sum(nv.LUONG) as 'LươngCaoNhat'
from NHANVIEN nv inner join PHONGBAN pb on nv.PHG = pb.MAPHG
group by nv.HONV, nv.TENLOT, nv.TEN 
having Sum(nv.LUONG) >= ALL (Select sum(LUONG)
                                From NHANVIEN inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
                                group by HONV,TENLOT,TEN,TENPHONG
                                )
go

--v. Cho biết mã nhân viên (MA_NVIEN) nào có nhiều thân nhân nhất.
Select nv.MANV, count(*) as 'Số lượng thân nhân'
From THANNHAN tn inner join NHANVIEN nv on nv.MANV = tn.MA_NVIEN
group by nv.MANV
having count(*) >= ALL (Select count(*)
                                from THANNHAN tn inner join NHANVIEN nv  on nv.MANV = tn.MA_NVIEN
                                group by nv.HONV
                        )
go

--w. Cho biết họ tên trưởng phòng của phòng có đông nhân viên nhất
SELECT PHONGBAN.TENPHONG, (NHANVIEN.HONV + NHANVIEN.TENLOT  + NHANVIEN.TEN) AS 'Họ tên trưởng phòng của phòng ban đông nhân viên nhất'
	FROM NHANVIEN, PHONGBAN
	WHERE NHANVIEN.MANV = PHONGBAN.TRPHG AND
		  PHONGBAN.MAPHG = (SELECT top 1 PHONGBAN.MAPHG
							FROM NHANVIEN, PHONGBAN
							WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
							GROUP BY PHONGBAN.MAPHG
							ORDER BY COUNT (NHANVIEN.PHG) DESC
							)
						--

--x. Đếm số nhân viên nữ của từng phòng, hiển thị: TenPHG, SoNVNữ, những khoa không có nhân viên nữ hiển thị SoNVNữ=0
SELECT  PHONGBAN.TENPHONG ,  COUNT(*) AS SoNV_Nu
FROM PHONGBAN inner join  NHANVIEN nv  on nv.PHG = PHONGBAN.MAPHG
WHERE  nv.PHAI = N'Nữ'
GROUP BY PHONGBAN.TENPHONG
----------3. VIEW
--a. Cho biết tên phòng, số lượng nhân viên và mức lương trung bình của từng phòng.
--b. Cho biết họ tên nhân viên và số lượng các đề án mà nhân viên đó tham gia
--c. Thống kê số nhân viên của từng phòng, hiển thị: MaPH, TenPHG, SoNVNữ, SoNVNam, TongSoNV.


create View vw_ThongKeNhanVien
as
select MAPHG, TENPHONG,
case
	when NHANVIEN.PHAI=N'nữ'then count(*)
	else 0
	end as [Số nhân viên nữ],
case
	when NHANVIEN.PHAI=N'Nam' then count(*)
	else 0
	end as [Số nhân viên nam],
count(*) as [Tổng nhân viên]
from NHANVIEN, PHONGBAN
where PHONGBAN.MAPHG=NHANVIEN.PHG
group by MAPHG, TENPHONG,PHAI

select *
from vw_ThongKeNhanVien

----BÀI TẬP---------
--5. PROCEDURE
--a. Tạo thủ tục hiển thị nhân viên (họ tên) tham gia nhiều dự án nhất trong năm 2013
	create proc usp_nhanvienthamgia
	@tongsothamgia int output				
	as
		begin 
			SELECT  top 1 NHANVIEN.HONV,NHANVIEN.TENLOT,NHANVIEN.TEN, PHANCONG.MA_NVIEN as madeanthamgianhieunhat
	                        FROM PHANCONG inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
							inner join DEAN on PHANCONG.MADA = DEAN.MADA
                            WHERE  year(DEAN.NGAYBD)=2013  
                            GROUP BY NHANVIEN.HONV,NHANVIEN.TENLOT ,NHANVIEN.TEN, PHANCONG.MA_NVIEN
                            ORDER BY COUNT (PHANCONG.MA_NVIEN) desc
                       	 
		end
execute usp_nhanvienthamgia ' '
--b. Tạo thủ tục hiển thị tên dự án, trưởng dự án và số nhân viên tham gia dự án đó.
	create proc usp_tenduan1 
	@tongsothamgia nvarchar(20) output 
	as														
		begin
			Select nv.TEN,pc.VITRI,da.TENDA, count(nv.MANV) as sonhanvienthamgia 
							From NHANVIEN nv inner join 
								PHANCONG pc on nv.MANV = pc.MA_NVIEN inner join
								DEAN da on da.MADA = pc.MADA
							group by nv.TEN,pc.VITRI,da.TENDA
		end
exec usp_tenduan1 N' '
--c. Tạo thủ tục truyền vào mã dự án, hiển thị tất cả các nhân viên tham gia dự án đó.
	Alter proc usp_duan
	@maduan int
	as
		begin
			if not exists (select * from DEAN where DEAN.MADA=@maduan)
			return 0
			else  
			Select nv.HONV, nv.TENLOT, nv.TEN
				From NHANVIEN nv inner join 
				PHANCONG pc on nv.MANV = pc.MA_NVIEN inner join
				DEAN da on da.MADA = pc.MADA
				where da.MADA = @maduan
		end
declare @mada int = 400
execute usp_duan @mada
--d. Tạo thủ tục truyền vào mã phòng ban, hiển thị tên phòng ban, số lượng nhân viên và số lượng địa điểm của phòng ban đó.
Alter proc usp_Phongban
	@mapb int
as
	Begin
		if not exists (select * from PHONGBAN pb where pb.MAPHG = @mapb)
			return 0
		else 
			Select pb.TENPHONG, pb.MAPHG, count(nv.MANV) as 'số lượng nhân viên'
			From PHONGBAN pb inner join NHANVIEN nv on nv.PHG = pb.MAPHG
				where pb.MAPHG = @mapb
			Group by   pb.TENPHONG	, pb.MAPHG
	end
 
declare @mada int = 4 
execute usp_Phongban @mada 
--e. Tạo thủ tục truyền vào mã nhân viên (@manv) và vị trí (@vitri), hiển thị tên những dự án mà @manv tham gia với vị trí là @vitri.
alter proc usp_nhanvien
	@manv int,
	@vitri NVARCHAR(50)
as
	begin
		 if not exists (select * from NHANVIEN nv where nv.MANV = @manv )
            return 0
		else
			select nv.MANV,pc.VITRI,da.TENDA
			from NHANVIEN nv inner join PHANCONG pc on nv.MANV = pc.MA_NVIEN
			inner join DEAN da on pc.MADA = da.MADA
			where nv.MANV = @manv and pc.VITRI =@vitri
	end
declare @ma char(9)	= '123456789'
declare @vt nvarchar(50) = N'Thành viên'
execute   usp_nhanvien @ma, @vt

--f. Tạo thủ tục:
--o Tham số vào: @mapb
--o Tham số ra: @luongcaonhat, @tennhanvien: lương cao nhất của phòng ban đó và họ tên nhân viên đạt lương cao nhất đó.
 

	alter proc usp_Luong 
    @mapb int, 
    @luongcaonhat float output,
    @tennhanvien nvarchar(30) output
as
    begin
        if not exists (select * from PHONGBAN pb where pb.MAPHG = @mapb)
            return 0
        else
           Select top 1 nv.TEN,pb.MAPHG , max(Luong) as 'Lương cao nhất'
			from NHANVIEN nv, PHONGBAN pb
			where  pb.MAPHG=@mapb and nv.MANV = pb.MAPHG
			group by pb.MAPHG,nv.TEN,nv.LUONG
			order by nv.LUONG desc
           
    end

declare @maphong int = 1
declare @luong float 
declare @tennv nvarchar(30)
execute usp_Luong @maphong, @luong output, @tennv  output
--g. Tạo thủ tục:
--o Tham số vào: @ngaybatdau, @ngayketthuc
--o Tham số ra: @soduan: số lượng dự án bắt đầu và kết thúc trong khoảng thời gian trên (có nghĩa sau bắt đầu sau @ ngaybatdau và kết thúc trước @ngayketthuc)
alter proc usp_Soluongdu
	@ngaybatdau datetime ,
	@ngayketthuc datetime,
	@soduan int	 output
as
	Begin 
		if not exists (select * from DEAN da where da.NGAYBD = @ngaybatdau 
												and da.NGAYKT = @ngayketthuc )
            return 0
        else 
			 Select @soduan = count(*) 
				From  DEAN da 
				where @ngaybatdau < @ngayketthuc
	end

declare @bd datetime = '2012-01-01'
declare @kt datetime = '2014-03-15'
declare @soduan1 int 
execute usp_Soluongdu @bd, @kt , @soduan1  output
print @soduan1
--h. Tạo thủ tục:
--o Tham số vào: @mada
--o Tham số ra: @sonu, @sonam: số nhân viên nữ và nhân viên nam tham gia dự án đó.
Create Proc usp_NhanVienThamGiaDA
	@mada int,
	@sonu int output,
	@sonam int output
as
	Begin
		if not exists (select * from NHANVIEN nv where nv.PHAI = N'Nữ' or nv.PHAI = N'Nam' )
            return 0
        else
	end
--i. Tạo thủ tục thêm mới một phòng ban với các tham số vào: @mapb, @tenpb, @trphg, @ngnhanchuc. Yêu cầu:
--o Kiểm tra @mapb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục.
--o Kiểm tra @tenpb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục.
--o Kiểm tra @trphg có phải là nhân viên không, nếu không phải là nhân viên thì thông báo và kết thúc thủ tục.
--o Nếu các điều kiện trên đều thỏa thì cho thêm mới phòng ban.
create Proc usp_Themphongban
	@tenpb nvarchar(30), @mapb int,
	@trphg char(9), @ngnhanchuc datetime
AS
	begin
		--Kiểm tra @mapb có tồn tại k
		IF EXISTS(SELECT MAPHG FROM PHONGBAN WHERE MAPHG=@mapb) or @mapb is null
			BEGIN
				RAISERROR(N'Mã phòng ban đã tồn tại', 16,1)
				RETURN 1
			END
		--Kiểm tra Tên Phòng Ban có tồn tại k
		IF  EXISTS(SELECT TENPHONG FROM PHONGBAN WHERE TENPHONG = @tenpb) or @tenpb is null
			BEGIN
				RAISERROR(N'Tên Phòng ban đã tồn tại', 16,1)
				RETURN 1
			END
		--Kiểm tra Trưởng phòng có phải là nhân viên k
		IF EXISTS(SELECT TRPHG FROM PHONGBAN WHERE TRPHG = @trphg) or @trphg is null
			BEGIN
				RAISERROR(N'Trưởng phòng là nhân viên', 16,1)
				RETURN 1
			END
		-- Thêm mới
		INSERT INTO PHONGBAN
		VALUES(@tenpb,@mapb,@trphg,@ngnhanchuc)
		RETURN 0
	end

EXEC usp_Themphongban N'Phòng11',5,'113422333','2030-07-07'
select * from PHONGBAN
--j. Tạo thủ tục cập nhật ngày kết thúc của một dự án với tham số vào là @mada và @ngayketthuc. Yêu cầu:
--o Kiểm tra @mada có tồn tại không, nếu không thì thông báo và kết thúc thủ tục.
--o Kiểm tra @ngayketthuc có sau ngày bắt đầu không, nếu không thì thông báo và kết thúc thủ tục
--o Nếu các điều kiện trên đều thỏa thì cho cập nhật ngày kết thúc.
-------------------------------------------
create PROC usp_duan_1
    @mada int,  @ngayketthuc datetime
AS
    begin
        --Kiểm tra @mada có tồn tại không
        IF not EXISTS(SELECT da.MADA FROM DEAN da WHERE da.MADA = @mada ) or @mada is null
            BEGIN
                RAISERROR(N'ket thuc1', 16,1)
                RETURN 1
            END
        --Kiểm tra @ngayketthuc có sau ngày bắt đầu không
		if exists (select da.NGAYKT from DEAN da where da.NGAYBD > @ngayketthuc)
			begin
				raiserror(N'ket thuc3',16,1)
				return 1 
				end
        -- Nếu tất cả dữ liệu đều hợp lệ thì thêm mới
        update DEAN
		set NGAYKT ='2030-07-08' where DEAN.MADA = 300
        RETURN 0
    end
--sử dụng
declare  @mada int = 300
declare  @ngayketthuc datetime 
execute usp_duan_1 @mada,@ngayketthuc
select * from DEAN

--k. Tạo thủ tục phân công nhân viên vào dự án mới. Các tham số vào là: @mada, @manv, @vitri. Yêu cầu:
--o @vitri chỉ nhận một trong 3 giá trị: “Trưởng dự án”, “Trưởng nhóm” và “Thành viên”. Nếu không thỏa điều kiện này thì thông báo và kết thúc thủ tục.
--o Nếu @vitri = “Trưởng dự án” thì kiểm tra dự án @duan đã có nhân viên làm “Trưởng dự án” chưa, nếu có rồi thì thông báo và kết thúc thủ tục.
--o Nếu các điều kiện trên đều thỏa thì cho thêm mới phân công.
----------------------------------------------
alter PROC usp_phancong
	@mada int, 
    @manv char(9),
    @vitri nvarchar(30)
AS
    begin
        
		if  not exists (select * from PHANCONG pc where @vitri = 'Trưởng dự án'or @vitri ='Trưởng nhóm'or @vitri = 'Thành viên' )
            BEGIN
                RAISERROR(N'kết thúc ',16,1)
                RETURN 1
            END
       
        if exists (select * from PHANCONG  pc where @vitri = 'Trưởng dự án')
            BEGIN
                RAISERROR(N'Kết thúc 1', 16,1)
                RETURN 1
            END
        -- Nếu tất cả dữ liệu đều hợp lệ thì thêm mới
        INSERT INTO PHANCONG
        VALUES(@mada, @manv, @vitri)
        RETURN 0
    end
--sử dụng
declare @madean int = 4
declare @manhanvien char(9) = '98798'
declare @vitri nvarchar(30) = N'Thành viên'
execute usp_phancong  @madean,@manhanvien, @vitri
select * from PHANCONG
--6. FUNCTION
--a. Viết hàm tính lương trung bình của một phòng ban bất kỳ
alter FUNCTION F_LUONGTB_phg (@maphong INT)
    RETURNS INT
    AS
        BEGIN
            RETURN (SELECT AVG(NHANVIEN.LUONG) AS 'Lương trung bình của phòng ban'
                    FROM NHANVIEN inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
                    WHERE PHONGBAN.MAPHG = @maphong
                    )
        END
Declare @kq int 
set @kq = dbo.F_LUONGTB_phg(4)
print @kq



--b. Viết hàm xác định một nhân viên có tham gia dự án nào đó với chức vụ là “Trưởng dự án” hay không.
	alter function ufd_duan_chuvu (@manv char(9))
	returns int
	as
		begin
			declare @dem int
			if not exists ( select * from NHANVIEN nv inner join PHANCONG pc on nv.MANV = pc.MA_NVIEN
							inner join DEAN da on pc.MADA = da.MADA
											where nv.MANV = @manv and pc.VITRI = N'Trưởng dự án' )
			return 0
			select @dem = count(nv.MANV) 
						from NHANVIEN nv inner join PHANCONG pc on nv.MANV = pc.MA_NVIEN
							inner join DEAN da on pc.MADA = da.MADA	
						where pc.VITRI = N'Trưởng dự án' 
			return @dem
		end 

Declare @kq int 
set @kq = dbo.ufd_duan_chuvu('987987987')
if(@kq = 0)
	print N'Không phải là trưởng dự án ' 
else
	print N'Nhân viên có chức vụ là trưởng dự án. '	

Select * from PHONGBAN
--c. Viết hàm đếm số lượng đề án đã tham gia của một nhân viên bất kỳ trong một năm bất kỳ
Create Function ufd_SoLuongDeAn(@manv char(9),@year int)
returns int 
as
	Begin 
		 declare @dem int
			if not exists ( select * from NHANVIEN nv 
											where nv.MANV = @manv )
			return 0
			select @dem = count(da.MADA) 
						from NHANVIEN nv inner join PHANCONG pc on nv.MANV = pc.MA_NVIEN
							inner join DEAN da on pc.MADA = da.MADA	
						where year(da.NGAYBD) = @year and year(da.NGAYKT) = @year 
			return @dem
	end

Declare @kq int 
set @kq = dbo.ufd_SoLuongDeAn('987987987',2012)
if(@kq = 0)
	print N'Không phải là nhân viên trong dự án ' 
else
	print N'Số lượng đề án trong năm là :  '  + cast(@kq as nvarchar)
--d. Viết hàm xác định số tiền thưởng cuối năm 2013 của một nhân viên bất kỳ với tiêu chí:
--+ 20 triệu đồng: Nếu nhân viên có tham gia dự án bắt đầu trong năm 2013 với vị trí “Trưởng dự án”
--+ 15 triệu đồng: Nếu nhân viên có tham gia dự án bắt đầu trong năm 2013 với vị trí “Trưởng nhóm”
--+ 10 triệu đồng: Các trường hợp còn lại
--(Lưu ý: mỗi nhân viên chỉ hưởng một mức cao nhất)
create function F_tienthuongcuoinam(@lt int(12))
	returns int
as 
	begin
		set @lt = 0
		begin
		if exists (Select NHANVIEN.LUONG from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN = NHANVIEN.MANV
				inner join DEAN on DEAN.MADA = PHANCONG.MADA
				where NHANVIEN.LUONG = @lt )
				return 0
			end
		begin 
		if exists (Select NHANVIEN.LUONG from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN = NHANVIEN.MANV
				inner join DEAN on DEAN.MADA = PHANCONG.MADA
				where year(DEAN.NGAYBD)>2013  and PHANCONG.VITRI=(N'Trưởng đề án'))
				return 1
		end
		begin
		if exists ( select NHANVIEN.LUONG from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN = NHANVIEN.MANV
				inner join DEAN on DEAN.MADA = PHANCONG.MADA
				where  PHANCONG.VITRI=(N'Trưởng nhóm')and year(DEAN.NGAYBD)>2013 )
				return 2
		end
		begin
		if exists ( select NHANVIEN.LUONG from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN = NHANVIEN.MANV
				inner join DEAN on DEAN.MADA = PHANCONG.MADA
				where  PHANCONG.VITRI=(N'Thành Viên'))
				return 3	
			end		

			
	end
declare @kq int 
set @kq = F_tienthuongcuoinam(2000 , @kq)
if(@kq=1)
	 Print (N'So tien cua truong phong tăng 20tr' )

else if(@kq=2)
	 Print (N'So tien cua truong phong  tăng 15tr' )

else(@kq=3)
	 Print (N'So tien cua truong phong tăng 10tr' )


--7. CURSOR
--a. Công ty quyết định tăng lương cho nhân viên như sau:
--+ 20% nếu tham gia ít nhất 2 dự án với chức vụ trưởng dự án
--+ 15% nếu là trưởng phòng hoặc người quản lý trực tiếp
--+ 10% nếu là nhân viên phòng số 5 có tham gia dự án bắt đầu và kết thúc trong năm 2014
--Dùng con trỏ duyệt qua từng dòng trong bảng NHANVIEN để thực hiện tăng lương như trên.

DECLARE tangluong CURSOR FOR
    select *
    from NHANVIEN
Open tangluong
    declare @vitri NVARCHAR(50)
    declare @luong float 
    declare @manv char(9)
    fetch next from tangluong 

    while @@FETCH_STATUS = 0
    begin
        begin
            set @vitri = N'Trưởng Dự Án'
            if exists(select HONV,TEN, LUONG,VITRI,count(DEAN.MADA) 'So lan tham gia DeAn'
                from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN = NHANVIEN.MANV
                    inner join DEAN on DEAN.MADA = PHANCONG.MADA
                where PHANCONG.VITRI = @vitri and NHANVIEN.LUONG = @luong
                group by LUONG,VITRI ,HONV,TEN
                having count(DEAN.MADA) > 2)
                update NHANVIEN set LUONG = 1.2  where MANV = @manv
            else
                fetch next from tangluong 
        end

        begin
            set @vitri = N'Trưởng Nhóm' 
            if exists(select HONV,TEN, LUONG,VITRI
                from NHANVIEN inner join PHANCONG on PHANCONG.MA_NVIEN = NHANVIEN.MANV
                    inner join DEAN on DEAN.MADA = PHANCONG.MADA
                where PHANCONG.VITRI = N'Trưởng Nhóm'and NHANVIEN.LUONG = @luong
                )
                update NHANVIEN set LUONG = 0.85  where MANV = @manv
            else
            fetch next from tangluong 
        end
    end

close tangluong
deallocate tangluong



select * from NHANVIEN
---------------
--b. Ứng với mỗi đề án, thêm mới 3 cột: số lượng trưởng dự án, số lượng trưởng nhóm, số lượng thành viên. Dùng con trỏ duyệt qua từng dòng trong bảng DEAN cập nhật dữ liệu cho 3 cột này. 


-- 6e. Viết hàm tính tổng tiền đã giao hàng cho một khách hàng bất kỳ trong năm bất kỳ.


--8. TRIGGER
--a. Tạo trigger cho ràng buộc: mỗi dự án có tối đa 10 nhân viên tham gia
Create trigger trg_RangBuoc 
on PhanCong
after insert
AS
    begin
        if (select count(*) from INSERTED)>1
            BEGIN
                RAISERROR(N'Chỉ chèn 1 dòng DL',16,1)
                ROLLBACK    -- Quay lui, hủy lệnh chèn DL
                RETURN    -- Cắt ngang, kết thúc trigger
            END

        declare @sl int
        select @sl = count(pc.MA_NVIEN) from PHANCONG pc inner join DEAN da on pc.MADA = da.MADA
        if @sl >=5
            begin
                raiserror(N'So luong con phai <=5',16,1)
                ROLLBACK
                return
            end
    end

select * from DEAN    where DEAN.MADA = 100

INSERT INTO PHANCONG(MADA,MA_NVIEN,VITRI)
values    (100,'111445555',N'Trưởng Nhóm')

--b. Tạo trigger cho ràng buộc: Với mỗi dự án,
--số lượng “trưởng dự án” phải ít hơn số lượng “trưởng nhóm” và
--số lượng “trưởng nhóm” phải ít hơn số lượng “thành viên”
Create trigger trg_RangBuocb
on PHANCONG
after insert
AS
    begin
        if (select count(*) from INSERTED)>1
            BEGIN
                RAISERROR(N'Chỉ chèn 1 dòng DL',16,1)
                ROLLBACK
                RETURN    
            END

        declare @truongda int, @truongnhom int, @thanhvien int    
        set @truongda =    (select count(*)
                            from PHANCONG pc
                            where pc.VITRI = N'Trưởng dự án')
        set @truongnhom = (select truongnhom = count(*)
                                from PHANCONG pc
                                where pc.VITRI = N'Trưởng nhóm')
        set @thanhvien =  (select truongda = count(*)
                                from PHANCONG pc
                                where pc.VITRI = N'Thành viên')
    
        if @truongda > @truongnhom
            begin
                raiserror(N'Số lượng trưởng dự án lớn hơn trưởng nhóm ',16,1)
                ROLLBACK
                return
            end
        if @truongnhom > @thanhvien
            Begin
                raiserror(N'Số lượng thành viên lớn hơn số lượng trưởng nhóm ',16,1)
                Rollback
                return
            end
    end


--c. Tạo trigger cho hành động Insert ngăn cấm việc chèn dữ liệu vào bảng PHANCONG với những đề án đã kết thúc
Alter Trigger trg_CamChen 
on     PHANCONG
INSTEAD OF Insert 
as    
    Begin
        if (select count(*) from INSERTED)>1
            BEGIN
                RAISERROR(N'Chỉ chèn 1 dòng DL',16,1)
                ROLLBACK
                RETURN    
            END
        declare @ngayketthuc datetime
        
        set @ngayketthuc = (select da.NGAYKT from DEAN da)

    end
INSERT INTO PHANCONG(MADA,MA_NVIEN,VITRI)
values    (100,'178467555',N'Thành viên')

Select * from PHANCONG

--d. Tạo trigger cho hành động Update ngăn cấm việc thay đổi thông tin của bảng PHANCONG với những đề án đã kết thúc.
Create Trigger trg_Update
on PHANCONG
Instead of Update
as
    Begin 
      if (select count(*) from INSERTED)>1
            BEGIN
                RAISERROR(N'Chỉ chèn 1 dòng DL',16,1)
                ROLLBACK
                RETURN    
            END
      RAISERROR(N'Không thể update',16,1)
    end

-- không được update

--e. Tạo trigger cho hành động Delete ngăn cấm việc xóa dữ liệu trong PHANCONG của những dự án đã kết thúc.
Create Trigger trg_Camxoa
on     PHANCONG
INSTEAD OF delete 
as
    Begin
       if (select count(*) from INSERTED)>1
            BEGIN
                RAISERROR(N'Chỉ chèn 1 dòng DL',16,1)
                ROLLBACK
                RETURN    
            END
      RAISERROR(N'Không thể delete',16,1)
    end
--f. Tạo trigger cho hành động Insert ngăn cấm việc phân công một nhân viên
--vào dự án mới nếu nhân viên đó đang tham gia một dự án chưa kết thúc
Create Trigger trg_CamInsert
on     PHANCONG
INSTEAD OF insert 
as
    Begin
       if (select count(*) from INSERTED)>1
            BEGIN
                RAISERROR(N'Chỉ chèn 1 dòng DL',16,1)
                ROLLBACK
                RETURN    
            END
      RAISERROR(N'Không thể insert',16,1)
    end