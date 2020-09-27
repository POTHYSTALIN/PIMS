component extends="coldbox.system.EventHandler" {
	property name="tipsService" inject="tips@tips" scope="instance";
	property name="tagsService" inject="tags@tips" scope="instance";

	public function preview( event, rc, prc ) {
		prc.currTips = instance.tipsService.list( id = rc.id );
	}

	public function index( event, rc, prc ) {
		param name="rc.msgAction" default="";
		param name="rc.msg" default="";
		param name="rc.id" default="0";

		prc.tips = instance.tipsService.list();
		prc.tags = instance.tagsService.list();
	}

	public function update( event, rc, prc ) {
		if( structKeyExists( rc, "submit" ) ) {
			if( val( rc.id ) ) {
				instance.tipsService.update( argumentCollection=rc );
			} else {
				try {
					rc.id = instance.tipsService.add( argumentCollection=rc );
					rc.msgAction = "Success";
					rc.msg = "Tips saved successfully.";
				} catch( any e ) {
					writeDump(e);abort;
					rc.msgAction = "Error";
					rc.msg = len( e.message )? e.message : e.detail;
				}
			}
			instance.tipsService.updateTags( tipId=rc.id, tagIds=rc.tagIds );
			relocate( event = "tips", persist = "msg,msgAction" );
		}
	}

	public function delete( event, rc, prc ) {
		instance.tipsService.delete( id = rc.id );
		rc.msgAction = "Success";
		rc.msg = "Tips deleted successfully.";
		relocate( event = "tips", persist = "msg,msgAction" );
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		prc.formAction = "tips.update.#rc.id#";
		prc.formSubmit = val( rc.id ) ? "Update" : "Add";

		prc.currTip = instance.tipsService.list( id = rc.id );
		prc.currTipTags = instance.tagsService.list( tipId = rc.id );
		prc.allTags = instance.tagsService.list();

		event.setView( view="tips/addEdit", noLayout=true );
	}
}