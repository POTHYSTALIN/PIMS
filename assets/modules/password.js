function toggleAddSecurity(elem) {
	if(jQuery(elem).prop("checked")){
		jQuery("#addSec").show();
		jQuery(".addSecContent").show();
	}else{
		jQuery("#addSec").hide();
		jQuery(".addSecContent").hide();
	}
}

function removeAddionalSecurity( id ) {
	jQuery("#addSecContent" + id).remove();
}

function addNewSecurityItem() {
	if(jQuery("#addSecWrapper").children().last().length != 0) {
		var id = (parseInt(jQuery("#addSecWrapper").children().last().attr("id").replace("addSecContent", ""))+1).toString();
	} else {
		var id = 1;
	}
	var newElem = '<div class="form-group row addSecContent" id="addSecContent' + id + '" data-id="' + id + '">';
	newElem += '<div for="password" class="col-sm-3">';
	newElem += '<div class="dropdown">';
	newElem += '<button class="btn btn-secondary btn-sm dropdown-toggle-split" type="button" data-toggle="dropdown" id="secTypeDropdown' + id + '">SMS';
	newElem += '<span class="fas fa-angle-down"></span></button>';
	newElem += '<ul class="dropdown-menu">';
	newElem += '<li><a href="#" onclick="javascript: changeSecType(\''+ id + '\', \'SMS\');">SMS</a></li>';
	newElem += '<li><a href="#" onclick="javascript: changeSecType(\''+ id + '\', \'Email\');">Email</a></li>';
	newElem += '<li><a href="#" onclick="javascript: changeSecType(\''+ id + '\', \'Others\');">Others</a></li>';
	newElem += '</ul>';
	newElem += '<input type="hidden" id="addSec' + id + 'ID" name="addSec'+ id + 'ID" value="' + id + '">';
	newElem += '<input type="hidden" id="addSec' + id + 'Type" name="addSec' + id + 'Type" value="SMS">';
	newElem += '</div>';
	newElem += '</div>';
	newElem += '<div class="col-sm-7">';
	newElem += '<input type="text" class="form-control input-sm" name="addSec' + id + 'Details" value="">';
	newElem += '</div>';
	newElem += '<div class="col-sm-2">';
	newElem += '<i class="cursor text-danger fas fa-times-circle" onclick="' + "javascript: removeAddionalSecurity('" + id + "');" + '"></i>';
	newElem += '</div>';
	newElem += '</div>';
	jQuery("#addSecWrapper").html(jQuery("#addSecWrapper").html()+newElem);
}

function changeSecType(id, type) {
	jQuery("#secTypeDropdown" + id).html(type+' <span class="fas fa-angle-down"></span>');
	jQuery("#addSec" + id + "Type").val(type);
}

function changeBoxFlag( elem, isEnabled, isForced ) {
	var sib = jQuery(elem).siblings(".btn")[0];
	jQuery(elem).toggleClass('active');
	jQuery(elem).toggleClass("btn-danger");
	jQuery(elem).toggleClass("btn-primary");
	jQuery(sib).toggleClass('active');
	jQuery(sib).toggleClass("btn-danger");
	jQuery(sib).toggleClass("btn-primary");
	if(typeof(isForced) == "undefined") {
		isForced = false;
	}
	if( !isForced ) {
		// add a ajax call to update the flag in new table.
	}
	if( isEnabled ) {
		window.location.href = "/password/list/downloadFromBox/true";
	} else {
		window.location.href = "/password/list";
	}
}

function showPassword(elem) {
	if( confirm("Are you sure to show/hide password?") ){
		console.log(jQuery(elem).parent().prev("td").find("span.hiddenPwd.orig"));
		jQuery(elem).parent().prev("td").find("span.hiddenPwd.orig").toggle();
		jQuery(elem).parent().prev("td").find("span.hiddenPwd.encrypted").toggle();
	}
}

function showEditModal(elem, id) {
	jQuery.post(
		"/password/update/" + id,
		function (res) {
			// success function
			if (parseInt(id) == 0)
				jQuery(".modal-title").html("Add password details");
			else
				jQuery(".modal-title").html("Update password details");
			jQuery(".modal-body").html(res);
			jQuery("#myModal").modal();
		}
	);
	return false;
}

function showDeleteConfirmModal(elem, id) {
	var confirmContent = "<p>Are you sure to delete this data?</p><div class='row'><div class='offset-9 col-sm-1 pr-0 pl-5 mr-3'><button type='button' class='btn btn-sm btn-danger' onclick='javascript: deletePassword(" + id + ")'>Delete</button></div><div class='col-sm-1 p-0 ml-5'><button type='button' class='btn btn-sm btn-secondary' data-dismiss='modal'>Close</button></div></div>";
	jQuery(".modal-title").html("Confirm delete");
	jQuery(".modal-body").html(confirmContent);
	jQuery("#myModal").modal({
		backdrop: 'static',
		keyboard: false
	});
}

function deletePassword(id) {
	$('#myModal').modal('hide');
	window.location.href = "/password/delete/" + id;
}

// modal for sync details show
function showSyncModal( elem, fileid, option ) {
	jQuery(".modal-title").html(jQuery(elem).html());
	jQuery(".modal-body").html("<div style='text-align: center;'><img src='/assets/img/loading.gif' width='100' height='100'></div>");
	jQuery("#myModal").modal({
		backdrop: 'static',
		keyboard: false
	});
	if(option == "download") {
		jQuery(".modal-dialog").removeClass("modal-lg");
		var posturl = "/password/box/from/" + fileid;
	} else {
		jQuery(".modal-dialog").addClass("modal-lg");
		var posturl = "/password/box/to/" + fileid;
	}
	jQuery.post(
		posturl,
		function(res) {
			// success function
			jQuery(".modal-body").html(res);
		}
	);
	return false;
}