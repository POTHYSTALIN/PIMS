component extends="coldbox.system.EventHandler" {
	// property name="router" inject="router@coldbox";
	function index( event, rc, prc ){
		// business logics goes here
		// event.noLayout();
		// event.setView(view="main/index", noLayout=true);
		event.setLayout("main");
	}

	function demo( event, rc, prc ){
		// business logics goes here
		event.setLayout("main");
	}

	/* --------------------- PRIVATE EVENTS ----------------------------- */
	public function onRequestStart( event, rc, prc ) {
		// List of pages, can be accessed without logged in.
		local.WhiteList = [
			"security.login",
			"security.doLogin",
			"security.signup",
			"security.doSignup",
			"login",
			"logout"
		];
		// writeDump(event.getCurrentModule());abort;

		// writeDump(event.isSES());
		// writeDump(getSetting("htmlBaseURL"));
		// writeDump(event);abort;
		// writeDump(router);abort;
		if( NOT structKeyExists(session, "userID") AND NOT ArrayFindNoCase( local.WhiteList, rc.action )){
			rc.msgAction = "Error";
			rc.msg = "Please try after login";
			setNextEvent(event = 'login', persist = "msg,msgAction");
		}

		local.BlackList = [
			"security.login"
		];

		if (structKeyExists(session, "userID") AND ArrayFindNoCase( local.BlackList, rc.action )){
			setNextEvent(event = 'home');
		}
	}

	public function onException(event,rc,prc){
	}
}