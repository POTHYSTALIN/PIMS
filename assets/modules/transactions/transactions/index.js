function showEditModal( elem, id ) {
	jQuery.post(
		"/transactions/edit/" + id,
		function (res) {
			// success function
			if( parseInt( id ) == 0 )
				jQuery( ".modal-title" ).html( "Add transaction" );
			else
				jQuery( ".modal-title" ).html( "Update transaction" );
			jQuery( ".modal-body" ).html( res );
			jQuery( "#myModal" ).modal();
		}
	);
	return false;
}

function showDeleteConfirmModal( elem, id, undelete=false ) {
	if( undelete ) {
		var confirmContent = '<p>Are you sure to undelete this transaction?</p><div class="row"><div class="offset-9 col-sm-1 pr-0 pl-5 mr-3"><button type="button" class="btn btn-sm btn-warning text-white" onclick="javascript: deleteTransaction(' + id + ', true );">Undelete</button></div><div class="col-sm-1 p-0 ml-5"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button></div></div>';
		jQuery( ".modal-title" ).html( "Confirm undelete" );
	} else {
		var confirmContent = '<p>Are you sure to delete this transaction?</p><div class="row"><div class="offset-9 col-sm-1 pr-0 pl-5 mr-3"><button type="button" class="btn btn-sm btn-danger" onclick="javascript: deleteTransaction(' + id + ');">Delete</button></div><div class="col-sm-1 p-0 ml-5"><button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">Cancel</button></div></div>';
		jQuery( ".modal-title" ).html( "Confirm delete" );
	}
	jQuery( ".modal-body" ).html( confirmContent );
	jQuery( "#myModal" ).modal({
		backdrop: "static",
		keyboard: false
	});
}

function deleteTransaction( id, undelete=false ) {
	$( "#myModal" ).modal( "hide" );
	if( undelete ) {
		window.location.href = "/transactions/undelete/" + id;
	} else {
		window.location.href = "/transactions/delete/" + id;
	}
}

function showBalanceReport() {
	jQuery.post(
		"/transactions/report/1",
		function (res) {
			// success function
			let currDate = new Date();
			jQuery(".modal-title").html("Balance amount on " + currDate.getDate() + " / " + currDate.toLocaleString('default', { month: 'short' }) + " / " + currDate.getFullYear() );
			jQuery(".modal-body").html( res );
			jQuery("#myModal").modal();
		}
	);
	return false;
}

function toggleFields( elem ) {
	let id = jQuery( elem ).prop( "id" );
	let selected = findSelectedOption( elem );
	if( selected == null ) {
		return false;
	}
	if( id == "categoryID" ) {
		let type = jQuery( selected ).data( "type" );
		if( type == "Expense" ) {
			jQuery( "#fromPersonId" ).val( 1 );
			jQuery( "#toPersonId" ).val( "" );
		} else {
			jQuery( "#fromPersonId" ).val( "" );
			jQuery( "#toPersonId" ).val( 1 );
		}

		if( jQuery( selected ).text() == "Transfers - Income" || jQuery( selected ).text() == "Transfers - Expense" ) {
			jQuery( "#modeId" ).val( 2 );
		} else {
			jQuery( "#modeId" ).val( 1 );
		}
		jQuery( "#modeId" ).trigger( "change" );
	} else if( id == "modeId" ) {
		let mode = jQuery( selected ).data( "mode" );

		// reset both account dropdowns
		jQuery( "#fromAccountId" ).val( "" );
		jQuery( "#toAccountId" ).val( "" );
		jQuery( "#description" ).val( "" );
		if( mode == "Cash" ) {
			jQuery( "#fromAccountId" ).parent().addClass( "hidden" );
			jQuery( "#toAccountId" ).parent().addClass( "hidden" );

			if( jQuery( "#categoryID option:selected" ).text() == "Others - Income" ) {
				jQuery( "#description" ).val( "Cash for Transfer" );
			}
			
		} else {
			jQuery( "#fromAccountId" ).parent().removeClass( "hidden" );
			jQuery( "#toAccountId" ).parent().removeClass( "hidden" );

			if( jQuery( "#categoryID option:selected" ).text() == "Transfers - Expense" ) {
				jQuery( "#description" ).val( "Transfer for cash" );
			}
		}
	}
}