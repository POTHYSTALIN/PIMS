component extends="base" {
	public function index( event, rc, prc ){
		// var a = controller.getModuleService();
		// a.activateAllModules();
		// writeDump(a.getLoadedModules());abort;
	}

	public function password( event, rc, prc ){
	}
	/* --------------------- PRIVATE EVENTS ----------------------------- */

	public function onRequestStart( event, rc, prc ) {
		// List of pages, can be accessed without logged in.
		local.WhiteList = [
			"security.login",
			"security.doLogin",
			"login",
			"logout"
		];

		if( NOT structKeyExists(session, "userID") AND NOT ArrayFindNoCase( local.WhiteList, rc.Action )){
			rc.msgAction = "Error";
			rc.msg = "Please try after login";
			setNextEvent(event = 'login', persist = "msg,msgAction");
		}

		local.BlackList = [
			"security.login"
		];

		if (structKeyExists(session, "userID") AND ArrayFindNoCase( local.BlackList, rc.Action )){
			setNextEvent(event = 'home');
		}
	}

	public function onException(event,rc,prc){
	}
}