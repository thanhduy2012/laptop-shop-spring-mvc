--------------------------------------------------------------------------
-- Use Master
USE master
GO

--------------------------------------------------------------------------
-- XÓA DATABASE NẾU TỒN TẠI DATABASE HieuBoyShop TRONG HỆ THỐNG
IF  EXISTS (SELECT * FROM sysdatabases 	WHERE name = N'HieuBoyShop' )
--  
DROP DATABASE HieuBoyShop
GO

--------------------------------------------------------------------------
-- TẠO DATABASE
CREATE DATABASE HieuBoyShop
GO

--------------------------------------------------------------------------
-- DÙNG DATABASE
USE HieuBoyShop
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Tài Khoản
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Admin' )
DROP TABLE dbo.Admin
--------------------------------------------------------------------------
CREATE TABLE dbo.Admin(
	Username VARCHAR(50) NOT NULL,
	Password VARCHAR(50) NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	Access INT NOT NULL,
	
	PRIMARY KEY(Username),
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Phòng Ban
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Departments' )
DROP TABLE dbo.Departments
--------------------------------------------------------------------------
CREATE TABLE dbo.Departments(
	ID VARCHAR(12) NOT NULL,
	NameDepartment NVARCHAR(50) NOT NULL,

	PRIMARY KEY(ID)	
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Loại Nhân Viên
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'EmployeeTypes' )
DROP TABLE dbo.EmployeeTypes
--------------------------------------------------------------------------
CREATE TABLE dbo.EmployeeTypes(
	ID VARCHAR(12) NOT NULL,
	NameEmployeeType NVARCHAR(50) NOT NULL,
	
	PRIMARY KEY (ID)
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Nhân Viên
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Employees' )
DROP TABLE dbo.Employees
--------------------------------------------------------------------------
CREATE TABLE dbo.Employees(
	ID VARCHAR(20) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	Password NVARCHAR(50) NOT NULL,
	NameEmployee NVARCHAR(50) NOT NULL,
	Gender INT NOT NULL,
	Photo NVARCHAR (MAX) NULL,
	Address NVARCHAR(50) NOT NULL,
	NumberPhone NVARCHAR(25) NOT NULL,
	Birthday DATETIME NOT NULL,
	Access INT NOT NULL,
	Activated BIT NOT NULL,
	DepartmentID VARCHAR(12) NOT NULL,
	EmployeeTypeID VARCHAR(12) NOT NULL,
	
	PRIMARY KEY(ID),
	FOREIGN KEY(DepartmentID) REFERENCES Departments(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY(EmployeeTypeID) REFERENCES EmployeeTypes(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Hợp Đồng
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Contracts' )
DROP TABLE dbo.Contracts
--------------------------------------------------------------------------
CREATE TABLE dbo.Contracts(
	ID VARCHAR(20) NOT NULL,
	NameContract NVARCHAR(50) NOT NULL,
	StartTime DATETIME NOT NULL,
	EndTime DATETIME NULL,
	Subsidize INT NULL,
	Insurrance FLOAT NULL,
	Salary FLOAT NULL,
	Status INT NOT NULL,
	
	PRIMARY KEY(ID),
	CONSTRAINT FK_Employees FOREIGN KEY(ID) REFERENCES Employees(ID)
)
GO


--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Khen thưởng
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Bonus' )
DROP TABLE dbo.Bonus
--------------------------------------------------------------------------
CREATE TABLE dbo.Bonus
(
	ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY(ID),
	EmployeeID VARCHAR(20) NOT NULL,
	Type BIT NOT NULL,
	Amount FLOAT,
	Reason NVARCHAR(50),
	DateWrite DATETIME NOT NULL,
	
	CONSTRAINT FK_Bonus_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(ID)

)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Nhà Sản Xuát
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Producers' )
DROP TABLE dbo.Producers
--------------------------------------------------------------------------
CREATE TABLE dbo.Producers
(
	ID INT NOT NULL IDENTITY(1,1),
	NameProducer NVARCHAR(50) NOT NULL,
	Logo NVARCHAR(MAX) NULL,
	Address NVARCHAR(50) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	NumberPhone NVARCHAR(25) NOT NULL,
	PRIMARY KEY(ID),
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Danh Mục
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Categories' )
DROP TABLE dbo.Categories
--------------------------------------------------------------------------
CREATE TABLE dbo.Categories
(
	ID INT NOT NULL IDENTITY(1,1),
	NameCategory NVARCHAR(50) NOT NULL,
	NameCategoryEN NVARCHAR(50) NOT NULL,
	PRIMARY KEY(ID),
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Sản Phẩm
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Products' )
DROP TABLE dbo.Products
--------------------------------------------------------------------------
CREATE TABLE dbo.Products
(
	ID INT NOT NULL IDENTITY(1,1),
	NameProduct NVARCHAR(50) NOT NULL,
	Photo NVARCHAR(MAX) NULL,
	Quantity INT NOT NULL,
	ProductDate DATETIME NOT NULL,
	UnitBrief NVARCHAR(50) NOT NULL,
	UnitPrice FLOAT NOT NULL,
	Discount FLOAT NULL,
	Description NVARCHAR(1000) NULL,
	Views INT NULL,
	Available BIT NULL,
	Special BIT NULL,
	Latest BIT NULL,
	Status BIT NOT NULL,
	CategoryID INT NOT NULL,
	ProducerID INT NOT NULL,
	
	PRIMARY KEY(ID),
	CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(ID),
	CONSTRAINT FK_Products_Producers FOREIGN KEY (ProducerID) REFERENCES Producers(ID)
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Khách Hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Customers' )
DROP TABLE dbo.Customers
--------------------------------------------------------------------------
CREATE TABLE dbo.Customers
(
	ID VARCHAR(20) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	Password NVARCHAR(50) NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	Photo NVARCHAR(MAX) NULL,
	Address NVARCHAR(50) NOT NULL,
	NumberPhone NVARCHAR(25) NOT NULL,
	Birthday DATETIME NOT NULL,
	Gender INT NOT NULL,
	Activated BIT NOT NULL,
	
	PRIMARY KEY(ID),
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Đơn Hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Orders' )
DROP TABLE dbo.Orders
--------------------------------------------------------------------------
CREATE TABLE dbo.Orders
(
	ID INT NOT NULL IDENTITY(1,1),
	OrderDate DATETIME NOT NULL,
	RequireDate DATETIME NOT NULL,
	Amount FLOAT NOT NULL,
	Receiver NVARCHAR(50) NOT NULL,
	Address NVARCHAR(50) NOT NULL,
	Description NVARCHAR(1000) NULL,
	Status INT NOT NULL,
	NumberPhone VARCHAR(15)NULL,
	CustomerID VARCHAR(20)NULL,
	
	PRIMARY KEY (ID),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Chi Tiết Đơn Hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'OrderDetails' )
DROP TABLE dbo.OrderDetails
--------------------------------------------------------------------------
CREATE TABLE dbo.OrderDetails
(
	ID INT NOT NULL IDENTITY(1,1),
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL,
	Amount FLOAT NOT NULL,
	Discount FLOAT NOT NULL,
	
	PRIMARY KEY (ID),
	CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ID),
	CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(ID)
)
GO

--------------------------------------------------------------------------
-- NỐI 2 KHÓA CHÍNH CHO 2 BẢNG
/** ALTER TABLE dbo.LaborContract  WITH CHECK ADD  CONSTRAINT FK_LaborContract_Employee FOREIGN KEY(ID_Employee)
REFERENCES dbo.Employee
GO
ALTER TABLE dbo.LaborContract CHECK CONSTRAINT FK_LaborContract_Employee
GO **/

--------------------------------------------------------------------------

--> QUẢN LÝ

-- Chèn dữ liệu Admin - Tài khoản
INSERT INTO Admin (Username,Password,FullName,Access) VALUES ('hieudtph04388@fpt.edu.vn','hbs123','Do Trung Hieu',1);

-- Chèn dữ liệu Departments - Phòng ban
INSERT INTO Departments (ID,NameDepartment) VALUES ('PB1',N'Phòng IT');
INSERT INTO Departments (ID,NameDepartment) VALUES ('PB2',N'Phòng Kế Toán');
INSERT INTO Departments (ID,NameDepartment) VALUES ('PB3',N'Phòng Nhân Sự');
INSERT INTO Departments (ID,NameDepartment) VALUES ('PB4',N'Phòng Marketting');

-- Chèn dữ liệu EmployeeTypes - Loại nhân viên
INSERT INTO EmployeeTypes (ID,NameEmployeeType) VALUES ('LNV1','FullTime');
INSERT INTO EmployeeTypes (ID,NameEmployeeType) VALUES ('LNV2','PartTime');

-- Chèn dữ liệu Employees - Nhân Viên
INSERT INTO Employees (ID,DepartmentID,EmployeeTypeID,Email,Password,NameEmployee,Gender,Photo,Address,NumberPhone,Birthday, Access,Activated) 
VALUES ('hieuboyfc','PB1','LNV1','hieuboyfc@gmail.com','hbs123',N'Do Trung Hieu',1,'NV001.PNG',N'Hai Phong','01213321897',CAST(0x00008AB400000000 AS DateTime),1,1)

INSERT INTO Employees (ID,DepartmentID,EmployeeTypeID,Email,Password,NameEmployee,Gender,Photo,Address,NumberPhone,Birthday, Access, Activated)
VALUES ('vip.hieuboy','PB2','LNV2','vip.hieuboy@gmail.com','hbs123',N'Hieu Boy',2,'NV002.jpg',N'Hai Phong','01213321897',CAST(0x00008AB400000000 AS DateTime),1,1)

-- Chèn dữ liệu Contract - Hợp Đồng
INSERT INTO Contracts (ID,NameContract,StartTime,EndTime,Subsidize,Insurrance,Salary,Status)
VALUES ('hieuboyfc','HD Khong Xac Dinh Thoi Han',CAST(0x0000A8CE00000000 AS DateTime),CAST(0x0000B9ED00000000 AS DateTime),500000,0.08,5000000,1)

INSERT INTO Contracts (ID,NameContract,StartTime,EndTime,Subsidize,Insurrance,Salary,Status)
VALUES ('vip.hieuboy','HD Xac Dinh Thoi Han',CAST(0x0000A8CE00000000 AS DateTime),CAST(0x0000B9ED00000000 AS DateTime),500000,0.18,5000000,1)

--------------------------------------------------------------------------

--> BÁN HÀNG

-- Chèn dữ liệu Categories - Danh Mục
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Điện Thoại','Phone')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Máy Tính','Computer')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Máy Ảnh','Camera')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Vô Tuyến','Television')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Đồng Hồ Thông Minh','Smart Watch')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Nhẫn Đeo Tay','Ring')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Mũ Nón','Hat')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Vali','Suitcase')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Nước Hoa','Perfume')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Quạt','Fan')
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Xe Máy','Motorbike')


-- Chèn dữ liệu Producer - Hãng Sản Xuất
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Apple','Apple.png',N'Hoa Kỳ', 'apple@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Samsung','Samsung.jpg',N'Hàn Quốc', 'samsung@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('OPPO','Oppo.jpg',N'Hàn Quốc', 'oppo@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Nokia','Nokia.jpg',N'Hàn Quốc', 'nokia@gmail.com','113')
--
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Dell','Dell.png',N'Hoa Kỳ', 'dell@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Acer','Acer.png',N'Nhật Bản', 'acer@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Asus','Asus.png',N'Đài Loan', 'asus@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Msi','Msi.jpg',N'Nhật Bản', 'msi@gmail.com','113')
--
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Canon','Canon.png',N'Nhật Bản', 'canon@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Sony ','Sony.jpg',N'Hoa Kỳ', 'sony@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Nikon  ','Nikon.png',N'Nhật Bản', 'nikon@gmail.com','113')
--


-- Chèn dữ liệu Products - Sản Phẩm

-- MÁY TÍNH --

--Macbook--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Macbook Pro 15 inch Touch Bar 512GB','MT001.jpg',10, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 69990000,0,NULL,0,1,0,0,1,2,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Macbook Pro 13 Touch Bar 512GB','MT002.jpg',9, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 47999000,0,NULL,0,0,1,0,1,2,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Macbook 12 256GB (2017)','MT003.jpg',13, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 33990000,0,NULL,0,0,0,1,1,2,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Macbook Air 13 256GB MQD42SA/A ','MT004.jpg',25, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 28990000,0.03,NULL,0,1,0,0,1,2,1)

--Asus--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Asus TUF FX504GD-E4571T/i5-8300H','MT005.jpg',10, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 21000000,0,NULL,0,1,0,0,1,2,7)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'ASUS ROG FX503VD-E4119T/i7-7700HQ ','MT006.jpg',5, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 24500000,0,NULL,0,0,1,0,1,2,7)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Asus UX430UA-GV261T','MT007.jpg',12, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 21300000,0,NULL,0,0,0,1,1,2,7)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Asus GL503VM - GZ219T','MT008.jpg',8, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 32490000,0.05,NULL,0,0,0,1,1,2,7)

--Dell--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Dell XPS 15 9560','MT009.jpg',3, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 53990000,0,NULL,0,0,0,1,1,2,5)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Dell Ins N7370/Core i7-8550U','MT010.jpg',5, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 53990000,0,NULL,0,0,1,0,1,2,5)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Dell N7567E','MT011.jpg',2, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 34490000,0,NULL,0,0,0,0,1,2,5)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Dell Ins N7370/i5-8250U','MT012.jpg',2, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 25990000,0.08,NULL,0,0,1,0,1,2,5)

