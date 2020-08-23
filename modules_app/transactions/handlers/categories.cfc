component extends="coldbox.system.EventHandler" {property name="categoriesService" inject="categories@transactions" scope="instance";

	public function index( event, rc, prc ){
		prc.allCategories = instance.categoriesService.getCategories( includeDeleted = 1 );
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";

		prc.formAction = "transactions.categories.update.#val( rc.id )#";
		prc.formSubmit = val( rc.id ) ? "Update" : "Add";

		prc.allCategories = instance.categoriesService.getCategories( includeDeleted = 1 );
		prc.allCategoryTypes = instance.categoriesService.getCategoryTypes();
		prc.currCategoryDetails = instance.categoriesService.getCategories( ID = rc.id, includeDeleted = 1 );

		event.setView( view="categories/addEdit", noLayout=true );
	}

	public function update( event, rc, prc ) {
		param name="rc.id";

		if( val( rc.id ) ) {
			instance.categoriesService.updateCategory( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction Category saved successfully";
		} else {
			instance.categoriesService.newCategory( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction Category added successfully";
		}
		relocate(event = "transactions.categories", persist = "msg,msgAction");
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";

		if( val( rc.id ) ) {
			instance.categoriesService.deleteCategory( ID = rc.id );
			rc.msgAction = "Success";
			rc.msg = "Transaction Category deleted successfully.";
		} else {
			rc.msgAction = "Error";
			rc.msg = "No such Transaction Category found.";
		}
		relocate( event = "transactions.categories", persist = "msg,msgAction" );
	}
}