<cfoutput>
    <div class="container-center">
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th width="10%">Title</th>
                    <th width="15%">Tags</th>
                    <th width="10%">Desc ( Short )</th>
                    <th width="5%" class="text-center">Status</th>
                    <th width="10%" class="text-center">Actions</th>
                </tr>
            </thead>
            <cfloop query="#prc.tips#">
                <tr>
                    <td>#prc.tips.title#</td>
                    <td>#getTags( prc.tags, prc.tips.id )#</td>
                    <td>#left( prc.tips.description, 100 )#...</td>
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

<cfscript>
    private string function getTags(
        required query baseQry,
        required numeric tipId
    ) {
        var res = "";
        var qry = "";
        var options = { dbtype: "query" };
		var params = {};
		var sql = "SELECT DISTINCT tagId, name FROM arguments.baseQry WHERE tipId = :tipId;";
        params.insert( "tipId", { value: arguments.tipId, cfsqltype: "cf_sql_integer" } );
        
        qry = queryExecute( sql, params, options );

        res = qry.valueList( "name" );
        return res;
    }
</cfscript>