component output="false" {
	property name="dsn" inject="coldbox:datasource:latestMyApp";

	public function init(){
		return this;
	}

	public void function addEvents(
		required string name,
		required string desc,
		required string sdate,
		required string edate
	){
		local.sqlString = "INSERT INTO events( name, [desc], sdate, edate ) VALUES( :name, :desc, :sdate, :edate )";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );
		local.qry.addParam(name="name", value="#arguments.name#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="desc", value="#arguments.desc#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="sdate", value="#arguments.sdate#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="edate", value="#arguments.edate#", cfsqltype="cf_sql_timestamp", null="#yesnoformat(!len(arguments.edate))#");
		local.qry.execute();
	}

	public query function getEvents( numeric id ){
		local.sqlString = "SELECT * FROM events WHERE 1 = 1 ";

		if(structKeyExists(arguments, "id")){
			local.sqlString &= "AND id = #arguments.id# ";
		}

		local.qry = new query( datasource = dsn.name, sql = local.sqlString );
		return local.qry.execute().getResult();
	}


	public void function updateEvents(
		required string name,
		required string desc,
		required string sdate,
		required string edate,
		required numeric id
	) {

		local.qry = new query(
			datasource = dsn.name,

			sql = "UPDATE events SET name = :name, [desc] = :desc,sdate=:sdate,edate=:edate WHERE id = :id"
		);
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="name", value="#arguments.name#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="desc", value="#arguments.desc#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="sdate", value="#arguments.sdate#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="edate", value="#arguments.edate#", cfsqltype="cf_sql_timestamp", null="#yesnoformat(!len(arguments.edate))#");

		local.qry.execute();

	}

	public void function deleteEvent( required numeric id ){
		local.qry = new query( datasource = dsn.name, sql = "DELETE FROM events WHERE id = :id" );
		local.qry.addParam(name="id", value="#arguments.id#", cfsqltype="cf_sql_integer");
		local.qry.execute();
	}

	public query function getNotifications( boolean showAll = true ) {
		local.sqlString = "
			with qry as (
				SELECT
					id, name, [desc], sdate, edate, 'events' as type
				FROM events
				WHERE 1 = 1
		";
		if(!arguments.showAll){
			local.sqlString &="
				AND sdate > DATEADD(day, -1, getDate())
				AND (
					edate < DATEADD(day, 1, getDate())
					OR edate IS NULL
				)
			";
		}
		local.sqlString &="
			)

			SELECT * FROM qry
			ORDER BY type, sdate, edate
		";
		local.qry = new query( datasource = dsn.name, sql = local.sqlString );

		return local.qry.execute().getResult();
	}
}