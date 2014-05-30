/*
   viernes, 30 de mayo de 201412:14:39
   User: 
   Server: localhost\SQLEXPRESS
   Database: loconomics
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.bookingrequest ADD
	InstantBooking bit NOT NULL CONSTRAINT DF_bookingrequest_InstantBooking DEFAULT 0
GO
ALTER TABLE dbo.bookingrequest SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.bookingrequest', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.bookingrequest', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.bookingrequest', 'Object', 'CONTROL') as Contr_Per 