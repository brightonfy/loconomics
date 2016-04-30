/*
   martes, 12 de enero de 201613:28:46
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
CREATE TABLE dbo.Tmp_OwnerStatusHistory
	(
	UserID int NOT NULL,
	OwnerStatusChangedDate datetime NOT NULL,
	OwnerStatusID int NOT NULL,
	OwnerStatusChangedBy varchar(3) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_OwnerStatusHistory SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.OwnerStatusHistory)
	 EXEC('INSERT INTO dbo.Tmp_OwnerStatusHistory (UserID, OwnerStatusChangedDate, OwnerStatusID, OwnerStatusChangedBy)
		SELECT UserID, CONVERT(datetime, OwnerStatusChangedDate), OwnerStatusID, OwnerStatusChangedBy FROM dbo.OwnerStatusHistory WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.OwnerStatusHistory
GO
EXECUTE sp_rename N'dbo.Tmp_OwnerStatusHistory', N'OwnerStatusHistory', 'OBJECT' 
GO
ALTER TABLE dbo.OwnerStatusHistory ADD CONSTRAINT
	PK__OwnerSta__1788CCAC7F76C749 PRIMARY KEY CLUSTERED 
	(
	UserID,
	OwnerStatusChangedDate
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.OwnerStatusHistory', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.OwnerStatusHistory', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.OwnerStatusHistory', 'Object', 'CONTROL') as Contr_Per 