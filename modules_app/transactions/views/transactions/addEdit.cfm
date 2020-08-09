<cfoutput>
<!--- Uncomment below lines if this page needs header --->
<!--- <div class="container">
	<div class="p-t-20"> --->
		<form id="addEditForm" action="#event.buildLink( lCase(prc.formAction) )#" method="post">
			<input type="hidden" name="id" value="#rc.id#">
			<div class="row">
				<!--- TYPE --->
				<div class="col-sm-6 form-group">
					<label for="category" class="col-form-label">Category</label>
					<select class="custom-select" id="categoryID" name="categoryID" required onchange="javascript: toggleFields( this );">
						<option value="">Please select a category</option>
						<cfloop query="#prc.allCategories#">
							<option value="#prc.allCategories.id#" <cfif prc.allCategories.id EQ prc.currTransactionDetails.categoryId>selected</cfif> data-type="#prc.allCategories.type#">#prc.allCategories.name#</option>
						</cfloop>
					</select>
					<div class="invalid-feedback">Please select a category</div>
				</div>

				<!--- MODE --->
				<div class="col-sm-6 form-group">
					<label for="modeId" class="col-form-label">Mode</label>
					<select class="custom-select" id="modeId" name="modeId" required onchange="javascript: toggleFields( this );">
						<option value="">Please select a mode</option>
						<cfloop query="#prc.allTransactionModes#">
							<option value="#prc.allTransactionModes.id#" <cfif prc.allTransactionModes.id EQ prc.currTransactionDetails.modeId>selected</cfif> data-mode="#prc.allTransactionModes.name#">#prc.allTransactionModes.name#</option>
						</cfloop>
					</select>
					<div class="invalid-feedback">Please select a mode</div>
				</div>

				<!--- TRANSACTION DATE --->
				<div class="col-sm-6 form-group">
					<label for="transactionDate" class="col-form-label">Date of Transaction</label>
					<div class="input-group date mb-3">
						<input type="text" class="form-control datepicker" id="transactionDate" name="transactionDate" placeholder="Please select a date" value="#dateFormat( prc.currTransactionDetails.transactionDate, "yyyy-mmm-dd" )#" required>
						<div class="input-group-append">
							<span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
						</div>
					</div>
					<div class="invalid-feedback">Please select a date</div>
				</div>

				<!--- AMOUNT --->
				<div class="col-sm-6 form-group">
					<label for="amount" class="col-form-label">Amount</label>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-rupee-sign"></i></span>
						</div>
						<input type="text" class="form-control" id="amount" name="amount" placeholder="Please enter the amount" value="#prc.currTransactionDetails.amount#" required>
						<div class="input-group-append">
							<span class="input-group-text">.00</span>
						</div>
						<div class="invalid-feedback">Please enter the amount</div>
					</div>
				</div>

				<!--- FROM --->
				<div class="col-sm-6 form-group">
					<label for="fromPersonId" class="col-form-label">From</label>
					<select class="custom-select" id="fromPersonId" name="fromPersonId" required>
						<option value="">Please select a person</option>
						<cfloop query="#prc.allPersons#">
							<option value="#prc.allPersons.id#" <cfif prc.allPersons.id EQ prc.currTransactionDetails.fromPersonId>selected</cfif>>#prc.allPersons.personName#</option>
						</cfloop>
					</select>
					<div class="invalid-feedback">Please select a person, who initiates this transaction</div>
				</div>
				<div class="col-sm-6 form-group <cfif arrayFindNoCase( [ "", "Cash" ], prc.currTransactionDetails.mode )>hidden</cfif>">
					<label for="fromAccountId" class="col-form-label">Account ( Optional )</label>
					<select class="custom-select" id="fromAccountId" name="fromAccountId">
						<option value="">Please select an account</option>
						<cfloop query="#prc.allBankAccounts#">
							<option value="#prc.allBankAccounts.id#" <cfif prc.allBankAccounts.id EQ prc.currTransactionDetails.fromAccountId>selected</cfif>>#prc.allBankAccounts.accountID#</option>
						</cfloop>
					</select>
				</div>

				<!--- TO --->
				<div class="col-sm-6 form-group">
					<label for="toPersonId" class="col-form-label">To</label>
					<select class="custom-select" id="toPersonId" name="toPersonId" required>
						<option value="">Please select an account</option>
						<cfloop query="#prc.allPersons#">
							<option value="#prc.allPersons.id#" <cfif prc.allPersons.id EQ prc.currTransactionDetails.toPersonId>selected</cfif>>#prc.allPersons.personName#</option>
						</cfloop>
					</select>
					<div class="invalid-feedback">Please select a person, who benefied from this transaction</div>
				</div>
				<div class="col-sm-6 form-group <cfif arrayFindNoCase( [ "", "Cash" ], prc.currTransactionDetails.mode )>hidden</cfif>">
					<label for="toAccountId" class="col-form-label">Account ( Optional )</label>
					<select class="custom-select" id="toAccountId" name="toAccountId">
						<option value="">Please select an account</option>
						<cfloop query="#prc.allBankAccounts#">
							<option value="#prc.allBankAccounts.id#" <cfif prc.allBankAccounts.id EQ prc.currTransactionDetails.toAccountId>selected</cfif>>#prc.allBankAccounts.accountID#</option>
						</cfloop>
					</select>
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