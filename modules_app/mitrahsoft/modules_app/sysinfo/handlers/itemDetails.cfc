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
		param name="rc.hid" default="0" type="numeric";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		prc.formAction = val(rc.id) ? "mitrahsoft.sysinfo.item-details.update" : "mitrahsoft.sysinfo.item-details.add";
		prc.formSubmit = val(rc.id) ? "Update" : "Add";

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
			relocate(event = 'mitrahsoft.sysinfo.item-details', persist = "msg,msgAction");
		}

		prc.itemDetail = instance.inventoryItemDetailService.getItemDetails( id = rc.id );
		prc.items = instance.inventoryItemService.getItems( deleted = 0 );
		prc.itemProps = instance.inventoryItemDetailService.getPropertiesForInventoryItem( rc.hid );
		prc.propertiesList = structNew("ordered");
		for( prop in prc.itemProps ) {
			if( !structKeyExists(prc.propertiesList, prop.property) ) {
				prc.propertiesList[prop.property] = structNew("ordered");
				prc.propertiesList[prop.property].id = prop.propID;
				prc.propertiesList[prop.property].options = structNew("ordered");
			}
			prc.propertiesList[prop.property].options[prop.detailID] = prop.details;
		}

		event.setView( view="itemDetails/addEdit", noLayout=true );
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		instance.inventoryItemDetailService.deleteitemDetails( id = rc.id );
		rc.msgAction = "Success";
		rc.msg = "Inventory item deatils deleted successfully.";

		relocate(event = 'mitrahsoft.sysinfo.item-details', persist = "msg,msgAction");
	}
}