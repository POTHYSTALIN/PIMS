component output="false" {
	property name="dsn" inject="coldbox:datasource:inoutcomes";

	public function init(){
		return this;
	}

	public void function addEvents(
		required string eventName,
		required string description,
		required string eventStartDate,
		required string eventEndDate
	){
		local.qry = new query(
			datasource = dsn.name,
			sql = "
				INSERT INTO events(
					event_name,
					event_desc,
					start_date,
					end_date
				)
				VALUES(
					:eventName,
					:description,
					:eventStartDate,
					:eventEndDate
				)
			"
		);
		local.qry.addParam(name="eventName", value="#arguments.eventName#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="description", value="#arguments.description#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="eventStartDate", value="#arguments.eventStartDate#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="eventEndDate", value="#arguments.eventEndDate#", cfsqltype="cf_sql_timestamp", null="#yesnoformat(!len(arguments.eventEndDate))#");
// writeDump(arguments);abort;
		local.qry.execute();
	}

	public query function getEvents(EVENTID){
		local.sqlString = "SELECT * FROM events WHERE 1 = 1 ";

		if(structKeyExists(arguments, "EVENTID")){
			local.sqlString = "SELECT * FROM events WHERE event_id = #arguments.EVENTID# ";
		}

		local.qry = new query(
			datasource = dsn.name,
			sql = local.sqlString
		);
		// var eventsRes= serializeJSON(local.qry.execute().getResult());
		return local.qry.execute().getResult();
	}


	public any function updateEvents(required string eventName,required string description,required string eventStartDate,
		required string eventEndDate,required event_id) {

		local.qry = new query(
			datasource = dsn.name,

			sql = "UPDATE events SET event_name = :eventName, event_desc = :description,start_date=:eventStartDate,end_date=:eventEndDate WHERE event_id = :event_id"
		);
		local.qry.addParam(name="event_id", value="#arguments.event_id#", cfsqltype="cf_sql_integer");
		local.qry.addParam(name="eventName", value="#arguments.eventName#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="description", value="#arguments.description#", cfsqltype="cf_sql_varchar");
		local.qry.addParam(name="eventStartDate", value="#arguments.eventStartDate#", cfsqltype="cf_sql_timestamp");
		local.qry.addParam(name="eventEndDate", value="#arguments.eventEndDate#", cfsqltype="cf_sql_timestamp", null="#yesnoformat(!len(arguments.eventEndDate))#");

		local.qry.execute();

	}
}