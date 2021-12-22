USE master
GO

IF(EXISTS(SELECT * FROM SYSDATABASES WHERE NAME = 'ElectronicDeviceShopDB'))
	DROP DATABASE ElectronicDeviceShopDB
GO

CREATE DATABASE ElectronicDeviceShopDB
GO

USE ElectronicDeviceShopDB
GO

CREATE TABLE Categories
(
	ID_Category INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(255) NOT NULL,
	UrlSlug NVARCHAR(255),
	Icon NVARCHAR(255) NOT NULL,
	[Status] INT DEFAULT 1,
) 
GO

CREATE TABLE Suppliers
(
	ID_Supplier INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(255) NOT NULL,
	UrlSlug NVARCHAR(255),
	Icon NVARCHAR(255) NOT NULL,
	[Status] INT DEFAULT 1,
) 
GO


CREATE TABLE Products
(
	ID_Product INT IDENTITY PRIMARY KEY,
	ID_Category INT NOT NULL,
	ID_Supplier INT NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	UrlSlug NVARCHAR(255),
	Price Money NOT NULL,
	Model NVARCHAR(255) NOT NULL,
	Amount INT NOT NULL,
	Guarantee INT NOT NULL,
	Origin NVARCHAR(255) NULL,
	Discount INT NULL,
	ShortDescription NTEXT NULL,
	Detail NTEXT NULL,
	[Image] NVARCHAR(255) NOT NULL,
	[Status] INT DEFAULT 1,	
	CONSTRAINT FK_Products_Categories FOREIGN KEY (ID_Category) REFERENCES Categories(ID_Category),
	CONSTRAINT FK_Products_Suppliers FOREIGN KEY (ID_Supplier) REFERENCES Suppliers(ID_Supplier)
) 
GO

CREATE TABLE Accounts
(
	ID_Account INT IDENTITY PRIMARY KEY,
	UserName Varchar(255) UNIQUE NOT NULL,
	[Password] Varchar(255) NOT NULL,
	FullName NVARCHAR(255) NULL,
	Phone Char(20) NULL,
	[Address] NVARCHAR(255) NULL,
	Email Varchar(50) NULL,
	Avatar NVARCHAR(255) NULL,
	[Role] INT DEFAULT 2,--0:AD,1:NV,2:KH
	[Status] INT DEFAULT 1,
) 
GO

CREATE TABLE Carts
(
	ID_Cart INT IDENTITY PRIMARY KEY,  
	ID_Product INT NOT NULL,
	ID_Account INT NOT NULL,
	Amount INT NOT NULL,
	[Status] INT DEFAULT 1,
	CONSTRAINT FK_Carts_Products FOREIGN KEY (ID_Product) REFERENCES Products(ID_Product),
	CONSTRAINT FK_Carts_Accounts FOREIGN KEY (ID_Account) REFERENCES Accounts(ID_Account)

) 
GO

CREATE TABLE Bills
(
	ID_Bill INT IDENTITY PRIMARY KEY,
	ID_Account INT NOT NULL,
	ReceiverName NVARCHAR(50) NOT NULL,
	ReceiverAddress NVARCHAR(255) NOT NULL,
	ReceiverEmail Varchar(255) NOT NULL,
	ReceiverPhone Char(20) NOT NULL,
	Note NTEXT NULL,
	PayType NVARCHAR(255) NOT NULL,
	BuyDate DATE NOT NULL,
	[Status] INT DEFAULT 2,
	CONSTRAINT FK_Bills_Accounts FOREIGN KEY (ID_Account) REFERENCES Accounts(ID_Account)
)
GO

CREATE TABLE BillDetails
(
	ID_Billdetail INT IDENTITY PRIMARY KEY,
	ID_Bill INT NOT NULL,
	ID_Product INT NOT NULL,
	Amount INT NOT NULL,
	CurrentlyPrice Money NOT NULL,
	[Status] INT DEFAULT 1,
	CONSTRAINT FK_BillDetails_Product FOREIGN KEY (ID_Product) REFERENCES Products(ID_Product),
	CONSTRAINT FK_BillDetails_Bill FOREIGN KEY (ID_Bill) REFERENCES Bills(ID_Bill)
) 
GO

CREATE TABLE [Permissions]
(
	ID_Permission INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(255) NOT NULL,
	Code VARCHAR(255),
	[Status] INT DEFAULT 1,
) 
GO

