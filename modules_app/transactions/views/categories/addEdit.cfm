<cfoutput>
	<form action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="name" class="col-sm-2 col-form-label">Category Name</label>
			<div class="col-sm-10">
				<input class="form-control" type="text" name="name" value="#prc.currCategoryDetails.name#" placeholder="Category Name">
			</div>
		</div>

		<div class="form-group row">
			<label for="type" class="col-sm-2 col-form-label">Category Type</label>
			<div class="col-sm-10">
				<cf_dropdown dropdownName="type" optionLabel="name" optionValue="id" selectedValue="#prc.currCategoryDetails.typeID#" selectedLabel="#prc.currCategoryDetails.type#" baseQuery="#prc.allCategoryTypes#" onclick="javascript: changeDropdown('type', @@currValue, this);" />
			</div>
		</div>

		<div class="form-group row">
			<label for="ParentID" class="col-sm-2 col-form-label">Sub category of</label>
			<div class="col-sm-10">
				<select name="ParentID" class="form-control">
					<option value="0">None</option>
					<cfloop query="prc.allCategories">
						<cfif prc.allCategories.ID EQ prc.currCategoryDetails.ID>
							<cfcontinue>
						</cfif>
						<option value="#prc.allCategories.ID#" <cfif prc.currCategoryDetails.ParentID EQ prc.allCategories.ID>selected="selected"</cfif>>#prc.allCategories.name#</option>
					</cfloop>
				</select>
			</div>
		</div>

		<div class="form-group row">
			<label for="deleted" class="col-sm-2 col-form-label">Status</label>
			<div class="col-sm-10">
				<select id="deleted" name="deleted" class="form-control">
					<option value="0" <cfif prc.currCategoryDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
					<option value="1" <cfif prc.currCategoryDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
				</select>
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