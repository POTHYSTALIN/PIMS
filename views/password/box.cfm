<cfoutput>
<table class="w-100">
	<thead>
		<tr>
			<th class="align-center" width="20%" valign="center" rowspan="2">Site</th>
			<th class="align-center" width="20%" valign="center" rowspan="2">Username</th>
			<th class="align-center" width="20%" valign="center" rowspan="2">Password</th>
			<th class="align-center" width="40%" valign="center" colspan="2">Additional Details</th>
		</tr>
		<tr>
			<th class="align-center" width="20%">Type</th>
			<th class="align-center" width="30%">Details</th>
		</tr>
	</thead>
	<tbody>
		<!--- <cfdump var="#rc.boxData#" /><cfabort /> --->
		<cfloop array="#rc.boxData#" index="itm">
			<tr>
				<td class="align-center" rowspan="#(arrayLen(itm.additional)?:1)#">#itm.site#</td>
				<td class="align-center" rowspan="#(arrayLen(itm.additional)?:1)#">#itm.username#</td>
				<td class="align-center" rowspan="#(arrayLen(itm.additional)?:1)#">#decrypt(itm.password, itm.salt)#</td>
				<cfloop from="0" to="#arrayLen(itm.additional)-1#" index="idx">
						<td class="align-center">#itm.additional[idx+1].securityType#</td>
						<td class="align-center">#itm.additional[idx+1].details#</td>
					</tr>
					<tr>
				</cfloop>
				<cfif NOT arrayLen(itm.additional)>
					<td class="align-center">&nbsp;</td>
					<td class="align-center">&nbsp;</td>
				</cfif>
			</tr>
		</cfloop>
	</tbody>
</table>

<form action="#event.buildLink('password.syncbox')#" method="post">
	<input type="hidden" name="fileid" value="#rc.fileid#">
	<input type="hidden" name="option" value="#rc.option#">
	<input type="hidden" name="data" id="data" value="">
	<span id="dataSpan" class="hidden">#serializeJSON(rc.boxData)#</span>
	<input type="submit" class="btn btn-success" name="Submit" value="#rc.submitValue#">
</form>
<script type="text/javascript">
	jQuery("input##data").val(jQuery("span##dataSpan").html());
</script>
</cfoutput>