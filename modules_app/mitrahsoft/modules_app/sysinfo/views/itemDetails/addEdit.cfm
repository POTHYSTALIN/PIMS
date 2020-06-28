<cfoutput>
	<form action="#event.buildLink( lCase(rc.formAction) )#" method="post" id="addEditForm">
		<input type="hidden" name="id" value="#rc.id#">
		<div id="error_container" class="form-group row" style="display:none;">
			<div id="errors">
				<ul>
					<li style="display:none;visibility:hidden;"></li>
				</ul>
			</div>
		</div>
		<div class="form-group row">
			<label for="inventoryItemId" class="col-sm-2 col-form-label">Hardware</label>
			<div class="col-sm-10">
				<select class="form-control" name="inventoryItemID" id="inventoryItemID" onchange="javascript: showEditModal(this, '#rc.id#', this.value);" required>
					<option value="">Please select an item</option>
					<cfloop query="prc.items">
						<option value="#prc.items.id#" <cfif listFindNoCase( prc.itemDetail.inventoryItemId & "," & rc.hid, prc.items.id )>selected</cfif>>#prc.items.name#</option>
					</cfloop>
				</select>
			</div>
		</div>

		<cfloop collection="#prc.propertiesList#" item="currProp">
			<cfset propName =lCase( listFirst( currProp, " " ) )>
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
		<div class="form-group row justify-content-sm-end">
			<div class="col-sm-2">
				<input type="submit" class="btn btn-success" name="Submit" value="#rc.formSubmit#">
			</div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</form>
</cfoutput>