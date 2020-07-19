// Inherits from Router and FrameworkSuperType
component {
	function configure() {
		// Turn on Full URL Rewrites, no index.cfm in the URL
		setFullRewrites( true );
		setBaseURL("https://final.myapp.local");

		// Common named routes
		addRoute(pattern="/login", handler="security", action="login");
		// route( "/login", "security.login", "login" );

		route( "/logout" ).to( "security.logout" );
		route( "/signup" ).to( "security.signup" );
		route( "/home" ).to( "main.index" );
		route( "/demo" ).to( "main.demo" );

		// Routing by Convention
		route( "/:handler/:action?" ).end();
	}
}