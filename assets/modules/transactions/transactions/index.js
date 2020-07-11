function showEditModal( elem, id ) {
	jQuery.post(
		"/transactions/edit/" + id,
		function (res) {
			// success function
			if( parseInt( id ) == 0 )
				jQuery( ".modal-title" ).html( "Add transaction" );
			else
				jQuery( ".modal-title" ).html( "Update transaction" );
			jQuery( ".modal-body" ).html( res );
			jQuery( "#myModal" ).modal();
		}
	);
	return false;
}

function showDeleteConfirmModal( elem, id ) {
	var confirmContent = '<p>Are you sure to delete this transaction?</p><div class="row"><div class="col-sm-offset-8 col-sm-2"><button type="button" class="btn btn-sm btn-danger" onclick="javascript: deleteTransaction(" + id + ")">Delete</button></div><div class="col-sm-2"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Close</button></div></div>';
	jQuery( ".modal-title" ).html( "Confirm delete" );
	jQuery( ".modal-body" ).html( confirmContent );
	jQuery( "#myModal" ).modal({
		backdrop: "static",
		keyboard: false
	});
}

function deleteTransaction( id ) {
	$( "#myModal" ).modal( "hide" );
	window.location.href = "/transactions/delete/" + id;
}