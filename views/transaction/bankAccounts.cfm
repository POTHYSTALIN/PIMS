<cfparam name="rc.id" default="0">
<cfparam name="rc.msg" default="">
<cfparam name="rc.msgAction" default="">
<cfparam name="rc.searchStr" default="">
<script type="text/javascript">
	jQuery(function(){
		setTimeout(function(){
			jQuery("div.alert").slideUp(1000);
		},10000);
	});
</script>
<cfoutput>
<div class="container">
	<div style="min-height: 10px;">&nbsp;</div>
	<cfif len(rc.msg) AND rc.msgAction EQ "Error">
		<div class="alert alert-dismissible alert-danger" role="alert">
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<strong>Error!</strong> #rc.msg#
		</div>
	<cfelseif len(rc.msg) AND rc.msgAction EQ "Success">
		<div class="alert alert-dismissible alert-success" role="alert">
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<strong>Success!</strong> #rc.msg#
		</div>
	</cfif>

	<div class="row">
		<div class="col-xs-6">
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th>ID</th>
						<th>Bank</th>
						<th>Account no</th>
						<th>Person</th>
						<th width="10">Status</th>
						<th width="70">&nbsp;</th>
					</tr>
				</thead>
				<cfloop query="prc.allBankAccounts">
					<tr class="#iif(prc.allBankAccounts.deleted, "'negative'", "'positive'")#">
						<td>#prc.allBankAccounts.ID#</td>
						<td>#prc.allBankAccounts.shortname#</td>
						<td>#prc.allBankAccounts.accountID#</td>
						<td>#prc.allBankAccounts.personName#</td>
						<td class="text-center">
							<cfif prc.allBankAccounts.deleted><i class="glyphicon glyphicon-remove text-danger"><cfelse><i class="glyphicon glyphicon-ok text-success"></i></cfif>
						</td>
						<td>
							<a href="#event.BuildLink( LinkTo='edit.bankAccount.#prc.allBankAccounts.ID#')#" title="Edit"><i class="glyphicon glyphicon-edit text-primary"></i></a>
							<cfif NOT prc.allBankAccounts.deleted>
								<a href="#event.BuildLink( LinkTo='delete.bankAccount.#prc.allBankAccounts.ID#')#" title="Delete"><i class="glyphicon glyphicon-remove text-danger"></i></a>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</table>
		</div>
		<div class="col-xs-6">
			<form class="ui form grid" action="#event.BuildLink('new.bankAccount')#" method="post">
				<input type="hidden" name="ID" value="#val(prc.currBankAccountDetails.ID)#">
				<div class="form-group col-xs-6">
					<label for="name">Bank</label>
					<cf_dropdown dropdownName="bankID" selectedValue="#prc.currBankAccountDetails.bankID#" selectedLabel="#prc.currBankAccountDetails.name#" baseQuery="#prc.allBanks#" onclick="javascript: changeDropdown('bankID', @@currValue, this);" />
				</div>
				<div class="form-group col-xs-6">
					<label>Account no</label>
					<input class="form-control" type="text" name="accountID" value="#prc.currBankAccountDetails.accountID#" placeholder="Account no">
				</div>
				<div class="form-group col-xs-6">
					<label>Person</label>
					<cf_dropdown dropdownName="personID" optionLabel="personName" optionValue="ID" selectedValue="#prc.currBankAccountDetails.personID#" selectedLabel="#prc.currBankAccountDetails.personName#" baseQuery="#prc.allPersons#" onclick="javascript: changeDropdown('personID', @@currValue, this);" />
				</div>
				<div class="form-group col-xs-6">
					<label>Status</label>
					<select name="deleted" class="form-control">
						<option value="0" <cfif prc.currBankAccountDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
						<option value="1" <cfif prc.currBankAccountDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
					</select>
				</div>
				<div class="form-group col-xs-6">
					<input class="btn btn-success" type="submit" name="Add" value="#iif(val(prc.currBankAccountDetails.id), "'Update'", "'Add'")#">
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>