<cfoutput>
	<div class="container-center">
		<div>&nbsp;</div>
		<div class="form-row justify-content-sm-end">
			<div class="col-1 ml-3">
				<button type="button" class="btn btn-success btn-sm" onclick="javascript: showEditModal(this, '0');">Add</button>
			</div>
		</div>
		<div>&nbsp;</div>
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th width="30%">Id</th>
					<th width="30%">employee</th>
					<th width="30%">System name</th>
					<th width="10%">Actions</th>
				</tr>
			</thead>
			<tbody>
			<cfloop query="prc.systemDetails">
				<tr>
					<td>#prc.inventoryDetails.id#</td>
					<td>#prc.inventoryDetails.employee#</td>
					<td>#prc.inventoryDetails.label#</td>
					<td>Test2</td>
				</tr>
			</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>