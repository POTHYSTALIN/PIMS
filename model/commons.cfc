component output="false" {
	property name="dsn" inject="coldbox:datasource:latestMyApp";

	public function init(){
		return this;
	}

	public query function getTaskTypes( numeric id, boolean includeDeleted = false ) {
		local.sqlString = "SELECT * FROM taskTypes WHERE 1 = 1 ";

		if(structKeyExists(arguments, "id")){
			local.sqlString &= "AND id = #arguments.id# ";
		}
		if(!arguments.includeDeleted){
			local.sqlString &= "AND deleted = 0 ";
		}

		local.qry = new query( datasource = dsn.name, sql = local.sqlString );
		return local.qry.execute().getResult();
	}

	public void function newTaskType( required string name, required string desc, boolean deleted = false ) {
		local.sqlString = "
			INSERT INTO taskTypes( name, [desc], deleted )
			VALUES( '#arguments.name#', '#arguments.desc#', #arguments.deleted# )
		";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		local.qry.execute();
	}

	public void function updateTaskType( required numeric id, required string name, required string desc, boolean deleted = false ) {
		local.sqlString = "
			UPDATE taskTypes SET
				name = '#arguments.name#',
				[desc] = '#arguments.desc#',
				deleted = #arguments.deleted#
			WHERE id = #arguments.id#
		";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		local.qry.execute();
	}

	public void function deleteTaskType( required numeric id ) {
		local.sqlString = "
			UPDATE taskTypes SET
				deleted = 1,
				updated = getDate()
			WHERE id = #arguments.id#
		";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		local.qry.execute();
	}

	public query function getTaskCategories( numeric id, boolean includeDeleted = false ) {
		local.sqlString = "
			SELECT
				TC.*, TT.name AS taskTypeName, TRT.name as repeatTypeName, TRD.name as repeatDelayName
			FROM taskCategories TC
				INNER JOIN taskTypes TT ON TC.taskTypeID = TT.id
				LEFT JOIN taskRepeatTypes TRT ON TC.repeatType = TRT.id
				LEFT JOIN taskRepeatDelays TRD ON TC.repeatDelay = TRd.id
			WHERE 1 = 1
		";

		if(structKeyExists(arguments, "id")){
			local.sqlString &= "AND TC.id = #arguments.id# ";
		}
		if(!arguments.includeDeleted){
			local.sqlString &= "AND TC.deleted = 0 ";
		}

		local.qry = new query( datasource = dsn.name, sql = local.sqlString );
		return local.qry.execute().getResult();
	}

	public void function newTaskCategory(
		required string name,
		required numeric taskTypeID,
		required numeric repeatType,
		required numeric repeatDelay,
		boolean deleted = false
	) {
		local.sqlString = "
			INSERT INTO taskCategories( name, taskTypeID, repeatType, repeatDelay, deleted )
			VALUES( '#arguments.name#', #arguments.taskTypeID#, #arguments.repeatType#, #arguments.repeatDelay#, #arguments.deleted# )
		";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		local.qry.execute();
	}

	public void function updateTaskCategory(
		required numeric ID,
		required string name,
		required numeric taskTypeID,
		required numeric repeatType,
		required numeric repeatDelay,
		boolean deleted = false
	) {
		local.sqlString = "
			UPDATE taskCategories SET
				name = '#arguments.name#',
				taskTypeID = #arguments.taskTypeID#,
				repeatType = #arguments.repeatType#,
				repeatDelay = #arguments.repeatDelay#,
				deleted = #arguments.deleted#
			WHERE id = #arguments.id#
		";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		local.qry.execute();
	}

	public void function deleteTaskCategory( required numeric id ) {
		local.sqlString = "
			UPDATE taskCategories SET
				deleted = 1,
				updated = getDate()
			WHERE id = #arguments.id#
		";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		local.qry.execute();
	}

	public query function getTaskRepeatTypes() {
		local.sqlString = "SELECT id, name FROM taskRepeatTypes WHERE deleted = 0";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		return local.qry.execute().getResult();
	}

	public query function getTaskRepeatDelay() {
		local.sqlString = "SELECT id, name FROM taskRepeatDelays";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		return local.qry.execute().getResult();
	}
}