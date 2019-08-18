component output="false" extends="model.utilsService" {

	property name="dsn" inject="coldbox:setting:latestMyApp";

	public function init() {
		return this;
	}

	public query function getItemDetails(
		numeric id,
		numeric deleted,
		string searchStr = ""
	) {
		local.sqlString = "
			SELECT
				iid.*, ii.name as item,
				iipd_brand.inventoryItemPropertyValue as brand
				,iipd_model.inventoryItemPropertyValue as model
				,iipd_cd.inventoryItemPropertyValue as cd
				,iipd_gen.inventoryItemPropertyValue as generation
				,iipd_freq.inventoryItemPropertyValue as frequency
				,iipd_size.inventoryItemPropertyValue as size
			FROM inventoryItemDetails iid
				INNER JOIN inventoryItems ii ON iid.inventoryItemID = ii.id
				INNER JOIN inventoryItemPropertyDetails iipd_brand ON iid.brandID = iipd_brand.id
				INNER JOIN inventoryItemProperties iip_brand ON iipd_brand.inventoryItemPropertyID = iip_brand.id

				INNER JOIN inventoryItemPropertyDetails iipd_model ON iid.modelID = iipd_model.id
				INNER JOIN inventoryItemProperties iip_model ON iipd_model.inventoryItemPropertyID = iip_model.id

				LEFT JOIN inventoryItemPropertyDetails iipd_cd ON iid.cdID = iipd_cd.id
				LEFT JOIN inventoryItemProperties iip_cd ON iipd_cd.inventoryItemPropertyID = iip_cd.id
				
				LEFT JOIN inventoryItemPropertyDetails iipd_gen ON iid.generationID = iipd_gen.id
				LEFT JOIN inventoryItemProperties iip_gen ON iipd_gen.inventoryItemPropertyID = iip_gen.id
				
				LEFT JOIN inventoryItemPropertyDetails iipd_freq ON iid.frequencyID = iipd_freq.id
				LEFT JOIN inventoryItemProperties iip_freq ON iipd_freq.inventoryItemPropertyID = iip_freq.id
				
				LEFT JOIN inventoryItemPropertyDetails iipd_size ON iid.sizeID = iipd_size.id
				LEFT JOIN inventoryItemProperties iip_size ON iipd_size.inventoryItemPropertyID = iip_size.id

			WHERE 1 = 1 ";
		if( structKeyExists( arguments, "deleted" ) ) {
			local.sqlString &= "AND iid.deleted = :deleted ";
		}
		if( structKeyExists( arguments, "id" ) ) {
			local.sqlString &= "AND iid.id = :id ";
		}
		if( len( arguments.searchStr ) ) {
			local.sqlString &= "AND ( iid.name LIKE :searchStr ) ";
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

	public string function addItemDetails(
		required numeric inventoryItemID,
		required numeric brandID,
		required numeric modelID,
		required numeric cdID,
		required numeric frequencyID,
		required numeric generationID,
		required numeric sizeID,
		boolean deleted=0,
		string created = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
			INSERT INTO inventoryItemDetails(
					inventoryItemID,
					brandID,
					modelID,
					cdID,
					frequencyID,
					generationID,
					sizeID,
					deleted,
					created
				)
				VALUES(
					:inventoryItemID,
					:brandID,
					:modelID,
					:cdID,
					:frequencyID,
					:generationID,
					:sizeID,
					:deleted,
					:created
				);
			"
		);
		local.qry.addParam(name="inventoryItemID", value="#arguments.inventoryItemID#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="brandID", value="#arguments.brandID#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="modelID", value="#arguments.modelID#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="cdID", value="#arguments.cdID#", cfsqltype="cf_sql_integer", null="#iif(val(arguments.cdID), false, true)#");
		local.qry.addParam(name="frequencyId", value="#arguments.frequencyId#", cfsqltype="cf_sql_integer", null="#iif(val(arguments.frequencyId), false, true)#");
		local.qry.addParam(name="generationID", value="#arguments.generationID#", cfsqltype="cf_sql_integer", null="#iif(val(arguments.generationID), false, true)#");
		local.qry.addParam(name="sizeID", value="#arguments.sizeID#", cfsqltype="cf_sql_integer", null="#iif(val(arguments.sizeID), false, true)#");
		local.qry.addParam(name="deleted", value="#arguments.deleted#", cfsqltype="cf_sql_bit");
		local.qry.addParam(name="created", value="#arguments.created#", cfsqltype="cf_sql_timestamp");

		local.result = local.qry.execute();
		return local.result.getPrefix().generatedkey;
	}

	public void function updateItemDetails(
		required numeric id,
		required numeric inventoryItemID,
		required numeric brandID,
		required numeric modelID,
		required numeric cdID,
		required numeric frequencyID,
		required numeric generationID,
		required numeric sizeID,
		boolean deleted=0,
		string updated = "#now()#"
	) {
		// writeDump(arguments);abort;
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				UPDATE inventoryItemDetails SET
					inventoryItemID = :inventoryItemID,
					brandID = :brandID,
					modelID = :modelID,
					cdID = :cdID,
					frequencyID = :frequencyID,
					generationID = :generationID,
					sizeID = :sizeID,
					deleted = :deleted,
					updated = :updated
				WHERE id = :id
			"
		);
		local.qry.addParam(name="inventoryItemID", value="#arguments.inventoryItemID#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="brandID", value="#arguments.brandID#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="modelID", value="#arguments.modelID#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="cdID", value="#arguments.cdID#", cfsqltype="cf_sql_integer", null="#iif(val(arguments.cdID), false, true)#");
		local.qry.addParam(name="frequencyId", value="#arguments.frequencyId#", cfsqltype="cf_sql_integer", null="#iif(val(arguments.frequencyId), false, true)#");
		local.qry.addParam(name="generationID", value="#arguments.generationID#", cfsqltype="cf_sql_integer", null="#iif(val(arguments.generationID), false, true)#");
		local.qry.addParam(name="sizeID", value="#arguments.sizeID#", cfsqltype="cf_sql_integer", null="#iif(val(arguments.sizeID), false, true)#");
		local.qry.addParam(name="deleted", value="#arguments.deleted#", cfsqltype="cf_sql_bit");
		local.qry.addParam(name="updated", value="#arguments.updated#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		local.result = local.qry.execute();
	}

	public void function deleteItemDetails(
		required numeric id,
		string updated = "#now()#"
	) {
		writeDump(arguments);abort;
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				UPDATE inventoryItemDetails SET
					deleted = 1,
					updated = :updated
				WHERE id = :id
			"
		);
		local.qry.addParam(name="updated", value="#arguments.updated#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		local.result = local.qry.execute();
	}

	public query function getPropertyDetails(
		required string type
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				SELECT iipd.id, iipd.inventoryItemPropertyValue name
				FROM inventoryItemPropertyDetails iipd
					INNER JOIN inventoryItemProperties iip ON iipd.inventoryItemPropertyId = iip.id and iip.name = '#arguments.type#'
				WHERE 1 = 1
			"
		);

		return local.qry.execute().getResult();
	}
}