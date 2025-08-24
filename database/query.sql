create table HangHoa(
ma_hang int primary key auto_increment,
ten_hang varchar(50),
don_gia decimal(14,4),
don_vi varchar(50));

create table TramXang(
ma_tram int primary key auto_increment,
ten_tram varchar(50),
dia_chi varchar(255));

create table TruBom(
ma_tru int primary key auto_increment,
ten_tru varchar(50) not null,
con_lai decimal(12,3),
trang_thai tinyint,
ma_tram int,
ma_hang int,
foreign key (ma_tram) references TramXang(ma_tram),
foreign key (ma_hang) references HangHoa(ma_hang)
);

create table GiaoDich(
ma_giao_dich int primary key auto_increment,
ngay_giao_dich datetime,
thanh_tien decimal(14,4),
so_luong decimal(12,3),
ma_tram int,
ma_hang int,
ma_tru int,
foreign key (ma_tram) references TramXang(ma_tram),
foreign key (ma_hang) references HangHoa(ma_hang),
foreign key (ma_tru) references TruBom(ma_tru)
);

INSERT INTO HangHoa (ten_hang, don_gia, don_vi) VALUES
('Xăng A95',            25000.0000, 'L'),
('Xăng E5',             23000.0000, 'L'),
('Dầu DO',              22000.0000, 'L'),
('Xăng RON95-II',       25500.0000, 'L'),
('Dầu nhờn',           120000.0000, 'L'),
('Xăng A92',            24000.0000, 'L'),
('Xăng RON92',          24000.0000, 'L'),
('Dầu hỏa',             18000.0000, 'L'),
('Dầu nhớt tổng hợp',  150000.0000, 'L'),
('Xăng sinh học',       23500.0000, 'L');

INSERT INTO TramXang (ten_tram, dia_chi) VALUES
('Trạm Xăng A',  'Số 1, Đường A, Quận 1'),
('Trạm Xăng B',  'Số 12, Đường B, Quận 2'),
('Trạm Xăng C',  'Số 23, Đường C, Quận 3'),
('Trạm Xăng D',  'Số 34, Đường D, Quận 4'),
('Trạm Xăng E',  'Số 45, Đường E, Quận 5'),
('Trạm Xăng F',  'Số 56, Đường F, Quận 6'),
('Trạm Xăng G',  'Số 67, Đường G, Quận 7'),
('Trạm Xăng H',  'Số 78, Đường H, Quận 8'),
('Trạm Xăng I',  'Số 89, Đường I, Quận 9'),
('Trạm Xăng J',  'Số 90, Đường J, Quận 10');

