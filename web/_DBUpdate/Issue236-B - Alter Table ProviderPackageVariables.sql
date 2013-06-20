/*
   jueves, 20 de junio de 201314:42:08
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
CREATE TABLE dbo.Tmp_ProviderPackageVariables
	(
	UserID int NOT NULL,
	PackageID int NOT NULL,
	PricingEstimateID int NOT NULL,
	PricingEstimateRevision int NOT NULL,
	CleaningRate decimal(7, 2) NULL,
	BedsNumber int NULL,
	BathsNumber int NULL,
	HoursNumber decimal(5, 2) NULL,
	ChildsNumber int NULL,
	ChildSurcharge decimal(7, 2) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_ProviderPackageVariables SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_ProviderPackageVariables ADD CONSTRAINT
	DF_ProviderPackageVariables_PricingEstimateRevision DEFAULT 0 FOR PricingEstimateRevision
GO
IF EXISTS(SELECT * FROM dbo.ProviderPackageVariables)
	 EXEC('INSERT INTO dbo.Tmp_ProviderPackageVariables (UserID, PackageID, PricingEstimateID, CleaningRate, BedsNumber, BathsNumber, HoursNumber, ChildsNumber, ChildSurcharge)
		SELECT UserID, PackageID, BookingID, CleaningRate, BedsNumber, BathsNumber, HoursNumber, ChildsNumber, ChildSurcharge FROM dbo.ProviderPackageVariables WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.ProviderPackageVariables
GO
EXECUTE sp_rename N'dbo.Tmp_ProviderPackageVariables', N'ProviderPackageVariables', 'OBJECT' 
GO
ALTER TABLE dbo.ProviderPackageVariables ADD CONSTRAINT
	PK_ProviderPackageVariables PRIMARY KEY CLUSTERED 
	(
	UserID,
	PackageID,
	PricingEstimateID,
	PricingEstimateRevision
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.ProviderPackageVariables', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.ProviderPackageVariables', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.ProviderPackageVariables', 'Object', 'CONTROL') as Contr_Per 