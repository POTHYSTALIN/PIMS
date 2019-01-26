component extends="coldbox.system.EventHandler"{
	// function index( event, rc, prc ){
	// 	event.noLayout();
	// 	setNextEvent("security.login");
	// }

	function login( event, rc, prc ){
		// business logics goes here
		event.setView(view="security/index", noLayout=true);
	}

	function signup( event, rc, prc ){
		// business logics goes here
		event.noLayout();
	}
}