<cfoutput>
	<div class="container-center">
		<div>&nbsp;</div>
		<div class="form-row justify-content-sm-end">
			<div class="col-1 ml-3">
				<button type="button" class="btn btn-success btn-sm" onclick="javascript: showEditModal(this, '0');">Add</button>
			</div>
		</div>
		<div>&nbsp;</div>
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th width="30%">Id</th>
					<th width="30%">Item</th>
					<th width="30%">Details</th>
					<th width="10%">Actions</th>
				</tr>
			</thead>
			<tbody>
			<cfloop query="prc.itemDetails">
				<tr>
					<td>#prc.itemDetails.id#</td>
					<td>#prc.itemDetails.item#</td>
					<td>#generateDetails( argumentCollection = queryGetRow( prc.itemDetails, prc.itemDetails.currentRow ) )#</td>
					<td>
						<i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#prc.itemDetails.id#');"></i> &nbsp;
						<i class="fas fa-trash cursor text-danger" onclick="javascript: showDeleteConfirmModal(this, '#prc.itemDetails.id#');"></a>
					</td>
				</tr>
			</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>
<cffunction name="generateDetails" access="public" returntype="string">
	<cfargument name="brand" type="string" required="true">
	<cfargument name="model" type="string" required="true">
	<cfargument name="cd" type="string" required="false" default="">
	<cfargument name="generation" type="string" required="false" default="">
	<cfargument name="frequency" type="string" required="false" default="">
	<cfargument name="size" type="string" required="false" default="">

	<cfset var res = "">
	<cfset res = listAppend(res, arguments.brand, "@")>
	<cfset res = listAppend(res, arguments.model, "@")>
	<cfif len(trim(arguments.cd))>
		<cfset res = listAppend(res, arguments.cd, "@")>
	</cfif>
	<cfif len(trim(arguments.generation))>
		<cfset res = listAppend(res, arguments.generation, "@")>
	</cfif>
	<cfif len(trim(arguments.frequency))>
		<cfset res = listAppend(res, arguments.frequency, "@")>
	</cfif>
	<cfif len(trim(arguments.size))>
		<cfset res = listAppend(res, arguments.size, "@")>
	</cfif>
	<cfset res = replace(res, "@", " - ", "ALL")>

	<cfreturn res />
</cffunction>