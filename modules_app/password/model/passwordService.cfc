component output="false" extends="model.utilsService" {

	property name="dsn" inject="coldbox:setting:PIMS";

	public function init() {
		return this;
	}

	public query function getPassword(
		numeric id,
		numeric deleted = 0,
		string searchStr = ""
	) {
		local.sqlString = "SELECT * FROM passwords WHERE 1 = 1 ";
		local.sqlString &= "AND deleted = :deleted ";
		if( structKeyExists( arguments, "id" ) ) {
			local.sqlString &= "AND id = :id ";
		}
		if( len( arguments.searchStr ) ) {
			local.sqlString &= "AND ( site LIKE :searchStr  OR username LIKE :searchStr ) ";
		}
		local.qry = new query(
			datasource = dsn.name,
			sql = local.sqlString
		);
		local.qry.addParam(name="deleted", value="#arguments.deleted#", cfsqltype="cf_sql_integer");
		if( structKeyExists( arguments, "id" ) ) {
			local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");
		}
		if( len( arguments.searchStr ) ) {
			local.qry.addParam(name="searchStr", value="%#arguments.searchStr#%", cfsqltype="cf_sql_varchar");
		}		

		return local.qry.execute().getResult();
	}

	public string function addPassword(
		required string sitename,
		required string username,
		required string password,
		string salt = "#createUUID()#",
		string created = "#now()#"
	) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				INSERT INTO
					passwords(
						site,
						username,
						password,
						salt,
						created
					)
					VALUES(
						:sitename,
						:username,
						:password,
						:salt,
						:created
					);
			"
		);
		local.qry.addParam(name="sitename", value="#arguments.sitename#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="username", value="#arguments.username#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="password", value="#encrypt(arguments.password, arguments.salt)#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="salt", value="#arguments.salt#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="created", value="#arguments.created#", cfsqltype="cf_sql_timestamp");

		local.result = local.qry.execute();
		return local.result.getPrefix().generatedkey;
	}

	public void function updatePassword(
		required numeric id,
		string sitename,
		string username,
		string password
	) {
		local.details = getPassword( id=arguments.id );
		local.sqlString = "UPDATE passwords SET salt = salt";
		if( structKeyExists(arguments, "sitename") )
			local.sqlString &= ", site = :sitename";
		if( structKeyExists(arguments, "username") )
			local.sqlString &= ", username = :username";
		if( structKeyExists(arguments, "password") )
			local.sqlString &= ", password = :password";
		local.sqlString &= " WHERE id = :id";

		local.qry = new query(
			datasource = dsn.name,
			sql = local.sqlString
		);
		if( structKeyExists(arguments, "sitename") )
			local.qry.addParam(name="sitename", value="#arguments.sitename#", cfsqltype="cf_sql_varchar");
		if( structKeyExists(arguments, "username") )
			local.qry.addParam(name="username", value="#arguments.username#", cfsqltype="cf_sql_varchar");
		if( structKeyExists(arguments, "password") )
			local.qry.addParam(name="password", value="#encrypt(arguments.password, local.details.salt)#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		local.qry.execute();
	}

	public void function deletePassword( required numeric id ) {
		local.qry = new query(
			datasource = dsn.name,
			sql = "UPDATE passwords SET deleted = 1 WHERE id = :id"
		);
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		local.qry.execute();
	}

	public void function addAdditionalSecurtity(
		required numeric accID,
		required array data
	) {
		for( curr in arguments.data ) {
			local.qry = new query(
				datasource = dsn.name,
				sql = "
					INSERT INTO AdditionalSecurity(
						accID,
						securityType,
						details
					)
					VALUES(
						:accID,
						:securityType,
						:details
					);
				"
			);
			local.qry.addParam(name="accID", value="#arguments.accID#", cfsqltype="cf_sql_integer");
			local.qry.addParam(name="securityType", value="#curr.securityType#", cfsqltype="cf_sql_varchar");
			local.qry.addParam(name="details", value="#curr.details#", cfsqltype="cf_sql_varchar");

			local.qry.execute();
		}
	}

	public query function getAdditionalSecurityDetails( required numeric id ) {
		local.sqlString = "SELECT * FROM AdditionalSecurity WHERE 1 = 1 ";
		local.sqlString &= "AND accID = :id ";

		local.qry = new query(
			datasource = dsn.name,
			sql = local.sqlString
		);
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");

		return local.qry.execute().getResult();
	}

	public void function removeAdditionalSecurityDetails( required numeric accID ) {
		local.sqlString = "DELETE FROM AdditionalSecurity WHERE 1 = 1 AND accID = :accID";

		local.qry = new query(
			datasource = dsn.name,
			sql = local.sqlString
		);
		local.qry.addParam(name="accID", value="#arguments.accID#", cfsqltype="cf_sql_integer");

		return local.qry.execute().getResult();
	}

	public boolean function syncBox( required string jsonContent ) {
		try {
			// local.sqlString = "sp_rename 'passwords', 'passwords_#dateFormat(now(), "yyyy_mm_dd")#'";
			local.sqlString = "SELECT * INTO passwords_#dateTimeFormat(now(), "yyyy_mm_dd_HH_nn_ss")# FROM passwords";

			local.qry = new query(
				datasource = dsn.name,
				sql = local.sqlString
			);
			local.qry.execute();

			local.sqlString = "TRUNCATE TABLE passwords";

			local.qry = new query(
				datasource = dsn.name,
				sql = local.sqlString
			);
			local.qry.execute();

			local.newData = deserializeJSON(arguments.jsonContent);
			for( var currItm in local.newData ) {
				local.currSLNo = addPassword(
					sitename = currItm.site,
					username = currItm.username,
					password = decrypt(currItm.password, currItm.salt),
					salt = currItm.salt
				);
				if(arrayLen(currItm.additional)) {
					var local.idx = 0;
					for( var currAddItm in currItm.additional) {
						idx++;
						addAdditionalSecurtity(
							addSecID = idx,
							accID = currSLNo,
							addSecType = currAddItm.securityType,
							addSecDetails = currAddItm.details
						);
					}
				}
			}
		}
		catch(any e) {
			writeDump(e);abort;
			return false;
		}
		return true;
	}
}