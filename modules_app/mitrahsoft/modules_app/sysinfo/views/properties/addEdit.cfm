<cfoutput>
	<form action="#event.buildLink( lCase(rc.formAction) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="name" class="col-sm-2 col-form-label">Property</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="name" name="name" placeholder="name" value="#prc.property.name#">
			</div>
		</div>
		<div class="form-group row">
			<label for="deleted" class="col-sm-2 col-form-label">Deleted</label>
			<div class="col-sm-10">
				<input type="checkbox" id="deleted" name="deleted" <cfif prc.property.deleted EQ 1>checked</cfif> value="1">
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