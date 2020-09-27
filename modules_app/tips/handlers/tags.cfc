component extends="coldbox.system.EventHandler" {
	property name="tagsService" inject="tags@tips" scope="instance";

	public function index( event, rc, prc ) {
		param name="rc.msgAction" default="";
		param name="rc.msg" default="";
		param name="rc.id" default="0";

		prc.tips = instance.tagsService.list();
	}
}