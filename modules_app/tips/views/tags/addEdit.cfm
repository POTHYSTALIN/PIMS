<cfoutput>
	<form id="addEditForm" action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<!--- MODE --->
		<div class="row">
			<div class="col-sm-6 form-group">
				<label for="name" class="col-form-label">Tag</label>
				<input type="text" class="form-control" id="name" name="name" placeholder="name" value="#prc.currTag.name#" required>
				<div class="invalid-feedback">Please enter the name for tag</div>
			</div>
			<div class="col-sm-6 form-group">
				<label for="deleted" class="col-form-label">Deleted</label>
				<input type="checkbox" id="deleted" class="badgebox w-100" name="deleted" <cfif prc.currTag.deleted EQ 1>checked</cfif> value="1">
				<label for="deleted" class="badge bg-danger text-white float-left"><i class="fas fa-check"></i></label>
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