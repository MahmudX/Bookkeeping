USE [master]
GO

CREATE DATABASE [BookKeepingDb];
ALTER DATABASE [BookKeepingDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookKeepingDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookKeepingDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookKeepingDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookKeepingDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookKeepingDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookKeepingDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookKeepingDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BookKeepingDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookKeepingDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookKeepingDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookKeepingDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookKeepingDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookKeepingDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookKeepingDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookKeepingDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookKeepingDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BookKeepingDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookKeepingDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookKeepingDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookKeepingDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookKeepingDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookKeepingDb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [BookKeepingDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookKeepingDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BookKeepingDb] SET  MULTI_USER 
GO
ALTER DATABASE [BookKeepingDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookKeepingDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookKeepingDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookKeepingDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookKeepingDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookKeepingDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BookKeepingDb] SET QUERY_STORE = OFF
GO
USE [BookKeepingDb]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 17/04/2023 06:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Costs]    Script Date: 17/04/2023 06:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Costs](
	[Id] [uniqueidentifier] NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_Costs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExpenseTypes]    Script Date: 17/04/2023 06:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExpenseTypes](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_ExpenseTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinancialRecordBase]    Script Date: 17/04/2023 06:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinancialRecordBase](
	[Id] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Month] [int] NOT NULL,
	[CostId] [uniqueidentifier] NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[IncomeId] [uniqueidentifier] NULL,
	[Year] [int] NULL,
	[ExpenseTypeId] [uniqueidentifier] NULL,
	[IncomeTypeId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_FinancialRecordBase] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Incomes]    Script Date: 17/04/2023 06:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Incomes](
	[Id] [uniqueidentifier] NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_Incomes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncomeTypes]    Script Date: 17/04/2023 06:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncomeTypes](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_IncomeTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230417065523_Initial', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230417081125_2111', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230417081736_217', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230417090757_307', N'7.0.5')
