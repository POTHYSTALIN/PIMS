component extends="coldbox.system.EventHandler" {
	property name="inventoryItemService" inject="inventoryItems@sysinfo" scope="instance";

	function index( event, rc, prc ) {
		prc.items = instance.inventoryItemService.getItems( argumentCollection = rc );
		// writeDump(prc.items);abort;
	}

	function addEdit( event, rc, prc ) {
		param name="rc.id" default="0" type="numeric";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id) ? "mitrahsoft.sysinfo.items.update" : "mitrahsoft.sysinfo.items.add";
		rc.formSubmit = val(rc.id) ? "Update" : "Add";

		if( structKeyExists(rc, "submit") ) {
			try {
				if( val(rc.id) ) {
					instance.inventoryItemService.updateItem(argumentCollection=rc);
				} else {
					rc.id = instance.inventoryItemService.addItem(argumentCollection=rc);
				}
				rc.msgAction = "Success";
				rc.msg = "Inventory item saved successfully.";
			} catch( any e ) {
				writeDump(e);abort;
				rc.msgAction = "Error";
				rc.msg = ( len(e.message) ? e.message : e.detail );
			}
			setNextEvent(event = 'mitrahsoft.sysinfo.items', persist = "msg,msgAction");
		}

		prc.item = instance.inventoryItemService.getItems( id = rc.id );
		event.setView( view="items/addEdit", noLayout=true );
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		instance.inventoryItemService.deleteItem( id = rc.id );
		rc.msgAction = "Success";
		rc.msg = "Password details deleted successfully.";

		setNextEvent(event = 'mitrahsoft.sysinfo.items', persist = "msg,msgAction");
	}
}