component extends="coldbox.system.EventHandler" {

	function index( event, rc, prc ) {
		writeDump(rc);abort;
	}
}