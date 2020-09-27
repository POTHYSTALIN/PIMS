function showEditModal(elem, id) {
	jQuery.post(
		"/tips/tags/edit/" + id,
		function (res) {
			// success function
			if (parseInt(id) == 0)
				jQuery(".modal-title").html("Add Tag");
			else
				jQuery(".modal-title").html("Update Tag");
			jQuery(".modal-body").html(res);
			jQuery("#myModal").modal();
		}
	);
	return false;
}

function showDeleteConfirmModal(elem, id) {
	var confirmContent = '<p>Are you sure to delete this data?</p><div class="row"><div class="offset-9 col-sm-1 pr-0 pl-5 mr-3"><button type="button" class="btn btn-sm btn-danger" onclick="javascript: deleteTags(' + id + ')">Delete</button></div><div class="col-sm-1 p-0 ml-5"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Close</button></div></div>';
	jQuery(".modal-title").html("Confirm delete");
	jQuery(".modal-body").html(confirmContent);
	jQuery("#myModal").modal({
		backdrop: "static",
		keyboard: false
	});
}

function deleteTags(id) {
	$( "#myModal" ).modal( "hide" );
	window.location.href = "/tips/tags/delete/" + id;
}