<cfcomponent singleton="true">
	<cfproperty name="dsn" inject="coldbox:setting:PIMS">

	<cffunction name="init" access="public" returntype="categories">
		<cfreturn this>
	</cffunction>

	<cffunction name="getCategories" access="public" returntype="Query" output="false">
		<cfargument name="ID" type="string" required="false">
		<cfargument name="includeDeleted" type="string" required="false" default="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT
				tc.ID, tc.name, tc.deleted, tc.parentId, tc.sortBy,
				tt.name AS Type, tt.ID AS TypeID
			FROM transactionCategories tc
				INNER JOIN transactionTypes tt ON tc.typeID = tt.ID
			WHERE 1 = 1
				<cfif structKeyExists(arguments, "ID")>
					AND tc.ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif NOT arguments.includeDeleted>
					AND tc.deleted = 0
				</cfif>
			ORDER BY tc.deleted, tc.sortBy, tc.name ASC
		</cfquery>

		<cfreturn local.qry>
	</cffunction>

	<cffunction name="newCategory" access="public" returntype="void" output="false">
		<cfargument name="name" type="string" required="true">
		<cfargument name="type" type="numeric" required="true">
		<cfargument name="parentId" type="numeric" required="true">
		<cfargument name="deleted" type="numeric" required="true">

		<cfquery datasource="#dsn.name#">
			INSERT INTO transactionCategories( name, typeID, parentId, sortBy, deleted )
			VALUES(
				<cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#arguments.type#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#arguments.sortBy#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#arguments.deleted#" cfsqltype="cf_sql_bit" />
			)
		</cfquery>
	</cffunction>

	<cffunction name="updateCategory" access="public" returntype="void" output="false">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="type" type="numeric" required="true">
		<cfargument name="parentId" type="numeric" required="true">
		<cfargument name="sortBy" type="numeric" required="true">
		<cfargument name="deleted" type="any" required="true">

		<cfquery datasource="#dsn.name#">
			UPDATE transactionCategories SET
				name       = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar" />,
				typeID     = <cfqueryparam value="#arguments.type#" cfsqltype="cf_sql_integer" />,
				parentId   = <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer" />,
				sortBy     = <cfqueryparam value="#arguments.sortBy#" cfsqltype="cf_sql_integer" />,
				deleted    = <cfqueryparam value="#arguments.deleted#" cfsqltype="cf_sql_integer" />,
				updated    = getDate()
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>

	<cffunction name="deleteCategory" access="public" returntype="void" output="false">
		<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#dsn.name#">
			UPDATE transactionCategories
			SET deleted = 1,
				updated = getDate()
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="hardDeleteCategory" access="public" returntype="void" output="false">
		<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#dsn.name#">
			DELETE FROM transactionCategories
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>


	<!--- Transaction Modes --->
	<cffunction name="getTransactionModes" access="public" returntype="query" output="false">
		<cfargument name="id" type="string" required="false">
		<cfargument name="includeDeleted" type="boolean" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT id, name FROM transactionModes
			WHERE 1 = 1
			<cfif structKeyExists(arguments, "id")>
				AND id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif NOT structKeyExists( arguments, "includeDeleted" )>
				AND deleted = 0
			</cfif>
		</cfquery>

		<cfreturn local.qry>
	</cffunction>


	<!--- ======================================================================== --->
	<!--- =========================== category types ============================= --->
	<!--- ======================================================================== --->
	<cffunction name="getCategoryTypes" access="public" returntype="query" output="false">
		<cfargument name="id" type="string" required="false">
		<cfargument name="includeDeleted" type="string" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT * FROM transactionTypes
			WHERE 1 = 1
			<cfif structKeyExists(arguments, "id")>
				AND id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
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