--MSI--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'MSI GE62 6QD-1297XVN','MT013.jpg',7, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 28900000,0,NULL,0,0,0,1,1,2,8)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'MSI GP62M 7REX-1884XVN/i7-7700HQ ','MT014.jpg',12, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 28000000,0,NULL,0,0,1,0,1,2,8)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'MSI GL72M 7REX - 1427XVN','MT015.jpg',6, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 25990000,0,NULL,0,0,0,0,1,2,8)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'MSI GP62 6QE-1221XVN','MT016.jpg',2, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 21890000,0,NULL,0.10,1,0,0,1,2,8)

-- ĐIỆN THOẠI

--Apple--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'iPhone X 256GB','DT001.jpg',10, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 34790000,0,NULL,0,1,0,0,1,1,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'iPhone 7 Plus 32GB','DT002.jpg',23, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 19999000,0,NULL,0,0,1,0,1,1,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'iPhone 8 256GB','DT003.jpg',18, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 34790000,0,NULL,0,0,0,1,1,1,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'iPhone 6s Plus 32GB','DT004.jpg',14, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 13990000,0.10,NULL,0,0,1,0,1,1,1)

--Samsung--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Samsung Galaxy S9 +','DT005.jpg',30, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 24990000,0,NULL,0,1,0,0,1,1,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Samsung Galaxy Note 8','DT006.jpg',15, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 22499000,0,NULL,0,0,1,0,1,1,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Samsung Galaxy A8+ (2018)','DT007.jpg',17, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 13490000,0,NULL,0,0,0,1,1,1,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Samsung Galaxy J7+','DT008.jpg',14, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 7290000,0.08,NULL,0,0,1,0,1,1,2)


