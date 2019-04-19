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
}