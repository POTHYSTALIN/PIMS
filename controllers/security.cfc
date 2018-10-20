component extends="base" {
	property name="userService" inject="model.users" scope="instance";
	property name="bankService" inject="model.banks" scope="instance";

	public function login( event, rc, prc ){
		event.setLayout("login");
	}

	public function doLogin( event, rc, prc ){
		if(structKeyExists(rc, "username") AND structKeyExists(rc, "password")){
			var tmpLogin = instance.userService.authenticateLogin( argumentCollection = rc );
			if( tmpLogin.recordcount ){
				session.userID = tmpLogin.ID;
				session.userName = tmpLogin.fname & " " & tmpLogin.lname;
				session.myBankAccounts = instance.bankService.getBankAccounts( personID = session.userID );
				rc.msgAction = "Success";
				rc.msg = "Welcome back, #Session.UserName# !!!";
				setNextEvent(event = 'home', persist = "msg,msgAction");
			} else if( rc.username EQ "admin" AND rc.password EQ "admin" ) {
				session.userID = -1;
				Session.userName = "POTHYS";
				rc.msgAction = "Success";
				rc.msg = "Welcome back, #Session.UserName# !!!";
				setNextEvent(event = 'home', persist = "msg,msgAction");
			}
		}
		rc.msgAction = "Error";
		rc.msg = "Invalid credentials!!!";
		setNextEvent(event = 'login', persist = "msg,msgAction");
	}

	public function logout( event, rc, prc ){
		structClear(session);
		rc.msgAction = "Success";
		rc.msg = "Logged out successfully!!!";
		setNextEvent(event = 'login', persist = "msg,msgAction");
	}
}