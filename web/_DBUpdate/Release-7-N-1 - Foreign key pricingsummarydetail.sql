/*
   martes, 22 de septiembre de 201517:55:52
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
ALTER TABLE dbo.pricingSummary SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.pricingSummaryDetail ADD CONSTRAINT
	FK_pricingSummaryDetail_pricingSummary FOREIGN KEY
	(
	PricingSummaryID,
	PricingSummaryRevision
	) REFERENCES dbo.pricingSummary
	(
	PricingSummaryID,
	PricingSummaryRevision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
