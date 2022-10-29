USE [master]
GO
/****** Object:  Database [g12shop]    Script Date: 10/29/2022 6:00:50 PM ******/
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
/****** Object:  Table [dbo].[accounts]    Script Date: 10/29/2022 6:00:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accounts](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [varchar](20) NOT NULL,
	[fullname] [nvarchar](50) NULL,
	[hashPassword] [varchar](255) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[isEnabled] [bit] NOT NULL,
	[authProvider] [varchar](15) NULL,
	[resetPasswordToken] [varchar](30) NULL,
	[verificationCode] [varchar](64) NULL,
	[createdDate] [datetime] NOT NULL,
	[imgUrl] [varchar](255) NULL,
	[roleId] [bigint] NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 10/29/2022 6:00:50 PM ******/
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
/****** Object:  Table [dbo].[order_details]    Script Date: 10/29/2022 6:00:50 PM ******/
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
	[statusOrder] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 10/29/2022 6:00:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[accountId] [bigint] NULL,
	[address] [nvarchar](255) NOT NULL,
	[phone] [varchar](11) NOT NULL,
	[statusOrder] [nvarchar](255) NOT NULL,
	[createdDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_images]    Script Date: 10/29/2022 6:00:50 PM ******/
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
/****** Object:  Table [dbo].[product_reviews]    Script Date: 10/29/2022 6:00:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_reviews](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[productId] [bigint] NULL,
	[description] [ntext] NULL,
	[accountId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 10/29/2022 6:00:50 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 10/29/2022 6:00:50 PM ******/
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
SET IDENTITY_INSERT [dbo].[accounts] ON 

INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (9, N'adm', N'admin', N'123', N'adminn12@dacsanmientrung.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:43:24.587' AS DateTime), N'adm.png', 1, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (10, N'minh', N'Trịnh Quốc Minh', N'123', N'minh@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:44:08.067' AS DateTime), N'minh.png', 1, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (11, N'duy', N'Hoàng Minh Duy', N'123', N'duy@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:44:29.397' AS DateTime), N'duy.png', 1, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (12, N'thai', N'Mai Xuân Thái', N'123', N'thai@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:44:46.940' AS DateTime), N'thai.png', 1, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (13, N'lam', N'Nguyễn Hùng Lâm', N'123', N'lam@gmai.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:45:30.873' AS DateTime), N'lam.png', 1, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (14, N'tan', N'Lâm Nhựt Tân', N'123', N'tan@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:45:53.413' AS DateTime), N'tan.png', 1, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (15, N'lap', N'Nguyễn Duy Lập', N'123', N'lap@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:46:25.940' AS DateTime), N'lap.png', 1, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (17, N'nguyen', N'Phạm Lê Vũ Nguyên', N'vunguyen', N'nguyen@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:47:06.233' AS DateTime), N'nguyen.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (18, N'thuan', N'Nguyễn Đức Thuận', N'ducthuan', N'thuan@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:47:37.580' AS DateTime), N'thuan.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (19, N'kiet', N'Lê Văn Anh Kiệt', N'anhkiet', N'kiet@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:48:44.480' AS DateTime), N'kiet.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (20, N'dat', N'Phạm Minh Đạt', N'minhdat', N'dat@gamil.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:49:09.900' AS DateTime), N'dat.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (21, N'vu', N'Lê Trường Vũ', N'truongvu', N'vu@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:49:30.860' AS DateTime), N'vu.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (22, N'quan', N'Nguyễn Minh Quân', N'minhquan', N'quan@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:49:52.203' AS DateTime), N'quan.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (23, N'chi', N'Trần Công Chí', N'congchi', N'chi@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:50:11.440' AS DateTime), N'chi.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (24, N'phat', N'Nguyễn Quang Phát', N'quanphat', N'phat@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:50:28.337' AS DateTime), N'phat.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (25, N'an', N'Phạm Minh An', N'minhan', N'anh@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:50:47.187' AS DateTime), N'an.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (26, N'binh', N'Nguyễn Khánh Bình', N'khanhbinh', N'binh@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:51:10.227' AS DateTime), N'binh.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (27, N'khanh', N'Lê Duy Khánh', N'duykhanh', N'khanh@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:51:44.377' AS DateTime), N'khanh.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (28, N'pha', N'Nguyễn Minh Pha', N'minhpha', N'pha@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:52:06.907' AS DateTime), N'pha.png', 2, 0)
INSERT [dbo].[accounts] ([id], [username], [fullname], [hashPassword], [email], [isEnabled], [authProvider], [resetPasswordToken], [verificationCode], [createdDate], [imgUrl], [roleId], [isDeleted]) VALUES (29, N'nhut', N'Lý Minh Nhựt', N'minhnhut', N'nhut@gmail.com', 0, NULL, NULL, NULL, CAST(N'2022-10-27T16:52:27.920' AS DateTime), N'nhut.png', 2, 0)
SET IDENTITY_INSERT [dbo].[accounts] OFF
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
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (4, N'Bún bò huế', 1, 50, CAST(50000.000 AS Decimal(12, 3)), N'bunbohue.img', N'Bún bò Huế', NULL, N'bun-bo-hue', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (5, N'Mì Quảng', 2, 12, CAST(45000.000 AS Decimal(12, 3)), N'miquang.jpg', N'Mì Quảng', NULL, N'mi-quang', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (6, N'Nem nướng', 3, 25, CAST(60000.000 AS Decimal(12, 3)), N'nemnuong.jpg', N'Nem nướng', NULL, N'nem-nuong', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (7, N'Bánh xèo', 4, 20, CAST(40000.000 AS Decimal(12, 3)), N'banhxeo.jpg', N'Bánh xèo', NULL, N'banh-xeo', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (8, N'Bánh canh hẹ Phú Yên', 5, 14, CAST(45000.000 AS Decimal(12, 3)), N'banhcanhhe.jpg', N'Bánh canh', NULL, N'banh-canh-hen', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (9, N'Cơm gà Tam Kỳ', 6, 35, CAST(55000.000 AS Decimal(12, 3)), N'comgatamky.jpg', N'Cơm gà', NULL, N'com-ga-tam-ky', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (10, N'Bánh ít lá gai', 7, 16, CAST(35000.000 AS Decimal(12, 3)), N'banhitlagai.jpg', N'Bánh ít', NULL, N'banh-it-la-gai', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (11, N'Bánh đập', 8, 22, CAST(25000.000 AS Decimal(12, 3)), N'banhdap.jpg', N'Bánh đập', NULL, N'banh-dap', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (12, N'Gỏi lá mai', 9, 15, CAST(55000.000 AS Decimal(12, 3)), N'goilcamai.jpg', N'Gỏi lá mai', NULL, N'goi-la-mai', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (15, N'Mực rim me', 10, 26, CAST(60000.000 AS Decimal(12, 3)), N'mucrimme.jpg', N'Mực rim me', NULL, N'muc-rim-me', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (16, N'Bún cá dầm', 11, 25, CAST(50000.000 AS Decimal(12, 3)), N'buncadam.jpg', N'Bún cá dầm', NULL, N'bun-ca-dam', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (17, N'Bánh bột lọc Huế', 12, 60, CAST(35000.000 AS Decimal(12, 3)), N'banhbotloc.jpg', N'Bánh bột lọc', NULL, N'banh-bot-loc', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (18, N'Nem chợ Huyền', 13, 55, CAST(45000.000 AS Decimal(12, 3)), N'nemchohuyen.jpg', N'Nem chợ Huyền', NULL, N'nem-cho-huyen', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (19, N'Bún sứa Nha Trang', 14, 55, CAST(45000.000 AS Decimal(12, 3)), N'bunsuanhatrang.jpg', N'Bún sứa', NULL, N'bun-sua-nha-trang', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (20, N'Bánh căn', 15, 35, CAST(30000.000 AS Decimal(12, 3)), N'banhcan.jpg', N'Bánh căn', NULL, N'banh-can', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (21, N'Cao lầu', 16, 30, CAST(65000.000 AS Decimal(12, 3)), N'caolau.jpg', N'Cao lầu', NULL, N'cao-lau', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (22, N'Cơm hến', 17, 22, CAST(55000.000 AS Decimal(12, 3)), N'comhen.jpg', N'Cơm hến', NULL, N'com-hen', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (23, N'Cháo lươn', 18, 15, CAST(60000.000 AS Decimal(12, 3)), N'chaoluong.jpg', N'Cháo lươn', NULL, N'chao-luon', 0)
INSERT [dbo].[products] ([id], [name], [categoryId], [quantity], [price], [imgName], [description], [discount], [slug], [isDeleted]) VALUES (24, N'Lẩu cá Phan Thiết', 19, 30, CAST(60000.000 AS Decimal(12, 3)), N'laucaphanthie.jpg', N'Lẩu cá', NULL, N'lau-ca-phan-thiet', 0)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([id], [name]) VALUES (1, N'admin')
INSERT [dbo].[roles] ([id], [name]) VALUES (2, N'user')
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__accounts__AB6E61647D275D22]    Script Date: 10/29/2022 6:00:50 PM ******/
ALTER TABLE [dbo].[accounts] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__accounts__F3DBC57243DA2E07]    Script Date: 10/29/2022 6:00:50 PM ******/
ALTER TABLE [dbo].[accounts] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__products__32DD1E4CE388C7F9]    Script Date: 10/29/2022 6:00:50 PM ******/
ALTER TABLE [dbo].[products] ADD UNIQUE NONCLUSTERED 
(
	[slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__roles__72E12F1B08C1C14D]    Script Date: 10/29/2022 6:00:50 PM ******/
ALTER TABLE [dbo].[roles] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[accounts] ADD  DEFAULT ((0)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[accounts] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[categories] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[accounts]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([accountId])
REFERENCES [dbo].[accounts] ([id])
GO
ALTER TABLE [dbo].[product_images]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[product_reviews]  WITH CHECK ADD FOREIGN KEY([accountId])
REFERENCES [dbo].[accounts] ([id])
GO
ALTER TABLE [dbo].[product_reviews]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[categories] ([id])
GO
USE [master]
GO
ALTER DATABASE [g12shop] SET  READ_WRITE 
GO
