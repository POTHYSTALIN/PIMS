component output="false" extends="model.utilsService" {

	property name="dsn" inject="coldbox:setting:PIMS";

	public function init() {
		return this;
	}

	public query function getSystemDetails(
		numeric id,
		numeric deleted,
		string searchStr = ""
	) {
		local.sqlString = "SELECT * FROM systemDetails WHERE 1 = 1 ";
		if( structKeyExists( arguments, "deleted" ) ) {
			local.sqlString &= "AND deleted = :deleted ";
		}
		if( structKeyExists( arguments, "id" ) ) {
			local.sqlString &= "AND id = :id ";
		}
		if( len( arguments.searchStr ) ) {
			local.sqlString &= "AND ( name LIKE :searchStr OR label LIKE :searchStr ) ";
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

	public string function addItem(
		required string name,
		string created = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				INSERT INTO
					inventoryItems(
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

	public void function updateItem(
		required numeric id,
		required string name,
		boolean deleted=false,
		string updated = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				UPDATE inventoryItems SET
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

	public void function deleteItem(
		required numeric id,
		string updated = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				UPDATE inventoryItems SET
					deleted = 1,
					updated = :updated
				WHERE id = :id
			"
		);
		local.qry.addParam(name="updated", value="#arguments.updated#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		local.result = local.qry.execute();
	}
	
	public query function getInventoryItems(
		required string type
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				SELECT DISTINCT ii.id, ii.name, iipd.inventoryItemPropertyValue, iip.name propName
				FROM inventoryItemDetails iid
					INNER JOIN inventoryItems ii ON ii.id = iid.inventoryItemID AND ii.name = :type
					INNER JOIN inventoryItemPropertyDetails iipd ON ii.id = iipd.inventoryItemID
						AND iipd.inventoryItemPropertyID IN ( iid.brandID, iid.modelID, iid.cdID, iid.generationID, iid.frequencyID, iid.sizeID )
					INNER JOIN inventoryItemProperties iip ON iipd.inventoryItemPropertyID = iip.id
			"
		);
		local.qry.addParam(name="type", value="#arguments.type#", cfsqltype="cf_sql_varchar");

		return local.qry.execute().getResult();
	}
}