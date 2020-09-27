<cfoutput>
    <div class="container-center">
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th width="10%">Title</th>
                    <th width="15%">Tags</th>
                    <th width="10%">Short.desc</th>
                    <th width="5%" class="text-center">Status</th>
                    <th width="10%" class="text-center">Actions</th>
                </tr>
            </thead>
            <cfloop query="#prc.tips#">
                <tr>
                    <td>#prc.tips.title#</td>
                    <td>tags list here</td>
                    <td>short desc</td>
                    <td class="text-center">
                        <cfif prc.tips.deleted><i class="fas fa-times text-danger"><cfelse><i class="fas fa-check text-success"></i></cfif>
                    </td>
                    <td align="center">
                        <i class="fas fa-edit cursor" onclick="javascript: showEditModal(this, '#prc.tips.id#');"></i>&nbsp;
                        <cfif NOT prc.tips.deleted>
                            <i class="fas fa-trash cursor text-danger" title="delete" onclick="javascript: showDeleteConfirmModal(this, '#prc.tips.id#');"></i>
                        <cfelse>
                            <i class="fas fa-check cursor text-warning" title="Undelete this transaction" onclick="javascript: showDeleteConfirmModal(this, '#prc.tips.id#', true);"></i>
                        </cfif>
                    </td>
                </tr>
            </cfloop>
        </table>
    </div>
</cfoutput>