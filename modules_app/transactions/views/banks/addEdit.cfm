<cfoutput>
	<form action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="name" class="col-sm-2 col-form-label">Bank</label>
			<div class="col-sm-10">
				<input class="form-control" type="text" id="name" name="name" value="#prc.currBankDetails.name#" placeholder="Bank Name">
			</div>
		</div>
		
		
		<div class="form-group row">
			<label for="shortname" class="col-sm-2 col-form-label">Short name</label>
			<div class="col-sm-10">
				<input class="form-control" type="text" id="shortname" name="shortname" value="#prc.currBankDetails.shortname#" placeholder="Short Name">
			</div>
		</div>
		<div class="form-group row">
			<label for="deleted" class="col-sm-2 col-form-label">Status</label>
			<div class="col-sm-10">
				<select id="deleted" name="deleted" class="form-control">
					<option value="0" <cfif prc.currBankDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
					<option value="1" <cfif prc.currBankDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
				</select>
			</div>
		</div>

		<div class="form-group row justify-content-sm-end">
			<div class="col-sm-2">
				<input type="submit" class="btn btn-success" name="Submit" value="#prc.formSubmit#">
			</div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</form>
</cfoutput>