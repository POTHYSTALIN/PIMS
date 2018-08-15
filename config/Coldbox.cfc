component {
	public function configure() {

		coldbox = {
			// Application Setup
			appName = "MyApp_v0001",
			BaseURL = "http://final.myapp.com/",

			// Conventions
			eventName = "action",
			eventAction = "index",
			handlersLocation = "controllers",
			viewsLocation = "views",
			layoutsLocation = "layouts",
			modelsLocation = "model",
			modulesLocation = "modules",

			// Implicit Events
			defaultEvent			= "main.index",
			requestStartHandler		= "main.OnRequestStart",
			requestEndHandler		= "",
			applicationStartHandler = "",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			// Extension Points
			applicationHelper = "",
			viewsHelper = "",
			handlersExternalLocation = "controllers",

			// Error/Exception Handling
			exceptionHandler		= "main.onException",
			onInvalidEvent			= "",
			customErrorTemplate		= "/coldbox/system/includes/BugReport.cfm",

			// Development Settings
			reinitPassword			= "",

			// Application Aspects
			handlersIndexAutoReload = false,
			handlerCaching 			= false,
			eventCaching			= true
		};

		// Datasources
		datasources = {
			inoutcomes = { name="inoutcomes", dbType="", username="", password=""}
		};

		// Environments, check CGI.HTTP_HOST for string, $ matches end, ^ matches start
		environments = {
			production = "\.com$",
			development = "^127,^localhost,\.dev$"
		};

		interceptors = [
			//SES
			{class="coldbox.system.interceptors.SES"}
		];

		settings = {
			"globalConfigPath" = "/config/myconfig.xml"
		};

	};

	public function development() {

		coldbox.BaseURL = "http://final.myapp.dev/";
		coldbox.reinitpassword = "";
		coldbox.eventCaching = false;
		coldbox.handlerCaching = false;
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		coldbox.handlersIndexAutoReload = true;

		wirebox.singletonReload = true;
	}
}