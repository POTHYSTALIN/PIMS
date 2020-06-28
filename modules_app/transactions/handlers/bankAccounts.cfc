component extends="coldbox.system.EventHandler" {
	property name="bankService" inject="banks@transactions" scope="instance";
	property name="userService" inject="users@transactions" scope="instance";

	public function index( event, rc, prc ){
		prc.allBankAccounts = instance.bankService.getBankAccounts( includeDeleted = 1 );
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";

		prc.formAction = val( rc.id ) ? "transactions.bank-accounts.update.#rc.id#" : "transactions.bank-accounts.add";
		prc.formSubmit = val( rc.id ) ? "Update" : "Add";

		prc.allBankAccounts = instance.bankService.getBankAccounts( includeDeleted = 1 );
		prc.allBanks = instance.bankService.getBanks();
		prc.allPersons = instance.userService.getPersons();
		prc.currBankAccountDetails = instance.bankService.getBankAccounts( id = rc.id, includeDeleted = 1 );

		event.setView( view="bankAccounts/addEdit", noLayout=true );
	}

	public function update( event, rc, prc ) {
		param name="rc.id";

		if( val( rc.id ) ) {
			instance.bankService.updateBankAccount( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Bank account saved successfully";
		} else {
			instance.bankService.newBankAccount( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Bank account added successfully";
		}
		setNextEvent(event = "transactions.bank-accounts", persist = "msg,msgAction");
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";

		if( val( rc.id ) ) {
			instance.bankService.deleteBankAccount( ID = rc.id );
			rc.msgAction = "Success";
			rc.msg = "Bank account deleted successfully.";
		} else {
			rc.msgAction = "Error";
			rc.msg = "No such bank account found.";
		}
		setNextEvent( event = "transactions.bank-accounts", persist = "msg,msgAction" );
	}
}