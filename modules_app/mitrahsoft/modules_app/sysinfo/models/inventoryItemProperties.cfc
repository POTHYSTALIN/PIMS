component output="false" extends="model.utilsService" {

	property name="dsn" inject="coldbox:setting:PIMS";

	public function init() {
		return this;
	}

	public query function getProperties(
		numeric id,
		numeric deleted,
		string searchStr = ""
	) {
		local.sqlString = "SELECT * FROM inventoryItemProperties WHERE 1 = 1 ";
		if( structKeyExists( arguments, "deleted" ) ) {
			local.sqlString &= "AND deleted = :deleted ";
		}
		if( structKeyExists( arguments, "id" ) ) {
			local.sqlString &= "AND id = :id ";
		}
		if( len( arguments.searchStr ) ) {
			local.sqlString &= "AND ( name LIKE :searchStr ) ";
		}
		local.qry = new query(
			datasource = dsn.name,
			sql = local.sqlString
		);
		if( structKeyExists( arguments, "deleted" ) ) {
			local.qry.addParam(name="deleted", value="#arguments.deleted#", cfsqltype="cf_sql_integer");
		}
		if( structKeyExists( arguments, "id" ) ) {
			local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");
		}
		if( len( arguments.searchStr ) ) {
			local.qry.addParam(name="searchStr", value="%#arguments.searchStr#%", cfsqltype="cf_sql_varchar");
		}		

		return local.qry.execute().getResult();
	}

	public string function addProperty(
		required string name,
		string created = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				INSERT INTO
					inventoryItemProperties(
						name,
						created
					)
					VALUES(
						:name,
						:created
					);
			"
		);
		local.qry.addParam(name="name", value="#arguments.name#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="created", value="#arguments.created#", cfsqltype="cf_sql_timestamp");

		local.result = local.qry.execute();
		return local.result.getPrefix().generatedkey;
	}

	public void function updateProperty(
		required numeric id,
		required string name,
		boolean deleted=false,
		string updated = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				UPDATE inventoryItemProperties SET
					name = :name,
					deleted = :deleted,
					updated = :updated
				WHERE id = :id
			"
		);
		local.qry.addParam(name="name", value="#arguments.name#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="deleted", value="#arguments.deleted#", cfsqltype="cf_sql_bit");
		local.qry.addParam(name="updated", value="#arguments.updated#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		local.result = local.qry.execute();
	}

	public void function deleteProperty(
		required numeric id,
		string updated = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				UPDATE inventoryItemProperties SET
					deleted = 1,
					updated = :updated
				WHERE id = :id
			"
		);
		local.qry.addParam(name="updated", value="#arguments.updated#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		local.result = local.qry.execute();
	}
}