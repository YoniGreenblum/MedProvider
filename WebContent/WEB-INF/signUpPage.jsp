<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>

<head>
<link rel="stylesheet" href="styles.css">
<title>MedProvider</title>
</head>
<body>

	<h1 style="text-align: center">Welcome to MedProvider - Providing
		you with all your health related needs</h1>

	<div style="text-align: center;">
		<img src="images/logo.png" alt="Logo">
	</div>

	<form id="signUp-form" action="signUpValidation.jsp" method="post">

		<h1 style="text-align: left">Please choose your type of user:</h1>
		<div class="login-body">
			<div style="text-align: left;">
				<span class="sortOptions"> 
				<input type="radio" id="patient" name="radAnswer" value="patient"><label> Patient </label> <br>
				<input type="radio" id="physician" name="radAnswer" value="physician"> <label> Physician</label> <br>
				<input type="radio" id="administrator" name="radAnswer" value="administrator"> <label>Administrator</label> <br>
				<br>
				</span>
			</div>
			<label for="username"><b>Name</b></label> <input type="text"
				placeholder="Enter Name" name="username" required> <label
				for="email"><b>Email</b></label> <input type="text"
				placeholder="Enter Email" name="email" required> <label
				for="psw"><b>Password</b></label> <input type="password"
				placeholder="Enter Password" name="psw" required>
				
				
		</div>
		<button class="signup" type="submit">Sign Up</button>
	</form>
	<form action="loginPage.jsp">
		<button class="signup" type="submit">Cancel</button>
	</form>


</body>
</html>
