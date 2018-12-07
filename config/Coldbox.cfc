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
			modulesLocation = "/modules",
			modulesExternalLocation = [ "/modules_app" ],
			modulesAutoReload = true,

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
			// handlersExternalLocation = "controllers",

			// Error/Exception Handling
			exceptionHandler		= "main.onException",
			onInvalidEvent			= "",
			customErrorTemplate		= "/coldbox/system/includes/BugReport.cfm",

			// Development Settings
			reinitPassword			= "",
			caseSensitiveImplicitViews = true,

			// Application Aspects
			handlersIndexAutoReload = false,
			handlerCaching 			= false,
			eventCaching			= true
		};

		conventions = {
			handlersLocation = "controllers",
			pluginsLocation = "plugins",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modulesLocation	 = "modules"
		};

		// Datasources
		datasources = {
			latestMyApp = { name="latestMyApp", dbType="", username="", password=""}
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
			"globalConfigPath" = "/config/myconfig.xml",
			modulesAutoReload = true
		};

		modules = {
			// Will auto reload the modules in each request. Great for development but can cause some loading/re-loading issues
			autoReload = true,
			// An array of modules to load ONLY
			include = [],
			// An array of modules to EXCLUDE for operation
			exclude = [ "paidModule1", "paidModule2" ]
		};

	};

	public function development() {

		coldbox.BaseURL = "http://final.myapp.dev/";
		coldbox.reinitpassword = "";
		coldbox.eventCaching = false;
		coldbox.handlerCaching = false;
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		coldbox.handlersIndexAutoReload = true;
		datasources = {
			latestMyApp = { name="latestMyApp_dev", dbType="", username="", password=""}
		};

		wirebox.singletonReload = true;
	}
}