component extends="coldbox.system.EventHandler" {
	property name="inventoryItemPropertyService" inject="inventoryItemProperties@sysinfo" scope="instance";

	function index( event, rc, prc ) {
		prc.properties = instance.inventoryItemPropertyService.getProperties( argumentCollection = rc );
		// writeDump(prc.items);abort;
	}

	function addEdit( event, rc, prc ) {
		param name="rc.id" default="0" type="numeric";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id) ? "mitrahsoft.sysinfo.item-props.update" : "mitrahsoft.sysinfo.item-props.add";
		rc.formSubmit = val(rc.id) ? "Update" : "Add";

		if( structKeyExists(rc, "submit") ) {
			try {
				if( val(rc.id) ) {
					instance.inventoryItemPropertyService.updateProperty(argumentCollection=rc);
				} else {
					rc.id = instance.inventoryItemPropertyService.addProperty(argumentCollection=rc);
				}
				rc.msgAction = "Success";
				rc.msg = "Inventory item saved successfully.";
			} catch( any e ) {
				writeDump(e);abort;
				rc.msgAction = "Error";
				rc.msg = ( len(e.message) ? e.message : e.detail );
			}
			setNextEvent(event = 'mitrahsoft.sysinfo.item-props', persist = "msg,msgAction");
		}

		prc.property = instance.inventoryItemPropertyService.getProperties( id = rc.id );
		// writeDump(prc.property);abort;
		event.setView( view="properties/addEdit", noLayout=true );
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		instance.inventoryItemPropertyService.deleteProperty( id = rc.id );
		rc.msgAction = "Success";
		rc.msg = "Password details deleted successfully.";

		setNextEvent(event = 'mitrahsoft.sysinfo.item-props', persist = "msg,msgAction");
	}
}