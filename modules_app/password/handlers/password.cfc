component extends="coldbox.system.EventHandler" {
	property name="passwordManagerService" inject="password.model.passwordService" scope="instance";
	// property name="fwsettings" inject="coldbox:fwSettings";
	// property name="cfgSettings" inject="coldbox:configSettings";
	// property name="moduleSettings" inject="coldbox:modulesettings:password";

	function index( event, rc, prc ) {
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";
		param name="rc.searchStr" default="";
		param name="rc.downloadFromBox" default="false";

		// writeDump(event.getModuleRoot());abort;
		// writeDump(getApplicationPath(getCurrentTemplatePath(), "/handlers"));
		// writeDump(fwsettings);
		// writeDump(cfgSettings.moduleSettings);abort;

		prc.passwordDetails = instance.passwordManagerService.getPassword( argumentCollection = rc );
		// event.setLayout("main");
	}

	public function addEdit( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		rc.formAction = val(rc.id)?"password.update":"password.add";
		rc.formSubmit = val(rc.id)?"Update":"Add";

		if( structKeyExists(rc, "submit") ) {
			try {
				if( val(rc.id) ) {
					instance.passwordManagerService.updatePassword(argumentCollection=rc);
				} else {
					rc.id = instance.passwordManagerService.addPassword(argumentCollection=rc);
				}

				if(structKeyExists(rc, "additionalEnabled")) {
					var currSecDetailsIDsList = "";
					var tmpAdditionalDetails = [];
					for(currItem in rc) {
						if(reFindNoCase("^addSec[0-9]+Type$", currItem)) {
							// Only form fields like addSec1Type, addSec2Type, etc.
							var currSLNo = mid(currItem,7,len(currItem)-10);
							var tmpDetailArr = { "securityType" : rc["addSec#currSLNo#Type"], "details" : rc["addSec#currSLNo#Details"] };
							arrayAppend(tmpAdditionalDetails, tmpDetailArr);
						}
					}

					instance.passwordManagerService.removeAdditionalSecurityDetails( accID = rc.id );
					instance.passwordManagerService.addAdditionalSecurtity( accID = rc.id, data = tmpAdditionalDetails );
				}
				rc.msgAction = "Success";
				rc.msg = "Password details saved successfully.";
			} catch( any e ) {
				writeDump(e);abort;
				rc.msgAction = "Error";
				rc.msg = (len(e.message)?e.message:e.detail);
			}
			setNextEvent(event = 'password.list', persist = "msg,msgAction");
		}
		// event.setLayout("blank");
		event.setView( view="password/addEdit", noLayout=true );
		rc.passwordDetails = instance.passwordManagerService.getPassword( id = rc.id );
		rc.additionalSecDetails = instance.passwordManagerService.getAdditionalSecurityDetails( id = rc.id );
	}

	public function delete( event, rc, prc ) {
		param name="rc.id" default="0";
		param name="rc.msg" default="";
		param name="rc.msgAction" default="";

		instance.passwordManagerService.deletePassword( id = rc.id );
		instance.passwordManagerService.removeAdditionalSecurityDetails( accID = rc.id );
		rc.msgAction = "Success";
		rc.msg = "Password details deleted successfully.";

		setNextEvent(event = 'password.list', persist = "msg,msgAction");
	}
}