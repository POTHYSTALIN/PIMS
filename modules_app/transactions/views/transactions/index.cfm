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
					<th width="10%">Type</th>
					<th width="15%">Category</th>
					<th width="10%">Amount</th>
					<th width="10%">From</th>
					<th width="10%">To</th>
					<th width="10%">Date</th>
					<th width="20%">Details</th>
					<th width="5%" class="text-center">Status</th>
					<th width="10%" class="text-center">Actions</th>
				</tr>
			</thead>
			<cfloop query="#prc.allTransactions#">
				<tr>
					<td>#prc.allTransactions.type#</td>
					<td>#prc.allTransactions.category#</td>
					<td><i class="fas fa-rupee-sign"></i> #numberFormat( prc.allTransactions.amount, "__.__" )#</td>
					<td>#prc.allTransactions.fromPersonName#</td>
					<td>#prc.allTransactions.toPersonName#</td>
					<td>#dateFormat( prc.allTransactions.transactionDate, "yyyy-mmm-dd" )#</td>
					<td>#prc.allTransactions.description#</td>
					<td class="text-center">
						<cfif prc.allTransactions.deleted><i class="fas fa-times text-danger"><cfelse><i class="fas fa-check text-success"></i></cfif>
					</td>
					<td align="center">
						<i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#prc.allTransactions.id#');"></i>&nbsp;
						<cfif NOT prc.allTransactions.deleted>
							<i class="fas fa-trash cursor text-danger" title="delete" onclick="javascript: showDeleteConfirmModal(this, '#prc.allTransactions.id#');"></i>
						<cfelse>
							<i class="fas fa-check cursor text-warning" title="Undelete this transaction" onclick="javascript: showDeleteConfirmModal(this, '#prc.allTransactions.id#', true);"></i>
						</cfif>
					</td>
				</tr>
			</cfloop>
		</table>
	</div>
</cfoutput>