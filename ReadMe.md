- Need to change all assets to its latest versions.
- Need to remove unwanted assets after updating latest versions.
- Need to remove unwanted cfml files.
- Need to add header and footer pages separately, in order to make it global.
- Add isActive on logins table & check that on login check

- sysinfo
	inventoryItems
		id
		item name ( ram, cabinet, hdd, motherboard etc )
	inventoryItemProperties
		id
		prop name ( name, size, capacity, frequency, etc )
	inventoryItemPropertyDetails
		id
		inventoryItemId ( id from inventoryItems )
		inventoryItemPropertyId ( id from inventoryItemProperties )
		inventoryItemPropertyValue ( 4GB, 8th Gen, 2300 GHz etc )

	purchases
	systemInventory ( all fields should be id fields from inventoryItemPropertyDetails )
		id
		label
		cabinet ( id from inventoryItemDetails, where inventoryItemId is corresponding id from inventoryItems )
		MotherBoard ( id from inventoryItemDetails, where inventoryItemId is corresponding id from inventoryItems )
		processor ( id from inventoryItemDetails, where inventoryItemId is corresponding id from inventoryItems )
		hdd ( id from inventoryItemDetails, where inventoryItemId is corresponding id from inventoryItems )
		ram ( id from inventoryItemDetails, where inventoryItemId is corresponding id from inventoryItems )
		os ( id from inventoryItemDetails, where inventoryItemId is corresponding id from inventoryItems )
		installationtype ( FE, CF, mixed )
		empid
	systemProblems
		id
		sysid
		date
		desc
		solution
		otherdetails


Use this kind of popover for modals or confirmations etc ( Need to check it is actively developed or not )
https://www.tutorialrepublic.com/codelab.php?topic=bootstrap&file=set-popovers-container