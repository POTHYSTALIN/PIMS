component{
	// https://coldbox.ortusbooks.com/intro/introduction
	function configure(){
		coldbox = {
			// Application Setup
			appName = "MyApp_v0001",
			BaseURL = "http://final.myapp.com/",

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
			customErrorTemplate		= "/coldbox/system/includes/BugReport.cfm",

			// Development Settings
			reinitPassword			= "",
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
			layoutsLocation  = "views",
			modelsLocation      = "model",
			modulesLocation  = "modules",
			eventAction      = "index"
		};
	}
}