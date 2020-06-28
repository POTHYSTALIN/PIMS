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
					<th width="30%">Hardware</th>
					<th width="30%">Details</th>
					<th width="10%">Actions</th>
				</tr>
			</thead>
			<tbody>
			<cfset prc.currCombinations = structNew("ordered")>
			<cfloop query="prc.itemDetails">
				<cfset fullDetails = generateDetails( argumentCollection = queryGetRow( prc.itemDetails, prc.itemDetails.currentRow ) )>
				<cfset currNameDetails = listFirst( fullDetails, "/" )>
				<cfset currIDDetails = listLast( fullDetails, "/" )>
				<cfset structInsert(prc.currCombinations, prc.itemDetails.inventoryItemID & " - " & currIDDetails, prc.itemDetails.item & " - " & currNameDetails)>
				<tr>
					<td>#prc.itemDetails.id#</td>
					<td>#prc.itemDetails.item#</td>
					<td>#currNameDetails#</td>
					<td>
						<i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#prc.itemDetails.id#', '#prc.itemDetails.inventoryItemID#');"></i> &nbsp;
						<i class="fas fa-trash cursor text-danger" onclick="javascript: showDeleteConfirmModal(this, '#prc.itemDetails.id#');"></a>
					</td>
				</tr>
			</cfloop>
				<input type="hidden" id="allCombinations" name="allCombinations" value='#serializeJSON(prc.currCombinations)#' />
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

	<cfset var res1 = "">
	<cfset var res2 = "">
	<cfset res1 = listAppend(res1, arguments.brand, "@")>
	<cfset res2 = listAppend(res2, arguments.brandID, "@")>
	<cfif len(trim(arguments.cd))>
		<cfset res1 = listAppend(res1, arguments.cd, "@")>
		<cfset res2 = listAppend(res2, arguments.cdID, "@")>
	</cfif>
	<cfif len(trim(arguments.model))>
		<cfset res1 = listAppend(res1, arguments.model, "@")>
		<cfset res2 = listAppend(res2, arguments.modelID, "@")>
	</cfif>
	<cfif len(trim(arguments.generation))>
		<cfset res1 = listAppend(res1, arguments.generation, "@")>
		<cfset res2 = listAppend(res2, arguments.generationID, "@")>
	</cfif>
	<cfif len(trim(arguments.frequency))>
		<cfset res1 = listAppend(res1, arguments.frequency, "@")>
		<cfset res2 = listAppend(res2, arguments.frequencyID, "@")>
	</cfif>
	<cfif len(trim(arguments.size))>
		<cfset res1 = listAppend(res1, arguments.size, "@")>
		<cfset res2 = listAppend(res2, arguments.sizeID, "@")>
	</cfif>
	<cfset res1 = replace(res1, "@", " - ", "ALL")>
	<cfset res2 = replace(res2, "@", " - ", "ALL")>

	<cfreturn res1 & "/" & res2 />
</cffunction>
