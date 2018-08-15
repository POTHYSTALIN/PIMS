-- MS SQL 2012 script
-- created by POTHYS RAVICHANDRAN, on 21 Apr, 2017
-- last updated by POTHYS RAVICHANDRAN, on 22 Jun, 2017


-- Hints for updating the script
-- We should be able to run this script multiple times without any error.
-- So please create any table surrounded by checking its existences.
-- Don't modify the CREATE TABLE script( actually any script ), which is added here with previous versions.
-- Instead you can add a ALTER TABLE script to modify.
-- Don't use any foreign key relationships in the DB.
-- Use camel case namings for all db objects, fields or constraints( like transactionDetails or logins ).
-- each table should have primary key.
-- primary key should be named as just id, not transactionID or something else.
-- primary key should be integer & auto incremented field.
-- type for each field should be in lower case.
-- each main table should have created & updated columns, not needed for mapping tables.
-- [int,nvarchar,datetime,bit] datatypes should only be used.

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'latestMyApp')
	CREATE DATABASE latestMyApp

use latestMyApp;

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[logins]') AND type in (N'U'))
BEGIN
	CREATE TABLE logins(
		id int primary key identity(1,1),
		name nvarchar(30) not null,
		password nvarchar(100) not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		verified bit default(0)
	)
	INSERT INTO logins( name, password, verified )
	VALUES( N'pothys', N'pothys', 1 )
END

-- for password manager module
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[passwords]') AND type in (N'U'))
BEGIN
	CREATE TABLE passwords(
		id int primary key identity(1,1),
		site nvarchar(100) not null,
		username nvarchar(50) not null,
		password nvarchar(50) not null,
		salt nvarchar(50) not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AdditionalSecurity]') AND type in (N'U'))
BEGIN
	Create table AdditionalSecurity (id int primary key identity(1,1), AccID int, SecurityType varchar(10), details varchar(100))
END

-- for transaction manager module
-- under construction
-- tables needed
	-- transactionTypes
	-- transactionCategories
	-- transactions
	-- bankAccounts ( for account based balance report )
	-- persons
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[transactionTypes]') AND type in (N'U'))
BEGIN
	CREATE TABLE transactionTypes(
		id int primary key identity(1,1),
		name nvarchar(50) not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO transactionTypes( name, deleted )
	VALUES( N'Income', 0 )
	INSERT INTO transactionTypes( name, deleted )
	VALUES( N'Expense', 0 )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[transactionCategories]') AND type in (N'U'))
BEGIN
	CREATE TABLE transactionCategories(
		id int primary key identity(1,1),
		name nvarchar(50) not null,
		typeID int not null,
		parentID int,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO transactionCategories( name, typeID, deleted )
	VALUES( N'Salary', 1, 0 )
	INSERT INTO transactionCategories( name, typeID, deleted )
	VALUES( N'Travel expense', 2, 0 )
END

-- fields for transactions table
	-- id
	-- category
	-- bankAccountID( for bank or ATM related transactions only, so it should be null allowed field )
	-- personID
	-- description
	-- amount
	-- created
	-- updated
	-- deleted

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[transactions]') AND type in (N'U'))
BEGIN
	CREATE TABLE transactions(
		id int primary key identity(1,1),
		categoryID int,
		bankAccountID int,
		personID int not null,
		description text,
		amount money,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[banks]') AND type in (N'U'))
BEGIN
	CREATE TABLE banks(
		id int primary key identity(1,1),
		name nvarchar(100) not null,
		shortname nvarchar(10) not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO banks( name, shortname, deleted ) VALUES
	( N'State Bank of India', 'SBI', 0 )
	,( N'Indian Overseas Bank', 'IOB', 0 )
	,( N'Tamilnadu Mercantile Bank', 'TMB', 0 )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bankAccounts]') AND type in (N'U'))
BEGIN
	CREATE TABLE bankAccounts(
		id int primary key identity(1,1),
		bankID int not null,
		accountID varchar(30) not null,
		personID int not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persons]') AND type in (N'U'))
BEGIN
	CREATE TABLE persons(
		id int primary key identity(1,1),
		fname nvarchar(50),
		lname nvarchar(50),
		username nvarchar(50) null,
		password nvarchar(50) null,
		email nvarchar(50) null,
		phone nvarchar(50) null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
END

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
		repeatType varchar(10) NULL,
		repeatDelay int NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO taskCategories ( name, taskTypeID, repeatType, repeatDelay ) VALUES
	( N'One time task', 1, NULL, NULL ),
	( N'Daily task', 2, 1, 1 ),
	( N'Weekly task', 2, 2, 1 ),
	( N'Monthly task', 2, 3, 1 ),
	( N'Yearly task', 2, 4, 1 )
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

	INSERT INTO taskRepeatDelays ( name ) VALUES ( 1 ), ( 2 ), ( 3 ), ( 4 ), ( 5 ), ( 6 ), ( 7 ), ( 8 ), ( 9 ), ( 10 )
END