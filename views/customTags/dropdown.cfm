<cfoutput>
<cfparam name="attributes.dropdownName">
<cfparam name="attributes.selectedLabel" default="">
<cfparam name="attributes.selectedValue" default="">
<cfparam name="attributes.baseQuery">
<cfparam name="attributes.onclick" default="">
<cfparam name="attributes.optionValue" default="ID">
<cfparam name="attributes.optionLabel" default="name">
<cfparam name="attributes.data" default="#{}#">

<cfif isArray( attributes.baseQuery )>
	<!--- Convert static array as query --->
	<cfset temp = duplicate( attributes.baseQuery ) />
	<cfset attributes.baseQuery = queryNew( "id,name", "integer,varchar", temp ) />
	<!--- <cfdump var="#attributes#" /><cfabort /> --->
	<cfset attributes.selectedLabel = attributes.baseQuery.reduce( function( a,b ) {

		if( attributes.selectedValue == b.id ) { return b.name; }
	}, "") />
<cfdump var="#attributes#" /><cfabort />
</cfif>
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
				<li class="cursor"
					onclick="#replaceNoCase(attributes.onclick, "@@currValue", "#attributes.baseQuery[attributes.optionValue][attributes.baseQuery.currentrow]#", "ALL")#"
					<cfif structCount( attributes.data )>
						<cfloop collection="#attributes.data#" index="idx" item="itm">
							data-#idx#="#attributes.baseQuery[itm][attributes.baseQuery.currentRow]#"
						</cfloop>
					</cfif>
				>
					<a href="##">#attributes.baseQuery[attributes.optionLabel][attributes.baseQuery.currentrow]#</a>
				</li>
			</cfloop>
		</ul>
		<input type="hidden" id="#attributes.dropdownName#" name="#attributes.dropdownName#" value="#attributes.selectedValue#">
	</div>
</cfif>
</cfoutput>

<script>
	if( !window.changeDropdown ) {
		window.changeDropdown = function( dropdownId, value, selected, callback ) {
			let thisElem = jQuery( "#" + dropdownId );
			let thisListElem = jQuery( "#" + dropdownId + "Dropdown span:first" );
			let thisTextElem = jQuery( "#" + dropdownId + "Dropdown span:first" );
			if( value == null ) {
				thisTextElem.html( "Select a " + dropdownId );
				thisElem.val( 0 );
			} else {
				thisTextElem.html( jQuery( selected ).text() );
				thisElem.val( value );
			}

			if( callback != undefined && typeof callback == "function" ) {
				callback( thisElem, selected );
			} else if( callback != undefined ) {
				// callback is used, but the function is not defined
				alert( "callback is used, but the function is not defined" );
			}
		}
	}
</script>