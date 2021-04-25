<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="ISO-8859-1">
		<link rel="stylesheet" href="styles.css">
		<title>Login Page</title>
	</head>


	<body>
		<div class="row">
			<div class="column left"></div>
			<div class="column middle">
				<div class="form-container">
					<form id="login-form" action="loginValidation.jsp" method="post">
						<div class="login-header">	
							<div class = "logo">
								<div class="container">
									<img src="images/logo.png" alt="Logo">
									<p>
										<b>
											<i>MedProvider</i>
										</b>
									</p>
								</div>
							</div>
						</div>
						<div class="login-body">
							<label for="email"><b>Email</b></label>
							<input type ="text" placeholder="Enter Email" name="email" required>
							<label for="psw"><b>Password</b></label>
							<input type="password" placeholder="Enter Password" name="psw" required>
							<button id="login" type="submit">Login</button>
						</div>
					</form>
					<form id="signUp-btn" action="signUpPage.jsp" method="post">
						<button class="signup" type="submit">Create Account</button>
					</form>
				</div>
			</div>
			
			
			<div class="column right"></div>
		</div>
	</body>
</html>