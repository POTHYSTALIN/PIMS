<cfoutput>
	<form action="#event.buildLink( lCase(rc.formAction) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="inventoryItemId" class="col-sm-2 col-form-label">Item</label>
			<div class="col-sm-10">
				<select class="form-control" name="inventoryItemId" id="inventoryItemId">
					<option>Please select an item</option>
					<cfloop query="prc.items">
						<option value="#prc.items.id#" <cfif prc.items.id EQ prc.itemDetail.inventoryItemId>selected</cfif>>#prc.items.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="brandID" class="col-sm-2 col-form-label">Brand</label>
			<div class="col-sm-10">
				<select class="form-control" name="brandID" id="brandID">
					<option>Please select a brand</option>
					<cfloop query="prc.brands">
						<option value="#prc.brands.id#" <cfif prc.brands.id EQ prc.itemDetail.brandID>selected</cfif>>#prc.brands.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="modelID" class="col-sm-2 col-form-label">Model</label>
			<div class="col-sm-10">
				<select class="form-control" name="modelID" id="modelID">
					<option>Please select a model</option>
					<cfloop query="prc.models">
						<option value="#prc.models.id#" <cfif prc.models.id EQ prc.itemDetail.modelID>selected</cfif>>#prc.models.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="cdID" class="col-sm-2 col-form-label">CD name</label>
			<div class="col-sm-10">
				<select class="form-control" name="cdID" id="cdID">
					<option value="0">Please select a cd</option>
					<cfloop query="prc.cds">
						<option value="#prc.cds.id#" <cfif prc.cds.id EQ prc.itemDetail.cdID>selected</cfif>>#prc.cds.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="generationID" class="col-sm-2 col-form-label">Generation</label>
			<div class="col-sm-10">
				<select class="form-control" name="generationID" id="generationID">
					<option value="0">Please select generation</option>
					<cfloop query="prc.generations">
						<option value="#prc.generations.id#" <cfif prc.generations.id EQ prc.itemDetail.generationID>selected</cfif>>#prc.generations.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="frequencyID" class="col-sm-2 col-form-label">Frequency</label>
			<div class="col-sm-10">
				<select class="form-control" name="frequencyID" id="frequencyID">
					<option value="0">Please select frequency</option>
					<cfloop query="prc.frequencies">
						<option value="#prc.frequencies.id#" <cfif prc.frequencies.id EQ prc.itemDetail.frequencyID>selected</cfif>>#prc.frequencies.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="sizeID" class="col-sm-2 col-form-label">Size</label>
			<div class="col-sm-10">
				<select class="form-control" name="sizeID" id="sizeID">
					<option value="0">Please select size/capacity</option>
					<cfloop query="prc.sizes">
						<option value="#prc.sizes.id#" <cfif prc.sizes.id EQ prc.itemDetail.sizeID>selected</cfif>>#prc.sizes.name#</option>
					</cfloop>
				</select>
			</div>
		</div>
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