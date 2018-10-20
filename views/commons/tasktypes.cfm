<cfparam name="rc.id" default="0">
<cfparam name="rc.msg" default="">
<cfparam name="rc.msgAction" default="">
<cfparam name="rc.searchStr" default="">
<script type="text/javascript">
	jQuery(function(){
		setTimeout(function(){
			jQuery("div.alert").slideUp(1000);
		},10000);
	});
</script>
<cfoutput>
<div class="container">
	<div style="min-height: 10px;">&nbsp;</div>
	<cf_alerts msg="#rc.msg#" msgAction="#rc.msgAction#">

	<div class="row">
		<div class="col-xs-6">
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th>ID</th>
						<th>Category Type</th>
						<th width="10">Status</th>
						<th width="70">&nbsp;</th>
					</tr>
				</thead>
				<cfloop query="prc.allTaskTypes">
					<tr class="#iif(prc.allTaskTypes.deleted, "'negative'", "'positive'")#">
						<td>#prc.allTaskTypes.ID#</td>
						<td>#prc.allTaskTypes.name#</td>
						<td class="text-center">
							<cfif prc.allTaskTypes.deleted><i class="glyphicon glyphicon-remove text-danger"><cfelse><i class="glyphicon glyphicon-ok text-success"></i></cfif>
						</td>
						<td>
							<a href="#event.BuildLink( LinkTo='edit.taskType.#prc.allTaskTypes.ID#')#" title="Edit"><i class="glyphicon glyphicon-edit text-primary"></i></a>
							<cfif NOT prc.allTaskTypes.deleted>
								<a href="#event.BuildLink( LinkTo='delete.taskType.#prc.allTaskTypes.ID#')#" title="Delete"><i class="glyphicon glyphicon-remove text-danger"></i></a>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</table>
		</div>
		<div class="col-xs-6">
			<form class="ui form grid" action="#event.BuildLink('new.taskType')#" method="post">
				<input type="hidden" name="ID" value="#val(prc.currTaskTypeDetails.ID)#">
				<div class="col-xs-6">
					<div class="form-group col-xs-12 p-0">
						<label for="name">Task Type</label>
						<input class="form-control" type="text" name="name" value="#prc.currTaskTypeDetails.name#" placeholder="Task type">
						<!--- <small id="nameHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> --->
					</div>
					<div class="form-group col-xs-12 p-0">
						<label>Status</label>
						<select name="deleted" class="form-control">
							<option value="0" <cfif prc.currTaskTypeDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
							<option value="1" <cfif prc.currTaskTypeDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
						</select>
					</div>
				</div>
				<div class="form-group col-xs-6">
					<label>Description</label>
					<textarea class="form-control" name="desc" rows="4">#prc.currTaskTypeDetails.desc#</textarea>
				</div>
				<div class="form-group col-xs-6">
					<input class="btn btn-success" type="submit" name="Add" value="#iif(val(prc.currTaskTypeDetails.ID), "'Update'", "'Add'")#">
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>