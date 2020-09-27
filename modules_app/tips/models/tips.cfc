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

	public numeric function add(
		required string title,
		required string description,
		boolean deleted=false
	) {
		var result = "";
		var options = { datasource: dsn.name, result: "result" };
		var params = {};
		var sql = "INSERT INTO tips( title, description, deleted ) VALUES( :title, :description, :deleted )";
		params.insert( "title", { value: arguments.title, cfsqltype: "cf_sql_varchar" } );
		params.insert( "description", { value: arguments.description, cfsqltype: "cf_sql_varchar" } );
		params.insert( "deleted", { value: arguments.deleted, cfsqltype: "cf_sql_bit" } );
		
		queryExecute( sql, params, options );
		return result.generatedkey;
	}

	public numeric function update(
		required numeric id,
		required string title,
		required string description,
		boolean deleted=false
	) {
		var result = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "
			UPDATE tips SET
				title = :title,
				description = :description,
				deleted = :deleted,
				updated = getDate()
			WHERE id = :id";
		params.insert( "id", { value: arguments.id, cfsqltype: "cf_sql_integer" } );
		params.insert( "title", { value: arguments.title, cfsqltype: "cf_sql_varchar" } );
		params.insert( "description", { value: arguments.description, cfsqltype: "cf_sql_varchar" } );
		params.insert( "deleted", { value: arguments.deleted, cfsqltype: "cf_sql_bit" } );
		
		queryExecute( sql, params, options );
		return arguments.id;
	}

	public numeric function delete( required numeric id ) {
		var result = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "UPDATE tips SET deleted = 1, updated = getDate() WHERE id = :id";
		params.insert( "id", { value: arguments.id, cfsqltype: "cf_sql_integer" } );
		
		queryExecute( sql, params, options );
		return arguments.id;
	}

	public void function updateTags(
		required numeric tipId,
		required string tagIds
	) {
		var result = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "DELETE FROM tips_tags WHERE tipId = :tipId; ";
		params.insert( "tipId", { value: arguments.tipId, cfsqltype: "cf_sql_integer" } );

		if( len( trim( arguments.tagIds ) ) ) {
			sql &= "INSERT INTO tips_tags ( tipId, tagId ) VALUES";
			var i = 1;
			for( var tagId in arguments.tagIds ) {
				if( i > 1 ) {
					sql &= ", ";
				}
				sql &= "( :tipId, :temp_" & tagId & " )";
				params.insert( "temp_" & tagId, { value: tagId, cfsqltype: "cf_sql_integer" } );
				i++;
			}
		}

		queryExecute( sql, params, options );
	}
}