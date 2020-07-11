function showEditModal(elem, id) {
	jQuery.post(
		"/mitrahsoft/sysinfo/items/edit/" + id,
		function (res) {
			// success function
			if (parseInt(id) == 0)
				jQuery(".modal-title").html("Add hardware");
			else
				jQuery(".modal-title").html("Update hardware");
			jQuery(".modal-body").html(res);
			jQuery("#myModal").modal();
		}
	);
	return false;
}

function showDeleteConfirmModal(elem, id) {
	var confirmContent = "<p>Are you sure to delete this data?</p><div class='row'><div class='col-sm-offset-8 col-sm-2'><button type='button' class='btn btn-sm btn-danger' onclick='javascript: deletePassword(" + id + ")'>Delete</button></div><div class='col-sm-2'><button type='button' class='btn btn-sm btn-secondary' data-dismiss='modal'>Close</button></div></div>";
	jQuery(".modal-title").html("Confirm delete");
	jQuery(".modal-body").html(confirmContent);
	jQuery("#myModal").modal({
		backdrop: 'static',
		keyboard: false
	});
}

function deletePassword(id) {
	$('#myModal').modal('hide');
	window.location.href = "/mitrahsoft/sysinfo/items/delete/" + id;
}