CREATE TABLE PermissionDetails
(
	ID_PermissionDetail INT IDENTITY PRIMARY KEY,
	ID_Permission INT NOT NULL,
	ID_Account INT NOT NULL,
	[View] BIT NULL,
	[Create] BIT NULL,
	Edit BIT NULL,
	[Delete] BIT NULL,
	[Status] INT DEFAULT 1,
	CONSTRAINT FK_PermissionDetail_Account FOREIGN KEY (ID_Account) REFERENCES Accounts(ID_Account),
	CONSTRAINT FK_PermissionDetail_Permission FOREIGN KEY (ID_Permission) REFERENCES [Permissions](ID_Permission),
) 
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([ID_Category], [Name], [UrlSlug], [Icon], [Status]) VALUES (1, N'Bình tắm nóng lạnh', N'binh-tam-nong-lanh', N'icon-binh-tam-nong-lanh.png', 1)
INSERT [dbo].[Categories] ([ID_Category], [Name], [UrlSlug], [Icon], [Status]) VALUES (2, N'Điều hòa nhiệt độ', N'dieu-hoa-nhiet-do', N'icon-dieu-hoa.png', 1)
INSERT [dbo].[Categories] ([ID_Category], [Name], [UrlSlug], [Icon], [Status]) VALUES (3, N'Nồi chiên không dầu', N'noi-chien-khong-dau', N'icon-noi-chien.png', 1)
INSERT [dbo].[Categories] ([ID_Category], [Name], [UrlSlug], [Icon], [Status]) VALUES (4, N'Tivi, Loa - Âm thanh', N'tivi-loa-am-thanh', N'icon-tivi-loa-am-thanh.png', 1)
INSERT [dbo].[Categories] ([ID_Category], [Name], [UrlSlug], [Icon], [Status]) VALUES (5, N'Tủ lạnh, Tủ đông, Tủ mát', N'tu-lanh-tu-dong-tu-mat', N'icon-tu-lanh-tu-dong-tu-mat.png', 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([ID_Supplier], [Name], [UrlSlug], [Icon], [Status]) VALUES (1, N'Ariston', N'ariston', N'ariston-7QeHYs.png', 1)
INSERT [dbo].[Suppliers] ([ID_Supplier], [Name], [UrlSlug], [Icon], [Status]) VALUES (2, N'Kangharoo', N'kangharoo', N'kangaroo-DxE1BV.png', 1)
INSERT [dbo].[Suppliers] ([ID_Supplier], [Name], [UrlSlug], [Icon], [Status]) VALUES (3, N'SamSung', N'samsung', N'samsung-2XG2f2.png', 1)
INSERT [dbo].[Suppliers] ([ID_Supplier], [Name], [UrlSlug], [Icon], [Status]) VALUES (4, N'LG', N'lg', N'lg-OI70q3.png', 1)
INSERT [dbo].[Suppliers] ([ID_Supplier], [Name], [UrlSlug], [Icon], [Status]) VALUES (5, N'Coex', N'coex', N'coex-5u7kJo.png', 1)
INSERT [dbo].[Suppliers] ([ID_Supplier], [Name], [UrlSlug], [Icon], [Status]) VALUES (6, N'Philips', N'philips', N'philips-3w2Q5U.png', 1)
INSERT [dbo].[Suppliers] ([ID_Supplier], [Name], [UrlSlug], [Icon], [Status]) VALUES (7, N'Sanaky', N'sanaky', N'sanaky-49X4N8.png', 1)
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (1, 1, 1, N'Bình nóng lạnh gián tiếp Ariston AN2 30RS 2.5 FE-MT 30 lít', N'binh-nong-lanh-gian-tiep-ariston-an2-30rs-25-fe-mt-30-lit', 3990000.0000, N'AN2 30RS 2.5 FE-MT', 10, 12, N'Việt Nam', 10, N'Bình nóng lạnh gián tiếp Ariston AN2 30RS 2.5 FE-MT 30 lít', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'-WH1UeP.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (2, 1, 1, N'Bình nóng lạnh 20L Ariston SL2 20R', N'binh-nong-lanh-20l-ariston-sl2-20r', 4440000.0000, N'SL2 20R', 20, 12, N'Malaysia', 12, N'Bình nóng lạnh gián tiếp, Dung tích: 20 lít Kích thước: 704 x 301 x 282 mm ( DxRxC) Nhiệt độ tối đa: 80 độ, Bình chứa tráng men Titan, Hệ thống an toàn đồng bộ tích hợp ELCB chống giật Lớp cách nhiệt mật độ cao, Tiết kiệm điện năng chuẩn 5 sao Vỏ chống thấm nước', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'-P2HwZg.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (3, 1, 1, N'Bình nóng lạnh 30L Ariston AN2 30R 2.5 FE-MT', N'binh-nong-lanh-30l-ariston-an2-30r-25-fe-mt', 4700000.0000, N'AN2 30R 2.5 FE-MT', 30, 12, N'Malaysia', 25, N'Bình nóng lạnh gián tiếp Dung tích 30L, Công suất 2500W Làm nóng hiệu quả, An toàn: Chống giật ELCB Thanh đốt đồng cho độ bền vượt trội Hiển thị nhiệt độ an toàn khuyên dùng', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'-ZZFkGo.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (4, 1, 1, N'Bình nóng lạnh gián tiếp Ariston 20L SL2 20 RS', N'binh-nong-lanh-gian-tiep-ariston-20l-sl2-20-rs', 4600000.0000, N'SL2 20 RS', 50, 12, N'Malaysia', 15, N'Thanh đốt 100% đồng chất lượng cao Bình chứa tráng men Titan Rơ le nhiệt cơ TBST  Khuyến cáo nhiệt độ an toàn Hệ thống an toàn đồng bộ TSS', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'-cItkGg.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (5, 1, 1, N'Bình nóng lạnh trực tiếp Ariston SM45PE-VN - 4500W', N'binh-nong-lanh-truc-tiep-ariston-sm45pe-vn-4500w', 2990000.0000, N'SM45PE-VN', 60, 12, N'Malaysia', 0, N'Thiết kế chống thấm nước, Bộ ổn định nhiệt lưỡng cực Hệ thống điều chỉnh lưu lượng nước,Vòi sen 3 chức năng Van cấp nước tích hợp 3 trong 1 (Khóa – Lọc – Mở)', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'binh-nong-lanh-truc-tiep-ariston-sm45pevn-4500wco-bom-44a9Xv.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (6, 1, 1, N'Bình nóng lạnh gián tiếp Ariston AN2 15R 2.5 FE-MT 15 Lít', N'binh-nong-lanh-gian-tiep-ariston-an2-15r-25-fe-mt-15-lit', 4450000.0000, N'AN2 15R 2.5 FE-MT', 25, 6, N'Malaysia', 18, N'Thanh đốt đồng cho độ bền vượt trội Hiển thị nhiệt độ an toàn khuyên dùng', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'-nu458B.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (7, 1, 1, N'Bình nóng lạnh 50L Ariston Pro R 50 SH 2.5 FE- Bình ngang', N'binh-nong-lanh-50l-ariston-pro-r-50-sh-25-fe-binh-ngang', 5240000.0000, N'Pro R 50 SH 2.5 FE', 24, 24, N'Malaysia', 0, N'Dung tích: 50L, Công suất: 2500W Hệ thống an toàn đồng bộ TSS Bộ ổn nhiệt kiểm soát nhiệt độ hiệu quả', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'binh-nong-lanh-50l-ariston-pro-r-50-sh-25-fe-binh-ngang-39WSh0.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (8, 1, 2, N'Bình nước nóng 22L Kangaroo KG68A2', N'binh-nuoc-nong-22l-kangaroo-kg68a2', 2990000.0000, N'KG68A2', 111, 12, N'Việt Nam', 0, N'Bình nóng lạnh gián tiếp 22L, Công nghệ Nano kháng khuẩn Hệ thống an toàn đồng bộ CSS, Lớp cách nhiệt pu mật độ cao Chống giật kép, Chống đun khô, Tiết kiệm điện năng ', N'<h3><strong>Dung t&iacute;ch 22L</strong></h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nuoc-nong-22l-kangaroo-kg68a2.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh Kangaroo KG68A2</a>&nbsp;c&oacute;&nbsp;dung t&iacute;ch 22L, đ&aacute;p ứng tốt nhu cầu sử dụng của c&aacute;c&nbsp;hộ gia đ&igrave;nh&nbsp;từ đ&ocirc;ng th&agrave;nh vi&ecirc;n từ 4-5 người rất tiện dụng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(47).jpg" /></p>

<h3><strong>Thiết kế đẹp mắt</strong></h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/?&amp;loc=gian-tiep" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh gi&aacute;n tiếp</a>&nbsp;với&nbsp;thiết kế sang trọng tinh tế với b&igrave;nh ngang v&agrave;ng, chắc chắn sẽ đem lại sự sang trọng cho nội thất nh&agrave; bạn. Ruột&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh n&oacute;ng lạnh</a>&nbsp;tr&aacute;ng kim cương nh&acirc;n tạo, duy nhất tr&ecirc;n thị trường c&oacute;, mang đến độ bền cao cho sản phẩm.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(109).jpg" /></p>

<h3><strong>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</strong></h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/" target="_blank">B&igrave;nh n&oacute;ng lạnh Kangaroo</a>&nbsp;c&oacute; sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.<br />
&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2017-12/bnl-TffWid.jpg" /></p>

<h3><strong>M&agrave;n h&igrave;nh LED hiển thị</strong></h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/?&amp;p=tren-5000000&amp;loc=20l-30l" target="_blank">B&igrave;nh tắm&nbsp;n&oacute;ng lạnh dung t&iacute;ch 22L</a>&nbsp;c&oacute; trang bị m&agrave;n h&igrave;nh LED điện tử hiển thị độ n&oacute;ng gi&uacute;p bạn dễ d&agrave;ng quan s&aacute;t, tăng phần an to&agrave;n cho người sử dụng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2017-12/bnl-7c9Bt9.jpg" /></p>

<h3><strong>C&oacute; điều chỉnh nhiệt độ</strong></h3>

<p>Chức năng điều chỉnh dạng xoay vặn đặt b&ecirc;n cạnh phải b&igrave;nh, dễ d&agrave;ng thao t&aacute;c, chủ động lựa chọn mức nhiệt ph&ugrave; hợp.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/kid-shampoo-1493004448584(2).jpg" /></p>

<h3><strong>An to&agrave;n&nbsp;tuyệt đối</strong></h3>

<p>Kangaroo KG69A2N&nbsp;c&oacute; hệ thống an to&agrave;n đồng bộ CSS , lớp c&aacute;ch nhiệt pu mật độ cao, chống giật k&eacute;p, chống đun kh&ocirc; an to&agrave;n tuyệt đối với c&aacute;c th&agrave;nh vi&ecirc;n gia đ&igrave;nh bạn..</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/6(44).jpg" /></p>
', N'binh-nuoc-nong-22l-kangaroo-kg68a2-XkMpfg.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (9, 1, 2, N'Bình nóng lạnh 15L Kangaroo KG516N', N'binh-nong-lanh-15l-kangaroo-kg516n', 3510000.0000, N'KG516N', 123, 18, N'Việt Nam', 20, N'Bình nóng lạnh gián tiếp 15L Chống giật kép, Chống đun khô Công nghệ Nano kháng khuẩn, Hệ thống an toàn đồng bộ CSS Lớp cách nhiệt pu mật độ caoTiết kiệm điện năng, Cài đặt nhiệt độ', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'-1eEOdS.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (10, 1, 2, N'Bình nóng lạnh 30L Kangaroo KG69A3', N'binh-nong-lanh-30l-kangaroo-kg69a3', 2960000.0000, N'KG69A3', 121, 6, N'Việt Nam', 0, N'Bình nóng lạnh gián tiếp 30L Chống giật kép, Chống đun khô Công nghệ Nano kháng khuẩn, Hệ thống an toàn đồng bộ CSS Lớp cách nhiệt pu mật độ cao', N'<p>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N c&oacute; dung t&iacute;ch 30 l&iacute;t, c&oacute; thể phục vụ cho c&aacute;c hộ gia đ&igrave;nh đ&ocirc;ng người sử dụng. B&igrave;nh c&oacute; h&igrave;nh chữ nhật, k&iacute;ch thước nhỏ gọn, lắp đặt dễ d&agrave;ng tiện lợi,m&agrave;u trắng kết hợp c&ugrave;ng n&acirc;u sang trọng. Ngo&agrave;i ra b&igrave;nh tắm n&oacute;ng lạnh KG69A3N c&ograve;n được t&iacute;ch hợp c&ocirc;ng nghệ kh&aacute;ng khuẩn, diệt trừ vi khuẩn, cặn, gỉ c&oacute; hại cho da.</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/kg69a3n.png" /><br />
Dung t&iacute;ch 30 L&iacute;t ph&ugrave; hợp cho nhiều gia đ&igrave;nh</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>B&igrave;nh nước n&oacute;ng Kangaroo KG69A3N</strong></a>&nbsp;c&oacute; dung t&iacute;ch 30 l&iacute;t đảm bảo cung cấp đủ nước n&oacute;ng phục vụ cho gia đ&igrave;nh c&oacute; từ 3 th&agrave;nh vi&ecirc;n trở l&ecirc;n.&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">B&igrave;nh tắm n&oacute;ng lạnh</a>&nbsp;c&oacute; thiết kế đẹp mắt, kiểu d&aacute;ng hiện đại v&agrave; nhỏ gọn ph&ugrave; hợp với nhiều kh&ocirc;ng gian diện t&iacute;ch ph&ograve;ng tắm kh&aacute;c nhau.</p>

<h3>L&agrave;m n&oacute;ng nước nhanh ch&oacute;ng</h3>

<p>Kangaroo KG69A3N&nbsp;c&oacute; c&ocirc;ng suất hoạt động l&ecirc;n tới 2500W cũng gi&uacute;p đem đến hiệu quả l&agrave;m n&oacute;ng nước trong thời gian ngắn, kh&ocirc;ng tốn nhiều thời gian chờ đợi nước n&oacute;ng.</p>

<h3>An to&agrave;n tuyệt đối khi sử dụng</h3>

<p>B&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>&nbsp;l&agrave; loại&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/" target="_blank">b&igrave;nh nước n&oacute;ng</a>&nbsp;gi&aacute;n tiếp được trang bị lớp c&aacute;ch nhiệt PU mật độ cao ngăn chặn sự cố r&ograve; rỉ điện đảm bảo an to&agrave;n cho người sử dụng. Ngo&agrave;i ra, b&igrave;nh nước n&oacute;ng Kangaroo c&ograve;n được trang bị hệ thống an to&agrave;n đồng bộ CSS v&agrave; hệ thống chống giật k&eacute;p gi&uacute;p người d&ugrave;ng c&oacute; thể an t&acirc;m sử dụng b&igrave;nh nước n&oacute;ng cho cả gia đ&igrave;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/HERV1t0R7e007Na.jpg" /></p>

<h3>C&ocirc;ng nghệ Nano kh&aacute;ng khuẩn</h3>

<p><a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank">B&igrave;nh tắm n&oacute;ng lanh Kangaroo KG69A3N</a>&nbsp;sử dụng c&ocirc;ng nghệ Nano kh&aacute;ng khuẩn, cung cấp&nbsp;nguồn nước sạch, đảm bảo an to&agrave;n cho sức khỏe ngươi sử dụng.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2019-12-News/Ovxa6SZ0nt6v7o4.jpg" /></strong></p>

<h3>Tiết kiệm điện năng</h3>

<p>Với b&igrave;nh nước n&oacute;ng&nbsp;<a href="https://mediamart.vn/binh-tam-nong-lanh/kangaroo/binh-nong-lanh-30l-kangaroo-kg69a3n.htm" target="_blank"><strong>Kangaroo KG69A3N</strong></a>, người sử dụng chỉ cần l&agrave;m n&oacute;ng nước 1 lần l&agrave; c&oacute; thể sử dụng được nhiều lần trong v&ograve;ng 24h sau khi bật b&igrave;nh m&agrave; kh&ocirc;ng phải bật l&agrave;m n&oacute;ng lại n&ecirc;n gi&uacute;p tiết kiệm tối đa điện năng ti&ecirc;u thụ cho người d&ugrave;ng.</p>

<h3>Th&ocirc;ng số kỹ thuật B&igrave;nh n&oacute;ng lạnh Kangaroo&nbsp;KG69A3N</h3>

<p>- Điện &aacute;p: 220V / 50Hz<br />
- Dung t&iacute;ch: 30 L&iacute;t<br />
- Khối lượng: 13 Kg<br />
- K&iacute;ch thước:&nbsp;710x330x350&nbsp;(mm)<br />
- C&ocirc;ng suất: 2.500W<br />
&nbsp;<br />
<strong>Hướng dẫn sử dụng:</strong><br />
&nbsp;<br />
Sử dụng nước n&oacute;ng: Khi sử dụng nước n&oacute;ng trước ti&ecirc;n mở v&ograve;i b&ecirc;n lạnh, sau đ&oacute; từ từ xoay sang b&ecirc;n nước n&oacute;ng để tạo hỗn hợp nước lạnh v&agrave; n&oacute;ng điều chỉnh nhiệt độ ph&ugrave; hợp rồi sử dụng. Khi kh&ocirc;ng sử dụng nữa kh&oacute;a v&ograve;i nước n&oacute;ng trước rồi đến v&ograve;i nước lạnh sau.<br />
<br />
<strong>Ch&uacute; &yacute; :</strong><br />
Trước mỗi lần sử dụng n&ecirc;n d&ugrave;ng tay kiểm tra nhiệt độ nước trước khi sử dụng, kh&ocirc;ng hướng v&ograve;i nước n&oacute;ng trực tiếp v&agrave;o người tr&agrave;nh bị bỏng.<br />
<br />
<strong>Quy tr&igrave;nh sửa chữa bảo dưỡng :</strong><br />
&nbsp;<br />
+&nbsp;Phải ngắt nguồn nước trước khi bảo dưỡng sửa chữa.<br />
<br />
+ Định kỳ l&agrave;m sạch b&igrave;nh đun lấy hết cặn trong b&igrave;nh ra ngo&agrave;i v&igrave; trong nước c&oacute; c&aacute;c tạp chất vi lượng v&agrave; kho&aacute;ng chất n&ecirc;n sử dụng b&igrave;nh nước n&oacute;ng trong thời gian d&agrave;i đ&aacute;y b&igrave;nh sẽ c&oacute; cặn. Th&ocirc;ng thường một năm n&ecirc;n sả cặn một lần. Ở những nơi chất lượng nước k&eacute;m n&ecirc;n r&uacute;t ngắn định kỳ xả cặn.<br />
<br />
+ Phương ph&aacute;p xả cặn: Ngắt nguồn điện, mở n&uacute;t van xả cặn dưới đ&aacute;y b&igrave;nh, mở van nước lạnh chảy v&agrave;o b&igrave;nh, đ&oacute;ng đường nước n&oacute;ng ra, th&aacute;o nắp xả cặn.<br />
<br />
+ Sau khi xả cặn xong vặn chặt n&uacute;t xả cặn v&agrave; sử dụng&nbsp;b&igrave;nh&nbsp;KG69A3N b&igrave;nh thường.</p>
', N'binh-nong-lanh-30l-kangaroo-kg69a3-T2vzZH.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (11, 2, 3, N'Điều hòa Samsung 1 chiều Inverter 12000BTU AR13TYHYCWKNSV', N'dieu-hoa-samsung-1-chieu-inverter-12000btu-ar13tyhycwknsv', 13200000.0000, N'AR13TYHYCWKNSV', 222, 12, N'Thái Lan', 0, N'Công suất: 12000BTU, Công nghệ InverterChế độ Làm Lạnh Tức Thì Fast CoolingBộ lọc Tri-Care Filter lọc sạch hiệu quả bụi siêu mịnChế độ Ngủ Ngon duy trì nhiệt độ lý tưởng', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(821).jpg" /><br />
L&agrave;m lạnh nhanh ch&oacute;ng với chức năng Super cool<br />
Chỉ bằng một n&uacute;t nhấn, bạn sẽ nhanh ch&oacute;ng cảm nhận luồng hơi lạnh phả ra, nhiệt độ ph&ograve;ng li&ecirc;n tục giảm xuống theo &yacute; muốn của bạn chỉ trong thời gian rất ngắn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(714).jpg" /><br />
Chế độ cảm biến nhiệt độ th&ocirc;ng minh Follow me<br />
Remote được t&iacute;ch hợp cảm biến nhiệt độ th&ocirc;ng minh. Chỉ cần đặt remote cạnh bạn, m&aacute;y lạnh sẽ tự động điều chỉnh c&ocirc;ng suất để l&agrave;m lạnh khu vực xung quanh remote, sao cho nhiệt độ khu vực n&agrave;y ch&iacute;nh x&aacute;c nhất với nhiệt độ mong muốn. Tạo cảm gi&aacute;c m&aacute;t lạnh đ&uacute;ng chuẩn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(591).jpg" /><br />
C&agrave;i đặt c&aacute;c chế độ l&agrave;m lạnh ph&ugrave; hợp chỉ với một n&uacute;t nhấn<br />
Mỗi lần c&agrave;i đặt m&aacute;y lạnh bạn lại mất một khoảng thời gian, đ&ocirc;i khi kh&ocirc;ng đ&uacute;ng chế độ m&igrave;nh quen d&ugrave;ng rất bất tiện. Để khắc phục t&igrave;nh trạng n&agrave;y Midea trang bị cho sản phẩm của m&igrave;nh t&iacute;nh năng ghi nhớ chế độ l&agrave;m lạnh y&ecirc;u th&iacute;ch, k&iacute;ch hoạt chỉ bằng 1 n&uacute;t nhấn Fav tr&ecirc;n remote.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(458).jpg" /><br />
Chăm s&oacute;c cơ thể bạn khi ngủ<br />
Chức năng Sweet Dream&nbsp;điều chỉnh nhiệt độ thay đổi ph&ugrave; hợp với nhiệt độ cơ thể bạn từ l&uacute;c bắt đầu ngủ cho đến khi thức dậy. Gi&uacute;p bạn c&oacute; một giấc ngủ s&acirc;u sau một ng&agrave;y l&agrave;m việc mệt mỏi.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(391).jpg" /><br />
Lọc sạch kh&ocirc;ng kh&iacute; v&agrave; khử m&ugrave;i h&ocirc;i tối đa<br />
Lưới lọc HD mật độ cao c&oacute; thể lọc bụi bẩn, m&ugrave;i h&ocirc;i gấp đ&ocirc;i lưới lọc th&ocirc;ng thường, loại bỏ ho&agrave;n to&agrave;n những t&aacute;c nh&acirc;n g&acirc;y hại đến sức khỏe người d&ugrave;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(275).jpg" /><br />
Chức năng Self-cleaning tự động l&agrave;m sạch<br />
D&agrave;n lạnh của chiếc&nbsp;m&aacute;y lạnh Midea&nbsp;n&agrave;y được l&agrave;m sạch tự động nhờ chức năng self-cleaning gi&uacute;p tăng tuổi thọ cho m&aacute;y lạnh, kh&ocirc;ng c&ograve;n t&igrave;nh trạng m&ugrave;i ẩm mốc.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(213).jpg" /><br />
Nh&igrave;n chung, với mức gi&aacute; cực k&igrave; ưu đ&atilde;i&nbsp;m&aacute;y lạnh Midea 1 HP MSMA3-10CRN1 phục vụ tốt nhu cầu sử dụng m&aacute;y lạnh cơ bản của người d&ugrave;ng. M&aacute;y l&agrave;m lạnh nhanh, lọc bụi trong kh&ocirc;ng kh&iacute; tốt. Nhỏ v&agrave; gọn, ph&ugrave; hợp lắp đặt cho ph&ograve;ng ngủ. Nếu chỉ sử dụng m&aacute;y lạnh để ngủ 4 tiếng một ng&agrave;y th&igrave; đ&acirc;y l&agrave; sự lựa chọn th&iacute;ch hợp để tiết kiệm chi ph&iacute;.</p>
', N'dieu-hoa-samsung-1-chieu-inverter-12000btu-ar13tyhycwknsv-T2nNcL.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (12, 2, 3, N'Điều hòa Samsung Wind-Free 1 chiều Inverter 12000BTU AR13TYGCDWKNSV', N'dieu-hoa-samsung-wind-free-1-chieu-inverter-12000btu-ar13tygcdwknsv', 13390000.0000, N'AR13TYGCDWKNSV', 321, 12, N'Thái Lan', 0, N'Công suất: 12000BTU, Công nghệ InverterChế độ Wind-Free Cooling làm lạnh không gió buốtTiện nghi với công nghệ làm lạnh thông minh AIỐng giảm thanh Twin Tube Muffler hạn chế tối đa tiếng ồn', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(821).jpg" /><br />
L&agrave;m lạnh nhanh ch&oacute;ng với chức năng Super cool<br />
Chỉ bằng một n&uacute;t nhấn, bạn sẽ nhanh ch&oacute;ng cảm nhận luồng hơi lạnh phả ra, nhiệt độ ph&ograve;ng li&ecirc;n tục giảm xuống theo &yacute; muốn của bạn chỉ trong thời gian rất ngắn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(714).jpg" /><br />
Chế độ cảm biến nhiệt độ th&ocirc;ng minh Follow me<br />
Remote được t&iacute;ch hợp cảm biến nhiệt độ th&ocirc;ng minh. Chỉ cần đặt remote cạnh bạn, m&aacute;y lạnh sẽ tự động điều chỉnh c&ocirc;ng suất để l&agrave;m lạnh khu vực xung quanh remote, sao cho nhiệt độ khu vực n&agrave;y ch&iacute;nh x&aacute;c nhất với nhiệt độ mong muốn. Tạo cảm gi&aacute;c m&aacute;t lạnh đ&uacute;ng chuẩn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(591).jpg" /><br />
C&agrave;i đặt c&aacute;c chế độ l&agrave;m lạnh ph&ugrave; hợp chỉ với một n&uacute;t nhấn<br />
Mỗi lần c&agrave;i đặt m&aacute;y lạnh bạn lại mất một khoảng thời gian, đ&ocirc;i khi kh&ocirc;ng đ&uacute;ng chế độ m&igrave;nh quen d&ugrave;ng rất bất tiện. Để khắc phục t&igrave;nh trạng n&agrave;y Midea trang bị cho sản phẩm của m&igrave;nh t&iacute;nh năng ghi nhớ chế độ l&agrave;m lạnh y&ecirc;u th&iacute;ch, k&iacute;ch hoạt chỉ bằng 1 n&uacute;t nhấn Fav tr&ecirc;n remote.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(458).jpg" /><br />
Chăm s&oacute;c cơ thể bạn khi ngủ<br />
Chức năng Sweet Dream&nbsp;điều chỉnh nhiệt độ thay đổi ph&ugrave; hợp với nhiệt độ cơ thể bạn từ l&uacute;c bắt đầu ngủ cho đến khi thức dậy. Gi&uacute;p bạn c&oacute; một giấc ngủ s&acirc;u sau một ng&agrave;y l&agrave;m việc mệt mỏi.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(391).jpg" /><br />
Lọc sạch kh&ocirc;ng kh&iacute; v&agrave; khử m&ugrave;i h&ocirc;i tối đa<br />
Lưới lọc HD mật độ cao c&oacute; thể lọc bụi bẩn, m&ugrave;i h&ocirc;i gấp đ&ocirc;i lưới lọc th&ocirc;ng thường, loại bỏ ho&agrave;n to&agrave;n những t&aacute;c nh&acirc;n g&acirc;y hại đến sức khỏe người d&ugrave;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(275).jpg" /><br />
Chức năng Self-cleaning tự động l&agrave;m sạch<br />
D&agrave;n lạnh của chiếc&nbsp;m&aacute;y lạnh Midea&nbsp;n&agrave;y được l&agrave;m sạch tự động nhờ chức năng self-cleaning gi&uacute;p tăng tuổi thọ cho m&aacute;y lạnh, kh&ocirc;ng c&ograve;n t&igrave;nh trạng m&ugrave;i ẩm mốc.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(213).jpg" /><br />
Nh&igrave;n chung, với mức gi&aacute; cực k&igrave; ưu đ&atilde;i&nbsp;m&aacute;y lạnh Midea 1 HP MSMA3-10CRN1 phục vụ tốt nhu cầu sử dụng m&aacute;y lạnh cơ bản của người d&ugrave;ng. M&aacute;y l&agrave;m lạnh nhanh, lọc bụi trong kh&ocirc;ng kh&iacute; tốt. Nhỏ v&agrave; gọn, ph&ugrave; hợp lắp đặt cho ph&ograve;ng ngủ. Nếu chỉ sử dụng m&aacute;y lạnh để ngủ 4 tiếng một ng&agrave;y th&igrave; đ&acirc;y l&agrave; sự lựa chọn th&iacute;ch hợp để tiết kiệm chi ph&iacute;.</p>
', N'dieu-hoa-samsung-windfree-1-chieu-inverter-12000btu-ar13tygcdwknsv-8CN26y.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (13, 2, 3, N'Điều hòa Samsung Wind-Free 1 chiều Inverter 9400BTU AR10TYGCDWKNSV', N'dieu-hoa-samsung-wind-free-1-chieu-inverter-9400btu-ar10tygcdwknsv', 11690000.0000, N'AR10TYGCDWKNSV', 213, 12, N'Thái Lan', 0, N'- Luồng khí lạnh lý tưởng, tiết kiệm điện với công nghệ WindFree với 23.000 lỗ siêu nhỏ giúp tỏa khí lạnh nhanh mà không lo gió buốt.- Công nghệ Kháng khuẩn, lọc bụi mịn và virus 99%, chống nấm mốc hiệu quả cùng bộ lọc TriCare.- Tiết kiệm điện lên đến 77%, làm lạnh nhanh với động cơ Digital Inverter Boots và chế độ Eco.- Làm lạnh hiệu quả, độ bền máy cao với chế độ Auto Clean.', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(821).jpg" /><br />
L&agrave;m lạnh nhanh ch&oacute;ng với chức năng Super cool<br />
Chỉ bằng một n&uacute;t nhấn, bạn sẽ nhanh ch&oacute;ng cảm nhận luồng hơi lạnh phả ra, nhiệt độ ph&ograve;ng li&ecirc;n tục giảm xuống theo &yacute; muốn của bạn chỉ trong thời gian rất ngắn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(714).jpg" /><br />
Chế độ cảm biến nhiệt độ th&ocirc;ng minh Follow me<br />
Remote được t&iacute;ch hợp cảm biến nhiệt độ th&ocirc;ng minh. Chỉ cần đặt remote cạnh bạn, m&aacute;y lạnh sẽ tự động điều chỉnh c&ocirc;ng suất để l&agrave;m lạnh khu vực xung quanh remote, sao cho nhiệt độ khu vực n&agrave;y ch&iacute;nh x&aacute;c nhất với nhiệt độ mong muốn. Tạo cảm gi&aacute;c m&aacute;t lạnh đ&uacute;ng chuẩn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(591).jpg" /><br />
C&agrave;i đặt c&aacute;c chế độ l&agrave;m lạnh ph&ugrave; hợp chỉ với một n&uacute;t nhấn<br />
Mỗi lần c&agrave;i đặt m&aacute;y lạnh bạn lại mất một khoảng thời gian, đ&ocirc;i khi kh&ocirc;ng đ&uacute;ng chế độ m&igrave;nh quen d&ugrave;ng rất bất tiện. Để khắc phục t&igrave;nh trạng n&agrave;y Midea trang bị cho sản phẩm của m&igrave;nh t&iacute;nh năng ghi nhớ chế độ l&agrave;m lạnh y&ecirc;u th&iacute;ch, k&iacute;ch hoạt chỉ bằng 1 n&uacute;t nhấn Fav tr&ecirc;n remote.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(458).jpg" /><br />
Chăm s&oacute;c cơ thể bạn khi ngủ<br />
Chức năng Sweet Dream&nbsp;điều chỉnh nhiệt độ thay đổi ph&ugrave; hợp với nhiệt độ cơ thể bạn từ l&uacute;c bắt đầu ngủ cho đến khi thức dậy. Gi&uacute;p bạn c&oacute; một giấc ngủ s&acirc;u sau một ng&agrave;y l&agrave;m việc mệt mỏi.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(391).jpg" /><br />
Lọc sạch kh&ocirc;ng kh&iacute; v&agrave; khử m&ugrave;i h&ocirc;i tối đa<br />
Lưới lọc HD mật độ cao c&oacute; thể lọc bụi bẩn, m&ugrave;i h&ocirc;i gấp đ&ocirc;i lưới lọc th&ocirc;ng thường, loại bỏ ho&agrave;n to&agrave;n những t&aacute;c nh&acirc;n g&acirc;y hại đến sức khỏe người d&ugrave;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(275).jpg" /><br />
Chức năng Self-cleaning tự động l&agrave;m sạch<br />
D&agrave;n lạnh của chiếc&nbsp;m&aacute;y lạnh Midea&nbsp;n&agrave;y được l&agrave;m sạch tự động nhờ chức năng self-cleaning gi&uacute;p tăng tuổi thọ cho m&aacute;y lạnh, kh&ocirc;ng c&ograve;n t&igrave;nh trạng m&ugrave;i ẩm mốc.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(213).jpg" /><br />
Nh&igrave;n chung, với mức gi&aacute; cực k&igrave; ưu đ&atilde;i&nbsp;m&aacute;y lạnh Midea 1 HP MSMA3-10CRN1 phục vụ tốt nhu cầu sử dụng m&aacute;y lạnh cơ bản của người d&ugrave;ng. M&aacute;y l&agrave;m lạnh nhanh, lọc bụi trong kh&ocirc;ng kh&iacute; tốt. Nhỏ v&agrave; gọn, ph&ugrave; hợp lắp đặt cho ph&ograve;ng ngủ. Nếu chỉ sử dụng m&aacute;y lạnh để ngủ 4 tiếng một ng&agrave;y th&igrave; đ&acirc;y l&agrave; sự lựa chọn th&iacute;ch hợp để tiết kiệm chi ph&iacute;.</p>
', N'dieu-hoa-samsung-windfree-1-chieu-inverter-9400btu-ar10tygcdwknsv-FbD86A.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (14, 2, 3, N'Điều hòa Samsung Digital Inverter AR10RYFTAWKNSV 1 chiều 9.400BTU', N'dieu-hoa-samsung-digital-inverter-ar10ryftawknsv-1-chieu-9400btu', 4990000.0000, N'AR10RYFTAWKNSV', 42, 12, N'Thái Lan', 13, N'Công nghệ Digital Inverter 8 cực tối ưu điện năngBộ lọc 3 Care Filter lọc sạch 99% bụi bẩn và vi khuẩnHiệu suất vượt trội với công nghệ Bảo Vệ Bộ Ba Tăng Cường', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(821).jpg" /><br />
L&agrave;m lạnh nhanh ch&oacute;ng với chức năng Super cool<br />
Chỉ bằng một n&uacute;t nhấn, bạn sẽ nhanh ch&oacute;ng cảm nhận luồng hơi lạnh phả ra, nhiệt độ ph&ograve;ng li&ecirc;n tục giảm xuống theo &yacute; muốn của bạn chỉ trong thời gian rất ngắn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(714).jpg" /><br />
Chế độ cảm biến nhiệt độ th&ocirc;ng minh Follow me<br />
Remote được t&iacute;ch hợp cảm biến nhiệt độ th&ocirc;ng minh. Chỉ cần đặt remote cạnh bạn, m&aacute;y lạnh sẽ tự động điều chỉnh c&ocirc;ng suất để l&agrave;m lạnh khu vực xung quanh remote, sao cho nhiệt độ khu vực n&agrave;y ch&iacute;nh x&aacute;c nhất với nhiệt độ mong muốn. Tạo cảm gi&aacute;c m&aacute;t lạnh đ&uacute;ng chuẩn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(591).jpg" /><br />
C&agrave;i đặt c&aacute;c chế độ l&agrave;m lạnh ph&ugrave; hợp chỉ với một n&uacute;t nhấn<br />
Mỗi lần c&agrave;i đặt m&aacute;y lạnh bạn lại mất một khoảng thời gian, đ&ocirc;i khi kh&ocirc;ng đ&uacute;ng chế độ m&igrave;nh quen d&ugrave;ng rất bất tiện. Để khắc phục t&igrave;nh trạng n&agrave;y Midea trang bị cho sản phẩm của m&igrave;nh t&iacute;nh năng ghi nhớ chế độ l&agrave;m lạnh y&ecirc;u th&iacute;ch, k&iacute;ch hoạt chỉ bằng 1 n&uacute;t nhấn Fav tr&ecirc;n remote.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(458).jpg" /><br />
Chăm s&oacute;c cơ thể bạn khi ngủ<br />
Chức năng Sweet Dream&nbsp;điều chỉnh nhiệt độ thay đổi ph&ugrave; hợp với nhiệt độ cơ thể bạn từ l&uacute;c bắt đầu ngủ cho đến khi thức dậy. Gi&uacute;p bạn c&oacute; một giấc ngủ s&acirc;u sau một ng&agrave;y l&agrave;m việc mệt mỏi.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(391).jpg" /><br />
Lọc sạch kh&ocirc;ng kh&iacute; v&agrave; khử m&ugrave;i h&ocirc;i tối đa<br />
Lưới lọc HD mật độ cao c&oacute; thể lọc bụi bẩn, m&ugrave;i h&ocirc;i gấp đ&ocirc;i lưới lọc th&ocirc;ng thường, loại bỏ ho&agrave;n to&agrave;n những t&aacute;c nh&acirc;n g&acirc;y hại đến sức khỏe người d&ugrave;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(275).jpg" /><br />
Chức năng Self-cleaning tự động l&agrave;m sạch<br />
D&agrave;n lạnh của chiếc&nbsp;m&aacute;y lạnh Midea&nbsp;n&agrave;y được l&agrave;m sạch tự động nhờ chức năng self-cleaning gi&uacute;p tăng tuổi thọ cho m&aacute;y lạnh, kh&ocirc;ng c&ograve;n t&igrave;nh trạng m&ugrave;i ẩm mốc.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(213).jpg" /><br />
Nh&igrave;n chung, với mức gi&aacute; cực k&igrave; ưu đ&atilde;i&nbsp;m&aacute;y lạnh Midea 1 HP MSMA3-10CRN1 phục vụ tốt nhu cầu sử dụng m&aacute;y lạnh cơ bản của người d&ugrave;ng. M&aacute;y l&agrave;m lạnh nhanh, lọc bụi trong kh&ocirc;ng kh&iacute; tốt. Nhỏ v&agrave; gọn, ph&ugrave; hợp lắp đặt cho ph&ograve;ng ngủ. Nếu chỉ sử dụng m&aacute;y lạnh để ngủ 4 tiếng một ng&agrave;y th&igrave; đ&acirc;y l&agrave; sự lựa chọn th&iacute;ch hợp để tiết kiệm chi ph&iacute;.</p>
', N'-77QCAC.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (15, 2, 3, N'Điều hòa Samsung 1 chiều Inverter 9.700BTU AR10NVFSCURXSV', N'dieu-hoa-samsung-1-chieu-inverter-9700btu-ar10nvfscurxsv', 4990000.0000, N'AR10NVFSCURXSV', 54, 12, N'Thái Lan', 20, N'Máy nén Digital Inverter 8 cực tiết kiệm điện tối ưuBộ lọc Filter/3 Care-Filter lọc bụi, virus và chất gây dị ứngThiết kế tam diện lan tỏa hơi mát ra xa 14m', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(821).jpg" /><br />
L&agrave;m lạnh nhanh ch&oacute;ng với chức năng Super cool<br />
Chỉ bằng một n&uacute;t nhấn, bạn sẽ nhanh ch&oacute;ng cảm nhận luồng hơi lạnh phả ra, nhiệt độ ph&ograve;ng li&ecirc;n tục giảm xuống theo &yacute; muốn của bạn chỉ trong thời gian rất ngắn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(714).jpg" /><br />
Chế độ cảm biến nhiệt độ th&ocirc;ng minh Follow me<br />
Remote được t&iacute;ch hợp cảm biến nhiệt độ th&ocirc;ng minh. Chỉ cần đặt remote cạnh bạn, m&aacute;y lạnh sẽ tự động điều chỉnh c&ocirc;ng suất để l&agrave;m lạnh khu vực xung quanh remote, sao cho nhiệt độ khu vực n&agrave;y ch&iacute;nh x&aacute;c nhất với nhiệt độ mong muốn. Tạo cảm gi&aacute;c m&aacute;t lạnh đ&uacute;ng chuẩn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(591).jpg" /><br />
C&agrave;i đặt c&aacute;c chế độ l&agrave;m lạnh ph&ugrave; hợp chỉ với một n&uacute;t nhấn<br />
Mỗi lần c&agrave;i đặt m&aacute;y lạnh bạn lại mất một khoảng thời gian, đ&ocirc;i khi kh&ocirc;ng đ&uacute;ng chế độ m&igrave;nh quen d&ugrave;ng rất bất tiện. Để khắc phục t&igrave;nh trạng n&agrave;y Midea trang bị cho sản phẩm của m&igrave;nh t&iacute;nh năng ghi nhớ chế độ l&agrave;m lạnh y&ecirc;u th&iacute;ch, k&iacute;ch hoạt chỉ bằng 1 n&uacute;t nhấn Fav tr&ecirc;n remote.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(458).jpg" /><br />
Chăm s&oacute;c cơ thể bạn khi ngủ<br />
Chức năng Sweet Dream&nbsp;điều chỉnh nhiệt độ thay đổi ph&ugrave; hợp với nhiệt độ cơ thể bạn từ l&uacute;c bắt đầu ngủ cho đến khi thức dậy. Gi&uacute;p bạn c&oacute; một giấc ngủ s&acirc;u sau một ng&agrave;y l&agrave;m việc mệt mỏi.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(391).jpg" /><br />
Lọc sạch kh&ocirc;ng kh&iacute; v&agrave; khử m&ugrave;i h&ocirc;i tối đa<br />
Lưới lọc HD mật độ cao c&oacute; thể lọc bụi bẩn, m&ugrave;i h&ocirc;i gấp đ&ocirc;i lưới lọc th&ocirc;ng thường, loại bỏ ho&agrave;n to&agrave;n những t&aacute;c nh&acirc;n g&acirc;y hại đến sức khỏe người d&ugrave;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(275).jpg" /><br />
Chức năng Self-cleaning tự động l&agrave;m sạch<br />
D&agrave;n lạnh của chiếc&nbsp;m&aacute;y lạnh Midea&nbsp;n&agrave;y được l&agrave;m sạch tự động nhờ chức năng self-cleaning gi&uacute;p tăng tuổi thọ cho m&aacute;y lạnh, kh&ocirc;ng c&ograve;n t&igrave;nh trạng m&ugrave;i ẩm mốc.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(213).jpg" /><br />
Nh&igrave;n chung, với mức gi&aacute; cực k&igrave; ưu đ&atilde;i&nbsp;m&aacute;y lạnh Midea 1 HP MSMA3-10CRN1 phục vụ tốt nhu cầu sử dụng m&aacute;y lạnh cơ bản của người d&ugrave;ng. M&aacute;y l&agrave;m lạnh nhanh, lọc bụi trong kh&ocirc;ng kh&iacute; tốt. Nhỏ v&agrave; gọn, ph&ugrave; hợp lắp đặt cho ph&ograve;ng ngủ. Nếu chỉ sử dụng m&aacute;y lạnh để ngủ 4 tiếng một ng&agrave;y th&igrave; đ&acirc;y l&agrave; sự lựa chọn th&iacute;ch hợp để tiết kiệm chi ph&iacute;.</p>
', N'dieu-hoa-samsung-1-chieu-inverter-9700btu-ar10nvfscurxsv-6N779O.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (16, 2, 4, N'Điều hòa LG 1 chiều Inverter 9.200BTU V10ENW1', N'dieu-hoa-lg-1-chieu-inverter-9200btu-v10enw1', 9450000.0000, N'V10ENW1', 96, 12, N'Thái Lan', 21, N'Công suất 1 HP thích hợp sử dụng cho phòng có diện tích dưới 15m2Công nghệ Inverter giúp máy vận hành êm, giảm ồn, tiết kiệm điệnChế độ làm lạnh Powerful giúp căn phòng mát lạnh ngay tức thìChế độ thổi hướng gió dễ chịu tránh gió lạnh lùa trực tiếp vào cơ thểLớp phủ chống ăn mòn Gold Fin giúp tăng độ bền cho dàn tản nhiệt', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(821).jpg" /><br />
L&agrave;m lạnh nhanh ch&oacute;ng với chức năng Super cool<br />
Chỉ bằng một n&uacute;t nhấn, bạn sẽ nhanh ch&oacute;ng cảm nhận luồng hơi lạnh phả ra, nhiệt độ ph&ograve;ng li&ecirc;n tục giảm xuống theo &yacute; muốn của bạn chỉ trong thời gian rất ngắn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(714).jpg" /><br />
Chế độ cảm biến nhiệt độ th&ocirc;ng minh Follow me<br />
Remote được t&iacute;ch hợp cảm biến nhiệt độ th&ocirc;ng minh. Chỉ cần đặt remote cạnh bạn, m&aacute;y lạnh sẽ tự động điều chỉnh c&ocirc;ng suất để l&agrave;m lạnh khu vực xung quanh remote, sao cho nhiệt độ khu vực n&agrave;y ch&iacute;nh x&aacute;c nhất với nhiệt độ mong muốn. Tạo cảm gi&aacute;c m&aacute;t lạnh đ&uacute;ng chuẩn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(591).jpg" /><br />
C&agrave;i đặt c&aacute;c chế độ l&agrave;m lạnh ph&ugrave; hợp chỉ với một n&uacute;t nhấn<br />
Mỗi lần c&agrave;i đặt m&aacute;y lạnh bạn lại mất một khoảng thời gian, đ&ocirc;i khi kh&ocirc;ng đ&uacute;ng chế độ m&igrave;nh quen d&ugrave;ng rất bất tiện. Để khắc phục t&igrave;nh trạng n&agrave;y Midea trang bị cho sản phẩm của m&igrave;nh t&iacute;nh năng ghi nhớ chế độ l&agrave;m lạnh y&ecirc;u th&iacute;ch, k&iacute;ch hoạt chỉ bằng 1 n&uacute;t nhấn Fav tr&ecirc;n remote.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(458).jpg" /><br />
Chăm s&oacute;c cơ thể bạn khi ngủ<br />
Chức năng Sweet Dream&nbsp;điều chỉnh nhiệt độ thay đổi ph&ugrave; hợp với nhiệt độ cơ thể bạn từ l&uacute;c bắt đầu ngủ cho đến khi thức dậy. Gi&uacute;p bạn c&oacute; một giấc ngủ s&acirc;u sau một ng&agrave;y l&agrave;m việc mệt mỏi.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(391).jpg" /><br />
Lọc sạch kh&ocirc;ng kh&iacute; v&agrave; khử m&ugrave;i h&ocirc;i tối đa<br />
Lưới lọc HD mật độ cao c&oacute; thể lọc bụi bẩn, m&ugrave;i h&ocirc;i gấp đ&ocirc;i lưới lọc th&ocirc;ng thường, loại bỏ ho&agrave;n to&agrave;n những t&aacute;c nh&acirc;n g&acirc;y hại đến sức khỏe người d&ugrave;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(275).jpg" /><br />
Chức năng Self-cleaning tự động l&agrave;m sạch<br />
D&agrave;n lạnh của chiếc&nbsp;m&aacute;y lạnh Midea&nbsp;n&agrave;y được l&agrave;m sạch tự động nhờ chức năng self-cleaning gi&uacute;p tăng tuổi thọ cho m&aacute;y lạnh, kh&ocirc;ng c&ograve;n t&igrave;nh trạng m&ugrave;i ẩm mốc.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(213).jpg" /><br />
Nh&igrave;n chung, với mức gi&aacute; cực k&igrave; ưu đ&atilde;i&nbsp;m&aacute;y lạnh Midea 1 HP MSMA3-10CRN1 phục vụ tốt nhu cầu sử dụng m&aacute;y lạnh cơ bản của người d&ugrave;ng. M&aacute;y l&agrave;m lạnh nhanh, lọc bụi trong kh&ocirc;ng kh&iacute; tốt. Nhỏ v&agrave; gọn, ph&ugrave; hợp lắp đặt cho ph&ograve;ng ngủ. Nếu chỉ sử dụng m&aacute;y lạnh để ngủ 4 tiếng một ng&agrave;y th&igrave; đ&acirc;y l&agrave; sự lựa chọn th&iacute;ch hợp để tiết kiệm chi ph&iacute;.</p>
', N'dieu-hoa-lg-1-chieu-inverter-9200btu-v10enw1-V96Zd2.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (17, 2, 4, N'Điều hòa LG sang trọng 1 chiều Inverter 9.200BTU V10API1', N'dieu-hoa-lg-sang-trong-1-chieu-inverter-9200btu-v10api1', 12200000.0000, N'V10API1', 63, 12, N'Thái Lan', 16, N'Công suất làm lạnh 1 HP, dành cho phòng có diện tích dưới 15 mét vuông.Công nghệ Inverter nâng cao hiệu quả tiết kiệm điện.Làm lạnh nhanh chóng chỉ trong 3 phút với công nghệ Jet Cool.Phát hiện và xử lý nhanh chóng khi máy lạnh bị lỗi với tính năng chuẩn đoán lỗi.', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(821).jpg" /><br />
L&agrave;m lạnh nhanh ch&oacute;ng với chức năng Super cool<br />
Chỉ bằng một n&uacute;t nhấn, bạn sẽ nhanh ch&oacute;ng cảm nhận luồng hơi lạnh phả ra, nhiệt độ ph&ograve;ng li&ecirc;n tục giảm xuống theo &yacute; muốn của bạn chỉ trong thời gian rất ngắn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(714).jpg" /><br />
Chế độ cảm biến nhiệt độ th&ocirc;ng minh Follow me<br />
Remote được t&iacute;ch hợp cảm biến nhiệt độ th&ocirc;ng minh. Chỉ cần đặt remote cạnh bạn, m&aacute;y lạnh sẽ tự động điều chỉnh c&ocirc;ng suất để l&agrave;m lạnh khu vực xung quanh remote, sao cho nhiệt độ khu vực n&agrave;y ch&iacute;nh x&aacute;c nhất với nhiệt độ mong muốn. Tạo cảm gi&aacute;c m&aacute;t lạnh đ&uacute;ng chuẩn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(591).jpg" /><br />
C&agrave;i đặt c&aacute;c chế độ l&agrave;m lạnh ph&ugrave; hợp chỉ với một n&uacute;t nhấn<br />
Mỗi lần c&agrave;i đặt m&aacute;y lạnh bạn lại mất một khoảng thời gian, đ&ocirc;i khi kh&ocirc;ng đ&uacute;ng chế độ m&igrave;nh quen d&ugrave;ng rất bất tiện. Để khắc phục t&igrave;nh trạng n&agrave;y Midea trang bị cho sản phẩm của m&igrave;nh t&iacute;nh năng ghi nhớ chế độ l&agrave;m lạnh y&ecirc;u th&iacute;ch, k&iacute;ch hoạt chỉ bằng 1 n&uacute;t nhấn Fav tr&ecirc;n remote.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(458).jpg" /><br />
Chăm s&oacute;c cơ thể bạn khi ngủ<br />
Chức năng Sweet Dream&nbsp;điều chỉnh nhiệt độ thay đổi ph&ugrave; hợp với nhiệt độ cơ thể bạn từ l&uacute;c bắt đầu ngủ cho đến khi thức dậy. Gi&uacute;p bạn c&oacute; một giấc ngủ s&acirc;u sau một ng&agrave;y l&agrave;m việc mệt mỏi.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(391).jpg" /><br />
Lọc sạch kh&ocirc;ng kh&iacute; v&agrave; khử m&ugrave;i h&ocirc;i tối đa<br />
Lưới lọc HD mật độ cao c&oacute; thể lọc bụi bẩn, m&ugrave;i h&ocirc;i gấp đ&ocirc;i lưới lọc th&ocirc;ng thường, loại bỏ ho&agrave;n to&agrave;n những t&aacute;c nh&acirc;n g&acirc;y hại đến sức khỏe người d&ugrave;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(275).jpg" /><br />
Chức năng Self-cleaning tự động l&agrave;m sạch<br />
D&agrave;n lạnh của chiếc&nbsp;m&aacute;y lạnh Midea&nbsp;n&agrave;y được l&agrave;m sạch tự động nhờ chức năng self-cleaning gi&uacute;p tăng tuổi thọ cho m&aacute;y lạnh, kh&ocirc;ng c&ograve;n t&igrave;nh trạng m&ugrave;i ẩm mốc.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(213).jpg" /><br />
Nh&igrave;n chung, với mức gi&aacute; cực k&igrave; ưu đ&atilde;i&nbsp;m&aacute;y lạnh Midea 1 HP MSMA3-10CRN1 phục vụ tốt nhu cầu sử dụng m&aacute;y lạnh cơ bản của người d&ugrave;ng. M&aacute;y l&agrave;m lạnh nhanh, lọc bụi trong kh&ocirc;ng kh&iacute; tốt. Nhỏ v&agrave; gọn, ph&ugrave; hợp lắp đặt cho ph&ograve;ng ngủ. Nếu chỉ sử dụng m&aacute;y lạnh để ngủ 4 tiếng một ng&agrave;y th&igrave; đ&acirc;y l&agrave; sự lựa chọn th&iacute;ch hợp để tiết kiệm chi ph&iacute;.</p>
', N'dieu-hoa-lg-sang-trong-1-chieu-inverter-9200btu-v10api1-qJLPJm.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (18, 2, 4, N'Điều hòa LG UV Nano 1 chiều Inverter 9.200BTU V10APFUV', N'dieu-hoa-lg-uv-nano-1-chieu-inverter-9200btu-v10apfuv', 15700000.0000, N'V10APFUV', 47, 12, N'Thái Lan', 15, N'Công nghệ UV Nano loại bỏ vi khuẩn tới 99,99%Loại bỏ bụi siêu mịn PM 0.1Công suất 1 HP thích hợp sử dụng cho phòng có diện tích dưới 15m2', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(821).jpg" /><br />
L&agrave;m lạnh nhanh ch&oacute;ng với chức năng Super cool<br />
Chỉ bằng một n&uacute;t nhấn, bạn sẽ nhanh ch&oacute;ng cảm nhận luồng hơi lạnh phả ra, nhiệt độ ph&ograve;ng li&ecirc;n tục giảm xuống theo &yacute; muốn của bạn chỉ trong thời gian rất ngắn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(714).jpg" /><br />
Chế độ cảm biến nhiệt độ th&ocirc;ng minh Follow me<br />
Remote được t&iacute;ch hợp cảm biến nhiệt độ th&ocirc;ng minh. Chỉ cần đặt remote cạnh bạn, m&aacute;y lạnh sẽ tự động điều chỉnh c&ocirc;ng suất để l&agrave;m lạnh khu vực xung quanh remote, sao cho nhiệt độ khu vực n&agrave;y ch&iacute;nh x&aacute;c nhất với nhiệt độ mong muốn. Tạo cảm gi&aacute;c m&aacute;t lạnh đ&uacute;ng chuẩn.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(591).jpg" /><br />
C&agrave;i đặt c&aacute;c chế độ l&agrave;m lạnh ph&ugrave; hợp chỉ với một n&uacute;t nhấn<br />
Mỗi lần c&agrave;i đặt m&aacute;y lạnh bạn lại mất một khoảng thời gian, đ&ocirc;i khi kh&ocirc;ng đ&uacute;ng chế độ m&igrave;nh quen d&ugrave;ng rất bất tiện. Để khắc phục t&igrave;nh trạng n&agrave;y Midea trang bị cho sản phẩm của m&igrave;nh t&iacute;nh năng ghi nhớ chế độ l&agrave;m lạnh y&ecirc;u th&iacute;ch, k&iacute;ch hoạt chỉ bằng 1 n&uacute;t nhấn Fav tr&ecirc;n remote.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(458).jpg" /><br />
Chăm s&oacute;c cơ thể bạn khi ngủ<br />
Chức năng Sweet Dream&nbsp;điều chỉnh nhiệt độ thay đổi ph&ugrave; hợp với nhiệt độ cơ thể bạn từ l&uacute;c bắt đầu ngủ cho đến khi thức dậy. Gi&uacute;p bạn c&oacute; một giấc ngủ s&acirc;u sau một ng&agrave;y l&agrave;m việc mệt mỏi.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(391).jpg" /><br />
Lọc sạch kh&ocirc;ng kh&iacute; v&agrave; khử m&ugrave;i h&ocirc;i tối đa<br />
Lưới lọc HD mật độ cao c&oacute; thể lọc bụi bẩn, m&ugrave;i h&ocirc;i gấp đ&ocirc;i lưới lọc th&ocirc;ng thường, loại bỏ ho&agrave;n to&agrave;n những t&aacute;c nh&acirc;n g&acirc;y hại đến sức khỏe người d&ugrave;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(275).jpg" /><br />
Chức năng Self-cleaning tự động l&agrave;m sạch<br />
D&agrave;n lạnh của chiếc&nbsp;m&aacute;y lạnh Midea&nbsp;n&agrave;y được l&agrave;m sạch tự động nhờ chức năng self-cleaning gi&uacute;p tăng tuổi thọ cho m&aacute;y lạnh, kh&ocirc;ng c&ograve;n t&igrave;nh trạng m&ugrave;i ẩm mốc.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(213).jpg" /><br />
Nh&igrave;n chung, với mức gi&aacute; cực k&igrave; ưu đ&atilde;i&nbsp;m&aacute;y lạnh Midea 1 HP MSMA3-10CRN1 phục vụ tốt nhu cầu sử dụng m&aacute;y lạnh cơ bản của người d&ugrave;ng. M&aacute;y l&agrave;m lạnh nhanh, lọc bụi trong kh&ocirc;ng kh&iacute; tốt. Nhỏ v&agrave; gọn, ph&ugrave; hợp lắp đặt cho ph&ograve;ng ngủ. Nếu chỉ sử dụng m&aacute;y lạnh để ngủ 4 tiếng một ng&agrave;y th&igrave; đ&acirc;y l&agrave; sự lựa chọn th&iacute;ch hợp để tiết kiệm chi ph&iacute;.</p>
', N'-6ZjeIx.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (19, 3, 5, N'Nồi chiên không dầu 3.5 lít Coex AFC-3115', N'noi-chien-khong-dau-35-lit-coex-afc-3115', 214000.0000, N'AFC-3115', 76, 12, N'Trung Quốc', 10, N'Dung tích chứa 3.5 lít, công suất 1500W chế biến được nhiều món ăn nhanh hơnCông nghệ Rapid Air độc đáo có thể rán, nướng, quay ngon và giảm dầu mỡ đến 80%Khay chiên phủ lớp chống dính ceramic cao cấp bền bỉ, hạn chế dính cháy, dễ chùi rửa sau khi dùng2 nút điều chỉnh thời gian và nhiệt độ riêng biệt', N'<h3>Thiết kế sang trọng, tinh tế</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu cao cấp Coex AFC-3115 thiết kế kiểu d&aacute;ng đẹp v&agrave; lạ mắt với lớp vỏ&nbsp;ngo&agrave;i mạ chrome sang trọng, vệ sinh. Vỏ d&agrave;y b&oacute;ng lo&aacute;ng, đẹp mắt, thiết kế dung t&iacute;ch 3.5 l&iacute;t, c&ocirc;ng suất 1500W, c&ocirc;ng nghệ Rapid Air hiện đại. Ứng dụng c&ocirc;ng nghệ chi&ecirc;n kh&ocirc;ng dầu Rapid Air hạn chế dầu mỡ tối đa cho m&oacute;n chi&ecirc;n, nướng thơm ngon, bổ dưỡng v&agrave; tốt với sức khỏe của người d&ugrave;ng hơn. Đặc biệt, th&iacute;ch hợp sử dụng sản phẩm nấu ăn cho người gi&agrave; v&agrave; trẻ nhỏ.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3115-01.jpg" /></p>

<h3>C&ocirc;ng nghệ chi&ecirc;n kh&ocirc;ng dầu Rapid Air gi&uacute;p thức ăn ch&iacute;n đều hơn</h3>

<p>Ứng dụng c&ocirc;ng nghệ chi&ecirc;n kh&ocirc;ng dầu Rapid Air kh&ocirc;ng kh&iacute; kết hợp với quạt thổi gi&oacute; gi&uacute;p kh&ocirc;ng kh&iacute; n&oacute;ng được lan tỏa nhanh v&agrave; mạnh đều khắp bề mặt thực phẩm đảm bảo m&oacute;n ăn được ch&iacute;n đều m&agrave; kh&ocirc;ng cần trở mặt nhiều như khi chi&ecirc;n bằng chảo chống d&iacute;nh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3115-02.jpg" /></p>

<h3>Dung t&iacute;ch nồi 3.5 l&iacute;t c&oacute; thể nướng được con g&agrave; 1 kg, c&ocirc;ng suất 1500W l&agrave;m n&oacute;ng bằng thanh điện trở chi&ecirc;n thực phẩm ch&iacute;n rất nhanh</h3>

<p>Hạn chế dầu mỡ tối đa cho m&oacute;n chi&ecirc;n (giảm 80% lượng mỡ trong thịt c&aacute;), nướng thơm ngon, bổ dưỡng v&agrave; tốt với sức khỏe của người d&ugrave;ng hơn. Đặc biệt, th&iacute;ch hợp sử dụng sản phẩm nấu ăn cho người gi&agrave; v&agrave; trẻ nhỏ.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3115-03.jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3115-04.jpg" /></p>

<h3>Bảng điều khiển thiết kế dạng n&uacute;m vặn dễ d&ugrave;ng</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu trang bị 2 n&uacute;t điều chỉnh thời gian v&agrave; nhiệt độ ri&ecirc;ng biệt. Người d&ugrave;ng c&oacute; thể t&ugrave;y chỉnh nhiệt độ từ 80 - 200 độ C, mức c&agrave;i đặt thời gian từ 0 - 60 ph&uacute;t trong khi c&aacute;c nồi kh&aacute;c từ 0 - 30 ph&uacute;t . T&ugrave;y loại v&agrave; lượng thực phẩm bạn chế biến, bạn c&oacute; thể canh chỉnh thời gian v&agrave; nhiệt độ ph&ugrave; hợp. Nồi chi&ecirc;n kh&ocirc;ng dầu sẽ tự động tắt khi hết thời gian c&agrave;i đặt, gi&uacute;p m&oacute;n ăn kh&ocirc;ng bị ch&aacute;y kh&eacute;t.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3115-05.jpg" /></p>

<h3>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic</h3>

<p>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic an to&agrave;n gi&uacute;p thực phẩm kh&ocirc;ng bị d&iacute;nh, kh&ocirc;ng bị vỡ n&aacute;t trong qu&aacute; tr&igrave;nh chi&ecirc;n, r&aacute;n... dễ ch&ugrave;i rửa sau khi d&ugrave;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3115-06.jpg" /></p>

<h3>Khay nồi chi&ecirc;n c&oacute; tay cầm chống n&oacute;ng, tiện lợi v&agrave; an t&acirc;m sử dụng. Vỉ chi&ecirc;n chống d&iacute;nh c&oacute; thể th&aacute;o rời để vệ sinh thuận tiện</h3>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3115-07.jpg" /></p>

<p><strong>Lưu &yacute; khi sử dụng nồi chi&ecirc;n kh&ocirc;ng dầu:</strong></p>

<p>- Thực phẩm trước khi đưa v&agrave;o nồi chi&ecirc;n cần được l&agrave;m sạch v&agrave; r&aacute;o nước.</p>

<p>- Kh&ocirc;ng cho qu&aacute; nhiều thực phẩm v&agrave;o c&ugrave;ng một l&uacute;c tr&aacute;nh đầy thức ăn v&agrave; thức ăn kh&ocirc;ng ch&iacute;n đều.</p>

<p>- Chi&ecirc;n xong chờ thức ăn v&agrave; l&ograve; nguội bớt trước khi lấy ra ngo&agrave;i v&agrave; chi&ecirc;n th&ecirc;m mẻ tiếp theo.</p>

<p>- R&uacute;t điện, chờ l&ograve; nguội &iacute;t nhất 30 ph&uacute;t sau khi nấu rồi mới tiến h&agrave;nh vệ sinh l&ograve;.</p>

<p>- Rửa khay chi&ecirc;n bằng nước n&oacute;ng với một ch&uacute;t nước rửa ch&eacute;n v&agrave; miếng vải mềm.</p>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Coex AFC 3115,&nbsp; 3.5 l&iacute;t c&oacute; dung t&iacute;ch lớn, chức năng hẹn giờ tiện lợi giảm 80% lượng mỡ trong thịt c&aacute; ph&ugrave; hợp cho gia đ&igrave;nh c&oacute; người gi&agrave;, trẻ nhỏ v&agrave; người ăn ki&ecirc;ng.</p>
', N'noi-chien-khong-dau-dien-tu-35-lit-coex-afc3115-C5ixBc.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (20, 3, 5, N'Nồi chiên không dầu 5 Lít cao cấp Coex AFC-3118M', N'noi-chien-khong-dau-5-lit-cao-cap-coex-afc-3118m', 3070000.0000, N'AFC-3118M', 92, 24, N'Trung Quốc', 12, N'Công suất mạnh mẽ 1700W cho món ăn chín nhanh, ít dầu, tốt cho sức khỏe của người dùngDung tích chứa siêu lớn 5.0 LítCông nghệ Rapid Air độc đáo có thể rán, nướng, quay ngon và giảm dầu mỡ đến 80%', N'<h3>Thiết kế sang trọng, tinh tế</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu cao cấp Coex AFC-3118M thiết kế sang trọng, trang nh&atilde; c&ugrave;ng với chất liệu an to&agrave;n, bền bỉ. Vỏ ngo&agrave;i bằng th&eacute;p kh&ocirc;ng gỉ, sang trọng, dễ vệ sinh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-02.jpg" /></p>

<h3>C&ocirc;ng suất 1700W</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Coex 3118M c&oacute; c&ocirc;ng suất 1700W gi&uacute;p chế biến được nhiều m&oacute;n ăn nhanh hơn, gi&uacute;p tiết kiệm năng lượng đến 50% so với nồi thường. Kh&ocirc;ng những chi&ecirc;n thức ăn kh&ocirc;ng d&ugrave;ng đến dầu m&agrave; c&ograve;n gi&uacute;p loại bỏ đến 80% lượng mỡ c&oacute; sẵn trong thực phẩm.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-03.jpg" /><br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-04.jpg" /><br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-06.jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(668).png" /><br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-08.jpg" /><br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-09.jpg" /></p>

<h3>Dung t&iacute;ch chứa 5L</h3>

<p>Với dung t&iacute;ch 5L,&nbsp;<a href="https://mediamart.vn/noi-chien-khong-dau/" target="_blank">nồi chi&ecirc;n kh&ocirc;ng dầu</a>&nbsp;sử dụng cảm biến nhiệt độ v&agrave; thời gian, bảng điều khiển điện tử dễ d&agrave;ng thao t&aacute;c chọn c&aacute;c chức năng. Bạn c&oacute; thể điều chỉnh nhiệt độ v&agrave; thời gian nướng t&ugrave;y th&iacute;ch. Nồi sử dụng&nbsp;cảm biến nhiệt độ, thời gian được c&agrave;i đặt v&agrave; tự động ngắt gi&uacute;p đồ ăn ch&iacute;n đều, gi&ograve;n, ngon, kh&ocirc;ng bị ch&aacute;y kh&eacute;t. Nồi chi&ecirc;n kh&ocirc;ng dầu ph&ugrave; hợp chi&ecirc;n, nướng d&agrave;nh cho gia đ&igrave;nh tr&ecirc;n 6 người ăn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-05.jpg" /></p>

<h3>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic</h3>

<p>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic an to&agrave;n gi&uacute;p thực phẩm kh&ocirc;ng bị d&iacute;nh, kh&ocirc;ng bị vỡ n&aacute;t trong qu&aacute; tr&igrave;nh chi&ecirc;n, r&aacute;n... dễ ch&ugrave;i rửa sau khi d&ugrave;ng. Mặt k&iacute;nh cường lực trong suốt chịu nhiệt cao, người d&ugrave;ng c&oacute; thể dễ d&agrave;ng quan s&aacute;t qu&aacute; tr&igrave;nh thực phẩm được chi&ecirc;n từ đ&oacute; điều chỉnh nhiệt độ v&agrave; thời gian ph&ugrave; hợp.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-11.jpg" /><br />
<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang04/AFC-3118M-10.jpg" /><br />
<img src="https://cdn.mediamart.vn/images/Upload/images/22(48).png" /></p>
', N'-krQCen.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (21, 3, 5, N'Nồi chiên không dầu 5L Coex AFC-3119', N'noi-chien-khong-dau-5l-coex-afc-3119', 3690000.0000, N'AFC-3119', 64, 12, N'Trung Quốc', 0, N'Dung tích chứa siêu lớn 5.0 Lít, Công suất mạnh mẽ 1700W cho món ăn chín nhanh, ít dầu, tốt cho sức khỏe của người dùngKhay chiên phủ lớp chống dính Ceramic cao cấp bền bỉ, hạn chế dính cháy, dễ chùi rửa sau khi dùngBảng điều khiển gồm 2 núm điều chỉnh thời gian và nhiệt độ riêng biệt dễ sử dụng', N'<h3>Thiết kế sang trọng, tinh tế</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu cao cấp Coex AFC-3119 thiết kế sang trọng, trang nh&atilde; c&ugrave;ng với chất liệu an to&agrave;n, bền bỉ. Vỏ ngo&agrave;i bằng th&eacute;p kh&ocirc;ng gỉ, sang trọng, dễ vệ sinh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3119-01.jpg" /></p>

<h3>C&ocirc;ng suất 1700W</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Coex c&oacute; c&ocirc;ng suất 1700W gi&uacute;p chế biến được nhiều m&oacute;n ăn nhanh hơn, gi&uacute;p tiết kiệm năng lượng đến 50% so với nồi thường. Kh&ocirc;ng những chi&ecirc;n thức ăn kh&ocirc;ng d&ugrave;ng đến dầu m&agrave; c&ograve;n gi&uacute;p loại bỏ đến 80% lượng mỡ c&oacute; sẵn trong thực phẩm.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3119-02.jpg" /></p>

<h3>Dung t&iacute;ch chứa 5.0L</h3>

<p>Với dung t&iacute;ch 5.0L,&nbsp;<a href="https://mediamart.vn/noi-chien-khong-dau/" target="_blank">nồi chi&ecirc;n kh&ocirc;ng dầu</a>&nbsp;sử dụng cảm biến nhiệt độ v&agrave; thời gian, điều khiển cơ với 2 n&uacute;t xoay điều chỉnh nhiệt độ v&agrave; thời gian. Bạn c&oacute; thể điều chỉnh nhiệt độ v&agrave; thời gian nướng bằng c&aacute;c n&uacute;m vặn xo&aacute;y. Nồi sử dụng&nbsp;cảm biến nhiệt độ, thời gian đ&atilde; được c&agrave;i đặt v&agrave; tự động ngắt gi&uacute;p đồ ăn ch&iacute;n đều, gi&ograve;n, ngon, kh&ocirc;ng bị ch&aacute;y kh&eacute;t. Nồi chi&ecirc;n kh&ocirc;ng dầu ph&ugrave; hợp chi&ecirc;n, nướng d&agrave;nh cho gia đ&igrave;nh tr&ecirc;n 6 người ăn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(785).jpg" /></p>

<h3>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic</h3>

<p>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic an to&agrave;n gi&uacute;p thực phẩm kh&ocirc;ng bị d&iacute;nh, kh&ocirc;ng bị vỡ n&aacute;t trong qu&aacute; tr&igrave;nh chi&ecirc;n, r&aacute;n... dễ ch&ugrave;i rửa sau khi d&ugrave;ng.&nbsp;</p>

<h3><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3119-04.jpg" /></h3>

<h3>Tiện lợi</h3>

<p>Coex AFC-3119 trang bị 2 n&uacute;t điều chỉnh thời gian v&agrave; nhiệt độ ri&ecirc;ng biệt, c&oacute; nhiều mức nhiệt gi&uacute;p bạn t&ugrave;y chỉnh nhiệt độ một c&aacute;ch dễ d&agrave;ng. Chức năng&nbsp;hẹn giờ nướng thuận tiện, ch&iacute;nh x&aacute;c bằng n&uacute;t xoay.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3119-05.jpg" /></p>
', N'-J63WXT.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (22, 3, 5, N'Nồi chiên không dầu 5.5 Lít cao cấp Coex AFC-3109', N'noi-chien-khong-dau-55-lit-cao-cap-coex-afc-3109', 3990000.0000, N'AFC-3109', 462, 12, N'Trung Quốc', 16, N'Dung tích chứa siêu lớn 5.5 LítCông suất 1500W chế biến được nhiều món ăn nhanh hơnCông nghệ Rapid Air độc đáo có thể rán, nướng, quay ngon, giảm dầu mỡ đến 80%Kính cường lực trong suốt, quan sát được quá trình chín thực phẩm', N'<h3>Thiết kế sang trọng, tinh tế</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu cao cấp&nbsp;<strong>Coex AFC-3109&nbsp;</strong>thiết kế sang trọng, trang nh&atilde; c&ugrave;ng với chất liệu an to&agrave;n, bền bỉ. K&iacute;nh cường lực trong suốt, quan s&aacute;t được qu&aacute; tr&igrave;nh ch&iacute;n thực phẩm b&ecirc;n trong. Vỏ ngo&agrave;i bằng th&eacute;p kh&ocirc;ng gỉ, sang trọng, dễ vệ sinh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(433).png" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(336).png" /></p>

<h3>C&ocirc;ng suất 1500W</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Coex c&oacute; c&ocirc;ng suất 1500W gi&uacute;p chế biến được nhiều m&oacute;n ăn nhanh hơn, gi&uacute;p tiết kiệm năng lượng đến 50% so với nồi thường. Kh&ocirc;ng những chi&ecirc;n thức ăn kh&ocirc;ng d&ugrave;ng đến dầu m&agrave; c&ograve;n gi&uacute;p loại bỏ đến 80% lượng mỡ c&oacute; sẵn trong thực phẩm.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(306).png" /></p>

<h3>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic</h3>

<p>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic an to&agrave;n gi&uacute;p thực phẩm kh&ocirc;ng bị d&iacute;nh, kh&ocirc;ng bị vỡ n&aacute;t trong qu&aacute; tr&igrave;nh chi&ecirc;n, r&aacute;n... dễ ch&ugrave;i rửa sau khi d&ugrave;ng. Mặt k&iacute;nh cường lực trong suốt chịu nhiệt cao, người d&ugrave;ng c&oacute; thể dễ d&agrave;ng quan s&aacute;t qu&aacute; tr&igrave;nh thực phẩm được chi&ecirc;n từ đ&oacute; điều chỉnh nhiệt độ v&agrave; thời gian ph&ugrave; hợp.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/4(186).png" /></p>

<h3>Dung t&iacute;ch chứa si&ecirc;u lớn 5.5L</h3>

<p>Với dung t&iacute;ch chứa si&ecirc;u lớn 5.5 L&iacute;t, nồi chi&ecirc;n kh&ocirc;ng dầu&nbsp;<strong>Coex AFC-3109</strong>&nbsp;ph&ugrave; hợp chi&ecirc;n, nướng d&agrave;nh cho gia đ&igrave;nh 4 - 5 người ăn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1_01.png" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1_02.png" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2_01.png" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2_02.png" /></p>

<h3>Tiện lợi</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu cao cấp Coex&nbsp;<strong>AFC-3109</strong>&nbsp;được trang bị 2 n&uacute;t vặn điều khiển thời gian v&agrave; nhiệt độ ri&ecirc;ng biệt gi&uacute;p bạn c&oacute; thể chi&ecirc;n, nướng, nấu, h&acirc;m n&oacute;ng, l&agrave;m b&aacute;nh... một c&aacute;ch dễ d&agrave;ng v&agrave; v&ocirc; c&ugrave;ng tiện lợi cho tất cả mọi người.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3_01.png" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3_02.png" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/8_01.png" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/8_02.png" /></p>

<p>&nbsp;</p>
', N'noi-chien-khong-dau-coex-afc3109-T74L46.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (23, 3, 5, N'Nồi chiên không dầu điện tử cao cấp 5 lít Coex AFC-3118', N'noi-chien-khong-dau-dien-tu-cao-cap-5-lit-coex-afc-3118', 4290000.0000, N'AFC-3118', 30, 12, N'Trung Quốc', 19, N'Dung tích chứa siêu lớn 5 lít, công suất mạnh mẽ 1700W cho món ăn chín nhanh, ít dầu, tốt cho sức khỏe của người dùngKhay chiên phủ lớp chống dính ceramic cao cấp bền bỉ, hạn chế dính cháy, dễ chùi rửa sau khi dùngBảng điều khiển điện tử dễ dàng thao tác chọn các chức năng', N'<h3>Thiết kế sang trọng, tinh tế</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu cao cấp Coex AFC-3118 thiết kế sang trọng, trang nh&atilde; c&ugrave;ng với chất liệu an to&agrave;n, bền bỉ. Vỏ ngo&agrave;i bằng th&eacute;p kh&ocirc;ng gỉ, sang trọng, dễ vệ sinh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3118-01.jpg" /></p>

<h3>C&ocirc;ng suất 1700W</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Coex c&oacute; c&ocirc;ng suất 1700W gi&uacute;p chế biến được nhiều m&oacute;n ăn nhanh hơn, gi&uacute;p tiết kiệm năng lượng đến 50% so với nồi thường. Kh&ocirc;ng những chi&ecirc;n thức ăn kh&ocirc;ng d&ugrave;ng đến dầu m&agrave; c&ograve;n gi&uacute;p loại bỏ đến 80% lượng mỡ c&oacute; sẵn trong thực phẩm.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3118-02.jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3118-03.jpg" /></p>

<h3>Dung t&iacute;ch chứa 5L</h3>

<p>Với dung t&iacute;ch 5L,&nbsp;<a href="https://mediamart.vn/noi-chien-khong-dau/" target="_blank">nồi chi&ecirc;n kh&ocirc;ng dầu</a>&nbsp;sử dụng cảm biến nhiệt độ v&agrave; thời gian, bảng điều khiển điện tử dễ d&agrave;ng thao t&aacute;c chọn c&aacute;c chức năng. Bạn c&oacute; thể điều chỉnh nhiệt độ v&agrave; thời gian nướng t&ugrave;y th&iacute;ch. Nồi sử dụng&nbsp;cảm biến nhiệt độ, thời gian được c&agrave;i đặt v&agrave; tự động ngắt gi&uacute;p đồ ăn ch&iacute;n đều, gi&ograve;n, ngon, kh&ocirc;ng bị ch&aacute;y kh&eacute;t. Nồi chi&ecirc;n kh&ocirc;ng dầu ph&ugrave; hợp chi&ecirc;n, nướng d&agrave;nh cho gia đ&igrave;nh tr&ecirc;n 6 người ăn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/4(612).jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3118-05.jpg" /></p>

<h3>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic</h3>

<p>Khay chi&ecirc;n phủ lớp chống d&iacute;nh Ceramic an to&agrave;n gi&uacute;p thực phẩm kh&ocirc;ng bị d&iacute;nh, kh&ocirc;ng bị vỡ n&aacute;t trong qu&aacute; tr&igrave;nh chi&ecirc;n, r&aacute;n... dễ ch&ugrave;i rửa sau khi d&ugrave;ng. Mặt k&iacute;nh cường lực trong suốt chịu nhiệt cao, người d&ugrave;ng c&oacute; thể dễ d&agrave;ng quan s&aacute;t qu&aacute; tr&igrave;nh thực phẩm được chi&ecirc;n từ đ&oacute; điều chỉnh nhiệt độ v&agrave; thời gian ph&ugrave; hợp.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2021/Thang06/AFC-3118-06.jpg" /></p>
', N'noi-chien-khong-dau-dien-tu-cao-cap-5-lit-coex-afc3118-f962HO.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (24, 3, 6, N'Nồi chiên không dầu Philips HD9216', N'noi-chien-khong-dau-philips-hd9216', 2880000.0000, N'HD9216', 46, 12, N'Trung Quốc', 20, N'Dung tích 3 lít, Công suất 1425W nấu nhanh hơn so với lò nướng thườngVới Airfryer bạn có thể rán, quay, nướng và thậm chí là nướng bánhĐiều khiển thời gian và nhiệt độ có thể điều chỉnh theo cách thủ côngRán có lợi cho sức khỏe với công nghệ Rapid Air', N'<p><strong>Nồi chi&ecirc;n ch&acirc;n kh&ocirc;ng Philips HD9216</strong>&nbsp;với c&ocirc;ng nghệ Rapid Air độc đ&aacute;o của Philips cho ph&eacute;p bạn r&aacute;n bằng kh&ocirc;ng kh&iacute;, khiến cho thức ăn gi&ograve;n ở b&ecirc;n ngo&agrave;i v&agrave; mềm ở b&ecirc;n trong.Chỉ cần &iacute;t dầu hoặc kh&ocirc;ng cần dầu để c&oacute; m&oacute;n ăn đẹp ho&agrave;n hảo v&agrave; thật ngon miệng</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-3-News/fNu7A962nelAv8d.jpg" /></p>

<p>&nbsp;</p>

<p><em><strong>Ưu điểm: Nồi chi&ecirc;n ch&acirc;n kh&ocirc;ng HD 9216:</strong></em></p>

<p><strong>R&aacute;n c&oacute; lợi cho sức khỏe với c&ocirc;ng nghệ Rapid Air</strong></p>

<p>Nồi chi&ecirc;n ch&acirc;n kh&ocirc;ng Philips HD9216 với c&ocirc;ng nghệ Rapid Air, Airfryer lu&acirc;n chuyển kh&iacute; n&oacute;ng xung quanh giỏ nấu bọc lưới kim loại, sử dụng &iacute;t dầu hoặc kh&ocirc;ng d&ugrave;ng dầu khi chi&ecirc;n r&aacute;n, nướng thịt v&agrave; nướng b&aacute;nh. Mặt đ&aacute;y của Airfryer được thiết kế h&igrave;nh sao gi&uacute;p lưu th&ocirc;ng kh&iacute; dễ d&agrave;ng, đảm bảo c&aacute;c m&oacute;n ăn ưa th&iacute;ch của bạn được nấu ch&iacute;n đều.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-3-News/IF8KrxdLYLLMi0B.jpg" /></p>

<p><strong>Với Airfryer bạn c&oacute; thể r&aacute;n, quay, nướng v&agrave; thậm ch&iacute; l&agrave; nướng b&aacute;nh</strong></p>

<p>Kh&ocirc;ng chỉ tuyệt vời khi r&aacute;n, Philips Airfryer đổi mới với c&ocirc;ng nghệ Rapid Air c&ograve;n cho ph&eacute;p bạn quay, nướng b&aacute;nh v&agrave; nướng những m&oacute;n ăn ưa th&iacute;ch với giải ph&aacute;p một lần kết th&uacute;c cho tất cả c&aacute;c m&oacute;n của bữa ăn.</p>

<p><strong>Điều khiển thời gian v&agrave; nhiệt độ c&oacute; thể điều chỉnh theo c&aacute;ch thủ c&ocirc;ng</strong></p>

<p>&nbsp;</p>

<p>Chức năng hẹn giờ t&iacute;ch hợp cho ph&eacute;p bạn đặt sẵn thời gian nấu l&ecirc;n đến 30 ph&uacute;t. Chức năng tự động tắt c&oacute; cả chỉ b&aacute;o &acirc;m thanh &quot;sẵn s&agrave;ng&quot;. Điều khiển nhiệt độ ho&agrave;n to&agrave;n c&oacute; thể điều chỉnh cho ph&eacute;p bạn đặt trước nhiệt độ nấu ăn tốt nh ất cho thức ăn l&ecirc;n đến 390 độ. Thưởng thức những miếng r&aacute;n gi&ograve;n, v&agrave;ng ươm, m&oacute;n ăn nhanh, g&agrave;, thịt v&agrave; nhiều m&oacute;n kh&aacute;c, tất cả đều được chế biến với thời gian v&agrave; nhiệt độ ph&ugrave; hợp để cho kết quả tốt nh ất!</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-3-News/0HHPZuq2v1U3LGz.jpg" /></p>

<p><strong>Thiết kế độc đ&aacute;o cho ph&eacute;p nấu ăn ngon miệng v&agrave; &iacute;t chất b&eacute;o</strong></p>

<p>&nbsp;</p>

<p>Nồi chi&ecirc;n ch&acirc;n kh&ocirc;ng Philips HD9216 thiết kế độc đ&aacute;o của Philips Airfryer kết hợp luồng kh&iacute; được l&agrave;m n&oacute;ng rất cao lưu th&ocirc;ng nhanh, thiết kế h&igrave;nh sao v&agrave; cấu h&igrave;nh l&agrave;m n&oacute;ng tối ưu cho ph&eacute;p bạn r&aacute;n nhiều m&oacute;n ăn ngon miệng kh&aacute;c nhau theo c&aacute;ch nhanh ch&oacute;ng, dễ d&agrave;ng v&agrave; l&agrave;nh mạnh cho sức khỏe m&agrave; kh&ocirc;ng cần th&ecirc;m dầu.</p>

<p><strong>Dễ vệ sinh v&agrave; tạo &iacute;t m&ugrave;i hơn so với nồi chi&ecirc;n th&ocirc;ng thường</strong></p>

<p>Ngăn k&eacute;o ra phủ lớp chống d&iacute;nh c&oacute; thể th&aacute;o rời v&agrave; giỏ thức ăn c&oacute; thể rửa được bằng m&aacute;y rửa ch&eacute;n, gi&uacute;p vệ sinh nhanh ch&oacute;ng v&agrave; dễ d&agrave;ng. Philips Airfryer với c&ocirc;ng nghệ Rapid Air gi&uacute;p bạn v&agrave; gia đ&igrave;nh tr&aacute;nh được m&ugrave;i dầu r&aacute;n so với nồi chi&ecirc;n th&ocirc;ng thường.</p>
', N'-92o6kY.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (25, 3, 6, N'Nồi chiên không dầu Philips HD9220 2.2L', N'noi-chien-khong-dau-philips-hd9220-22l', 2390000.0000, N' HD9220', 61, 12, N'Trung Quốc', 0, N'Dùng công nghệ Rapid Air có thể rán, nướng, quay thực phẩm không cần dầu.Có thể điều chỉnh nhiệt độ đến 200 độ C, hẹn giờ nấu đến 30 phút tiện dụng.Công suất cao 1425 W cho hiệu quả nấu ăn nhanh.', N'<h3>Thiết kế tinh tế</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Philips HD9220 sở hữu m&agrave;u đen&nbsp;trang nh&atilde; với chất liệu vỏ nhựa cao cấp chắc chắn, l&agrave;m t&ocirc;n th&ecirc;m sự tinh tế của gian bếp nh&agrave; bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/Untitled(12).png" /></p>

<h3>C&agrave;i đặt dễ d&agrave;ng</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/philips/" target="_blank">Nồi chi&ecirc;n kh&ocirc;ng dầu Philips</a>&nbsp;c&oacute; khả năng c&agrave;i đặt nhiệt độ l&ecirc;n đến 200 độ v&agrave; thời gian hẹn giờ tối đa 30 ph&uacute;t cho bạn lựa chọn chủ động trong c&ocirc;ng việc nấu nướng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2018-8-News/A97Bs67G3Ry26n5.jpg" /></p>

<h3>Chi&ecirc;n kh&ocirc;ng dầu</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/" target="_blank">Nồi chi&ecirc;n kh&ocirc;ng dầu</a>&nbsp;sử dụng c&ocirc;ng nghệ Rapid Air, d&ugrave;ng d&ograve;ng kh&iacute; n&oacute;ng l&ecirc;n đến 200 độ C đối lưu nhanh v&agrave; mạnh xung quanh thực phẩm để chi&ecirc;n gi&ograve;n đều bằng kh&ocirc;ng kh&iacute; m&agrave; kh&ocirc;ng cần dầu mỡ.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/ba7f5ea4-864f-48b2-9801-bd944201ebb4.jpg" /></p>

<h3>An to&agrave;n khi sử dụng</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/philips/noi-chien-chan-khong-philips-hd9220.htm" target="_blank">Philips HD9220</a>&nbsp;c&oacute; chức năng tự ngắt điện khi chi&ecirc;n xong gi&uacute;p bạn y&ecirc;n t&acirc;m khi sử dụng, kh&ocirc;ng cần lo những sự cố về điện.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2018-8-News/6m4D3ZPp6rLv6tK.jpg" /></p>
', N'-7387Po.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (26, 3, 6, N'Nồi chiên không dầu Philips HD9218', N'noi-chien-khong-dau-philips-hd9218', 2790000.0000, N'HD9218', 73, 12, N'Trung Quốc', 0, N'Dung tích 3 lít, Công suất 1425W nấu nhanh hơn so với lò nướng thườngVới Airfryer bạn có thể rán, quay, nướng và thậm chí là nướng bánhĐiều khiển thời gian và nhiệt độ có thể điều chỉnh theo cách thủ côngRán có lợi cho sức khỏe với công nghệ Rapid Air', N'<h3>Thiết kế tinh tế</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Philips HD9220 sở hữu m&agrave;u đen&nbsp;trang nh&atilde; với chất liệu vỏ nhựa cao cấp chắc chắn, l&agrave;m t&ocirc;n th&ecirc;m sự tinh tế của gian bếp nh&agrave; bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/Untitled(12).png" /></p>

<h3>C&agrave;i đặt dễ d&agrave;ng</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/philips/" target="_blank">Nồi chi&ecirc;n kh&ocirc;ng dầu Philips</a>&nbsp;c&oacute; khả năng c&agrave;i đặt nhiệt độ l&ecirc;n đến 200 độ v&agrave; thời gian hẹn giờ tối đa 30 ph&uacute;t cho bạn lựa chọn chủ động trong c&ocirc;ng việc nấu nướng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2018-8-News/A97Bs67G3Ry26n5.jpg" /></p>

<h3>Chi&ecirc;n kh&ocirc;ng dầu</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/" target="_blank">Nồi chi&ecirc;n kh&ocirc;ng dầu</a>&nbsp;sử dụng c&ocirc;ng nghệ Rapid Air, d&ugrave;ng d&ograve;ng kh&iacute; n&oacute;ng l&ecirc;n đến 200 độ C đối lưu nhanh v&agrave; mạnh xung quanh thực phẩm để chi&ecirc;n gi&ograve;n đều bằng kh&ocirc;ng kh&iacute; m&agrave; kh&ocirc;ng cần dầu mỡ.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/ba7f5ea4-864f-48b2-9801-bd944201ebb4.jpg" /></p>

<h3>An to&agrave;n khi sử dụng</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/philips/noi-chien-chan-khong-philips-hd9220.htm" target="_blank">Philips HD9220</a>&nbsp;c&oacute; chức năng tự ngắt điện khi chi&ecirc;n xong gi&uacute;p bạn y&ecirc;n t&acirc;m khi sử dụng, kh&ocirc;ng cần lo những sự cố về điện.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2018-8-News/6m4D3ZPp6rLv6tK.jpg" /></p>
', N'noi-chien-khong-dau-philips-hd9218-0a608i.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (27, 3, 6, N'Nồi chiên không dầu Philips HD9650/91', N'noi-chien-khong-dau-philips-hd965091', 69909000.0000, N'HD9650/91', 34, 12, N'Trung Quốc', 13, N'Dùng chiên, nướng thực phẩm nhanh chóng với công suất 2200 W.Giảm đến 90% lượng chất béo trong thực phẩm nhờ công nghệ chiên không dầu Radpid Twin Turbo Star hiện đại.', N'<h3>M&oacute;n ăn từ nồi chi&ecirc;n kh&ocirc;ng dầu ch&iacute;n ngon chuẩn vị</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Philips HD9650/91 sở hữu c&ocirc;ng nghệ TurboStar với luồng nhiệt được truyền mạnh mẽ, ổn định gi&uacute;p bạn tiết kiệm c&ocirc;ng sức, kh&ocirc;ng phải lật trở nhiều ngay cả khi thức ăn chất chồng l&ecirc;n nhau, để thức ăn đạt được độ &quot;gi&ograve;n b&ecirc;n ngo&agrave;i, mềm b&ecirc;n trong&quot;.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-4857f3.jpg" /></p>

<h3>Thiết kế nhỏ gọn, hiện đại</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/philips/" target="_blank">Nồi chi&ecirc;n kh&ocirc;ng dầu Philips</a>&nbsp;sở hữu thiết kế h&igrave;nh sao nhỏ gọn, đẹp mắt c&ugrave;ng với m&agrave;u đen b&oacute;ng sang trọng, t&ocirc;n l&ecirc;n vẻ đẹp, hiện đại cho căn bếp của gia đ&igrave;nh bạn. C&ocirc;ng nghệ chi&ecirc;n nướng kh&ocirc;ng cần dầu mang đến những m&oacute;n ăn tốt cho sức khỏe của cả gia đ&igrave;nh bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-NJuofy.jpg" /></p>

<h3>An to&agrave;n tuyệt đối</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/" target="_blank">Nồi chi&ecirc;n kh&ocirc;ng dầu</a>&nbsp;c&oacute; vỏ m&aacute;y m&aacute;t, ch&acirc;n đế chống trượt mang lại sự an to&agrave;n tuyệt đối cho người sử dụng. B&ecirc;n cạnh đ&oacute; c&ograve;n c&oacute; chế độ tự động ngắt khi đ&atilde; nấu xong gi&uacute;p m&oacute;n ăn ngon chuẩn vị m&agrave; kh&ocirc;ng phải mất thời gian để canh chừng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-vp8zVj.jpg" /></p>

<h3>Chế độ nấu đa dạng</h3>

<p>Nồi Philips&nbsp;với 5 chế độ nấu nướng được thiết lập sẵn k&egrave;m theo c&ocirc;ng thức chế biến của hơn 30 m&oacute;n ăn gi&uacute;p bữa ăn của gia đ&igrave;nh bạn trở n&ecirc;n phong ph&uacute; hơn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-GWWsnY.jpg" /></p>

<h3>C&ocirc;ng suất họat động lớn</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu&nbsp;Philips với c&ocirc;ng suất hoạt động l&ecirc;n đến 2200W, gi&uacute;p bạn&nbsp;sử dụng ngay lập tức sau khi khởi động v&agrave; duy tr&igrave; vận tốc cao tr&ecirc;n to&agrave;n bộ qu&aacute; tr&igrave;nh nấu nướng, th&iacute;ch hợp cho nhu cầu sử dụng mỗi ng&agrave;y.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-Ymg829.jpg" /></p>

<h3>Chống d&iacute;nh hiệu quả</h3>

<p>Nồi chi&ecirc;n Philips HD9650 trang bị giỏ Quickclean với dạng lưới được l&agrave;m bằng chất liệu chống d&iacute;nh, c&oacute; thể th&aacute;o rời, gi&uacute;p bạn vệ sinh thật dễ d&agrave;ng v&agrave; nhanh ch&oacute;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-Xo96ea.jpg" /></p>

<h3>Dung t&iacute;ch XXL</h3>

<p>Nồi chi&ecirc;n Philips HD9650 c&oacute; dung t&iacute;ch l&ecirc;n đến 1.4kg, c&oacute; thể quay hẳn 1 c&ograve;n g&agrave; hoặc chi&ecirc;n khoai t&acirc;y cho 6 người ăn. M&agrave;n h&igrave;nh điện tử trực quan c&ugrave;ng 5 chế độ nấu ăn c&agrave;i đặt sẵn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-UqI9Fk.jpg" /></p>
', N'noi-chien-khong-dau-philips-hd965091-74mbPo.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (28, 3, 6, N'Nồi chiên không dầu Philips HD9745/90', N'noi-chien-khong-dau-philips-hd974590', 4990000.0000, N'HD9745/90', 64, 12, N'Trung Quốc', 10, N'Dung tích 3 lít, Công suất 1500W nhanh hơn 1,5 lần so với lò nướng thườngCông nghệ Rapid Air cho món ăn giòn rụm và thơm ngon hơnCông nghệ Loại bỏ chất béo giúp tách và thu gom chất béo dư thừaChiên rán, nướng, quay hoặc hâm nóng thức ăn', N'<h3>M&oacute;n ăn từ nồi chi&ecirc;n kh&ocirc;ng dầu ch&iacute;n ngon chuẩn vị</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu Philips HD9650/91 sở hữu c&ocirc;ng nghệ TurboStar với luồng nhiệt được truyền mạnh mẽ, ổn định gi&uacute;p bạn tiết kiệm c&ocirc;ng sức, kh&ocirc;ng phải lật trở nhiều ngay cả khi thức ăn chất chồng l&ecirc;n nhau, để thức ăn đạt được độ &quot;gi&ograve;n b&ecirc;n ngo&agrave;i, mềm b&ecirc;n trong&quot;.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-4857f3.jpg" /></p>

<h3>Thiết kế nhỏ gọn, hiện đại</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/philips/" target="_blank">Nồi chi&ecirc;n kh&ocirc;ng dầu Philips</a>&nbsp;sở hữu thiết kế h&igrave;nh sao nhỏ gọn, đẹp mắt c&ugrave;ng với m&agrave;u đen b&oacute;ng sang trọng, t&ocirc;n l&ecirc;n vẻ đẹp, hiện đại cho căn bếp của gia đ&igrave;nh bạn. C&ocirc;ng nghệ chi&ecirc;n nướng kh&ocirc;ng cần dầu mang đến những m&oacute;n ăn tốt cho sức khỏe của cả gia đ&igrave;nh bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-NJuofy.jpg" /></p>

<h3>An to&agrave;n tuyệt đối</h3>

<p><a href="https://mediamart.vn/noi-chien-khong-dau/" target="_blank">Nồi chi&ecirc;n kh&ocirc;ng dầu</a>&nbsp;c&oacute; vỏ m&aacute;y m&aacute;t, ch&acirc;n đế chống trượt mang lại sự an to&agrave;n tuyệt đối cho người sử dụng. B&ecirc;n cạnh đ&oacute; c&ograve;n c&oacute; chế độ tự động ngắt khi đ&atilde; nấu xong gi&uacute;p m&oacute;n ăn ngon chuẩn vị m&agrave; kh&ocirc;ng phải mất thời gian để canh chừng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-vp8zVj.jpg" /></p>

<h3>Chế độ nấu đa dạng</h3>

<p>Nồi Philips&nbsp;với 5 chế độ nấu nướng được thiết lập sẵn k&egrave;m theo c&ocirc;ng thức chế biến của hơn 30 m&oacute;n ăn gi&uacute;p bữa ăn của gia đ&igrave;nh bạn trở n&ecirc;n phong ph&uacute; hơn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-GWWsnY.jpg" /></p>

<h3>C&ocirc;ng suất họat động lớn</h3>

<p>Nồi chi&ecirc;n kh&ocirc;ng dầu&nbsp;Philips với c&ocirc;ng suất hoạt động l&ecirc;n đến 2200W, gi&uacute;p bạn&nbsp;sử dụng ngay lập tức sau khi khởi động v&agrave; duy tr&igrave; vận tốc cao tr&ecirc;n to&agrave;n bộ qu&aacute; tr&igrave;nh nấu nướng, th&iacute;ch hợp cho nhu cầu sử dụng mỗi ng&agrave;y.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-Ymg829.jpg" /></p>

<h3>Chống d&iacute;nh hiệu quả</h3>

<p>Nồi chi&ecirc;n Philips HD9650 trang bị giỏ Quickclean với dạng lưới được l&agrave;m bằng chất liệu chống d&iacute;nh, c&oacute; thể th&aacute;o rời, gi&uacute;p bạn vệ sinh thật dễ d&agrave;ng v&agrave; nhanh ch&oacute;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-Xo96ea.jpg" /></p>

<h3>Dung t&iacute;ch XXL</h3>

<p>Nồi chi&ecirc;n Philips HD9650 c&oacute; dung t&iacute;ch l&ecirc;n đến 1.4kg, c&oacute; thể quay hẳn 1 c&ograve;n g&agrave; hoặc chi&ecirc;n khoai t&acirc;y cho 6 người ăn. M&agrave;n h&igrave;nh điện tử trực quan c&ugrave;ng 5 chế độ nấu ăn c&agrave;i đặt sẵn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-10/jkl-UqI9Fk.jpg" /></p>
', N'noi-chien-khong-dau-philips-hd9745-PqKe6a.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (29, 4, 3, N'Loa Soundbar Samsung HW-Q600A/XV', N'loa-soundbar-samsung-hw-q600axv', 6643000.0000, N'HW-Q600A/XV', 28, 12, N'Việt Nam', 0, N'Âm Thanh 2.1ch Chân ThựcÂm thanh vòm 3DTinh Chỉnh Âm Thanh Vượt TrộiĐiều Khiển Thông Minh One Remote', N'<p><strong>Kiểu d&aacute;ng đơn giản, chắc chắn</strong><br />
Trong khi loa thanh c&oacute; dạng thanh d&agrave;i đồng nhất th&igrave; loa Subwoofer h&igrave;nh hộp gọn g&agrave;ng, tinh tế,&nbsp;m&agrave;u đen lịch l&atilde;m, tạo điểm nhấn cho kh&ocirc;ng gian ph&ograve;ng họp, ph&ograve;ng kh&aacute;ch trong gia đ&igrave;nh, c&ocirc;ng ty.<br />
C&aacute;ch bố tr&iacute; bộ&nbsp;loa thanh Samsung&nbsp;t&ugrave;y theo thẩm mỹ v&agrave; thiết kế nội thất kh&aacute;c nhau, bạn c&oacute; thể đặt cả loa thanh v&agrave; loa&nbsp;Subwoofer tr&ecirc;n kệ hoặc loa thanh tr&ecirc;n kệ/treo tường c&ograve;n loa&nbsp;Subwoofer để s&agrave;n.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-t6Cf4A.jpg" /></p>

<p><strong>Trải nghiệm &acirc;m thanh vang dội, cuốn h&uacute;t c&ugrave;ng loa 2.1 k&ecirc;nh, c&ocirc;ng suất 410 W</strong><br />
C&aacute;c dải &acirc;m được t&aacute;i hiện t&aacute;ch bạch, r&otilde; r&agrave;ng, đặc biệt với&nbsp;loa&nbsp;Subwoofer 6.5 inch&nbsp;hỗ trợ th&ecirc;m chế độ&nbsp;Bass Boost&nbsp;n&acirc;ng cao dải &acirc;m trầm&nbsp;cho bạn nghe c&aacute;c bản nhạc Rock, EDM cực kỳ đ&atilde; tai, &acirc;m sắc cho độ rung cảm m&atilde;nh liệt.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-7634Ax.jpg" /></p>

<p><strong>Trải nghiệm &acirc;m thanh 3D sống động nhờ c&ocirc;ng nghệ&nbsp;Dolby Audio/DTS Virtual:X</strong><br />
Dolby Audio/DTS Virtual:X t&aacute;i tạo chất &acirc;m ch&acirc;n thật&nbsp;cho bạn nghe r&otilde; được từng sắc &acirc;m, cảm nhận độ s&acirc;u của &acirc;m thanh, n&acirc;ng cao trải nghiệm &acirc;m nhạc.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-a5NmL5.jpg" /></p>

<p><strong>&Acirc;m thanh đa chiều lan tỏa rộng với chế độ Surround Sound Expansion</strong><br />
Loa thanh&nbsp;mang đến&nbsp;&acirc;m thanh v&ograve;m mở rộng&nbsp;bao tr&ugrave;m kh&ocirc;ng gian, cho cảm gi&aacute;c như ở quanh bạn.&nbsp;<br />
Chế độ&nbsp;Adaptive Sound Lite&nbsp;ph&acirc;n t&iacute;ch nội dung đang ph&aacute;t ra tr&ecirc;n tivi, chỉnh &acirc;m thanh tương th&iacute;ch để bạn nghe được cuộc hội thoại, lời ca, giọng b&igrave;nh luận vi&ecirc;n,... chi tiết, tăng th&ecirc;m sự hấp dẫn, l&ocirc;i cuốn khi giải tr&iacute;.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-UGHBMT.jpg" /></p>

<p><strong>&Acirc;m thanh ph&ugrave; hợp với từng m&agrave;n game qua chế độ Game Mode</strong><br />
Ngo&agrave;i khả năng tối ưu &acirc;m thanh theo m&agrave;n game th&igrave; chế độ n&agrave;y c&ograve;n&nbsp;khử nhiễu xuy&ecirc;n &acirc;m, loại bỏ c&aacute;c &acirc;m thanh g&acirc;y xao nh&atilde;ng, tạo hiệu ứng gi&uacute;p bạn nắm bắt chuẩn x&aacute;c c&aacute;c &acirc;m thanh trong tr&ograve; game, chiến game phấn kh&iacute;ch, h&agrave;o hứng hơn.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-AY1W8w.jpg" /></p>

<p><strong>Sử dụng linh hoạt, điều khiển từ xa m&agrave; kh&ocirc;ng cần lại gần loa với&nbsp;One Remote Control&nbsp;đi k&egrave;m</strong></p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-96Z6Ho.jpg" /></p>

<p><strong>Kết nối&nbsp;loa&nbsp;với tivi, điện thoại, m&aacute;y t&iacute;nh bảng,... mượt m&agrave; c&ugrave;ng Bluetooth&nbsp;</strong><br />
Đường truyền chất lượng cao, đảm bảo t&iacute;n hiệu liền mạch, bạn c&oacute; thể tận hưởng danh s&aacute;ch b&agrave;i h&aacute;t y&ecirc;u th&iacute;ch cả ng&agrave;y c&ugrave;ng&nbsp;Samsung HW-A550.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-XuPZ7L.jpg" /></p>

<p><strong>Trang bị nhiều kết nối tiện &iacute;ch</strong><br />
C&oacute; kết nối kh&ocirc;ng d&acirc;y&nbsp;Bluetooth, cổng&nbsp;USB, HDMI, HDMI-ARC,&nbsp;Optical gh&eacute;p nối loa với tivi, đầu đĩa, điện thoại,... dễ d&agrave;ng, cho bạn l&agrave;m việc, giải tr&iacute; th&ecirc;m tiện lợi.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-9tARpR.jpg" /></p>

<p>Loa thanh Samsung HW-A550, thiết bị &acirc;m thanh hiện đại t&aacute;i tạo thế giới &acirc;m thanh đầy sắc m&agrave;u cho bạn thưởng thức phim ảnh, nghe nhạc tuyệt vời hơn.</p>
', N'-00BMt7.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (30, 4, 3, N'Loa Soundbar Samsung HW-Q950A/XV', N'loa-soundbar-samsung-hw-q950axv', 24990000.0000, N'HW-Q950A/XV', 46, 12, N'Việt Nam', 13, N'Thưởng thức sắc âm chuẩn 11.1.4CHSống động bộ Loa Vệ Tinh Không DâyÂm thanh vòm 3D cải tiến, bao trùm mọi giác quanTính năng Adaptive Sound tự động cân chỉnh âm thanh', N'<p><strong>Kiểu d&aacute;ng đơn giản, chắc chắn</strong><br />
Trong khi loa thanh c&oacute; dạng thanh d&agrave;i đồng nhất th&igrave; loa Subwoofer h&igrave;nh hộp gọn g&agrave;ng, tinh tế,&nbsp;m&agrave;u đen lịch l&atilde;m, tạo điểm nhấn cho kh&ocirc;ng gian ph&ograve;ng họp, ph&ograve;ng kh&aacute;ch trong gia đ&igrave;nh, c&ocirc;ng ty.<br />
C&aacute;ch bố tr&iacute; bộ&nbsp;loa thanh Samsung&nbsp;t&ugrave;y theo thẩm mỹ v&agrave; thiết kế nội thất kh&aacute;c nhau, bạn c&oacute; thể đặt cả loa thanh v&agrave; loa&nbsp;Subwoofer tr&ecirc;n kệ hoặc loa thanh tr&ecirc;n kệ/treo tường c&ograve;n loa&nbsp;Subwoofer để s&agrave;n.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-t6Cf4A.jpg" /></p>

<p><strong>Trải nghiệm &acirc;m thanh vang dội, cuốn h&uacute;t c&ugrave;ng loa 2.1 k&ecirc;nh, c&ocirc;ng suất 410 W</strong><br />
C&aacute;c dải &acirc;m được t&aacute;i hiện t&aacute;ch bạch, r&otilde; r&agrave;ng, đặc biệt với&nbsp;loa&nbsp;Subwoofer 6.5 inch&nbsp;hỗ trợ th&ecirc;m chế độ&nbsp;Bass Boost&nbsp;n&acirc;ng cao dải &acirc;m trầm&nbsp;cho bạn nghe c&aacute;c bản nhạc Rock, EDM cực kỳ đ&atilde; tai, &acirc;m sắc cho độ rung cảm m&atilde;nh liệt.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-7634Ax.jpg" /></p>

<p><strong>Trải nghiệm &acirc;m thanh 3D sống động nhờ c&ocirc;ng nghệ&nbsp;Dolby Audio/DTS Virtual:X</strong><br />
Dolby Audio/DTS Virtual:X t&aacute;i tạo chất &acirc;m ch&acirc;n thật&nbsp;cho bạn nghe r&otilde; được từng sắc &acirc;m, cảm nhận độ s&acirc;u của &acirc;m thanh, n&acirc;ng cao trải nghiệm &acirc;m nhạc.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-a5NmL5.jpg" /></p>

<p><strong>&Acirc;m thanh đa chiều lan tỏa rộng với chế độ Surround Sound Expansion</strong><br />
Loa thanh&nbsp;mang đến&nbsp;&acirc;m thanh v&ograve;m mở rộng&nbsp;bao tr&ugrave;m kh&ocirc;ng gian, cho cảm gi&aacute;c như ở quanh bạn.&nbsp;<br />
Chế độ&nbsp;Adaptive Sound Lite&nbsp;ph&acirc;n t&iacute;ch nội dung đang ph&aacute;t ra tr&ecirc;n tivi, chỉnh &acirc;m thanh tương th&iacute;ch để bạn nghe được cuộc hội thoại, lời ca, giọng b&igrave;nh luận vi&ecirc;n,... chi tiết, tăng th&ecirc;m sự hấp dẫn, l&ocirc;i cuốn khi giải tr&iacute;.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-UGHBMT.jpg" /></p>

<p><strong>&Acirc;m thanh ph&ugrave; hợp với từng m&agrave;n game qua chế độ Game Mode</strong><br />
Ngo&agrave;i khả năng tối ưu &acirc;m thanh theo m&agrave;n game th&igrave; chế độ n&agrave;y c&ograve;n&nbsp;khử nhiễu xuy&ecirc;n &acirc;m, loại bỏ c&aacute;c &acirc;m thanh g&acirc;y xao nh&atilde;ng, tạo hiệu ứng gi&uacute;p bạn nắm bắt chuẩn x&aacute;c c&aacute;c &acirc;m thanh trong tr&ograve; game, chiến game phấn kh&iacute;ch, h&agrave;o hứng hơn.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-AY1W8w.jpg" /></p>

<p><strong>Sử dụng linh hoạt, điều khiển từ xa m&agrave; kh&ocirc;ng cần lại gần loa với&nbsp;One Remote Control&nbsp;đi k&egrave;m</strong></p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-96Z6Ho.jpg" /></p>

<p><strong>Kết nối&nbsp;loa&nbsp;với tivi, điện thoại, m&aacute;y t&iacute;nh bảng,... mượt m&agrave; c&ugrave;ng Bluetooth&nbsp;</strong><br />
Đường truyền chất lượng cao, đảm bảo t&iacute;n hiệu liền mạch, bạn c&oacute; thể tận hưởng danh s&aacute;ch b&agrave;i h&aacute;t y&ecirc;u th&iacute;ch cả ng&agrave;y c&ugrave;ng&nbsp;Samsung HW-A550.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-XuPZ7L.jpg" /></p>

<p><strong>Trang bị nhiều kết nối tiện &iacute;ch</strong><br />
C&oacute; kết nối kh&ocirc;ng d&acirc;y&nbsp;Bluetooth, cổng&nbsp;USB, HDMI, HDMI-ARC,&nbsp;Optical gh&eacute;p nối loa với tivi, đầu đĩa, điện thoại,... dễ d&agrave;ng, cho bạn l&agrave;m việc, giải tr&iacute; th&ecirc;m tiện lợi.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-9tARpR.jpg" /></p>

<p>Loa thanh Samsung HW-A550, thiết bị &acirc;m thanh hiện đại t&aacute;i tạo thế giới &acirc;m thanh đầy sắc m&agrave;u cho bạn thưởng thức phim ảnh, nghe nhạc tuyệt vời hơn.</p>
', N'loa-soundbar-samsung-hwq950axv-X3aY50.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (31, 4, 3, N'Smart Tivi Samsung 4K 43 inch 43AU8000 Crystal UHD', N'smart-tivi-samsung-4k-43-inch-43au8000-crystal-uhd', 18900000.0000, N'UA43AU8000KXXV', 94, 12, N'Việt Nam', 0, N'Tận hưởng màu sắc chân thực nhờ công nghệ Dynamic Crystal 4KDynamic Crystal Color đắm mình vào khung hìnhDễ dàng tìm kiếm nội dung nhờ Trợ lý ảo GoogleMulti View xem nhiều nội dung trên một khung hình', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(845).jpg" /></p>

<h3>T&ocirc;ng m&agrave;u đ&egrave;n nền được tối ưu h&oacute;a để tăng độ tương phản</h3>

<p><strong>Dual LED&nbsp;</strong>-&nbsp;C&ocirc;ng nghệ đ&egrave;n nền cải tiến mang lại độ tương phản r&otilde; n&eacute;t v&agrave; ch&iacute;nh x&aacute;c hơn bằng c&aacute;ch tối ưu h&oacute;a t&ocirc;ng m&agrave;u đ&egrave;n nền để ph&ugrave; hợp với loại nội dung đang xem.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-optimized-backlight-color-tone-for-enhanced-contrast-379601282.gif" /></p>

<h3>Độ tương phản rộng hơn</h3>

<p><strong>Quantum HDR&nbsp;</strong>-&nbsp;Quantum HDR tr&ecirc;n&nbsp;<a href="http://tivi-samsung/" target="_blank">tivi Samsung</a>&nbsp;n&agrave;y mang lại độ chi tiết v&agrave; độ tương phản, v&igrave; vậy bạn c&oacute; thể trải nghiệm to&agrave;n bộ sức mạnh của mọi h&igrave;nh ảnh.&nbsp;Vượt xa c&aacute;c ti&ecirc;u chuẩn h&agrave;ng đầu, &aacute;nh xạ t&ocirc;ng m&agrave;u động của HDR10 + tạo ra m&agrave;u đen s&acirc;u hơn, h&igrave;nh ảnh sống động hơn v&agrave; chi tiết lu&ocirc;n tỏa s&aacute;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(976).jpg" /></p>

<h3>Bộ xử l&yacute; 4K th&ocirc;ng minh hơn, nhanh hơn</h3>

<p><strong>Bộ xử l&yacute; Quantum Processor 4K Lite&nbsp;</strong>-&nbsp;Bộ vi xử l&yacute; mạnh mẽ của Samsung tối ưu h&oacute;a chất lượng &acirc;m thanh theo nội dung xem.&nbsp;Ngo&agrave;i ra, c&ocirc;ng nghệ n&acirc;ng cấp 4K mạnh mẽ đảm bảo bạn c&oacute; được độ ph&acirc;n giải l&ecirc;n đến 4K cho nội dung bạn y&ecirc;u th&iacute;ch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(742).jpg" /></p>

<h3>&Acirc;m thanh v&ograve;m 3D&nbsp;theo&nbsp;h&agrave;nh động h&igrave;nh ảnh</h3>

<p><strong>Object Tracking Sound Lite (OTS Lite)</strong>&nbsp;- &Acirc;m thanh v&ograve;m 3D với &acirc;m thanh k&ecirc;nh h&agrave;ng đầu ảo của ch&uacute;ng t&ocirc;i sẽ cho ph&eacute;p bạn ho&agrave;n to&agrave;n đắm ch&igrave;m trong trải nghiệm &acirc;m thanh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(743).jpg" /></p>

<h3>TV v&agrave; soundbar được sắp xếp h&agrave;i h&ograve;a ho&agrave;n hảo</h3>

<p><strong>Q-Symphony -&nbsp;</strong>Đắm m&igrave;nh với &acirc;m thanh từ cả loa TV v&agrave; loa soundbar của bạn, được đồng bộ h&oacute;a trong sự h&agrave;i h&ograve;a ho&agrave;n hảo để mang đến &acirc;m thanh phong ph&uacute;, tr&agrave;n ngập khắp căn ph&ograve;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/8(150).jpg" /></p>

<h3>&Acirc;m thanh được tinh chỉnh ph&ugrave; hợp với nội dung của bạn</h3>

<p><strong>&Acirc;m thanh th&iacute;ch ứng</strong>&nbsp;-&nbsp;&Acirc;m thanh tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=qled-tv" target="_blank">QLED TV Samsung</a>&nbsp;th&iacute;ch ứng c&oacute; t&iacute;nh năng th&ocirc;ng minh cảnh quan &acirc;m thanh gi&uacute;p tối ưu h&oacute;a &acirc;m thanh dựa tr&ecirc;n ph&acirc;n t&iacute;ch cảnh thời gian thực theo loại nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(620).jpg" /></p>

<h3>Kiểu d&aacute;ng đẹp v&agrave; mỏng, hơn bao giờ hết</h3>

<p><strong>AirSlim</strong>&nbsp;- Thiết kế mỏng đầy ấn tượng m&agrave; bạn chưa từng thấy trước đ&acirc;y trong danh mục n&agrave;y, gi&uacute;p TV của bạn h&ograve;a v&agrave;o tường một c&aacute;ch liền mạch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(700).jpg" /></p>

<h3>To&agrave;n&nbsp;cảnh thay đổi tr&ograve; chơi</h3>

<p><strong>GameView &amp; Game Bar Super Ultrawide -&nbsp;</strong>Mở rộng tầm nh&igrave;n của bạn với khả năng thay đổi linh hoạt giữa nhiều tỷ lệ khung h&igrave;nh từ 21: 9 đến 32: 9 v&agrave; điều chỉnh vị tr&iacute; m&agrave;n h&igrave;nh ngang tầm mắt của bạn để c&oacute; trải nghiệm lớn hơn, tốt hơn.&nbsp;Tối ưu h&oacute;a c&aacute;ch chơi của bạn với Game Bar, một menu tr&ecirc;n m&agrave;n h&igrave;nh cho ph&eacute;p bạn điều chỉnh tỷ lệ m&agrave;n h&igrave;nh theo thời gian thực, kiểm tra độ trễ đầu v&agrave;o, FPS, HDR, c&agrave;i đặt tai nghe kh&ocirc;ng d&acirc;y, v.v.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(730).jpg" /></p>

<h3>Chuyển động mượt m&agrave; cho h&igrave;nh ảnh r&otilde; n&eacute;t</h3>

<p><strong>Motion Xcelerator</strong>&nbsp;- Trải nghiệm h&igrave;nh ảnh v&agrave; hiệu suất r&otilde; r&agrave;ng v&igrave; n&oacute; tự động ước t&iacute;nh v&agrave; b&ugrave; đắp khung h&igrave;nh cho nguồn nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(410).jpg" /></p>

<h3>L&agrave;m việc v&agrave; học tập tại&nbsp;nh&agrave;</h3>

<p><strong>PC tr&ecirc;n TV</strong>&nbsp;- Tận hưởng mọi khả năng của những g&igrave; bạn c&oacute; thể l&agrave;m.&nbsp;Dễ d&agrave;ng truy cập li&ecirc;n tục PC, Laptop v&agrave; thiết bị di động tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=smart-tv" target="_blank">Smart Tivi Samsung</a>&nbsp;của bạn.</p>

<p>* Kết nối từ xa với PC chỉ được hỗ trợ cho Windows 10 Professional trở l&ecirc;n v&agrave; Mac OS 10.5 trở l&ecirc;n.<br />
* Kết nối điện thoại th&ocirc;ng minh với Samsung Dex y&ecirc;u cầu một thiết bị di động tương th&iacute;ch.<br />
* T&iacute;nh khả dụng của c&aacute;c dịch vụ c&oacute; thể thay đổi m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước.<br />
* Cần c&oacute; kết nối Internet tr&ecirc;n TV v&agrave; PC.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/7(221).jpg" /></p>

<h3>Phản ứng tức th&igrave; với lệnh của bạn</h3>

<p><strong>Chế độ độ trễ thấp tự động</strong>&nbsp;- Tham gia tr&ograve; chơi nhanh hơn với Chế độ độ trễ thấp tự động (ALLM), tối ưu h&oacute;a m&agrave;n h&igrave;nh của bạn để bạn c&oacute; nhiều quyền điều khiển hơn với độ trễ đầu v&agrave;o hầu như kh&ocirc;ng đ&aacute;ng kể.&nbsp;Trải nghiệm chơi game mượt m&agrave; ở h&igrave;nh thức ấn tượng nhất m&agrave; kh&ocirc;ng bị nh&ograve;e chuyển động v&agrave; rung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-instantly-reacts-to-your-commands-379601320.gif" /></p>

<h3>Chỉ cần nhấn để kết nối</h3>

<p><strong>Nhấn v&agrave;o Xem</strong>&nbsp;- Chiếu điện thoại của bạn l&ecirc;n TV chỉ bằng một lần nhấn để tiếp tục thưởng thức phim, nhạc v&agrave; ứng dụng tr&ecirc;n m&agrave;n h&igrave;nh lớn hơn trong v&ograve;ng v&agrave;i gi&acirc;y.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2021-2-News/s0iG4Crt96dwzdk.jpg" /></p>

<h3>Xem tất cả tr&ecirc;n một m&agrave;n h&igrave;nh</h3>

<p><strong>Nhiều chế độ xem&nbsp;MultiView,&nbsp;TapView</strong>&nbsp;-&nbsp;Xem nội dung tr&ecirc;n TV v&agrave; điện thoại di động của bạn tr&ecirc;n c&ugrave;ng một m&agrave;n h&igrave;nh c&ugrave;ng một l&uacute;c.&nbsp;Cho d&ugrave; đ&oacute; l&agrave; số liệu thống k&ecirc; trực tiếp về thể thao hay video hướng dẫn cho tr&ograve; chơi, chỉ cần kết nối điện thoại với nhiều m&agrave;n h&igrave;nh của bạn hơn bao giờ hết.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(849).jpg" /></p>

<h3>Chọn bất kỳ trợ l&yacute; giọng n&oacute;i n&agrave;o bạn đ&atilde; quen</h3>

<p><strong>Nhiều trợ l&yacute; giọng n&oacute;i</strong>&nbsp;- Chọn trợ l&yacute; giọng n&oacute;i y&ecirc;u th&iacute;ch của bạn;&nbsp;Bixby, Amazon Alexa hoặc Trợ l&yacute; Google.&nbsp;Lần đầu ti&ecirc;n, tất cả đều được t&iacute;ch hợp v&agrave;o TV Samsung của bạn để mang đến trải nghiệm giải tr&iacute; tối ưu v&agrave; khả năng điều khiển ti&ecirc;n tiến trong ng&ocirc;i nh&agrave; kết nối của bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(738).jpg" /></p>

<h3>Kiểm so&aacute;t thiết bị cũ v&agrave; mới</h3>

<p><strong>SmartThings&nbsp;</strong>-&nbsp;Cho ph&eacute;p&nbsp;<a href="https://mediamart.vn/tivi" target="_blank">TV</a>&nbsp;của bạn tự động ph&aacute;t hiện, kết nối ngay lập tức v&agrave; hiển thị trực quan tất cả c&aacute;c thiết bị xung quanh TV của bạn.&nbsp;Digital Butler kh&ocirc;ng chỉ hỗ trợ thiết bị di động / cam / IoT / Smart m&agrave; c&ograve;n bao gồm c&aacute;c thiết bị cũ.&nbsp;Bạn c&oacute; thể điều khiển thiết bị trực tiếp bằng remote hoặc giọng n&oacute;i khi xem TV.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(855).jpg" /></p>

<h3>Truyền h&igrave;nh&nbsp;miễn ph&iacute;</h3>

<p><strong>Samsung TV Plus -&nbsp;</strong>Thưởng thức h&agrave;ng ngh&igrave;n giờ xem TV, phim, thể thao miễn ph&iacute; với 150 k&ecirc;nh v&agrave; đang ph&aacute;t triển.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(404).jpg" /></p>

<h3>D&agrave;nh thời gian xem, kh&ocirc;ng phải t&igrave;m kiếm</h3>

<p>Đ&aacute;p ứng trải nghiệm duyệt web chuyển tiếp nội dung gi&uacute;p tăng tốc độ t&igrave;m kiếm nội dung cần xem tr&ecirc;n TV trực tiếp v&agrave; OTT.&nbsp;Giờ đ&acirc;y, thật dễ d&agrave;ng để t&igrave;m tất cả c&aacute;c bộ phim v&agrave; chương tr&igrave;nh truyền h&igrave;nh y&ecirc;u th&iacute;ch của bạn ở một nơi.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(617).jpg" /></p>

<h3>Chăm s&oacute;c sức khỏe tại nh&agrave;</h3>

<p><strong>Samsung Health</strong>&nbsp;-&nbsp;L&agrave;m chủ to&agrave;n bộ th&oacute;i quen chăm s&oacute;c sức khỏe cho t&acirc;m tr&iacute; v&agrave; cơ thể của bạn v&agrave; vượt qua c&aacute;c mục ti&ecirc;u của bạn với nội dung từ c&aacute;c đối t&aacute;c h&agrave;ng đầu trong ng&agrave;nh thể dục v&agrave; quản l&yacute; số liệu thống k&ecirc; h&agrave;ng ng&agrave;y của bạn từ ứng dụng Samsung Health.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(611).jpg" /></p>

<h3>Gallery:</h3>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(856).jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(744).jpg" /></p>
', N'-5pw465.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (32, 4, 3, N'Smart Tivi Samsung 4K 55 inch 55AU7700 UHD', N'smart-tivi-samsung-4k-55-inch-55au7700-uhd', 19900000.0000, N'UA55AU7700KXXV', 72, 24, N'Việt Nam', 10, N'Công Nghệ Motion Xcelerator cho khung hình rõ nétTái hiện sắc màu chân thực với công nghệ PurColorThưởng thức nội dung 4K chuẩn điện ảnh', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(845).jpg" /></p>

<h3>T&ocirc;ng m&agrave;u đ&egrave;n nền được tối ưu h&oacute;a để tăng độ tương phản</h3>

<p><strong>Dual LED&nbsp;</strong>-&nbsp;C&ocirc;ng nghệ đ&egrave;n nền cải tiến mang lại độ tương phản r&otilde; n&eacute;t v&agrave; ch&iacute;nh x&aacute;c hơn bằng c&aacute;ch tối ưu h&oacute;a t&ocirc;ng m&agrave;u đ&egrave;n nền để ph&ugrave; hợp với loại nội dung đang xem.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-optimized-backlight-color-tone-for-enhanced-contrast-379601282.gif" /></p>

<h3>Độ tương phản rộng hơn</h3>

<p><strong>Quantum HDR&nbsp;</strong>-&nbsp;Quantum HDR tr&ecirc;n&nbsp;<a href="http://tivi-samsung/" target="_blank">tivi Samsung</a>&nbsp;n&agrave;y mang lại độ chi tiết v&agrave; độ tương phản, v&igrave; vậy bạn c&oacute; thể trải nghiệm to&agrave;n bộ sức mạnh của mọi h&igrave;nh ảnh.&nbsp;Vượt xa c&aacute;c ti&ecirc;u chuẩn h&agrave;ng đầu, &aacute;nh xạ t&ocirc;ng m&agrave;u động của HDR10 + tạo ra m&agrave;u đen s&acirc;u hơn, h&igrave;nh ảnh sống động hơn v&agrave; chi tiết lu&ocirc;n tỏa s&aacute;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(976).jpg" /></p>

<h3>Bộ xử l&yacute; 4K th&ocirc;ng minh hơn, nhanh hơn</h3>

<p><strong>Bộ xử l&yacute; Quantum Processor 4K Lite&nbsp;</strong>-&nbsp;Bộ vi xử l&yacute; mạnh mẽ của Samsung tối ưu h&oacute;a chất lượng &acirc;m thanh theo nội dung xem.&nbsp;Ngo&agrave;i ra, c&ocirc;ng nghệ n&acirc;ng cấp 4K mạnh mẽ đảm bảo bạn c&oacute; được độ ph&acirc;n giải l&ecirc;n đến 4K cho nội dung bạn y&ecirc;u th&iacute;ch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(742).jpg" /></p>

<h3>&Acirc;m thanh v&ograve;m 3D&nbsp;theo&nbsp;h&agrave;nh động h&igrave;nh ảnh</h3>

<p><strong>Object Tracking Sound Lite (OTS Lite)</strong>&nbsp;- &Acirc;m thanh v&ograve;m 3D với &acirc;m thanh k&ecirc;nh h&agrave;ng đầu ảo của ch&uacute;ng t&ocirc;i sẽ cho ph&eacute;p bạn ho&agrave;n to&agrave;n đắm ch&igrave;m trong trải nghiệm &acirc;m thanh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(743).jpg" /></p>

<h3>TV v&agrave; soundbar được sắp xếp h&agrave;i h&ograve;a ho&agrave;n hảo</h3>

<p><strong>Q-Symphony -&nbsp;</strong>Đắm m&igrave;nh với &acirc;m thanh từ cả loa TV v&agrave; loa soundbar của bạn, được đồng bộ h&oacute;a trong sự h&agrave;i h&ograve;a ho&agrave;n hảo để mang đến &acirc;m thanh phong ph&uacute;, tr&agrave;n ngập khắp căn ph&ograve;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/8(150).jpg" /></p>

<h3>&Acirc;m thanh được tinh chỉnh ph&ugrave; hợp với nội dung của bạn</h3>

<p><strong>&Acirc;m thanh th&iacute;ch ứng</strong>&nbsp;-&nbsp;&Acirc;m thanh tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=qled-tv" target="_blank">QLED TV Samsung</a>&nbsp;th&iacute;ch ứng c&oacute; t&iacute;nh năng th&ocirc;ng minh cảnh quan &acirc;m thanh gi&uacute;p tối ưu h&oacute;a &acirc;m thanh dựa tr&ecirc;n ph&acirc;n t&iacute;ch cảnh thời gian thực theo loại nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(620).jpg" /></p>

<h3>Kiểu d&aacute;ng đẹp v&agrave; mỏng, hơn bao giờ hết</h3>

<p><strong>AirSlim</strong>&nbsp;- Thiết kế mỏng đầy ấn tượng m&agrave; bạn chưa từng thấy trước đ&acirc;y trong danh mục n&agrave;y, gi&uacute;p TV của bạn h&ograve;a v&agrave;o tường một c&aacute;ch liền mạch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(700).jpg" /></p>

<h3>To&agrave;n&nbsp;cảnh thay đổi tr&ograve; chơi</h3>

<p><strong>GameView &amp; Game Bar Super Ultrawide -&nbsp;</strong>Mở rộng tầm nh&igrave;n của bạn với khả năng thay đổi linh hoạt giữa nhiều tỷ lệ khung h&igrave;nh từ 21: 9 đến 32: 9 v&agrave; điều chỉnh vị tr&iacute; m&agrave;n h&igrave;nh ngang tầm mắt của bạn để c&oacute; trải nghiệm lớn hơn, tốt hơn.&nbsp;Tối ưu h&oacute;a c&aacute;ch chơi của bạn với Game Bar, một menu tr&ecirc;n m&agrave;n h&igrave;nh cho ph&eacute;p bạn điều chỉnh tỷ lệ m&agrave;n h&igrave;nh theo thời gian thực, kiểm tra độ trễ đầu v&agrave;o, FPS, HDR, c&agrave;i đặt tai nghe kh&ocirc;ng d&acirc;y, v.v.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(730).jpg" /></p>

<h3>Chuyển động mượt m&agrave; cho h&igrave;nh ảnh r&otilde; n&eacute;t</h3>

<p><strong>Motion Xcelerator</strong>&nbsp;- Trải nghiệm h&igrave;nh ảnh v&agrave; hiệu suất r&otilde; r&agrave;ng v&igrave; n&oacute; tự động ước t&iacute;nh v&agrave; b&ugrave; đắp khung h&igrave;nh cho nguồn nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(410).jpg" /></p>

<h3>L&agrave;m việc v&agrave; học tập tại&nbsp;nh&agrave;</h3>

<p><strong>PC tr&ecirc;n TV</strong>&nbsp;- Tận hưởng mọi khả năng của những g&igrave; bạn c&oacute; thể l&agrave;m.&nbsp;Dễ d&agrave;ng truy cập li&ecirc;n tục PC, Laptop v&agrave; thiết bị di động tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=smart-tv" target="_blank">Smart Tivi Samsung</a>&nbsp;của bạn.</p>

<p>* Kết nối từ xa với PC chỉ được hỗ trợ cho Windows 10 Professional trở l&ecirc;n v&agrave; Mac OS 10.5 trở l&ecirc;n.<br />
* Kết nối điện thoại th&ocirc;ng minh với Samsung Dex y&ecirc;u cầu một thiết bị di động tương th&iacute;ch.<br />
* T&iacute;nh khả dụng của c&aacute;c dịch vụ c&oacute; thể thay đổi m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước.<br />
* Cần c&oacute; kết nối Internet tr&ecirc;n TV v&agrave; PC.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/7(221).jpg" /></p>

<h3>Phản ứng tức th&igrave; với lệnh của bạn</h3>

<p><strong>Chế độ độ trễ thấp tự động</strong>&nbsp;- Tham gia tr&ograve; chơi nhanh hơn với Chế độ độ trễ thấp tự động (ALLM), tối ưu h&oacute;a m&agrave;n h&igrave;nh của bạn để bạn c&oacute; nhiều quyền điều khiển hơn với độ trễ đầu v&agrave;o hầu như kh&ocirc;ng đ&aacute;ng kể.&nbsp;Trải nghiệm chơi game mượt m&agrave; ở h&igrave;nh thức ấn tượng nhất m&agrave; kh&ocirc;ng bị nh&ograve;e chuyển động v&agrave; rung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-instantly-reacts-to-your-commands-379601320.gif" /></p>

<h3>Chỉ cần nhấn để kết nối</h3>

<p><strong>Nhấn v&agrave;o Xem</strong>&nbsp;- Chiếu điện thoại của bạn l&ecirc;n TV chỉ bằng một lần nhấn để tiếp tục thưởng thức phim, nhạc v&agrave; ứng dụng tr&ecirc;n m&agrave;n h&igrave;nh lớn hơn trong v&ograve;ng v&agrave;i gi&acirc;y.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2021-2-News/s0iG4Crt96dwzdk.jpg" /></p>

<h3>Xem tất cả tr&ecirc;n một m&agrave;n h&igrave;nh</h3>

<p><strong>Nhiều chế độ xem&nbsp;MultiView,&nbsp;TapView</strong>&nbsp;-&nbsp;Xem nội dung tr&ecirc;n TV v&agrave; điện thoại di động của bạn tr&ecirc;n c&ugrave;ng một m&agrave;n h&igrave;nh c&ugrave;ng một l&uacute;c.&nbsp;Cho d&ugrave; đ&oacute; l&agrave; số liệu thống k&ecirc; trực tiếp về thể thao hay video hướng dẫn cho tr&ograve; chơi, chỉ cần kết nối điện thoại với nhiều m&agrave;n h&igrave;nh của bạn hơn bao giờ hết.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(849).jpg" /></p>

<h3>Chọn bất kỳ trợ l&yacute; giọng n&oacute;i n&agrave;o bạn đ&atilde; quen</h3>

<p><strong>Nhiều trợ l&yacute; giọng n&oacute;i</strong>&nbsp;- Chọn trợ l&yacute; giọng n&oacute;i y&ecirc;u th&iacute;ch của bạn;&nbsp;Bixby, Amazon Alexa hoặc Trợ l&yacute; Google.&nbsp;Lần đầu ti&ecirc;n, tất cả đều được t&iacute;ch hợp v&agrave;o TV Samsung của bạn để mang đến trải nghiệm giải tr&iacute; tối ưu v&agrave; khả năng điều khiển ti&ecirc;n tiến trong ng&ocirc;i nh&agrave; kết nối của bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(738).jpg" /></p>

<h3>Kiểm so&aacute;t thiết bị cũ v&agrave; mới</h3>

<p><strong>SmartThings&nbsp;</strong>-&nbsp;Cho ph&eacute;p&nbsp;<a href="https://mediamart.vn/tivi" target="_blank">TV</a>&nbsp;của bạn tự động ph&aacute;t hiện, kết nối ngay lập tức v&agrave; hiển thị trực quan tất cả c&aacute;c thiết bị xung quanh TV của bạn.&nbsp;Digital Butler kh&ocirc;ng chỉ hỗ trợ thiết bị di động / cam / IoT / Smart m&agrave; c&ograve;n bao gồm c&aacute;c thiết bị cũ.&nbsp;Bạn c&oacute; thể điều khiển thiết bị trực tiếp bằng remote hoặc giọng n&oacute;i khi xem TV.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(855).jpg" /></p>

<h3>Truyền h&igrave;nh&nbsp;miễn ph&iacute;</h3>

<p><strong>Samsung TV Plus -&nbsp;</strong>Thưởng thức h&agrave;ng ngh&igrave;n giờ xem TV, phim, thể thao miễn ph&iacute; với 150 k&ecirc;nh v&agrave; đang ph&aacute;t triển.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(404).jpg" /></p>

<h3>D&agrave;nh thời gian xem, kh&ocirc;ng phải t&igrave;m kiếm</h3>

<p>Đ&aacute;p ứng trải nghiệm duyệt web chuyển tiếp nội dung gi&uacute;p tăng tốc độ t&igrave;m kiếm nội dung cần xem tr&ecirc;n TV trực tiếp v&agrave; OTT.&nbsp;Giờ đ&acirc;y, thật dễ d&agrave;ng để t&igrave;m tất cả c&aacute;c bộ phim v&agrave; chương tr&igrave;nh truyền h&igrave;nh y&ecirc;u th&iacute;ch của bạn ở một nơi.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(617).jpg" /></p>

<h3>Chăm s&oacute;c sức khỏe tại nh&agrave;</h3>

<p><strong>Samsung Health</strong>&nbsp;-&nbsp;L&agrave;m chủ to&agrave;n bộ th&oacute;i quen chăm s&oacute;c sức khỏe cho t&acirc;m tr&iacute; v&agrave; cơ thể của bạn v&agrave; vượt qua c&aacute;c mục ti&ecirc;u của bạn với nội dung từ c&aacute;c đối t&aacute;c h&agrave;ng đầu trong ng&agrave;nh thể dục v&agrave; quản l&yacute; số liệu thống k&ecirc; h&agrave;ng ng&agrave;y của bạn từ ứng dụng Samsung Health.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(611).jpg" /></p>

<h3>Gallery:</h3>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(856).jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(744).jpg" /></p>
', N'smart-tivi-samsung-4k-55-inch-55au7700-uhd-f7iBwb.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (33, 4, 3, N'Smart Tivi Samsung 4K 55 inch 55AU9000 Crystal UHD', N'smart-tivi-samsung-4k-55-inch-55au9000-crystal-uhd', 21000000.0000, N'UA55AU9000KXXV', 82, 24, N'Việt Nam', 15, N'Tận hưởng màu sắc chân thực nhờ công nghệ Dual LEDDynamic Crystal Color đắm mình vào khung hìnhDễ dàng tìm kiếm nội dung nhờ Trợ lý ảo Google', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(845).jpg" /></p>

<h3>T&ocirc;ng m&agrave;u đ&egrave;n nền được tối ưu h&oacute;a để tăng độ tương phản</h3>

<p><strong>Dual LED&nbsp;</strong>-&nbsp;C&ocirc;ng nghệ đ&egrave;n nền cải tiến mang lại độ tương phản r&otilde; n&eacute;t v&agrave; ch&iacute;nh x&aacute;c hơn bằng c&aacute;ch tối ưu h&oacute;a t&ocirc;ng m&agrave;u đ&egrave;n nền để ph&ugrave; hợp với loại nội dung đang xem.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-optimized-backlight-color-tone-for-enhanced-contrast-379601282.gif" /></p>

<h3>Độ tương phản rộng hơn</h3>

<p><strong>Quantum HDR&nbsp;</strong>-&nbsp;Quantum HDR tr&ecirc;n&nbsp;<a href="http://tivi-samsung/" target="_blank">tivi Samsung</a>&nbsp;n&agrave;y mang lại độ chi tiết v&agrave; độ tương phản, v&igrave; vậy bạn c&oacute; thể trải nghiệm to&agrave;n bộ sức mạnh của mọi h&igrave;nh ảnh.&nbsp;Vượt xa c&aacute;c ti&ecirc;u chuẩn h&agrave;ng đầu, &aacute;nh xạ t&ocirc;ng m&agrave;u động của HDR10 + tạo ra m&agrave;u đen s&acirc;u hơn, h&igrave;nh ảnh sống động hơn v&agrave; chi tiết lu&ocirc;n tỏa s&aacute;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(976).jpg" /></p>

<h3>Bộ xử l&yacute; 4K th&ocirc;ng minh hơn, nhanh hơn</h3>

<p><strong>Bộ xử l&yacute; Quantum Processor 4K Lite&nbsp;</strong>-&nbsp;Bộ vi xử l&yacute; mạnh mẽ của Samsung tối ưu h&oacute;a chất lượng &acirc;m thanh theo nội dung xem.&nbsp;Ngo&agrave;i ra, c&ocirc;ng nghệ n&acirc;ng cấp 4K mạnh mẽ đảm bảo bạn c&oacute; được độ ph&acirc;n giải l&ecirc;n đến 4K cho nội dung bạn y&ecirc;u th&iacute;ch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(742).jpg" /></p>

<h3>&Acirc;m thanh v&ograve;m 3D&nbsp;theo&nbsp;h&agrave;nh động h&igrave;nh ảnh</h3>

<p><strong>Object Tracking Sound Lite (OTS Lite)</strong>&nbsp;- &Acirc;m thanh v&ograve;m 3D với &acirc;m thanh k&ecirc;nh h&agrave;ng đầu ảo của ch&uacute;ng t&ocirc;i sẽ cho ph&eacute;p bạn ho&agrave;n to&agrave;n đắm ch&igrave;m trong trải nghiệm &acirc;m thanh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(743).jpg" /></p>

<h3>TV v&agrave; soundbar được sắp xếp h&agrave;i h&ograve;a ho&agrave;n hảo</h3>

<p><strong>Q-Symphony -&nbsp;</strong>Đắm m&igrave;nh với &acirc;m thanh từ cả loa TV v&agrave; loa soundbar của bạn, được đồng bộ h&oacute;a trong sự h&agrave;i h&ograve;a ho&agrave;n hảo để mang đến &acirc;m thanh phong ph&uacute;, tr&agrave;n ngập khắp căn ph&ograve;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/8(150).jpg" /></p>

<h3>&Acirc;m thanh được tinh chỉnh ph&ugrave; hợp với nội dung của bạn</h3>

<p><strong>&Acirc;m thanh th&iacute;ch ứng</strong>&nbsp;-&nbsp;&Acirc;m thanh tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=qled-tv" target="_blank">QLED TV Samsung</a>&nbsp;th&iacute;ch ứng c&oacute; t&iacute;nh năng th&ocirc;ng minh cảnh quan &acirc;m thanh gi&uacute;p tối ưu h&oacute;a &acirc;m thanh dựa tr&ecirc;n ph&acirc;n t&iacute;ch cảnh thời gian thực theo loại nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(620).jpg" /></p>

<h3>Kiểu d&aacute;ng đẹp v&agrave; mỏng, hơn bao giờ hết</h3>

<p><strong>AirSlim</strong>&nbsp;- Thiết kế mỏng đầy ấn tượng m&agrave; bạn chưa từng thấy trước đ&acirc;y trong danh mục n&agrave;y, gi&uacute;p TV của bạn h&ograve;a v&agrave;o tường một c&aacute;ch liền mạch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(700).jpg" /></p>

<h3>To&agrave;n&nbsp;cảnh thay đổi tr&ograve; chơi</h3>

<p><strong>GameView &amp; Game Bar Super Ultrawide -&nbsp;</strong>Mở rộng tầm nh&igrave;n của bạn với khả năng thay đổi linh hoạt giữa nhiều tỷ lệ khung h&igrave;nh từ 21: 9 đến 32: 9 v&agrave; điều chỉnh vị tr&iacute; m&agrave;n h&igrave;nh ngang tầm mắt của bạn để c&oacute; trải nghiệm lớn hơn, tốt hơn.&nbsp;Tối ưu h&oacute;a c&aacute;ch chơi của bạn với Game Bar, một menu tr&ecirc;n m&agrave;n h&igrave;nh cho ph&eacute;p bạn điều chỉnh tỷ lệ m&agrave;n h&igrave;nh theo thời gian thực, kiểm tra độ trễ đầu v&agrave;o, FPS, HDR, c&agrave;i đặt tai nghe kh&ocirc;ng d&acirc;y, v.v.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(730).jpg" /></p>

<h3>Chuyển động mượt m&agrave; cho h&igrave;nh ảnh r&otilde; n&eacute;t</h3>

<p><strong>Motion Xcelerator</strong>&nbsp;- Trải nghiệm h&igrave;nh ảnh v&agrave; hiệu suất r&otilde; r&agrave;ng v&igrave; n&oacute; tự động ước t&iacute;nh v&agrave; b&ugrave; đắp khung h&igrave;nh cho nguồn nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(410).jpg" /></p>

<h3>L&agrave;m việc v&agrave; học tập tại&nbsp;nh&agrave;</h3>

<p><strong>PC tr&ecirc;n TV</strong>&nbsp;- Tận hưởng mọi khả năng của những g&igrave; bạn c&oacute; thể l&agrave;m.&nbsp;Dễ d&agrave;ng truy cập li&ecirc;n tục PC, Laptop v&agrave; thiết bị di động tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=smart-tv" target="_blank">Smart Tivi Samsung</a>&nbsp;của bạn.</p>

<p>* Kết nối từ xa với PC chỉ được hỗ trợ cho Windows 10 Professional trở l&ecirc;n v&agrave; Mac OS 10.5 trở l&ecirc;n.<br />
* Kết nối điện thoại th&ocirc;ng minh với Samsung Dex y&ecirc;u cầu một thiết bị di động tương th&iacute;ch.<br />
* T&iacute;nh khả dụng của c&aacute;c dịch vụ c&oacute; thể thay đổi m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước.<br />
* Cần c&oacute; kết nối Internet tr&ecirc;n TV v&agrave; PC.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/7(221).jpg" /></p>

<h3>Phản ứng tức th&igrave; với lệnh của bạn</h3>

<p><strong>Chế độ độ trễ thấp tự động</strong>&nbsp;- Tham gia tr&ograve; chơi nhanh hơn với Chế độ độ trễ thấp tự động (ALLM), tối ưu h&oacute;a m&agrave;n h&igrave;nh của bạn để bạn c&oacute; nhiều quyền điều khiển hơn với độ trễ đầu v&agrave;o hầu như kh&ocirc;ng đ&aacute;ng kể.&nbsp;Trải nghiệm chơi game mượt m&agrave; ở h&igrave;nh thức ấn tượng nhất m&agrave; kh&ocirc;ng bị nh&ograve;e chuyển động v&agrave; rung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-instantly-reacts-to-your-commands-379601320.gif" /></p>

<h3>Chỉ cần nhấn để kết nối</h3>

<p><strong>Nhấn v&agrave;o Xem</strong>&nbsp;- Chiếu điện thoại của bạn l&ecirc;n TV chỉ bằng một lần nhấn để tiếp tục thưởng thức phim, nhạc v&agrave; ứng dụng tr&ecirc;n m&agrave;n h&igrave;nh lớn hơn trong v&ograve;ng v&agrave;i gi&acirc;y.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2021-2-News/s0iG4Crt96dwzdk.jpg" /></p>

<h3>Xem tất cả tr&ecirc;n một m&agrave;n h&igrave;nh</h3>

<p><strong>Nhiều chế độ xem&nbsp;MultiView,&nbsp;TapView</strong>&nbsp;-&nbsp;Xem nội dung tr&ecirc;n TV v&agrave; điện thoại di động của bạn tr&ecirc;n c&ugrave;ng một m&agrave;n h&igrave;nh c&ugrave;ng một l&uacute;c.&nbsp;Cho d&ugrave; đ&oacute; l&agrave; số liệu thống k&ecirc; trực tiếp về thể thao hay video hướng dẫn cho tr&ograve; chơi, chỉ cần kết nối điện thoại với nhiều m&agrave;n h&igrave;nh của bạn hơn bao giờ hết.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(849).jpg" /></p>

<h3>Chọn bất kỳ trợ l&yacute; giọng n&oacute;i n&agrave;o bạn đ&atilde; quen</h3>

<p><strong>Nhiều trợ l&yacute; giọng n&oacute;i</strong>&nbsp;- Chọn trợ l&yacute; giọng n&oacute;i y&ecirc;u th&iacute;ch của bạn;&nbsp;Bixby, Amazon Alexa hoặc Trợ l&yacute; Google.&nbsp;Lần đầu ti&ecirc;n, tất cả đều được t&iacute;ch hợp v&agrave;o TV Samsung của bạn để mang đến trải nghiệm giải tr&iacute; tối ưu v&agrave; khả năng điều khiển ti&ecirc;n tiến trong ng&ocirc;i nh&agrave; kết nối của bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(738).jpg" /></p>

<h3>Kiểm so&aacute;t thiết bị cũ v&agrave; mới</h3>

<p><strong>SmartThings&nbsp;</strong>-&nbsp;Cho ph&eacute;p&nbsp;<a href="https://mediamart.vn/tivi" target="_blank">TV</a>&nbsp;của bạn tự động ph&aacute;t hiện, kết nối ngay lập tức v&agrave; hiển thị trực quan tất cả c&aacute;c thiết bị xung quanh TV của bạn.&nbsp;Digital Butler kh&ocirc;ng chỉ hỗ trợ thiết bị di động / cam / IoT / Smart m&agrave; c&ograve;n bao gồm c&aacute;c thiết bị cũ.&nbsp;Bạn c&oacute; thể điều khiển thiết bị trực tiếp bằng remote hoặc giọng n&oacute;i khi xem TV.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(855).jpg" /></p>

<h3>Truyền h&igrave;nh&nbsp;miễn ph&iacute;</h3>

<p><strong>Samsung TV Plus -&nbsp;</strong>Thưởng thức h&agrave;ng ngh&igrave;n giờ xem TV, phim, thể thao miễn ph&iacute; với 150 k&ecirc;nh v&agrave; đang ph&aacute;t triển.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(404).jpg" /></p>

<h3>D&agrave;nh thời gian xem, kh&ocirc;ng phải t&igrave;m kiếm</h3>

<p>Đ&aacute;p ứng trải nghiệm duyệt web chuyển tiếp nội dung gi&uacute;p tăng tốc độ t&igrave;m kiếm nội dung cần xem tr&ecirc;n TV trực tiếp v&agrave; OTT.&nbsp;Giờ đ&acirc;y, thật dễ d&agrave;ng để t&igrave;m tất cả c&aacute;c bộ phim v&agrave; chương tr&igrave;nh truyền h&igrave;nh y&ecirc;u th&iacute;ch của bạn ở một nơi.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(617).jpg" /></p>

<h3>Chăm s&oacute;c sức khỏe tại nh&agrave;</h3>

<p><strong>Samsung Health</strong>&nbsp;-&nbsp;L&agrave;m chủ to&agrave;n bộ th&oacute;i quen chăm s&oacute;c sức khỏe cho t&acirc;m tr&iacute; v&agrave; cơ thể của bạn v&agrave; vượt qua c&aacute;c mục ti&ecirc;u của bạn với nội dung từ c&aacute;c đối t&aacute;c h&agrave;ng đầu trong ng&agrave;nh thể dục v&agrave; quản l&yacute; số liệu thống k&ecirc; h&agrave;ng ng&agrave;y của bạn từ ứng dụng Samsung Health.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(611).jpg" /></p>

<h3>Gallery:</h3>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(856).jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(744).jpg" /></p>
', N'smart-tivi-samsung-4k-55-inch-55au9000-crystal-uhd-JyY5Qd.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (34, 4, 4, N'Loa SoundBar LG SL4 2.1 CH', N'loa-soundbar-lg-sl4-21-ch', 2190000.0000, N'LG SL4', 69, 12, N'Việt Nam', 0, N'Loa siêu trầm cho âm thanh rõ ràngCông nghệ Dolby AtmosHi-res Audio đạt 24bit/192kHz.Kết nối không dây Bluetooth', N'<p><strong>Kiểu d&aacute;ng đơn giản, chắc chắn</strong><br />
Trong khi loa thanh c&oacute; dạng thanh d&agrave;i đồng nhất th&igrave; loa Subwoofer h&igrave;nh hộp gọn g&agrave;ng, tinh tế,&nbsp;m&agrave;u đen lịch l&atilde;m, tạo điểm nhấn cho kh&ocirc;ng gian ph&ograve;ng họp, ph&ograve;ng kh&aacute;ch trong gia đ&igrave;nh, c&ocirc;ng ty.<br />
C&aacute;ch bố tr&iacute; bộ&nbsp;loa thanh Samsung&nbsp;t&ugrave;y theo thẩm mỹ v&agrave; thiết kế nội thất kh&aacute;c nhau, bạn c&oacute; thể đặt cả loa thanh v&agrave; loa&nbsp;Subwoofer tr&ecirc;n kệ hoặc loa thanh tr&ecirc;n kệ/treo tường c&ograve;n loa&nbsp;Subwoofer để s&agrave;n.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-t6Cf4A.jpg" /></p>

<p><strong>Trải nghiệm &acirc;m thanh vang dội, cuốn h&uacute;t c&ugrave;ng loa 2.1 k&ecirc;nh, c&ocirc;ng suất 410 W</strong><br />
C&aacute;c dải &acirc;m được t&aacute;i hiện t&aacute;ch bạch, r&otilde; r&agrave;ng, đặc biệt với&nbsp;loa&nbsp;Subwoofer 6.5 inch&nbsp;hỗ trợ th&ecirc;m chế độ&nbsp;Bass Boost&nbsp;n&acirc;ng cao dải &acirc;m trầm&nbsp;cho bạn nghe c&aacute;c bản nhạc Rock, EDM cực kỳ đ&atilde; tai, &acirc;m sắc cho độ rung cảm m&atilde;nh liệt.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-7634Ax.jpg" /></p>

<p><strong>Trải nghiệm &acirc;m thanh 3D sống động nhờ c&ocirc;ng nghệ&nbsp;Dolby Audio/DTS Virtual:X</strong><br />
Dolby Audio/DTS Virtual:X t&aacute;i tạo chất &acirc;m ch&acirc;n thật&nbsp;cho bạn nghe r&otilde; được từng sắc &acirc;m, cảm nhận độ s&acirc;u của &acirc;m thanh, n&acirc;ng cao trải nghiệm &acirc;m nhạc.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-a5NmL5.jpg" /></p>

<p><strong>&Acirc;m thanh đa chiều lan tỏa rộng với chế độ Surround Sound Expansion</strong><br />
Loa thanh&nbsp;mang đến&nbsp;&acirc;m thanh v&ograve;m mở rộng&nbsp;bao tr&ugrave;m kh&ocirc;ng gian, cho cảm gi&aacute;c như ở quanh bạn.&nbsp;<br />
Chế độ&nbsp;Adaptive Sound Lite&nbsp;ph&acirc;n t&iacute;ch nội dung đang ph&aacute;t ra tr&ecirc;n tivi, chỉnh &acirc;m thanh tương th&iacute;ch để bạn nghe được cuộc hội thoại, lời ca, giọng b&igrave;nh luận vi&ecirc;n,... chi tiết, tăng th&ecirc;m sự hấp dẫn, l&ocirc;i cuốn khi giải tr&iacute;.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-UGHBMT.jpg" /></p>

<p><strong>&Acirc;m thanh ph&ugrave; hợp với từng m&agrave;n game qua chế độ Game Mode</strong><br />
Ngo&agrave;i khả năng tối ưu &acirc;m thanh theo m&agrave;n game th&igrave; chế độ n&agrave;y c&ograve;n&nbsp;khử nhiễu xuy&ecirc;n &acirc;m, loại bỏ c&aacute;c &acirc;m thanh g&acirc;y xao nh&atilde;ng, tạo hiệu ứng gi&uacute;p bạn nắm bắt chuẩn x&aacute;c c&aacute;c &acirc;m thanh trong tr&ograve; game, chiến game phấn kh&iacute;ch, h&agrave;o hứng hơn.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-AY1W8w.jpg" /></p>

<p><strong>Sử dụng linh hoạt, điều khiển từ xa m&agrave; kh&ocirc;ng cần lại gần loa với&nbsp;One Remote Control&nbsp;đi k&egrave;m</strong></p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-96Z6Ho.jpg" /></p>

<p><strong>Kết nối&nbsp;loa&nbsp;với tivi, điện thoại, m&aacute;y t&iacute;nh bảng,... mượt m&agrave; c&ugrave;ng Bluetooth&nbsp;</strong><br />
Đường truyền chất lượng cao, đảm bảo t&iacute;n hiệu liền mạch, bạn c&oacute; thể tận hưởng danh s&aacute;ch b&agrave;i h&aacute;t y&ecirc;u th&iacute;ch cả ng&agrave;y c&ugrave;ng&nbsp;Samsung HW-A550.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-XuPZ7L.jpg" /></p>

<p><strong>Trang bị nhiều kết nối tiện &iacute;ch</strong><br />
C&oacute; kết nối kh&ocirc;ng d&acirc;y&nbsp;Bluetooth, cổng&nbsp;USB, HDMI, HDMI-ARC,&nbsp;Optical gh&eacute;p nối loa với tivi, đầu đĩa, điện thoại,... dễ d&agrave;ng, cho bạn l&agrave;m việc, giải tr&iacute; th&ecirc;m tiện lợi.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-9tARpR.jpg" /></p>

<p>Loa thanh Samsung HW-A550, thiết bị &acirc;m thanh hiện đại t&aacute;i tạo thế giới &acirc;m thanh đầy sắc m&agrave;u cho bạn thưởng thức phim ảnh, nghe nhạc tuyệt vời hơn.</p>
', N'-pFble3.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (35, 4, 4, N'Loa Soundbar LG QP5W 3.1.2CH', N'loa-soundbar-lg-qp5w-312ch', 7490000.0000, N'QP5W', 70, 12, N'Việt Nam', 15, N'Chia sẻ chế độ âm thanh TV & Điều khiển chế độ loa SoundbarLow-vibration SubwooferDolby Atmos & DTS:X', N'<p><strong>Kiểu d&aacute;ng đơn giản, chắc chắn</strong><br />
Trong khi loa thanh c&oacute; dạng thanh d&agrave;i đồng nhất th&igrave; loa Subwoofer h&igrave;nh hộp gọn g&agrave;ng, tinh tế,&nbsp;m&agrave;u đen lịch l&atilde;m, tạo điểm nhấn cho kh&ocirc;ng gian ph&ograve;ng họp, ph&ograve;ng kh&aacute;ch trong gia đ&igrave;nh, c&ocirc;ng ty.<br />
C&aacute;ch bố tr&iacute; bộ&nbsp;loa thanh Samsung&nbsp;t&ugrave;y theo thẩm mỹ v&agrave; thiết kế nội thất kh&aacute;c nhau, bạn c&oacute; thể đặt cả loa thanh v&agrave; loa&nbsp;Subwoofer tr&ecirc;n kệ hoặc loa thanh tr&ecirc;n kệ/treo tường c&ograve;n loa&nbsp;Subwoofer để s&agrave;n.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-t6Cf4A.jpg" /></p>

<p><strong>Trải nghiệm &acirc;m thanh vang dội, cuốn h&uacute;t c&ugrave;ng loa 2.1 k&ecirc;nh, c&ocirc;ng suất 410 W</strong><br />
C&aacute;c dải &acirc;m được t&aacute;i hiện t&aacute;ch bạch, r&otilde; r&agrave;ng, đặc biệt với&nbsp;loa&nbsp;Subwoofer 6.5 inch&nbsp;hỗ trợ th&ecirc;m chế độ&nbsp;Bass Boost&nbsp;n&acirc;ng cao dải &acirc;m trầm&nbsp;cho bạn nghe c&aacute;c bản nhạc Rock, EDM cực kỳ đ&atilde; tai, &acirc;m sắc cho độ rung cảm m&atilde;nh liệt.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-7634Ax.jpg" /></p>

<p><strong>Trải nghiệm &acirc;m thanh 3D sống động nhờ c&ocirc;ng nghệ&nbsp;Dolby Audio/DTS Virtual:X</strong><br />
Dolby Audio/DTS Virtual:X t&aacute;i tạo chất &acirc;m ch&acirc;n thật&nbsp;cho bạn nghe r&otilde; được từng sắc &acirc;m, cảm nhận độ s&acirc;u của &acirc;m thanh, n&acirc;ng cao trải nghiệm &acirc;m nhạc.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-a5NmL5.jpg" /></p>

<p><strong>&Acirc;m thanh đa chiều lan tỏa rộng với chế độ Surround Sound Expansion</strong><br />
Loa thanh&nbsp;mang đến&nbsp;&acirc;m thanh v&ograve;m mở rộng&nbsp;bao tr&ugrave;m kh&ocirc;ng gian, cho cảm gi&aacute;c như ở quanh bạn.&nbsp;<br />
Chế độ&nbsp;Adaptive Sound Lite&nbsp;ph&acirc;n t&iacute;ch nội dung đang ph&aacute;t ra tr&ecirc;n tivi, chỉnh &acirc;m thanh tương th&iacute;ch để bạn nghe được cuộc hội thoại, lời ca, giọng b&igrave;nh luận vi&ecirc;n,... chi tiết, tăng th&ecirc;m sự hấp dẫn, l&ocirc;i cuốn khi giải tr&iacute;.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-UGHBMT.jpg" /></p>

<p><strong>&Acirc;m thanh ph&ugrave; hợp với từng m&agrave;n game qua chế độ Game Mode</strong><br />
Ngo&agrave;i khả năng tối ưu &acirc;m thanh theo m&agrave;n game th&igrave; chế độ n&agrave;y c&ograve;n&nbsp;khử nhiễu xuy&ecirc;n &acirc;m, loại bỏ c&aacute;c &acirc;m thanh g&acirc;y xao nh&atilde;ng, tạo hiệu ứng gi&uacute;p bạn nắm bắt chuẩn x&aacute;c c&aacute;c &acirc;m thanh trong tr&ograve; game, chiến game phấn kh&iacute;ch, h&agrave;o hứng hơn.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-AY1W8w.jpg" /></p>

<p><strong>Sử dụng linh hoạt, điều khiển từ xa m&agrave; kh&ocirc;ng cần lại gần loa với&nbsp;One Remote Control&nbsp;đi k&egrave;m</strong></p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-96Z6Ho.jpg" /></p>

<p><strong>Kết nối&nbsp;loa&nbsp;với tivi, điện thoại, m&aacute;y t&iacute;nh bảng,... mượt m&agrave; c&ugrave;ng Bluetooth&nbsp;</strong><br />
Đường truyền chất lượng cao, đảm bảo t&iacute;n hiệu liền mạch, bạn c&oacute; thể tận hưởng danh s&aacute;ch b&agrave;i h&aacute;t y&ecirc;u th&iacute;ch cả ng&agrave;y c&ugrave;ng&nbsp;Samsung HW-A550.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-XuPZ7L.jpg" /></p>

<p><strong>Trang bị nhiều kết nối tiện &iacute;ch</strong><br />
C&oacute; kết nối kh&ocirc;ng d&acirc;y&nbsp;Bluetooth, cổng&nbsp;USB, HDMI, HDMI-ARC,&nbsp;Optical gh&eacute;p nối loa với tivi, đầu đĩa, điện thoại,... dễ d&agrave;ng, cho bạn l&agrave;m việc, giải tr&iacute; th&ecirc;m tiện lợi.</p>

<p><img alt="1" src="https://mediamart.vn/images/uploads/data-2021/1-9tARpR.jpg" /></p>

<p>Loa thanh Samsung HW-A550, thiết bị &acirc;m thanh hiện đại t&aacute;i tạo thế giới &acirc;m thanh đầy sắc m&agrave;u cho bạn thưởng thức phim ảnh, nghe nhạc tuyệt vời hơn.</p>
', N'loa-soundbar-lg-qp5w-O2GroS.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (36, 4, 4, N'Smart Tivi LG 4K 43 inch 43UP7720PTC ThinQ AI', N'smart-tivi-lg-4k-43-inch-43up7720ptc-thinq-ai', 13900000.0000, N'43UP7720PTC', 18, 12, N'Việt Nam', 0, N'Xem 4K Ultra HD rực rỡ với chất lượng hình ảnh sống động.Chất lượng âm thanh hấp thụ và không khí với AI SoundNền tảng thông minh webOS với Freeview Play, Netflix, Disney + và hơn thế nữaKiểu dáng đẹp và mỏng với chân đế kép', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(845).jpg" /></p>

<h3>T&ocirc;ng m&agrave;u đ&egrave;n nền được tối ưu h&oacute;a để tăng độ tương phản</h3>

<p><strong>Dual LED&nbsp;</strong>-&nbsp;C&ocirc;ng nghệ đ&egrave;n nền cải tiến mang lại độ tương phản r&otilde; n&eacute;t v&agrave; ch&iacute;nh x&aacute;c hơn bằng c&aacute;ch tối ưu h&oacute;a t&ocirc;ng m&agrave;u đ&egrave;n nền để ph&ugrave; hợp với loại nội dung đang xem.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-optimized-backlight-color-tone-for-enhanced-contrast-379601282.gif" /></p>

<h3>Độ tương phản rộng hơn</h3>

<p><strong>Quantum HDR&nbsp;</strong>-&nbsp;Quantum HDR tr&ecirc;n&nbsp;<a href="http://tivi-samsung/" target="_blank">tivi Samsung</a>&nbsp;n&agrave;y mang lại độ chi tiết v&agrave; độ tương phản, v&igrave; vậy bạn c&oacute; thể trải nghiệm to&agrave;n bộ sức mạnh của mọi h&igrave;nh ảnh.&nbsp;Vượt xa c&aacute;c ti&ecirc;u chuẩn h&agrave;ng đầu, &aacute;nh xạ t&ocirc;ng m&agrave;u động của HDR10 + tạo ra m&agrave;u đen s&acirc;u hơn, h&igrave;nh ảnh sống động hơn v&agrave; chi tiết lu&ocirc;n tỏa s&aacute;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(976).jpg" /></p>

<h3>Bộ xử l&yacute; 4K th&ocirc;ng minh hơn, nhanh hơn</h3>

<p><strong>Bộ xử l&yacute; Quantum Processor 4K Lite&nbsp;</strong>-&nbsp;Bộ vi xử l&yacute; mạnh mẽ của Samsung tối ưu h&oacute;a chất lượng &acirc;m thanh theo nội dung xem.&nbsp;Ngo&agrave;i ra, c&ocirc;ng nghệ n&acirc;ng cấp 4K mạnh mẽ đảm bảo bạn c&oacute; được độ ph&acirc;n giải l&ecirc;n đến 4K cho nội dung bạn y&ecirc;u th&iacute;ch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(742).jpg" /></p>

<h3>&Acirc;m thanh v&ograve;m 3D&nbsp;theo&nbsp;h&agrave;nh động h&igrave;nh ảnh</h3>

<p><strong>Object Tracking Sound Lite (OTS Lite)</strong>&nbsp;- &Acirc;m thanh v&ograve;m 3D với &acirc;m thanh k&ecirc;nh h&agrave;ng đầu ảo của ch&uacute;ng t&ocirc;i sẽ cho ph&eacute;p bạn ho&agrave;n to&agrave;n đắm ch&igrave;m trong trải nghiệm &acirc;m thanh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(743).jpg" /></p>

<h3>TV v&agrave; soundbar được sắp xếp h&agrave;i h&ograve;a ho&agrave;n hảo</h3>

<p><strong>Q-Symphony -&nbsp;</strong>Đắm m&igrave;nh với &acirc;m thanh từ cả loa TV v&agrave; loa soundbar của bạn, được đồng bộ h&oacute;a trong sự h&agrave;i h&ograve;a ho&agrave;n hảo để mang đến &acirc;m thanh phong ph&uacute;, tr&agrave;n ngập khắp căn ph&ograve;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/8(150).jpg" /></p>

<h3>&Acirc;m thanh được tinh chỉnh ph&ugrave; hợp với nội dung của bạn</h3>

<p><strong>&Acirc;m thanh th&iacute;ch ứng</strong>&nbsp;-&nbsp;&Acirc;m thanh tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=qled-tv" target="_blank">QLED TV Samsung</a>&nbsp;th&iacute;ch ứng c&oacute; t&iacute;nh năng th&ocirc;ng minh cảnh quan &acirc;m thanh gi&uacute;p tối ưu h&oacute;a &acirc;m thanh dựa tr&ecirc;n ph&acirc;n t&iacute;ch cảnh thời gian thực theo loại nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(620).jpg" /></p>

<h3>Kiểu d&aacute;ng đẹp v&agrave; mỏng, hơn bao giờ hết</h3>

<p><strong>AirSlim</strong>&nbsp;- Thiết kế mỏng đầy ấn tượng m&agrave; bạn chưa từng thấy trước đ&acirc;y trong danh mục n&agrave;y, gi&uacute;p TV của bạn h&ograve;a v&agrave;o tường một c&aacute;ch liền mạch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(700).jpg" /></p>

<h3>To&agrave;n&nbsp;cảnh thay đổi tr&ograve; chơi</h3>

<p><strong>GameView &amp; Game Bar Super Ultrawide -&nbsp;</strong>Mở rộng tầm nh&igrave;n của bạn với khả năng thay đổi linh hoạt giữa nhiều tỷ lệ khung h&igrave;nh từ 21: 9 đến 32: 9 v&agrave; điều chỉnh vị tr&iacute; m&agrave;n h&igrave;nh ngang tầm mắt của bạn để c&oacute; trải nghiệm lớn hơn, tốt hơn.&nbsp;Tối ưu h&oacute;a c&aacute;ch chơi của bạn với Game Bar, một menu tr&ecirc;n m&agrave;n h&igrave;nh cho ph&eacute;p bạn điều chỉnh tỷ lệ m&agrave;n h&igrave;nh theo thời gian thực, kiểm tra độ trễ đầu v&agrave;o, FPS, HDR, c&agrave;i đặt tai nghe kh&ocirc;ng d&acirc;y, v.v.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(730).jpg" /></p>

<h3>Chuyển động mượt m&agrave; cho h&igrave;nh ảnh r&otilde; n&eacute;t</h3>

<p><strong>Motion Xcelerator</strong>&nbsp;- Trải nghiệm h&igrave;nh ảnh v&agrave; hiệu suất r&otilde; r&agrave;ng v&igrave; n&oacute; tự động ước t&iacute;nh v&agrave; b&ugrave; đắp khung h&igrave;nh cho nguồn nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(410).jpg" /></p>

<h3>L&agrave;m việc v&agrave; học tập tại&nbsp;nh&agrave;</h3>

<p><strong>PC tr&ecirc;n TV</strong>&nbsp;- Tận hưởng mọi khả năng của những g&igrave; bạn c&oacute; thể l&agrave;m.&nbsp;Dễ d&agrave;ng truy cập li&ecirc;n tục PC, Laptop v&agrave; thiết bị di động tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=smart-tv" target="_blank">Smart Tivi Samsung</a>&nbsp;của bạn.</p>

<p>* Kết nối từ xa với PC chỉ được hỗ trợ cho Windows 10 Professional trở l&ecirc;n v&agrave; Mac OS 10.5 trở l&ecirc;n.<br />
* Kết nối điện thoại th&ocirc;ng minh với Samsung Dex y&ecirc;u cầu một thiết bị di động tương th&iacute;ch.<br />
* T&iacute;nh khả dụng của c&aacute;c dịch vụ c&oacute; thể thay đổi m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước.<br />
* Cần c&oacute; kết nối Internet tr&ecirc;n TV v&agrave; PC.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/7(221).jpg" /></p>

<h3>Phản ứng tức th&igrave; với lệnh của bạn</h3>

<p><strong>Chế độ độ trễ thấp tự động</strong>&nbsp;- Tham gia tr&ograve; chơi nhanh hơn với Chế độ độ trễ thấp tự động (ALLM), tối ưu h&oacute;a m&agrave;n h&igrave;nh của bạn để bạn c&oacute; nhiều quyền điều khiển hơn với độ trễ đầu v&agrave;o hầu như kh&ocirc;ng đ&aacute;ng kể.&nbsp;Trải nghiệm chơi game mượt m&agrave; ở h&igrave;nh thức ấn tượng nhất m&agrave; kh&ocirc;ng bị nh&ograve;e chuyển động v&agrave; rung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-instantly-reacts-to-your-commands-379601320.gif" /></p>

<h3>Chỉ cần nhấn để kết nối</h3>

<p><strong>Nhấn v&agrave;o Xem</strong>&nbsp;- Chiếu điện thoại của bạn l&ecirc;n TV chỉ bằng một lần nhấn để tiếp tục thưởng thức phim, nhạc v&agrave; ứng dụng tr&ecirc;n m&agrave;n h&igrave;nh lớn hơn trong v&ograve;ng v&agrave;i gi&acirc;y.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2021-2-News/s0iG4Crt96dwzdk.jpg" /></p>

<h3>Xem tất cả tr&ecirc;n một m&agrave;n h&igrave;nh</h3>

<p><strong>Nhiều chế độ xem&nbsp;MultiView,&nbsp;TapView</strong>&nbsp;-&nbsp;Xem nội dung tr&ecirc;n TV v&agrave; điện thoại di động của bạn tr&ecirc;n c&ugrave;ng một m&agrave;n h&igrave;nh c&ugrave;ng một l&uacute;c.&nbsp;Cho d&ugrave; đ&oacute; l&agrave; số liệu thống k&ecirc; trực tiếp về thể thao hay video hướng dẫn cho tr&ograve; chơi, chỉ cần kết nối điện thoại với nhiều m&agrave;n h&igrave;nh của bạn hơn bao giờ hết.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(849).jpg" /></p>

<h3>Chọn bất kỳ trợ l&yacute; giọng n&oacute;i n&agrave;o bạn đ&atilde; quen</h3>

<p><strong>Nhiều trợ l&yacute; giọng n&oacute;i</strong>&nbsp;- Chọn trợ l&yacute; giọng n&oacute;i y&ecirc;u th&iacute;ch của bạn;&nbsp;Bixby, Amazon Alexa hoặc Trợ l&yacute; Google.&nbsp;Lần đầu ti&ecirc;n, tất cả đều được t&iacute;ch hợp v&agrave;o TV Samsung của bạn để mang đến trải nghiệm giải tr&iacute; tối ưu v&agrave; khả năng điều khiển ti&ecirc;n tiến trong ng&ocirc;i nh&agrave; kết nối của bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(738).jpg" /></p>

<h3>Kiểm so&aacute;t thiết bị cũ v&agrave; mới</h3>

<p><strong>SmartThings&nbsp;</strong>-&nbsp;Cho ph&eacute;p&nbsp;<a href="https://mediamart.vn/tivi" target="_blank">TV</a>&nbsp;của bạn tự động ph&aacute;t hiện, kết nối ngay lập tức v&agrave; hiển thị trực quan tất cả c&aacute;c thiết bị xung quanh TV của bạn.&nbsp;Digital Butler kh&ocirc;ng chỉ hỗ trợ thiết bị di động / cam / IoT / Smart m&agrave; c&ograve;n bao gồm c&aacute;c thiết bị cũ.&nbsp;Bạn c&oacute; thể điều khiển thiết bị trực tiếp bằng remote hoặc giọng n&oacute;i khi xem TV.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(855).jpg" /></p>

<h3>Truyền h&igrave;nh&nbsp;miễn ph&iacute;</h3>

<p><strong>Samsung TV Plus -&nbsp;</strong>Thưởng thức h&agrave;ng ngh&igrave;n giờ xem TV, phim, thể thao miễn ph&iacute; với 150 k&ecirc;nh v&agrave; đang ph&aacute;t triển.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(404).jpg" /></p>

<h3>D&agrave;nh thời gian xem, kh&ocirc;ng phải t&igrave;m kiếm</h3>

<p>Đ&aacute;p ứng trải nghiệm duyệt web chuyển tiếp nội dung gi&uacute;p tăng tốc độ t&igrave;m kiếm nội dung cần xem tr&ecirc;n TV trực tiếp v&agrave; OTT.&nbsp;Giờ đ&acirc;y, thật dễ d&agrave;ng để t&igrave;m tất cả c&aacute;c bộ phim v&agrave; chương tr&igrave;nh truyền h&igrave;nh y&ecirc;u th&iacute;ch của bạn ở một nơi.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(617).jpg" /></p>

<h3>Chăm s&oacute;c sức khỏe tại nh&agrave;</h3>

<p><strong>Samsung Health</strong>&nbsp;-&nbsp;L&agrave;m chủ to&agrave;n bộ th&oacute;i quen chăm s&oacute;c sức khỏe cho t&acirc;m tr&iacute; v&agrave; cơ thể của bạn v&agrave; vượt qua c&aacute;c mục ti&ecirc;u của bạn với nội dung từ c&aacute;c đối t&aacute;c h&agrave;ng đầu trong ng&agrave;nh thể dục v&agrave; quản l&yacute; số liệu thống k&ecirc; h&agrave;ng ng&agrave;y của bạn từ ứng dụng Samsung Health.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(611).jpg" /></p>

<h3>Gallery:</h3>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(856).jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(744).jpg" /></p>
', N'smart-tivi-lg-4k-43-inch-43up7720ptc-thinq-ai-9A3TOj.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (37, 4, 4, N'Smart Tivi LG 4K 55 inch 55UP8100PTB ThinQ AI', N'smart-tivi-lg-4k-55-inch-55up8100ptb-thinq-ai', 20400000.0000, N'55UP8100PTB', 76, 24, N'Việt Nam', 0, N'Độ sống động, màu sắc và độ sâu của hình ảnh 4K Ultra HD đáng kinh ngạcChất lượng âm thanh hấp thụ và không khí với AI SoundNền tảng thông minh webOS với Freeview Play, Netflix, Disney + và hơn thế nữa', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(845).jpg" /></p>

<h3>T&ocirc;ng m&agrave;u đ&egrave;n nền được tối ưu h&oacute;a để tăng độ tương phản</h3>

<p><strong>Dual LED&nbsp;</strong>-&nbsp;C&ocirc;ng nghệ đ&egrave;n nền cải tiến mang lại độ tương phản r&otilde; n&eacute;t v&agrave; ch&iacute;nh x&aacute;c hơn bằng c&aacute;ch tối ưu h&oacute;a t&ocirc;ng m&agrave;u đ&egrave;n nền để ph&ugrave; hợp với loại nội dung đang xem.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-optimized-backlight-color-tone-for-enhanced-contrast-379601282.gif" /></p>

<h3>Độ tương phản rộng hơn</h3>

<p><strong>Quantum HDR&nbsp;</strong>-&nbsp;Quantum HDR tr&ecirc;n&nbsp;<a href="http://tivi-samsung/" target="_blank">tivi Samsung</a>&nbsp;n&agrave;y mang lại độ chi tiết v&agrave; độ tương phản, v&igrave; vậy bạn c&oacute; thể trải nghiệm to&agrave;n bộ sức mạnh của mọi h&igrave;nh ảnh.&nbsp;Vượt xa c&aacute;c ti&ecirc;u chuẩn h&agrave;ng đầu, &aacute;nh xạ t&ocirc;ng m&agrave;u động của HDR10 + tạo ra m&agrave;u đen s&acirc;u hơn, h&igrave;nh ảnh sống động hơn v&agrave; chi tiết lu&ocirc;n tỏa s&aacute;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(976).jpg" /></p>

<h3>Bộ xử l&yacute; 4K th&ocirc;ng minh hơn, nhanh hơn</h3>

<p><strong>Bộ xử l&yacute; Quantum Processor 4K Lite&nbsp;</strong>-&nbsp;Bộ vi xử l&yacute; mạnh mẽ của Samsung tối ưu h&oacute;a chất lượng &acirc;m thanh theo nội dung xem.&nbsp;Ngo&agrave;i ra, c&ocirc;ng nghệ n&acirc;ng cấp 4K mạnh mẽ đảm bảo bạn c&oacute; được độ ph&acirc;n giải l&ecirc;n đến 4K cho nội dung bạn y&ecirc;u th&iacute;ch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(742).jpg" /></p>

<h3>&Acirc;m thanh v&ograve;m 3D&nbsp;theo&nbsp;h&agrave;nh động h&igrave;nh ảnh</h3>

<p><strong>Object Tracking Sound Lite (OTS Lite)</strong>&nbsp;- &Acirc;m thanh v&ograve;m 3D với &acirc;m thanh k&ecirc;nh h&agrave;ng đầu ảo của ch&uacute;ng t&ocirc;i sẽ cho ph&eacute;p bạn ho&agrave;n to&agrave;n đắm ch&igrave;m trong trải nghiệm &acirc;m thanh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(743).jpg" /></p>

<h3>TV v&agrave; soundbar được sắp xếp h&agrave;i h&ograve;a ho&agrave;n hảo</h3>

<p><strong>Q-Symphony -&nbsp;</strong>Đắm m&igrave;nh với &acirc;m thanh từ cả loa TV v&agrave; loa soundbar của bạn, được đồng bộ h&oacute;a trong sự h&agrave;i h&ograve;a ho&agrave;n hảo để mang đến &acirc;m thanh phong ph&uacute;, tr&agrave;n ngập khắp căn ph&ograve;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/8(150).jpg" /></p>

<h3>&Acirc;m thanh được tinh chỉnh ph&ugrave; hợp với nội dung của bạn</h3>

<p><strong>&Acirc;m thanh th&iacute;ch ứng</strong>&nbsp;-&nbsp;&Acirc;m thanh tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=qled-tv" target="_blank">QLED TV Samsung</a>&nbsp;th&iacute;ch ứng c&oacute; t&iacute;nh năng th&ocirc;ng minh cảnh quan &acirc;m thanh gi&uacute;p tối ưu h&oacute;a &acirc;m thanh dựa tr&ecirc;n ph&acirc;n t&iacute;ch cảnh thời gian thực theo loại nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(620).jpg" /></p>

<h3>Kiểu d&aacute;ng đẹp v&agrave; mỏng, hơn bao giờ hết</h3>

<p><strong>AirSlim</strong>&nbsp;- Thiết kế mỏng đầy ấn tượng m&agrave; bạn chưa từng thấy trước đ&acirc;y trong danh mục n&agrave;y, gi&uacute;p TV của bạn h&ograve;a v&agrave;o tường một c&aacute;ch liền mạch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(700).jpg" /></p>

<h3>To&agrave;n&nbsp;cảnh thay đổi tr&ograve; chơi</h3>

<p><strong>GameView &amp; Game Bar Super Ultrawide -&nbsp;</strong>Mở rộng tầm nh&igrave;n của bạn với khả năng thay đổi linh hoạt giữa nhiều tỷ lệ khung h&igrave;nh từ 21: 9 đến 32: 9 v&agrave; điều chỉnh vị tr&iacute; m&agrave;n h&igrave;nh ngang tầm mắt của bạn để c&oacute; trải nghiệm lớn hơn, tốt hơn.&nbsp;Tối ưu h&oacute;a c&aacute;ch chơi của bạn với Game Bar, một menu tr&ecirc;n m&agrave;n h&igrave;nh cho ph&eacute;p bạn điều chỉnh tỷ lệ m&agrave;n h&igrave;nh theo thời gian thực, kiểm tra độ trễ đầu v&agrave;o, FPS, HDR, c&agrave;i đặt tai nghe kh&ocirc;ng d&acirc;y, v.v.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(730).jpg" /></p>

<h3>Chuyển động mượt m&agrave; cho h&igrave;nh ảnh r&otilde; n&eacute;t</h3>

<p><strong>Motion Xcelerator</strong>&nbsp;- Trải nghiệm h&igrave;nh ảnh v&agrave; hiệu suất r&otilde; r&agrave;ng v&igrave; n&oacute; tự động ước t&iacute;nh v&agrave; b&ugrave; đắp khung h&igrave;nh cho nguồn nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(410).jpg" /></p>

<h3>L&agrave;m việc v&agrave; học tập tại&nbsp;nh&agrave;</h3>

<p><strong>PC tr&ecirc;n TV</strong>&nbsp;- Tận hưởng mọi khả năng của những g&igrave; bạn c&oacute; thể l&agrave;m.&nbsp;Dễ d&agrave;ng truy cập li&ecirc;n tục PC, Laptop v&agrave; thiết bị di động tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=smart-tv" target="_blank">Smart Tivi Samsung</a>&nbsp;của bạn.</p>

<p>* Kết nối từ xa với PC chỉ được hỗ trợ cho Windows 10 Professional trở l&ecirc;n v&agrave; Mac OS 10.5 trở l&ecirc;n.<br />
* Kết nối điện thoại th&ocirc;ng minh với Samsung Dex y&ecirc;u cầu một thiết bị di động tương th&iacute;ch.<br />
* T&iacute;nh khả dụng của c&aacute;c dịch vụ c&oacute; thể thay đổi m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước.<br />
* Cần c&oacute; kết nối Internet tr&ecirc;n TV v&agrave; PC.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/7(221).jpg" /></p>

<h3>Phản ứng tức th&igrave; với lệnh của bạn</h3>

<p><strong>Chế độ độ trễ thấp tự động</strong>&nbsp;- Tham gia tr&ograve; chơi nhanh hơn với Chế độ độ trễ thấp tự động (ALLM), tối ưu h&oacute;a m&agrave;n h&igrave;nh của bạn để bạn c&oacute; nhiều quyền điều khiển hơn với độ trễ đầu v&agrave;o hầu như kh&ocirc;ng đ&aacute;ng kể.&nbsp;Trải nghiệm chơi game mượt m&agrave; ở h&igrave;nh thức ấn tượng nhất m&agrave; kh&ocirc;ng bị nh&ograve;e chuyển động v&agrave; rung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-instantly-reacts-to-your-commands-379601320.gif" /></p>

<h3>Chỉ cần nhấn để kết nối</h3>

<p><strong>Nhấn v&agrave;o Xem</strong>&nbsp;- Chiếu điện thoại của bạn l&ecirc;n TV chỉ bằng một lần nhấn để tiếp tục thưởng thức phim, nhạc v&agrave; ứng dụng tr&ecirc;n m&agrave;n h&igrave;nh lớn hơn trong v&ograve;ng v&agrave;i gi&acirc;y.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2021-2-News/s0iG4Crt96dwzdk.jpg" /></p>

<h3>Xem tất cả tr&ecirc;n một m&agrave;n h&igrave;nh</h3>

<p><strong>Nhiều chế độ xem&nbsp;MultiView,&nbsp;TapView</strong>&nbsp;-&nbsp;Xem nội dung tr&ecirc;n TV v&agrave; điện thoại di động của bạn tr&ecirc;n c&ugrave;ng một m&agrave;n h&igrave;nh c&ugrave;ng một l&uacute;c.&nbsp;Cho d&ugrave; đ&oacute; l&agrave; số liệu thống k&ecirc; trực tiếp về thể thao hay video hướng dẫn cho tr&ograve; chơi, chỉ cần kết nối điện thoại với nhiều m&agrave;n h&igrave;nh của bạn hơn bao giờ hết.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(849).jpg" /></p>

<h3>Chọn bất kỳ trợ l&yacute; giọng n&oacute;i n&agrave;o bạn đ&atilde; quen</h3>

<p><strong>Nhiều trợ l&yacute; giọng n&oacute;i</strong>&nbsp;- Chọn trợ l&yacute; giọng n&oacute;i y&ecirc;u th&iacute;ch của bạn;&nbsp;Bixby, Amazon Alexa hoặc Trợ l&yacute; Google.&nbsp;Lần đầu ti&ecirc;n, tất cả đều được t&iacute;ch hợp v&agrave;o TV Samsung của bạn để mang đến trải nghiệm giải tr&iacute; tối ưu v&agrave; khả năng điều khiển ti&ecirc;n tiến trong ng&ocirc;i nh&agrave; kết nối của bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(738).jpg" /></p>

<h3>Kiểm so&aacute;t thiết bị cũ v&agrave; mới</h3>

<p><strong>SmartThings&nbsp;</strong>-&nbsp;Cho ph&eacute;p&nbsp;<a href="https://mediamart.vn/tivi" target="_blank">TV</a>&nbsp;của bạn tự động ph&aacute;t hiện, kết nối ngay lập tức v&agrave; hiển thị trực quan tất cả c&aacute;c thiết bị xung quanh TV của bạn.&nbsp;Digital Butler kh&ocirc;ng chỉ hỗ trợ thiết bị di động / cam / IoT / Smart m&agrave; c&ograve;n bao gồm c&aacute;c thiết bị cũ.&nbsp;Bạn c&oacute; thể điều khiển thiết bị trực tiếp bằng remote hoặc giọng n&oacute;i khi xem TV.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(855).jpg" /></p>

<h3>Truyền h&igrave;nh&nbsp;miễn ph&iacute;</h3>

<p><strong>Samsung TV Plus -&nbsp;</strong>Thưởng thức h&agrave;ng ngh&igrave;n giờ xem TV, phim, thể thao miễn ph&iacute; với 150 k&ecirc;nh v&agrave; đang ph&aacute;t triển.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(404).jpg" /></p>

<h3>D&agrave;nh thời gian xem, kh&ocirc;ng phải t&igrave;m kiếm</h3>

<p>Đ&aacute;p ứng trải nghiệm duyệt web chuyển tiếp nội dung gi&uacute;p tăng tốc độ t&igrave;m kiếm nội dung cần xem tr&ecirc;n TV trực tiếp v&agrave; OTT.&nbsp;Giờ đ&acirc;y, thật dễ d&agrave;ng để t&igrave;m tất cả c&aacute;c bộ phim v&agrave; chương tr&igrave;nh truyền h&igrave;nh y&ecirc;u th&iacute;ch của bạn ở một nơi.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(617).jpg" /></p>

<h3>Chăm s&oacute;c sức khỏe tại nh&agrave;</h3>

<p><strong>Samsung Health</strong>&nbsp;-&nbsp;L&agrave;m chủ to&agrave;n bộ th&oacute;i quen chăm s&oacute;c sức khỏe cho t&acirc;m tr&iacute; v&agrave; cơ thể của bạn v&agrave; vượt qua c&aacute;c mục ti&ecirc;u của bạn với nội dung từ c&aacute;c đối t&aacute;c h&agrave;ng đầu trong ng&agrave;nh thể dục v&agrave; quản l&yacute; số liệu thống k&ecirc; h&agrave;ng ng&agrave;y của bạn từ ứng dụng Samsung Health.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(611).jpg" /></p>

<h3>Gallery:</h3>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(856).jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(744).jpg" /></p>
', N'smart-tivi-lg-4k-55-inch-55up8100ptb-thinq-ai-kscAns.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (38, 4, 4, N'Smart Tivi LG 32 inch 32LM575BPTC ThinQ AI', N'smart-tivi-lg-32-inch-32lm575bptc-thinq-ai', 7290000.0000, N'32LM575BPTC', 99, 12, N'Việt Nam', 0, N'Nâng cấp màu sắc sống động, Bộ Xử Lý Lõi TứVirtual Surround Plus, Dolby AudioĐiều khiển thông minh, Điều khiển bằng giọng nói', N'<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(845).jpg" /></p>

<h3>T&ocirc;ng m&agrave;u đ&egrave;n nền được tối ưu h&oacute;a để tăng độ tương phản</h3>

<p><strong>Dual LED&nbsp;</strong>-&nbsp;C&ocirc;ng nghệ đ&egrave;n nền cải tiến mang lại độ tương phản r&otilde; n&eacute;t v&agrave; ch&iacute;nh x&aacute;c hơn bằng c&aacute;ch tối ưu h&oacute;a t&ocirc;ng m&agrave;u đ&egrave;n nền để ph&ugrave; hợp với loại nội dung đang xem.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-optimized-backlight-color-tone-for-enhanced-contrast-379601282.gif" /></p>

<h3>Độ tương phản rộng hơn</h3>

<p><strong>Quantum HDR&nbsp;</strong>-&nbsp;Quantum HDR tr&ecirc;n&nbsp;<a href="http://tivi-samsung/" target="_blank">tivi Samsung</a>&nbsp;n&agrave;y mang lại độ chi tiết v&agrave; độ tương phản, v&igrave; vậy bạn c&oacute; thể trải nghiệm to&agrave;n bộ sức mạnh của mọi h&igrave;nh ảnh.&nbsp;Vượt xa c&aacute;c ti&ecirc;u chuẩn h&agrave;ng đầu, &aacute;nh xạ t&ocirc;ng m&agrave;u động của HDR10 + tạo ra m&agrave;u đen s&acirc;u hơn, h&igrave;nh ảnh sống động hơn v&agrave; chi tiết lu&ocirc;n tỏa s&aacute;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(976).jpg" /></p>

<h3>Bộ xử l&yacute; 4K th&ocirc;ng minh hơn, nhanh hơn</h3>

<p><strong>Bộ xử l&yacute; Quantum Processor 4K Lite&nbsp;</strong>-&nbsp;Bộ vi xử l&yacute; mạnh mẽ của Samsung tối ưu h&oacute;a chất lượng &acirc;m thanh theo nội dung xem.&nbsp;Ngo&agrave;i ra, c&ocirc;ng nghệ n&acirc;ng cấp 4K mạnh mẽ đảm bảo bạn c&oacute; được độ ph&acirc;n giải l&ecirc;n đến 4K cho nội dung bạn y&ecirc;u th&iacute;ch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(742).jpg" /></p>

<h3>&Acirc;m thanh v&ograve;m 3D&nbsp;theo&nbsp;h&agrave;nh động h&igrave;nh ảnh</h3>

<p><strong>Object Tracking Sound Lite (OTS Lite)</strong>&nbsp;- &Acirc;m thanh v&ograve;m 3D với &acirc;m thanh k&ecirc;nh h&agrave;ng đầu ảo của ch&uacute;ng t&ocirc;i sẽ cho ph&eacute;p bạn ho&agrave;n to&agrave;n đắm ch&igrave;m trong trải nghiệm &acirc;m thanh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(743).jpg" /></p>

<h3>TV v&agrave; soundbar được sắp xếp h&agrave;i h&ograve;a ho&agrave;n hảo</h3>

<p><strong>Q-Symphony -&nbsp;</strong>Đắm m&igrave;nh với &acirc;m thanh từ cả loa TV v&agrave; loa soundbar của bạn, được đồng bộ h&oacute;a trong sự h&agrave;i h&ograve;a ho&agrave;n hảo để mang đến &acirc;m thanh phong ph&uacute;, tr&agrave;n ngập khắp căn ph&ograve;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/8(150).jpg" /></p>

<h3>&Acirc;m thanh được tinh chỉnh ph&ugrave; hợp với nội dung của bạn</h3>

<p><strong>&Acirc;m thanh th&iacute;ch ứng</strong>&nbsp;-&nbsp;&Acirc;m thanh tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=qled-tv" target="_blank">QLED TV Samsung</a>&nbsp;th&iacute;ch ứng c&oacute; t&iacute;nh năng th&ocirc;ng minh cảnh quan &acirc;m thanh gi&uacute;p tối ưu h&oacute;a &acirc;m thanh dựa tr&ecirc;n ph&acirc;n t&iacute;ch cảnh thời gian thực theo loại nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(620).jpg" /></p>

<h3>Kiểu d&aacute;ng đẹp v&agrave; mỏng, hơn bao giờ hết</h3>

<p><strong>AirSlim</strong>&nbsp;- Thiết kế mỏng đầy ấn tượng m&agrave; bạn chưa từng thấy trước đ&acirc;y trong danh mục n&agrave;y, gi&uacute;p TV của bạn h&ograve;a v&agrave;o tường một c&aacute;ch liền mạch.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(700).jpg" /></p>

<h3>To&agrave;n&nbsp;cảnh thay đổi tr&ograve; chơi</h3>

<p><strong>GameView &amp; Game Bar Super Ultrawide -&nbsp;</strong>Mở rộng tầm nh&igrave;n của bạn với khả năng thay đổi linh hoạt giữa nhiều tỷ lệ khung h&igrave;nh từ 21: 9 đến 32: 9 v&agrave; điều chỉnh vị tr&iacute; m&agrave;n h&igrave;nh ngang tầm mắt của bạn để c&oacute; trải nghiệm lớn hơn, tốt hơn.&nbsp;Tối ưu h&oacute;a c&aacute;ch chơi của bạn với Game Bar, một menu tr&ecirc;n m&agrave;n h&igrave;nh cho ph&eacute;p bạn điều chỉnh tỷ lệ m&agrave;n h&igrave;nh theo thời gian thực, kiểm tra độ trễ đầu v&agrave;o, FPS, HDR, c&agrave;i đặt tai nghe kh&ocirc;ng d&acirc;y, v.v.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(730).jpg" /></p>

<h3>Chuyển động mượt m&agrave; cho h&igrave;nh ảnh r&otilde; n&eacute;t</h3>

<p><strong>Motion Xcelerator</strong>&nbsp;- Trải nghiệm h&igrave;nh ảnh v&agrave; hiệu suất r&otilde; r&agrave;ng v&igrave; n&oacute; tự động ước t&iacute;nh v&agrave; b&ugrave; đắp khung h&igrave;nh cho nguồn nội dung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(410).jpg" /></p>

<h3>L&agrave;m việc v&agrave; học tập tại&nbsp;nh&agrave;</h3>

<p><strong>PC tr&ecirc;n TV</strong>&nbsp;- Tận hưởng mọi khả năng của những g&igrave; bạn c&oacute; thể l&agrave;m.&nbsp;Dễ d&agrave;ng truy cập li&ecirc;n tục PC, Laptop v&agrave; thiết bị di động tr&ecirc;n chiếc&nbsp;<a href="https://mediamart.vn/tivi-samsung?f=smart-tv" target="_blank">Smart Tivi Samsung</a>&nbsp;của bạn.</p>

<p>* Kết nối từ xa với PC chỉ được hỗ trợ cho Windows 10 Professional trở l&ecirc;n v&agrave; Mac OS 10.5 trở l&ecirc;n.<br />
* Kết nối điện thoại th&ocirc;ng minh với Samsung Dex y&ecirc;u cầu một thiết bị di động tương th&iacute;ch.<br />
* T&iacute;nh khả dụng của c&aacute;c dịch vụ c&oacute; thể thay đổi m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước.<br />
* Cần c&oacute; kết nối Internet tr&ecirc;n TV v&agrave; PC.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/7(221).jpg" /></p>

<h3>Phản ứng tức th&igrave; với lệnh của bạn</h3>

<p><strong>Chế độ độ trễ thấp tự động</strong>&nbsp;- Tham gia tr&ograve; chơi nhanh hơn với Chế độ độ trễ thấp tự động (ALLM), tối ưu h&oacute;a m&agrave;n h&igrave;nh của bạn để bạn c&oacute; nhiều quyền điều khiển hơn với độ trễ đầu v&agrave;o hầu như kh&ocirc;ng đ&aacute;ng kể.&nbsp;Trải nghiệm chơi game mượt m&agrave; ở h&igrave;nh thức ấn tượng nhất m&agrave; kh&ocirc;ng bị nh&ograve;e chuyển động v&agrave; rung.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/levant-feature-instantly-reacts-to-your-commands-379601320.gif" /></p>

<h3>Chỉ cần nhấn để kết nối</h3>

<p><strong>Nhấn v&agrave;o Xem</strong>&nbsp;- Chiếu điện thoại của bạn l&ecirc;n TV chỉ bằng một lần nhấn để tiếp tục thưởng thức phim, nhạc v&agrave; ứng dụng tr&ecirc;n m&agrave;n h&igrave;nh lớn hơn trong v&ograve;ng v&agrave;i gi&acirc;y.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2021-2-News/s0iG4Crt96dwzdk.jpg" /></p>

<h3>Xem tất cả tr&ecirc;n một m&agrave;n h&igrave;nh</h3>

<p><strong>Nhiều chế độ xem&nbsp;MultiView,&nbsp;TapView</strong>&nbsp;-&nbsp;Xem nội dung tr&ecirc;n TV v&agrave; điện thoại di động của bạn tr&ecirc;n c&ugrave;ng một m&agrave;n h&igrave;nh c&ugrave;ng một l&uacute;c.&nbsp;Cho d&ugrave; đ&oacute; l&agrave; số liệu thống k&ecirc; trực tiếp về thể thao hay video hướng dẫn cho tr&ograve; chơi, chỉ cần kết nối điện thoại với nhiều m&agrave;n h&igrave;nh của bạn hơn bao giờ hết.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(849).jpg" /></p>

<h3>Chọn bất kỳ trợ l&yacute; giọng n&oacute;i n&agrave;o bạn đ&atilde; quen</h3>

<p><strong>Nhiều trợ l&yacute; giọng n&oacute;i</strong>&nbsp;- Chọn trợ l&yacute; giọng n&oacute;i y&ecirc;u th&iacute;ch của bạn;&nbsp;Bixby, Amazon Alexa hoặc Trợ l&yacute; Google.&nbsp;Lần đầu ti&ecirc;n, tất cả đều được t&iacute;ch hợp v&agrave;o TV Samsung của bạn để mang đến trải nghiệm giải tr&iacute; tối ưu v&agrave; khả năng điều khiển ti&ecirc;n tiến trong ng&ocirc;i nh&agrave; kết nối của bạn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(738).jpg" /></p>

<h3>Kiểm so&aacute;t thiết bị cũ v&agrave; mới</h3>

<p><strong>SmartThings&nbsp;</strong>-&nbsp;Cho ph&eacute;p&nbsp;<a href="https://mediamart.vn/tivi" target="_blank">TV</a>&nbsp;của bạn tự động ph&aacute;t hiện, kết nối ngay lập tức v&agrave; hiển thị trực quan tất cả c&aacute;c thiết bị xung quanh TV của bạn.&nbsp;Digital Butler kh&ocirc;ng chỉ hỗ trợ thiết bị di động / cam / IoT / Smart m&agrave; c&ograve;n bao gồm c&aacute;c thiết bị cũ.&nbsp;Bạn c&oacute; thể điều khiển thiết bị trực tiếp bằng remote hoặc giọng n&oacute;i khi xem TV.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(855).jpg" /></p>

<h3>Truyền h&igrave;nh&nbsp;miễn ph&iacute;</h3>

<p><strong>Samsung TV Plus -&nbsp;</strong>Thưởng thức h&agrave;ng ngh&igrave;n giờ xem TV, phim, thể thao miễn ph&iacute; với 150 k&ecirc;nh v&agrave; đang ph&aacute;t triển.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/5(404).jpg" /></p>

<h3>D&agrave;nh thời gian xem, kh&ocirc;ng phải t&igrave;m kiếm</h3>

<p>Đ&aacute;p ứng trải nghiệm duyệt web chuyển tiếp nội dung gi&uacute;p tăng tốc độ t&igrave;m kiếm nội dung cần xem tr&ecirc;n TV trực tiếp v&agrave; OTT.&nbsp;Giờ đ&acirc;y, thật dễ d&agrave;ng để t&igrave;m tất cả c&aacute;c bộ phim v&agrave; chương tr&igrave;nh truyền h&igrave;nh y&ecirc;u th&iacute;ch của bạn ở một nơi.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(617).jpg" /></p>

<h3>Chăm s&oacute;c sức khỏe tại nh&agrave;</h3>

<p><strong>Samsung Health</strong>&nbsp;-&nbsp;L&agrave;m chủ to&agrave;n bộ th&oacute;i quen chăm s&oacute;c sức khỏe cho t&acirc;m tr&iacute; v&agrave; cơ thể của bạn v&agrave; vượt qua c&aacute;c mục ti&ecirc;u của bạn với nội dung từ c&aacute;c đối t&aacute;c h&agrave;ng đầu trong ng&agrave;nh thể dục v&agrave; quản l&yacute; số liệu thống k&ecirc; h&agrave;ng ng&agrave;y của bạn từ ứng dụng Samsung Health.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/3(611).jpg" /></p>

<h3>Gallery:</h3>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/1(856).jpg" /></p>

<p><img src="https://cdn.mediamart.vn/images/Upload/images/2(744).jpg" /></p>
', N'smart-tivi-lg-32-inch-32lm575bptc-fhd-thinq-ai-163uqC.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (39, 5, 7, N'Tủ đông Kangaroo KG399NC1 286 Lít - Kháng khuẩn', N'tu-dong-kangaroo-kg399nc1-286-lit-khang-khuan', 87890000.0000, N'KG399NC1', 75, 12, N'Việt Nam', 0, N'Công nghệ Digital Inverter tiết kiệm điện năng lên đến 50%Công nghệ Nano bạc kháng khuẩn giúp thực phẩm luôn tươi ngon, thời gian bảo quản được lâu hơn.Trang bị máy nén Panasonic made in Singapore hoạt động êm ái, độ bền cao.', N'<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2020-4-News/757Mcuj0J8Ka1O1.jpg" /></strong></p>

<h3><strong>Dung t&iacute;ch 399 L&iacute;t&nbsp;</strong></h3>

<p>Mẫu&nbsp;<em><a href="https://mediamart.vn/tu-dong/kangaroo/tu-dong-kangaroo-kg399nc1-286-lit-khang-khuan.htm">tủ đ&ocirc;ng Kangaroo KG399NC1</a>&nbsp;</em>c&oacute; dung t&iacute;ch 399 L&iacute;t ph&ugrave; hợp để bảo quản rất nhiều loại thực phẩm kh&aacute;c nhau với số lượng lớn. Tủ c&oacute; thể sử dụng cho c&aacute;c hộ kinh doanh nhỏ lẻ hoặc những gia đ&igrave;nh đ&ocirc;ng người thường xuy&ecirc;n t&iacute;ch trữ đồ đ&ocirc;ng lạnh.</p>

<h3><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2020-4-News/nj0Ir0SST6X0wc5.jpg" /></strong></h3>

<h3>C&ocirc;ng nghệ INVERTER tiết kiệm điện năng</h3>

<p><em><strong>Tủ động&nbsp;<a href="https://mediamart.vn/tu-dong/kangaroo/tu-dong-kangaroo-kg399nc1-286-lit-khang-khuan.htm">Kangaroo KG399NC1</a></strong></em>&nbsp;sử dụng d&agrave;n l&agrave;m lạnh bằng đồng nguy&ecirc;n chất c&ugrave;ng c&ocirc;ng nghệ Inverter tiết kiệm điện năng đem lại khả năng l&agrave;m lạnh nhanh l&ecirc;n đến 30% v&agrave; tiết kiệm điện lện 50%.</p>

<p><strong><img src="https://cdn.mediamart.vn/images/Upload/download/2020-4-News/85dREQ7Yr0KAO6T.jpg" />&nbsp;</strong></p>

<h3>Nhiều thiết kế tiện lợi, linh hoạt</h3>

<p>Cũng giống như nhiều mẫu tủ đ&ocirc;ng kh&aacute;ng khuẩn kh&aacute;c,&nbsp;<strong>Kangaroo&nbsp;<em>KG399NC1</em></strong>&nbsp;thiết kế bảng điều khiển nhiệt độ ngay b&ecirc;n ngo&agrave;i th&acirc;n tủ để người d&ugrave;ng c&oacute; thể dễ d&agrave;ng điều chỉnh nhiệt độ t&ugrave;y &yacute; sao cho ph&ugrave; hợp với từng loại, từng lượng thực phẩm kh&aacute;c nhau chỉ với một thao t&aacute;c vặn n&uacute;m đơn giản. Ngo&agrave;i ra,&nbsp;<a href="https://mediamart.vn/tu-dong/" target="_blank"><strong>tủ đ&ocirc;ng</strong></a>&nbsp;Kangaroo KG399NC1 cũng được trang bị bộ cảm ứng nhiệt độ tủ để tủ tự c&acirc;n bằng nhiệt độ ph&ugrave; hợp.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-4-News/TJ6V0E1uGKikqwZ.jpg" /></p>

<p>B&ecirc;n cạnh đ&oacute;,&nbsp;<a href="https://mediamart.vn/tu-dong/kangaroo/" target="_blank"><strong>Tủ đ&ocirc;ng Kangaroo</strong></a>&nbsp;c&ograve;n thiết kế lỗ tho&aacute;t nước ngo&agrave;i để lượng nước dư thừa trong tủ lạnh c&oacute; thể chảy ra ngo&agrave;i m&agrave; kh&ocirc;ng bị dồn ứ lại trong tủ lạnh, đồng thời khi vệ sinh tủ lạnh cũng lấy cặn nước bẩn ra khỏi tủ một c&aacute;ch dễ d&agrave;ng hơn.</p>

<p>Sản phẩm n&agrave;y c&oacute; giỏ đựng linh hoạt gi&uacute;p bạn quản l&yacute; thực phẩm một c&aacute;ch ngăn nắp, gọn g&agrave;ng v&agrave; th&ocirc;ng minh nhất</p>
', N'-K2pI20.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (40, 5, 2, N'Tủ đông Kangaroo 90L KG168NC1', N'tu-dong-kangaroo-90l-kg168nc1', 4490000.0000, N'KG168NC1', 43, 12, N'Việt Nam', 11, N'Model Tủ đông kháng khuẩn 1 ngăn – 1 cánhLòng tủ sử dụng công nghệ Nano bạc kháng khuẩnTrang bị máy nén LG made in Korea hoạt động êm ái, độ bền cao.', N'<p>Tủ đ&ocirc;ng kh&aacute;ng khuẩn Kangaroo&nbsp;KG168NC1&nbsp;được thiết kế với kiểu d&aacute;ng nhỏ gọn, thiết kế bo viền 4 g&oacute;c sang trọng, vỏ ngo&agrave;i c&oacute; gam m&agrave;u trắng đẹp mắt. Đặc biệt dưới ch&acirc;n tủ c&oacute; b&aacute;nh xe, dễ d&agrave;ng di chuyển khi muốn thay đổi vị tr&iacute; đặt tủ n&ecirc;n ph&ugrave; hợp với nhiều kh&ocirc;ng gian kh&aacute;c nhau. Tủ được thiết kế 1 ngăn 1 c&aacute;nh tiện lợi, với một ngăn đ&ocirc;ng c&oacute; nhiệt độ đ&ocirc;ng &le; -18&deg;C d&ugrave;ng để bảo quản thực phẩm tươi sống như thịt, c&aacute;, hải sản&hellip; rất tiện lợi.<br />
<strong>Dung t&iacute;ch 90 L&iacute;t&nbsp;</strong><br />
Mẫu&nbsp;tủ đ&ocirc;ng Kangaroo&nbsp;KG168NC1&nbsp;c&oacute; dung t&iacute;ch 90 L&iacute;t nhỏ gọn, dự trữ được rất nhiều loại thực phẩm m&agrave; kh&ocirc;ng chiếm qu&aacute; nhiều kh&ocirc;ng gian. Tủ c&oacute; thể sử dụng cho c&aacute;c hộ kinh doanh nhỏ lẻ hoặc những gia đ&igrave;nh nhỏ thường xuy&ecirc;n t&iacute;ch trữ đồ đ&ocirc;ng lạnh.<br />
<strong>L&ograve;ng tủ nh&ocirc;m phủ Nano bạc kh&aacute;ng khuẩn</strong><br />
Tủ đ&ocirc;ng kh&aacute;ng khuẩn Kangaroo KG168NC1 thiết kế l&ograve;ng nh&ocirc;m phủ Nano gi&uacute;p diệt sạch vi khuẩn g&acirc;y bệnh, chống oxy h&oacute;a, l&agrave;m sạch kh&ocirc;ng kh&iacute;&nbsp;giữ cho thực phẩm tươi ngon l&acirc;u hơn.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-12/1-4Jb6Xw.jpg" /></p>

<p><br />
<strong>D&agrave;n l&agrave;m lạnh bằng đồng nguy&ecirc;n chất c&oacute; độ bền cao</strong><br />
Tủ đ&ocirc;ng Kangaroo KG168NC1&nbsp;sử dụng d&agrave;n l&agrave;m lạnh bằng đồng nguy&ecirc;n chất c&oacute; độ bền cao gi&uacute;p n&acirc;ng cao khả năng l&agrave;m lạnh nhanh ch&oacute;ng. Tủ sử dụng kh&iacute; gas R600a rất th&acirc;n thiện với m&ocirc;i trường, an to&agrave;n cho người sử dụng.</p>

<p>&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-12/1-wlWcdS.jpg" /></p>

<p><strong>&nbsp;<br />
Nhiều thiết kế tiện lợi, linh hoạt</strong><br />
Cũng giống như nhiều mẫu tủ đ&ocirc;ng kh&aacute;ng khuẩn kh&aacute;c,&nbsp;Kangaroo KG168NC1&nbsp;thiết kế bảng điều khiển nhiệt độ ngay b&ecirc;n ngo&agrave;i th&acirc;n tủ để người d&ugrave;ng c&oacute; thể dễ d&agrave;ng điều chỉnh nhiệt độ t&ugrave;y &yacute; sao cho ph&ugrave; hợp với từng loại, từng lượng thực phẩm kh&aacute;c nhau chỉ với một thao t&aacute;c vặn n&uacute;m đơn giản. Ngo&agrave;i ra, tủ đ&ocirc;ng&nbsp;Kangaroo KG168NC1 cũng được trang bị bộ cảm ứng nhiệt độ tủ để tủ tự c&acirc;n bằng nhiệt độ ph&ugrave; hợp.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-12/1-932923.jpg" /></p>

<p><br />
&nbsp;<br />
B&ecirc;n cạnh đ&oacute;,&nbsp;Tủ đ&ocirc;ng Kangaroo&nbsp;c&ograve;n thiết kế lỗ tho&aacute;t nước ngo&agrave;i để lượng nước dư thừa trong tủ lạnh c&oacute; thể chảy ra ngo&agrave;i m&agrave; kh&ocirc;ng bị dồn ứ lại trong tủ lạnh, đồng thời khi vệ sinh tủ lạnh cũng lấy cặn nước bẩn ra khỏi tủ một c&aacute;ch dễ d&agrave;ng hơn.<br />
Sản phẩm n&agrave;y c&oacute; giỏ đựng linh hoạt gi&uacute;p bạn quản l&yacute; thực phẩm một c&aacute;ch ngăn nắp, gọn g&agrave;ng v&agrave; th&ocirc;ng minh nhất.</p>
', N'tu-dong-kangaroo-90l-kg168nc1-saZsMP.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (41, 5, 2, N'Tủ đông mềm Kangaroo 212L KG328DM2', N'tu-dong-mem-kangaroo-212l-kg328dm2', 9390000.0000, N'KG328DM2', 73, 12, N'Việt Nam', 15, N'Dung tích ngăn mát: 86 lít, Dung tích ngăn đông: 126 lítDàn làm lạnh bằng đồng 99.99%Có chức năng kháng khuẩn trong lòng tủ & trên tay cầm', N'<ul>
	<li>Tủ đ&ocirc;ng mềm Kangaroo gi&uacute;p thực phẩm ngo&agrave;i chức năng cấp đ&ocirc;ng. K&egrave;m theo đ&oacute; l&agrave; chức năng bảo quản đ&ocirc;ng mềm, đ&oacute; l&agrave; qu&aacute; tr&igrave;nh xử l&yacute; l&agrave;m ức chế sự ph&aacute;t triển của vi khuẩn, l&agrave;m giảm sự ph&aacute; vỡ li&ecirc;n kết tế b&agrave;o giữ cho thực phẩm được tươi ngon v&agrave; giữ trọn hương vị.</li>
	<li>Nhiệt độ ngăn đ&ocirc;ng mềm được duy tr&igrave; trong khoảng từ -3 đến -7 độ C.</li>
</ul>

<ul>
	<li><img src="https://kangaroo.vn/wp-content/uploads/avatar-2.jpg-2-2.jpg" />
	<p>Nhiệt độ ngăn đ&ocirc;ng mềm được giữ từ -3 đến -7 độ C</p>

	<p>Hai d&agrave;n lạnh độc lập bằng đồng 99.99% l&agrave;m lạnh nhanh: D&agrave;n lạnh ngăn đ&ocirc;ng mềm &ndash; D&agrave;n lạnh ngăn m&aacute;t</p>
	</li>
	<li>Tủ đ&ocirc;ng mềm Kangaroo kiểm so&aacute;t nhiệt độ ch&iacute;nh x&aacute;c cao với bộ điều khiển nhiệt độ điện tử</li>
</ul>

<ul>
	<li><img src="https://kangaroo.vn/wp-content/uploads/t%E1%BB%A7-%C4%91%C3%B4ng-m%E1%BB%81m-kh%C3%A1ng-khu%E1%BA%A9n.jpg" />
	<p>Tủ đ&ocirc;ng mềm kh&aacute;ng khuẩn</p>

	<p>C&ocirc;ng nghệ nano bạc kh&aacute;ng khuẩn: bảo quản thực phẩm tốt hơn, tr&aacute;nh nhiễm khuẩn ch&eacute;o</p>
	</li>
	<li>Gas R600a hiệu suất l&agrave;m lạnh cao, th&acirc;n thiện với m&ocirc;i trường</li>
	<li>M&aacute;y n&eacute;n LG c&oacute; độ ồn thấp, vận h&agrave;nh &ecirc;m &aacute;i</li>
	<li>PU c&aacute;ch nhiệt: C5H10 &ndash; (CFC-free) Cyclopentane th&acirc;n thiện m&ocirc;i trường</li>
	<li>Ngăn m&aacute;t điều chỉnh nhiệt độ ph&ugrave; hợp với bảo quản từng loại thực phẩm kh&aacute;c nhau</li>
</ul>
', N'-w89YJA.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (42, 5, 2, N'Tủ đông Kangaroo KG308C1 308 Lít - Kháng khuẩn', N'tu-dong-kangaroo-kg308c1-308-lit-khang-khuan', 9890000.0000, N'KG308C1', 85, 12, N'Việt Nam', 17, N'Dung tích Tổng/Thực: 308/278L, Công nghệ Digital Inverter tiết kiệm điện năng lên đến 50%Công nghệ Nano bạc kháng khuẩn giúp thực phẩm luôn tươi ngon, thời gian bảo quản được lâu hơn.', N'<p>Ở tủ đ&ocirc;ng, l&ograve;ng tủ l&agrave; nơi chứa nhiều loại vi khuẩn nhất, nếu kh&ocirc;ng muốn n&oacute;i l&agrave; ổ vi khuẩn với nguy cơ l&acirc;y nhiễm ch&eacute;o giữa c&aacute;c loại thực phẩm với nhau. Ch&iacute;nh v&igrave; vậy, một lớp&nbsp;nano bạc được Kangaroo tr&aacute;ng l&ecirc;n bề mặt l&ograve;ng&nbsp;<strong>Tủ đ&ocirc;ng Kangaroo</strong>&nbsp;gi&uacute;p vị tr&iacute; n&agrave;y lu&ocirc;n sạch khuẩn, ngo&agrave;i ra, c&aacute;c ph&acirc;n tử bạc cũng gi&uacute;p chống oxy h&oacute;a, l&agrave;m sạch kh&ocirc;ng kh&iacute;&nbsp;<strong>giữ cho thực phẩm tươi ngon l&acirc;u hơn</strong>.</p>

<p>Tủ đ&ocirc;ng kh&aacute;ng khuẩn Kangaroo&nbsp;KG308C1 m&agrave;u x&aacute;m bạc&nbsp;với d&agrave;n lạnh bằng đồng nguy&ecirc;n chất, l&agrave;m lạnh nhanh,1 ngăn 2 c&aacute;nh mở. B&ecirc;n ngo&agrave;i được l&agrave;m bằng nhựa ABS nguy&ecirc;n chất, c&oacute; độ bền cao. Đặc biệt dưới ch&acirc;n tủ c&oacute; b&aacute;nh xe, dễ d&agrave;ng di chuyển khi muốn thay đổi vị tr&iacute; đặt tủ.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2018-8-News/G3voEzwAFiZc462.jpg" /></p>
', N'tu-dong-kangaroo-kg308c1-308-lit-khang-khuan-gl81GH.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (43, 5, 2, N'Tủ đông Kangaroo KG235VC1 230 Lít - Kháng khuẩn', N'tu-dong-kangaroo-kg235vc1-230-lit-khang-khuan', 4990000.0000, N'KG235VC1', 347, 12, N'Việt Nam', 12, N'- Tủ đông kháng khuẩn: 1 ngăn 1 cánh- Màu xám bạc sang trọng hiện đại.- Đèn chiếu sang, 2 cánh kính trượt - Tay nắm nổi có khóa/ Lòng nhôm sơn tĩnh điện phủ Nano bạc ', N'<h3>Tủ đ&ocirc;ng c&oacute; k&iacute;ch thước nhỏ gọn, kh&ocirc;ng chiếm nhiều kh&ocirc;ng gian diện t&iacute;ch</h3>

<p><a href="https://mediamart.vn/tu-dong/kangaroo/tu-dong-kangaroo-kg235vc1-230-lit-khang-khuan.htm" target="_blank">Tủ đ&ocirc;ng Kangaroo 235 l&iacute;t KG235VC1&nbsp;</a>c&oacute; kiểu d&aacute;ng 1 ngăn, một c&aacute;nh mở, đơn giản, nhỏ gọn sẽ kh&ocirc;ng chiếm nhiều kh&ocirc;ng gian diện t&iacute;ch của gia đ&igrave;nh bạn. Đi c&ugrave;ng&nbsp;<a href="https://mediamart.vn/tu-dong?&amp;loc=duoi-300-lit" target="_blank">dung t&iacute;ch tổng l&agrave; 235 l&iacute;t</a>, tủ đ&ocirc;ng l&agrave; sự lựa chọn l&yacute; tưởng cho gia đ&igrave;nh sử dụng hoặc d&ugrave;ng cho hộ kinh doanh nhỏ lẻ.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-6-News/OQr4D3pw503P1bU.jpg" /></p>

<h3>Sử dụng&nbsp;gas R600a&nbsp;th&acirc;n thiện với tầng Ozone, l&agrave;m lạnh nhanh ch&oacute;ng</h3>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-6-News/8p523xMvaL126LZ.jpg" /></p>

<h3>D&agrave;n lạnh bằng đồng vận h&agrave;nh bền bỉ, đ&ocirc;ng lạnh nhanh ch&oacute;ng</h3>

<p><a href="https://mediamart.vn/tu-dong" target="_blank">Tủ đ&ocirc;ng</a>&nbsp;c&oacute; d&agrave;n lạnh được l&agrave;m từ chất liệu đồng nguy&ecirc;n chất. Nhờ vậy, tủ kh&ocirc;ng chỉ gi&uacute;p đ&ocirc;ng lạnh thực phẩm nhanh hơn đến 30% m&agrave; c&ograve;n đảm bảo độ vận h&agrave;nh bền bỉ với thời gian.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-6-News/jJCFvh1IE1Ax03A.jpg" /></p>

<h3>L&ograve;ng tủ được phủ Nano Silver kh&aacute;ng khuẩn, khử m&ugrave;i hiệu quả</h3>

<p>Giờ đ&acirc;y, với l&ograve;ng tủ được phủ lớp Nano Silver với c&aacute;c ph&acirc;n tử bạc kh&aacute;ng khuẩn, khử m&ugrave;i, bạn sẽ kh&ocirc;ng c&ograve;n phải lo lắng về vi khuẩn g&acirc;y hại, m&ugrave;i h&ocirc;i kh&oacute; chịu của thực phẩm b&aacute;m v&agrave;o tủ đ&ocirc;ng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-6-News/ltw2Z18oS8B6Q6c.jpg" /></p>

<h3>T&iacute;ch hợp nhiều tiện &iacute;ch cho người sử dụng</h3>

<p>B&ecirc;n cạnh những c&ocirc;ng nghệ l&agrave;m lạnh, tủ đ&ocirc;ng Kangaroo KG235VC1 c&ograve;n mang đến cho người sử dụng nhiều tiện &iacute;ch nổi bật:</p>

<ul>
	<li><strong>Kh&oacute;a an to&agrave;n</strong>: Đối với gia đ&igrave;nh c&oacute; trẻ nhỏ, trang bị kh&oacute;a an to&agrave;n của&nbsp;<a href="https://mediamart.vn/tu-dong/kangaroo?" target="_blank">tủ đ&ocirc;ng Kangaroo</a>&nbsp;sẽ ngăn chặn trẻ nghịch ph&aacute;, mở cửa tủ nhiều lần g&acirc;y thất tho&aacute;t hơi lạnh, ảnh hưởng đến thực phẩm.</li>
	<li><strong>4 b&aacute;nh xe xoay đa chiều</strong>: Gi&uacute;p cho việc di chuyển, thay đổi vị tr&iacute; hay lau dọn sau lưng tủ trở n&ecirc;n dễ d&agrave;ng hơn bao giờ hết.</li>
	<li><strong>Đ&egrave;n chiếu s&aacute;ng</strong>: Cho ph&eacute;p bạn dễ d&agrave;ng quan s&aacute;t thực phẩm b&ecirc;n trong tủ.</li>
</ul>
', N'tu-dong-kangaroo-kg235vc1-230-lit-khang-khuan-0LooS2.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (44, 5, 4, N'Tủ Đông LG Inverter 165L GN-F304PS', N'tu-dong-lg-inverter-165l-gn-f304ps', 6190000.0000, N'GN-F304PS', 336, 12, N'Việt Nam', 0, N'Tay cầm thời trang, tiện lợi và không lo bị gãy tay cầm.Thiết kế cửa bạch kim hoàn thiện, đẹp mắt.Làm lạnh nhanh, tiết kiệm điện với máy nén Inverter.', N'<p>Tay cầm thời trang, tiện lợi v&agrave; kh&ocirc;ng lo bị g&atilde;y tay cầm<br />
Tay cầm của&nbsp;<a href="https://mediamart.vn/tu-dong/lg/tu-dong-lg-inverter-165l-gnf304ps.htm">tủ đ&ocirc;ng LG 165 l&iacute;t GN-F304PS</a>&nbsp;được thiết kế m&agrave;u đen b&oacute;ng, nổi bật tr&ecirc;n nền bạch kim của cửa tủ, gi&uacute;p tủ th&ecirc;m sang trọng v&agrave; nổi bật hơn.<br />
Ngo&agrave;i ra, kh&aacute;c với những kiểu tủ truyền thống l&agrave; tay cầm được lắp nổi tr&ecirc;n bề mặt cửa th&igrave; ở dạng tủ đ&ocirc;ng n&agrave;y, tay cầm được thiết kế ch&igrave;m b&ecirc;n trong c&aacute;nh cửa, gi&uacute;p thao t&aacute;c đ&oacute;ng - mở cửa tủ dễ d&agrave;ng hơn, gọn g&agrave;ng v&agrave; kh&ocirc;ng lo bị g&atilde;y khi vận chuyển, lắp đặt, sử dụng.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-9/1-8987aH.jpg" /></p>

<p><br />
Thiết kế cửa bạch kim ho&agrave;n thiện, l&agrave;m ph&ograve;ng bếp trở n&ecirc;n s&agrave;nh điệu hơn<br />
C&ugrave;ng với tay cầm th&igrave; cửa của&nbsp;tủ đ&ocirc;ng&nbsp;n&agrave;y c&oacute; m&agrave;u bạch kim rất s&agrave;nh điệu, gi&uacute;p l&agrave;m s&aacute;ng l&ecirc;n nội thất b&ecirc;n trong ph&ograve;ng bếp của bạn, th&iacute;ch hợp với nhiều kh&ocirc;ng gian nội thất, chiều l&ograve;ng mọi gu thẩm mĩ kh&oacute; t&iacute;nh của người ti&ecirc;u d&ugrave;ng.</p>

<p>&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-9/1-36R0Cv.jpg" /></p>

<p><br />
L&agrave;m lạnh nhanh, tiết kiệm điện với&nbsp;<a href="https://mediamart.vn/tu-dong/lg/?&amp;loc=cong-nghe-inverter">m&aacute;y n&eacute;n Inverter</a><br />
Sản phẩm tủ đ&ocirc;ng LG n&agrave;y sử dụng c&ocirc;ng nghệ l&agrave;m lạnh trực tiếp c&ugrave;ng việc t&iacute;ch hợp c&ocirc;ng nghệ Inverter gi&uacute;p l&agrave;m lạnh nhanh,&nbsp;duy tr&igrave; được nhiệt độ lạnh ph&ugrave; hợp m&agrave; hoạt động vẫn &ecirc;m &aacute;i v&agrave; giảm thiểu tiếng ồn.<br />
Ngo&agrave;i ra c&ocirc;ng nghệ n&agrave;y c&ograve;n gi&uacute;p tiết kiệm điện hiệu quả, với c&ocirc;ng suất ti&ecirc;u thụ c&ocirc;ng bố theo TCVN l&agrave; 399 kWh/năm, giải tỏa nỗi lo chi ph&iacute; tiền điện h&agrave;ng th&aacute;ng.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-9/1-L0h5QW.jpg" /></p>

<p><br />
L&agrave;m m&aacute;t nhanh, đều hơn nhờ c&ocirc;ng nghệ l&agrave;m m&aacute;t kệ<br />
Thực phẩm lưu trữ tr&ecirc;n&nbsp;tủ đ&ocirc;ng inverter&nbsp;n&agrave;y được l&agrave;m lạnh, đ&ocirc;ng nhanh ch&oacute;ng gi&uacute;p nhiệt độ tỏa đều mọi nơi trong tủ nhờ c&ocirc;ng nghệ l&agrave;m m&aacute;t kệ.</p>

<p>&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-9/1-VaR5gn.jpg" /></p>

<p><br />
Dung t&iacute;ch&nbsp;<a href="https://mediamart.vn/tu-dong/lg/?&amp;loc=cong-nghe-inverter">165 l&iacute;t</a>, sự lựa chọn l&yacute; tưởng cho gia đ&igrave;nh c&oacute; 2 - 3 th&agrave;nh vi&ecirc;n<br />
Thiết kế dưới dạng tủ đơn, chiếc tủ đ&ocirc;ng n&agrave;y sở hữu dung t&iacute;ch 165 l&iacute;t th&iacute;ch hợp với nhu cầu sử dụng của gia đ&igrave;nh nhỏ từ 2 - 3 th&agrave;nh vi&ecirc;n, đảm bảo tiết kiệm chi ph&iacute; m&agrave; vẫn đ&aacute;p ứng nhu cầu bảo quản thực phẩm.</p>

<p>&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-9/1-yxj9zE.jpg" /></p>

<p><br />
Tiết kiệm kh&ocirc;ng gian, ph&ugrave; hớp với căn hộ nhỏ khi bề ngang tủ hẹp (530mm)<br />
Một ưu điểm kh&aacute;c của chiếc tủ n&agrave;y so với những tủ đ&ocirc;ng truyền thống kh&aacute;c l&agrave; tủ được thiết kế dạng đứng, k&iacute;ch thước chiều d&agrave;i - rộng chỉ đến 53cm - 60cm, gi&uacute;p bạn tiết kiệm diện t&iacute;ch hơn, đặc biệt l&agrave; với những căn ph&ograve;ng c&oacute; kh&ocirc;ng gian hẹp th&igrave; đ&acirc;y l&agrave; lựa chọn hợp l&yacute;.</p>

<p>&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-9/1-x107hh.jpg" /></p>

<p><br />
Linh hoạt, lưu trữ đa dạng thực phẩm với thiết kế 6 kệ v&agrave; 1 hộc tủ<br />
C&aacute;c ngăn chứa của tủ lạnh được chia đều th&agrave;nh 6 kệ v&agrave; 1 hộc tủ, gi&uacute;p lưu trữ được đa dạng c&aacute;c loại thực phẩm m&agrave; kh&ocirc;ng bị lẫn v&agrave;o nhanh, phục vụ tốt hơn cho nhu cầu bảo quản thực phẩm của người ti&ecirc;u d&ugrave;ng.</p>

<p>&nbsp;</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2020-9/1-sM3fjA.jpg" /></p>

<p><br />
Tủ đ&ocirc;ng LG 165 l&iacute;t GN-F304PS c&oacute;&nbsp;thiết kế nhỏ gọn, dạng đứng v&ocirc; c&ugrave;ng sang trọng, tiện lợi v&agrave; mới lạ, với c&aacute;c c&ocirc;ng nghệ hiện đại c&ugrave;ng khả năng tiết kiệm điện th&igrave; sản phẩm n&agrave;y sẽ gi&uacute;p cho gia đ&igrave;nh bạn bảo quản thực phẩm tươi ngon v&agrave; đảm bảo vệ sinh một c&aacute;ch hiệu quả nhất.</p>
', N'-6VZiTQ.png', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (45, 5, 4, N'Tủ Đông LG Inverter 165L GN-F304WB', N'tu-dong-lg-inverter-165l-gn-f304wb', 6690000.0000, N'GN-F304WB', 94, 12, N'Việt Nam', 21, N'Sang trọng, chắn chắc với tay cầm dạng âm vào trong.Kiểu dáng thon gọn, tinh tế.Vận hành êm ái, tiết kiệm điện năng với công nghệ Inverter.', N'<p>Sang trọng, kh&ocirc;ng lo bị vướn, g&atilde;y với tay cầm dạng &acirc;m v&agrave;o trong<br />
<a href="https://mediamart.vn/tu-dong/lg/tu-dong-lg-inverter-165l-gnf304wb.htm">Tủ đ&ocirc;ng LG 165 l&iacute;t GN-F304WB</a>&nbsp;c&oacute; tay cầm m&agrave;u đen b&oacute;ng sang trọng, vững chắc, tiết kiệm kh&ocirc;ng gian nội thất một c&aacute;ch tối đa với thiết kế ch&igrave;m tinh tế, người d&ugrave;ng c&oacute; thể dễ d&agrave;ng sử dụng, vận chuyển m&agrave; kh&ocirc;ng cần lo lắng vấn đề tay cầm sẽ bị g&atilde;y.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/1(746).jpg" /><br />
Kiểu d&aacute;ng thon gọn, tinh tế<br />
<a href="https://mediamart.vn/tu-dong/lg/">Tủ đ&ocirc;ng LG</a>&nbsp;165 l&iacute;t GN-F304WB&nbsp;c&oacute; kiểu d&aacute;ng nhỏ gọn v&ocirc; c&ugrave;ng tinh tế, lớp sơn tĩnh điện m&agrave;u đen sang trọng, gi&uacute;p tủ c&oacute; thể h&agrave;i h&ograve;a với kh&ocirc;ng gian người d&ugrave;ng một c&aacute;ch dễ d&agrave;ng m&agrave; kh&ocirc;ng tốn nhiều diện t&iacute;ch.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/2(646).jpg" /><br />
Vận h&agrave;nh &ecirc;m &aacute;i, tiết kiệm điện năng với&nbsp;<a href="https://mediamart.vn/tu-dong/lg?&amp;loc=cong-nghe-inverter">c&ocirc;ng nghệ Inverter</a><br />
Tủ đ&ocirc;ng&nbsp;LG được t&iacute;ch hợp m&aacute;y n&eacute;n Inverter vận h&agrave;nh bền bỉ, bảo h&agrave;nh l&ecirc;n tới 10 năm, c&ugrave;ng khả năng hoạt động &ecirc;m &aacute;i, hạn chế tiếng ồn một c&aacute;ch tối ưu. Đồng thời gi&uacute;p l&agrave;m lạnh thực phẩm nhanh ch&oacute;ng, duy tr&igrave; độ lạnh ph&ugrave; hợp m&agrave; vẫn tiết kiệm điện năng cho gia đ&igrave;nh, giảm thiểu chi ph&iacute; hằng th&aacute;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/3(535).jpg" /><br />
L&agrave;m m&aacute;t thực phẩm một c&aacute;ch nhanh ch&oacute;ng với c&ocirc;ng nghệ l&agrave;m m&aacute;t kệ<br />
Thực phẩm khi lưu trữ tr&ecirc;n chiếc&nbsp;tủ đ&ocirc;ng inverter&nbsp;n&agrave;y được đảm bảo l&agrave;m lạnh đều, hơi lạnh lan tỏa mọi ng&oacute;c ng&aacute;ch của tủ nhờ c&ocirc;ng nhệ l&agrave;m m&aacute;t kệ gi&uacute;p bảo quản an to&agrave;n, l&agrave;m lạnh nhanh ch&oacute;ng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/4(417).jpg" /><br />
Tiết kiệm kh&ocirc;ng gian gia đ&igrave;nh bạn với bề ngang tủ hẹp chỉ 530 mm<br />
Kh&aacute;c biệt với những sản phẩm hay thấy ngo&agrave;i thị trường, tủ đ&ocirc;ng LG GN-F304WB c&oacute; thiết kế dạng đứng mới lạ. Với bề ngang chỉ 530 mm, nhỏ hơn cả so với tủ lạnh th&ocirc;ng thường sẽ gi&uacute;p tiết kiệm diện t&iacute;ch một c&aacute;ch tối ưu, mang lại cho kh&ocirc;ng gian gia đ&igrave;nh bạn n&eacute;t độc đ&aacute;o nhưng kh&ocirc;ng k&eacute;m phần sang trọng.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/5(356).jpg" /><br />
Sử dụng thoải m&aacute;i với dung t&iacute;ch tủ l&ecirc;n tới&nbsp;<a href="https://mediamart.vn/tu-dong/lg/?&amp;loc=duoi-300-lit">165 l&iacute;t</a><br />
Dung t&iacute;ch tủ 165 l&iacute;t gi&uacute;p bạn c&oacute; thể sử dụng v&agrave; bảo quản thực phẩm một c&aacute;ch thoải m&aacute;i. Tủ th&iacute;ch hợp sử dụng cho những gia đ&igrave;nh nhỏ, học sinh - sinh vi&ecirc;n, c&aacute; nh&acirc;n khi nhu cầu sử dụng &iacute;t.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/6(252).jpg" /><br />
Bảo quản nhiều loại thực phẩm với 6 kệ v&agrave; 1 hộc tủ<br />
Tủ được chia đều với 6 kệ v&agrave; 1 hộc tủ, gi&uacute;p bạn c&oacute; thể ph&acirc;n chia v&agrave; bảo quản thực phẩm một c&aacute;ch tiện lợi nhất, thức ăn lu&ocirc;n giữ được hương vị tươi ngon m&agrave; kh&ocirc;ng mất đi c&aacute;c chất dinh dưỡng, kh&ocirc;ng bị lẫn lộn với nhau trong qu&aacute; tr&igrave;nh bảo quản. C&aacute;c ngăn chứa được l&agrave;m từ chất liệu cao cấp c&oacute; khả năng chịu lực tốt, đồng thời c&oacute; thể dễ d&agrave;ng lau ch&ugrave;i, vệ sinh.<br />
<img src="https://cdn.mediamart.vn/images/Upload/images/7(198).jpg" /><br />
Tủ đ&ocirc;ng&nbsp;LG GN-F304WB với thiết kế nhỏ gọn, tay cầm vững chắc v&agrave; kiểu d&aacute;ng mới lạ, sử dụng những c&ocirc;ng nghệ hiện đại, ti&ecirc;n tiến hiện nay gi&uacute;p đem đến một sản phẩm tốt nhất đến tay người d&ugrave;ng.</p>
', N'tu-dong-lg-inverter-165l-gnf304wb-v5XMGQ.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (46, 5, 7, N'Tủ đông Sanaky 260L Inverter VH-3699W3', N'tu-dong-sanaky-260l-inverter-vh-3699w3', 7790000.0000, N'VH-3699W3', 45, 12, N'Việt Nam', 11, N'Dung tích 360L gồm 1 ngăn đông và 1 ngăn mát, thích hợp sử dụng cho gia đìnhDàn lạnh làm bằng ống đồng, nhiệt độ làm lạnh đạt đến -18 oC nhanh chóng', N'<h3>Hoạt động bền bỉ</h3>

<p><a href="https://mediamart.vn/tu-dong/sanaky/tu-dong-360l-inverter-sanaky-2-ngan-vh3699w3.htm" target="_blank">Tủ đ&ocirc;ng Sanaky VH 3699W3</a>&nbsp;l&agrave;m lạnh bằng d&agrave;n đồng nguy&ecirc;n chất si&ecirc;u bền. Hệ thống m&aacute;y n&eacute;n c&ocirc;ng nghệ Inverter l&agrave;m lạnh nhanh, vận h&agrave;nh &ecirc;m. Khe tho&aacute;t nước an to&agrave;n cho m&aacute;y, dễ vệ sinh.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-4-News/Q60k1XFkp88cl3A.jpg" /></p>

<h3>L&agrave;m lạnh nhanh ch&oacute;ng</h3>

<p><a href="https://mediamart.vn/tu-dong/sanaky" target="_blank">Tủ đ&ocirc;ng Sanaky</a>&nbsp;c&ocirc;ng nghệ Nhật, 1 ngăn đ&ocirc;ng 1 ngăn m&aacute;t. Quạt lồng s&oacute;c l&agrave;m lạnh nhanh, s&acirc;u, trữ đ&ocirc;ng an to&agrave;n, tr&aacute;nh vi khuẩn, nấm mốc.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-4-News/Mbipi9UL90HB8B1.jpg" /></p>

<h3>D&ugrave;ng gas R600A th&acirc;n thiện m&ocirc;i trường</h3>

<p>Tủ đ&ocirc;ng&nbsp;sử dụng gas R600A th&acirc;n thiện m&ocirc;i trường, đảm bảo sức khỏe người d&ugrave;ng. B&aacute;nh xe chịu lực tốt, dễ di chuyển.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-4-News/6HFwA4UxSa2523v.jpg" /></p>

<h3>Thương hiệu uy t&iacute;n, dễ điều khiển</h3>

<p>Tủ đ&ocirc;ng thương hiệu Sanaky uy t&iacute;n, c&ocirc;ng nghệ Nhật, si&ecirc;u bền, hiệu quả, Dễ sử dụng, bảng điều khiển nhiệt độ tr&ecirc;n th&acirc;n tủ.</p>

<p><img src="https://cdn.mediamart.vn/images/Upload/download/2019-4-News/2jkuwvt4zCOAk5g.jpg" /></p>
', N'-AgVmb0.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (47, 5, 7, N'Tủ đông 400L inverter SANAKY 1 NGĂN VH-4099A3', N'tu-dong-400l-inverter-sanaky-1-ngan-vh-4099a3', 7790000.0000, N'VH-4099A3', 346, 12, N'Việt Nam', 5, N'Tủ đông dung tích 400 lít bảo quản thực phẩm số lượng lớnDàn lạnh bằng đồng có độ bền caoQuạt lồng sóc làm lạnh nhanh và sâu hơnThiết kế 1 ngăn 2 cửa tiện lợi, có bánh xe dễ dàng di chuyển', N'<h3><strong>Tủ đ&ocirc;ng dung t&iacute;ch lớn</strong></h3>

<p><a href="https://mediamart.vn/tu-dong/sanaky/tu-dong-400l-inverter-sanaky-2-ngan-vh-4099w3.htm" target="_blank">Tủ đ&ocirc;ng Sanaky&nbsp;VH 4099W3</a>&nbsp;thiết kế hiện với c&ocirc;ng nghệ Nhật Bản ti&ecirc;n tiến.&nbsp;Tủ đ&ocirc;ng&nbsp;c&oacute; 2 ngăn gồm ngăn đ&ocirc;ng v&agrave; ngăn m&aacute;t với dung t&iacute;ch lớn 400 l&iacute;t sẽ l&agrave; một sự lựa chọn l&yacute; tưởng cho c&aacute;c qu&aacute;n ăn, nh&agrave; h&agrave;ng, tạp h&oacute;a lớn...d&ugrave;ng để bảo quản rau củ quả, đồ uống v&agrave; c&aacute;c loại thực phẩm thịt c&aacute; được tươi ngon, sử dụng l&acirc;u hơn, đảm bảo an to&agrave;n sức khỏe.&nbsp;</p>

<p><em><img src="https://cdn.mediamart.vn/images/Upload/download/2017-4-News/CY1kp84snV7U0xK.jpg" /></em></p>

<p><em>Tủ đ&ocirc;ng Sanaky&nbsp;VH 4099W3 dung t&iacute;ch 400 l&iacute;t</em></p>

<h3><strong>L&agrave;m lạnh nhanh</strong></h3>

<p><a href="https://mediamart.vn/tu-dong/sanaky" target="_blank">Tủ đ&ocirc;ng Sanaky</a>&nbsp;VH 4099W3&nbsp;được kế d&agrave;n lạnh bằng đồng l&agrave;m lạnh nhanh, tiết kiệm điện v&agrave; bền hơn c&aacute;c loại tủ d&ugrave;ng d&agrave;n nh&ocirc;m. Tủ đ&ocirc;ng 2 cửa c&oacute; lớp th&agrave;nh tủ d&agrave;y, chịu được va đập, độ bền cao. Tủ c&oacute; gioăng bao quanh k&iacute;n v&igrave; vậy c&oacute; khả năng giữ lạnh cao, tiết kiệm điện năng sử dụng, n&acirc;ng cao hiệu quả bảo quản thực phẩm trong thời gian d&agrave;i.</p>

<p><em><img src="https://cdn.mediamart.vn/images/Upload/download/2017-4-News/CnBQT77ppKQtnUB.jpg" /></em></p>

<p><em>Tủ đ&ocirc;ng Sanaky&nbsp;VH 4099W3&nbsp;l&agrave;m lạnh nhanh</em></p>

<h3><strong>Tiết kiệm điện</strong></h3>

<p>Nhờ được trang bị c&ocirc;ng nghệ Inverter ti&ecirc;n tiến, tủ đ&ocirc;ng Sanaky&nbsp;VH 4099W3 vận h&agrave;nh bền bỉ, &ecirc;m &aacute;i, kh&ocirc;ng g&acirc;y tiếng ồn, n&acirc;ng cao tuổi thọ sử dụng l&acirc;u d&agrave;i. Kh&ocirc;ng những thế, c&ocirc;ng nghệ n&agrave;y c&ograve;n gi&uacute;p bạn tiết kiệm được chi ph&iacute; tiền điện h&agrave;ng th&aacute;ng đ&aacute;ng kể.</p>

<p><em><img src="https://cdn.mediamart.vn/images/Upload/download/2017-4-News/4V6ut63o90ANuvP.jpg" /></em></p>

<p><em>Tủ đ&ocirc;ng Sanaky&nbsp;VH 4099W3 tiết kiệm chi ph&iacute; tiền điện</em></p>

<h3><strong>Dễ điều khiển</strong></h3>

<p>Tủ đ&ocirc;ng Sanaky&nbsp;rất dễ sử dụng, với bảng điều khiển nhiệt độ tr&ecirc;n th&acirc;n tủ rất đơn giản, gi&uacute;p bạn dễ d&agrave;ng điều chỉnh nhiệt độ theo &yacute; muốn. T&ugrave;y theo lượng thực phẩm trong tủ m&agrave; bạn c&oacute; thể chọn mức nhiệt độ th&iacute;ch hợp để bảo quản thực phẩm một c&aacute;ch tốt nhất.</p>

<p><em><img src="https://cdn.mediamart.vn/images/Upload/download/2017-4-News/4HSHMGkup8k8RPG.jpg" /></em></p>

<p><em>Tủ đ&ocirc;ng Sanaky&nbsp;VH 4099W3&nbsp;dễ điều khiển</em></p>
', N'-yyk5LR.jpg', 1)
INSERT [dbo].[Products] ([ID_Product], [ID_Category], [ID_Supplier], [Name], [UrlSlug], [Price], [Model], [Amount], [Guarantee], [Origin], [Discount], [ShortDescription], [Detail], [Image], [Status]) VALUES (48, 5, 7, N'Tủ đông Sanaky 100L VH-1599HYK', N'tu-dong-sanaky-100l-vh-1599hyk', 5990000.0000, N'VH-1599HYK', 48, 12, N'Việt Nam', 19, N'Tủ đông Sanaky VH-1599HYK mặt kính cường lực', N'<h2>Tủ đ&ocirc;ng Sanaky VH-1599HYK mặt k&iacute;nh cường lực</h2>

<p><strong>Tủ đ&ocirc;ng Sanaky VH-1599HYK</strong>&nbsp;l&agrave; d&ograve;ng tủ c&oacute; một ngăn đ&ocirc;ng một&nbsp;cửa mặt k&iacute;nh mới ra mắt của Sanaky. Với thiết kế mặt k&iacute;nh m&agrave;u x&aacute;m tinh tế v&agrave; sang trọng, sản phẩm hứa hẹn sẽ mang lại trải nghiệm mới cho người ti&ecirc;u d&ugrave;ng.</p>

<p><img src="https://sanakyvietnam.net/wp-content/uploads/tu-dong-sanaky-vh-1599hyk-600x600.jpg" /></p>

<h3>Một số t&iacute;nh năng cơ bản</h3>

<p>Model VH-1599HYK sử dụng d&agrave;n lạnh bằng ống đồng kết hợp với quạt lồng s&oacute;c gi&uacute;p cho nhiệt độ l&agrave;m lạnh b&ecirc;n trong ngăn tủ đạt đến -18&deg;C nhanh ch&oacute;ng, hơi lạnh s&acirc;u hơn gi&uacute;p tăng hiệu suất l&agrave;m lạnh của tủ. Hơn nữa độ bền của d&agrave;n đồng cao hơn so với c&aacute;c sản phẩm sử dụng d&agrave;n lạnh bằng nh&ocirc;m.</p>

<p>Thiết kế 1 ngăn v&agrave; 1 c&aacute;nh mở kiểu vali rất dễ sử dụng. Mặt tr&ecirc;n của c&aacute;nh tủ được l&agrave;m bằng k&iacute;nh cường lực, mặt k&iacute;nh phẳng sang trọng, tiện lợi khi sử dụng. Mặt k&iacute;nh bền m&agrave;u theo thời gian cũng rất dễ d&agrave;ng vệ sinh.</p>

<p>Cửa tủ cũng được lắp đặt kh&oacute;a tủ n&ecirc;n rất tiện lợi cho chủ cửa h&agrave;ng. An to&agrave;n với gia&nbsp;đ&igrave;nh c&oacute; trẻ nhỏ v&agrave; tr&aacute;nh những trường hợp mở tủ ngo&agrave;i&nbsp;&yacute; muốn.</p>

<p>L&ograve;ng&nbsp;tủ cấp đ&ocirc;ng&nbsp;Sanaky&nbsp;được l&agrave;m từ nhựa ABS cao cấp&nbsp;c&oacute; độ bền cao v&agrave; rất dễ d&agrave;ng&nbsp;để vệ sinh.</p>

<h3>Một số t&iacute;nh năng kh&aacute;c</h3>

<p>&ndash; Gas l&agrave;m lạnh của tủ&nbsp;l&agrave; loại&nbsp;R600A&nbsp;mới nhất hiện nay cho hiệu suất l&agrave;m lạnh tốt hơn,&nbsp;th&acirc;n thiện với m&ocirc;i trường v&agrave; người sử dụng.</p>

<p>&ndash; Bạn c&oacute; thể dễ d&agrave;ng&nbsp;điều chỉnh nhiệt&nbsp;độ của tủ bằng&nbsp;t&uacute;t điều chỉnh nằm ph&iacute;a trước tủ.</p>

<p>&ndash; Ch&acirc;n tủ c&oacute; 4 b&aacute;nh lăn chịu lực, thuận tiện cho việc di chuyển.</p>

<p>&ndash; Sản phẩm bảo h&agrave;nh ch&iacute;nh h&atilde;ng tại nh&agrave; trong 2 năm</p>
', N'-q4I5dm.jpg', 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([ID_Account], [UserName], [Password], [FullName], [Phone], [Address], [Email], [Avatar], [Role], [Status]) VALUES (1, N'Admin', N'Admin123456', N'Đoàn Văn Admin', N'123456789           ', N'Việt Nam', N'Admin@gmail.com', N'icons8_user_80px_1.png', 0, 1)
INSERT [dbo].[Accounts] ([ID_Account], [UserName], [Password], [FullName], [Phone], [Address], [Email], [Avatar], [Role], [Status]) VALUES (2, N'User', N'User123456', N'Đoàn Văn User', N'0975429508          ', N'Việt Nam', N'User@gmail.com', N'icons8_user_80px_1.png', 2, 1)
INSERT [dbo].[Accounts] ([ID_Account], [UserName], [Password], [FullName], [Phone], [Address], [Email], [Avatar], [Role], [Status]) VALUES (3, N'Staff', N'Staff123456', N'Đoàn Văn Staff', N'123456789           ', N'Việt Nam', N'Staff@gmail.com', N'icons8_user_80px_1.png', 1, 1)
INSERT [dbo].[Accounts] ([ID_Account], [UserName], [Password], [FullName], [Phone], [Address], [Email], [Avatar], [Role], [Status]) VALUES (4, N'LinhDoan', N'Linh123456', N'Linh Đoàn', N'0975429509          ', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'IMG_20200422_115748 (1).png', 2, 1)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Carts] ON 

INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (1, 19, 2, 1, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (2, 39, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (3, 44, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (4, 45, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (5, 11, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (6, 12, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (7, 13, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (8, 22, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (9, 23, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (10, 26, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (11, 20, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (12, 29, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (13, 31, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (14, 33, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (15, 8, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (16, 9, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (17, 43, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (18, 14, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (19, 15, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (20, 16, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (21, 32, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (22, 33, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (23, 38, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (24, 40, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (25, 10, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (26, 35, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (27, 41, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (28, 14, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (29, 36, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (30, 27, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (31, 24, 4, 0, NULL)
INSERT [dbo].[Carts] ([ID_Cart], [ID_Product], [ID_Account], [Amount], [Status]) VALUES (32, 23, 4, 0, NULL)
SET IDENTITY_INSERT [dbo].[Carts] OFF
GO
SET IDENTITY_INSERT [dbo].[Bills] ON 

INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (1, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-10-21' AS Date), 5)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (2, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 5)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (3, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 6)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (4, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 4)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (5, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 4)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (6, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 4)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (7, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 3)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (8, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 3)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (9, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 3)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (10, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 2)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (11, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 2)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (12, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 2)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (13, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-12-21' AS Date), 2)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (14, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-11-21' AS Date), 5)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (15, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-1-21' AS Date), 5)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (16, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-5-21' AS Date), 5)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (17, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-7-21' AS Date), 5)
INSERT [dbo].[Bills] ([ID_Bill], [ID_Account], [ReceiverName], [ReceiverAddress], [ReceiverEmail], [ReceiverPhone], [Note], [PayType], [BuyDate], [Status]) VALUES (18, 4, N'Linh Đoàn', N'Trường mầm non minh khai,quận bắc từ liêm, hà nội', N'kenvindoan89@gmail.com', N'0975429509          ', NULL, N'Thẻ', CAST(N'2021-2-21' AS Date), 5)
SET IDENTITY_INSERT [dbo].[Bills] OFF
GO
SET IDENTITY_INSERT [dbo].[BillDetails] ON 

INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (1, 1, 39, 1, 87890000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (2, 1, 44, 5, 30950000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (3, 1, 45, 2, 10570200.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (4, 2, 11, 1, 13200000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (5, 2, 12, 1, 13390000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (6, 2, 13, 1, 11690000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (7, 2, 22, 1, 3351600.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (8, 2, 23, 1, 3474900.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (9, 2, 26, 1, 2790000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (10, 2, 20, 1, 2701600.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (11, 2, 29, 1, 6643000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (12, 2, 31, 1, 18900000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (13, 2, 33, 1, 17850000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (14, 2, 8, 1, 2990000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (15, 2, 9, 1, 2808000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (16, 3, 43, 2, 8782400.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (17, 4, 14, 1, 4341300.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (18, 4, 15, 1, 3992000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (19, 4, 16, 1, 7465500.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (20, 5, 32, 1, 17910000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (21, 5, 33, 1, 17850000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (22, 5, 38, 1, 7290000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (23, 6, 40, 2, 7992200.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (24, 7, 10, 1, 2960000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (25, 8, 35, 1, 6366500.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (26, 9, 41, 1, 7981500.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (27, 9, 14, 1, 4341300.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (28, 10, 36, 1, 13900000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (29, 11, 27, 1, 60820830.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (30, 12, 24, 1, 2304000.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (31, 13, 23, 3, 10424700.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (32, 14, 23, 3, 10424700.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (33, 15, 23, 3, 10424700.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (34, 16, 23, 3, 10424700.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (35, 17, 23, 3, 10424700.0000, 1)
INSERT [dbo].[BillDetails] ([ID_Billdetail], [ID_Bill], [ID_Product], [Amount], [CurrentlyPrice], [Status]) VALUES (36, 18, 23, 3, 10424700.0000, 1)
SET IDENTITY_INSERT [dbo].[BillDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Permissions] ON 

INSERT [dbo].[Permissions] ([ID_Permission], [Name], [Code], [Status]) VALUES (1, N'Quản lý tài khoản', N'ACCOUNTS', 1)
INSERT [dbo].[Permissions] ([ID_Permission], [Name], [Code], [Status]) VALUES (2, N'Quản lý hóa đơn', N'BILLS', 1)
INSERT [dbo].[Permissions] ([ID_Permission], [Name], [Code], [Status]) VALUES (3, N'Quản lý danh mục', N'CATEGORIES', 1)
INSERT [dbo].[Permissions] ([ID_Permission], [Name], [Code], [Status]) VALUES (4, N'Quản lý sản phẩm', N'PRODUCTS', 1)
INSERT [dbo].[Permissions] ([ID_Permission], [Name], [Code], [Status]) VALUES (5, N'Quản lý nhà cung cấp', N'SUPPLIERS', 1)
INSERT [dbo].[Permissions] ([ID_Permission], [Name], [Code], [Status]) VALUES (6, N'Quản lý thống kê', N'Statistic', 1)
SET IDENTITY_INSERT [dbo].[Permissions] OFF
GO
SET IDENTITY_INSERT [dbo].[PermissionDetails] ON 

INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (1, 1, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (2, 2, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (3, 3, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (4, 4, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (5, 5, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (6, 6, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (7, 1, 2, 0, 0, 0, 0, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (8, 2, 2, 0, 0, 1, 0, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (9, 3, 2, 0, 0, 0, 0, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (10, 4, 2, 0, 0, 0, 0, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (11, 5, 2, 0, 0, 0, 0, 1)
INSERT [dbo].[PermissionDetails] ([ID_PermissionDetail], [ID_Permission], [ID_Account], [View], [Create], [Edit], [Delete], [Status]) VALUES (12, 6, 2, 1, 0, 0, 0, 1)
SET IDENTITY_INSERT [dbo].[PermissionDetails] OFF
GO

SELECT * FROM Categories
SELECT * FROM Suppliers
SELECT * FROM Products
SELECT * FROM Accounts
SELECT * FROM Carts
SELECT * FROM Bills
SELECT * FROM BillDetails
SELECT * FROM [Permissions]
SELECT * FROM PermissionDetails
GO

