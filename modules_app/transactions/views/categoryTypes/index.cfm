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
					<th>ID</th>
					<th>Category Type</th>
					<th width="10">Status</th>
					<th width="70">&nbsp;</th>
				</tr>
			</thead>
			<cfloop query="prc.allCategoryTypes">
				<tr>
					<td>#prc.allCategoryTypes.ID#</td>
					<td>#prc.allCategoryTypes.name#</td>
					<td class="text-center">
						<cfif prc.allCategoryTypes.deleted><i class="fas fa-times text-danger"><cfelse><i class="fas fa-check text-success"></i></cfif>
					</td>
					<td>
						<i class="fas fa-edit text-primary cursor" onclick="javascript: showEditModal(this, '#prc.allCategoryTypes.id#');"></i>
						<cfif NOT prc.allCategoryTypes.deleted>
							<i class="fas fa-trash text-danger" onclick="javascript: showDeleteConfirmModal(this, '#prc.allCategoryTypes.id#');"></i>
						</cfif>
					</td>
				</tr>
			</cfloop>
		</table>
	</div>
</cfoutput>