/*
   domingo, 12 de abril de 201510:56:31
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
ALTER TABLE dbo.ReferralSource SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.ReferralSource', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.ReferralSource', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.ReferralSource', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
CREATE TABLE dbo.ProviderCustomer
	(
	ProviderUserID int NOT NULL,
	CustomerUserID int NOT NULL,
	NotesAboutCustomer ntext NOT NULL,
	ReferralSourceID int NOT NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.ProviderCustomer ADD CONSTRAINT
	DF_ProviderCustomer_NotesAboutCustomer DEFAULT '' FOR NotesAboutCustomer
GO
ALTER TABLE dbo.ProviderCustomer ADD CONSTRAINT
	PK_ProviderCustomer PRIMARY KEY CLUSTERED 
	(
	ProviderUserID,
	CustomerUserID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.ProviderCustomer ADD CONSTRAINT
	FK_ProviderCustomer_ReferralSource FOREIGN KEY
	(
	ReferralSourceID
	) REFERENCES dbo.ReferralSource
	(
	ReferralSourceID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.ProviderCustomer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.ProviderCustomer', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.ProviderCustomer', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.ProviderCustomer', 'Object', 'CONTROL') as Contr_Per 