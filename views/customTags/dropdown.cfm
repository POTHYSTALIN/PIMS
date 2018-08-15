<cfoutput>
<cfparam name="attributes.dropdownName">
<cfparam name="attributes.selectedLabel" default="">
<cfparam name="attributes.selectedValue" default="">
<cfparam name="attributes.baseQuery">
<cfparam name="attributes.onclick" default="">
<cfparam name="attributes.optionValue" default="ID">
<cfparam name="attributes.optionLabel" default="name">

<cfif thisTag.ExecutionMode is "start">
	<div class="btn-group w-100">
		<button class="btn btn-secondary btn-sm dropdown-toggle-split w-100" type="button" data-toggle="dropdown" id="#attributes.dropdownName#Dropdown">
			<span class="pull-left">
				<cfif len(attributes.selectedLabel)>
					#attributes.selectedLabel#
				<cfelseif len(attributes.selectedValue) AND NOT isNumeric(attributes.selectedValue)>
					#attributes.selectedValue#
				<cfelse>
					Select a #attributes.dropdownName#
				</cfif>
			</span>
			<span class="caret pull-right" style="position: relative; margin-top: 8px;"></span>
		</button>
		<ul class="dropdown-menu w-100">
			<cfloop query="#attributes.baseQuery#">
				<li><a href="##" onclick="#replaceNoCase(attributes.onclick, "@@currValue", "#attributes.baseQuery[attributes.optionValue][attributes.baseQuery.currentrow]#", "ALL")#">#attributes.baseQuery[attributes.optionLabel][attributes.baseQuery.currentrow]#</a></li>
			</cfloop>
		</ul>
		<input type="hidden" id="#attributes.dropdownName#" name="#attributes.dropdownName#" value="#attributes.selectedValue#">
	</div>
</cfif>
</cfoutput>