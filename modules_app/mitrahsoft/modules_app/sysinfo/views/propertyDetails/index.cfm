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
					<th width="10%">ID</th>
					<th width="20%">Hardware</th>
					<th width="20%">Property</th>
					<th width="20%">Details</th>
					<th width="10%">status</th>
					<th width="20%">Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="#prc.propertyDetails#">
					<tr>
						<td>#prc.propertyDetails.id#</td>
						<td>#prc.propertyDetails.inventoryItemName#</td>
						<td>#prc.propertyDetails.inventoryItemPropertyName#</td>
						<td>#prc.propertyDetails.inventoryItemPropertyValue#</td>
						<td><cfif prc.propertyDetails.deleted>Inactive<cfelse>Active</cfif></td>
						<td align="center">
							<i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#prc.propertyDetails.id#');"></i> &nbsp;
							<i class="fas fa-trash cursor text-danger" onclick="javascript: showDeleteConfirmModal(this, '#prc.propertyDetails.id#');"></a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>