component extends="coldbox.system.EventHandler" {
	property name="systemDetailsService" inject="systemDetails@sysinfo" scope="instance";

	function index( event, rc, prc ) {
		prc.systemDetails = instance.systemDetailsService.getSystemDetails();
		// writeDump(prc.systemDetails);abort;
	}

	function addEdit( event, rc, prc ) {
		prc.systemDetails = instance.systemDetailsService.getSystemDetails();
		writeDump(prc.systemDetails);abort;
	}
}