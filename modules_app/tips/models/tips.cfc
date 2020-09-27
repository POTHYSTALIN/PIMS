component singleton="true" {
	property name="dsn" inject="coldbox:setting:PIMS";

	public query function list( numeric id ) {
		var qry = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "SELECT ti.* FROM tips ti WHERE 1 = 1 ";

		if( structKeyExists( arguments, "id" ) ) {
			sql &= "AND ti.id = :id";
			params.insert( "id", { value: arguments.id, cfsqltype: "cf_sql_integer" } );
		}

		qry = queryExecute( sql, params, options );
		return qry;
	}
}