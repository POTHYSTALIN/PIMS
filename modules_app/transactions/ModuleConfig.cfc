component {
	// Module Properties
	this.title 				= "transacions";
	this.author 			= "";
	this.webURL 			= "";
	this.description 		= "";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "transactions";
	// Inherit entry point from parent, so this will be /api/transactions
	this.inheritEntryPoint  = true;
	// Model Namespace
	this.modelNamespace		= "transactions";
	// CF Mapping
	this.cfmapping			= "transactions";
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
			.route( "", "transactions.index" )
			.route( "edit/:id-numeric", "transactions.addEdit" )
			.route( "update/:id-numeric", "transactions.update" )
			.route( "delete/:id-numeric", "transactions.delete" )
			.route( "report/:id-numeric", "transactions.reports" )

			.route( "banks/edit/:id-numeric", "banks.addEdit" )
			.route( "banks/update/:id-numeric", "banks.update" )
			.route( "banks/delete/:id-numeric", "banks.delete" )
			.route( "banks", "banks.index" )

			.route( "bank-accounts/edit/:id-numeric", "bankAccounts.addEdit" )
			.route( "bank-accounts/update/:id-numeric", "bankAccounts.update" )
			.route( "bank-accounts/delete/:id-numeric", "bankAccounts.delete" )
			.route( "bank-accounts", "bankAccounts.index" )

			.route( "categories/edit/:id-numeric", "categories.addEdit" )
			.route( "categories/update/:id-numeric", "categories.update" )
			.route( "categories/delete/:id-numeric", "categories.delete" )
			.route( "categories", "categories.index" )

			.route( "category-types/edit/:id-numeric", "categoryTypes.addEdit" )
			.route( "category-types/update/:id-numeric", "categoryTypes.update" )
			.route( "category-types/delete/:id-numeric", "categoryTypes.delete" )
			.route( "category-types", "categoryTypes.index" )

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