GO
INSERT [dbo].[Costs] ([Id], [Year]) VALUES (N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', 2022)
GO
INSERT [dbo].[Costs] ([Id], [Year]) VALUES (N'bc9752c1-79ce-4b78-8977-fb9428a05823', 2021)
GO
INSERT [dbo].[ExpenseTypes] ([Id], [Name]) VALUES (N'9f8be28f-cc59-49e8-9bfd-d319e7f725f2', N'Type 1')
GO
INSERT [dbo].[ExpenseTypes] ([Id], [Name]) VALUES (N'f541d57b-14e0-4035-8118-c0abe1c56caa', N'Type 2')
GO
INSERT [dbo].[ExpenseTypes] ([Id], [Name]) VALUES (N'a31f6c2b-368a-42f5-9461-6f8b955ba605', N'Type 3')
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'6e7bb9cf-60e0-4439-8c69-008702141c4f', CAST(0.00 AS Decimal(18, 2)), 8, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'996dab76-bda3-436e-8d91-0185dff3ec30', CAST(110.00 AS Decimal(18, 2)), 11, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'8601a7ca-c8f5-43e8-9acb-0d2f87da8f22', CAST(100.00 AS Decimal(18, 2)), 10, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'0a2abdb1-685a-45f1-b237-10c3c71b55a3', CAST(127.00 AS Decimal(18, 2)), 4, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'a23142a1-e372-4457-9010-12b1c927e6ee', CAST(12.00 AS Decimal(18, 2)), 3, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'6c187591-4a39-4762-86c2-17cd29ec74d3', CAST(90.00 AS Decimal(18, 2)), 9, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'1ab70c07-c7c4-4f19-b6f2-1d4fc60ba422', CAST(40.00 AS Decimal(18, 2)), 3, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'34f3bbf4-7858-4521-94a2-1e0484f03e23', CAST(90.00 AS Decimal(18, 2)), 9, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'4c803e07-8daa-4b0b-ab73-22af14a5dba4', CAST(60.00 AS Decimal(18, 2)), 6, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'55340614-b9d6-4bcb-8de2-2306bbac6e46', CAST(0.00 AS Decimal(18, 2)), 9, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'93fbef66-71ff-4592-9a91-2ccc11aea499', CAST(60.00 AS Decimal(18, 2)), 6, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'05223d09-7162-4e73-b4dd-31314ead1d4f', CAST(100.00 AS Decimal(18, 2)), 5, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'ab56ca2d-f44b-447e-9aae-34be00599ee7', CAST(0.00 AS Decimal(18, 2)), 10, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'47b4056f-af91-4171-99dc-35f2c04ed4ff', CAST(110.00 AS Decimal(18, 2)), 11, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'76cc898c-2d0c-4fa9-bf5f-39b632060acb', CAST(30.00 AS Decimal(18, 2)), 3, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'8d4ed97d-7ad0-41f2-a22b-516784cab403', CAST(50.00 AS Decimal(18, 2)), 4, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'0b1109bf-72ce-4e77-a819-538fda017576', CAST(220.00 AS Decimal(18, 2)), 11, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'370093ff-88bd-4760-9f24-59cdbc7f7305', CAST(120.00 AS Decimal(18, 2)), 2, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'6f9b6ad3-96ac-4d98-b903-5dc330413ed8', CAST(80.00 AS Decimal(18, 2)), 4, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'8bba04ca-3baa-48b3-99a5-68bf1d785b8c', CAST(1128.00 AS Decimal(18, 2)), 7, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'518f2946-7a12-406f-9adb-6dfb4464c6a8', CAST(80.00 AS Decimal(18, 2)), 8, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'1a33eb1d-0d25-46d4-b766-7a826a227b18', CAST(140.00 AS Decimal(18, 2)), 7, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'39894c68-0b9c-4870-9405-817e5a1c5843', CAST(60.00 AS Decimal(18, 2)), 3, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'c6ec50f1-68bb-43cc-8e1b-86d2f8031123', CAST(0.00 AS Decimal(18, 2)), 0, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'b34ae76b-d514-4880-84d1-8ea9f12e2c9c', CAST(10.00 AS Decimal(18, 2)), 1, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'd75f9a20-4c4f-4b2a-ae3f-8feb18bbaacd', CAST(128.00 AS Decimal(18, 2)), 5, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'98007acd-30fc-4f15-9acf-95982b7b964a', CAST(70.00 AS Decimal(18, 2)), 7, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'b491ba65-6901-4107-b54f-96ff2d94310e', CAST(120.00 AS Decimal(18, 2)), 6, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'8fab0de6-e180-4f0a-a1e6-9cc21475c82e', CAST(100.00 AS Decimal(18, 2)), 0, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'43081efb-4d2b-49d9-9f8c-9f529c2359e3', CAST(100.00 AS Decimal(18, 2)), 10, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'26f59612-cfd4-4622-8b0b-9f5fe276a3a9', CAST(180.00 AS Decimal(18, 2)), 9, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'e1c52dbc-ab00-47c5-b614-9f714e804103', CAST(50.00 AS Decimal(18, 2)), 5, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'fc0ac2af-3232-4534-8285-a651be3adab2', CAST(30.00 AS Decimal(18, 2)), 2, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'a627bbea-c120-49b0-ac3d-a6e4da763682', CAST(70.00 AS Decimal(18, 2)), 7, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'2d464320-40e3-47d5-bb74-a8d87e6ed354', CAST(20.00 AS Decimal(18, 2)), 2, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'1246aba7-7b81-4463-9a02-af80ca68d3a8', CAST(1128.00 AS Decimal(18, 2)), 6, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'92743865-45c8-4a60-9dae-b6507b043a29', CAST(40.00 AS Decimal(18, 2)), 2, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'0d7e163a-d9c7-4ee8-ab44-bbfcdbdf2464', CAST(110.00 AS Decimal(18, 2)), 1, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'48c6fc60-1a44-4758-95f3-c72beb262445', CAST(160.00 AS Decimal(18, 2)), 8, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'0254ff51-6e2f-4553-af42-d114625da59f', CAST(50.00 AS Decimal(18, 2)), 5, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'cb6849d8-ecd7-4140-a05f-ddaea386a947', CAST(0.00 AS Decimal(18, 2)), 0, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'c3a04a7e-bebb-4089-baf7-e39939c130bf', CAST(20.00 AS Decimal(18, 2)), 1, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'55ebf816-6094-4257-8e85-eb17f053ff84', CAST(1000.00 AS Decimal(18, 2)), 0, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'64b56aad-5d39-43e8-b0d2-f09fb9bee997', CAST(10.00 AS Decimal(18, 2)), 11, NULL, N'FinancialRecord', N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'9af5e745-d909-43ec-8eb9-f44a99b48dc2', CAST(80.00 AS Decimal(18, 2)), 8, NULL, N'FinancialRecord', N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'823a0e32-fcf2-4b90-8c00-f6a859f735f9', CAST(40.00 AS Decimal(18, 2)), 4, N'4ada5bc2-b8e2-4b56-8204-e7df8c78d48b', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'f11a5a7e-d70f-427f-8840-fa913e7ac61d', CAST(200.00 AS Decimal(18, 2)), 10, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[FinancialRecordBase] ([Id], [Amount], [Month], [CostId], [Discriminator], [IncomeId], [Year], [ExpenseTypeId], [IncomeTypeId]) VALUES (N'dfa43c53-1529-434e-ab47-fd813cf51d3e', CAST(20.00 AS Decimal(18, 2)), 1, N'bc9752c1-79ce-4b78-8977-fb9428a05823', N'FinancialRecord', NULL, 0, NULL, NULL)
GO
INSERT [dbo].[Incomes] ([Id], [Year]) VALUES (N'fcf48025-8a4b-4d44-ae80-3257ec1d51c3', 2021)
GO
INSERT [dbo].[Incomes] ([Id], [Year]) VALUES (N'07426de5-9b6e-4183-874b-bfc5b602e0c0', 2022)
GO
INSERT [dbo].[IncomeTypes] ([Id], [Name]) VALUES (N'43a4875b-6f7a-496f-8959-eec139d155fd', N'TA/DA')
GO
INSERT [dbo].[IncomeTypes] ([Id], [Name]) VALUES (N'42058199-646f-49ca-ab82-7b0b96db7e65', N'Type 1')
GO
INSERT [dbo].[IncomeTypes] ([Id], [Name]) VALUES (N'f88cdac3-183a-4556-a787-27d37f0110cb', N'Type 2')
GO
INSERT [dbo].[IncomeTypes] ([Id], [Name]) VALUES (N'cecd024a-00df-472a-b45e-e0e2359b9db1', N'Type 3')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ExpenseTypes_Name]    Script Date: 17/04/2023 06:54:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ExpenseTypes_Name] ON [dbo].[ExpenseTypes]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FinancialRecordBase_CostId]    Script Date: 17/04/2023 06:54:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinancialRecordBase_CostId] ON [dbo].[FinancialRecordBase]
(
	[CostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FinancialRecordBase_ExpenseTypeId]    Script Date: 17/04/2023 06:54:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinancialRecordBase_ExpenseTypeId] ON [dbo].[FinancialRecordBase]
