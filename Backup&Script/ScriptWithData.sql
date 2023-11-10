USE [master]
GO
/****** Object:  Database [DealerAppDb]    Script Date: 10.11.2023 20:05:45 ******/
CREATE DATABASE [DealerAppDb1]
 USE [DealerAppDb1]

CREATE TABLE [dbo].[AccountTransactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerAccountId] [int] NULL,
	[UserAccountId] [int] NULL,
	[Amount] [money] NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_AccountTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Baskets]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Baskets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[Price] [money] NOT NULL,
 CONSTRAINT [PK_Basket] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerAccounts]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAccounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[IBAN] [varchar](26) NULL,
	[BankName] [varchar](max) NULL,
	[Balance] [money] NULL,
 CONSTRAINT [PK_CustomerAccounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerCards]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCards](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[CardHolder] [varchar](max) NULL,
	[CardNumber] [varchar](16) NULL,
	[Limit] [money] NULL,
	[Cvv] [varchar](3) NULL,
 CONSTRAINT [PK_CustomerCards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerCardTransactions]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCardTransactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCardId] [int] NULL,
	[UserAccountId] [int] NULL,
	[Amount] [money] NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_CustomerCardTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerRelationships]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRelationships](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[PriceListId] [int] NULL,
	[Discount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_CustomerRelationships] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Email] [varchar](max) NOT NULL,
	[PasswordSalt] [varbinary](max) NOT NULL,
	[PasswordHash] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailParameters]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailParameters](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Smtp] [varchar](max) NOT NULL,
	[Email] [varchar](max) NOT NULL,
	[Password] [varchar](max) NOT NULL,
	[Port] [int] NOT NULL,
	[SSL] [bit] NOT NULL,
	[HTML] [bit] NOT NULL,
 CONSTRAINT [PK_EmailParameters] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SenderId] [int] NOT NULL,
	[ReceiverId] [int] NOT NULL,
	[Content] [varchar](max) NOT NULL,
	[TimeStamp] [datetime] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationClaims]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_OperationClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[Price] [money] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderNumber] [varchar](16) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Status] [varchar](max) NOT NULL,
	[IsPaid] [bit] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PriceListDetails]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceListDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PriceListId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Price] [money] NOT NULL,
 CONSTRAINT [PK_PriceListDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PriceLists]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceLists](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
 CONSTRAINT [PK_PriceLists] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[ImageUrl] [varchar](max) NOT NULL,
	[IsMainImage] [bit] NOT NULL,
 CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Stock] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccounts]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[BankName] [varchar](max) NULL,
	[IBAN] [varchar](26) NULL,
	[Balance] [money] NULL,
 CONSTRAINT [PK_UserAccounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserOperationClaims]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserOperationClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[OperationClaimId] [int] NOT NULL,
 CONSTRAINT [PK_UserOperationClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Email] [varchar](max) NOT NULL,
	[ImageUrl] [varchar](max) NOT NULL,
	[PasswordSalt] [varbinary](max) NOT NULL,
	[PasswordHash] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_Users_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AccountTransactions] ON 
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (1, 1, 1, 1000.0000, CAST(N'2023-11-07T02:18:23.180' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (2, 1, 1, 500000.0000, CAST(N'2023-11-07T13:23:44.060' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (3, 1, 1, 100000.0000, CAST(N'2023-11-07T15:03:46.677' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (4, 1, 1, 500000.0000, CAST(N'2023-11-07T15:29:41.213' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (5, 1, 1, 11111.0000, CAST(N'2023-11-07T15:42:07.087' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (6, 1, 1, 12312.0000, CAST(N'2023-11-07T15:57:58.657' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (7, 1, 1, 12321.0000, CAST(N'2023-11-07T16:05:37.500' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (8, 1, 1, 32000.0000, CAST(N'2023-11-07T16:38:31.373' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (9, 1, 1, 22400.0000, CAST(N'2023-11-08T00:54:06.557' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (10, 1, 1, 9600.0000, CAST(N'2023-11-08T17:28:26.930' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (11, 1, 1, 9600.0000, CAST(N'2023-11-08T20:20:32.193' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (12, 1, 1, 9600.0000, CAST(N'2023-11-08T20:24:54.433' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (13, 1, 1, 25600.0000, CAST(N'2023-11-08T20:31:02.707' AS DateTime))
GO
INSERT [dbo].[AccountTransactions] ([Id], [CustomerAccountId], [UserAccountId], [Amount], [Date]) VALUES (14, 4, 1, 29784.0000, CAST(N'2023-11-10T17:48:13.420' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[AccountTransactions] OFF
GO
SET IDENTITY_INSERT [dbo].[Baskets] ON 
GO
INSERT [dbo].[Baskets] ([Id], [CustomerId], [ProductId], [Quantity], [Price]) VALUES (33, 6, 1007, CAST(2.00 AS Decimal(18, 2)), 13500.0000)
GO
INSERT [dbo].[Baskets] ([Id], [CustomerId], [ProductId], [Quantity], [Price]) VALUES (34, 6, 1008, CAST(1.00 AS Decimal(18, 2)), 18000.0000)
GO
INSERT [dbo].[Baskets] ([Id], [CustomerId], [ProductId], [Quantity], [Price]) VALUES (110, 8, 1016, CAST(1.00 AS Decimal(18, 2)), 1275.0000)
GO
SET IDENTITY_INSERT [dbo].[Baskets] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerAccounts] ON 
GO
INSERT [dbo].[CustomerAccounts] ([Id], [CustomerId], [IBAN], [BankName], [Balance]) VALUES (1, 1, N'14785296325295226526265265', N'VakıfBank', 18754456.0000)
GO
INSERT [dbo].[CustomerAccounts] ([Id], [CustomerId], [IBAN], [BankName], [Balance]) VALUES (3, 1, N'56489416519841651165165156', N'ZiratBank', 0.0000)
GO
INSERT [dbo].[CustomerAccounts] ([Id], [CustomerId], [IBAN], [BankName], [Balance]) VALUES (4, 8, N'47102929595929295719256265', N'Ziraat Bank', 9970216.0000)
GO
INSERT [dbo].[CustomerAccounts] ([Id], [CustomerId], [IBAN], [BankName], [Balance]) VALUES (5, 8, N'74569949263178253571527228', N'VakıfBank', 1200000.0000)
GO
SET IDENTITY_INSERT [dbo].[CustomerAccounts] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerCards] ON 
GO
INSERT [dbo].[CustomerCards] ([Id], [CustomerId], [CardHolder], [CardNumber], [Limit], [Cvv]) VALUES (1, 1, N'Nuray Ertantu', N'1485963274859632', 1000000.0000, N'741')
GO
INSERT [dbo].[CustomerCards] ([Id], [CustomerId], [CardHolder], [CardNumber], [Limit], [Cvv]) VALUES (2, 1, N'Furkan Ertantu', N'1482269595992225', 1199200.0000, N'341')
GO
INSERT [dbo].[CustomerCards] ([Id], [CustomerId], [CardHolder], [CardNumber], [Limit], [Cvv]) VALUES (3, 8, N'Ahmet Yılmaz', N'7415963258528522', 54275.0000, N'852')
GO
INSERT [dbo].[CustomerCards] ([Id], [CustomerId], [CardHolder], [CardNumber], [Limit], [Cvv]) VALUES (4, 8, N'Fulya Yılmaz', N'4142629527110320', 160500.0000, N'826')
GO
SET IDENTITY_INSERT [dbo].[CustomerCards] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerCardTransactions] ON 
GO
INSERT [dbo].[CustomerCardTransactions] ([Id], [CustomerCardId], [UserAccountId], [Amount], [date]) VALUES (1, 3, 1, 33660.0000, CAST(N'2023-11-10T16:19:18.307' AS DateTime))
GO
INSERT [dbo].[CustomerCardTransactions] ([Id], [CustomerCardId], [UserAccountId], [Amount], [date]) VALUES (2, 3, 1, 12750.0000, CAST(N'2023-11-10T18:46:50.143' AS DateTime))
GO
INSERT [dbo].[CustomerCardTransactions] ([Id], [CustomerCardId], [UserAccountId], [Amount], [date]) VALUES (3, 3, 1, 1020.0000, CAST(N'2023-11-10T18:48:23.177' AS DateTime))
GO
INSERT [dbo].[CustomerCardTransactions] ([Id], [CustomerCardId], [UserAccountId], [Amount], [date]) VALUES (4, 3, 1, 42500.0000, CAST(N'2023-11-10T20:00:54.453' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[CustomerCardTransactions] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerRelationships] ON 
GO
INSERT [dbo].[CustomerRelationships] ([Id], [CustomerId], [PriceListId], [Discount]) VALUES (1, 1, 2, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[CustomerRelationships] ([Id], [CustomerId], [PriceListId], [Discount]) VALUES (2, 5, 5, CAST(25.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[CustomerRelationships] ([Id], [CustomerId], [PriceListId], [Discount]) VALUES (3, 4, 3, CAST(17.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[CustomerRelationships] ([Id], [CustomerId], [PriceListId], [Discount]) VALUES (4, 6, 4, CAST(10.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[CustomerRelationships] ([Id], [CustomerId], [PriceListId], [Discount]) VALUES (6, 8, 1, CAST(15.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[CustomerRelationships] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email], [PasswordSalt], [PasswordHash]) VALUES (1, N'Anadolu Bilişim', N'anadolu@gmail.com', 0x5F6A07194DAC4B1E992AFF3F1A7A35E4CD98098AB8EF672FAC0C14F6FF6EA2B1A4608724F98ACA41290403F01BCB5A7275827EC98FAC5B2CA5AC1FCB13EADB953F3209573B1DA145D9D514D9DCD98589379146132E11F159EBAA3E0DD0D42BEE59FB633E36EC65F58CEF7CF1E0A4383DCA745E4C4B09900E804D96ABD9E3143D, 0xEA01EDF1098FEF825DEE95290FE99ABE18D64330CA4E0067C879BCEC2A0A15741D812ADD7D07EC8051A8B71544C2455035A49E2DFFACFF22766EE364C81A263D)
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email], [PasswordSalt], [PasswordHash]) VALUES (4, N'Bulut Bilişim', N'bulut@gmail.com', 0x305ED42F2E7AA2B0BEE90B7BC5B11914820976D046F46A3F8048DA163B7FDE753B6DBF2D5DD12BDEA97B8EA9E0EF5201F12EFCC9C0C24BBB08C2AEA9CD5ED9F74EE720665DC1BD9B323069B48F1A5F195295E9AC7A5BB8DB9D5177981D6EAC6DC4EADD340AAE1C593DC954625394CC282B82220483924E8A7F7C01C30A1F0EE5, 0x4F86ED6A228683618C2B74BD95C66331C57C81A0714BDD2A5258FA5786590C1C051691E76D769CA1DE0600BEA734ADEA8B1042843A38D4B5CB690CD726F71617)
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email], [PasswordSalt], [PasswordHash]) VALUES (5, N'Yılmaz Ticaret', N'yilmaz@gmail.com', 0xBD30A2D52D21BF3F07919707E449F703DA106889082E9747C9512535066C727F47AF46FC8B59831BC815B136FB1093C637F93A0EB33EFE28E9AB394AACD17DE97A11C2531E4C66A395A463BC00B076ADE71475ECE6F6CC45D4E1236BA96BE6877ED7776AF123BB9443F72692F1CB1FC4F491C1417E36F2B5734F022D632D23EF, 0xC61611F564BF86369B1FE4590EE3E92D30EFE6A1B9FB5AA5BC61584EDA0FAA5467F7630EB76D091B838E2AA07CF6FD267EC4DA89CCD234226884CBDBF3CE4336)
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email], [PasswordSalt], [PasswordHash]) VALUES (6, N'Kristal Bilişim', N'kristal@gmail.com', 0xAEB9BD82BB8C5A061674AEEA614696864CC79AE5F13B8D656057088839805C548EF654D360EB1F6F2DF2A9BB01F81DE2795267678373C055CE4886687501E8DBD4EF47FFB805D9F48E9A2EE44606316EEDAEC1FC47720EB94AE9983D77F3540F6FAFCE9EFF37AA0523538774A2E3404F2FBC1C53BA58BF2F8022DA8C2E2F326F, 0x9EEDD1DE9231B64D5B7000C8368D54D7701BF4DED900350B45C60976195AC7FE463BC4121041505587D0857577DDB73AF82BB9E8C1185743DF7942EFDEAC704C)
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email], [PasswordSalt], [PasswordHash]) VALUES (8, N'Akasya Bilişim', N'akasya@gmail.com', 0x5D47825CDB8EF9DF9BB736DED2E54CEF1BA59B94C2F442C968539F594EB4FA8B5C8AC00A942A4373DF6FB2E7BE7C567E2B54AD34D402E7932834EF0ACB311901556C1738ACA99E88B07426E23EE34A494E13F6811CEA23EDB7975F58071328FF88C2ED08E3D62A437FE90B75747B95E7549EF996F5651B7F0B1AB01E93C37483, 0xC24975B7D0CD3A6310C50ADF0AD0E9844712C7E04104C636571B35394BBACDFB5676BA7FA37C758C732B715A639B84C745B8D4001F774589602289B58550A86F)
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (1, 1, 4, N'denemededed', CAST(N'2023-11-03T18:22:38.153' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (2, 1, 4, N'denemededed', CAST(N'2023-11-03T18:22:38.153' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (5, 1, 5, N'denemededed', CAST(N'2023-11-03T18:22:38.153' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (6, 1, 4, N'ilk mesajımız', CAST(N'2023-11-03T23:37:15.410' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (7, 1, 4, N'ikinci mesaj', CAST(N'2023-11-03T23:39:55.257' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (8, 1, 4, N'', CAST(N'2023-11-03T23:40:06.767' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (9, 1, 4, N'niye olmadı', CAST(N'2023-11-03T23:40:23.347' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (10, 1, 4, N'oldu mu', CAST(N'2023-11-03T23:40:51.283' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (11, 1, 5, N'ikincii mesahı', CAST(N'2023-11-03T23:41:02.283' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (12, 1, 6, N'ilk mesaj', CAST(N'2023-11-03T23:41:11.227' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (13, 1, 5, N'string', CAST(N'2023-11-03T20:45:58.357' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (14, 1, 5, N'asdsadasdasd', CAST(N'2023-11-03T20:45:58.357' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (15, 1, 5, N'asdasda
', CAST(N'2023-11-04T00:01:45.900' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (16, 1, 5, N'asdasdas', CAST(N'2023-11-04T00:01:47.627' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (17, 1, 5, N'asdsad', CAST(N'2023-11-04T00:01:48.603' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (18, 1, 5, N'asdasdsa', CAST(N'2023-11-04T00:01:49.840' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (19, 1, 5, N'asdasdasd', CAST(N'2023-11-04T00:01:51.397' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (20, 1, 5, N'asdasda', CAST(N'2023-11-04T00:01:52.323' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (21, 1, 5, N'asdasdas', CAST(N'2023-11-04T00:01:54.077' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (22, 1, 5, N'adsadsad', CAST(N'2023-11-04T00:01:55.107' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (23, 1, 5, N'asdsadas', CAST(N'2023-11-04T00:01:56.177' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (24, 1, 5, N'asdasdas', CAST(N'2023-11-04T00:02:44.653' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (25, 1, 5, N'asdas', CAST(N'2023-11-04T00:07:09.687' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (26, 1, 5, N'mkökök', CAST(N'2023-11-04T00:07:16.360' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (27, 1, 5, N'deneme', CAST(N'2023-11-04T00:13:59.570' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (28, 1, 5, N'old umu', CAST(N'2023-11-04T00:15:00.477' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (29, 1, 5, N'asdksajşd', CAST(N'2023-11-04T00:17:00.827' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (30, 1, 5, N'kjdfnskdjfnslfjnsdlkfnsdşlkfsdnflkşsdnfslkdnfsşlkdfnsşlkfnsdlkfnsdşlkfnsdlkfnsdlfnsşklfdnsdlşkfnsdşlksndşlfsndlkşsdnfşlksdnflksdfnşlksdfnlkşsdfnsdlkfnslkdfnsdlşfnsdşlkfsdnşklsdnfşlsdn', CAST(N'2023-11-04T00:36:37.287' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (31, 1, 4, N'adjaşkdamsdlkşmfdlkamsskdasmsdkmlksmdclkdmklsdmlmsmksldmfklsdmflksdmflksdmflksdmflksdmflksdlfkdsmfklsdmflksmdflkmfslksmdflksmflksmdflksmdflksmflksdmflksdmflksmfs', CAST(N'2023-11-04T14:46:47.853' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (32, 1, 5, N'bune lan
', CAST(N'2023-11-04T15:00:31.697' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (33, 1, 5, N'güzel şeyler oluyor', CAST(N'2023-11-04T12:13:36.950' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (34, 1, 5, N'sevdik bu işi', CAST(N'2023-11-04T12:13:36.950' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (35, 1, 5, N'devam
', CAST(N'2023-11-04T15:14:58.857' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (36, 1, 5, N'uzun mesaj yazaulım sdsldkdmalkdfmsaiaslddişlmdai,ş öa ösşdö laö lsöfd öa,is öasf öfdlm s  sad sfd f dassdbu işi', CAST(N'2023-11-04T12:13:36.950' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (37, 1, 5, N'furkanerntantun aşkdmfsdlkfaşknsşkdfsmas4
', CAST(N'2023-11-04T15:15:47.357' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (38, 1, 5, N'fvfvfvf
', CAST(N'2023-11-04T19:12:54.747' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (39, 1, 5, N'string', CAST(N'2023-11-04T16:48:07.950' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (41, 1, 5, N'deneme', CAST(N'2023-11-08T19:14:37.987' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (42, 1, 5, N'deneme', CAST(N'2023-11-08T19:15:38.923' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (43, 1, 5, N'deneme', CAST(N'2023-11-08T19:22:18.927' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (44, 1, 5, N'oldu ', CAST(N'2023-11-08T19:22:30.100' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (45, 1, 5, N'abone', CAST(N'2023-11-08T19:33:35.183' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (46, 1, 5, N'mesaj', CAST(N'2023-11-08T19:34:57.223' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (47, 1, 5, N'mesaj2 ', CAST(N'2023-11-08T19:35:56.147' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (48, 1, 5, N'mesaj3', CAST(N'2023-11-08T19:36:07.613' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (49, 1, 5, N'selam', CAST(N'2023-11-08T19:41:51.007' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (50, 1, 5, N'selam', CAST(N'2023-11-08T19:42:02.427' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (51, 1, 5, N'nasılsın', CAST(N'2023-11-08T19:42:22.773' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (52, 1, 5, N'iyiyim sen
', CAST(N'2023-11-08T19:43:10.547' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (53, 1, 5, N'ben de iyiim', CAST(N'2023-11-08T19:43:19.453' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (54, 1, 5, N'teşekkürler', CAST(N'2023-11-08T19:44:41.143' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (55, 1, 5, N'teşekkürler', CAST(N'2023-11-08T19:44:49.177' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (56, 1, 1, N'deneme
', CAST(N'2023-11-09T14:33:33.027' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (57, 1, 1, N'mesaj 1
', CAST(N'2023-11-09T14:33:45.637' AS DateTime), 1)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (58, 1, 1, N'nasılsın', CAST(N'2023-11-09T14:33:52.220' AS DateTime), 0)
GO
INSERT [dbo].[Messages] ([Id], [SenderId], [ReceiverId], [Content], [TimeStamp], [IsAdmin]) VALUES (59, 1, 1, N'iyiym sen nasılsın', CAST(N'2023-11-09T14:33:57.960' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[OperationClaims] ON 
GO
INSERT [dbo].[OperationClaims] ([Id], [Name]) VALUES (1, N'admin')
GO
INSERT [dbo].[OperationClaims] ([Id], [Name]) VALUES (2, N'product.add')
GO
INSERT [dbo].[OperationClaims] ([Id], [Name]) VALUES (3, N'product.delete')
GO
INSERT [dbo].[OperationClaims] ([Id], [Name]) VALUES (4, N'product.update')
GO
INSERT [dbo].[OperationClaims] ([Id], [Name]) VALUES (5, N'product.get')
GO
SET IDENTITY_INSERT [dbo].[OperationClaims] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (19, 12, 1007, CAST(10.00 AS Decimal(18, 2)), 13500.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (20, 12, 1008, CAST(5.00 AS Decimal(18, 2)), 18000.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (21, 12, 1009, CAST(15.00 AS Decimal(18, 2)), 4500.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (22, 13, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (23, 13, 1007, CAST(112.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (24, 15, 1007, CAST(1.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (25, 15, 1009, CAST(1.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (26, 15, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (27, 16, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (28, 16, 1009, CAST(1.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (29, 16, 1007, CAST(1.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (30, 17, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (31, 17, 1009, CAST(1.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (32, 17, 1007, CAST(10.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (33, 17, 1008, CAST(10.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (34, 17, 1009, CAST(10.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (36, 19, 1007, CAST(1.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (37, 20, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (38, 21, 1009, CAST(1.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (39, 22, 1009, CAST(1.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (40, 22, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (41, 23, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (42, 23, 1007, CAST(1.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (46, 25, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (47, 25, 1007, CAST(1.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (48, 26, 1009, CAST(1.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (49, 26, 1009, CAST(1.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (50, 26, 1009, CAST(1.00 AS Decimal(18, 2)), 3200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (51, 27, 1008, CAST(1.00 AS Decimal(18, 2)), 15000.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (52, 28, 1007, CAST(100.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (53, 29, 1007, CAST(100.00 AS Decimal(18, 2)), 9600.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (54, 30, 1008, CAST(1.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (55, 30, 1008, CAST(10.00 AS Decimal(18, 2)), 12800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (56, 31, 1008, CAST(2.00 AS Decimal(18, 2)), 800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (57, 32, 1007, CAST(3.00 AS Decimal(18, 2)), 11200.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (58, 32, 1008, CAST(2.00 AS Decimal(18, 2)), 800.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (59, 32, 1009, CAST(4.00 AS Decimal(18, 2)), 2000.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (60, 33, 1013, CAST(8.00 AS Decimal(18, 2)), 1020.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (61, 33, 1007, CAST(2.00 AS Decimal(18, 2)), 12750.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (62, 34, 1007, CAST(2.00 AS Decimal(18, 2)), 12750.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (63, 34, 1013, CAST(4.00 AS Decimal(18, 2)), 1020.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (64, 34, 1006, CAST(2.00 AS Decimal(18, 2)), 102.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (65, 35, 1007, CAST(1.00 AS Decimal(18, 2)), 12750.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (66, 36, 1013, CAST(1.00 AS Decimal(18, 2)), 1020.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (67, 37, 1008, CAST(1.00 AS Decimal(18, 2)), 17000.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (68, 37, 1012, CAST(10.00 AS Decimal(18, 2)), 1275.0000)
GO
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price]) VALUES (69, 37, 1007, CAST(1.00 AS Decimal(18, 2)), 12750.0000)
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (12, 6, N'SN00000000000001', CAST(N'2023-11-04T23:22:56.030' AS DateTime), N'Sevke Hazır', 0)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (13, 1, N'SN00000000000002', CAST(N'2023-11-05T19:54:42.913' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (15, 1, N'SN00000000000003', CAST(N'2023-11-07T01:10:08.777' AS DateTime), N'Reddedilen', 0)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (16, 1, N'SN00000000000004', CAST(N'2023-11-07T01:11:07.043' AS DateTime), N'Sevke Hazır', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (17, 1, N'SN00000000000005', CAST(N'2023-11-07T15:43:30.440' AS DateTime), N'Sevke Hazır', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (19, 1, N'SN00000000000006', CAST(N'2023-11-07T16:02:29.277' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (20, 1, N'SN00000000000007', CAST(N'2023-11-07T16:03:54.497' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (21, 1, N'SN00000000000008', CAST(N'2023-11-07T16:07:02.783' AS DateTime), N'Reddedilen', 0)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (22, 1, N'SN00000000000009', CAST(N'2023-11-07T16:37:18.543' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (23, 1, N'SN00000000000010', CAST(N'2023-11-07T16:42:34.477' AS DateTime), N'İşlemde', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (25, 1, N'SN00000000000012', CAST(N'2023-11-07T16:56:08.070' AS DateTime), N'Reddedilen', 0)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (26, 1, N'SN00000000000013', CAST(N'2023-11-08T17:26:12.603' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (27, 5, N'SN00000000000014', CAST(N'2023-11-08T19:47:04.347' AS DateTime), N'İşlemde', 0)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (28, 1, N'SN00000000000015', CAST(N'2023-11-08T20:20:03.117' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (29, 1, N'SN00000000000016', CAST(N'2023-11-08T20:24:38.180' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (30, 1, N'SN00000000000017', CAST(N'2023-11-08T20:30:49.893' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (31, 1, N'SN00000000000018', CAST(N'2023-11-09T14:28:29.140' AS DateTime), N'İşlemde', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (32, 1, N'SN00000000000019', CAST(N'2023-11-09T20:11:46.857' AS DateTime), N'İşlemde', 0)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (33, 8, N'SN00000000000020', CAST(N'2023-11-10T13:57:58.073' AS DateTime), N'İşlemde', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (34, 8, N'SN00000000000021', CAST(N'2023-11-10T17:46:58.913' AS DateTime), N'Sevkiyatı Yapıldı', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (35, 8, N'SN00000000000022', CAST(N'2023-11-10T18:04:33.643' AS DateTime), N'İşlemde', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (36, 8, N'SN00000000000023', CAST(N'2023-11-10T18:07:14.560' AS DateTime), N'İşlemde', 1)
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderNumber], [Date], [Status], [IsPaid]) VALUES (37, 8, N'SN00000000000024', CAST(N'2023-11-10T18:49:47.977' AS DateTime), N'Sevke Hazır', 1)
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[PriceListDetails] ON 
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (5, 2, 1007, 14000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (6, 1, 1007, 15000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (7, 1, 1008, 20000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (8, 1, 1009, 5000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (9, 2, 1008, 1000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (10, 2, 1009, 2500.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (11, 1, 1013, 1200.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (12, 1, 1016, 1500.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (13, 1, 1014, 15000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (14, 1, 1011, 1250.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (15, 2, 1013, 1700.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (16, 2, 1016, 1600.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (17, 2, 1006, 50.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (18, 2, 1011, 745.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (19, 2, 1012, 800.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (20, 3, 1013, 2000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (21, 3, 1007, 17000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (22, 3, 1016, 2500.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (23, 3, 1008, 450.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (24, 3, 1014, 18500.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (25, 3, 1006, 80.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (26, 3, 1011, 1450.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (27, 3, 1012, 960.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (28, 1, 1010, 750.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (29, 1, 1017, 12000.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (30, 1, 1012, 1500.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (31, 1, 1015, 2400.0000)
GO
INSERT [dbo].[PriceListDetails] ([Id], [PriceListId], [ProductId], [Price]) VALUES (32, 1, 1006, 120.0000)
GO
SET IDENTITY_INSERT [dbo].[PriceListDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[PriceLists] ON 
GO
INSERT [dbo].[PriceLists] ([Id], [Name]) VALUES (1, N' Ekim Fiyat Listesi')
GO
INSERT [dbo].[PriceLists] ([Id], [Name]) VALUES (2, N'Kasım Fiyat Listesi')
GO
INSERT [dbo].[PriceLists] ([Id], [Name]) VALUES (3, N'Aralık Fiyat Listesi')
GO
INSERT [dbo].[PriceLists] ([Id], [Name]) VALUES (4, N'Ocak Fiyat Listesi')
GO
INSERT [dbo].[PriceLists] ([Id], [Name]) VALUES (5, N'Şubat Fiyat Listesi')
GO
INSERT [dbo].[PriceLists] ([Id], [Name]) VALUES (6, N'Mart Fiyat Listesi')
GO
SET IDENTITY_INSERT [dbo].[PriceLists] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1022, 1007, N'16354a96-4583-4065-aca9-caf99420350b.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1023, 1007, N'9aff4a9d-cd5a-491b-95bf-ac0f39f635a7.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1025, 1008, N'aeed6879-f9a9-4e91-adcc-97afab460727.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1026, 1009, N'a025db6e-bb41-40f0-894b-1de649cb72ea.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1027, 1006, N'87099e69-2063-45be-b73c-6befded6b1e0.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1028, 1013, N'183d1283-a1c3-4953-901b-9fe0bbf9fac3.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1029, 1013, N'1e50de85-7853-4dfa-b111-9e182b1a003c.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1030, 1013, N'8b14bcd4-8ed8-478b-bfd9-f7b1867490bc.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1031, 1016, N'053a0644-5b85-450a-b2a8-df62a57fd5ca.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1032, 1016, N'28691dd5-8891-43cd-a38a-37f31161c2e2.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1033, 1014, N'9c43a273-5160-41e9-b2de-0651c3b74920.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1034, 1014, N'5325b7ab-4da6-48e8-b31e-4377e0d856f6.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1035, 1011, N'a0def475-1e12-4bce-892f-486c7d18ec03.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1036, 1011, N'b6ed8574-747c-4c59-8955-2c76a6d2bece.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1037, 1011, N'1c53be5d-a268-4c7a-9880-dfd54feeb52d.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1038, 1012, N'5f59f95e-95d9-4851-82d6-400fd960fb14.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1039, 1012, N'd79986a0-c33a-4c56-ae56-ee1d5b5cb945.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1040, 1012, N'dae97f6b-595a-4c64-a05c-c77cb8096236.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1041, 1015, N'efa6f087-6a32-4340-bf1a-89f507a13d3f.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1042, 1015, N'734179f1-39fb-4555-b896-5ffa474680eb.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1043, 1015, N'cf4c1c6f-b3b2-47dc-920b-587412582b20.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1044, 1010, N'ce8e4aa9-a4a3-41fc-9bf1-12720f802c50.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1045, 1010, N'da643758-ffba-488c-b5b6-f806e283babe.jpeg', 1)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1046, 1010, N'6402e887-6e16-42d2-98b7-e1fca11f95c6.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1047, 1009, N'c7252442-3122-4f95-a11b-439c608ec67d.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1048, 1017, N'360b3c5a-1f51-46b9-b418-469bb99cfeee.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1049, 1017, N'2a1734f8-df2e-4897-aa6f-7432aaa63f47.jpeg', 0)
GO
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsMainImage]) VALUES (1050, 1017, N'248059ba-04f1-41c1-b934-00dfff2481c2.jpeg', 1)
GO
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1006, N'Kitap', 98)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1007, N'Bilgisayar', 238)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1008, N'Çanta', 482)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1009, N'Süpürge', 146)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1010, N'Mouse', 1000)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1011, N'Klavye', 1200)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1012, N'Kulaklık ', 740)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1013, N'Akıllı Saat', 1496)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1014, N'Kamera', 650)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1015, N'Mikrofon', 853)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1016, N'Bilgisayar Kasası', 251)
GO
INSERT [dbo].[Products] ([Id], [Name], [Stock]) VALUES (1017, N'Telefon', 1745)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[UserAccounts] ON 
GO
INSERT [dbo].[UserAccounts] ([Id], [UserId], [BankName], [IBAN], [Balance]) VALUES (1, 1, N'VakıfBank', N'12001556203274128596485632', 2365258.0000)
GO
INSERT [dbo].[UserAccounts] ([Id], [UserId], [BankName], [IBAN], [Balance]) VALUES (3, 1, N'Halkbank', N'62165116515649851233266556', 800.0000)
GO
SET IDENTITY_INSERT [dbo].[UserAccounts] OFF
GO
SET IDENTITY_INSERT [dbo].[UserOperationClaims] ON 
GO
INSERT [dbo].[UserOperationClaims] ([Id], [UserId], [OperationClaimId]) VALUES (1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[UserOperationClaims] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [Name], [Email], [ImageUrl], [PasswordSalt], [PasswordHash]) VALUES (1, N'Furkan Ertantu', N'admin@adminmail.com', N'41745ae1-fe8e-4b2e-9df9-8c4002f59424.jpg', 0x3710DB92D178EE87F7A021CE54C3FE9F491293FC16BF7D63B85CCE4D10000E85EC0308B5312FC155CF0A0D35283F89D1D99AE43092055FDD2A46149B2B3576F221074928878CAAF5C9F8525E54F0B4D49955080C3684FAB7A3327CBBB872AA34B6522CFA4E021EA352A1A1AEA7737E80C1798E4AFF841B3394380D2D21356E6A, 0x63D8C51D535BE2082EDA098DFE17491AE2440204A69A37022FD48FDB5B0369AC2591C0F0308ECD156CD9413457F186F91D9F209AC0B8AA561A13CFE977437108)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_CustomerAccounts_IBAN]    Script Date: 10.11.2023 20:05:45 ******/
ALTER TABLE [dbo].[CustomerAccounts] ADD  CONSTRAINT [UC_CustomerAccounts_IBAN] UNIQUE NONCLUSTERED 
(
	[IBAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountTransactions]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransactions_CustomerAccounts] FOREIGN KEY([CustomerAccountId])
REFERENCES [dbo].[CustomerAccounts] ([Id])
GO
ALTER TABLE [dbo].[AccountTransactions] CHECK CONSTRAINT [FK_AccountTransactions_CustomerAccounts]
GO
ALTER TABLE [dbo].[AccountTransactions]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransactions_UserAccounts] FOREIGN KEY([UserAccountId])
REFERENCES [dbo].[UserAccounts] ([Id])
GO
ALTER TABLE [dbo].[AccountTransactions] CHECK CONSTRAINT [FK_AccountTransactions_UserAccounts]
GO
ALTER TABLE [dbo].[Baskets]  WITH CHECK ADD  CONSTRAINT [FK_Basket_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Baskets] CHECK CONSTRAINT [FK_Basket_Customers]
GO
ALTER TABLE [dbo].[Baskets]  WITH CHECK ADD  CONSTRAINT [FK_Basket_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Baskets] CHECK CONSTRAINT [FK_Basket_Products]
GO
ALTER TABLE [dbo].[CustomerAccounts]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAccounts_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[CustomerAccounts] CHECK CONSTRAINT [FK_CustomerAccounts_Customers]
GO
ALTER TABLE [dbo].[CustomerCards]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCards_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[CustomerCards] CHECK CONSTRAINT [FK_CustomerCards_Customers]
GO
ALTER TABLE [dbo].[CustomerCardTransactions]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCardTransactions_CustomerCards] FOREIGN KEY([CustomerCardId])
REFERENCES [dbo].[CustomerCards] ([Id])
GO
ALTER TABLE [dbo].[CustomerCardTransactions] CHECK CONSTRAINT [FK_CustomerCardTransactions_CustomerCards]
GO
ALTER TABLE [dbo].[CustomerCardTransactions]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCardTransactions_UserAccounts] FOREIGN KEY([UserAccountId])
REFERENCES [dbo].[UserAccounts] ([Id])
GO
ALTER TABLE [dbo].[CustomerCardTransactions] CHECK CONSTRAINT [FK_CustomerCardTransactions_UserAccounts]
GO
ALTER TABLE [dbo].[CustomerRelationships]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRelationships_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[CustomerRelationships] CHECK CONSTRAINT [FK_CustomerRelationships_Customers]
GO
ALTER TABLE [dbo].[CustomerRelationships]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRelationships_PriceLists] FOREIGN KEY([PriceListId])
REFERENCES [dbo].[PriceLists] ([Id])
GO
ALTER TABLE [dbo].[CustomerRelationships] CHECK CONSTRAINT [FK_CustomerRelationships_PriceLists]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Customers] FOREIGN KEY([ReceiverId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Customers]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users] FOREIGN KEY([SenderId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[PriceListDetails]  WITH CHECK ADD  CONSTRAINT [FK_PriceListDetails_PriceLists] FOREIGN KEY([PriceListId])
REFERENCES [dbo].[PriceLists] ([Id])
GO
ALTER TABLE [dbo].[PriceListDetails] CHECK CONSTRAINT [FK_PriceListDetails_PriceLists]
GO
ALTER TABLE [dbo].[PriceListDetails]  WITH CHECK ADD  CONSTRAINT [FK_PriceListDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[PriceListDetails] CHECK CONSTRAINT [FK_PriceListDetails_Products]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_Products]
GO
ALTER TABLE [dbo].[UserAccounts]  WITH CHECK ADD  CONSTRAINT [FK_UserAccounts_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserAccounts] CHECK CONSTRAINT [FK_UserAccounts_Users]
GO
ALTER TABLE [dbo].[UserOperationClaims]  WITH CHECK ADD  CONSTRAINT [FK_UserOperationClaims_OperationClaims] FOREIGN KEY([OperationClaimId])
REFERENCES [dbo].[OperationClaims] ([Id])
GO
ALTER TABLE [dbo].[UserOperationClaims] CHECK CONSTRAINT [FK_UserOperationClaims_OperationClaims]
GO
ALTER TABLE [dbo].[UserOperationClaims]  WITH CHECK ADD  CONSTRAINT [FK_UserOperationClaims_Users1] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserOperationClaims] CHECK CONSTRAINT [FK_UserOperationClaims_Users1]
GO
/****** Object:  Trigger [dbo].[trg_OrderStatusChanged]    Script Date: 10.11.2023 20:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_OrderStatusChanged]
ON [dbo].[Orders]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Sadece Sevke Hazır ve ödenmiş siparişler için stok güncelleme
    IF UPDATE(Status)
    BEGIN
        -- Güncellenmiş ve ödenmiş siparişlerle ilişkili ürünlerin stoklarını azalt
        UPDATE P
        SET P.Stock = P.Stock - SubQuery.Quantity
        FROM Products P
        INNER JOIN (
            SELECT OD.ProductId, OD.Quantity
            FROM inserted AS I
            INNER JOIN OrderDetails AS OD ON I.Id = OD.OrderId
            WHERE I.Status = 'Sevke Hazır' AND I.IsPaid = 1
        ) AS SubQuery ON P.Id = SubQuery.ProductId;

    END
END
GO
ALTER TABLE [dbo].[Orders] ENABLE TRIGGER [trg_OrderStatusChanged]
GO
USE [master]
GO
ALTER DATABASE [DealerAppDb] SET  READ_WRITE 
GO
