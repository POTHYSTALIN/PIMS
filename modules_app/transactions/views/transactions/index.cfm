<cfoutput>
	<div class="container-center">
		<form action="#event.buildLink('transactions')#" class="form-inline mb-2" method="post">
			<div class="form-row justify-content-sm-end w-100 mt-3">
				<div class="form-group col-sm-3">
					<label for="searchStr">Search&nbsp;&nbsp;</label>
					<input type="text" class="form-control input-sm" name="searchStr" value="#rc.searchStr#" style="width: 75%">
				</div>
				<div class="checkbox col-sm-1 mt-2">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="deleted" name="deleted" value="1" <cfif structKeyExists(rc, "deleted")>checked</cfif>>
						<label class="custom-control-label float-left" for="deleted">Deleted</label>
					</div>
				</div>
				<div class="col-sm-1 mt-1">
					<button type="submit" class="btn btn-success btn-sm"><i class="fas fa-search"></i> Search</button>
				</div>
				<div class="offset-5 col-sm-1 mt-1">
					<!--- TODO: Need to make the report based on all transactions & balances table  --->
					<button type="button" class="btn btn-success btn-sm" onclick="javascript: showBalanceReport();"><i class="fas fa-download"></i> Balance report</button>
				</div>
				<div class="col-sm-1 mt-1 pr-0">
					<button type="button" class="btn btn-success btn-sm float-right" onclick="javascript: showEditModal(this, '0');"><i class="fas fa-plus"></i> Add</button>
				</div>
			</div>
		</form>

		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th width="25%">Type</th>
					<th width="25%">Category</th>
					<th width="25%">Person</th>
					<th width="15%">Amount</th>
					<th width="10%">Actions</th>
				</tr>
			</thead>
			<cfloop query="#rc.allTransactions#">
				<tr>
					<td>#rc.allTransactions.type#</td>
					<td>#rc.allTransactions.category#</td>
					<td>#rc.allTransactions.fromPersonName#</td>
					<td>#rc.allTransactions.amount#</td>
					<td align="center">
						<i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#rc.allTransactions.id#');"></i> &nbsp;
						<i class="fas fa-trash cursor text-danger" onclick="javascript: showDeleteConfirmModal(this, '#rc.allTransactions.id#');"></a></td>
				</tr>
			</cfloop>
		</table>
	</div>
</cfoutput>