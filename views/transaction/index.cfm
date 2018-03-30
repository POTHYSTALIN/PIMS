<cfparam name="rc.id" default="0">
<cfparam name="rc.msg" default="">
<cfparam name="rc.msgAction" default="">
<cfparam name="rc.searchStr" default="">
<style type="text/css">
	/* For larger modal window */
	@media (min-width: 768px) {
		.modal-xlg {
			width: 900px;
			margin: 30px auto;
		}
	}
</style>
<script type="text/javascript">
	jQuery(function(){
		window.addEventListener('load', function () {
			// At first, let's check if we have permission for notification
			// If not, let's ask for it
			if (window.Notification && Notification.permission !== "granted") {
				Notification.requestPermission(function (status) {
					if (Notification.permission !== status) {
						Notification.permission = status;
					}
				});
			}
		});
		setTimeout(function(){
			jQuery("div.alert").slideUp(1000);
		},10000);

		i = 0;
		checkEvents();
		setInterval(function(){
			// This will call every one hour to check for a new event
			// This show notifiaction should be called whenever an event available
			checkEvents();
		},10000);
	});

	function checkEvents(){
		showNotification("Hi Pothys, This is a test notification!");
	}

	function showNotification(msg){
		if (window.Notification && Notification.permission === "granted"){
			window["notifications" + i] = new Notification(msg + i, {tag: 'soManyNotification' + i, body: 'Do you like this notifications?', data: 'I like peas.'});
			window["notifications" + i].onclick = function(event){
				event.preventDefault();
				alert("Test");
			}
			i++;
		}else if (window.Notification && Notification.permission !== "denied"){
			Notification.requestPermission(function (status) {
				// If the user said okay
				if (status === "granted") {
					var i = 0;
					// Using an interval cause some browsers (including Firefox) are blocking notifications if there are too much in a certain time.
					var interval = window.setInterval(function () {
						// Thanks to the tag, we should only see the "Hi! 9" notification 
						var n = new Notification("Hi! " + i, {tag: 'soManyNotification' + i, body: 'Do you like my body?'});
						if (i++ == 9) {
							window.clearInterval(interval);
						}
					}, 200);
				}
				// Otherwise, we can fallback to a regular modal alert
				else {
					alert("Permission denied");
				}
			});
		}else{
		}
	}
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
				<div class="form-group col-sm-3">
					<label for="searchStr">Search:</label>
					<input type="text" class="form-control input-sm" name="searchStr" value="#rc.searchStr#" style="width: 75%">
				</div>
				<div class="checkbox col-sm-1">
					<input type="checkbox" name="deleted" value="1"<cfif structKeyExists(rc, "deleted")>checked</cfif>>
					<label>Deleted</label>
				</div>
				<div class="col-sm-1">
					<button type="submit" class="btn btn-success btn-sm">Search</button>
				</div>
				<div class="col-sm-offset-6 col-sm-1">
					<button type="button" class="btn btn-success btn-sm" onclick="javascript: showEditModal(this, '0');">Add</button>
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
			<tbody>
				<cfloop query="#rc.allTransactions#">
					<tr>
						<td>#rc.allTransactions.type#</td>
						<td>#rc.allTransactions.category#</td>
						<td>#rc.allTransactions.person#</td>
						<td>#rc.allTransactions.amount#</td>
						<td align="center">
							<i class="glyphicon glyphicon-edit cursor" onclick="javascript: showEditModal(this, '#rc.allTransactions.id#');"></i> &nbsp;
							<i class="glyphicon glyphicon-trash cursor text-danger" onclick="javascript: showDeleteConfirmModal(this, '#rc.allTransactions.id#');"></a></td>
					</tr>
				</cfloop>
			</tbody>
		</table>

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-xlg">
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
		<script>
			function showEditModal(elem, id){
				jQuery.post(
					"/edit/transaction/" + id,
					function(res){
						// success function
						if(parseInt(id) == 0)
							jQuery(".modal-title").html("Add transaction details");
						else
							jQuery(".modal-title").html("Update transaction details");
						jQuery(".modal-body").html(res);
						jQuery("##myModal").modal();
					}
				);
				return false;
			}
			function showDeleteConfirmModal(elem, id){
				var confirmContent = "<h4>Are you sure to delete this data?</h4><div class='row'><div class='col-sm-offset-8 col-sm-2'><button type='button' class='btn btn-danger' onclick='javascript: deleteTransaction(" + id + ")'>Delete</button></div><div class='col-sm-2'><button type='button' class='btn btn-default' data-dismiss='modal'>Close</button></div></div>";
				jQuery(".modal-title").html("Confirm delete");
				jQuery(".modal-body").html(confirmContent);
				jQuery("##myModal").modal();
			}
			function deleteTransaction(id){
				$('##myModal').modal('hide');
				window.location.href = "#event.buildLink('delete.transaction')#/" + id;
			}
		</script>
	</div>

<!--- End --->
</cfoutput>
<!--- for modal window with ajax --->
<!--- https://jsfiddle.net/ednon5d1/ --->