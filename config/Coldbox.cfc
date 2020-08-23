component{
	// https://coldbox.ortusbooks.com/intro/introduction
	function configure(){
		coldbox = {
			// Application Setup
			appName = "MyApp_v0001",
			BaseURL = "https://final.myapp.com/",

			// Conventions
			eventName = "action",

			// These items moved into a separate struct in CB5
			// eventAction = "index",
			// handlersLocation = "controllers",
			// viewsLocation = "views",
			// layoutsLocation = "layouts",
			// modelsLocation = "model",
			// modulesLocation = "/modules",

			// modulesExternalLocation = [ "/modules_app" ],
			// modulesAutoReload = true,

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
			customErrorTemplate		= "/coldbox/system/exceptions/Whoops.cfm",

			// Development Settings
			reinitKey				= "reloadme",
			reinitPassword			= "pothys",
			caseSensitiveImplicitViews = true,

			// Application Aspects
			handlersIndexAutoReload = true,
			handlerCaching 			= false,
			eventCaching			= true
		};

		//Conventions
		conventions = {
			handlersLocation = "controllers",
			viewsLocation      = "views",
			layoutsLocation  = "layouts",
			modelsLocation      = "model",
			modulesLocation  = "modules",
			eventAction      = "index"
		};

		// Environments, check CGI.HTTP_HOST for string, $ matches end, ^ matches start
		environments = {
			production = "\.com$",
			development = "^127,^localhost,\.dev$,\.local$"
		};

		settings = {
			latestMyApp = { name="latestMyApp", dbType="", username="", password=""},
			globalConfigPath = "/config/myconfig.xml",
			modulesAutoReload = true
		};
	}

	public function development() {
		coldbox.BaseURL = "https://final.myapp.local/";
		coldbox.reinitpassword = "";
		coldbox.eventCaching = false;
		coldbox.handlerCaching = false;
		coldbox.customErrorTemplate = "/coldbox/system/exceptions/BugReport.cfm";
		coldbox.exceptionEditor = "vscode"; // This is default too
		coldbox.handlersIndexAutoReload = true;
		settings.latestMyApp = { name="latestMyApp_dev", dbType="", username="", password=""};

		wirebox.singletonReload = true;
	}
}