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
	<cfif len(rc.msg) AND rc.msgAction EQ "Error">
		<div class="alert alert-dismissible alert-danger" role="alert">
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<strong>Error!</strong> #rc.msg#
		</div>
	<cfelseif len(rc.msg) AND rc.msgAction EQ "Success">
		<div class="alert alert-dismissible alert-success" role="alert">
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<strong>Success!</strong> #rc.msg#
		</div>
	</cfif>

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
				<cfloop query="prc.allTaskCategories">
					<tr class="#iif(prc.allTaskCategories.deleted, "'negative'", "'positive'")#">
						<td>#prc.allTaskCategories.ID#</td>
						<td>#prc.allTaskCategories.name#</td>
						<td class="text-center">
							<cfif prc.allTaskCategories.deleted><i class="glyphicon glyphicon-remove text-danger"><cfelse><i class="glyphicon glyphicon-ok text-success"></i></cfif>
						</td>
						<td>
							<a href="#event.BuildLink( LinkTo='edit.taskCategory.#prc.allTaskCategories.ID#')#" title="Edit"><i class="glyphicon glyphicon-edit text-primary"></i></a>
							<cfif NOT prc.allTaskCategories.deleted>
								<a href="#event.BuildLink( LinkTo='delete.taskCategory.#prc.allTaskCategories.ID#')#" title="Delete"><i class="glyphicon glyphicon-remove text-danger"></i></a>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</table>
		</div>
		<div class="col-xs-6">
			<form class="ui form grid" action="#event.BuildLink('new.taskCategory')#" method="post">
				<input type="hidden" name="ID" value="#val(prc.currTaskCategoryDetails.ID)#">
				<div class="form-group col-xs-6">
					<label for="name">Task Category</label>
					<input class="form-control" type="text" name="name" value="#prc.currTaskCategoryDetails.name#" placeholder="Task category">
					<!--- <small id="nameHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> --->
				</div>
				<div class="form-group col-xs-6">
					<label>Status</label>
					<select name="deleted" class="form-control">
						<option value="0" <cfif prc.currTaskCategoryDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
						<option value="1" <cfif prc.currTaskCategoryDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
					</select>
				</div>
				<div class="form-group col-xs-6">
					<label>Task type</label>
					<cf_dropdown dropdownName="taskTypeID" selectedValue="#val(prc.currTaskCategoryDetails.taskTypeID)#" selectedLabel="#prc.currTaskCategoryDetails.taskTypeName#" baseQuery="#prc.allTaskTypes#" onclick="javascript: changeDropdown('taskTypeID', @@currValue, this);" />
				</div>
				<div class="form-group col-xs-6">
					<label>Repeat type</label>
					<cf_dropdown dropdownName="repeatType" selectedValue="#val(prc.currTaskCategoryDetails.repeatType)#" selectedLabel="#prc.currTaskCategoryDetails.repeatTypeName#" baseQuery="#prc.allTaskRepeatTypes#" onclick="javascript: changeDropdown('repeatType', @@currValue, this);" />
				</div>
				<div class="form-group col-xs-6">
					<label>Repeat interval</label>
					<cf_dropdown dropdownName="repeatDelay" selectedValue="#val(prc.currTaskCategoryDetails.repeatDelay)#" selectedLabel="#prc.currTaskCategoryDetails.repeatDelayName#" baseQuery="#prc.allTaskRepeatDelays#" onclick="javascript: changeDropdown('repeatDelay', @@currValue, this);" />
				</div>
				<div class="form-group col-xs-6">&nbsp;<br><br><br></div>
				<div class="form-group col-xs-6">
					<input class="btn btn-success" type="submit" name="Add" value="#iif(val(prc.currTaskCategoryDetails.ID), "'Update'", "'Add'")#">
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>