component extends="coldbox.system.EventHandler" {
	property name="tagsService" inject="tags@tips" scope="instance";

	public function index( event, rc, prc ) {
		param name="rc.msgAction" default="";
		param name="rc.msg" default="";
		param name="rc.id" default="0";

		prc.tags = instance.tagsService.list();
	}

	public function update( event, rc, prc ) {
		if( structKeyExists( rc, "submit" ) ) {
			if( val( rc.id ) ) {
				instance.tagsService.update( argumentCollection=rc );
			} else {
				try {
					rc.id = instance.tagsService.add( argumentCollection=rc );
					rc.msgAction = "Success";
					rc.msg = "Tag saved successfully.";
				} catch( any e ) {
					writeDump(e);abort;
					rc.msgAction = "Error";
					rc.msg = len( e.message )? e.message : e.detail;
				}
			}
			relocate( event = "tips.tags", persist = "msg,msgAction" );
		}
	}

	public function delete( event, rc, prc ) {
		instance.tagsService.delete( id = rc.id );
		rc.msgAction = "Success";
		rc.msg = "Tag deleted successfully.";
		relocate( event = "tips.tags", persist = "msg,msgAction" );
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		prc.formAction = "tips.tags.update.#rc.id#";
		prc.formSubmit = val( rc.id ) ? "Update" : "Add";

		prc.currTag = instance.tagsService.list( id = rc.id );

		event.setView( view="tags/addEdit", noLayout=true );
	}
}