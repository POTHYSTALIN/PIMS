component extends="coldbox.system.EventHandler" {
	property name="eventService" inject="events.model.eventService" scope="instance";
	// property name="utilsService" inject="utilsService" scope="instance";
	// property name="utilsService" inject="model.utils" scope="instance";

	public function index( event, rc, prc ) {
		// writeDump(CGI);abort;
		param name="rc.msgAction" default="";
		param name="rc.msg" default="";
		param name="rc.id" default="0";

		prc.formAction = "events";
		// prc.formSubmit = val(rc.id) ? "Update" : "Add";
		if( structKeyExists(rc, "submit") && rc.submit == "submit" ){
			if(val(rc.id)){
				instance.eventService.updateEvents(argumentCollection=rc);
			} else {
				try{
					rc.id = instance.eventService.addEvents(argumentCollection=rc);
					rc.msgAction = "Success";
					rc.msg = "Event saved successfully.";
				} catch( any e ) {
					writeDump(e);abort;
					rc.msgAction = "Error";
					rc.msg = (len(e.message)?e.message:e.detail);
				}
			}
			relocate(event = 'list.events', persist = "msg,msgAction");
		} else if( structKeyExists(rc, "submit") && rc.submit == "delete" ){
			instance.eventService.deleteEvent( id = rc.id );
			rc.msgAction = "Success";
			rc.msg = "Event deleted successfully.";
			relocate(event = 'list.events', persist = "msg,msgAction");
		}

		prc.getEvents = instance.eventService.getNotifications();
	}

	public string function notifications( event, rc, prc ) returnformat="JSON" {
		var tmpNotifications = instance.eventService.getNotifications();
		return instance.utilsService.queryToJSON(tmpNotifications);
	}
}