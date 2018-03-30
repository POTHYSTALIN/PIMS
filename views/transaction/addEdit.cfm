<cfoutput>
<!--- Uncomment below lines if this page needs header --->
<!--- <div class="container">
	<div class="p-t-20"> --->
		<form action="#event.buildLink( lCase(rc.formAction) )#" method="post">
			<input type="hidden" name="id" value="#rc.id#">
			<div class="row">
				<div class="col-sm-6 form-group">
					<label for="type" class="col-form-label">Type</label>
					<div class="btn-group w-100">
						<button class="btn btn-secondary btn-sm dropdown-toggle-split w-100" type="button" data-toggle="dropdown" id="secTypeDropdown">
							<span class="pull-left">
								<cfif len(rc.transactionDetails.type)>
									#rc.transactionDetails.type#
								<cfelse>
									Select a type
								</cfif>
							</span>
							<span class="caret pull-right" style="position: relative; margin-top: 8px;"></span>
						</button>
						<ul class="dropdown-menu w-100">
							<cfloop query="#rc.allCategoryTypes#">
								<li><a href="##" onclick="javascript: changeType('1', 'SMS');">#rc.allCategoryTypes.name#</a></li>
							</cfloop>
						</ul>
						<input type="hidden" id="type" name="type" value="#rc.transactionDetails.type#">
					</div>
				</div>
				<div class="col-sm-6 form-group">
					<label for="category" class="col-form-label">Category</label>
					<div class="btn-group w-100">
						<button class="btn btn-secondary btn-sm dropdown-toggle-split w-100" type="button" data-toggle="dropdown" id="secTypeDropdown">
							<span class="pull-left">
								<cfif len(rc.transactionDetails.category)>
									#rc.transactionDetails.category#
								<cfelse>
									Select a category
								</cfif>
							</span>
							<span class="caret pull-right" style="position: relative; margin-top: 8px;"></span>
						</button>
						<ul class="dropdown-menu w-100">
							<cfloop query="#rc.allCategories#">
								<li><a href="##" onclick="javascript: changeType('1', 'SMS');">#rc.allCategories.name#</a></li>
							</cfloop>
						</ul>
						<input type="hidden" id="category" name="category" value="#rc.transactionDetails.category#">
					</div>
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