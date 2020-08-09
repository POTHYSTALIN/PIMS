<cfoutput>
	<form action="#event.buildLink( lCase( prc.formAction ) )#" method="post" id="addEditForm">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="inventoryItemId" class="col-sm-2 col-form-label">Hardware</label>
			<div class="col-sm-10">
				<select class="form-control" name="inventoryItemID" id="inventoryItemID" onchange="javascript: showEditModal(this, '#rc.id#', this.value);" required>
					<option value="">Please select an item</option>
					<cfloop query="prc.items">
						<option value="#prc.items.id#" <cfif listFindNoCase( prc.itemDetail.inventoryItemId & "," & rc.hid, prc.items.id )>selected</cfif>>#prc.items.name#</option>
					</cfloop>
				</select>
				<div class="invalid-feedback">Please select an item</div>
			</div>
		</div>

		<cfloop collection="#prc.propertiesList#" item="currProp">
			<cfset propName = lCase( listFirst( currProp, " " ) )>
			<div class="form-group row">
				<label for="#propName#ID" class="col-sm-2 col-form-label">#currProp#</label>
				<div class="col-sm-10">
					<select class="form-control" name="#propName#ID" id="#propName#ID" required>
						<option value="">Please select a #lCase(currProp)#</option>
						<cfloop collection="#prc.propertiesList[currProp].options#" item="currOption">
							<option value="#currOption#" <cfif currOption EQ prc.itemDetail[ lCase( propName ) & "ID" ][1]>selected</cfif>>#prc.propertiesList[currProp].options[currOption]#</option>
						</cfloop>
					</select>
				</div>
			</div>
		</cfloop>
		<!--- <div class="form-group row">
			<label for="deleted" class="col-sm-2 col-form-label">Deleted</label>
			<div class="col-sm-10">
				<input type="checkbox" class="form-control" id="deleted" name="deleted" <cfif prc.itemDetail.deleted EQ 1>checked</cfif> value="1">
			</div>
		</div> --->
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