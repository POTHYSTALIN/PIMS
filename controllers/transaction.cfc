component extends="base" {
	property name="categoriesService" inject="model.categories" scope="instance";
	property name="transactionsService" inject="model.transactions" scope="instance";

	public function index( event, rc, prc ){
		// writeDump(CGI);abort;
		rc.allTransactions = instance.transactionsService.getTransactions();
		// writeDump(rc.allTransactions);abort;
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id)?"update.transaction.#rc.id#":"add.transaction";
		rc.formSubmit = val(rc.id)?"Update":"Add";
		if(structKeyExists(rc, "submit")){
			try{
				if( val(rc.id) )
					instance.transactionsService.updateTransaction(argumentCollection=rc);
				else
					rc.id = instance.transactionsService.newTransaction(argumentCollection=rc);
				rc.msgAction = "Success";
				rc.msg = "Transaction details saved successfully.";
			} catch( any e ){
				writeDump(e);abort;
				rc.msgAction = "Error";
				rc.msg = (len(e.message)?e.message:e.detail);
			}
			setNextEvent(event = 'list.transactions', persist = "msg,msgAction");
		}
		event.setView( view="transaction/addEdit", noLayout=true );
		rc.transactionDetails = instance.transactionsService.getTransactions( id = rc.id );
		rc.allCategoryTypes = instance.categoriesService.getCategoryTypes();
		rc.allCategories = instance.categoriesService.getCategories();
		// writeDump(rc.allCategoryTypes);abort;
		// rc.additionalSecDetails = instance.transactionsService.getAdditionalSecurityDetails( id = rc.id );
	}

	public function delete( event, rc, prc ){
		param name="rc.id" default="0";

		if( val(rc.id) )
			instance.transactionsService.deleteTransaction( ID = rc.ID );
		rc.msgAction = "Success";
		rc.msg = "Transaction details deleted successfully.";
		setNextEvent(event = 'list.transactions', persist = "msg,msgAction");
	}

	public function categories( event, rc, prc ){
		param name="rc.ID" default="0";
		prc.allCategories = instance.categoriesService.getCategories( includeDeleted = 1 );
		prc.allCategoryTypes = instance.categoriesService.getCategoryTypes();
		if( structKeyExists(rc, "ID") ){
			prc.currCategoryDetails = instance.categoriesService.getCategories( ID = rc.ID, includeDeleted = 1 );
		}
	}

	public function addEditCategory( event, rc, prc ) {
		if(val(rc.ID)){
			instance.categoriesService.updateCategory( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction category details saved successfully.";
		}else{
			instance.categoriesService.newCategory( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction category details added successfully.";
		}
		setNextEvent(event = 'list.categories', persist = "msg,msgAction");
	}

	public function deleteCategory( event, rc, prc ) {
		param name="rc.ID" default="0";
		if(val(rc.ID)){
			instance.categoriesService.deleteCategory( ID = rc.ID );
			rc.msgAction = "Success";
			rc.msg = "Transaction category deleted successfully.";
		}else{
			rc.msgAction = "Error";
			rc.msg = "No such Transaction category found.";
		}
		setNextEvent(event = 'list.categories', persist = "msg,msgAction");
	}

	public function categoryTypes( event, rc, prc ){
		param name="rc.ID" default="0";
		prc.allCategoryTypes = instance.categoriesService.getCategoryTypes( includeDeleted = 1 );
		if( structKeyExists(rc, "ID") ){
			prc.currCategoryTypeDetails = instance.categoriesService.getCategoryTypes( ID = rc.ID, includeDeleted = 1 );
		}
	}

	public function addEditCategoryType( event, rc, prc ) {
		// writeDump(rc);abort;
		if(val(rc.ID)){
			instance.categoriesService.updateCategoryType( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction category type details saved successfully.";
		}else{
			instance.categoriesService.newCategoryType( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Transaction category type details added successfully.";
		}
		setNextEvent(event = 'list.categoryTypes', persist = "msg,msgAction");
	}

	public function deleteCategoryType( event, rc, prc ) {
		param name="rc.ID" default="0";
		if(val(rc.ID)){
			instance.categoriesService.deleteCategoryType( ID = rc.ID );
			rc.msgAction = "Success";
			rc.msg = "Transaction category type deleted successfully.";
		}else{
			rc.msgAction = "Error";
			rc.msg = "No such Transaction category type found.";
		}
		setNextEvent(event = 'list.categoryTypes', persist = "msg,msgAction");
	}
}