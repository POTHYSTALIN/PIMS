<!-- development version, includes helpful console warnings -->
<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>

<cfoutput>
	<div id="app" class="container-center">
		<div> {{ message }} </div>
		<form action="#event.buildLink('transactions')#" class="form-inline mb-2" method="post">
			<div class="form-row justify-content-sm-end w-100 mt-3">
				<div class="form-group col-sm-2">
					<div class="input-group date">
						<div class="input-group-prepend">
							<span class="input-group-text">Start date</span>
						</div>
						<input type="text" class="form-control datepicker" id="searchFrom" name="searchFrom" placeholder="Please select a start date" value="#dateFormat( rc.searchFrom, "yyyy-mmm-dd" )#" required>
					
					</div>
				</div>
				<div class="form-group col-sm-2">
					<div class="input-group date">
						<div class="input-group-prepend">
							<span class="input-group-text">End date</span>
						</div>
						<input type="text" class="form-control datepicker" id="searchTo" name="searchTo" placeholder="Please select a end date" value="#dateFormat( rc.searchTo, "yyyy-mmm-dd" )#" required>
					</div>
				</div>
				<div class="col-sm-1 form-group">
					<select class="bootstrap-custom-select" id="personId" name="personId" multiple>
						<cfloop query="#prc.allPersons#">
							<option value="#prc.allPersons.id#" <cfif listFind( rc.personId, prc.allPersons.id )>selected</cfif>>#prc.allPersons.personName#</option>
						</cfloop>
					</select>
				</div>
				<div class="col-sm-1 ml-5 form-group">
					<select class="bootstrap-custom-select" id="accountId" name="accountId" multiple>
						<option value="0">Please select a person</option>
						<cfloop query="#prc.allBankAccounts#">
							<option value="#prc.allBankAccounts.id#" <cfif listFind( rc.accountId, prc.allBankAccounts.id )>selected</cfif>>#prc.allBankAccounts.accountID#</option>
						</cfloop>
					</select>
				</div>
				<div class="checkbox col-sm-1 ml-5 mt-2">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="deleted" name="deleted" value="1" <cfif structKeyExists(rc, "deleted")>checked</cfif>>
						<label class="custom-control-label float-left" for="deleted">Deleted</label>
					</div>
				</div>
				<div class="col-sm-1 mt-1">
					<button type="submit" class="btn btn-success btn-sm" name="search"><i class="fas fa-search"></i>&nbsp;&nbsp;Search</button>
				</div>
				<div class="col-sm-1 mt-1 ml-5">
					<!--- TODO: Need to make the report based on all transactions & balances table  --->
					<button type="button" class="btn btn-success btn-sm" onclick="javascript: showBalanceReport();"><i class="fas fa-download"></i>&nbsp;&nbsp;Balance report</button>
				</div>
				<div class="col-sm-1 ml-2 mt-1 pr-0">
					<cfif structKeyExists( rc, "debug" )>
						<button type="submit" class="btn btn-success btn-sm" name="archive"><i class="fas fa-archive"></i>&nbsp;&nbsp;Archive</button>
					</cfif>
				</div>
				<div class="col-sm-1 mt-1 pr-0">
					<button type="button" class="btn btn-success btn-sm float-right" onclick="javascript: showEditModal(this, '0');"><i class="fas fa-plus"></i>&nbsp;&nbsp;Add</button>
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

			<tbody>
				<tr v-for="trans in allTransactions" :key="trans.id">
					<td>{{ trans.Type }}</td>
					<td>{{ trans.Category }}</td>
					<td><i class="fas fa-rupee-sign"></i>&nbsp;&nbsp;{{ trans.amount }}</td>
					<td>{{ trans.fromPersonName }}</td>
					<td>{{ trans.toPersonName }}</td>
					<td>{{ trans.transactionDate }}</td>
					<td>{{ trans.description }}</td>
					<td class="text-center">
						<i class="fas fa-archive text-danger" v-if="trans.archived == 1"></i><span v-if="trans.archived == 1"> - </span>
						<i v-if="trans.deleted == 1" class="fas fa-times text-danger"></i><i v-else class="fas fa-check text-success"></i>
					</td>
					<td align="center">
						<i class="fas fa-edit cursor" onclick="javascript: showEditModal( this, trans.id );"></i>&nbsp;
						<i v-if="trans.deleted == 0" class="fas fa-trash cursor text-danger" title="delete" onclick="javascript: showDeleteConfirmModal(this, trans.id);"></i>
						<i v-else class="fas fa-check cursor text-warning" title="Undelete this transaction" onclick="javascript: showDeleteConfirmModal(this, trans.id, true);"></i>
					</td>
				</tr>
			</tbody>
			<!--- <cfloop query="#prc.allTransactions#">
				<tr>
					<td>#prc.allTransactions.type#</td>
					<td>#prc.allTransactions.category#</td>
					<td><i class="fas fa-rupee-sign"></i>&nbsp;&nbsp;#numberFormat( prc.allTransactions.amount, "__.__" )#</td>
					<td>#prc.allTransactions.fromPersonName#</td>
					<td>#prc.allTransactions.toPersonName#</td>
					<td>#dateFormat( prc.allTransactions.transactionDate, "yyyy-mmm-dd" )#</td>
					<td>#prc.allTransactions.description#</td>
					<td class="text-center">
						<cfif prc.allTransactions.archived><i class="fas fa-archive text-danger"> - </cfif><cfif prc.allTransactions.deleted><i class="fas fa-times text-danger"><cfelse><i class="fas fa-check text-success"></i></cfif>
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
			</cfloop> --->
		</table>
	</div>
</cfoutput>

<script>
	var app = new Vue({
		el: "#app",
		data: {
			message: "Hello Vue!",
			allTransactions: <cfoutput>#serializeJSON( prc.allTransactionsJSON )#</cfoutput>
		}
	});
</script>