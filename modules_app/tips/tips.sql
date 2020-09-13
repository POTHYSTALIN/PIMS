-- for tips manager module
-- under construction
-- tables needed
	-- tips
	-- tipsCategories

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tips]') AND type in (N'U'))
BEGIN
	CREATE TABLE tips(
		id int primary key identity(1,1),
		title nvarchar(200) not null,
		tipsCategoryId int not null,
		tags varchar(200) not null,
		description nvarchar(max) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	-- INSERT INTO banks( name, shortname, deleted ) VALUES
	-- ( N'State Bank of India', 'SBI', 0 )
	-- ,( N'Indian Overseas Bank', 'IOB', 0 )
	-- ,( N'Tamilnadu Mercantile Bank', 'TMB', 0 )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tips]') AND type in (N'U'))
BEGIN
	CREATE TABLE tips(
		id int primary key identity(1,1),
		title nvarchar(200) not null,
		tipsCategoryId int not null,
		tags varchar(200) not null,
		description nvarchar(max) NOT NULL,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	-- INSERT INTO banks( name, shortname, deleted ) VALUES
	-- ( N'State Bank of India', 'SBI', 0 )
	-- ,( N'Indian Overseas Bank', 'IOB', 0 )
	-- ,( N'Tamilnadu Mercantile Bank', 'TMB', 0 )
END