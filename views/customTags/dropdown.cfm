<cfoutput>
<cfparam name="attributes.dropdownName">
<cfparam name="attributes.selectedLabel" default="">
<cfparam name="attributes.selectedValue" default="">
<cfparam name="attributes.baseQuery">
<cfparam name="attributes.onclick" default="">
<cfparam name="attributes.optionValue" default="ID">
<cfparam name="attributes.optionLabel" default="name">

<style>
	.dropdown-menu.custom li {
		background-color: white;
	}
	.dropdown-menu.custom li a {
		color: black;
	}
	.dropdown-menu.custom li:hover {
		background-color: ##50d8af;
	}
	.dropdown-menu.custom li:hover a {
		color: white;
	}
</style>

<cfif thisTag.ExecutionMode is "start">
	<div class="btn-group w-100">
		<button class="btn btn-sm dropdown-toggle-split w-100 border border-light-grey rounded" type="button" data-toggle="dropdown" id="#attributes.dropdownName#Dropdown" aria-haspopup="true" aria-expanded="false">
			<span class="pull-left">
				<cfif len(attributes.selectedLabel)>
					#attributes.selectedLabel#
				<cfelseif len(attributes.selectedValue) AND NOT isNumeric(attributes.selectedValue)>
					#attributes.selectedValue#
				<cfelse>
					Select a #attributes.dropdownName#
				</cfif>
			</span>
			<span class="fas fa-caret-down float-right" style="position: relative; margin: 6px 0px;"></span>
		</button>
		<ul class="dropdown-menu custom w-100 border-light-grey">
			<cfloop query="#attributes.baseQuery#">
				<li><a href="##" onclick="#replaceNoCase(attributes.onclick, "@@currValue", "#attributes.baseQuery[attributes.optionValue][attributes.baseQuery.currentrow]#", "ALL")#">#attributes.baseQuery[attributes.optionLabel][attributes.baseQuery.currentrow]#</a></li>
			</cfloop>
		</ul>
		<input type="hidden" id="#attributes.dropdownName#" name="#attributes.dropdownName#" value="#attributes.selectedValue#">
	</div>
</cfif>
</cfoutput>

<script>
	if( !window.changeDropdown ) {
		window.changeDropdown = function( elem, value, cliked ) {
			jQuery("#" + elem + "Dropdown span:first").html( jQuery( cliked ).text() );
			jQuery("#" + elem).val(value);
		}
	}
</script>