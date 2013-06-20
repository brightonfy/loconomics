/*
   jueves, 20 de junio de 201315:45:36
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
CREATE TABLE dbo.Tmp_pricingestimatedetail
	(
	PricingEstimateID int NOT NULL,
	PricingEstimateRevision int NOT NULL,
	PricingVariableID int NOT NULL,
	PricingSurchargeID int NOT NULL,
	PricingOptionID int NOT NULL,
	ServiceAttributeID int NOT NULL,
	ProviderPackageID int NOT NULL,
	ProviderPricingDataInput varchar(100) NULL,
	CustomerPricingDataInput varchar(500) NULL,
	SystemPricingDataInput decimal(7, 2) NULL,
	HourlyPrice decimal(5, 2) NULL,
	SubtotalPrice decimal(7, 2) NULL,
	FeePrice decimal(7, 2) NULL,
	TotalPrice decimal(7, 2) NULL,
	ServiceDuration decimal(7, 2) NULL,
	FirstSessionDuration decimal(7, 2) NULL,
	CreatedDate datetime NOT NULL,
	UpdatedDate datetime NOT NULL,
	ModifiedBy varchar(25) NOT NULL,
	PricingGroupID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_pricingestimatedetail SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.pricingestimatedetail)
	 EXEC('INSERT INTO dbo.Tmp_pricingestimatedetail (PricingEstimateID, PricingEstimateRevision, PricingVariableID, PricingSurchargeID, PricingOptionID, ServiceAttributeID, ProviderPackageID, ProviderPricingDataInput, CustomerPricingDataInput, SystemPricingDataInput, HourlyPrice, SubtotalPrice, FeePrice, TotalPrice, ServiceDuration, FirstSessionDuration, CreatedDate, UpdatedDate, ModifiedBy, PricingGroupID)
		SELECT PricingEstimateID, PricingEstimateRevision, PricingVariableID, PricingSurchargeID, PricingOptionID, ServiceAttributeID, ProviderPackageID, ProviderPricingDataInput, CustomerPricingDataInput, SystemPricingDataInput, HourlyPrice, SubtotalPrice, FeePrice, TotalPrice, ServiceDuration, FirstSessionDuration, CreatedDate, UpdatedDate, ModifiedBy, PricingGroupID FROM dbo.pricingestimatedetail WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.pricingestimatedetail
GO
EXECUTE sp_rename N'dbo.Tmp_pricingestimatedetail', N'pricingestimatedetail', 'OBJECT' 
GO
ALTER TABLE dbo.pricingestimatedetail ADD CONSTRAINT
	PK_pricingestimatedetail PRIMARY KEY CLUSTERED 
	(
	PricingEstimateID,
	PricingEstimateRevision,
	PricingVariableID,
	PricingSurchargeID,
	PricingOptionID,
	ServiceAttributeID,
	ProviderPackageID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
select Has_Perms_By_Name(N'dbo.pricingestimatedetail', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.pricingestimatedetail', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.pricingestimatedetail', 'Object', 'CONTROL') as Contr_Per 