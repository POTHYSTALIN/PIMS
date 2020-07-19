component output="false" {

	public securityService function init( required struct  dsn ){
		variables.dsn = arguments.dsn.name;
		return this;
	}

	public struct function validateLogin( required string username, required string password ) {
		var res = {};

		local.sqlString = "SELECT * FROM logins l LEFT JOIN persons p ON l.personID = p.id WHERE 1 = 1 ";
		local.sqlString &= "AND l.username = :username ";
		local.sqlString &= "AND l.password = :password ";
		
		local.qry = new query( datasource = variables.dsn, sql = local.sqlString );
		local.qry.addParam(name="username", value="#arguments.username#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="password", value="#arguments.password#", cfsqltype="cf_sql_varchar");

		res.data 	= local.qry.execute().getResult();
		res.isValid = yesNoFormat(res.data.recordcount);

		return res;
	}

	public struct function createUser(
		required string username,
		required string password,
		required string firstname,
		required string lastname,
		required string email,
		required string phone,
		string profileImg
	) {
		var res = {};

		queryExecute(
			"INSERT INTO persons( fname, lname, email, phone ) VALUES ( ?, ?, ?, ? )",
			[ arguments.firstname, arguments.lastname, arguments.email, arguments.phone ],
			{ datasource=variables.dsn, result="res.person" }
		);
		
		queryExecute(
			"INSERT INTO logins( username, password, personId ) VALUES ( ?, ?, ? )",
			[ arguments.username, arguments.password, res.person.generatedKey ],
			{ datasource=variables.dsn, result="res.data" }
		);
		res.isValid = yesNoFormat(res.person.generatedKey) && yesNoFormat(res.data.generatedKey);

		return res;
	}
}