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
						<th>Category</th>
						<th>Type</th>
						<th width="10">Status</th>
						<th width="70">&nbsp;</th>
					</tr>
				</thead>
				<cfloop query="prc.allCategories">
					<tr class="#iif(prc.allCategories.deleted, "'negative'", "'positive'")#">
						<td>#prc.allCategories.ID#</td>
						<td>#prc.allCategories.name#</td>
						<td>#prc.allCategories.type#</td>
						<td class="text-center">
							<cfif prc.allCategories.deleted><i class="glyphicon glyphicon-remove text-danger"><cfelse><i class="glyphicon glyphicon-ok text-success"></i></cfif>
						</td>
						<td>
							<a href="#event.BuildLink( LinkTo='edit.category.#prc.allCategories.ID#')#" title="Edit"><i class="glyphicon glyphicon-edit text-primary"></i></a>
							<cfif NOT prc.allCategories.deleted>
								<a href="#event.BuildLink( LinkTo='delete.category.#prc.allCategories.ID#')#" title="Delete"><i class="glyphicon glyphicon-remove text-danger"></i></a>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</table>
		</div>
		<div class="col-xs-6">
			<form class="ui form grid" action="#event.BuildLink('new.category')#" method="post">
				<input type="hidden" name="ID" value="#val(prc.currCategoryDetails.ID)#">
				<div class="form-group col-xs-6">
					<label for="name">Category Name</label>
					<input class="form-control" type="text" name="name" value="#prc.currCategoryDetails.name#" placeholder="Category Name">
					<!--- <small id="nameHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> --->
				</div>
				<div class="form-group col-xs-6">
					<label>Category Type</label>
					<select name="Type" class="form-control">
						<cfloop query="prc.allCategoryTypes">
							<option value="#prc.allCategoryTypes.ID#" <cfif prc.currCategoryDetails.typeID EQ prc.allCategoryTypes.ID>selected="selected"</cfif>>#prc.allCategoryTypes.name#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group col-xs-6">
					<label>Sub category of</label>
					<select name="ParentID" class="form-control">
						<option value="0">None</option>
						<cfloop query="prc.allCategories">
							<cfif prc.allCategories.ID EQ prc.currCategoryDetails.ID>
								<cfcontinue>
							</cfif>
							<option value="#prc.allCategories.ID#" <cfif prc.currCategoryDetails.ParentID EQ prc.allCategories.ID>selected="selected"</cfif>>#prc.allCategories.name#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group col-xs-6">
					<label>Status</label>
					<select name="deleted" class="form-control">
						<option value="0" <cfif prc.currCategoryDetails.deleted EQ 0>selected="selected"</cfif>>Active</option>
						<option value="1" <cfif prc.currCategoryDetails.deleted EQ 1>selected="selected"</cfif>>Deleted</option>
					</select>
				</div>
				<div class="form-group col-xs-6">
					<input class="btn btn-success" type="submit" name="Add" value="#iif(val(prc.currCategoryDetails.TypeID), "'Update'", "'Add'")#">
				</div>
			</form>
		</div>
	</div>
</div>
</cfoutput>