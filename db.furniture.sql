USE [master]
GO
/****** Object:  Database [furniture]    Script Date: 2019-07-01 6:37:23 PM ******/
CREATE DATABASE [furniture]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'furniture', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\furniture.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'furniture_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\furniture_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [furniture] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [furniture].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [furniture] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [furniture] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [furniture] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [furniture] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [furniture] SET ARITHABORT OFF 
GO
ALTER DATABASE [furniture] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [furniture] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [furniture] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [furniture] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [furniture] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [furniture] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [furniture] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [furniture] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [furniture] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [furniture] SET  DISABLE_BROKER 
GO
ALTER DATABASE [furniture] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [furniture] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [furniture] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [furniture] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [furniture] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [furniture] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [furniture] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [furniture] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [furniture] SET  MULTI_USER 
GO
ALTER DATABASE [furniture] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [furniture] SET DB_CHAINING OFF 
GO
ALTER DATABASE [furniture] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [furniture] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [furniture] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [furniture] SET QUERY_STORE = OFF
GO
USE [furniture]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2019-07-01 6:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[categoryId] [int] NOT NULL,
	[categoryTitle] [varchar](254) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Furniture]    Script Date: 2019-07-01 6:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Furniture](
	[furnitureId] [int] NOT NULL,
	[categoryId] [int] NOT NULL,
	[furnitureTitle] [varchar](254) NULL,
	[furniturePrice] [float] NULL,
	[furnitureInStock] [int] NULL,
	[furnitureOnOrder] [int] NULL,
	[images] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 2019-07-01 6:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[orderId] [int] NOT NULL,
	[userId] [int] NULL,
	[orderDate] [datetime] NULL,
	[requiredDate] [datetime] NULL,
	[orderType] [varchar](254) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 2019-07-01 6:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[orderDetailsId] [int] NOT NULL,
	[furnitureId] [int] NOT NULL,
	[orderId] [int] NOT NULL,
	[furniturePrice] [float] NULL,
	[quantity] [float] NULL,
	[deliveryStatus] [varchar](254) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 2019-07-01 6:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[paymentId] [int] NOT NULL,
	[orderId] [int] NULL,
	[paymentTypeId] [int] NULL,
	[totalSum] [float] NULL,
	[paymentDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentType]    Script Date: 2019-07-01 6:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentType](
	[paymentTypeId] [int] NOT NULL,
	[paymentType] [varchar](254) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile]    Script Date: 2019-07-01 6:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile](
	[profileId] [int] NOT NULL,
	[profileName] [varchar](254) NULL,
	[profilePrivileges] [varchar](254) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 2019-07-01 6:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[shoppingCartId] [int] NOT NULL,
	[orderId] [int] NULL,
	[shoppingCartDate] [datetime] NULL,
	[productID] [int] NULL,
	[quantity] [int] NULL,
	[productSum] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 2019-07-01 6:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[userId] [int] NOT NULL,
	[profileId] [int] NOT NULL,
 CONSTRAINT [PK_USERPROFILE] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[profileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2019-07-01 6:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userId] [int] NOT NULL,
	[shoppingCartId] [int] NOT NULL,
	[userName] [varchar](254) NULL,
	[password] [varchar](254) NULL,
	[userHint] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Categories] ([categoryId], [categoryTitle]) VALUES (1, N'armchairs')
