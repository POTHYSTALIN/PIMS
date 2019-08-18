component extends="coldbox.system.EventHandler" {
	property name="systemDetailsService" inject="systemDetails@sysinfo" scope="instance";

	function index( event, rc, prc ) {
		prc.systemDetails = instance.systemDetailsService.getSystemDetails();
		// writeDump(prc.systemDetails);abort;
	}

	function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id)?"main.update":"main.add";
		rc.formSubmit = val(rc.id)?"Update":"Add";

		prc.systemDetails = instance.systemDetailsService.getSystemDetails();
		prc.cabinets = instance.systemDetailsService.getInventoryItems( "Cabinet" );
		prc.motherboards = instance.systemDetailsService.getInventoryItems( "Motherboard" );
		prc.processors = instance.systemDetailsService.getInventoryItems( "Processor" );
		prc.hdds = instance.systemDetailsService.getInventoryItems( "HDD" );
		prc.rams = instance.systemDetailsService.getInventoryItems( "RAM" );
		prc.oses = instance.systemDetailsService.getInventoryItems( "OS" );
		writeDump(prc);abort;

		event.setView( view="main/addEdit", noLayout=true );
	}
}