(
	[ExpenseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FinancialRecordBase_IncomeId]    Script Date: 17/04/2023 06:54:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinancialRecordBase_IncomeId] ON [dbo].[FinancialRecordBase]
(
	[IncomeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FinancialRecordBase_IncomeTypeId]    Script Date: 17/04/2023 06:54:05 ******/
CREATE NONCLUSTERED INDEX [IX_FinancialRecordBase_IncomeTypeId] ON [dbo].[FinancialRecordBase]
(
	[IncomeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_IncomeTypes_Name]    Script Date: 17/04/2023 06:54:05 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IncomeTypes_Name] ON [dbo].[IncomeTypes]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FinancialRecordBase]  WITH CHECK ADD  CONSTRAINT [FK_FinancialRecordBase_Costs_CostId] FOREIGN KEY([CostId])
REFERENCES [dbo].[Costs] ([Id])
GO
ALTER TABLE [dbo].[FinancialRecordBase] CHECK CONSTRAINT [FK_FinancialRecordBase_Costs_CostId]
GO
ALTER TABLE [dbo].[FinancialRecordBase]  WITH CHECK ADD  CONSTRAINT [FK_FinancialRecordBase_ExpenseTypes_ExpenseTypeId] FOREIGN KEY([ExpenseTypeId])
REFERENCES [dbo].[ExpenseTypes] ([Id])
GO
ALTER TABLE [dbo].[FinancialRecordBase] CHECK CONSTRAINT [FK_FinancialRecordBase_ExpenseTypes_ExpenseTypeId]
GO
ALTER TABLE [dbo].[FinancialRecordBase]  WITH CHECK ADD  CONSTRAINT [FK_FinancialRecordBase_Incomes_IncomeId] FOREIGN KEY([IncomeId])
REFERENCES [dbo].[Incomes] ([Id])
GO
ALTER TABLE [dbo].[FinancialRecordBase] CHECK CONSTRAINT [FK_FinancialRecordBase_Incomes_IncomeId]
GO
ALTER TABLE [dbo].[FinancialRecordBase]  WITH CHECK ADD  CONSTRAINT [FK_FinancialRecordBase_IncomeTypes_IncomeTypeId] FOREIGN KEY([IncomeTypeId])
REFERENCES [dbo].[IncomeTypes] ([Id])
GO
ALTER TABLE [dbo].[FinancialRecordBase] CHECK CONSTRAINT [FK_FinancialRecordBase_IncomeTypes_IncomeTypeId]
GO
USE [master]
GO
ALTER DATABASE [BookKeepingDb] SET  READ_WRITE 
GO
