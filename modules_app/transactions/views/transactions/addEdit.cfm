<cfoutput>
<!--- Uncomment below lines if this page needs header --->
<!--- <div class="container">
	<div class="p-t-20"> --->
		<form action="#event.buildLink( lCase(prc.formAction) )#" method="post">
			<input type="hidden" name="id" value="#rc.id#">
			<div class="row">
				<!--- TYPE --->
				<div class="col-sm-6 form-group">
					<label for="category" class="col-form-label">Particular</label>
					<cf_dropdown dropdownName="categoryID" selectedValue="#prc.currTransactionDetails.categoryID#" selectedLabel="#prc.currTransactionDetails.category#" baseQuery="#prc.allCategories#" onclick="javascript: changeDropdown('categoryID', @@currValue, this);" />
				</div>

				<!--- TRANSACTION DATE --->
				<div class="col-sm-6 form-group">
					<label for="transactionDate" class="col-form-label">Date</label>
					<input type="text" class="form-control" id="transactionDate" name="transactionDate" placeholder="Date of Transaction ( yyyy-mmm-dd )" value="#dateFormat( prc.currTransactionDetails.transactionDate, "yyyy-mmm-dd" )#">
				</div>

				<!--- MODE --->
				<div class="col-sm-6 form-group">
					<label for="modeId" class="col-form-label">Mode</label>
					<cf_dropdown dropdownName="modeId" selectedValue="#prc.currTransactionDetails.modeId#" selectedLabel="#prc.currTransactionDetails.mode#" baseQuery="#prc.allTransactionModes#" onclick="javascript: changeDropdown('modeId', @@currValue, this);" />
				</div>

				<!--- AMOUNT --->
				<div class="col-sm-6 form-group">
					<label for="amount" class="col-form-label">Amount</label>
					<input type="text" class="form-control" id="amount" name="amount" placeholder="Amount" value="#prc.currTransactionDetails.amount#">
				</div>

				<!--- FROM --->
				<div class="col-sm-6 form-group">
					<label for="fromPersonId" class="col-form-label">From</label>
					<cf_dropdown dropdownName="fromPersonId" optionLabel="personName" optionValue="ID" selectedValue="#prc.currTransactionDetails.fromPersonId#" selectedLabel="#prc.currTransactionDetails.fromPersonName#" baseQuery="#prc.allPersons#" onclick="javascript: changeDropdown('fromPersonId', @@currValue, this);" />
				</div>
				<div class="col-sm-6 form-group">
					<label for="fromAccountId" class="col-form-label">Account ( Optional )</label>
					<cf_dropdown dropdownName="fromAccountId" selectedLabel="#prc.currTransactionDetails.fromAccount#" selectedValue="#val(prc.currTransactionDetails.fromAccountId)#" baseQuery="#prc.allBankAccounts#" optionValue="ID" optionLabel="accountID" onclick="javascript: changeDropdown('fromAccountId', @@currValue, this);" />
				</div>

				<!--- TO --->
				<div class="col-sm-6 form-group">
					<label for="toPersonId" class="col-form-label">To</label>
					<cf_dropdown dropdownName="toPersonId" optionLabel="personName" optionValue="ID" selectedValue="#prc.currTransactionDetails.toPersonId#" selectedLabel="#prc.currTransactionDetails.toPersonName#" baseQuery="#prc.allPersons#" onclick="javascript: changeDropdown('toPersonId', @@currValue, this);" />
				</div>
				<div class="col-sm-6 form-group">
					<label for="toAccountId" class="col-form-label">Account ( Optional )</label>
					<cf_dropdown dropdownName="toAccountId" selectedLabel="#prc.currTransactionDetails.toAccount#" selectedValue="#val(prc.currTransactionDetails.toAccountId)#" baseQuery="#prc.allBankAccounts#" optionValue="ID" optionLabel="accountID" onclick="javascript: changeDropdown('toAccountId', @@currValue, this);" />
				</div>

				<div class="col-sm-12 form-group">
					<label for="category" class="col-form-label">Description</label>
					<textarea class="form-control" name="description" id="description" rows="9">#prc.currTransactionDetails.description#</textarea>
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
<!--- 	</div>
</div> --->
</cfoutput>