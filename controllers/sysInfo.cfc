component extends="base"{
	property name="sysInfo" inject="model.systemInfo";
	function index( event, rc, prc ){
		// business logics goes here
	}

	function systemInfo( event, rc, prc ){
		// business logics goes here
		RC.listSysInfo = sysInfo.list();
	}

	public any function addEditSys() {
		if(structKeyExists(RC, "submitToInsert") and rc.hiddenID eq ''){
			sysInfo.insertSys(rc);
			setNextEvent(event="sysInfo.systemInfo");
		}
		if(structKeyExists(RC, "empID")){
			rc.selectedSys = sysInfo.selectSys(rc);
		}
		if(structKeyExists(RC, "submitToInsert") and rc.hiddenID neq ''){
			rc.selectedSys = sysInfo.editSys(rc);
			setNextEvent(event="sysInfo.systemInfo");
		}
	}

	public any function deleteSysInfo(param) {
		if(structKeyExists(RC, "empDelID")){
			sysInfo.delSys(rc);
			setNextEvent(event="sysInfo.systemInfo");
		}
	}

	public any function list() {
		 rc.employee = sysInfo.get();
		 rc.empType = sysInfo.getEmployeeType();
		 rc.empBatch = sysInfo.getEmployeeBatch();
	}

	public function listAction(event,rc,prc) {
		rc.empType = sysInfo.getEmployeeType();
		rc.empBatch = sysInfo.getEmployeeBatch();
		if(structKeyExists(rc, "ID")){
		 rc.employee = sysInfo.get(ID = rc.ID);
		}
		if(not structKeyExists(rc,"status")){
			rc.status =0;
		}
		if(structKeyExists(rc, "submit")){
			if(structKeyExists(rc, "ID") and len(rc.ID)){
				sysInfo.update(ID = rc.ID,firstName = rc.firstName,lastName = rc.lastName,typeID = rc.typeID,batchID = rc.batchID,
										status = rc.status);
			}else{
				sysInfo.create(firstName = rc.firstName,lastName = rc.lastName,typeID = rc.typeID,batchID = rc.batchID,
										status = rc.status);

			}
				setNextEvent(event="sysInfo.list");
		}
	}

	public function deleteEmployee(event,rc,prc) {
		if(structKeyExists(rc, "did")){
			sysInfo.delete( ID = rc.did);
			setNextEvent(event="sysInfo.list");
		}else{
			"Please Try Again Later";
		}
	}

	public void function batch(event,rc,prc){
		rc.viewEmpbatch = sysInfo.selectData();
		event.setView("sysInfo/batch");
	}

	public function addbatch(){
		if(structKeyExists(rc, "batchID") and rc.batchID neq ""){
			rc.viewSelectdata = sysInfo.updateSelectdata(id=rc.batchID);
		}
		if(structKeyExists(rc, "submit")){
			if(structKeyExists(rc, "id") and rc.id eq ""){
				sysInfo.insertData(batchName=rc.batchName, startdate=rc.startdate);
				setNextEvent(event="sysInfo.batch");
			}
			else{
				sysInfo.updateData(id=rc.id,batchName=rc.batchName,startdate=rc.startdate);
				setNextEvent(event="sysInfo.batch");
			}
		}
	}

	public function deleteBatch(rc){
		if(structKeyExists(rc,"batchID")){
			sysInfo.deleteBatch(id = rc.batchID);
			setNextEvent(event="sysInfo.batch");
		}
	}
}