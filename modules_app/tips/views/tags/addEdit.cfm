<cfoutput>
	<form action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="name" class="col-sm-2 col-form-label">Tag</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="name" name="name" placeholder="name" value="#prc.currTag.name#">
			</div>
		</div>
		<div class="form-group row">
			<label for="deleted" class="col-sm-2 col-form-label">Deleted</label>
			<div class="col-sm-10">
				<input type="checkbox" id="deleted" name="deleted" <cfif prc.currTag.deleted EQ 1>checked</cfif> value="1">
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