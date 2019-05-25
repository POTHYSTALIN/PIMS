<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	10/16/2007
Description :
	This is the Application.cfc for usage withing the ColdBox Framework.
	Make sure that it extends the coldbox object:
	coldbox.system.Coldbox

	So if you have refactored your framework, make sure it extends coldbox.
----------------------------------------------------------------------->
<cfcomponent output="false">
	<cfsetting enablecfoutputonly="yes">
	<!--- APPLICATION CFC PROPERTIES --->
	<cfscript>
		this.name = "PIMS_" & hash(getCurrentTemplatePath()) & "_aaa"; // name of the application context

		// scope handling
		// lifespan of a untouched application scope
		this.applicationTimeout = createTimeSpan( 1, 0, 20, 0 ); 
		
		// session handling enabled or not
		this.sessionManagement = true; 
		// untouched session lifespan
		this.sessionTimeout = createTimeSpan( 1, 0, 10, 0 );

		// request
		// max lifespan of a running request
		this.requestTimeout=createTimeSpan(0,0,2,50);
	</cfscript>

	<!--- COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP --->
	<cfset COLDBOX_APP_ROOT_PATH = getDirectoryFromPath(getCurrentTemplatePath())>
	<!--- The web server mapping to this application. Used for remote purposes or static purposes --->
	<cfset COLDBOX_APP_MAPPING   = "">
	<!--- COLDBOX PROPERTIES --->
	<cfset COLDBOX_CONFIG_FILE = "">
	<!--- COLDBOX APPLICATION KEY OVERRIDE --->
	<cfset COLDBOX_APP_KEY = "">

	<cfscript>
		// THE LOCATION OF EMBEDDED COLDBOX
		this.mappings["/coldbox"] = COLDBOX_APP_ROOT_PATH & "coldbox/";
		this.customTagPaths = COLDBOX_APP_ROOT_PATH & "/views/customTags";
	</cfscript>

	<!--- on Application Start --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfscript>	
			//Load ColdBox
			application.cbBootstrap = CreateObject("component","coldbox.system.Bootstrap").init(COLDBOX_CONFIG_FILE,COLDBOX_APP_ROOT_PATH,COLDBOX_APP_KEY,COLDBOX_APP_MAPPING);
			application.cbBootstrap.loadColdbox();
			return true;
		</cfscript>
	</cffunction>

	<!--- on Request Start --->
	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<!--- ************************************************************* --->
		<cfargument name="targetPage" type="string" required="true" />
		<!--- ************************************************************* --->
		
		<!--- request decorations --->
		<cfset request.assetsPath = "/assets">
		<cfset request.bootstrapPath = request.assetsPath & "/vendor/bootstrap-4.2.1-dist">

		<cfset application.cbBootstrap.onRequestStart( arguments.targetPage )>
		<cfreturn true>
	</cffunction>

	<!--- on Application End --->
	<cffunction name="onApplicationEnd" returnType="void"  output="false">
		<!--- ************************************************************* --->
		<cfargument name="appScope" type="struct" required="true">
		<!--- ************************************************************* --->
		<cfset arguments.appScope.cbBootstrap.onApplicationEnd(argumentCollection=arguments)>
		<!--- WHATEVER YOU WANT BELOW --->
	</cffunction>

	<!--- on Session Start --->
	<cffunction name="onSessionStart" returnType="void" output="false">
		<cfscript>
			lock name="#application.cbBootstrap.getAppHash()#" timeout="60" type="readonly" {
				application.cbBootStrap.onSessionStart();
			}
		</cfscript>
		<!--- WHATEVER YOU WANT BELOW --->
	</cffunction>

	<!--- on Session End --->
	<cffunction name="onSessionEnd" returnType="void" output="false">
		<!--- ************************************************************* --->
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" 	type="struct" required="false">
		<!--- ************************************************************* --->
		<cfscript>
			lock name="#arguments.appScope.cbBootstrap.getAppHash()#" timeout="60" type="readonly" {
				arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
			}
		</cfscript>
		<!--- WHATEVER YOU WANT BELOW --->
	</cffunction>

	<!--- OnMissing Template --->
	<cffunction	name="onMissingTemplate" access="public" returntype="boolean" output="true" hint="I execute when a non-existing CFM page was requested.">
		<cfargument name="template"	type="string" required="true"	hint="I am the template that the user requested."/>
		<cfreturn application.cbBootstrap.onMissingTemplate(argumentCollection=arguments)>
	</cffunction>

	<cffunction name="onError" access="public" returntype="void" output="true" hint="I show the error page">
		<cfargument name="Except" required="true" />
		<cfargument name="EventName" type="String" required="true" />

		<cfoutput>Oops, an error occured</cfoutput>
		<cfdump var="#arguments#" label="debug_info" /><cfabort />
	</cffunction>
</cfcomponent>