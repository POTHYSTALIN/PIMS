function showEditModal(elem, id, hid) {
	var ajaxURL = "/mitrahsoft/sysinfo/item-details/edit/" + id;
	if( typeof(hid) === "undefined" ) {
		hid = 0;
	} else {
		ajaxURL += "/hid/" + hid;
	}
	// $('#myModal').on('show.bs.modal', function (e) {
	// 	$(this).find('.modal-content').load(ajaxURL);
	// });
	// jQuery("#myModal").modal();
	jQuery.post(
		ajaxURL,
		function (res) {
			// success function
			if (parseInt(id) == 0)
				jQuery(".modal-title").html("Add hardware details");
			else
				jQuery(".modal-title").html("Update hardware details");
			jQuery(".modal-body").html(res);
			jQuery("#myModal").modal();
			$('#addEditForm').removeData('validator');
			jQuery("#addEditForm").validate({
				invalidHandler: function(form, validator) {
					alert("invalid");
					jQuery(window).scrollTop(jQuery("#error_container").offset().top);
				},
				success: function(label) {
					alert("success");
					return false;
					label.remove();
					if(!jQuery("#errors ul li").length){
						jQuery("#error_container").css('display','none');
					}
				},
				submitHandler: function(form) {
					alert("submit");
					form.submit();
				},
				errorContainer: "#error_container",
				errorLabelContainer: "#errors ul",
				errorElement: "li",
				rules: {
					// simple rule, converted to {required:true}
					inventoryItemID: "required"
				},
				messages: {
					inventoryItemID: {
						required: "Please select an item"
					}
				},
			});
			// submitAddEdit();
		}
	);
	return false;
}

function showDeleteConfirmModal(elem, id) {
	var confirmContent = "<h4>Are you sure to delete this data?</h4><div class='row'><div class='col-sm-offset-8 col-sm-2'><button type='button' class='btn btn-danger' onclick='javascript: deleteProperty(" + id + ")'>Delete</button></div><div class='col-sm-2'><button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div></div>";
	jQuery(".modal-title").html("Confirm delete");
	jQuery(".modal-body").html(confirmContent);
	jQuery("#myModal").modal({
		backdrop: 'static',
		keyboard: false
	});
}

function deleteProperty(id) {
	$('#myModal').modal('hide');
	window.location.href = "/mitrahsoft/sysinfo/item-details/delete/" + id;
}

// function submitAddEdit(form) {
// 	console.log( "hi ");
// 	var currCombs = JSON.parse( jQuery("#allCombinations").val() );
// 	var currPropsList = jQuery("select.form-control");
// 	var currIDCombSelected = [];
// 	var currNameCombSelected = [];
// 	var isOK = true;
// 	var errorMsg = "";
// 	for( var i=0; i<currPropsList.length; i++ ) {
// 		currId = jQuery(currPropsList[i]).prop("id").replace("ID", "");
// 		thisVal = jQuery("#" + currId + "ID").val();
// 		if( thisVal == "" ) {
// 			isOK = false;
// 			errorMsg += "";
// 		}
// 		currIDCombSelected.push( thisVal );
// 		currNameCombSelected.push( jQuery("#" + currId + "ID option[value='" + thisVal + "']").text() );
// 	}
// 	currIDCombSelected = currIDCombSelected.join(" - ");
// 	currNameCombSelected = currNameCombSelected.join(" - ");
// 	// console.log( currCombs );
// 	// console.log( currIDCombSelected );
// 	// console.log( currNameCombSelected );
// 	// console.log( currIDCombSelected in currCombs );
// 	// console.log( currCombs[currIDCombSelected] === currNameCombSelected );
// 	// if( isOK )
// 		// $(form).submit();
// }
