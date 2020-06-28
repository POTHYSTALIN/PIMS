IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[inventoryItems]') AND type in (N'U'))
BEGIN
	CREATE TABLE inventoryItems (
		id int primary key identity(1,1),
		name varchar(50) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO inventoryItems ( name ) VALUES ( 'Motherboard' ), ( 'Processor' ), ( 'HDD' ), ( 'RAM' ), ( 'Cabinet' ), ( 'OS' )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[inventoryItemProperties]') AND type in (N'U'))
BEGIN
	CREATE TABLE inventoryItemProperties (
		id int primary key identity(1,1),
		name varchar(50) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO inventoryItemProperties ( name ) VALUES ( 'Brand' ), ( 'Model' ), ( 'CD name' ), ( 'Generation' ), ( 'Frequency' ), ( 'Size' )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[inventoryItemPropertyDetails]') AND type in (N'U'))
BEGIN
	CREATE TABLE inventoryItemPropertyDetails (
		id int primary key identity(1,1),
		inventoryItemId int NOT NULL,
		inventoryItemPropertyId int NOT NULL,
		inventoryItemPropertyValue varchar(100),
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[systemDetails]') AND type in (N'U'))
BEGIN
	CREATE TABLE systemDetails (
		id int primary key identity(1,1),
		name varchar(50) NOT NULL,
		label varchar(50) NOT NULL,
		cabinet varchar(50) NOT NULL,
		motherboard varchar(50) NOT NULL,
		processor varchar(50) NOT NULL,
		ram varchar(50) NOT NULL,
		HDD varchar(50) NOT NULL,
		OS varchar(50) NOT NULL,
		installationType varchar(50) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[inventoryItemDetails]') AND type in (N'U'))
BEGIN
	CREATE TABLE inventoryItemDetails (
		id int primary key identity(1,1),
		inventoryItemID int NOT NULL,
		brandID int,
		modelID int,
		cdID int,
		generationID int,
		frequencyID int,
		sizeID int,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

-- ====================================================
-- Below items needs to be verified
-- ====================================================

IF NOT EXISTS(SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[systemProblems]') AND type in (N'U'))
BEGIN
	CREATE TABLE systemProblems
	(
		id int primary key identity(1,1),
		sysID int NOT NULL,
		problemDate dateTime NOT NULL,
		description nvarchar(max) NOT NULL,
		solutionProposed nvarchar(max) NOT NULL,
		otherDetails nvarchar(max) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[taskRepeatDelays]') AND type in (N'U'))
BEGIN
	CREATE TABLE taskRepeatDelays(
		id int primary key identity(1,1),
		name int NOT NULL
	)

	INSERT INTO taskRepeatDelays ( name ) VALUES ( 1 ), ( 2 ), ( 3 ), ( 4 ), ( 5 ), ( 6 ), ( 7 ), ( 8 ), ( 9 ), ( 10 )
END