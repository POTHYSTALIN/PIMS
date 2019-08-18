component extends="coldbox.system.EventHandler" {
	property name="inventoryItemDetailService" inject="inventoryItemDetails@sysinfo" scope="instance";
	property name="inventoryItemService" inject="inventoryItems@sysinfo" scope="instance";
	property name="inventoryItemPropertyDetailService" inject="inventoryItemPropertyDetails@sysinfo" scope="instance";

	function index( event, rc, prc ) {
		prc.itemDetails = instance.inventoryItemDetailService.getItemDetails( argumentCollection = rc );
		// writeDump(prc.itemDetails);abort;
	}

	function addEdit( event, rc, prc ) {
		param name="rc.id" default="0" type="numeric";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id) ? "mitrahsoft.sysinfo.item-details.update" : "mitrahsoft.sysinfo.item-details.add";
		rc.formSubmit = val(rc.id) ? "Update" : "Add";

		if( structKeyExists(rc, "submit") ) {
			try {
				if( val(rc.id) ) {
					instance.inventoryItemDetailService.updateItemDetails(argumentCollection=rc);
				} else {
					rc.id = instance.inventoryItemDetailService.addItemDetails(argumentCollection=rc);
				}
				rc.msgAction = "Success";
				rc.msg = "Inventory item deatils saved successfully.";
			} catch( any e ) {
				writeDump(e);abort;
				rc.msgAction = "Error";
				rc.msg = ( len(e.message) ? e.message : e.detail );
			}
			setNextEvent(event = 'mitrahsoft.sysinfo.item-details', persist = "msg,msgAction");
		}

		prc.itemDetail = instance.inventoryItemDetailService.getItemDetails( id = rc.id );
		prc.items = instance.inventoryItemService.getItems( deleted = 0 );
		prc.brands = instance.inventoryItemDetailService.getPropertyDetails("brand");
		prc.models = instance.inventoryItemDetailService.getPropertyDetails("model");
		prc.cds = instance.inventoryItemDetailService.getPropertyDetails("CD name");
		prc.generations = instance.inventoryItemDetailService.getPropertyDetails("generation");
		prc.frequencies = instance.inventoryItemDetailService.getPropertyDetails("frequency");
		prc.sizes = instance.inventoryItemDetailService.getPropertyDetails("size");
		// writeDump(prc);abort;
		event.setView( view="itemDetails/addEdit", noLayout=true );
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		instance.inventoryItemDetailService.deleteitemDetails( id = rc.id );
		rc.msgAction = "Success";
		rc.msg = "Inventory item deatils deleted successfully.";

		setNextEvent(event = 'mitrahsoft.sysinfo.item-details', persist = "msg,msgAction");
	}
}