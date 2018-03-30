component extends="base" {
	property name="passwordManagerService" inject="model.password" scope="instance";
	property name="boxService" inject="model.box" scope="instance";

	public function index( event, rc, prc ){
		param name="rc.searchStr" default="";
		param name="rc.downloadFromBox" default="false";

		rc.passwordDetails = instance.passwordManagerService.getPassword(argumentCollection=rc);

		if( rc.downloadFromBox ){
			// 01_MyApps - 35046518192
			local.tmpDetails = instance.boxService.getFolder(id = "35046518192");
			//writeDump(local.tmpDetails);abort;
			if(!local.tmpDetails.hasError){
				rc.boxFileID = structFindValue(local.tmpDetails, "pwd.json", "one")[1].owner.id;
				if(len(rc.searchStr)){
					var tmpWClause = " AND ( ";
					tmpWClause &= "SITE LIKE '%#rc.searchStr#%' OR USERNAME LIKE '%#rc.searchStr#%'";
					if(isNumeric(rc.searchStr))
						tmpWClause &= " OR ID LIKE '%#rc.searchStr#%'";
					tmpWClause &= " ) ";
					rc.passwordDetails = instance.passwordManagerService.getDataFromQuery(mainQry=rc.passwordDetails, wClause="#tmpWClause#");
				}
				event.setLayout("main");
			}else{
				rc.boxFileID = "";
				rc.msgAction = "Error";
				rc.msg = "Box developer token has been expired.";
			}
		}
	}

	public function addEdit( event, rc, prc ){
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id)?"update.password.#rc.id#":"add.password";
		rc.formSubmit = val(rc.id)?"Update":"Add";

		if(structKeyExists(rc, "submit")){
			try{
				if( val(rc.id) )
					instance.passwordManagerService.updatePassword(argumentCollection=rc);
				else
					rc.id = instance.passwordManagerService.addPassword(argumentCollection=rc);

				if(structKeyExists(rc, "additionalEnabled")){
					// && structKeyExists(rc, "addSec1Type")
					var currSecDetailsIDsList = "";
					for (currItem in rc) {
						if(reFindNoCase("^addSec[0-9]+Type$", currItem)){
							// Only form fields like addSec1Type, addSec2Type, etc.
							var currSLNo = mid(currItem,7,len(currItem)-10);

							var updatedID = instance.passwordManagerService.addAdditionalSecurtity(
								addSecID = rc["addSec#currSLNo#ID"],
								accID = rc["id"],
								addSecType = rc["addSec#currSLNo#Type"],
								addSecDetails = rc["addSec#currSLNo#Details"]
							);
							currSecDetailsIDsList = listAppend(currSecDetailsIDsList, updatedID);
						}
					}

					instance.passwordManagerService.removeAdditionalSecurityDetails( accID = rc.id, IDList = currSecDetailsIDsList );
				}
				rc.msgAction = "Success";
				rc.msg = "Password details saved successfully.";
			} catch( any e ){
				writeDump(e);abort;
				rc.msgAction = "Error";
				rc.msg = (len(e.message)?e.message:e.detail);
			}
			setNextEvent(event = 'list.password', persist = "msg,msgAction");
		}
		// event.setLayout("blank");
		event.setView( view="password/addEdit", noLayout=true );
		rc.passwordDetails = instance.passwordManagerService.getPassword( id = rc.id );
		rc.additionalSecDetails = instance.passwordManagerService.getAdditionalSecurityDetails( id = rc.id );
	}

	public function delete( event, rc, prc ){
		param name="rc.id" default="0";

		if( val(rc.id) )
			instance.passwordManagerService.deletePassword(argumentCollection=rc);
		rc.msgAction = "Success";
		rc.msg = "Password details deleted successfully.";
		setNextEvent(event = 'list.password', persist = "msg,msgAction");
	}

	public function box( event, rc, prc ) {
		if( structKeyExists(rc, "option") && structKeyExists(rc, "fileID")){
			if(rc.option == "from"){
				// downloading the password details from Box.com
				rc.submitValue = "Confirm download from Box.com";
				local.tmpDetails = instance.boxService.downloadFile( fileID = rc.fileID );
				rc.hasError = false;
				rc.errMsg = "";

				if(local.tmpDetails.statusCode EQ "200 OK"){
					rc.boxData = deserializeJSON(local.tmpDetails.fileContent);
				}else{
					rc.hasError = true;
					rc.errMsg = local.tmpDetails.errorDetail;
				}
			}else{
				// downloading the password details from Box.com
				rc.submitValue = "Confirm upload to Box.com";
				local.tmpDetails = instance.passwordManagerService.getPassword();
				rc.boxData = [];
				for(var aRecord in tmpDetails){
					var aAdditionalDetails = instance.passwordManagerService.getAdditionalSecurityDetails( id = aRecord.id );
					aRecord.additional = [];
					for(var bRecord in aAdditionalDetails){
						arrayAppend(aRecord.additional, bRecord);
					}
					arrayAppend(rc.boxData, aRecord);
				}
				rc.hasError = false;
				rc.errMsg = "";
			}
			// event.setLayout("blank");
			event.setView( view="password/box", noLayout=true );
		}else{
			rc.msgAction = "Error";
			rc.msg = "Invalid request.";
			setNextEvent(event = 'list.password', persist = "msg,msgAction");
		}
	}

	public function syncBox( event, rc, prc ){
		if(structKeyExists(rc, "option") && rc.option == "from"){
			local.syncResult = instance.passwordManagerService.syncBox( jsonContent = rc.data );
			writeDump(local.syncResult);abort;
			if(syncResult){
				rc.msgAction = "Success";
				rc.msg = "Password details were synced successfully from Box.com";
			}else{
				rc.msgAction = "Error";
				rc.msg = "There is some problem with syncing password details from Box.com";
			}
		}else if(structKeyExists(rc, "option") && rc.option == "to"){
			// Upload process should be here
			local.res = instance.boxService.uploadFile( filename = "pwd.json", folderID = "35046518192", content=rc.data );
			if(res){
				rc.msgAction = "Success";
				rc.msg = "Password details were synced successfully to Box.com";
			}else{
				rc.msgAction = "Error";
				rc.msg = "There is some problem with syncing password details to Box.com";
			}
			// instance.boxService.uploadFile( filename = "pwd.json", content='[{"SALT":"E733D18F-DC1E-8558-AA8C4D77147C4C36","SITE":"www.hmail.com","PASSWORD":"&6)B8UJNM\n","USERNAME":"pothystalin@gmail.com","DELETED":0,"ADDITIONAL":[{"SECURITYTYPE":"SMS","DETAILS":91},{"SECURITYTYPE":"email","DETAILS":"POTHYS"}]}]');
		}else{
			rc.msgAction = "Error";
			rc.msg = "Invalid request.";
		}
		setNextEvent(event = 'list.password', persist = "msg,msgAction");
	}
}