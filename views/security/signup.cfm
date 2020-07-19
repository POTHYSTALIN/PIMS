<cfoutput>
<div class="container-center">
	<!--- <div class="container-profile-img">
		<img src="/assets//img/profile-placeholder.jpg" width="100" height="100">
	</div> --->
	<form action="/security/doSignup" method="post">
		<!--- <input type="text" class="box1 border1" name="username" placeholder="user name">
		<input type="password" class="box1 border2" name="password" placeholder="password">
		<input type="submit" class="send" value="Go" name="">
		<p class="">Forgot Your Password? <a href="##">click here</a></p> --->
		<div class="row">
			<div class="col">
				<div class="form-group">
					<label for="firstname">First name</label>
					<input type="text" class="form-control" id="firstname" name="firstname" aria-describedby="firstnameHelp" placeholder="Enter your first name">
					<!--- <small id="firstnameHelp" class="form-text text-muted">Enter your first name</small> --->
				</div>
				<div class="form-group">
					<label for="email">Email</label>
					<input type="text" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Enter your email">
				</div>
				<div class="form-group">
					<label for="username">Username</label>
					<input type="text" class="form-control" id="username" name="username" aria-describedby="usernameHelp" placeholder="Enter your username">
				</div>
				<div class="form-group">
					<label for="password">Password</label>
					<input type="password" class="form-control" id="password" name="password" aria-describedby="passwordHelp" placeholder="Enter your password">
				</div>
			</div>
			<div class="col">
				<div class="form-group">
					<label for="lastname">Last name</label>
					<input type="text" class="form-control" id="lastname" name="lastname" aria-describedby="lastnameHelp" placeholder="Enter your last name">
				</div>
				<div class="form-group">
					<label for="phone">Phone</label>
					<input type="text" class="form-control" id="phone" name="phone" aria-describedby="phoneHelp" placeholder="Enter your phone">
				</div>
				<div class="form-group">
					<label for="profileImg">Profile image</label>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="profileImg" name="profileImg" aria-describedby="profileImgHelp">
						<label class="custom-file-label" for="profileImg">Choose file</label>
					</div>
				</div>
				<div class="form-group">
					<label for="confirmPassword">Confirm password</label>
					<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" aria-describedby="confirmPasswordHelp" placeholder="Re-enter your password">
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<button type="submit" class="btn btn-success">Submit</button>
				<button type="reset" class="btn btn-danger">Cancel</button>
			</div>
		</div>
	</form>
</div>
</cfoutput>