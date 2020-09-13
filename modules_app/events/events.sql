-- for events manager module
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[events]') AND type in (N'U'))
BEGIN
	CREATE TABLE events(
		id int primary key identity(1,1),
		name nvarchar(50) NOT NULL,
		[desc] nvarchar(max) NULL,
		startDate datetime NULL, -- can be NULL for no-range events
		endDate datetime NULL, -- can be NULL for single day events
		eventCategoryID int NOT NULL,
		no_of_repeats int NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO events ( name, [desc], startDate, endDate, eventCategoryID ) VALUES
	( N'Demo Event 1', N'Demo', N'2019-08-01 00:00:00.000', N'2019-08-03 23:59:59.000', 1 ),
	( N'Demo Event 2', N'Demo', N'2019-08-02 00:00:00.000', NULL, 2 ),
	( N'Demo Event 3', N'Demo', N'2019-08-01 00:00:00.000', NULL, 3 ),
	( N'Demo Event 4', N'Demo', N'2019-08-03 00:00:00.000', NULL, 4 ),
	( N'Demo Event 5', N'Demo', N'2019-08-05 00:00:00.000', NULL, 5 ),
	( N'Demo Event 6', N'Demo', N'2019-08-06 00:00:00.000', NULL, 6 )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[eventTypes]') AND type in (N'U'))
BEGIN
	CREATE TABLE eventTypes(
		id int primary key identity(1,1),
		name nvarchar(50) NOT NULL,
		[desc] nvarchar(max) NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO eventTypes ( name, [desc] ) VALUES
	( N'Occasional', N'This is a type for an occasional event' ),
	( N'No range', N'This is a type for a event, which may have no date of completion' ),
	( N'Repeative', N'This is a type for a event, which may happen again & again' )
END



-- repeatType -
	-- 1 - daily
	-- 2 - weekly
	-- 3 - monthly
	-- 4 - yearly
-- repeatDelay - count to be used along with the repeat type
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[eventCategories]') AND type in (N'U'))
BEGIN
	CREATE TABLE eventCategories(
		id int primary key identity(1,1),
		name nvarchar(50) NOT NULL,
		eventTypeID int NOT NULL,
		repeatTypeID int NULL,
		repeatDelayID int NULL,
		textColor varchar(20) NOT NULL,
		backgroundColor varchar(20) NOT NULL,
		borderColor varchar(20) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO eventCategories ( name, eventTypeID, repeatTypeID, repeatDelayID, textColor, backgroundColor, borderColor ) VALUES
	( N'Events', 1, NULL, NULL, 'white', '#dc3545', '#dc3545' ),
	( N'One-Time', 2, NULL, NULL, 'white', 'purple', 'purple' ),
	( N'Repeat-Daily', 3, 1, 1, '#ffffff', '#17a2b8', '#17a2b8' ),
	( N'Repeat-Every 2 days', 3, 1, 2, '#ffffff', '#6c757d', '#6c757d' ),
	( N'Repeat-Every 3 days', 3, 1, 3, '#ffffff', '#ffc107', '#ffc107' ),
	( N'Repeat-Weekly', 3, 2, 1, '#ffffff', '#50d8af', '#50d8af' ),
	( N'Repeat-Bi-Weekly', 3, 2, 2, '#ffffff', '#50d8af', '#50d8af' ),
	( N'Repeat-Tri-Weekly', 3, 2, 3, '#ffffff', '#50d8af', '#50d8af' ),
	( N'Repeat-Monthly', 3, 3, 1, '#ffffff', '#50d8af', '#50d8af' ),
	( N'Repeat-Bi-Monthly', 3, 3, 2, '#ffffff', '#50d8af', '#50d8af' ),
	( N'Repeat-Tri-Monthly', 3, 3, 3, '#ffffff', '#50d8af', '#50d8af' ),
	( N'Repeat-Yearly', 3, 4, 1, '#ffffff', '#50d8af', '#50d8af' ),
	( N'Repeat-Bi-Yearly', 3, 4, 2, '#ffffff', '#50d8af', '#50d8af' ),
	( N'Repeat-Tri-Yearly', 3, 4, 3, '#ffffff', '#50d8af', '#50d8af' )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[eventRepeatTypes]') AND type in (N'U'))
BEGIN
	CREATE TABLE eventRepeatTypes(
		id int primary key identity(1,1),
		name nvarchar(50) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO eventRepeatTypes ( name ) VALUES ( N'Daily' ), ( N'Weekly' ), ( N'Monthly' ), ( N'Yearly' )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[eventRepeatDelays]') AND type in (N'U'))
BEGIN
	CREATE TABLE eventRepeatDelays(
		id int primary key identity(1,1),
		name int NOT NULL
	)

	INSERT INTO eventRepeatDelays ( name ) VALUES ( 1 ), ( 2 ), ( 3 ), ( 4 ), ( 5 ), ( 6 ), ( 7 ), ( 8 ), ( 9 ), ( 10 ), ( 11 ), ( 12 ), ( 13 ), ( 14 ), ( 15 ), ( 16 ), ( 17 ), ( 18 ), ( 19 ), ( 20 ), ( 21 ), ( 22 ), ( 23 ), ( 24 ), ( 25 ), ( 26 ), ( 27 ), ( 28 ), ( 29 ), ( 30 ), ( 31 )
END