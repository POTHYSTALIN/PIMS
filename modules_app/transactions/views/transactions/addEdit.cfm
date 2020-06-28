<cfoutput>
<!--- Uncomment below lines if this page needs header --->
<!--- <div class="container">
	<div class="p-t-20"> --->
		<form action="#event.buildLink( lCase(prc.formAction) )#" method="post">
			<input type="hidden" name="id" value="#rc.id#">
			<div class="row">
				<div class="col-sm-6 form-group">
					<label for="category" class="col-form-label">Category</label>
					<cf_dropdown dropdownName="categoryID" selectedValue="#prc.currTransactionDetails.categoryID#" selectedLabel="#prc.currTransactionDetails.category#" baseQuery="#prc.allCategories#" onclick="javascript: changeDropdown('categoryID', @@currValue, this);" />
				</div>
				<div class="col-sm-6 form-group">
					<label for="type" class="col-form-label">Account ( Optional )</label>
					<cf_dropdown dropdownName="bankAccountID" selectedLabel="#prc.currTransactionDetails.accountID#" selectedValue="#val(prc.currTransactionDetails.bankAccountID)#" baseQuery="#prc.allBankAccounts#" optionValue="ID" optionLabel="accountID" onclick="javascript: changeDropdown('bankAccountID', @@currValue, this);" />
				</div>
				<div class="col-sm-6 form-group">
					<label for="category" class="col-form-label">Person</label>
					<cf_dropdown dropdownName="personID" optionLabel="personName" optionValue="ID" selectedValue="#prc.currTransactionDetails.personID#" selectedLabel="#prc.currTransactionDetails.personName#" baseQuery="#prc.allPersons#" onclick="javascript: changeDropdown('personID', @@currValue, this);" />
				</div>
				<div class="col-sm-6 form-group">
					<label for="amount" class="col-form-label">Amount</label>
					<input type="text" class="form-control" id="amount" name="amount" placeholder="Amount" value="#prc.currTransactionDetails.amount#">
				</div>
				<div class="col-sm-12 form-group">
					<label for="category" class="col-form-label">Description</label>
					<textarea class="form-control" name="description" id="description" rows="9">#prc.currTransactionDetails.description#</textarea>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-8 col-sm-2">
					<input type="submit" class="btn btn-success" name="Submit" value="#prc.formSubmit#">
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
		</form>
<!--- 	</div>
</div> --->
</cfoutput>