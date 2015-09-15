/*
   martes, 15 de septiembre de 201518:04:16
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
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__pricingSummary
GO
ALTER TABLE dbo.pricingSummary SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.pricingSummary', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__serviceDate
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__alternativeDate1
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__alternativeDate2
GO
ALTER TABLE dbo.CalendarEvents SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.CalendarEvents', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.CalendarEvents', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.CalendarEvents', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__serviceAddress
GO
ALTER TABLE dbo.address SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.address', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.address', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.address', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__cancellationPolicy
GO
ALTER TABLE dbo.cancellationpolicy SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.cancellationpolicy', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.cancellationpolicy', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.cancellationpolicy', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__type
GO
ALTER TABLE dbo.bookingType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.bookingType', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.bookingType', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.bookingType', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__status
GO
ALTER TABLE dbo.bookingStatus SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.bookingStatus', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.bookingStatus', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.bookingStatus', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__jobtitle
GO
ALTER TABLE dbo.positions SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.positions', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.positions', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.positions', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__client
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__serviceProfessional
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__AwaitingResponseFromUserID
GO
ALTER TABLE dbo.users SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
select Has_Perms_By_Name(N'dbo.users', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.users', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.users', 'Object', 'CONTROL') as Contr_Per BEGIN TRANSACTION
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_InstantBooking
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_SendReminder
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_SendPromotional
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_Recurrent
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_MultiSession
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint__booking__PricingAdjustmentApplied
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_PaymentCollected
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_PaymentAuthorized
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_PricingAdjustmentRequested
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT Contraint_booking_MessagingLog
GO
CREATE TABLE dbo.Tmp_booking
	(
	BookingID int NOT NULL IDENTITY (1, 1),
	ClientUserID int NULL,
	ServiceProfessionalUserID int NULL,
	JobTitleID int NOT NULL,
	LanguageID int NOT NULL,
	CountryID int NOT NULL,
	BookingStatusID int NOT NULL,
	BookingTypeID int NOT NULL,
	CancellationPolicyID int NOT NULL,
	ParentBookingID int NULL,
	ServiceAddressID int NULL,
	ServiceDateID int NULL,
	AlternativeDate1ID int NULL,
	AlternativeDate2ID int NULL,
	PricingSummaryID int NOT NULL,
	PricingSummaryRevision int NOT NULL,
	PaymentTransactionID varchar(250) NULL,
	PaymentLastFourCardNumberDigits varchar(64) NULL,
	TotalPricePaidByClient decimal(25, 2) NULL,
	TotalServiceFeesPaidByClient decimal(25, 2) NULL,
	TotalPaidToServiceProfessional decimal(25, 2) NULL,
	TotalServiceFeesPaidByServiceProfessional decimal(25, 2) NULL,
	InstantBooking bit NOT NULL,
	FirstTimeBooking bit NOT NULL,
	SendReminder bit NOT NULL,
	SendPromotional bit NOT NULL,
	Recurrent bit NOT NULL,
	MultiSession bit NOT NULL,
	PricingAdjustmentApplied bit NOT NULL,
	PaymentEnabled bit NOT NULL,
	PaymentCollected bit NOT NULL,
	PaymentAuthorized bit NOT NULL,
	AwaitingResponseFromUserID int NULL,
	PricingAdjustmentRequested bit NOT NULL,
	SupportTicketNumber varchar(200) NULL,
	MessagingLog nvarchar(400) NOT NULL,
	CreatedDate datetime NOT NULL,
	UpdatedDate datetime NOT NULL,
	ModifiedBy varchar(25) NOT NULL,
	SpecialRequests text NULL,
	PreNotesToClient text NULL,
	PostNotesToClient text NULL,
	PreNotesToSelf text NULL,
	PostNotesToSelf text NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_booking SET (LOCK_ESCALATION = TABLE)
GO
DECLARE @v sql_variant 
SET @v = N'The languageID related to the jobTitleID, and the one used on the API call by the creator of the booking'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_booking', N'COLUMN', N'LanguageID'
GO
DECLARE @v sql_variant 
SET @v = N'The countryID related to the jobTitleID, and the one used on the API call by the creator of the booking'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_booking', N'COLUMN', N'CountryID'
GO
DECLARE @v sql_variant 
SET @v = N'It''s an initial setup flag, set on creation and no updated later. It lets know that payment processing is enabled on this booking, and later payment MUST be collected and performed. Payment must be enabled on the service professional account and optionally enable/disable for bookNow bookings depending on jobTitle and user setup'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_booking', N'COLUMN', N'PaymentEnabled'
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_InstantBooking DEFAULT ((0)) FOR InstantBooking
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_SendReminder DEFAULT ((0)) FOR SendReminder
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_SendPromotional DEFAULT ((0)) FOR SendPromotional
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_Recurrent DEFAULT ((0)) FOR Recurrent
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_MultiSession DEFAULT ((0)) FOR MultiSession
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint__booking__PricingAdjustmentApplied DEFAULT ((0)) FOR PricingAdjustmentApplied
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	DF_booking_PaymentEnabled DEFAULT 0 FOR PaymentEnabled
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_PaymentCollected DEFAULT ((0)) FOR PaymentCollected
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_PaymentAuthorized DEFAULT ((0)) FOR PaymentAuthorized
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_PricingAdjustmentRequested DEFAULT ((0)) FOR PricingAdjustmentRequested
GO
ALTER TABLE dbo.Tmp_booking ADD CONSTRAINT
	Contraint_booking_MessagingLog DEFAULT ('') FOR MessagingLog
GO
SET IDENTITY_INSERT dbo.Tmp_booking ON
GO
IF EXISTS(SELECT * FROM dbo.booking)
	 EXEC('INSERT INTO dbo.Tmp_booking (BookingID, ClientUserID, ServiceProfessionalUserID, JobTitleID, LanguageID, CountryID, BookingStatusID, BookingTypeID, CancellationPolicyID, ParentBookingID, ServiceAddressID, ServiceDateID, AlternativeDate1ID, AlternativeDate2ID, PricingSummaryID, PricingSummaryRevision, PaymentTransactionID, PaymentLastFourCardNumberDigits, TotalPricePaidByClient, TotalServiceFeesPaidByClient, TotalPaidToServiceProfessional, TotalServiceFeesPaidByServiceProfessional, InstantBooking, FirstTimeBooking, SendReminder, SendPromotional, Recurrent, MultiSession, PricingAdjustmentApplied, PaymentCollected, PaymentAuthorized, AwaitingResponseFromUserID, PricingAdjustmentRequested, SupportTicketNumber, MessagingLog, CreatedDate, UpdatedDate, ModifiedBy, SpecialRequests, PreNotesToClient, PostNotesToClient, PreNotesToSelf, PostNotesToSelf)
		SELECT BookingID, ClientUserID, ServiceProfessionalUserID, JobTitleID, LanguageID, CountryID, BookingStatusID, BookingTypeID, CancellationPolicyID, ParentBookingID, ServiceAddressID, ServiceDateID, AlternativeDate1ID, AlternativeDate2ID, PricingSummaryID, PricingSummaryRevision, PaymentTransactionID, PaymentLastFourCardNumberDigits, TotalPricePaidByClient, TotalServiceFeesPaidByClient, TotalPaidToServiceProfessional, TotalServiceFeesPaidByServiceProfessional, InstantBooking, FirstTimeBooking, SendReminder, SendPromotional, Recurrent, MultiSession, PricingAdjustmentApplied, PaymentCollected, PaymentAuthorized, AwaitingResponseFromUserID, PricingAdjustmentRequested, SupportTicketNumber, MessagingLog, CreatedDate, UpdatedDate, ModifiedBy, SpecialRequests, PreNotesToClient, PostNotesToClient, PreNotesToSelf, PostNotesToSelf FROM dbo.booking WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_booking OFF
GO
ALTER TABLE dbo.booking
	DROP CONSTRAINT FK__booking__parentbooking
GO
DROP TABLE dbo.booking
GO
EXECUTE sp_rename N'dbo.Tmp_booking', N'booking', 'OBJECT' 
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	PK__booking__bookingIDKey PRIMARY KEY CLUSTERED 
	(
	BookingID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__parentbooking FOREIGN KEY
	(
	ParentBookingID
	) REFERENCES dbo.booking
	(
	BookingID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__client FOREIGN KEY
	(
	ClientUserID
	) REFERENCES dbo.users
	(
	UserID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__serviceProfessional FOREIGN KEY
	(
	ServiceProfessionalUserID
	) REFERENCES dbo.users
	(
	UserID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__jobtitle FOREIGN KEY
	(
	JobTitleID,
	LanguageID,
	CountryID
	) REFERENCES dbo.positions
	(
	PositionID,
	LanguageID,
	CountryID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__status FOREIGN KEY
	(
	BookingStatusID
	) REFERENCES dbo.bookingStatus
	(
	BookingStatusID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__type FOREIGN KEY
	(
	BookingTypeID
	) REFERENCES dbo.bookingType
	(
	BookingTypeID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__cancellationPolicy FOREIGN KEY
	(
	CancellationPolicyID,
	LanguageID,
	CountryID
	) REFERENCES dbo.cancellationpolicy
	(
	CancellationPolicyID,
	LanguageID,
	CountryID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__serviceAddress FOREIGN KEY
	(
	ServiceAddressID
	) REFERENCES dbo.address
	(
	AddressID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__serviceDate FOREIGN KEY
	(
	ServiceDateID
	) REFERENCES dbo.CalendarEvents
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__alternativeDate1 FOREIGN KEY
	(
	AlternativeDate1ID
	) REFERENCES dbo.CalendarEvents
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__alternativeDate2 FOREIGN KEY
	(
	AlternativeDate2ID
	) REFERENCES dbo.CalendarEvents
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__AwaitingResponseFromUserID FOREIGN KEY
	(
	AwaitingResponseFromUserID
	) REFERENCES dbo.users
	(
	UserID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.booking ADD CONSTRAINT
	FK__booking__pricingSummary FOREIGN KEY
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
select Has_Perms_By_Name(N'dbo.booking', 'Object', 'ALTER') as ALT_Per, Has_Perms_By_Name(N'dbo.booking', 'Object', 'VIEW DEFINITION') as View_def_Per, Has_Perms_By_Name(N'dbo.booking', 'Object', 'CONTROL') as Contr_Per 