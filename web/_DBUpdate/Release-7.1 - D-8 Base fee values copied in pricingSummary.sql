/*
   miércoles, 10 de febrero de 201615:50:48
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
ALTER TABLE dbo.pricingSummary ADD
	FirstTimeServiceFeeFixed decimal(5, 2) NOT NULL CONSTRAINT DF_pricingSummary_FirstTimeServiceFeeFixed DEFAULT ((0)),
	FirstTimeServiceFeePercentage decimal(5, 2) NOT NULL CONSTRAINT DF_pricingSummary_FirstTimeServiceFeePercentage DEFAULT ((0)),
	PaymentProcessingFeePercentage decimal(5, 2) NOT NULL CONSTRAINT DF_pricingSummary_PaymentProcessingFeePercentage DEFAULT ((0)),
	PaymentProcessingFeeFixed decimal(5, 2) NOT NULL CONSTRAINT DF_pricingSummary_PaymentProcessingFeeFixed DEFAULT ((0)),
	FirstTimeServiceFeeMaximum decimal(5, 2) NOT NULL CONSTRAINT DF_pricingSummary_FirstTimeServiceFeeMaximum DEFAULT ((0)),
	FirstTimeServiceFeeMinimum decimal(5, 2) NOT NULL CONSTRAINT DF_pricingSummary_FirstTimeServiceFeeMinimum DEFAULT ((0))
GO
ALTER TABLE dbo.pricingSummary SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'CONTROL') as Contr_Per 