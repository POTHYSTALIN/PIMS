component output="false" {
	property name="dsn" inject="coldbox:setting:PIMS";

	public function init(){
		return this;
	}

	public query function list( numeric id, boolean showAll = true, boolean includeDeleted = false ) {
		var qry = "";
		var options = { datasource: dsn.name };
		var params = {};
		var sql = "
			SELECT
				e.id, e.[name] AS title, e.[desc], e.eventCategoryId, e.no_of_repeats cycles,
				CONVERT( varchar, e.startDate, 126 ) AS [start], CONVERT( varchar, e.endDate, 126 ) [end],
				ec.[name] [type], ec.textColor, ec.backgroundColor, ec.borderColor
			FROM events e
				LEFT JOIN eventCategories ec ON e.eventCategoryId = ec.id
			WHERE 1 = 1
		";

		if( structKeyExists( arguments, "id" ) ) {
			sql &= " AND e.id = :id";
			params.insert( "id", { value: arguments.id, cfsqltype="cf_sql_integer" } );
		}

		if( !arguments.includeDeleted ) {
			sql &= " AND e.deleted = 0";
		}

		if( !arguments.showAll ) {
			sql &= "
				AND [start] > DATEADD(day, -1, getDate())
				AND (
					[end] < DATEADD(day, 1, getDate())
					OR [end] IS NULL
				)
			";
		}

		sql &= " ORDER BY ec.[name], e.startDate, e.endDate";
		qry = queryExecute( sql, params, options );

		return qry;
	}

	public void function add(
		required string name,
		required string desc,
		required string startDate,
		required string endDate,
		required string eventCategoryId hint="string - to support NULL values",
		required string no_of_repeats hint="string - to support NULL values"
	) {
		var qry = "";
		var options = { datasource: dsn.name };
		var params = {};

		var sql = "
			INSERT INTO events( name, [desc], startDate, endDate, eventCategoryId, no_of_repeats )
			VALUES( :name, :desc, :startDate, :endDate, :eventCategoryId, :no_of_repeats )
		";

		params.insert( "name", { value=arguments.name, cfsqltype="cf_sql_varchar" } );
		params.insert( "desc", { value=arguments.desc, cfsqltype="cf_sql_varchar" } );
		params.insert( "startDate", { value=arguments.startDate, cfsqltype="cf_sql_date" } );
		params.insert( "endDate", { value=arguments.endDate, cfsqltype="cf_sql_date", null=yesNoFormat( !len( arguments.endDate ) ) } );
		params.insert( "eventCategoryId", { value=arguments.eventCategoryId, cfsqltype="cf_sql_integer", null=yesNoFormat( !len( arguments.eventCategoryId ) ) } );
		params.insert( "no_of_repeats", { value=arguments.no_of_repeats, cfsqltype="cf_sql_integer", null=yesNoFormat( !len( arguments.no_of_repeats ) ) } );

		qry = queryExecute( sql, params, options );
	}


	public void function update(
		required string name,
		required string desc,
		required string startDate,
		required string endDate,
		required string eventCategoryId hint="string - to support NULL values",
		required string no_of_repeats hint="string - to support NULL values",
		required numeric id
	) {
		var qry = "";
		var options = { datasource: dsn.name };
		var params = {};

		var sql = "
			UPDATE events SET
				name = :name,
				[desc] = :desc,
				startDate = :startDate,
				endDate = :endDate,
				eventCategoryId = :eventCategoryId,
				no_of_repeats = :no_of_repeats,
				updated = getDate()
			WHERE id = :id
		";

		params.insert( "id", { value=arguments.id, cfsqltype="cf_sql_integer" } );
		params.insert( "name", { value=arguments.name, cfsqltype="cf_sql_varchar" } );
		params.insert( "desc", { value=arguments.desc, cfsqltype="cf_sql_varchar" } );
		params.insert( "startDate", { value=arguments.startDate, cfsqltype="cf_sql_date" } );
		params.insert( "endDate", { value=arguments.endDate, cfsqltype="cf_sql_date", null=yesNoFormat( !len( arguments.endDate ) ) } );
		params.insert( "eventCategoryId", { value=arguments.eventCategoryId, cfsqltype="cf_sql_integer", null=yesNoFormat( !len( arguments.eventCategoryId ) ) } );
		params.insert( "no_of_repeats", { value=arguments.no_of_repeats, cfsqltype="cf_sql_integer", null=yesNoFormat( !len( arguments.no_of_repeats ) ) } );

		qry = queryExecute( sql, params, options );
	}

	public void function delete( required numeric id ) {
		var qry = "";
		var options = { datasource: dsn.name };
		var params = {};

		// var sql = "DELETE FROM events WHERE id = :id";
		var sql = "UPDATE events set deleted = 1, updated = getDate() WHERE id = :id";
		params.insert( "id", { value=arguments.id, cfsqltype="cf_sql_integer" } );
		qry = queryExecute( sql, params, options );
	}

	public query function listCategories(  ) {
		var qry = "";
		var options = { datasource: dsn.name };
		var params = {};

		var sql = "SELECT * FROM eventCategories";

		qry = queryExecute( sql, params, options );

		return qry;
	}
}