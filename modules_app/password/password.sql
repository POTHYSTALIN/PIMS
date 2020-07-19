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
	Create table AdditionalSecurity (
		id int primary key identity(1,1),
		AccID int not null,
		SecurityType varchar(10),
		details varchar(100)
	)
END