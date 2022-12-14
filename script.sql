USE [master]
GO
/****** Object:  Database [g12shop]    Script Date: 11/23/2022 4:11:24 PM ******/
CREATE DATABASE [g12shop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'g12shop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\g12shop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'g12shop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\g12shop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [g12shop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [g12shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [g12shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [g12shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [g12shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [g12shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [g12shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [g12shop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [g12shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [g12shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [g12shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [g12shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [g12shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [g12shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [g12shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [g12shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [g12shop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [g12shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [g12shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [g12shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [g12shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [g12shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [g12shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [g12shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [g12shop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [g12shop] SET  MULTI_USER 
GO
ALTER DATABASE [g12shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [g12shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [g12shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [g12shop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [g12shop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [g12shop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [g12shop] SET QUERY_STORE = OFF
GO
USE [g12shop]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](500) NOT NULL,
	[slug] [varchar](255) NOT NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_details]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_details](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[orderId] [bigint] NULL,
	[productId] [bigint] NULL,
	[price] [decimal](12, 3) NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[userId] [bigint] NULL,
	[address] [nvarchar](255) NOT NULL,
	[phone] [varchar](11) NOT NULL,
	[shippingFee] [decimal](12, 3) NOT NULL,
	[totalPrice] [decimal](12, 3) NOT NULL,
	[orderStatus] [nvarchar](255) NOT NULL,
	[createdDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_images]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_images](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[productId] [bigint] NULL,
	[imgName] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_reviews]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_reviews](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[productId] [bigint] NULL,
	[description] [ntext] NULL,
	[userId] [bigint] NULL,
	[createdDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_types]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_types](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[slug] [nchar](50) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_product_types] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[categoryId] [bigint] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](12, 3) NOT NULL,
	[imgName] [varchar](255) NOT NULL,
	[description] [ntext] NOT NULL,
	[discount] [int] NULL,
	[slug] [varchar](255) NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[productTypeId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [varchar](255) NULL,
	[fullname] [nvarchar](255) NULL,
	[hashPassword] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[imgUrl] [varchar](255) NULL,
	[createdDate] [datetime2](7) NULL,
	[roleId] [bigint] NULL,
	[isEnabled] [bit] NULL,
	[resetPasswordToken] [varchar](255) NULL,
	[verificationCode] [varchar](255) NULL,
	[authProvider] [varchar](255) NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[categories] ON 

INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (1, N'Thanh Hoá', N'thanh-hoa', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (2, N'Nghệ An', N'nghe-an', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (3, N'Hà Tĩnh', N'ha-tinh', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (4, N'Quảng Bình', N'quang-binh', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (5, N'Quảng Trị', N'quang-tri', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (6, N'Thừa Thiên - Huế', N'thua-thien-hue', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (7, N'Kon Tum', N'kon-tum', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (8, N'Gia Lai', N'gia-lai', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (9, N'Đắk Lắk', N'dak-lak', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (10, N'Đắk Nông', N'dak-nong', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (11, N'Lâm Đồng', N'lam-dong', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (12, N'Đà Nẵng', N'da-nang', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (13, N'Quảng Nam', N'quang-nam', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (14, N'Quảng Ngãi', N'quang-ngai', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (15, N'Bình Định', N'binh-dinh', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (16, N'Phú Yên', N'phu-yen', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (17, N'Khánh Hoà', N'khanh-hoa', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (18, N'Ninh Thuận', N'ninh-thuan', 0)
INSERT [dbo].[categories] ([id], [name], [slug], [isDeleted]) VALUES (19, N'Bình Thuận', N'binh-thuan', 0)
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[order_details] ON 

INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10005, 10015, 1, CAST(50000.000 AS Decimal(12, 3)), 1)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10006, 10015, 2, CAST(36000.000 AS Decimal(12, 3)), 2)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10007, 10016, 16, CAST(58500.000 AS Decimal(12, 3)), 2)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10008, 10016, 18, CAST(60000.000 AS Decimal(12, 3)), 1)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10009, 10016, 3, CAST(60000.000 AS Decimal(12, 3)), 1)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10010, 10016, 19, CAST(60000.000 AS Decimal(12, 3)), 3)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10011, 10016, 8, CAST(25000.000 AS Decimal(12, 3)), 2)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10012, 10016, 12, CAST(35000.000 AS Decimal(12, 3)), 2)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10013, 10017, 2, CAST(36000.000 AS Decimal(12, 3)), 1)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10014, 10017, 7, CAST(28000.000 AS Decimal(12, 3)), 1)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10015, 10018, 19, CAST(60000.000 AS Decimal(12, 3)), 1)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10016, 10018, 15, CAST(30000.000 AS Decimal(12, 3)), 1)
INSERT [dbo].[order_details] ([id], [orderId], [productId], [price], [quantity]) VALUES (10017, 10019, 19, CAST(60000.000 AS Decimal(12, 3)), 2)
SET IDENTITY_INSERT [dbo].[order_details] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [userId], [address], [phone], [shippingFee], [totalPrice], [orderStatus], [createdDate]) VALUES (10015, 3, N'Q12, HCM', N'0123', CAST(30000.000 AS Decimal(12, 3)), CAST(152000.000 AS Decimal(12, 3)), N'CHUA_XAC_NHAN', CAST(N'2022-11-17T12:14:23.357' AS DateTime))
INSERT [dbo].[orders] ([id], [userId], [address], [phone], [shippingFee], [totalPrice], [orderStatus], [createdDate]) VALUES (10016, 3, N'Q12, HCM', N'1234', CAST(0.000 AS Decimal(12, 3)), CAST(537000.000 AS Decimal(12, 3)), N'DA_XAC_NHAN', CAST(N'2022-11-17T12:15:43.517' AS DateTime))
INSERT [dbo].[orders] ([id], [userId], [address], [phone], [shippingFee], [totalPrice], [orderStatus], [createdDate]) VALUES (10017, 3, N'Q12, HCM', N'0123', CAST(30000.000 AS Decimal(12, 3)), CAST(94000.000 AS Decimal(12, 3)), N'DA_XAC_NHAN', CAST(N'2022-10-17T14:45:11.663' AS DateTime))
INSERT [dbo].[orders] ([id], [userId], [address], [phone], [shippingFee], [totalPrice], [orderStatus], [createdDate]) VALUES (10018, 3, N'Q12, HCM', N'0123', CAST(30000.000 AS Decimal(12, 3)), CAST(120000.000 AS Decimal(12, 3)), N'DA_GIAO_HANG', CAST(N'2022-10-17T14:45:26.143' AS DateTime))
INSERT [dbo].[orders] ([id], [userId], [address], [phone], [shippingFee], [totalPrice], [orderStatus], [createdDate]) VALUES (10019, 3, N'Q12, HCM', N'0123', CAST(30000.000 AS Decimal(12, 3)), CAST(150000.000 AS Decimal(12, 3)), N'DA_XAC_NHAN', CAST(N'2022-10-17T14:45:41.323' AS DateTime))
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[product_images] ON 

INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (2, 1, N'bun-bo-hue2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (3, 1, N'bun-bo-hue3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (4, 2, N'mi-quang2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (5, 2, N'mi-quang3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (6, 3, N'nem-nuong2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (7, 3, N'nem-nuong3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (8, 4, N'banh-xeo2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (9, 4, N'banh-xeo3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (10, 5, N'banh-canh-he2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (11, 5, N'banh-canh-he3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (12, 6, N'com-ga-tam-ky2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (13, 6, N'com-ga-tam-ky3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (14, 7, N'banh-it-la-gai2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (15, 7, N'banh-it-la-gai3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (16, 8, N'banh-dap2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (17, 8, N'banh-dap3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (18, 9, N'goi-ca-mai2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (19, 9, N'goi-ca-mai3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (20, 10, N'muc-rim-me2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (21, 10, N'muc-rim-me3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (22, 11, N'bun-ca-dam2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (23, 11, N'bun-ca-dam3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (24, 12, N'banh-bot-loc2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (25, 12, N'banh-bot-loc3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (26, 13, N'nem-cho-huyen2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (27, 13, N'nem-cho-huyen3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (28, 14, N'bun-sua-nha-trang2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (29, 14, N'bun-sua-nha-trang3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (30, 15, N'banh-can2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (31, 15, N'banh-can3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (32, 16, N'cao-lau2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (33, 16, N'cao-lau3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (34, 17, N'com-hen2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (35, 17, N'com-hen3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (36, 18, N'chao-luon2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (37, 18, N'chao-luon3.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (38, 19, N'lau-ca-phan-thiet2.jpg')
INSERT [dbo].[product_images] ([id], [productId], [imgName]) VALUES (39, 19, N'lau-ca-phan-thiet3.jpg')
SET IDENTITY_INSERT [dbo].[product_images] OFF
GO
SET IDENTITY_INSERT [dbo].[product_reviews] ON 

INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (1, 1, N'Ngon', 1, CAST(N'2022-11-04T17:30:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (2, 1, N'Cho xin cái địa chỉ', 2, CAST(N'2022-11-01T08:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (3, 2, N'Mì quảng hấp dẫn quá chuẩn vị miền Trung luôn', 3, CAST(N'2022-11-04T20:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (4, 2, N'Món ngon, nước lèo vừa ăn, đầy đủ gia vị', 4, CAST(N'2022-09-20T12:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (5, 3, N'Nem nướng có vị nem nướng', 5, CAST(N'2022-11-04T08:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (6, 3, N'Rất ngon đã ăn nhiều lần rồi sẽ ủng hộ tiếp', 6, CAST(N'2022-10-06T07:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (7, 4, N'Bánh xèo ngon nhưng nước mắm hơi mặn', 7, CAST(N'2022-11-06T08:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (8, 4, N'Banh ngon giòn, đóng gói ổn', 8, CAST(N'2022-11-07T09:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (9, 5, N'Bánh canh ngon nhứt nách luôn ạ', 9, CAST(N'2022-11-07T12:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (10, 5, N'Tuyệt vời ông mặt trời', 10, CAST(N'2022-11-07T11:30:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (11, 6, N'Cơm gà nhiều, miếng gà siêu to khổng lồ', 11, CAST(N'2022-09-08T12:30:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (12, 6, N'Cơm ngon hợp giá tiền', 12, CAST(N'2022-11-08T17:30:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (13, 7, N'Bánh ngon dữ thần mèn đét ơi, mai mốt ủng hộ tiếp', 13, CAST(N'2022-08-08T08:52:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (14, 7, N'Bánh ít gất ngon 50 cho quán luôn', 14, CAST(N'2022-11-08T08:36:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (15, 8, N'Bánh đập có vị bánh đập =))', 15, CAST(N'2022-11-09T19:10:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (16, 8, N'Bánh ngon quá', 16, CAST(N'2022-10-29T20:07:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (17, 9, N'Gỏi cá mai ngon có hương thơm rất tuyệt', 17, CAST(N'2022-11-09T21:10:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (18, 9, N'Gỏi ngon mềm xen lẫn vị chua cay', 18, CAST(N'2022-10-29T23:56:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (19, 10, N'Quá đỉnh chua chua dai dai', 19, CAST(N'2022-11-10T06:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (20, 10, N'Hương vị thơm ngon, bíu ti phun', 20, CAST(N'2022-11-10T21:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (21, 11, N'Bún cá ngon, cá rất là tươi luôn', 1, CAST(N'2022-09-02T08:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (22, 11, N'Tuyệt vời ông mặt trời', 2, CAST(N'2022-11-10T09:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (23, 12, N'Bánh bột lọc dai ngon, nước mắm vừa ăn', 3, CAST(N'2022-11-10T10:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (24, 12, N'Đồ ăn vừa khẩu vị nên không có gì để nói rồi', 4, CAST(N'2022-08-11T08:03:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (25, 13, N'Ngonnnnnn, nhưng rau hơi ít', 5, CAST(N'2022-11-11T08:35:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (26, 13, N'Ngon, nem ổn', 6, CAST(N'2022-10-21T09:56:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (27, 14, N'Sứa giòn dai dai ăn đã cái miệng, mình sẽ ủng hộ nghennn', 7, CAST(N'2022-11-12T08:45:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (28, 14, N'Ngon lắm khách quen của quán, mọi người nên mua ăn thử nha', 8, CAST(N'2022-10-17T11:55:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (29, 15, N'Bánh căn ăn lúc nào cũng ngon không bị ngán', 9, CAST(N'2022-11-14T22:16:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (30, 15, N'Món ăn ngon khỏi phải chê sẽ ủng hộ tiếp', 10, CAST(N'2022-11-16T15:25:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (31, 16, N'Cao lầu ngon vãi chưởng', 11, CAST(N'2022-08-15T12:35:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (32, 16, N'Cho xin cái địa chỉ', 12, CAST(N'2022-11-17T13:55:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (33, 17, N'Có lúc ngon có lúc không ngon', 13, CAST(N'2022-10-14T17:55:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (34, 17, N'Nhìn chung là ăn được, giá hơi cao tí', 14, CAST(N'2022-11-18T18:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (35, 18, N'Cháu lương thơm ngon, chuẩn vị', 15, CAST(N'2022-11-19T18:30:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (36, 18, N'Cáu lương không tanh, 10 điểm 10 điểm', 16, CAST(N'2022-09-21T20:00:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (37, 19, N'Nước lẩu có vị khá ngon', 17, CAST(N'2022-10-22T08:30:00.000' AS DateTime))
INSERT [dbo].[product_reviews] ([id], [productId], [description], [userId], [createdDate]) VALUES (38, 19, N'Lẩu ngon, cá tươi, rau đầy đủ', 18, CAST(N'2022-10-12T02:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[product_reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[product_types] ON 

INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (1, N'Lẩu', N'lau                                               ', 0)
INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (2, N'Bún', N'bun                                               ', 0)
INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (3, N'Cơm', N'com                                               ', 0)
INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (4, N'Mì', N'mi                                                ', 0)
INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (5, N'Bánh', N'banh                                              ', 0)
INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (6, N'Gỏi', N'goi                                               ', 0)
INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (7, N'Nem', N'nem                                               ', 0)
INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (8, N'Cháo', N'chao                                              ', 0)
INSERT [dbo].[product_types] ([id], [name], [slug], [isDeleted]) VALUES (9, N'Hải Sản', N'hai-san                                           ', 0)
SET IDENTITY_INSERT [dbo].[product_types] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (1, N'Bún bò Huế', 6, 49, CAST(50000.000 AS Decimal(12, 3)), N'bun-bo-hue.jpg', N'Bún bò là một trong những đặc sản của xứ Huế, mặc dù món bún này phổ biến trên cả ba miền ở Việt Nam và cả người Việt tại hải ngoại. Tại Huế, món này được gọi đơn giản là "bún bò" hoặc gọi cụ thể hơn là "bún bò thịt bò". Các địa phương khác gọi là "bún bò Huế", "bún bò gốc Huế" để chỉ xuất xứ của món ăn này.', NULL, N'bun-bo-hue', 0, 2)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (2, N'Mì Quảng', 2, 7, CAST(45000.000 AS Decimal(12, 3)), N'mi-quang.jpg', N'Mỳ Quảng là một món ăn đặc sản đặc trưng của Quảng Nam và Đà Nẵng, Việt Nam. Mỳ Quảng thường được làm từ bột gạo xay mịn với nước từ hạt dành dành và trứng cho có màu vàng và tráng thành từng lớp bánh mỏng, sau đó thái theo chiều ngang để có những sợi mỳ mỏng khoảng 5 -10mm.', 20, N'mi-quang', 0, 4)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (3, N'Nem nướng', 3, 22, CAST(60000.000 AS Decimal(12, 3)), N'nem-nuong.jpg', N'Nem nướng là món thịt heo nướng hoặc thịt viên nướng của Việt Nam, và là một món ăn phổ biến ở quốc gia này, đôi khi được dùng như một món khai vị hoặc món ăn nhẹ riêng lẻ, hoặc ăn kèm bún như một món chính. Nem nướng là đặc sản của tỉnh Khánh Hòa.', NULL, N'nem-nuong', 0, 7)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (4, N'Bánh xèo', 4, 20, CAST(40000.000 AS Decimal(12, 3)), N'banh-xeo.jpg', N'Bánh xèo là một loại bánh phổ biến ở châu Á, phiên bản bánh xèo của Nhật Bản và Triều Tiên có bột bên ngoài, bên trong có nhân là tôm, thịt, giá đỗ, kim chi, khoai tây, hẹ, tôm, thịt, cải thảo được rán màu vàng, đúc thành hình tròn hoặc gấp lại thành hình bán nguyệt.', NULL, N'banh-xeo', 0, 5)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (5, N'Bánh canh hẹ Phú Yên', 5, 14, CAST(45000.000 AS Decimal(12, 3)), N'banh-canh-he.jpg', N'Bánh canh là một món ăn Việt Nam. Bánh canh có nguồn gốc từ Đông Nam Bộ, sau đó phổ biến khắp Việt Nam. Bánh canh bao gồm nước dùng được nấu từ tôm, cá và giò heo thêm gia vị tùy theo từng loại bánh canh. Sợi bánh canh có thể được làm từ bột gạo, bột mì, bột năng hoặc bột sắn hoặc bột gạo pha bột sắn.', NULL, N'banh-canh-he', 0, 5)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (6, N'Cơm gà Tam Kỳ', 1, 35, CAST(55000.000 AS Decimal(12, 3)), N'com-ga-tam-ky.jpg', N'Cơm gà là món ăn được chế biến và trình bày với hình thức cơm và thịt gà. Cơm có thể dùng là cơm trắng hoặc cơm chiên, cơm rang và thịt gà được trình bày thông thường là đùi gà hay cánh gà. Món cơm gà tương đối dễ làm và phổ biến.', NULL, N'com-ga-tam-ky', 0, 3)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (7, N'Bánh ít lá gai', 7, 14, CAST(35000.000 AS Decimal(12, 3)), N'banh-it-la-gai.jpg', N'Bánh ít hay bánh ích là một loại bánh phổ biến ở Việt Nam, được làm từ bột nếp và đậu xanh với phương pháp hấp cách thủy. Nhân bánh được xào chín trước khi gói cẩn thận bằng lá chuối tươi hoặc khô và có thể có nhiều hình dáng khác nhau tùy theo cách gói của người làm bánh. Nhân bánh có thể là nhân mặn hoặc nhân ngọt.', 20, N'banh-it-la-gai', 0, 5)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (8, N'Bánh đập', 8, 20, CAST(25000.000 AS Decimal(12, 3)), N'banh-dap.jpg', N'Bánh đập hay còn gọi là Bánh chập là một loại bánh khá phổ biến ở các tỉnh ven biển Miền Trung Việt Nam từ Quảng Nam đến Khánh Hòa nhưng nổi tiếng nhất vẫn là ở Quảng Ngãi. "Đập" được hiểu đơn giản là bánh phải được đập rồi mới ăn. Bánh đập là sự kết hợp tinh tế giữa bánh ướt và bánh tráng nướng.', NULL, N'banh-dap', 0, 5)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (9, N'Gỏi cá mai', 9, 15, CAST(55000.000 AS Decimal(12, 3)), N'goi-ca-mai.jpg', N'Gỏi cá mai là một món ăn ngon đặc sản, món gỏi cá này thu hút rất nhiều du khách đến thưởng thức. Phải là người sành ăn mới có thể thưởng thức được hết cái ngon, lạ của món ăn này. Nếu có dịp đến Nha Trang mà không thưởng thức món ăn này thì tiếc cả một đời người đấy!', NULL, N'goi-ca-mai', 0, 6)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (10, N'Mực rim me', 10, 26, CAST(60000.000 AS Decimal(12, 3)), N'muc-rim-me.jpg', N'Mực rim me là một món ăn đặc sản được nhiều du khách biết đến. Không chỉ thơm ngon hấp dẫn với hương vị đặc trưng mà món ăn này còn được thu hút bởi nét tinh tế trong từng khâu chế biến. Thưởng thức mực rim me cùng chút rượu nhẹ trong một khung cảnh an nhiên, không khí mát mẻ quả là không còn gì bằng.', NULL, N'muc-rim-me', 0, 9)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (11, N'Bún cá dầm', 11, 23, CAST(50000.000 AS Decimal(12, 3)), N'bun-ca-dam.jpg', N'Bún cá dầm, ngon như bún cá.', NULL, N'bun-ca-dam', 0, 2)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (12, N'Bánh bột lọc Huế', 12, 58, CAST(35000.000 AS Decimal(12, 3)), N'banh-bot-loc.jpg', N'Bánh bột lọc là một loại bánh Việt Nam, có xuất xứ từ Huế. Đây là món ăn phổ biến ở Hà Nội, Nam Định, các tỉnh miền Trung từ Nghệ An đến Đà Nẵng và đặc biệt là Huế. Ở Nam Định, người ta làm bánh bột lọc với mộc nhĩ.', NULL, N'banh-bot-loc', 0, 5)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (13, N'Nem chợ Huyện', 13, 55, CAST(45000.000 AS Decimal(12, 3)), N'nem-cho-huyen.jpg', N'Nem chợ Huyện là một món ăn đặc sản trứ danh và là một biểu tượng cho nền văn hóa ẩm thực của miền đất võ Bình Định. Với hương vị chua chua ngọt ngọt, đặc trưng và rất riêng biệt, nem chợ Huyện đã chiếm được tình cảm của đông đảo thực khách trong và ngoài nước.', 50, N'nem-cho-huyen', 0, 7)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (14, N'Bún sứa Nha Trang', 14, 55, CAST(45000.000 AS Decimal(12, 3)), N'bun-sua-nha-trang.jpg', N'Bún cá sứa Nha Trang là một món nước quen thuộc với người dân vùng biển, với cách làm đơn giản nhưng hương vị lại cực kì hấp dẫn và thơm ngon từ cá và sứa. Vào bếp cùng Điện máy XANH ngay để thực hiện món ăn đặc sản Nha Trang này nhé!', NULL, N'bun-sua-nha-trang', 0, 2)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (15, N'Bánh căn', 15, 34, CAST(30000.000 AS Decimal(12, 3)), N'banh-can.jpg', N'Bánh căn là một loại bánh phổ biến của Ninh Thuận, Bình Thuận. Sau này được phát triển ở vùng Nam Trung Bộ, đặc biệt ở các tỉnh Khánh Hòa, Lâm Đồng, Bình Thuận. Bánh căn có hình dáng gần với bánh khọt ở các tỉnh phía Nam, nhưng cách làm hoàn toàn khác.', NULL, N'banh-can', 0, 5)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (16, N'Cao lầu', 16, 28, CAST(65000.000 AS Decimal(12, 3)), N'cao-lau.jpg', N'Cao lầu là tên gọi một món mì ở Quảng Nam. Đây được xem là món ăn đặc sản của thành phố Hội An. Món mì này có sợi mì màu vàng, được dùng với tôm, thịt heo, các loại rau sống và rất ít nước dùng. Sợi mì màu vàng là do được trộn với tro từ một loại cây ở địa phương.', 10, N'cao-lau', 0, 4)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (17, N'Cơm hến', 17, 22, CAST(55000.000 AS Decimal(12, 3)), N'com-hen.jpg', N'Cơm hến là một đặc sản ẩm thực Huế. Cơm hến được trình bày dưới hình thức là cơm nguội trộn với hến xào qua dầu và gia vị, nước hến, mắm ruốc, môn bạc hà, bẹ chuối, rau má, rau thơm, giá đỗ, tóp mỡ hoặc bóng bì chiên giòn, sợi mì chiên giòn, ớt màu, đậu phộng nguyên hạt, ớt chưng, tiêu, bột ngọt và muối.', NULL, N'com-hen', 0, 3)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (18, N'Cháo lươn', 18, 14, CAST(60000.000 AS Decimal(12, 3)), N'chao-luon.jpg', N'Cháo lươn Nghệ An là món đặc sản “có tiếng” của vùng quê Bác. Đây là món khoái khẩu của người dân địa phương cũng như du khách mỗi lần đi du lịch Nghệ An.', NULL, N'chao-luon', 0, 8)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (19, N'Lẩu cá Phan Thiết', 19, 24, CAST(60000.000 AS Decimal(12, 3)), N'lau-ca-phan-thiet.jpg', N'Phan Thiết được biết đến là thành phố biển với những bãi biển xanh mát và những đồi cát bao la. Nhưng du khách đến với Phan Thiết không chỉ bởi cảnh đẹp mà còn để thưởng thức ẩm thực nơi đây. Ngoài các món hải sản, thịt nướng quen thuộc thì lẩu cá chính là một lựa chọn rất phù hợp cho bữa ăn gia đình, buổi vui chơi bạn bè.', NULL, N'lau-ca-phan-thiet', 0, 1)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted], [productTypeId]) VALUES (23, N'Test', 5, 12, CAST(16000.000 AS Decimal(12, 3)), N'db83b2cb.png', N'', 0, N'test', 0, 5)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [name]) VALUES (1, N'admin')
INSERT [dbo].[roles] ([id], [name]) VALUES (2, N'user')
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (1, N'admin', N'Admin', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'g12shop@dacsanmientrung.com', N'admin.png', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 1, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (2, N'minhtq', N'Trịnh Quốc Minh', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'minhtq@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 1, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (3, N'duyhm', N'Hoàng Minh Duy', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'duyhm@gmail.com', N'ece285b8.png', CAST(N'2022-11-01T16:43:24.5866667' AS DateTime2), 1, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (4, N'thaimx', N'Mai Xuân Thái', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'thaimx@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 1, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (5, N'lamnh', N'Nguyễn Hùng Lâm', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'lamnh@gmai.com', N'lamnh.jpg', CAST(N'2022-11-01T16:43:24.5866667' AS DateTime2), 1, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (6, N'tanln', N'Lâm Nhựt Tân', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'tanln@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 1, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (7, N'lapnd', N'Nguyễn Duy Lập', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'lapnd@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 1, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (8, N'nguyenplv', N'Phạm Lê Vũ Nguyên', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'nguyenplv@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (9, N'thuannd', N'Nguyễn Đức Thuận', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'thuannd@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (10, N'kietlva', N'Lê Van Anh Kiệt', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'kietlva@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (11, N'datpm', N'Phạm Minh Đạt', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'datpm@gamil.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (12, N'vult', N'Lê Trường Vũ', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'vult@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (13, N'quannm', N'Nguyễn Minh Quân', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'quannm@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (14, N'chitc', N'Trần Công Chí', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'chitc@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (15, N'phatnq', N'Nguyễn Quang Phát', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'phatnq@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (16, N'anpm', N'Phạm Minh An', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'anpm@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (17, N'binhnk', N'Nguyễn Khánh Bình', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'binhnk@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (18, N'khanhld', N'Lê Duy Khánh', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'khanhld@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (19, N'phanm', N'Nguyễn Minh Pha', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'phanm@gmail.com', N'', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 1)
INSERT [dbo].[users] ([id], [username], [fullname], [hashPassword], [email], [imgUrl], [createdDate], [roleId], [isEnabled], [resetPasswordToken], [verificationCode], [authProvider], [isDeleted]) VALUES (20, N'nhatlm', N'Lý Minh Nhật', N'$2a$10$7YIj5SGLAAev58xzTj6y3Owj/0e9ZVBZy9Hoc0nXxeysm8wovQUY6', N'nhatlm@gmail.com', N'8f8d04cf.jpg', CAST(N'2022-09-01T16:43:24.5866667' AS DateTime2), 2, 1, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__products__32DD1E4CED51FC8A]    Script Date: 11/23/2022 4:11:24 PM ******/
ALTER TABLE [dbo].[products] ADD UNIQUE NONCLUSTERED 
(
	[slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__roles__72E12F1BCF6ACDED]    Script Date: 11/23/2022 4:11:24 PM ******/
ALTER TABLE [dbo].[roles] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E616447147906]    Script Date: 11/23/2022 4:11:24 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__F3DBC572C06A13DE]    Script Date: 11/23/2022 4:11:24 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[categories] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[product_types] ADD  CONSTRAINT [DF_Product_types_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[product_images]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[product_reviews]  WITH CHECK ADD  CONSTRAINT [FKhonsga9x61myhhlhbfhd29wk9] FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[product_reviews] CHECK CONSTRAINT [FKhonsga9x61myhhlhbfhd29wk9]
GO
ALTER TABLE [dbo].[product_reviews]  WITH CHECK ADD  CONSTRAINT [FKsn23ja8kbk6akk0627k24xy09] FOREIGN KEY([userId])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[product_reviews] CHECK CONSTRAINT [FKsn23ja8kbk6akk0627k24xy09]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([productTypeId])
REFERENCES [dbo].[product_types] ([id])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK91mjuf61b7rhfjnjkucfc0omf] FOREIGN KEY([roleId])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK91mjuf61b7rhfjnjkucfc0omf]
GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalOrderPerMonth]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getTotalOrderPerMonth]
(
	@month varchar(2),
	@year varchar(4)
)
AS BEGIN
	DECLARE @result varchar(20)
	SET @result = (SELECT
						COUNT(id) AS 'totalOrder'
					FROM
						orders
					WHERE MONTH(createdDate) = @month
					AND YEAR(createdDate) = @year)
	IF @result IS NULL BEGIN SET @result = '0' END
	SELECT @result
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalPricePerMonth]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getTotalPricePerMonth]
(
	@month varchar(2),
	@year varchar(4)
)
AS BEGIN
	DECLARE @result varchar(20)
	SET @result = (SELECT
						SUM(totalPrice) AS 'totalPrice'
					FROM
						orders
					WHERE MONTH(createdDate) = @month
					AND YEAR(createdDate) = @year)
	IF @result IS NULL BEGIN SET @result = '0' END
	SELECT @result
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalUserPerMonth]    Script Date: 11/23/2022 4:11:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getTotalUserPerMonth]
(
	@month varchar(2),
	@year varchar(4)
)
AS BEGIN
	DECLARE @result varchar(20)
	SET @result = (SELECT
						COUNT(id) AS 'totalUser'
					FROM
						users
					WHERE MONTH(createdDate) = @month
					AND YEAR(createdDate) = @year)
	IF @result IS NULL BEGIN SET @result = '0' END
	SELECT @result
END
GO
USE [master]
GO
ALTER DATABASE [g12shop] SET  READ_WRITE 
GO
