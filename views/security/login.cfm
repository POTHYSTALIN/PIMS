<cfparam name="rc.msg" default="">
<cfparam name="rc.msgAction" default="">

<div class="container">
	<cfoutput>
		<div style="min-height: 10px;">&nbsp;</div>
		<cf_alerts msg="#rc.msg#" msgAction="#rc.msgAction#">
		<div class="login-main">
			<form action="#event.buildLink('security.doLogin')#" method="post">
				<input type="text" name="username" placeholder="user name" class="box1 border1">
				<input type="password" name="password" placeholder="password" class="box1 border2">
				<input type="submit" class="send" value="Go" name="">
				<p>Forgot Your Password? <a href="##">click here</a></p>
			</form>
		</div>
	</cfoutput>
</div>