--OPPO--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'OPPO F7 128GB','DT009.jpg',11, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 9990000,0,NULL,0,1,0,0,1,1,3)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'SOPPO F5 6GB','DT010.jpg',12, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 8990000,0,NULL,0,0,1,0,1,1,3)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'OPPO F5 Youth','DT011.jpg',7,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 6190000,0,NULL,0,0,0,1,1,1,3)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'OPPO F1s 2017 (64GB)','DT012.jpg',14,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 4990000,0.05,NULL,0,1,1,0,1,1,3)


--Nokia--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nokia 8','DT013.jpg',9,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 12990000,0,NULL,0,1,0,0,1,1,4)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nokia 6','DT014.jpg',6,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 5590000,0,NULL,0,0,1,0,1,1,4)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nokia 5','DT015.jpg',17,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 4259000,0,NULL,0,0,0,1,1,1,4)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nokia 3','DT016.jpg',11,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 2990000,0.03,NULL,0,1,0,1,1,1,4)

-- MÁY ẢNH

--Canon--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Canon EOS 3000D + Lens EF-S','MA001.jpg',14,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 9600000,0,NULL,0,1,0,0,1,3,9)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Canon EOS M50 + Kit 15-45mm (24.1MP)','MA002.jpg',5,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 19000000,0,NULL,0,0,1,0,1,3,9)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Canon 750D + Lens 18-55 IS STM','MA003.jpg',18,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 12890000,0,NULL,0,0,0,1,1,3,9)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Canon Powershot G7X Mark II','MA004.jpg',3,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 15190000,0.03,NULL,0,0,1,0,1,3,9)

