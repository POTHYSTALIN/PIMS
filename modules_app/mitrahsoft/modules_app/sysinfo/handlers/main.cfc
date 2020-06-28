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
		// prc.cabinets = instance.systemDetailsService.getInventoryItems( "Cabinet" );
		prc.cabinets = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 5 );
		// prc.cabinets = instance.inventoryItemService.getItems( inventoryItemID=5 );
		// prc.motherboards = instance.systemDetailsService.getInventoryItems( "Motherboard" );
		prc.motherboards = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 1 );
		// prc.motherboards = instance.inventoryItemService.getItems( inventoryItemID= 1 );
		// prc.processors = instance.systemDetailsService.getInventoryItems( "Processor" );
		prc.processors = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 2 );
		// prc.processors = instance.inventoryItemService.getItems( inventoryItemID= 2 );
		// prc.hdds = instance.systemDetailsService.getInventoryItems( "HDD" );
		prc.hdds = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 3 );
		// prc.hdds = instance.inventoryItemService.getItems( inventoryItemID= 3 );
		// prc.rams = instance.systemDetailsService.getInventoryItems( "RAM" );
		prc.rams = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 4 );
		// prc.rams = instance.inventoryItemService.getItems( inventoryItemID= 4 );
		// prc.oses = instance.systemDetailsService.getInventoryItems( "OS" );
		prc.oses = instance.inventoryItemDetailService.getPropertiesForInventoryItem( 6 );
		// prc.oses = instance.inventoryItemService.getItems( inventoryItemID= 6 );
		// writeDump(prc);abort;

		event.setView( view="main/addEdit", noLayout=true );
	}
}