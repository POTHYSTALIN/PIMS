<cfcomponent>
	<!--- <cfproperty name="boxKey" inject="coldbox:setting:boxAPI"> --->
	<cfset variables.apiURLs = {}>
	<cfset variables.apiURLs["getFolder"] = "https://api.box.com/2.0/folders/">
	<cfset variables.apiURLs["downloadFile"] = "https://api.box.com/2.0/files">
	<cfset variables.apiURLs["uploadFile"] = "https://upload.box.com/api/2.0/files/content">
	<cfset variables.apiURLs["deleteFile"] = "https://api.box.com/2.0/files/">
	<cffunction name="init" access="public" returntype="box">
		<!--- <cfargument name="devToken" type="string" required="true"> --->
<!--- <cfdump var="#boxKey#" /><cfabort /> --->
		<cfset variables.devToken = "">
		<cfset variables.clientID = "">
		<cfset variables.clientSecret = "">
		<cfset variables.redirectURI = "http://localhost:8501/boxAPI/getToken.cfm">
		<cfreturn this>
	</cffunction>

	<cffunction name="getFolder" access="public" returntype="struct">
		<cfargument name="id" type="string" required="true">

		<cfset local.res = {"hasError": false,"errorMsg": ""}>

		<cfhttp url="#variables.apiURLs["getFolder"]##arguments.id#" result="local.result" charset="utf-8">
			<cfhttpparam type="header" name="Authorization" value="Bearer #variables.devToken#" />
		</cfhttp>
		<cfif result.Statuscode EQ "200 OK">
			<cfset local.res.data = deserializeJSON(result.filecontent).item_collection.entries>
		<cfelse>
			<cfset local.res.hasError = true>
			<cfset local.res.errorMsg = local.result.errorDetail>
		</cfif>

		<cfreturn local.res>
	</cffunction>

	<cffunction name="getRoot" access="public" returntype="struct">
		<cfreturn getFolder( id = "0" )>
	</cffunction>

	<cffunction name="downloadFile" access="public" returntype="struct">
		<cfargument name="fileID" type="string" required="true">
		<cfargument name="fileType" type="string" required="false" default="json" hint="possible values are [json,txt,image,pdf,zip]">
		<cfhttp url="#variables.apiURLs["downloadFile"]#/#fileID#/content" result="local.result">
			<cfhttpparam type="header" name="Authorization" value="Bearer #variables.devToken#" />
		</cfhttp>

		<cfreturn local.result>
	</cffunction>

	<cffunction name="uploadFile" access="public" returntype="boolean">
		<cfargument name="filename" type="string" required="true">
		<cfargument name="folderID" type="string" required="true">
		<cfargument name="content" type="string" required="true">

		<cfset deleteFile( filename = arguments.filename, folderID = folderID )>

		<cfset local.dir = getDirectoryFromPath(expandPath("/")) & "assets/uploads/tmp/">
		<cfif NOT directoryExists(local.dir)>
			<cfdirectory action="create" directory="#local.dir#">
		</cfif>

		<cffile action="write" file="#local.dir##filename#" output="#content#">

		<cfhttp url="#variables.apiURLs["uploadFile"]#" result="local.result" multipart="true" method="post">
			<cfhttpparam type="header" name="Authorization" value="Bearer #variables.devToken#" />
			<cfhttpparam type="formfield" name="attributes" value='{"name":"#filename#", "parent":{"id":"0"}}' />
			<cfhttpparam type="file" name="file" file="#local.dir##filename#">
		</cfhttp>

		<cfreturn local.result.statusCode EQ "201 Created">
	</cffunction>

	<cffunction name="deleteFile" access="private" returntype="boolean">
		<cfargument name="filename" type="string" required="true">
		<cfargument name="folderID" type="string" required="true">

		<cfhttp url="#variables.apiURLs["getFolder"]##arguments.folderID#" result="local.folder" charset="utf-8">
			<cfhttpparam type="header" name="Authorization" value="Bearer #variables.devToken#" />
		</cfhttp>

		<cfset fileID = structFindValue(deserializeJSON(folder.filecontent), arguments.filename, "one")[1].owner.id>
<!--- <cfdump var="#deserializeJSON(folder.filecontent)#" /><cfabort /> --->
		<cfhttp url="https://api.box.com/2.0/files/#fileID#" result="local.result" method="delete">
			<cfhttpparam type="header" name="Authorization" value="Bearer #variables.devToken#" />
			<cfhttpparam type="formfield" name="attributes" value='{"parent":{"id":"#folderID#"}}' />
		</cfhttp>

		<cfreturn local.result.statusCode EQ "204 No Content">
	</cffunction>
</cfcomponent>