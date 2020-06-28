<cfcomponent singleton="true">
	<cfproperty name="dsn" inject="coldbox:setting:latestMyApp">

	<cffunction name="init" returntype="Any">
		<cfreturn this>
	</cffunction>

	<cffunction name="getCategories" access="public" returntype="Query" output="false">
		<cfargument name="ID" type="string" required="false">
		<cfargument name="includeDeleted" type="string" required="false" default="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT
				TC.ID, TC.name, TC.deleted, TC.parentID,
				TT.name AS Type, TT.ID AS TypeID
			FROM transactionCategories TC
				INNER JOIN transactionTypes TT ON TC.typeID = TT.ID
			WHERE 1 = 1
				<cfif structKeyExists(arguments, "ID")>
					AND TC.ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif NOT arguments.includeDeleted>
					AND TC.deleted = 0
				</cfif>
			ORDER BY TC.deleted ASC
		</cfquery>

		<cfreturn local.qry>
	</cffunction>

	<cffunction name="newCategory" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true">
		<cfargument name="type" type="numeric" required="true">
		<cfargument name="parentID" type="numeric" required="true">
		<cfargument name="deleted" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			INSERT INTO transactionCategories( name, typeID, parentID, deleted )
			VALUES( '#arguments.name#', #arguments.type#, #arguments.parentID#, #arguments.deleted# )
		</cfquery>
	</cffunction>

	<cffunction name="updateCategory" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="type" type="numeric" required="true">
		<cfargument name="parentID" type="numeric" required="true">
		<cfargument name="deleted" type="any" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactionCategories SET
				name = '#arguments.name#',
				typeID = #arguments.type#,
				parentID = #arguments.parentid#,
				deleted = #arguments.deleted#,
				updated = getDate()
			WHERE ID = #arguments.ID#
		</cfquery>
	</cffunction>

	<cffunction name="deleteCategory" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactionCategories
			SET
				Deleted = 1,
				updated = getDate()
			WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="hardDeleteCategory" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			DELETE FROM transactionCategories
			WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>


	<!--- ======================================================================== --->
	<!--- =========================== category types ============================= --->
	<!--- ======================================================================== --->
	<cffunction name="getCategoryTypes" access="public" returntype="Query" output="false">
		<cfargument name="ID" type="string" required="false">
		<cfargument name="includeDeleted" type="string" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT * FROM transactionTypes
			WHERE 1 = 1
			<cfif structKeyExists(arguments, "ID")>
				AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif NOT structKeyExists(arguments, "includeDeleted")>
				AND deleted = 0
			</cfif>
		</cfquery>

		<cfreturn local.qry>
	</cffunction>

	<cffunction name="newCategoryType" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true">
		<cfargument name="deleted" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			INSERT INTO transactionTypes( name, deleted )
			VALUES( '#arguments.name#', #arguments.deleted# )
		</cfquery>
	</cffunction>

	<cffunction name="updateCategoryType" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="deleted" type="any" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactionTypes SET
				name = '#arguments.name#',
				deleted = #arguments.deleted#,
				updated = getDate()
			WHERE ID = #arguments.ID#
		</cfquery>
	</cffunction>

	<cffunction name="deleteCategoryType" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactionTypes
			SET
				Deleted = 1,
				updated = getDate()
			WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="hardDeleteCategoryType" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			DELETE FROM transactionTypes
			WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>
</cfcomponent>