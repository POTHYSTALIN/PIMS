<cfcomponent singleton="true">
	<cfproperty name="dsn" inject="coldbox:setting:PIMS">

	<cffunction name="init" returntype="Any">
		<cfreturn this>
	</cffunction>

	<cffunction name="getBanks" access="public" returntype="query" output="false">
		<cfargument name="ID" type="string" required="false">
		<cfargument name="includeDeleted" type="boolean" required="false" default="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT b.*
			FROM banks b
			WHERE 1 = 1
				<cfif structKeyExists(arguments, "ID")>
					AND b.ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif NOT arguments.includeDeleted>
					AND b.deleted = 0
				</cfif>
			ORDER BY b.deleted ASC
		</cfquery>

		<cfreturn local.qry>
	</cffunction>

	<cffunction name="newBank" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true">
		<cfargument name="shortname" type="string" required="true">
		<cfargument name="deleted" type="boolean" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			INSERT INTO banks( name, shortname, deleted )
			VALUES( '#arguments.name#', '#arguments.shortname#', #arguments.deleted# )
		</cfquery>
	</cffunction>

	<cffunction name="updateBank" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="shortname" type="string" required="true">
		<cfargument name="deleted" type="boolean" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE banks SET
				name = '#arguments.name#',
				shortname = '#arguments.shortname#',
				deleted = #arguments.deleted#,
				updated = getDate()
			WHERE ID = #arguments.ID#
		</cfquery>
	</cffunction>

	<cffunction name="deleteBank" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE banks
			SET
				Deleted = 1,
				updated = getDate()
			WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="hardDeleteBank" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			DELETE FROM banks
			WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="getBankAccounts" access="public" returntype="query" output="false">
		<cfargument name="ID" type="numeric" required="false">
		<cfargument name="personID" type="numeric" required="false">
		<cfargument name="includeDeleted" type="boolean" required="false" default="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT
				ba.ID, ba.accountID, ba.bankID, ba.personID, ba.deleted, ba.tracked,
				b.name, b.shortname, concat(p.fname, ' ', p.lname) as personName
			FROM bankAccounts ba
				INNER JOIN banks b ON ba.bankID = b.ID
				INNER JOIN persons p ON ba.personID = p.ID
			WHERE 1 = 1
				<cfif structKeyExists(arguments, "ID")>
					AND ba.ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif structKeyExists(arguments, "personID")>
					AND ba.personID = <cfqueryparam value="#arguments.personID#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif NOT arguments.includeDeleted>
					AND ba.deleted = 0
				</cfif>
			ORDER BY ba.deleted ASC
		</cfquery>

		<cfreturn local.qry>
	</cffunction>

	<cffunction name="newBankAccount" access="public" returntype="void" output="false">
		<cfargument name="bankID" type="numeric" required="true">
		<cfargument name="accountID" type="string" required="true" hint="original bank account number">
		<cfargument name="personID" type="numeric" required="true">
		<cfargument name="deleted" type="boolean" required="false" default="false">
		<cfargument name="tracked" type="boolean" required="false" default="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			INSERT INTO bankAccounts( bankID, accountID, personID, deleted, tracked )
			VALUES( #arguments.bankID#, '#arguments.accountID#', #arguments.personID#, #arguments.deleted#, #arguments.tracked# )
		</cfquery>
	</cffunction>

	<cffunction name="updateBankAccount" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">
		<cfargument name="bankID" type="numeric" required="true">
		<cfargument name="accountID" type="string" required="true" hint="original bank account number">
		<cfargument name="personID" type="numeric" required="true">
		<cfargument name="deleted" type="boolean" required="false" default="false">
		<cfargument name="tracked" type="boolean" required="false" default="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE bankAccounts SET
				bankID = #arguments.bankID#,
				accountID = '#arguments.accountID#',
				personID = #arguments.personID#,
				deleted = #arguments.deleted#,
				tracked = #arguments.tracked#,
				updated = getDate()
			WHERE ID = #arguments.ID#
		</cfquery>
	</cffunction>

	<cffunction name="deleteBankAccount" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE bankAccounts
			SET
				deleted = 1,
				updated = getDate()
			WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="hardDeleteBankAccount" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			DELETE FROM bankAccounts
			WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>
</cfcomponent>