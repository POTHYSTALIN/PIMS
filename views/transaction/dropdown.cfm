<cfparam name="attributes.dropdownName" default="type">
<cfparam name="attributes.selectedType" default="">
<cfparam name="attributes.baseQuery" defau>

<!--- <cfif attributes.dropdownName EQ "type">
</cfif> --->

<div class="btn-group w-100">
	<button class="btn btn-secondary btn-sm dropdown-toggle-split w-100" type="button" data-toggle="dropdown" id="secTypeDropdown">
		<span class="pull-left">
			<cfif len(attributes.selectedType)>
				#attributes.selectedType#
			<cfelse>
				Select a #attributes.dropdownName#
			</cfif>
		</span>
		<span class="caret pull-right" style="position: relative; margin-top: 8px;"></span>
	</button>
	<ul class="dropdown-menu w-100">
		<cfloop query="#attributes.baseQuery#">
			<li><a href="##" onclick="javascript: changeType('1', 'SMS');">#attributes.baseQuery.name#</a></li>
		</cfloop>
	</ul>
	<input type="hidden" id="type" name="type" value="#rc.transactionDetails.type#">
</div>