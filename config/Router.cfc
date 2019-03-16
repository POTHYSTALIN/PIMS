// Inherits from Router and FrameworkSuperType
component {

    function configure(){
        // Turn on Full URL Rewrites, no index.cfm in the URL
        setFullRewrites( true );
        
        // Routing by Convention
        // route( "/blog/:year-numeric{4}/:month?/:day?" ).to( "blog.list" );
        route( "/login" ).to( "security.login" );
        route( "/logout" ).to( "security.logout" );
        route( "/signup" ).to( "security.signup" );
        route( "/home" ).to( "main.index" );
        route( "/demo" ).to( "main.demo" );
        route( "/:handler/:action?" ).end();
        
    }
    
}