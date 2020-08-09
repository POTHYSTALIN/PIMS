<cfoutput>
	<form action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="inventoryItemId" class="col-sm-2 col-form-label">Hardware</label>
			<div class="col-sm-10">
				<select class="form-control" name="inventoryItemId" id="inventoryItemId">
					<option>Please select an item</option>
					<cfloop query="prc.items">
						<option value="#prc.items.id#" <cfif prc.items.id EQ prc.propertyDetail.inventoryItemId>selected</cfif>>#prc.items.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="inventoryItemPropertyId" class="col-sm-2 col-form-label">Property</label>
			<div class="col-sm-10">
				<select class="form-control" name="inventoryItemPropertyId" id="inventoryItemPropertyId">
					<option>Please select an property</option>
					<cfloop query="prc.properties">
						<option value="#prc.properties.id#" <cfif prc.properties.id EQ prc.propertyDetail.inventoryItemPropertyId>selected</cfif>>#prc.properties.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="inventoryItemPropertyValue" class="col-sm-2 col-form-label">Details</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="inventoryItemPropertyValue" name="inventoryItemPropertyValue" placeholder="Property value" value="#prc.propertyDetail.inventoryItemPropertyValue#">
			</div>
		</div>
		<div class="form-group row">
			<label for="deleted" class="col-sm-2 col-form-label">Deleted</label>
			<div class="col-sm-10">
				<input type="checkbox" id="deleted" name="deleted" <cfif prc.propertyDetail.deleted EQ 1>checked</cfif> value="1">
			</div>
		</div>
		<div class="form-group row">
			<div class="offset-9 col-sm-1 pr-0 pl-4 mr-1">
				<input type="submit" class="btn btn-success" name="Submit" value="#prc.formSubmit#">
			</div>
			<div class="col-sm-1 p-0 mr-2 ml-5">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</form>
</cfoutput>