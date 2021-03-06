<cfcomponent output="false">
	<cfproperty name="globalConfigPath" inject="coldbox:setting:globalConfigPath">

	<cffunction name="getDataFromQuery" access="public" returntype="query" hint="provides qoq functionality through a function">
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

	<cffunction name="getGlobalConfigs" access="public" returntype="Struct" output="false" hint="Reads an xml file and parses it as struct">
		<cffile action="read" file="#expandPath(globalConfigPath)#" variable="xmlContent">

		<cfset local.xmlObj = xmlParse(xmlContent, true)>
		<cfset local.allConfigs = xmlSearch(xmlObj, "configs/config")>
		<cfset local.resConfigs = {}>

		<cfloop array="#allConfigs#" index="currConfig">
			<cfset structAppend(resConfigs, parseXMLObject(currConfig), true)>
		</cfloop>

		<cfreturn resConfigs>
	</cffunction>

	<cffunction name="parseXMLObject" access="private" returntype="struct" output="false" hint="parses the given xml object and creates a struct. If there is some nested xml objects found, then this function will be called again.">
		<cfargument name="xmlObject" type="xml" required="true">

		<cfset local.tempObj = duplicate(arguments.xmlObject)>
		<cfset local.res = {}>

		<cfif structFind(tempObj.xmlAttributes, "type") EQ "string">
			<cfset res[structFind(tempObj.xmlAttributes, "name")] = tempObj.xmlText>
		<cfelseif structFind(tempObj.xmlAttributes, "type") EQ "struct">
			<cfset res[structFind(tempObj.xmlAttributes, "name")] = {}>
			<cfloop array="#tempObj.xmlChildren#" index="currChild">
				<cfset structAppend(res[structFind(tempObj.xmlAttributes, "name")], parseXMLObject(currChild), true)>
			</cfloop>
		</cfif>

		<cfreturn res>
	</cffunction>

	<cffunction name="queryToJSON" access="public" returntype="array" returnformat="JSON" output="false" hint="I'll create a JSON ( array of objects ) from a query">
		<cfargument name="iQuery" type="query" required="true">
		<cfargument name="colList" type="string" required="false" default="" hint="if no columns are mentioned, all columns will be included">

		<cfset local.res = "">
		<cfif NOT len(trim(arguments.colList))>
			<!--- <cfset arguments.colList = arguments.iQuery.ColumnList> --->
			<!--- TODO :: Seems getColumnlist is a hidden function in Lucee/Railo --->
			<cfset arguments.colList = arguments.iQuery.getColumnlist(false)>
		</cfif>
		<cfset local.tmpArray = []>
		<cfloop query="arguments.iQuery">
			<cfset local.tmpStruct = {}>
			<cfloop list="#arguments.colList#" index="currCol">
				<cfset structInsert(local.tmpStruct, currCol, arguments.iQuery[currCol][currentRow])>
			</cfloop>
			<cfset arrayAppend(local.tmpArray, local.tmpStruct)>
		</cfloop>

		<cfreturn local.tmpArray>
	</cffunction>
</cfcomponent>