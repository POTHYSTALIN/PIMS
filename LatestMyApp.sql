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
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bankAccounts]') AND type in (N'U'))
BEGIN
	CREATE TABLE bankAccounts(
		id int primary key identity(1,1),
		bankID int not null,
		accountID int not null,
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
		event_id int primary key identity(1,1),
		event_name varchar(50) NULL,
		event_desc nvarchar(max) NULL,
		start_date datetime NULL,
		end_date datetime NULL
	)
END