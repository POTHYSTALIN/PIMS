component extends="coldbox.system.EventHandler"{
	property name="securityService" inject="securityService_custom";

	// function index( event, rc, prc ){
	// 	event.noLayout();
	// 	relocate("security.login");
	// }

	function login( event, rc, prc ){
		// business logics goes here
		// writeDump(getSetting("RegisteredHandlers"));
		// writeDump(getSetting("modules"));
		// abort;
		event.setLayout("main");
		event.setView(view="security/index");
	}

	function doLogin( event, rc, prc ){
		var tmpLogin = securityService.validateLogin( argumentCollection = rc );
		if(tmpLogin.isValid) {
			session.userID = tmpLogin.data.ID;
			session.userName = tmpLogin.data.fname & " " & tmpLogin.data.lname;
			// session.myBankAccounts = instance.bankService.getBankAccounts( personID = session.userID );
			rc.msgAction = "Success";
			rc.msg = "Welcome #session.userName#!";
			relocate(event = 'home', persist = "msg,msgAction");
		} else {
			rc.msgAction = "Error";
			rc.msg = "Invalid credentials!!!";
			relocate(event = 'login', persist = "msg,msgAction");
		}
	}
	
	function logout( event, rc, prc ){
		// clear all session variables & redirect the user to login page
		session.clear();
		rc.msgAction = "Success";
		rc.msg = "Successfully logged out!!!";
		relocate(event = 'login', persist = "msg,msgAction");
	}

	function signup( event, rc, prc ){
		// business logics goes here
		event.setLayout("main");
	}

	function doSignup( event, rc, prc ){
		// writeDump(securityService);
		// writeDump(rc);abort;
		var res = securityService.createUser( argumentCollection=rc );
		rc.msgAction = "Success";
		rc.msg = "Successfully signed up!!!";
		relocate(event = 'login', persist = "msg,msgAction");
	}
}