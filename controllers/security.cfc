component extends="coldbox.system.EventHandler"{
	property name="securityService" inject="securityService";

	// function index( event, rc, prc ){
	// 	event.noLayout();
	// 	setNextEvent("security.login");
	// }

	function login( event, rc, prc ){
		// business logics goes here
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
			setNextEvent(event = 'home', persist = "msg,msgAction");
		} else {
			rc.msgAction = "Error";
			rc.msg = "Invalid credentials!!!";
			setNextEvent(event = 'login', persist = "msg,msgAction");
		}
	}
	
	function logout( event, rc, prc ){
		// clear all session variables & redirect the user to login page
		session.clear();
		rc.msgAction = "Success";
		rc.msg = "Successfully logged out!!!";
		setNextEvent(event = 'login', persist = "msg,msgAction");
	}

	function signup( event, rc, prc ){
		// business logics goes here
		event.setLayout("main");
	}

	function doSignup( event, rc, prc ){
		writeDump(securityService);
		writeDump(rc);abort;
	}
}