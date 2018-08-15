<cfscript>
	setEnabled(true);
	setUniqueURLS(false);

	if ( len( getSetting( 'AppMapping' ) ) LTE 1 ){
		setBaseURL("http://#cgi.HTTP_HOST#");
		// setBaseURL("https://#cgi.HTTP_HOST#");
	}else {
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#");
		// setBaseURL("https://#cgi.HTTP_HOST#/#getSetting('AppMapping')#");
	};

	// Common named routes
	addRoute(pattern="/login", handler="security", action="login");
	addRoute(pattern="/logout", handler="security", action="logout");
	addRoute(pattern="/home", handler="main", action="index");
	// Password manager routes
	addRoute(pattern="/list/password", handler="password", action="index");
	addRoute(pattern="/update/password/:id-numeric", handler="password", action="addEdit");
	addRoute(pattern="/add/password", handler="password", action="addEdit");
	addRoute(pattern="/delete/password/:id", handler="password", action="delete");
	addRoute(pattern="/password/box/:option/:fileid", handler="password", action="box");
	// Transaction manager routes
	addRoute(pattern="/list/categoryTypes", handler="transaction", action="categoryTypes");
	addRoute(pattern="/new/categoryType", handler="transaction", action="addEditCategoryType");
	addRoute(pattern="/edit/categoryType/:ID", handler="transaction", action="categoryTypes");
	addRoute(pattern="/delete/categoryType/:ID", handler="transaction", action="deleteCategoryType");
	addRoute(pattern="/delete/categoryType", handler="transaction", action="deleteCategoryType");

	addRoute(pattern="/list/categories", handler="transaction", action="categories");
	addRoute(pattern="/new/category", handler="transaction", action="addeditcategory");
	addRoute(pattern="/edit/category/:ID", handler="transaction", action="categories");
	addRoute(pattern="/delete/category/:ID", handler="transaction", action="deleteCategory");

	addRoute(pattern="/list/banks", handler="transaction", action="banks");
	addRoute(pattern="/new/bank", handler="transaction", action="addeditbank");
	addRoute(pattern="/delete/bank/:ID", handler="transaction", action="deletebank");
	addRoute(pattern="/edit/bank/:ID", handler="transaction", action="banks");

	addRoute(pattern="/list/bankaccounts", handler="transaction", action="bankaccounts");
	addRoute(pattern="/new/bankaccount", handler="transaction", action="addeditbankaccount");
	addRoute(pattern="/delete/bankaccount/:ID", handler="transaction", action="deletebankaccount");
	addRoute(pattern="/edit/bankaccount/:ID", handler="transaction", action="bankaccounts");

	addRoute(pattern="/list/transactions", handler="transaction", action="index");
	addRoute(pattern="/edit/transaction/:id-numeric", handler="transaction", action="addEdit");
	addRoute(pattern="/add/transaction", handler="transaction", action="addEdit");
	addRoute(pattern="/delete/transaction/:ID", handler="transaction", action="delete");

	// Events manager routes
	addRoute(pattern="/list/events", handler="events", action="index");
	addRoute(pattern="/list/notifications", handler="events", action="notifications");

	addRoute(pattern="/list/tasks", handler="commons", action="tasks");

	addRoute(pattern="/list/taskTypes", handler="commons", action="tasktypes");
	addRoute(pattern="/new/taskType", handler="commons", action="addedittasktype");
	addRoute(pattern="/edit/taskType/:ID", handler="commons", action="tasktypes");
	addRoute(pattern="/delete/taskType/:ID", handler="commons", action="deleteTaskType");

	addRoute(pattern="/list/taskCategories", handler="commons", action="taskCategories");
	addRoute(pattern="/new/taskCategory", handler="commons", action="addedittaskCategory");
	addRoute(pattern="/edit/taskCategory/:ID", handler="commons", action="taskCategories");
	addRoute(pattern="/delete/taskCategory/:ID", handler="commons", action="deleteTaskCategory");

	addRoute(pattern="/list/tips", handler="commons", action="tips");

	// Common unnamed routes
	addRoute(":handler/:action/:id");
	addRoute(":handler/:action");
	addRoute(":handler");
</cfscript>