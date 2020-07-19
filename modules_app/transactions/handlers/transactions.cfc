component extends="coldbox.system.EventHandler" {
	property name="transactionsService" inject="transactions@transactions" 	scope="instance";
	property name="categoriesService" 	inject="categories@transactions" 	scope="instance";
	property name="bankService" 		inject="banks@transactions" 		scope="instance";
	property name="userService" 		inject="users@transactions" 		scope="instance";

	/*
		Need to check all files in this module
		Need to make all CFCs in this module as script based
		Need to split this refactor models
		Need to split this handler into multiple handlers based on functionlity
	*/

	public function index( event, rc, prc ) {
		param name="rc.searchStr" default="";
		prc.allTransactions = instance.transactionsService.list();
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		prc.formAction = "transactions.update.#rc.id#";
		prc.formSubmit = val( rc.id ) ? "Update" : "Add";

		prc.currTransactionDetails = instance.transactionsService.list( id = rc.id );
		prc.allTransactionModes = instance.categoriesService.getTransactionModes();
		prc.allCategories = instance.categoriesService.getCategories();
		prc.allBankAccounts = instance.bankService.getBankAccounts();
		prc.allPersons = instance.userService.getPersons();

		event.setView( view="transactions/addEdit", noLayout=true );
	}

	public function update( event, rc, prc ) {
		try {
			if( val( rc.id ) )
				instance.transactionsService.update( argumentCollection=rc );
			else
				rc.id = instance.transactionsService.new( argumentCollection=rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction details updated successfully.";
		} catch( any e ) {
			writeDump(e);abort;
			rc.msgAction = "Error";
			rc.msg = (len(e.message)?e.message:e.detail);
		}
		setNextEvent(event = "transactions", persist = "msg,msgAction");
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";

		if( val( rc.id ) && ( prc.currentRoute == "undelete/:id-numeric/" ) ) {
			instance.transactionsService.undelete( ID = rc.id );
			rc.msg = "Transaction details undeleted successfully.";
		} else {
			instance.transactionsService.delete( ID = rc.id );
			rc.msg = "Transaction details deleted successfully.";
		}
		rc.msgAction = "Success";
		rc.msg = "Transaction details deleted successfully.";
		setNextEvent(event = "transactions", persist = "msg,msgAction");
	}

	public function reports( event, rc, prc ) {
		param name="rc.id" default="0";

		if( rc.id == 1 ) {
			// Balance report
			prc.currBalances = instance.transactionsService.getCurrentBalances( session.userId );
		}

		event.setView( view="transactions/report_1", noLayout=true );
	}
}