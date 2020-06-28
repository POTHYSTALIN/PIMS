component extends="coldbox.system.EventHandler" {
	property name="systemDetailsService" inject="systemDetails@sysinfo" scope="instance";
	property name="inventoryItemDetailService" inject="inventoryItemDetails@sysinfo" scope="instance";
	property name="inventoryItemService" inject="inventoryItems@sysinfo" scope="instance";

	function index( event, rc, prc ) {
		prc.systemDetails = instance.systemDetailsService.getSystemDetails();
		// writeDump(prc.systemDetails);abort;
	}

	function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id)?"main.update":"main.add";
		rc.formSubmit = val(rc.id)?"Update":"Add";

		prc.systemDetails = instance.systemDetailsService.getSystemDetails();
		prc.cabinets = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 5 );
		prc.motherboards = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 1 );
		prc.processors = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 2 );
		prc.hdds = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 3 );
		prc.rams = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 4 );
		prc.oses = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 6 );

		event.setView( view="main/addEdit", noLayout=true );
	}
}