<cfcomponent singleton="true">
	<cfproperty name="dsn" inject="coldbox:datasource:inoutcomes">

	<cffunction name="init" returntype="Any">
		<cfreturn this>
	</cffunction>

	<cffunction name="authenticateLogin" access="public" returntype="query" output="false">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT * FROM Persons P
			WHERE 1 = 1
				AND deleted = 0
				AND username = <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">
				AND password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfreturn local.qry />
	</cffunction>

	<cffunction name="getPersons" access="public" returntype="query" output="false">
		<cfargument name="ID" type="string" required="false">
		<cfargument name="includeDeleted" type="boolean" required="false" default="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT P.*, concat(P.fname, ' ', P.lname) as personName
			FROM persons P
			WHERE 1 = 1
				<cfif structKeyExists(arguments, "ID")>
					AND P.ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif NOT arguments.includeDeleted>
					AND P.deleted = 0
				</cfif>
			ORDER BY P.deleted ASC
		</cfquery>

		<cfreturn local.qry>
	</cffunction>
</cfcomponent>