--Nikon--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nikon D7200 Kit 18-140mm','MA005.jpg',7,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 25000000,0,NULL,0,1,0,0,1,3,11)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nikon D5300 KIT 18-55 VR','MA006.jpg',6,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 12390000,0,NULL,0,0,1,0,1,3,11)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nikon D610','MA007.jpg',18,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 12890000,0,NULL,0,0,0,1,1,3,11)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nikon D5600 KIT AF-P 18-55 VR','MA008.jpg',3,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 14990000,0.08,NULL,0,0,1,0,1,3,11)


--Sony--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Sony Alpha A7 Mark II','MA009.jpg',9,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 31990000,0,NULL,0,1,0,0,1,3,10)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Sony Cyber-Shot DSC-RX10 III','MA010.jpg',13,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 27990000,0,NULL,0,0,1,0,1,3,10)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Sony Alpha A7R MARK III Body','MA011.jpg',18,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 72990000,0,NULL,0,0,0,1,1,3,10)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Sony Alpha A6000 + 16-50mm','MA012.jpg',21,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 13490000,0.05,NULL,0,1,0,0,1,3,10)

-- TIVI

--Samsung--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Smart TV 4K Samsung QLED 75 inch','TV001.jpg',5,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 113000000,0,NULL,0,1,0,0,1,4,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Smart Tivi Samsung 75 inch UHD','TV002.jpg',7,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 63990000,0,NULL,0,0,1,0,1,4,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Smart TV Cong 4K Samsung QLED','TV003.jpg',4,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 61990000,0,NULL,0,0,0,1,1,4,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Smart TV 4K Samsung QLED 65 inch','TV004.jpg',3,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 55900000,0.03,NULL,0,0,1,0,1,4,2)


