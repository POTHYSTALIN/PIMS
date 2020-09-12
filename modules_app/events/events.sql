-- for events manager module
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[events]') AND type in (N'U'))
BEGIN
	CREATE TABLE events(
		id int primary key identity(1,1),
		name nvarchar(50) NULL,
		[desc] nvarchar(max) NULL,
		sdate datetime NOT NULL,
		edate datetime NULL
	)
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tasks]') AND type in (N'U'))
BEGIN
	CREATE TABLE tasks(
		id int primary key identity(1,1),
		name nvarchar(50) NOT NULL,
		[desc] nvarchar(max) NULL,
		taskCategoryID int NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[taskTypes]') AND type in (N'U'))
BEGIN
	CREATE TABLE taskTypes(
		id int primary key identity(1,1),
		name nvarchar(50) NOT NULL,
		[desc] nvarchar(max) NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO taskTypes ( name, [desc] ) VALUES
	( N'Occasional', N'This is a type for an occasional task' ),
	( N'No range', N'This is a type for a task, which may have no date of completion' ),
	( N'Repeative', N'This is a type for a task, which may happen again & again' )
END



-- repeatType -
	-- 1 - daily
	-- 2 - weekly
	-- 3 - monthly
	-- 4 - yearly
-- repeatDelay - count to be used along with the repeat type
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[taskCategories]') AND type in (N'U'))
BEGIN
	CREATE TABLE taskCategories(
		id int primary key identity(1,1),
		name nvarchar(50) NOT NULL,
		taskTypeID int NOT NULL,
		repeatTypeID int NULL,
		repeatDelayID int NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO taskCategories ( name, taskTypeID, repeatTypeID, repeatDelayID ) VALUES
	( N'Events', 1, NULL, NULL ),
	( N'One-Time', 2, NULL, NULL ),
	( N'Repeat-Daily', 3, 1, 1 ),
	( N'Repeat-Every 2 days', 3, 1, 2 ),
	( N'Repeat-Every 3 days', 3, 1, 3 ),
	( N'Repeat-Weekly', 3, 2, 1 ),
	( N'Repeat-Bi-Weekly', 3, 2, 2 ),
	( N'Repeat-Tri-Weekly', 3, 2, 3 ),
	( N'Repeat-Monthly', 3, 3, 1 ),
	( N'Repeat-Bi-Monthly', 3, 3, 2 ),
	( N'Repeat-Tri-Monthly', 3, 3, 3 ),
	( N'Repeat-Yearly', 3, 4, 1 )
	( N'Repeat-Bi-Yearly', 3, 4, 2 )
	( N'Repeat-Tri-Yearly', 3, 4, 3 )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[taskRepeatTypes]') AND type in (N'U'))
BEGIN
	CREATE TABLE taskRepeatTypes(
		id int primary key identity(1,1),
		name nvarchar(50) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO taskRepeatTypes ( name ) VALUES ( N'Daily' ), ( N'Weekly' ), ( N'Monthly' ), ( N'Yearly' )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[taskRepeatDelays]') AND type in (N'U'))
BEGIN
	CREATE TABLE taskRepeatDelays(
		id int primary key identity(1,1),
		name int NOT NULL
	)

	INSERT INTO taskRepeatDelays ( name ) VALUES ( 1 ), ( 2 ), ( 3 ), ( 4 ), ( 5 ), ( 6 ), ( 7 ), ( 8 ), ( 9 ), ( 10 ), ( 11 ), ( 12 ), ( 13 ), ( 14 ), ( 15 ), ( 16 ), ( 17 ), ( 18 ), ( 19 ), ( 20 ), ( 21 ), ( 22 ), ( 23 ), ( 24 ), ( 25 ), ( 26 ), ( 27 ), ( 28 ), ( 29 ), ( 30 ), ( 31 )
END