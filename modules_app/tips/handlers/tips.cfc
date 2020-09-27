component extends="coldbox.system.EventHandler" {
	property name="tipsService" inject="tips@tips" scope="instance";

	public function index( event, rc, prc ) {
		param name="rc.msgAction" default="";
		param name="rc.msg" default="";
		param name="rc.id" default="0";

		prc.tips = instance.tipsService.list();
	}

	public function preview( event, rc, prc ) {
		// event.setView( view="tips/preview" );
	}

	// public function update( event, rc, prc ) {
	// 	// writeDump(rc);abort;
	// 	if( structKeyExists( rc, "submit" ) ) {
	// 		if( val( rc.id ) ) {
	// 			instance.eventService.update( argumentCollection=rc );
	// 		} else {
	// 			try {
	// 				rc.id = instance.eventService.add( argumentCollection=rc );
	// 				rc.msgAction = "Success";
	// 				rc.msg = "Event saved successfully.";
	// 			} catch( any e ) {
	// 				writeDump(e);abort;
	// 				rc.msgAction = "Error";
	// 				rc.msg = len( e.message )? e.message : e.detail;
	// 			}
	// 		}
	// 		relocate( event = "events", persist = "msg,msgAction" );
	// 	}
	// }

	// public function delete( event, rc, prc ) {
	// 	instance.eventService.delete( id = rc.id );
	// 	rc.msgAction = "Success";
	// 	rc.msg = "Event deleted successfully.";
	// 	relocate( event = "events", persist = "msg,msgAction" );
	// }

	// public function addEdit( event, rc, prc ) {
	// 	param name="rc.id" default="0";
	// 	param name="rc.msg" default="";
	// 	param name="rc.msgAction" default="";

	// 	prc.formAction = "events.update.#rc.id#";
	// 	prc.formSubmit = val( rc.id ) ? "Update" : "Add";

	// 	prc.currEvent = instance.eventService.list( id = rc.id );
	// 	prc.allCategories = instance.eventService.listCategories();

	// 	event.setView( view="events/addEdit", noLayout=true );
	// }
}