--Sony--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Smart Tivi Sony 55 inch 4K','TV005.jpg',9,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 24290000,0,NULL,0,1,0,0,1,4,10)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Smart Tivi Sony 49 inch 4K','TV006.jpg',3,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 251990000,0,NULL,0,0,1,0,1,4,10)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Smart Tivi Sony 65 inch 4K HDR','TV007.jpg',7,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 54099000,0,NULL,0,0,0,1,1,4,10)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Smart Tivi Sony 75 inch 4K','TV008.jpg',6,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 63990000,0.05,NULL,0,0,1,0,1,4,10)

--


-- Chèn dữ liệu Customers - Khách Hàng
INSERT INTO Customers (ID,Email,Password,FullName,Photo,Address,NumberPhone,Birthday,Gender,Activated) 
VALUES ('hieuboyfc','hieuboyfc@gmail.com','hbs123',N'Do Trung Hieu','KH001.jpg',N'Hai Phong','01213321897',CAST(0x00008AB400000000 AS DateTime),1,1)

INSERT INTO Customers (ID,Email,Password,FullName,Photo,Address,NumberPhone,Birthday,Gender,Activated) 
VALUES ('vip.hieuboy','vip.hieuboy@gmail.com','hbs123',N'Hieu Boy','KH002.jpg',N'Hai Phong','01213321897',CAST(0x00008AB400000000 AS DateTime),1,1)

