function showEditModal( elem, id ) {
	jQuery.post(
		"/transactions/category-types/edit/" + id,
		function( res ) {
			// success function
			if( parseInt( id ) == 0 )
				jQuery( ".modal-title" ).html( "Add Category Type" );
			else
				jQuery( ".modal-title" ).html( "Update Category Type" );
			jQuery( ".modal-body" ).html( res );
			jQuery( "#myModal" ).modal();
		}
	);
	return false;
}

function showDeleteConfirmModal( elem, id ) {
	var confirmContent = '<p>Are you sure to delete this Category Type?</p><div class="row"><div class="col-sm-offset-8 col-sm-2"><button type="button" class="btn btn-sm btn-danger" onclick="javascript: deleteCategoryType(' + id + ')">Delete</button></div><div class="col-sm-2"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Close</button></div></div>';
	jQuery( ".modal-title" ).html( "Confirm delete" );
	jQuery( ".modal-body" ).html( confirmContent );
	jQuery( "#myModal" ).modal({
		backdrop: "static",
		keyboard: false
	});
}

function deleteCategoryType( id ) {
	jQuery( "#myModal" ).modal( "hide" );
	window.location.href = "/transactions/category-types/delete/" + id;
}