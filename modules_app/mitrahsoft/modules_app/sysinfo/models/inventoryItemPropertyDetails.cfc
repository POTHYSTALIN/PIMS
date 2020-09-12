component output="false" extends="model.utilsService" {

	property name="dsn" inject="coldbox:setting:PIMS";

	public function init() {
		return this;
	}

	public query function getPropertyDetails(
		numeric id,
		numeric deleted,
		string searchStr = ""
	) {
		local.sqlString = "
			SELECT pd.*, i.name as inventoryItemName, ip.name as inventoryItemPropertyName FROM inventoryItemPropertyDetails pd
				INNER JOIN inventoryItems i ON pd.inventoryItemId = i.id
				INNER JOIN inventoryItemProperties ip ON pd.inventoryItemPropertyId = ip.id
			WHERE 1 = 1 ";
		if( structKeyExists( arguments, "deleted" ) ) {
			local.sqlString &= "AND pd.deleted = :deleted ";
		}
		if( structKeyExists( arguments, "id" ) ) {
			local.sqlString &= "AND pd.id = :id ";
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

	public string function addPropertyDetails(
		required numeric inventoryItemId,
		required numeric inventoryItemPropertyId,
		required string inventoryItemPropertyValue,
		boolean deleted=0,
		string created = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				INSERT INTO
					inventoryItemPropertyDetails(
						inventoryItemId,
						inventoryItemPropertyId,
						inventoryItemPropertyValue,
						deleted,
						created
					)
					VALUES(
						:inventoryItemId,
						:inventoryItemPropertyId,
						:inventoryItemPropertyValue,
						:deleted,
						:created
					);
			"
		);
		local.qry.addParam(name="inventoryItemId", value="#arguments.inventoryItemId#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="inventoryItemPropertyId", value="#arguments.inventoryItemPropertyId#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="inventoryItemPropertyValue", value="#arguments.inventoryItemPropertyValue#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="deleted", value="#arguments.deleted#", cfsqltype="cf_sql_bit");
		local.qry.addParam(name="created", value="#arguments.created#", cfsqltype="cf_sql_timestamp");

		local.result = local.qry.execute();
		return local.result.getPrefix().generatedkey;
	}

	public void function updatePropertyDetails(
		required numeric id,
		required numeric inventoryItemId,
		required numeric inventoryItemPropertyId,
		required string inventoryItemPropertyValue,
		boolean deleted=0,
		string updated = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				UPDATE inventoryItemPropertyDetails SET
					inventoryItemId = :inventoryItemId,
					inventoryItemPropertyId = :inventoryItemPropertyId,
					inventoryItemPropertyValue = :inventoryItemPropertyValue,
					deleted = :deleted,
					updated = :updated
				WHERE id = :id
			"
		);
		local.qry.addParam(name="inventoryItemId", value="#arguments.inventoryItemId#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="inventoryItemPropertyId", value="#arguments.inventoryItemPropertyId#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="inventoryItemPropertyValue", value="#arguments.inventoryItemPropertyValue#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="deleted", value="#arguments.deleted#", cfsqltype="cf_sql_bit");
		local.qry.addParam(name="updated", value="#arguments.updated#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		local.result = local.qry.execute();
	}

	public void function deletePropertyDetails(
		required numeric id,
		string updated = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				UPDATE inventoryItemPropertyDetails SET
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