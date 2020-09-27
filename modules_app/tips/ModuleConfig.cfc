component {
	// Module Properties
	this.title 				= "tips";
	this.author 			= "";
	this.webURL 			= "";
	this.description 		= "";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "tips";
	// Inherit entry point from parent, so this will be /api/tips
	this.inheritEntryPoint  = true;
	// Model Namespace
	this.modelNamespace		= "tips";
	// CF Mapping
	this.cfmapping			= "tips";
	// Auto-map models
	this.autoMapModels		= true;
	// Module Dependencies
	this.dependencies 		= [];

	function configure() {
		// parent settings
		parentSettings = {
		};

		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// SES Routes
		router
			.route( "", "tips.index" )
			.route( "markdown", "tips.preview" )
			.route( "preview", "tips.preview" )
			.route( ":id-numeric", "tips.preview" )
			.route( "edit/:id-numeric", "tips.addEdit" )
			.route( "update/:id-numeric", "tips.update" )
			.route( "delete/:id-numeric", "tips.delete" )
			.route( "undelete/:id-numeric", "tips.delete" )
			.route( "report/:id-numeric", "tips.reports" )

			.route( "tags/edit/:id-numeric", "tags.addEdit" )
			.route( "tags/update/:id-numeric", "tags.update" )
			.route( "tags/delete/:id-numeric", "tags.delete" )
			.route( "tags", "tags.index" )

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

	function postModuleLoad( event, interceptData, buffer, rc, prc ) {
		// writeDump("test");abort;
		// binder.map( "passwordManagerService@sysinfo" ).to( "#moduleMapping#.models.inventoryItemPropertyDetails" );
	}
}
