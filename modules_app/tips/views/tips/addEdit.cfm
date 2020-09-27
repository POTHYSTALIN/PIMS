<cfoutput>
	<form action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="row">
			<!--- NAME/TITLE --->
			<div class="form-group col-sm-6">
				<label for="title" class="col-form-label">Tag</label>
				<input type="text" class="form-control" id="title" name="title" placeholder="title" value="#prc.currTip.title#">
			</div>

			<!--- DELETED --->
			<div class="checkbox form-group col-sm-6">
				<label for="deleted" class="col-form-label pl-0">Deleted</label>
				<div class="custom-control custom-checkbox">
					<input type="checkbox" class="custom-control-input" id="deleted" name="deleted" value="1" <cfif prc.currTip.deleted EQ 1>checked</cfif>>
					<label class="custom-control-label float-left" for="deleted"></label>
				</div>
			</div>

			<!--- TAGS --->
			<div class="col-sm-6 form-group">
				<label for="tagIds" class="col-form-label">Tags</label><br>
				<select class="bootstrap-custom-select w-100" id="tagIds" name="tagIds" multiple required>
					<option value="">Please select tag(s)</option>
					<cfloop query="#prc.allTags#">
						<option value="#prc.allTags.id#" <cfif listFind( prc.currTipTags.valueList( "tagId" ), prc.allTags.id )>selected</cfif>>#prc.allTags.name#</option>
					</cfloop>
				</select>
				<div class="invalid-feedback">Please select a person, who benefied from this transaction</div>
			</div>

			<!--- DESCRIPTION --->
			<div class="form-group col-sm-12">
				<label for="category" class="col-form-label">Description</label>
				<textarea class="form-control md-editor" name="description" id="description" rows="9">#prc.currTip.description#</textarea>
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
<cfinclude template="/views/main/md-editor.cfm" runonce="true" />