-- for tips manager module
-- under construction
-- tables needed
	-- tips
	-- tags

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tips]') AND type in (N'U'))
BEGIN
	CREATE TABLE tips(
		id int primary key identity(1,1),
		title nvarchar(200) not null,
		description nvarchar(max) not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)

	INSERT INTO tips( title, description ) VALUES
	( N'Demo tips', N'# heading' )
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tags]') AND type in (N'U'))
BEGIN
	CREATE TABLE tags(
		id int primary key identity(1,1),
		name nvarchar(30) not null,
		created datetime default(getDate()),
		updated datetime default(getDate()),
		deleted bit default(0)
	)
	INSERT INTO tags( name ) VALUES
	( N'windows' ),
	( N'linux' ),
	( N'mac' ),
	( N'tech' ),
	( N'hardware' ),
	( N'apache' ),
	( N'iis' ),
	( N'ssl' ),
	( N'rewrite' ),
	( N'mod_cfml' ),
	( N'java' ),
	( N'java' ),
	( N'andorid' ),
	( N'vpn' ),
	( N'vscode' ),
	( N'coldfusion' ),
	( N'lucee' ),
	( N'railo' ),
	( N'lucee / railo' ),
	( N'sql' ),
	( N'mssql' ),
	( N'mysql' ),
	( N'config' ),
	( N'hidden gems' ),
	( N'update' ),
	( N'troubleshooting' ),
	( N'virtualbox' ),
	( N'docker' ),
	( N'execution policy' ),
	( N'aws' ),
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tags]') AND type in (N'U'))
BEGIN
	CREATE TABLE tips_tags(
		tips_id int not null,
		tag_id int not null
	)
	INSERT INTO tips_tags( tips_id, tag_id ) VALUES
	( 1, 1 ),
	( 1, 4 ),
	( 1, 5 )
END