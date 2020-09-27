component singleton="true" {
	property name="dsn" inject="coldbox:setting:PIMS";

	public query function list(
		numeric id,
		numeric tipId,
		boolean includeDeleted=false
	) {
		var qry = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "
			SELECT ta.*, tt.* FROM tags ta
				LEFT JOIN tips_tags tt ON ta.id = tt.tagId
			WHERE 1 = 1 ";

		if( structKeyExists( arguments, "id" ) ) {
			sql &= "AND ta.id = :id ";
			params.insert( "id", { value: arguments.id, cfsqltype: "cf_sql_integer" } );
		}

		if( structKeyExists( arguments, "tipId" ) ) {
			sql &= "AND tt.tipId = :tipId ";
			params.insert( "tipId", { value: arguments.tipId, cfsqltype: "cf_sql_integer" } );
		}

		if( !arguments.includeDeleted ) {
			sql &= "AND ta.deleted = 0 ";
		}

		qry = queryExecute( sql, params, options );
		return qry;
	}

	public numeric function add(
		required string name,
		boolean deleted=false
	) {
		var result = "";
		var options = { datasource: dsn.name, result: "result" };
		var params = {};
		var sql = "INSERT INTO tags( name, deleted ) VALUES( :name, :deleted )";
		params.insert( "name", { value: arguments.name, cfsqltype: "cf_sql_varchar" } );
		params.insert( "deleted", { value: arguments.deleted, cfsqltype: "cf_sql_bit" } );
		
		queryExecute( sql, params, options );
		return result.generatedkey;
	}

	public numeric function update(
		required numeric id,
		required string name,
		boolean deleted=false
	) {
		var result = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "
			UPDATE tags SET
				name = :name,
				deleted = :deleted,
				updated = getDate()
			WHERE id = :id";
		params.insert( "id", { value: arguments.id, cfsqltype: "cf_sql_integer" } );
		params.insert( "name", { value: arguments.name, cfsqltype: "cf_sql_varchar" } );
		params.insert( "deleted", { value: arguments.deleted, cfsqltype: "cf_sql_bit" } );
		
		queryExecute( sql, params, options );
		return arguments.id;
	}

	public numeric function delete( required numeric id ) {
		var result = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "UPDATE tags SET deleted = 1, updated = getDate() WHERE id = :id";
		params.insert( "id", { value: arguments.id, cfsqltype: "cf_sql_integer" } );
		
		queryExecute( sql, params, options );
		return arguments.id;
	}
}