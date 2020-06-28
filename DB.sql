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

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'PIMS')
	CREATE DATABASE PIMS

use PIMS;

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[persons]') AND type in (N'U'))
BEGIN
	CREATE TABLE persons(
		id int primary key identity(1,1),
		fname nvarchar(50),
		lname nvarchar(50),
		email nvarchar(50) null,
		phone nvarchar(50) null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO persons( fname, lname, email, phone )
	VALUES( N'Pothys', N'Ravichandran', N'pothystalin@gmail.com', N'+91 xxxxxxxxxx' )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[logins]') AND type in (N'U'))
BEGIN
	CREATE TABLE logins(
		id int primary key identity(1,1),
		username nvarchar(50) not null,
		password nvarchar(50) not null,
		personID int NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		verified bit default(0)
	)
	INSERT INTO logins( username, password, personID, verified )
	VALUES( N'pothys', N'pothys', 1, 1 )
END