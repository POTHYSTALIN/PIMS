component {
	property name="dsn" inject="coldbox:datasource:latestMyApp";

	public any function list() {
		var q = new Query();
		sql = "SELECT * FROM systemInventory";
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		result = q.execute().getResult();
		return result;
	}

	public any function insertSys(rc) {
		writeDump(rc);abort;
		var q = new Query();
		sql="INSERT INTO systemInventory (
				name,
				label,
				cabinet,
				motherboard,
				processor,
				ram,
				HDD,
				OS,
				installationType
			)values(
				:name,
				:label,
				:cabinet,
				:motherboard,
				:processor,
				:ram,
				:HDD,
				:OS,
				:installationType
			)";
		q.addParam(name="name", value=rc.name, cfsqltype="cf_sql_varchar");
		q.addParam(name="label", value=rc.label, cfsqltype="cf_sql_varchar");
		q.addParam(name="cabinet", value=rc.cabinet, cfsqltype="cf_sql_varchar");
		q.addParam(name="motherboard", value=rc.motherboard, cfsqltype="cf_sql_varchar");
		q.addParam(name="processor", value=rc.processor, cfsqltype="cf_sql_varchar");
		q.addParam(name="ram", value=rc.ram, cfsqltype="cf_sql_varchar");
		q.addParam(name="HDD", value=rc.HDD, cfsqltype="cf_sql_varchar");
		q.addParam(name="OS", value=rc.OS, cfsqltype="cf_sql_varchar");
		q.addParam(name="installationType", value=rc.installationType, cfsqltype="cf_sql_varchar");
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		q.execute();
	}


	public query function selectSys( required numeric empID ) {
		var q = new Query();
		sql = "SELECT * FROM systemInventory where id = :empID";
		q.addParam(name="empID", value=rc.empID, cfsqltype="cf_sql_numeric");
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		return q.execute().getResult();
	}


	public any function editSys(rc) {
		var q = new Query();
		sql = "UPDATE systemInventory set
				name = :name,
				label = :label,
				cabinet = :cabinet,
				motherboard = :motherboard,
				processor = :processor,
				ram = :ram,
				HDD = :HDD,
				OS = :OS
			where id = :hiddenID
		";
		q.addParam(name="name", value=rc.name, cfsqltype="cf_sql_varchar");
		q.addParam(name="label", value=rc.label, cfsqltype="cf_sql_varchar");
		q.addParam(name="cabinet", value=rc.cabinet, cfsqltype="cf_sql_varchar");
		q.addParam(name="motherboard", value=rc.motherboard, cfsqltype="cf_sql_varchar");
		q.addParam(name="processor", value=rc.processor, cfsqltype="cf_sql_varchar");
		q.addParam(name="ram", value=rc.ram, cfsqltype="cf_sql_varchar");
		q.addParam(name="HDD", value=rc.HDD, cfsqltype="cf_sql_varchar");
		q.addParam(name="OS", value=rc.OS, cfsqltype="cf_sql_varchar");
		q.addParam(name="installationType", value=rc.installationType, cfsqltype="cf_sql_varchar");
		q.addParam(name="hiddenID", value=rc.hiddenID, cfsqltype="cf_sql_integer");
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		q.execute().getResult();
	}


	public any function delSys(rc) {
		var q = new Query();
		sql = "DELETE FROM systemInventory
			where id = '#rc.empDelID#'
		";
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		q.execute().getResult();
	}

	public any function get(string ID) {
		var q = new Query();
		var sql = "
			SELECT * from Employees e
			inner join empBatch eb on e.batchID = eb.id
			inner join empType et on e.typeID = et.id
		";

		if( structKeyExists(arguments,"ID") and len(arguments.ID) ){
			sql &= " WHERE e.ID = :ID";
			q.addParam(name="ID",value=arguments.ID,cfsqltype="cf_sql_integer");
		}
		q.setSQL(sql);
		q.setDatasource(dsn.name);

		return q.execute().getResult();
	}

	public any function getEmployeeType() {
		var q = new Query();
		var sql = "
			SELECT * from empType
		";
		q.setSQL(sql);
		q.setDatasource(dsn.name);

		return q.execute().getResult();
	}

	public any function getEmployeeBatch() {
		var q = new Query();
		var sql = "
			SELECT * from empBatch
		";
		q.setSQL(sql);
		q.setDatasource(dsn.name);

		return q.execute().getResult();
	}


	public any function create(required string firstName ,required string lastName, required string typeID, required string batchID ,boolean status ="0") {
		var q = new Query();
		var sql = "
			INSERT INTO Employees (
				firstName
				,lastName
				,typeID
				,batchID
				,status
				)
				VALUES(
					:firstName
					,:lastName
					,:typeID
					,:batchID
					,:status
				)
		";
		q.addParam(name="firstName",value=arguments.firstName,cfsqltype="cf_sql_varchar");
		q.addParam(name="lastName",value=arguments.lastName,cfsqltype="cf_sql_varchar");
		q.addParam(name="typeID",value=arguments.typeID,cfsqltype="cf_sql_integer");
		q.addParam(name="batchID",value=arguments.batchID,cfsqltype="cf_sql_integer");
		q.addParam(name="status",value=arguments.status,cfsqltype="cf_sql_bit");
		q.setSQL(sql);
		q.setDatasource(dsn.name);

		return q.execute();
	}

	public any function update(required string ID ,string firstName, string lastName, string typeID, string batchID, boolean status) {
		var q = new Query();
		var sql = "
			UPDATE Employees SET
				firstName = :firstName
				,lastName = :lastName
				,typeID = :typeID
				,batchID = :batchID
				,status =:status
			 WHERE ID = :ID
		";
		q.addParam(name="ID",value=arguments.ID,cfsqltype="cf_sql_varchar");
		q.addParam(name="firstName",value=arguments.firstName,cfsqltype="cf_sql_varchar");
		q.addParam(name="lastName",value=arguments.lastName,cfsqltype="cf_sql_varchar");
		q.addParam(name="typeID",value=arguments.typeID,cfsqltype="cf_sql_integer");
		q.addParam(name="batchID",value=arguments.batchID,cfsqltype="cf_sql_integer");
		q.addParam(name="status",value=arguments.status,cfsqltype="cf_sql_bit");
		q.setSQL(sql);
		q.setDatasource(dsn.name);

		return q.execute();
	}

	public any function deleteEmployees(
		required string ID
		) {
		var q = new Query();
		var sql = "
			DELETE from Employees
			WHERE ID = :ID
		";
		q.addParam(name="ID",value=arguments.ID,cfsqltype="cf_sql_varchar");
		q.setSQL(sql);
		q.setDatasource(dsn.name);

		return q.execute();
	}

		public any function insertData(string batchName, date startdate){
		var q = new query();
		var sql = "INSERT INTO empbatch(batchName,startdate) values (:batchName,:startdate)";
		q.addParam(name="batchName",value=arguments.batchName,cfsqltype="cf_sql_varchar");
		q.addParam(name="startdate",value=arguments.startdate,cfsqltype="cf_sql_date");
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		return q.execute();
	}

	public any function selectData(){
		var q = new query();
		var sql = "select * from empbatch";
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		return q.execute().getResult();
	}

	public any function updateSelectdata(){
		var q = new Query();
		var sql = "SELECT * from empbatch WHERE id = :id";
		q.addParam(name="id",value=arguments.id,cfsqltype="cf_sql_integer");
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		return q.execute().getResult();
	}

	public any function updateData(required string id,string batchName, date startdate){
		var q = new Query();
		var sql = "UPDATE empBatch SET batchName = :batchName, startdate = :startdate WHERE id = :id";
		q.addParam(name="id",value=arguments.id,cfsqltype="cf_sql_integer");
		q.addParam(name="batchName",value=arguments.batchName,cfsqltype="cf_sql_varchar");
		q.addParam(name="startdate",value=arguments.startdate,cfsqltype="cf_sql_date");
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		return q.execute();
	}

	public any function deleteBatch(required string id){
		var q = new Query();
		var sql = "DELETE from empbatch WHERE id = :ID";
		q.addParam(name="ID",value=arguments.ID,cfsqltype="cf_sql_integer");
		q.setSQL(sql);
		q.setDatasource(dsn.name);
		return q.execute();
	}
}


