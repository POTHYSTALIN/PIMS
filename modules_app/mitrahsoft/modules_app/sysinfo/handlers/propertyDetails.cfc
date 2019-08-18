component extends="coldbox.system.EventHandler" {
	property name="inventoryItemPropertyDetailService" inject="inventoryItemPropertyDetails@sysinfo" scope="instance";
	property name="inventoryItemService" inject="inventoryItems@sysinfo" scope="instance";
	property name="inventoryItemPropertyService" inject="inventoryItemProperties@sysinfo" scope="instance";

	function index( event, rc, prc ) {
		prc.propertyDetails = instance.inventoryItemPropertyDetailService.getPropertyDetails( argumentCollection = rc );
	}

	function addEdit( event, rc, prc ) {
		param name="rc.id" default="0" type="numeric";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id) ? "mitrahsoft.sysinfo.prop-details.update" : "mitrahsoft.sysinfo.prop-details.add";
		rc.formSubmit = val(rc.id) ? "Update" : "Add";

		if( structKeyExists(rc, "submit") ) {
			try {
				if( val(rc.id) ) {
					instance.inventoryItemPropertyDetailService.updatePropertyDetails(argumentCollection=rc);
				} else {
					rc.id = instance.inventoryItemPropertyDetailService.addPropertyDetails(argumentCollection=rc);
				}
				rc.msgAction = "Success";
				rc.msg = "Inventory item property deatils saved successfully.";
			} catch( any e ) {
				writeDump(e);abort;
				rc.msgAction = "Error";
				rc.msg = ( len(e.message) ? e.message : e.detail );
			}
			setNextEvent(event = 'mitrahsoft.sysinfo.prop-details', persist = "msg,msgAction");
		}

		prc.propertyDetail = instance.inventoryItemPropertyDetailService.getPropertyDetails( id = rc.id );
		prc.items = instance.inventoryItemService.getItems();
		prc.properties = instance.inventoryItemPropertyService.getProperties();
		// writeDump(prc.propertyDetail);abort;
		event.setView( view="propertyDetails/addEdit", noLayout=true );
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		instance.inventoryItemPropertyDetailService.deletePropertyDetails( id = rc.id );
		rc.msgAction = "Success";
		rc.msg = "Inventory item property deatils deleted successfully.";

		setNextEvent(event = 'mitrahsoft.sysinfo.prop-details', persist = "msg,msgAction");
	}
}