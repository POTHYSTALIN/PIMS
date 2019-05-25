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
					<th width="30%">ID</th>
					<th width="30%">Item name</th>
					<th width="30%">status</th>
					<th width="10%">Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="#prc.items#">
					<tr>
						<td>#prc.items.id#</td>
						<td>#prc.items.name#</td>
						<td><cfif prc.items.deleted>Inactive<cfelse>Active</cfif></td>
						<td align="center">
							<!--- <a href="#event.buildLink("mitrahsoft.sysinfo.items.edit.#prc.items.id#")#">Edit</a> &nbsp;
							<a href="#event.buildLink("mitrahsoft.sysinfo.items.delete.#prc.items.id#")#">Delete</a> --->
							<i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#prc.items.id#');"></i> &nbsp;
							<i class="fas fa-trash cursor text-danger" onclick="javascript: showDeleteConfirmModal(this, '#prc.items.id#');"></a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>