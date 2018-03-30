component extends="base" {
	property name="eventService" inject="model.events" scope="instance";

	public function index( event, rc, prc ){
		// writeDump(CGI);abort;
		param name="rc.msgAction" default="";
		param name="rc.msg" default="";

		rc.formAction = "list.events";
		if(structKeyExists(rc, "event_id")){
			instance.eventService.updateEvents(argumentCollection=rc);
		}else if(structKeyExists(rc,"submit")){
			try{
				rc.id = instance.eventService.addEvents(argumentCollection=rc);
				rc.msgAction = "Success";
				rc.msg = "Events saved successfully.";
			}
			catch( any e ){
				writeDump(e);abort;
				rc.msgAction = "Error";
				rc.msg = (len(e.message)?e.message:e.detail);
			}
			// setNextEvent(event = 'list.events', persist = "msg,msgAction");
		}
		rc.getevents = instance.eventService.getEvents();
	}
}