/* MOCK DATA

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ A-1', 500.000, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Xăng A95'
WHERE tx.ten_tram = 'Trạm Xăng A'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ B-1', 300.500, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Xăng E5'
WHERE tx.ten_tram = 'Trạm Xăng B'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ C-1', 1000.000, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Dầu DO'
WHERE tx.ten_tram = 'Trạm Xăng C'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ D-1', 150.750, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Xăng RON95-II'
WHERE tx.ten_tram = 'Trạm Xăng D'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ E-1', 80.250, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Dầu nhờn'
WHERE tx.ten_tram = 'Trạm Xăng E'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ F-1', 420.000, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Xăng A92'
WHERE tx.ten_tram = 'Trạm Xăng F'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ G-1', 220.000, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Xăng RON92'
WHERE tx.ten_tram = 'Trạm Xăng G'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ H-1', 2000.000, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Dầu hỏa'
WHERE tx.ten_tram = 'Trạm Xăng H'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ I-1', 50.000, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Dầu nhớt tổng hợp'
WHERE tx.ten_tram = 'Trạm Xăng I'
LIMIT 1;

INSERT INTO TruBom (ten_tru, con_lai, trang_thai, ma_tram, ma_hang)
SELECT 'Trụ J-1', 600.000, 1, tx.ma_tram, h.ma_hang
FROM TramXang tx JOIN HangHoa h ON h.ten_hang = 'Xăng sinh học'
WHERE tx.ten_tram = 'Trạm Xăng J'
LIMIT 1;


-- =========================
-- GIAO DỊCH GIẢ LẬP 3 THÁNG
-- =========================

-- 2025-06
INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-06-01 08:15:00', 10.5, 10.5*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng A95'
JOIN TruBom tb ON tb.ten_tru='Trụ A-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng A' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-06-03 09:20:00', 7.2, 7.2*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Dầu DO'
JOIN TruBom tb ON tb.ten_tru='Trụ C-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng C' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-06-05 10:00:00', 5.0, 5.0*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng E5'
JOIN TruBom tb ON tb.ten_tru='Trụ B-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng B' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-06-10 08:40:00', 15.0, 15.0*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Dầu hỏa'
JOIN TruBom tb ON tb.ten_tru='Trụ H-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng H' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-06-15 11:10:00', 2.2, 2.2*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Dầu nhờn'
JOIN TruBom tb ON tb.ten_tru='Trụ E-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng E' LIMIT 1;

-- 2025-07
INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-07-01 09:05:00', 8.3, 8.3*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng A92'
JOIN TruBom tb ON tb.ten_tru='Trụ F-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng F' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-07-02 08:50:00', 3.5, 3.5*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng RON95-II'
JOIN TruBom tb ON tb.ten_tru='Trụ D-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng D' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-07-05 10:15:00', 1.1, 1.1*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Dầu nhớt tổng hợp'
JOIN TruBom tb ON tb.ten_tru='Trụ I-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng I' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-07-08 09:25:00', 6.0, 6.0*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng sinh học'
JOIN TruBom tb ON tb.ten_tru='Trụ J-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng J' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-07-10 08:45:00', 12.0, 12.0*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng A95'
JOIN TruBom tb ON tb.ten_tru='Trụ A-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng A' LIMIT 1;

-- 2025-08
INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-08-01 09:00:00', 9.0, 9.0*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng A95'
JOIN TruBom tb ON tb.ten_tru='Trụ A-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng A' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-08-02 08:30:00', 4.0, 4.0*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Dầu DO'
JOIN TruBom tb ON tb.ten_tru='Trụ C-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng C' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-08-05 08:10:00', 2.5, 2.5*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng RON92'
JOIN TruBom tb ON tb.ten_tru='Trụ G-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng G' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-08-07 10:30:00', 18.0, 18.0*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Dầu hỏa'
JOIN TruBom tb ON tb.ten_tru='Trụ H-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng H' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-08-10 11:05:00', 5.5, 5.5*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng E5'
JOIN TruBom tb ON tb.ten_tru='Trụ B-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng B' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-08-15 09:50:00', 1.8, 1.8*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Dầu nhờn'
JOIN TruBom tb ON tb.ten_tru='Trụ E-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng E' LIMIT 1;

INSERT INTO GiaoDich (ngay_giao_dich, so_luong, thanh_tien, ma_tram, ma_hang, ma_tru)
SELECT '2025-08-20 08:20:00', 6.7, 6.7*h.don_gia, tx.ma_tram, h.ma_hang, tb.ma_tru
FROM TramXang tx JOIN HangHoa h ON h.ten_hang='Xăng sinh học'
JOIN TruBom tb ON tb.ten_tru='Trụ J-1' AND tb.ma_tram=tx.ma_tram
WHERE tx.ten_tram='Trạm Xăng J' LIMIT 1;

*/

/*Lay cac giao dich trong khoang thoi gian*/
select * from GiaoDich
where ngay_giao_dich > '2025-08-01 08:15:00'
and ngay_giao_dich < '2025-08-01 11:00:00';

/*Tong doanh thu mot ngay cua tru bom, vi du tram 2*/
select t.ma_tru, t.ten_tru, sum(g.thanh_tien) as doanh_thu from giaodich g
join trubom t on t.ma_tru=g.ma_tru
where t.ma_tru = 2;

/*Doanh thu 1 ngay cua 1 tram, vi du tram 2*/
select t.ma_tram, t.ten_tram, sum(g.thanh_tien) as doanh_thu from giaodich g
join tramxang t on t.ma_tram=g.ma_tram
where t.ma_tram = 2;

/*Top 3 hoang hoa ban chay*/
select h.ma_hang, h.ten_hang, sum(g.so_luong) as tong_sl
from giaodich g join hanghoa h
on g.ma_hang = h.ma_hang
group by g.ma_hang
order by tong_sl desc
limit 3;

/*Tong so lit tai mot tram trong thang, vi du ma tram 2 va thang 8*/
select t.ma_tram, t.ten_tram, sum(g.so_luong) as tong_sl
from giaodich g join tramxang t
on g.ma_tram=t.ma_tram
where t.ma_tram=2 and month(g.ngay_giao_dich) = 8;