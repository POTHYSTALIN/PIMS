function toggleAddSecurity(elem) {
	if(jQuery(elem).prop("checked")){
		jQuery("#addSec").show();
		jQuery(".addSecContent").show();
	}else{
		jQuery("#addSec").hide();
		jQuery(".addSecContent").hide();
	}
}

function removeAddionalSecurity( id ){
	jQuery("#addSecContent" + id).remove();
}

function addNewSecurityItem(){
	if(jQuery("#addSecWrapper").children().last().length != 0)
		var id = (parseInt(jQuery("#addSecWrapper").children().last().attr("id").replace("addSecContent", ""))+1).toString();
	else
		var id = 1;
	var newElem = '<div class="form-group row addSecContent" id="addSecContent' + id + '" data-id="' + id + '">';
	newElem += '<div for="password" class="col-sm-3">';
	newElem += '<div class="dropdown">';
	// newElem += '<input type="hidden" name="addSec' + id + 'ID" value="0">';
	// newElem += '<select name="addSec' + id + 'Type">';
	// newElem += '<option value="sms">SMS</option>';
	// newElem += '<option value="email">Email</option>';
	// newElem += '<option value="others">Others</option>';
	// newElem += '</select>';
	newElem += '<button class="btn btn-secondary btn-sm dropdown-toggle-split" type="button" data-toggle="dropdown" id="secTypeDropdown' + id + '">SMS';
	newElem += '<span class="caret"></span></button>';
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
	newElem += '<i class="cursor glyphicon glyphicon-remove" onclick="' + "javascript: removeAddionalSecurity('" + id + "');" + '"></i>';
	newElem += '</div>';
	newElem += '</div>';
	jQuery("#addSecWrapper").html(jQuery("#addSecWrapper").html()+newElem);
}

function changeSecType(id, type) {
	jQuery("#secTypeDropdown" + id).html(type+' <span class="caret"></span>');
	jQuery("#addSec" + id + "Type").val(type);
}

function changeBoxFlag( isEnabled, isForced ) {
	if(typeof(isForced) == "undefined"){
		isForced = false;
	}
	if( !isForced ){
		// add a ajax call to update the flag in new table.
	}
	if(isEnabled) {
		window.location.href = "/list/password/downloadFromBox/true";
	} else {
		window.location.href = "/list/password";
	}
}

function showPassword(elem) {
	if( confirm("Are you sure to show/hide password?") ){
		jQuery(elem).parent().prev("td").find("span.hiddenPwd.orig").toggle();
		jQuery(elem).parent().prev("td").find("span.hiddenPwd.encrypted").toggle();
	}
}