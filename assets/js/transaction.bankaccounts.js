function changeDropdown(elem, value, cliked) {
	jQuery("#" + elem + "Dropdown span:first").html(jQuery(cliked).text());
	jQuery("#" + elem).val(value);
}