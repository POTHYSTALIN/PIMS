-- for transaction manager module
-- under construction
-- tables needed
	-- transactionTypes
	-- transactionModes
	-- transactionCategories
	-- transactions
	-- bankAccounts ( for account based balance report )
	-- persons

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[balances]') AND type in (N'U'))
BEGIN
	CREATE TABLE balances(
		id int primary key identity(1,1),
		personId int,
		modeId int,
		accountId int,
		amount money not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO balances( personId, modeId, accountId, amount )
	VALUES
		( 1, 1, NULL, 40300.00 ),
		( 1, 2, 1, 12446.92 ),
		( 1, 2, 2, 2161.51 )
END

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

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[transactionModes]') AND type in (N'U'))
BEGIN
	CREATE TABLE transactionModes(
		id int primary key identity(1,1),
		name nvarchar(50) not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO transactionModes( name, deleted )
	VALUES( N'Cash', 0 )
	INSERT INTO transactionModes( name, deleted )
	VALUES( N'Transfer', 0 )
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
	-- INSERT INTO transactionCategories( name, typeID, deleted )
	-- VALUES( N'Salary', 1, 0 )
	-- INSERT INTO transactionCategories( name, typeID, deleted )
	-- VALUES( N'Travel expense', 2, 0 )
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
		categoryId int,
		modeId int,
		fromPersonId int not null,
		fromAccountId int,
		toPersonId int not null,
		toAccountId int,
		amount money,
		description text,
		transactionDate datetime not null default( getDate() ),
		created datetime default( getDate() ),
		updated datetime default( getDate() ),
		archived bit not null default( 0 ),
		archivedDate datetime,
		deleted bit default( 0 )
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