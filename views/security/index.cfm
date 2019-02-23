<style type="text/css">
	.container-center {
		margin-left: auto;
		margin-right: auto;
		width: 50%;
		padding: 10px;
	}
	.container-login, .container-signup {
		margin-top: 50px;
		min-height: 450px;
		background-color: #e8e3e3;
		border-radius: 10px;
		padding: 30px;
		position: absolute;
		right: 39%;
		width: 330px;
	}
	.bg-secondary {
		color: white;
	}
	.login-main {
		width: 300px;
		height: 120px;
		position: absolute;
		margin: auto;
		top: 0;
		bottom: 0;
		left: 0;
		right: 0;
		/*background: #CDCCCE;*/
		background: #e8e3e3;
		padding: 10px;
		-webkit-border-radius: 10px;
		-moz-border-radius: 10px;
		-ms-border-radius: 10px;
		-o-border-radius: 10px;
		border-radius: 10px;
	}
	.login-main p {
		text-indent: 10px;
	}
	.box1 {
		/*background: #ffd5ce;*/
		background: #FEFEFE;
		height: 40px;
		text-indent: 10px;
		width: 90%;
		margin-bottom: 2px;
		color: #3B424D;
		font-size: 15px;
		font-weight: 400;
		border: none;
	}
	.border1 {
		-webkit-border-radius: 5px 5px 0 0;
		-moz-border-radius: 5px 5px 0 0;
		-ms-border-radius: 5px 5px 0 0;
		-o-border-radius: 5px 5px 0 0;
		border-radius: 5px 5px 0 0;
	}
	.border2 {
		-webkit-border-radius: 0px 0 5px 5px;
		-moz-border-radius: 0px 0 5px 5px;
		-ms-border-radius: 0px 0 5px 5px;
		-o-border-radius: 0px 0 5px 5px;
		border-radius: 0px 0 5px 5px;
	}
	.send {
		width: 60px;
		height: 60px;
		-webkit-border-radius: 50%;
		-moz-border-radius: 50%;
		-ms-border-radius: 50%;
		-o-border-radius: 50%;
		border-radius: 50%;
		position: absolute;
		right: 24px;
		top: 150px;
		border: 5px solid #CDCCCE;
		/*background: #FF5335;*/
		background: #FEFEFE;
		font-size: 18px;
		color: #2C2B2D;
		font-weight: normal;
		text-shadow: 1px 1px 2px #000;
		box-sizing: border-box;
		-webkit-box-sizing: border-box;
	}
	.send:hover {
		animation: spin 0.3s ease-in-out;
		-webkit-animation: spin 0.3s ease-in-out;
		-moz-animation: spin 0.3s ease-in-out;
		-ms-animation: spin 0.3s ease-in-out;
		-o-animation: spin 0.3s ease-in-out;
		cursor: pointer;
	}
	@keyframes spin {
		from {
			transform: rotate(0deg);
		}
		to {
			transform: rotate(360deg);
		}
	}
	@-webkit-keyframes spin {
		from {
			-webkit-transform: rotate(0deg);
		}
		to {
			-webkit-transform: rotate(360deg);
		}
	}
	@-moz-keyframes spin {
		from {
			-moz-transform: rotate(0deg);
		}
		to {
			-moz-transform: rotate(360deg);
		}
	}
	@-o-keyframes spin {
		from {
			-o-transform: rotate(0deg);
		}
		to {
			-o-transform: rotate(360deg);
		}
	}

	.container-profile-img {
		width: 43%;
		margin: 0 auto;
		margin-bottom: 10px;
	}
	.container-profile-img img {
		border-radius: 50%;
	}
</style>
<cfoutput>
<div class="container-center container-login">
	<div class="container-profile-img">
		<img src="/assets//img/profile-placeholder.jpg" width="100" height="100">
	</div>
	<form action="/security/doLogin" method="post">
		<input type="text" class="box1 border1" name="username" placeholder="user name">
		<input type="password" class="box1 border2" name="password" placeholder="password">
		<input type="submit" class="send" value="Go" name="">
		<p class="">Forgot Your Password? <a href="##">click here</a></p>
	</form>
</div>
</cfoutput>