-- Chèn dữ liệu vào Đơn Hàng
INSERT INTO Orders (OrderDate,RequireDate,Amount,Receiver,Address,Description,NumberPhone,Status,CustomerID) 
VALUES (CAST(0x0000A8D200000000 AS DateTime),CAST(0x0000A8D700000000 AS DateTime),127970000,'Do Trung Hieu','Hai Phong',NULL,'01213321897',1,'hieuboyfc')

INSERT INTO Orders (OrderDate,RequireDate,Amount,Receiver,Address,Description,NumberPhone,Status,CustomerID) 
VALUES (CAST(0x0000A8D200000000 AS DateTime),CAST(0x0000A8D700000000 AS DateTime),85980000,'Do Trung Hieu','Hai Phong',NULL,'01213321897',2,'hieuboyfc')

INSERT INTO Orders (OrderDate,RequireDate,Amount,Receiver,Address,Description,NumberPhone,Status,CustomerID) 
VALUES (CAST(0x0000A8D200000000 AS DateTime),CAST(0x0000A8D700000000 AS DateTime),105970000,'Do Trung Hieu','Hai Phong',NULL,'01213321897',3,'hieuboyfc')

INSERT INTO Orders (OrderDate,RequireDate,Amount,Receiver,Address,Description,NumberPhone,Status,CustomerID) 
VALUES (CAST(0x0000A8D200000000 AS DateTime),CAST(0x0000A8D700000000 AS DateTime),72680000,'Hieu Boy','Hai Phong',NULL,'01213321897',1,'vip.hieuboy')

INSERT INTO Orders (OrderDate,RequireDate,Amount,Receiver,Address,Description,NumberPhone,Status,CustomerID) 
VALUES (CAST(0x0000A8D200000000 AS DateTime),CAST(0x0000A8D700000000 AS DateTime),62680000,'Hieu Boy','Hai Phong',NULL,'01213321897',2,'vip.hieuboy')

INSERT INTO Orders (OrderDate,RequireDate,Amount,Receiver,Address,Description,NumberPhone,Status,CustomerID) 
VALUES (CAST(0x0000A8D200000000 AS DateTime),CAST(0x0000A8D700000000 AS DateTime),39570000,'Hieu Boy','Hai Phong',NULL,'01213321897',3,'vip.hieuboy')

-- Chèn dữ liệu vào Đơn Hàng Chi Tiết
INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (1,1,1,69990000,0)
INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (1,4,2,57980000,0.03)

INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (2,5,1,21000000,0)
INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (2,8,2,64980000,0.05)

INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (3,9,1,53990000,0)
INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (3,12,2,51980000,0.08)
	

INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (4,13,1,28900000,0)
INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (4,16,2,43780000,0.10)

INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (5,17,1,34790000,0)
INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (5,20,2,27890000,0.10)

INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (6,21,1,24990000,0)
INSERT INTO OrderDetails (OrderID,ProductID,Quantity,Amount,Discount) VALUES (6,24,2,14580000,0.08)


select * from sys.dm_tcp_listener_states 