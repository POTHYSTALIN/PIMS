<cfoutput>
	<form action="#event.buildLink( lCase( prc.formAction ) )#" method="post">
		<input type="hidden" name="id" value="#rc.id#">
		<div class="form-group row">
			<label for="bankID" class="col-sm-2 col-form-label">Bank</label>
			<div class="col-sm-10">
				<cf_dropdown dropdownName="bankID" selectedValue="#prc.currBankAccountDetails.bankID#" selectedLabel="#prc.currBankAccountDetails.name#" baseQuery="#prc.allBanks#" onclick="javascript: changeDropdown('bankID', @@currValue, this);" />
			</div>
		</div>

		<div class="form-group row">
			<label for="accountID" class="col-sm-2 col-form-label">Account no</label>
			<div class="col-sm-10">
				<input class="form-control" type="text" name="accountID" value="#prc.currBankAccountDetails.accountID#" placeholder="Account no">
			</div>
		</div>

		<div class="form-group row">
			<label for="personID" class="col-sm-2 col-form-label">Person</label>
			<div class="col-sm-10">
				<cf_dropdown dropdownName="personID" optionLabel="personName" optionValue="ID" selectedValue="#prc.currBankAccountDetails.personID#" selectedLabel="#prc.currBankAccountDetails.personName#" baseQuery="#prc.allPersons#" onclick="javascript: changeDropdown('personID', @@currValue, this);" />
			</div>
		</div>

		<div class="form-group row">
			<label for="deleted" class="col-sm-2 col-form-label">Status</label>
			<div class="col-sm-10">
				<select id="deleted" name="deleted" class="form-control">
					<option value="0" <cfif prc.currBankAccountDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
					<option value="1" <cfif prc.currBankAccountDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
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