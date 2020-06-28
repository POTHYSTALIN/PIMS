function showEditModal( elem, id ) {
	jQuery.post(
		"/transactions/banks/edit/" + id,
		function( res ) {
			// success function
			if( parseInt( id ) == 0 )
				jQuery( ".modal-title" ).html( "Add Bank" );
			else
				jQuery( ".modal-title" ).html( "Update Bank" );
			jQuery( ".modal-body" ).html( res );
			jQuery( "#myModal" ).modal();
		}
	);
	return false;
}

function showDeleteConfirmModal( elem, id ) {
	var confirmContent = '<h4>Are you sure to delete this bank?</h4><div class="row"><div class="col-sm-offset-8 col-sm-2"><button type="button" class="btn btn-danger" onclick="javascript: deleteBank(' + id + ')">Delete</button></div><div class="col-sm-2"><button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button></div></div>';
	jQuery( ".modal-title" ).html( "Confirm delete" );
	jQuery( ".modal-body" ).html( confirmContent );
	jQuery( "#myModal" ).modal({
		backdrop: "static",
		keyboard: false
	});
}

function deleteBank( id ) {
	jQuery( "#myModal" ).modal( "hide" );
	window.location.href = "/transactions/banks/delete/" + id;
}