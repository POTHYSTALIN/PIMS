<cfoutput>
	<div class="container-center">
		<!--- search pane --->
		<div>&nbsp;</div>
		<form>
			<div class="form-row">
				<div class="col-1">
					Search:
				</div>
				<div class="col-2">
					<input type="text" class="form-control input-sm" name="searchStr" value="#rc.searchStr#" placeholder="search">
				</div>
				<div class="col-1">
					<div class="form-check mt-2">
						<input type="checkbox" class="form-check-input" id="deleted" name="deleted" value="1" <cfif structKeyExists(rc, "deleted")>checked</cfif>>
						<label class="form-check-label" for="deleted">deleted</label>
					</div>
				</div>
				<div class="col-1">
					<button type="submit" class="btn btn-success btn-sm">Search</button>
				</div>
				<div class="col-3">
					<div class="form-check">
						<label class="form-check-label" for="autoSizingCheck">Download from Box.com</label>
						<div class="btn-group btn-toggle">
							<button type="button" data-checked="false" class="btn btn-sm <cfif !rc.downloadFromBox>btn-success active<cfelse>btn-default</cfif>" onclick="javascript: changeBoxFlag(this, false);">OFF</button>
							<button type="button" data-checked="true" class="btn btn-sm <cfif rc.downloadFromBox>btn-danger active<cfelse>btn-default</cfif>" onclick="javascript: changeBoxFlag(this, true);">ON</button>
						</div>
					</div>
				</div>
				<div class="col-1 ml-3">
					<button type="button" class="btn btn-success btn-sm" onclick="javascript: showEditModal(this, '0');">Add</button>
				</div>
			</div>
		</form>
		<div>&nbsp;</div>
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th width="30%">Site</th>
					<th width="30%">Username</th>
					<th width="30%">Password</th>
					<th width="10%">Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="#prc.passwordDetails#">
					<tr>
						<td>#prc.passwordDetails.site#</td>
						<td>#prc.passwordDetails.Username#</td>
						<td>
							<cfset currPwd = (len(prc.passwordDetails.password) ? decrypt(prc.passwordDetails.password, prc.passwordDetails.salt) : '')>
							<span class="hiddenPwd orig">#currPwd#</span>
							<span class="hiddenPwd encrypted">**********</span>

						</td>
						<td align="center">
							<i class="fas fa-eye cursor" onclick="javascript: showPassword(this);"></i> &nbsp;
							<i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#prc.passwordDetails.id#');"></i> &nbsp;
							<i class="fas fa-trash cursor text-danger" onclick="javascript: showDeleteConfirmModal(this, '#prc.passwordDetails.id#');"></a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-lg">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Update password details</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<p>Some text in the modal.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</cfoutput>