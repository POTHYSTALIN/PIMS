component extends="base"{
	public function login( event, rc, prc ){
		event.setLayout("login");
	}

	public function doLogin( event, rc, prc ){
		if(structKeyExists(rc, "username") AND structKeyExists(rc, "password") AND rc.username EQ "admin" AND rc.password EQ "admin"){
			session.UserID = -1;
			Session.UserName = "POTHYS";
			setNextEvent('home');
		}
		setNextEvent('login');
	}

	public function logout( event, rc, prc ){
		structClear(session);
		setNextEvent('login');
	}
}