component extends="base"{
	public function login( event, rc, prc ){
		event.setLayout("login");
	}

	public function doLogin( event, rc, prc ){
		if(structKeyExists(rc, "username") AND structKeyExists(rc, "password") AND rc.username EQ "admin" AND rc.password EQ "admin"){
			session.UserID = -1;
			Session.UserName = "POTHYS";
			rc.msgAction = "Success";
			rc.msg = "Welcome back, POTHYS !!!";
			setNextEvent(event = 'home', persist = "msg,msgAction");
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