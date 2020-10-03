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
                    <th width="15%">Tags</th>
                    <th width="5%" class="text-center">Status</th>
                    <th width="10%" class="text-center">Actions</th>
                </tr>
            </thead>
            <cfloop query="#prc.tags#">
                <tr>
                    <td>#prc.tags.name#</td>
                    <td class="text-center">
                        <cfif prc.tags.deleted><i class="fas fa-times text-danger"><cfelse><i class="fas fa-check text-success"></i></cfif>
                    </td>
                    <td align="center">
                        <i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#prc.tags.id#');"></i>&nbsp;
                        <cfif NOT prc.tags.deleted>
                            <i class="fas fa-trash cursor text-danger" title="delete" onclick="javascript: showDeleteConfirmModal(this, '#prc.tags.id#');"></i>
                        <cfelse>
                            <i class="fas fa-check cursor text-warning" title="Undelete this transaction" onclick="javascript: showDeleteConfirmModal(this, '#prc.tags.id#', true);"></i>
                        </cfif>
                    </td>
                </tr>
            </cfloop>
        </table>
    </div>
</cfoutput>