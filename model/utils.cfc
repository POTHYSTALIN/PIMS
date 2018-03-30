<cfcomponent output="false">
	<cffunction name="getDataFromQuery" access="public" returntype="Query" hints="provides qoq functionality through a function">
		<cfargument name="mainQry" type="query" required="true">
		<cfargument name="sClause" type="string" required="false" default="*">
		<cfargument name="wClause" type="string" required="false" default="">
		<cfargument name="oClause" type="string" required="false" default="">

		<cfset local.sqlString = "SELECT #arguments.sClause# FROM arguments.mainQry ">
		<cfif len(arguments.wClause)>
			<cfset local.sqlString &= "WHERE 1 = 1 " & arguments.wClause>
		</cfif>
		<cfif len(arguments.oClause)>
			<cfset local.sqlString &= " ORDER BY " & arguments.oClause>
		</cfif>
		<cfquery name="local.qry" dbtype="query">
			#toString(local.sqlString)#
		</cfquery>

		<cfreturn local.qry>
	</cffunction>
</cfcomponent>