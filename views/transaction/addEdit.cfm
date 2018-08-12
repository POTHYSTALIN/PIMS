<cfoutput>
<!--- Uncomment below lines if this page needs header --->
<!--- <div class="container">
	<div class="p-t-20"> --->
		<form action="#event.buildLink( lCase(rc.formAction) )#" method="post">
			<input type="hidden" name="id" value="#rc.id#">
			<div class="row">
				<div class="col-sm-6 form-group">
					<label for="type" class="col-form-label">Type</label>
					<cf_dropdown dropdownName="type" selectedValue="#rc.transactionDetails.type#" baseQuery="#rc.allCategoryTypes#" onclick="javascript: changeType(@@currValue);" />
				</div>
				<div class="col-sm-6 form-group">
					<label for="category" class="col-form-label">Category</label>
					<cf_dropdown dropdownName="category" selectedValue="#rc.transactionDetails.category#" baseQuery="#rc.allCategories#" onclick="javascript: changeCategory(@@currValue);" />
				</div>
				<div class="col-sm-6 form-group">
					<label for="category" class="col-form-label">Category</label>
					<input type="text" class="form-control" id="category" name="category" placeholder="Category" value="#rc.transactionDetails.category#">
				</div>
				<div class="col-sm-6 form-group">
					<label for="category" class="col-form-label">Category</label>
					<input type="text" class="form-control" id="category" name="category" placeholder="Category" value="#rc.transactionDetails.category#">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-8 col-sm-2">
					<input type="submit" class="btn btn-success" name="Submit" value="#rc.formSubmit#">
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
		</form>
<!--- 	</div>
</div> --->
</cfoutput>