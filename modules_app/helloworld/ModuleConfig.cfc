/**
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component {

	// Module Properties
	this.title 				= "helloworld";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "@MODULE_DESCRIPTION@";
	// Model Namespace
	this.modelNamespace		= "helloworld";
	// CF Mapping
	this.cfmapping			= "helloworldMODULE_MAPPING@";
	// Dependencies
	this.dependencies 		= [];
	this.entryPoint 		= "helloworld";

	/**
	* Configure Module
	*/
	function configure(){
		settings = {

		};
		routes = [
			{pattern="/", handler="main", action="index", module="helloworld"},
			{pattern=":handler/:action?", module="helloworld"}
		];
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// writeDump("I'm from helloworld");abort;
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}
