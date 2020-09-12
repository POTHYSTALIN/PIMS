component extends="coldbox.system.EventHandler" {
	property name="eventService" inject="events.model.eventService" scope="instance";
	property name="utilsService" inject="utilsService" scope="instance";
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

	public string function todos( event, rc, prc ) returntype="array" returnformat="JSON" {
		var res = [];
		return res;
	}
	public string function samples( event, rc, prc ) returntype="array" returnformat="JSON" {
		var res = [
			{
				"id": 1133,
				"title": "All Day Event",
				"start": "2019-08-01",
				"textColor": "red",
				"backgroundColor": "yellow",
				"borderColor": "yellow"
			},
			{
				"title": "Long Event",
				"start": "2019-08-07",
				"end": "2019-08-10"
			},
			{
				"groupId": 999,
				"title": "Repeating Event",
				"start": "2019-08-09T16:00:00"
			},
			{
				"groupId": 999,
				"title": "Repeating Event",
				"start": "2019-08-16T16:00:00"
			},
			{
				"title": "Conference",
				"start": "2019-08-11",
				"end": "2019-08-13"
			},
			{
				"title": "Meeting",
				"start": "2019-08-12T10:30:00",
				"end": "2019-08-12T12:30:00"
			},
			{
				"title": "Lunch",
				"start": "2019-08-12T12:00:00"
			},
			{
				"title": "Meeting",
				"start": "2019-08-12T14:30:00"
			},
			{
				"title": "Happy Hour",
				"start": "2019-08-12T17:30:00"
			},
			{
				"title": "Dinner",
				"start": "2019-08-12T20:00:00"
			},
			{
				"title": "Birthday Party",
				"start": "2019-08-13T07:00:00"
			},
			{
				"title": "Click for Google",
				"url": "http://google.com/",
				"start": "2019-08-28"
			}
		];
		return res;
	}
}