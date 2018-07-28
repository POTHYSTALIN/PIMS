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

		<!--- search pane --->
		<form action="#event.buildLink('list.password')#" class="form-inline" method="post">
			<div class="row">
				<div class="form-group col-sm-3 col-xl-3 col-lg-3">
					<label for="searchStr">Search:</label>
					<input type="text" class="form-control input-sm" name="searchStr" value="#rc.searchStr#" style="width: 75%">
				</div>
				<div class="checkbox col-sm-1 col-xl-1 col-lg-1">
					<input type="checkbox" name="deleted" value="1"<cfif structKeyExists(rc, "deleted")>checked</cfif>>
					<label>Deleted</label>
				</div>
				<div class="col-sm-1 col-xl-1 col-lg-1">
					<button type="submit" class="btn btn-success btn-sm">Search</button>
				</div>
				<div class="col-sm-3 col-xl-3 col-lg-3 checkbox">
					<label>
						Download from Box.com
					</label>
					<!--- <input data-toggle="toggle" data-on="Enabled" data-off="Disabled" data-onstyle="success" type="checkbox" name="downloadFromBox" <cfif rc.downloadFromBox>checked</cfif> onchange="javascript: changeBoxFlag(this.checked);"> --->
					<div class="btn-group btn-toggle">
						<button type="button" data-checked="false" class="btn btn-xs <cfif !rc.downloadFromBox>btn-primary active<cfelse>btn-default</cfif>" onclick="javascript: changeBoxFlag(this, false);">OFF</button>
						<button type="button" data-checked="true" class="btn btn-xs <cfif rc.downloadFromBox>btn-primary active<cfelse>btn-default</cfif>" onclick="javascript: changeBoxFlag(this, true);">ON</button>
					</div>
				</div>
				<div class="col-sm-1 col-sm-offset-3">
					<button type="button" class="btn btn-success btn-sm" onclick="javascript: showEditModal(this, '0');">Add</button>
				</div>
			</div>
			<div class="row">
				<cfif rc.downloadFromBox AND len(rc.boxFileID)>
					<div class="col-sm-2 col-xl-2 col-lg-2 pull-right p-r-10">
						<button type="button" class="btn btn-primary btn-sm pull-right" onclick="javascript: showSyncModal(this, '#rc.boxFileID#', 'download');">Download from Box.com</button>
					</div>
					<div class="col-sm-1 col-xl-1 col-lg-1 pull-right">
						<button type="button" class="btn btn-primary btn-sm" onclick="javascript: showSyncModal(this, '#rc.boxFileID#', 'upload');">Upload to Box.com</button>
					</div>
				</cfif>
			</div>
		</form>
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
				<cfloop query="#rc.passwordDetails#">
					<tr>
						<td>#rc.passwordDetails.site#</td>
						<td>#rc.passwordDetails.Username#</td>
						<td>
							<cfset currPwd = (len(rc.passwordDetails.password) ? decrypt(rc.passwordDetails.password, rc.passwordDetails.salt) : '')>
							<span class="hiddenPwd orig">#currPwd#</span>
							<span class="hiddenPwd encrypted">**********</span>

						</td>
						<td align="center">
							<i class="glyphicon glyphicon-eye-open cursor" onclick="javascript: showPassword(this);"></i>
							<i class="glyphicon glyphicon-edit cursor" onclick="javascript: showEditModal(this, '#rc.passwordDetails.id#');"></i> &nbsp;
							<i class="glyphicon glyphicon-trash cursor text-danger" onclick="javascript: showDeleteConfirmModal(this, '#rc.passwordDetails.id#');"></a>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Update password details</h4>
					</div>
					<div class="modal-body">
						<p>Some text in the modal.</p>
					</div>
				</div>
			</div>
		</div>

		<!--- box sync modal --->
		<!--- <div class="modal fade" id="boxSync" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Update password details</h4>
					</div>
					<div class="modal-body">
						<p>Some text in the modal.</p>
					</div>
				</div>
			</div>
		</div> --->
		<script>
			function showEditModal(elem, id){
				jQuery.post(
					"/update/password/" + id,
					function(res){
						// success function
						if(parseInt(id) == 0)
							jQuery(".modal-title").html("Add password details");
						else
							jQuery(".modal-title").html("Update password details");
						jQuery(".modal-body").html(res);
						jQuery("##myModal").modal();
					}
				);
				return false;
			}
			function showDeleteConfirmModal(elem, id){
				var confirmContent = "<h4>Are you sure to delete this data?</h4><div class='row'><div class='col-sm-offset-8 col-sm-2'><button type='button' class='btn btn-danger' onclick='javascript: deletePassword(" + id + ")'>Delete</button></div><div class='col-sm-2'><button type='button' class='btn btn-default' data-dismiss='modal'>Close</button></div></div>";
				jQuery(".modal-title").html("Confirm delete");
				jQuery(".modal-body").html(confirmContent);
				jQuery("##myModal").modal({
					backdrop: 'static',
					keyboard: false
				});
			}
			function deletePassword(id){
				$('##myModal').modal('hide');
				window.location.href = "#event.buildLink('delete.password')#/" + id;
			}

			// modal for sync details show
			function showSyncModal( elem, fileid, option ){
			 	jQuery(".modal-title").html(jQuery(elem).html());
				jQuery(".modal-body").html("<div style='text-align: center;'><img src='/assets/img/loading.gif' width='100' height='100'></div>");
				jQuery("##myModal").modal({
					backdrop: 'static',
					keyboard: false
				});
				if(option == "download"){
					jQuery(".modal-dialog").removeClass("modal-lg");
					var posturl = "/password/box/from/" + fileid;
				}else{
					jQuery(".modal-dialog").addClass("modal-lg");
					var posturl = "/password/box/to/" + fileid;
				}
				jQuery.post(
					posturl,
					function(res){
						// success function
						jQuery(".modal-body").html(res);
					}
				);
				return false;
			}
		</script>
	</div>

<!--- End --->
</cfoutput>
<!--- for modal window with ajax --->
<!--- https://jsfiddle.net/ednon5d1/ --->