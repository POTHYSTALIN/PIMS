component extends="base" {
	property name="commonsService" inject="model.commons" scope="instance";

	public function index( event, rc, prc ){
		runEvent(commons.tasks);
	}

	public function tasks( event, rc, prc ){
		prc.allTaskTypes = instance.commonsService.getTaskTypes();
		writeDump(prc.allTaskTypes);abort;
	}

	public function taskTypes( event, rc, prc ){
		param name="rc.id" default="0";
		prc.allTaskTypes = instance.commonsService.getTaskTypes( includeDeleted = true );
		prc.currTaskTypeDetails = instance.commonsService.getTaskTypes( id = rc.id, includeDeleted = true );
	}

	public function addEditTaskType( event, rc, prc ){
		if(val(rc.ID)){
			instance.commonsService.updateTaskType( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Task type details saved successfully.";
		}else{
			instance.commonsService.newTaskType( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Task type details added successfully.";
		}
		setNextEvent(event = 'list.taskTypes', persist = "msg,msgAction");
	}

	public function deleteTaskType( event, rc, prc ) {
		param name="rc.ID" default="0";
		if(val(rc.ID)){
			instance.commonsService.deleteTaskType( ID = rc.ID );
			rc.msgAction = "Success";
			rc.msg = "Task type deleted successfully.";
		}else{
			rc.msgAction = "Error";
			rc.msg = "No such Task type found.";
		}
		setNextEvent(event = 'list.taskTypes', persist = "msg,msgAction");
	}

	public function taskCategories( event, rc, prc ){
		param name="rc.id" default="0";
		prc.allTaskCategories = instance.commonsService.getTaskCategories( includeDeleted = true );
		prc.allTaskTypes = instance.commonsService.getTaskTypes();
		prc.allTaskRepeatTypes = instance.commonsService.getTaskRepeatTypes();
		prc.allTaskRepeatDelays = instance.commonsService.getTaskRepeatDelay();
		prc.currTaskCategoryDetails = instance.commonsService.getTaskCategories( id = rc.id, includeDeleted = true );
	}

	public function addEditTaskCategory( event, rc, prc ){
		if(val(rc.ID)){
			instance.commonsService.updateTaskCategory( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Task category details saved successfully.";
		}else{
			instance.commonsService.newTaskCategory( argumentCollection = rc );
			rc.msgAction = "Success";
			rc.msg = "Task category details added successfully.";
		}
		setNextEvent(event = 'list.taskCategories', persist = "msg,msgAction");
	}

	public function deleteTaskCategory( event, rc, prc ) {
		param name="rc.ID" default="0";
		if(val(rc.ID)){
			instance.commonsService.deleteTaskCategory( ID = rc.ID );
			rc.msgAction = "Success";
			rc.msg = "Task category deleted successfully.";
		}else{
			rc.msgAction = "Error";
			rc.msg = "No such Task category found.";
		}
		setNextEvent(event = 'list.taskCategories', persist = "msg,msgAction");
	}
}