component extends="coldbox.system.EventHandler" output="false"{
	property name="CBConfigSettings" inject="coldbox:configSettings";
	property name="CBFWSettings" inject="coldbox:fwSettings";

	function preHandler( event, action, eventArguments, rc, prc ){
		request.CBConfigSettings 	= CBConfigSettings;
		request.CBFWSettings 		= CBFWSettings;
	}
}