/*
   miércoles, 24 de septiembre de 201414:57:46
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
ALTER TABLE dbo.servicecategorypositionattribute ADD
	EnteredByUserID int NULL,
	Approved bit NULL
GO
ALTER TABLE dbo.servicecategorypositionattribute SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.servicecategorypositionattribute', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.servicecategorypositionattribute', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.servicecategorypositionattribute', 'Object', 'CONTROL') as Contr_Per 