<cfoutput>
<table>
	<thead>
		<tr>
			<th width="20%" valign="top" rowspan="2">Site</th>
			<th width="20%" valign="top" rowspan="2">Username</th>
			<th width="20%" valign="top" rowspan="2">Password</th>
			<th width="40%" valign="top" colspan="2">Additional Details</th>
		</tr>
		<tr>
			<th width="30%">Type</th>
			<th width="30%">Details</th>
		</tr>
	</thead>
	<tbody>
		<!--- <cfdump var="#rc.boxData#" /><cfabort /> --->
		<cfloop array="#rc.boxData#" index="itm">
			<tr>
				<td rowspan="#(arrayLen(itm.additional)?:1)#">#itm.site#</td>
				<td rowspan="#(arrayLen(itm.additional)?:1)#">#itm.username#</td>
				<td rowspan="#(arrayLen(itm.additional)?:1)#">#decrypt(itm.password, itm.salt)#</td>
				<cfloop from="0" to="#arrayLen(itm.additional)-1#" index="idx">
						<td>#itm.additional[idx+1].securityType#</td>
						<td>#itm.additional[idx+1].details#</td>
					</tr>
					<tr>
				</cfloop>
				<cfif NOT arrayLen(itm.additional)>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</cfif>
			</tr>
		</cfloop>
	</tbody>
</table>

<form action="#event.buildLink('password.syncbox')#" method="post">
	<input type="hidden" name="fileid" value="#rc.fileid#">
	<input type="hidden" name="option" value="#rc.option#">
	<input type="hidden" name="data" value='#serializeJSON(rc.boxData)#'>
	<input type="submit" class="btn btn-success" name="Submit" value="#rc.submitValue#">
</form>
</cfoutput>