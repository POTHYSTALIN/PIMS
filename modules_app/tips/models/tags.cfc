component singleton="true" {
	property name="dsn" inject="coldbox:setting:PIMS";

	public query function list( numeric id ) {
		var qry = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "SELECT ta.* FROM tags ta WHERE 1 = 1 ";

		if( structKeyExists( arguments, "id" ) ) {
			sql &= "AND ta.id = :id";
			params.insert( "id", { value: arguments.id, cfsqltype: "cf_sql_integer" } );
		}

		qry = queryExecute( sql, params, options );
		return qry;
	}
}