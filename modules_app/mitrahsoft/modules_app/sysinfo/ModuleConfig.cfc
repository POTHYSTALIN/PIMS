/**
Module Directives as public properties
this.title 				= "Title of the module";
this.author 			= "Author of the module";
this.webURL 			= "Web URL for docs purposes";
this.description 		= "Module description";
this.version 			= "Module Version";
this.viewParentLookup   = (true) [boolean] (Optional) // If true, checks for views in the parent first, then it the module.If false, then modules first, then parent.
this.layoutParentLookup = (true) [boolean] (Optional) // If true, checks for layouts in the parent first, then it the module.If false, then modules first, then parent.
this.entryPoint  		= "" (Optional) // If set, this is the default event (ex:forgebox:manager.index) or default route (/forgebox) the framework
									       will use to create an entry link to the module. Similar to a default event.
this.cfmapping			= "The CF mapping to create";
this.modelNamespace		= "The namespace to use for registered models, if blank it uses the name of the module."
this.dependencies 		= "The array of dependencies for this module"

structures to create for configuration
- parentSettings : struct (will append and override parent)
- settings : struct
- interceptorSettings : struct of the following keys ATM
	- customInterceptionPoints : string list of custom interception points
- interceptors : array
- layoutSettings : struct (will allow to define a defaultLayout for the module)
- routes : array Allowed keys are same as the addRoute() method of the SES interceptor.
- wirebox : The wirebox DSL to load and use

Available objects in variable scope
- controller
- appMapping (application mapping)
- moduleMapping (include,cf path)
- modulePath (absolute path)
- log (A pre-configured logBox logger object for this object)
- binder (The wirebox configuration binder)
- wirebox (The wirebox injector)

Required Methods
- configure() : The method ColdBox calls to configure the module.

Optional Methods
- onLoad() 		: If found, it is fired once the module is fully loaded
- onUnload() 	: If found, it is fired once the module is unloaded

*/
component {
	// Module Properties
	this.title 				= "sysinfo";
	this.author 			= "";
	this.webURL 			= "";
	this.description 		= "";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "sysinfo";
	// Inherit entry point from parent, so this will be /api/sysinfo
	this.inheritEntryPoint  = true;
	// Model Namespace
	this.modelNamespace		= "sysinfo";
	// CF Mapping
	this.cfmapping			= "sysinfo";
	// Auto-map models
	this.autoMapModels		= true;
	// Module Dependencies
	this.dependencies 		= [];

	function configure() {
		// parent settings
		parentSettings = {
		};

		// module settings - stored in modules.name.settings
		settings = {
			demo: "demo"
		};

		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// SES Routes
		router
			.route( "/", "main.index" )
			.route( "/list", "main.index" )
			.route( "/update/:id-numeric", "main.addEdit")
			.route( "/add", "main.addEdit")
			.route( "/items/delete/:id-numeric", "items.delete" )
			.route( "/items/delete", "items.delete" )
			.route( "/items/update/:id-numeric", "items.addEdit" )
			.route( "/items/update", "items.addEdit" )
			.route( "/items/edit/:id-numeric", "items.addEdit" )
			.route( "/items/add", "items.addEdit" )
			.route( "/items", "items.index" )
			.route( "/item-props/delete/:id-numeric", "properties.delete" )
			.route( "/item-props/delete", "properties.delete" )
			.route( "/item-props/update/:id-numeric", "properties.addEdit" )
			.route( "/item-props/update", "properties.addEdit" )
			.route( "/item-props/edit/:id-numeric", "properties.addEdit" )
			.route( "/item-props/add", "properties.addEdit" )
			.route( "/item-props", "properties.index" )
			.route( "/prop-details/delete/:id-numeric", "propertyDetails.delete" )
			.route( "/prop-details/delete", "propertyDetails.delete" )
			.route( "/prop-details/update/:id-numeric", "propertyDetails.addEdit" )
			.route( "/prop-details/update", "propertyDetails.addEdit" )
			.route( "/prop-details/edit/:id-numeric", "propertyDetails.addEdit" )
			.route( "/prop-details/add", "propertyDetails.addEdit" )
			.route( "/prop-details", "propertyDetails.index" )
			.route( "/item-purchases", "purchases.index" )
			.route( "/item-problems", "problems.index" )
			.route( "/:handler/:action" ).end();

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		// Custom Declared Interceptors
		interceptors = [];
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad() {
		// writeDump(this);abort;
		// moduleAssetsPath = this.entryPoint;
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload() {
	}
}
