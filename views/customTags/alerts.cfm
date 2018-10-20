<cfparam name="attributes.msgAction" type="string" default="success">
<cfparam name="attributes.msg" type="string" default="">

<cfoutput>
	<cfif thisTag.ExecutionMode is "start">
		<cfif len(attributes.msg) AND lCase(attributes.msgAction) EQ "error">
			<div class="alert alert-dismissible alert-danger" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Error!</strong> #attributes.msg#
			</div>
		<cfelseif len(attributes.msg) AND lCase(attributes.msgAction) EQ "success">
			<div class="alert alert-dismissible alert-success" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Success!</strong> #attributes.msg#
			</div>
		</cfif>
	</cfif>
</cfoutput>