INSERT [dbo].[Categories] ([categoryId], [categoryTitle]) VALUES (5, N'beds')
INSERT [dbo].[Categories] ([categoryId], [categoryTitle]) VALUES (4, N'tables')
INSERT [dbo].[Categories] ([categoryId], [categoryTitle]) VALUES (2, N'sofas')
INSERT [dbo].[Categories] ([categoryId], [categoryTitle]) VALUES (7, N'wardrobes')
INSERT [dbo].[Categories] ([categoryId], [categoryTitle]) VALUES (6, N'kitchen')
INSERT [dbo].[Categories] ([categoryId], [categoryTitle]) VALUES (3, N'office')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (1, 1, N'armchair1', 23, 6, 6, N'armchair1_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (2, 1, N'armchair2', 45, 12, 11, N'armchair2_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (3, 1, N'armchair3', 45, 11, 4, N'armchair3_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (4, 5, N'bed1', 254, 9, 10, N'bed1_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (5, 5, N'bed2', 350, 11, 2, N'bed2_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (6, 5, N'bed3', 382, 8, 7, N'bed3_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (7, 4, N'table11', 89, 5, 8, N'table1_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (8, 4, N'table2', 160, 12, 2, N'table2_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (9, 4, N'table3', 67, 6, 7, N'table3_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (10, 2, N'sofa1', 1100, 6, 7, N'sofa1_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (11, 2, N'sofa2', 1200, 15, 2, N'sofa2_small.png')
INSERT [dbo].[Furniture] ([furnitureId], [categoryId], [furnitureTitle], [furniturePrice], [furnitureInStock], [furnitureOnOrder], [images]) VALUES (12, 2, N'sofa3', 1600, 14, 5, N'sofa3_small.png')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (1, 1, CAST(N'2019-04-04T04:31:37.000' AS DateTime), CAST(N'2019-04-10T01:32:38.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (2, 1, CAST(N'2019-01-29T02:31:10.000' AS DateTime), CAST(N'2019-02-10T02:37:47.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (3, 1, CAST(N'2019-03-08T06:27:50.000' AS DateTime), CAST(N'2019-03-18T06:02:49.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (4, 2, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2019-07-02T06:51:40.000' AS DateTime), N'inventoryVoucher')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (5, 4, CAST(N'2019-07-01T11:20:05.207' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (6, 4, CAST(N'2019-07-01T11:28:13.267' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (7, 4, CAST(N'2019-07-01T11:45:42.093' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (9, 4, CAST(N'2019-07-01T13:15:21.277' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (10, 4, CAST(N'2019-07-01T13:17:39.067' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (11, 4, CAST(N'2019-07-01T13:18:12.017' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (12, 4, CAST(N'2019-07-01T13:18:12.147' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (13, 4, CAST(N'2019-07-01T13:18:12.277' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (14, 4, CAST(N'2019-07-01T13:20:30.160' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (17, 4, CAST(N'2019-07-01T14:12:09.687' AS DateTime), CAST(N'2019-07-01T14:12:06.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (28, 4, CAST(N'2019-07-01T14:42:30.900' AS DateTime), CAST(N'2019-07-31T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (8, 4, CAST(N'2019-07-01T11:48:47.913' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (16, 4, CAST(N'2019-07-01T14:09:11.400' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (15, 4, CAST(N'2019-07-01T14:07:08.850' AS DateTime), NULL, N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (18, 4, CAST(N'2019-07-01T14:22:21.903' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (19, 4, CAST(N'2019-07-01T14:26:25.550' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (20, 4, CAST(N'2019-07-01T14:27:18.707' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (21, 4, CAST(N'2019-07-01T14:29:58.187' AS DateTime), CAST(N'2019-07-01T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (22, 4, CAST(N'2019-07-01T14:31:55.770' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (23, 4, CAST(N'2019-07-01T14:32:13.020' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (24, 4, CAST(N'2019-07-01T14:32:43.247' AS DateTime), CAST(N'2019-10-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (25, 4, CAST(N'2019-07-01T14:33:15.980' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (26, 4, CAST(N'2019-07-01T14:38:23.557' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (27, 4, CAST(N'2019-07-01T14:38:41.103' AS DateTime), CAST(N'2019-07-07T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (29, 4, CAST(N'2019-07-01T14:43:30.947' AS DateTime), CAST(N'2019-07-01T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[Order] ([orderId], [userId], [orderDate], [requiredDate], [orderType]) VALUES (30, 3, CAST(N'2019-07-01T18:28:51.980' AS DateTime), CAST(N'2019-07-01T00:00:00.000' AS DateTime), N'purchase')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (2, 6, 2, 7, 7, N'delivered')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (0, 7, 3, 3, 4, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (4, 4, 4, 0, 2, N'delivered')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (5, 1, 8, 2, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (6, 1, 9, 2, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (7, 3, 10, 6, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (8, 3, 11, 6, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (9, 4, 12, 1, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (10, 10, 13, 1, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (11, 6, 14, 5, 2, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (14, 3, 17, 6, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (25, 7, 28, 1, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (12, 1, 15, 2, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (13, 1, 16, 2, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (15, 2, 18, 4, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (16, 4, 19, 1, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (17, 4, 20, 1, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (18, 4, 21, 1, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (19, 7, 22, 1, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (20, 1, 23, 2, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (21, 9, 24, 5, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (22, 1, 25, 2, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (23, 9, 26, 5, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (24, 2, 27, 4, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (26, 2, 29, 4, 1, N'hold')
INSERT [dbo].[OrderDetails] ([orderDetailsId], [furnitureId], [orderId], [furniturePrice], [quantity], [deliveryStatus]) VALUES (27, 2, 30, 4, 1, N'hold')
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (1, 3, 2, 7, CAST(N'2019-10-06T01:53:54.000' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (2, 2, 2, 0, CAST(N'2018-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (7, 4, 2, 3, CAST(N'2018-11-04T03:52:12.000' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (0, 8, 5, 2, CAST(N'2019-07-01T11:48:48.027' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (8, 10, 4, 6, CAST(N'2019-07-01T13:17:39.187' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (9, 11, 2, 6, CAST(N'2019-07-01T13:18:12.090' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (10, 12, 2, 1, CAST(N'2019-07-01T13:18:12.220' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (11, 13, 2, 1, CAST(N'2019-07-01T13:18:12.347' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (12, 14, 4, 5, CAST(N'2019-07-01T13:20:30.270' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (15, 17, 2, 6, CAST(N'2019-07-01T14:12:09.800' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (26, 28, 4, 1, CAST(N'2019-07-01T14:42:31.010' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (13, 15, 4, 2, CAST(N'2019-07-01T14:07:08.970' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (14, 16, 2, 2, CAST(N'2019-07-01T14:09:11.517' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (16, 18, 2, 4, CAST(N'2019-07-01T14:22:22.020' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (17, 19, 2, 1, CAST(N'2019-07-01T14:26:25.670' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (18, 20, 2, 1, CAST(N'2019-07-01T14:27:18.830' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (19, 21, 2, 1, CAST(N'2019-07-01T14:29:58.297' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (20, 22, 2, 1, CAST(N'2019-07-01T14:31:55.883' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (21, 23, 4, 2, CAST(N'2019-07-01T14:32:13.097' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (22, 24, 4, 5, CAST(N'2019-07-01T14:32:43.330' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (23, 25, 4, 2, CAST(N'2019-07-01T14:33:27.237' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (24, 26, 2, 5, CAST(N'2019-07-01T14:38:23.670' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (25, 27, 2, 4, CAST(N'2019-07-01T14:38:54.670' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (27, 29, 4, 4, CAST(N'2019-07-01T14:43:31.063' AS DateTime))
INSERT [dbo].[Payment] ([paymentId], [orderId], [paymentTypeId], [totalSum], [paymentDate]) VALUES (28, 30, 4, 4, CAST(N'2019-07-01T18:28:52.033' AS DateTime))
INSERT [dbo].[PaymentType] ([paymentTypeId], [paymentType]) VALUES (5, N'cash')
INSERT [dbo].[PaymentType] ([paymentTypeId], [paymentType]) VALUES (4, N'debetCard')
INSERT [dbo].[PaymentType] ([paymentTypeId], [paymentType]) VALUES (2, N'creditCard')
INSERT [dbo].[Profile] ([profileId], [profileName], [profilePrivileges]) VALUES (1, N'admin', N'manageUsers')
INSERT [dbo].[Profile] ([profileId], [profileName], [profilePrivileges]) VALUES (2, N'customer', N'managesShopping')
INSERT [dbo].[Profile] ([profileId], [profileName], [profilePrivileges]) VALUES (3, N'employee', N'manageFurniture')
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (1, 4, CAST(N'2018-11-10T07:17:53.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (4, 2, CAST(N'2019-02-20T01:54:51.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (5, 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (6, 3, CAST(N'2016-04-18T08:41:15.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (22, 1, CAST(N'2019-09-08T00:00:00.000' AS DateTime), 8, 2, NULL)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (2, 2, CAST(N'2018-03-23T02:59:09.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (3, 3, CAST(N'2019-05-19T05:13:23.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (23, 8, CAST(N'2019-07-01T11:48:43.223' AS DateTime), 1, 1, 2)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (24, 9, CAST(N'2019-07-01T13:14:00.380' AS DateTime), 1, 1, 2)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (25, 10, CAST(N'2019-07-01T13:17:22.020' AS DateTime), 3, 1, 6)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (26, 11, CAST(N'2019-07-01T13:17:52.953' AS DateTime), 3, 1, 6)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (27, 12, CAST(N'2019-07-01T13:17:56.773' AS DateTime), 4, 1, 1)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (28, 13, CAST(N'2019-07-01T13:18:00.143' AS DateTime), 10, 1, 1)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (29, 14, CAST(N'2019-07-01T13:20:16.180' AS DateTime), 6, 2, 5)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (32, 17, CAST(N'2019-07-01T14:11:54.157' AS DateTime), 3, 1, 6)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (43, 28, CAST(N'2019-07-01T14:42:21.260' AS DateTime), 7, 1, 1)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (30, 15, CAST(N'2019-07-01T13:47:38.443' AS DateTime), 1, 1, 2)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (31, 16, CAST(N'2019-07-01T14:08:59.750' AS DateTime), 1, 1, 2)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (33, 18, CAST(N'2019-07-01T14:21:57.343' AS DateTime), 2, 1, 4)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (34, 19, CAST(N'2019-07-01T14:26:11.480' AS DateTime), 4, 1, 1)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (35, 20, CAST(N'2019-07-01T14:27:05.527' AS DateTime), 4, 1, 1)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (36, 21, CAST(N'2019-07-01T14:29:44.103' AS DateTime), 4, 1, 1)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (37, 22, CAST(N'2019-07-01T14:31:11.763' AS DateTime), 7, 1, 1)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (38, 23, CAST(N'2019-07-01T14:32:04.663' AS DateTime), 1, 1, 2)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (39, 24, CAST(N'2019-07-01T14:32:29.560' AS DateTime), 9, 1, 5)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (40, 25, CAST(N'2019-07-01T14:32:50.673' AS DateTime), 1, 1, 2)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (41, 26, CAST(N'2019-07-01T14:37:56.213' AS DateTime), 9, 1, 5)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (42, 27, CAST(N'2019-07-01T14:38:29.347' AS DateTime), 2, 1, 4)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (44, 29, CAST(N'2019-07-01T14:43:25.273' AS DateTime), 2, 1, 4)
INSERT [dbo].[ShoppingCart] ([shoppingCartId], [orderId], [shoppingCartDate], [productID], [quantity], [productSum]) VALUES (45, 30, CAST(N'2019-07-01T18:28:39.153' AS DateTime), 2, 1, 4)
INSERT [dbo].[UserProfile] ([userId], [profileId]) VALUES (1, 1)
INSERT [dbo].[UserProfile] ([userId], [profileId]) VALUES (2, 1)
INSERT [dbo].[UserProfile] ([userId], [profileId]) VALUES (4, 2)
INSERT [dbo].[UserProfile] ([userId], [profileId]) VALUES (3, 3)
INSERT [dbo].[Users] ([userId], [shoppingCartId], [userName], [password], [userHint]) VALUES (1, 1, N'ogo@gmail.com', N'7Ogo_ogo', 3)
INSERT [dbo].[Users] ([userId], [shoppingCartId], [userName], [password], [userHint]) VALUES (2, 3, N'user1@gmail.com', N'user1', 2)
INSERT [dbo].[Users] ([userId], [shoppingCartId], [userName], [password], [userHint]) VALUES (3, 2, N'user2@gmail.com', N'user2', 1)
INSERT [dbo].[Users] ([userId], [shoppingCartId], [userName], [password], [userHint]) VALUES (4, 0, N'ogo2@gmail.com', N'ogo2@gmail.com', NULL)
/****** Object:  Index [PK_CATEGORIES]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [PK_CATEGORIES] PRIMARY KEY NONCLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_FURNITURE]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[Furniture] ADD  CONSTRAINT [PK_FURNITURE] PRIMARY KEY NONCLUSTERED 
(
	[furnitureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION3_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION3_FK] ON [dbo].[Furniture]
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_ORDER]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [PK_ORDER] PRIMARY KEY NONCLUSTERED 
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION5_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION5_FK] ON [dbo].[Order]
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_ORDERDETAILS]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [PK_ORDERDETAILS] PRIMARY KEY NONCLUSTERED 
(
	[orderDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION2_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION2_FK] ON [dbo].[OrderDetails]
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION6_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION6_FK] ON [dbo].[OrderDetails]
(
	[furnitureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_PAYMENT]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[Payment] ADD  CONSTRAINT [PK_PAYMENT] PRIMARY KEY NONCLUSTERED 
(
	[paymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION8_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION8_FK] ON [dbo].[Payment]
(
	[paymentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION9_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION9_FK] ON [dbo].[Payment]
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_PAYMENTTYPE]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[PaymentType] ADD  CONSTRAINT [PK_PAYMENTTYPE] PRIMARY KEY NONCLUSTERED 
(
	[paymentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_PROFILE]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [PK_PROFILE] PRIMARY KEY NONCLUSTERED 
(
	[profileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_SHOPPINGCART]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[ShoppingCart] ADD  CONSTRAINT [PK_SHOPPINGCART] PRIMARY KEY NONCLUSTERED 
(
	[shoppingCartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION7_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION7_FK] ON [dbo].[ShoppingCart]
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION11_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION11_FK] ON [dbo].[UserProfile]
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION11_FK2]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION11_FK2] ON [dbo].[UserProfile]
(
	[profileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_USERS]    Script Date: 2019-07-01 6:37:24 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [PK_USERS] PRIMARY KEY NONCLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ASSOCIATION13_FK]    Script Date: 2019-07-01 6:37:24 PM ******/
CREATE NONCLUSTERED INDEX [ASSOCIATION13_FK] ON [dbo].[Users]
(
	[shoppingCartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Furniture]  WITH CHECK ADD  CONSTRAINT [FK_FURNITUR_ASSOCIATI_CATEGORI] FOREIGN KEY([categoryId])
REFERENCES [dbo].[Categories] ([categoryId])
GO
ALTER TABLE [dbo].[Furniture] CHECK CONSTRAINT [FK_FURNITUR_ASSOCIATI_CATEGORI]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_ASSOCIATI_USERS] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_ORDER_ASSOCIATI_USERS]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_ORDERDET_ASSOCIATI_FURNITUR] FOREIGN KEY([furnitureId])
REFERENCES [dbo].[Furniture] ([furnitureId])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_ORDERDET_ASSOCIATI_FURNITUR]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_ORDERDET_ASSOCIATI_ORDER] FOREIGN KEY([orderId])
REFERENCES [dbo].[Order] ([orderId])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_ORDERDET_ASSOCIATI_ORDER]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_PAYMENT_ASSOCIATI_ORDER] FOREIGN KEY([orderId])
REFERENCES [dbo].[Order] ([orderId])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_PAYMENT_ASSOCIATI_ORDER]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_PAYMENT_ASSOCIATI_PAYMENTT] FOREIGN KEY([paymentTypeId])
REFERENCES [dbo].[PaymentType] ([paymentTypeId])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_PAYMENT_ASSOCIATI_PAYMENTT]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_SHOPPING_ASSOCIATI_ORDER] FOREIGN KEY([orderId])
REFERENCES [dbo].[Order] ([orderId])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_SHOPPING_ASSOCIATI_ORDER]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Furniture] FOREIGN KEY([productID])
REFERENCES [dbo].[Furniture] ([furnitureId])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Furniture]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_USERPROF_USERPROFI_PROFILE] FOREIGN KEY([profileId])
REFERENCES [dbo].[Profile] ([profileId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_USERPROF_USERPROFI_PROFILE]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_USERPROF_USERPROFI_USERS] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_USERPROF_USERPROFI_USERS]
GO
USE [master]
GO
ALTER DATABASE [furniture] SET  READ_WRITE 
GO
