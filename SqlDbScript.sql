USE [ComapnyStockDb]
GO
/****** Object:  Table [dbo].[tbl_CompanyStock]    Script Date: 4/5/2019 7:08:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_CompanyStock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](max) NOT NULL,
	[CompanyCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_CompanyStock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_UserWatchList]    Script Date: 4/5/2019 7:08:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UserWatchList](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[CompanyCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_UserWatchList] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tbl_CompanyStock] ON 

INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (1, N'Agilent Technologies', N'A')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (2, N'ACCENTURE PLC', N'ACN')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (3, N'Aac Holdings Inc ', N'AAC')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (4, N'CGI INC.', N'GIB')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (5, N'PERFICIENT INC. ', N'PRFT')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (6, N'Advanced Micro Devices, Inc.', N'AMD')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (7, N'Fortinet, Inc.', N'FTNT')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (8, N'Red Hat, Inc.', N'RHT')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (9, N'Keysight Technologies Inc.', N'KEYS')
INSERT [dbo].[tbl_CompanyStock] ([Id], [CompanyName], [CompanyCode]) VALUES (10, N' Motorola Solutions, Inc.', N'MSI')
SET IDENTITY_INSERT [dbo].[tbl_CompanyStock] OFF
SET IDENTITY_INSERT [dbo].[tbl_UserWatchList] ON 

INSERT [dbo].[tbl_UserWatchList] ([Id], [CompanyId], [CompanyCode]) VALUES (10012, 1, N'A')
INSERT [dbo].[tbl_UserWatchList] ([Id], [CompanyId], [CompanyCode]) VALUES (10013, 2, N'AA')
INSERT [dbo].[tbl_UserWatchList] ([Id], [CompanyId], [CompanyCode]) VALUES (10014, 10, N'MSI')
INSERT [dbo].[tbl_UserWatchList] ([Id], [CompanyId], [CompanyCode]) VALUES (10015, 4, N'GIB')
SET IDENTITY_INSERT [dbo].[tbl_UserWatchList] OFF
/****** Object:  StoredProcedure [dbo].[Usp_AddEditCompany]    Script Date: 4/5/2019 7:08:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Usp_AddEditCompany] -- Usp_AddEditCompany 'Delete',@CompanyCode='A'
(
@Action Nvarchar(50)='',
@CompanyId int=0,
@CompanyCode Nvarchar(50)=''
)

as
BEGIN


 IF(@Action='Add')
 BEGIN
  IF Not Exists(select Id from tbl_UserWatchList where CompanyId=@CompanyId)
  BEGIN
  Select @CompanyCode=CompanyCode from tbl_CompanyStock where Id=@CompanyId
     Insert  into tbl_UserWatchList (CompanyId,CompanyCode)Values(@CompanyId,@CompanyCode)
	
  END
  
 END
 IF(@Action='Delete')
 BEGIN
Select @CompanyId=Id from tbl_CompanyStock where CompanyCode=@CompanyCode
   Delete from tbl_UserWatchList where CompanyId=@CompanyId
 END
  Select tbl_CompanyStock.CompanyName,tbl_CompanyStock.CompanyCode,tbl_CompanyStock.Id from tbl_UserWatchList inner join tbl_CompanyStock   on tbl_CompanyStock.Id=tbl_UserWatchList.CompanyId
END


GO
