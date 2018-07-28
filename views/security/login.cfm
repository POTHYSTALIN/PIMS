<cfparam name="rc.msg" default="">
<cfparam name="rc.msgAction" default="">

<div class="container">
	<cfoutput>
		<div style="min-height: 10px;">&nbsp;</div>
		<cfif len(rc.msg) AND rc.msgAction EQ "Error">
			<div class="alert alert-dismissible alert-danger" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Error!</strong> #rc.msg#
			</div>
		<cfelseif len(rc.msg) AND rc.msgAction EQ "Success">
			<div class="alert alert-dismissible alert-success" role="alert">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Success!</strong> #rc.msg#
			</div>
		</cfif>
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