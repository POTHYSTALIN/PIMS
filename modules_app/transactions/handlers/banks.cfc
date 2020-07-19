component extends="coldbox.system.EventHandler" {
	property name="bankService" inject="banks@transactions" scope="instance";

	public function index( event, rc, prc ){
		prc.allBanks = instance.bankService.getBanks( includeDeleted = 1 );
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";

		prc.formAction = "transactions.banks.update.#val( rc.id )#";
		prc.formSubmit = val( rc.id ) ? "Update" : "Add";

		prc.allBanks = instance.bankService.getBanks( includeDeleted = 1 );
		prc.currBankDetails = instance.bankService.getBanks( ID = rc.id, includeDeleted = 1 );
		event.setView( view="banks/addEdit", noLayout=true );
	}

	public function update( event, rc, prc ) {
		param name="rc.id";

		if( val( rc.id ) ) {
			instance.bankService.updateBank( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Bank details updated successfully";
		} else {
			instance.bankService.newBank( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Bank details added successfully";
		}
		setNextEvent(event = "transactions.banks", persist = "msg,msgAction");
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";

		if( val( rc.id ) ) {
			instance.bankService.deleteBank( ID = rc.id );
			rc.msgAction = "Success";
			rc.msg = "Bank deleted successfully";
		} else {
			rc.msgAction = "Error";
			rc.msg = "No such bank found";
		}
		setNextEvent( event = "transactions.banks", persist = "msg,msgAction" );
	}
}