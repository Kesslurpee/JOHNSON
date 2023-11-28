USE [C__USERS_RONKE_DOCUMENTS_POSALE]
GO
/****** Object:  Trigger [dbo].[ComputeTotal]    Script Date: 16/11/2023 7:59:30 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[ComputeTotal]
   ON  [dbo].[tbCart]
   AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE tbCart SET discount = ((price*qty) * discount_percentage * 0.01)
	UPDATE tbCart SET total = (price*qty)-discount 

    -- Insert statements for trigger here

END