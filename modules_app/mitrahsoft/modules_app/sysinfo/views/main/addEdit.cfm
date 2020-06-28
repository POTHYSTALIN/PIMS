<cfoutput>
	<form action="#event.buildLink( lCase(rc.formAction) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="name" class="col-sm-2 col-form-label">System name</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="name" name="name" placeholder="name" value="#prc.systemDetails.name#">
			</div>
		</div>
		<div class="form-group row">
			<label for="label" class="col-sm-2 col-form-label">System label</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="label" name="label" placeholder="label" value="#prc.systemDetails.label#">
			</div>
		</div>
		<div class="form-group row">
			<label for="cabinet" class="col-sm-2 col-form-label">Cabinet</label>
			<div class="col-sm-10">
				<select class="form-control" name="cabinet" id="cabinet">
					<option>Please select the cabinet</option>
					<cfloop query="prc.cabinets">
						<option value="#prc.cabinets.detailID#" <cfif prc.cabinets.detailID EQ prc.systemDetails.cabinet>selected</cfif>>#prc.cabinets.details#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="cabinet" class="col-sm-2 col-form-label">Motherboard</label>
			<div class="col-sm-10">
				<select class="form-control" name="motherboard" id="motherboard">
					<option>Please select the motherboard</option>
					<cfloop query="prc.motherboards">
						<option value="#prc.motherboards.detailID#" <cfif prc.motherboards.detailID EQ prc.systemDetails.motherboard>selected</cfif>>#prc.motherboards.details#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="cabinet" class="col-sm-2 col-form-label">Processor</label>
			<div class="col-sm-10">
				<select class="form-control" name="processor" id="processor">
					<option>Please select the processor</option>
					<cfloop query="prc.processors">
						<option value="#prc.processors.detailID#" <cfif prc.processors.detailID EQ prc.systemDetails.processor>selected</cfif>>#prc.processors.details#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="cabinet" class="col-sm-2 col-form-label">Ram</label>
			<div class="col-sm-10">
				<select class="form-control" name="ram" id="ram">
					<option>Please select the ram</option>
					<cfloop query="prc.rams">
						<option value="#prc.rams.detailID#" <cfif prc.rams.detailID EQ prc.systemDetails.ram>selected</cfif>>#prc.rams.details#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="cabinet" class="col-sm-2 col-form-label">Harddisk</label>
			<div class="col-sm-10">
				<select class="form-control" name="hdd" id="hdd">
					<option>Please select the harddisk</option>
					<cfloop query="prc.hdds">
						<option value="#prc.hdds.detailID#" <cfif prc.hdds.detailID EQ prc.systemDetails.hdd>selected</cfif>>#prc.hdds.details#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="cabinet" class="col-sm-2 col-form-label">OS</label>
			<div class="col-sm-10">
				<select class="form-control" name="os" id="os">
					<option>Please select the os</option>
					<cfloop query="prc.oses">
						<option value="#prc.oses.detailID#" <cfif prc.oses.detailID EQ prc.systemDetails.os>selected</cfif>>#prc.oses.details#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="deleted" class="col-sm-2 col-form-label">Deleted</label>
			<div class="col-sm-10">
				<input type="checkbox" class="form-control" id="deleted" name="deleted" <cfif prc.systemDetails.deleted EQ 1>checked</cfif> value="1">
			</div>
		</div>
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