component extends="coldbox.system.EventHandler" {
	property name="categoriesService" inject="categories@transactions" scope="instance";

	public function index( event, rc, prc ){
		prc.allCategoryTypes = instance.categoriesService.getCategoryTypes( includeDeleted = 1 );
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";

		prc.formAction = val( rc.id ) ? "transactions.category-types.update.#rc.id#" : "transactions.category-types.add";
		prc.formSubmit = val( rc.id ) ? "Update" : "Add";

		
		prc.allCategoryTypes = instance.categoriesService.getCategoryTypes( includeDeleted = 1 );
		prc.currCategoryTypeDetails = instance.categoriesService.getCategoryTypes( ID = rc.id, includeDeleted = 1 );

		event.setView( view="categoryTypes/addEdit", noLayout=true );
	}

	public function update( event, rc, prc ) {
		param name="rc.id";

		if( val( rc.id ) ) {
			instance.categoriesService.updateCategoryType( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction category type saved successfully";
		} else {
			instance.categoriesService.newCategoryType( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction category type added successfully";
		}
		setNextEvent(event = "transactions.category-types", persist = "msg,msgAction");
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";

		if( val( rc.id ) ) {
			instance.categoriesService.deleteCategoryType( id = rc.id );
			rc.msgAction = "Success";
			rc.msg = "Transaction category type deleted successfully.";
		} else {
			rc.msgAction = "Error";
			rc.msg = "No such bank found.";
		}
		setNextEvent( event = "transactions.category-types", persist = "msg,msgAction" );
	}
}