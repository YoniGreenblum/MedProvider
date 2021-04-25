<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="isUser()">

</body>

<% 
String email = request.getParameter("email");
String psw = request.getParameter("psw");
session.setAttribute("SES_USEREMAIL", email);

String db = "medprovider";
String user = "root"; // assumes database name is the same as username
String password = "Cannucks123!";
int aUser = -1;
int aPatient = -1;
int aPhysician = -1;
int aAdmin= -1;
try {
    
    java.sql.Connection con; 
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.users WHERE Email = '" + 
    	email +"' AND password= '" + psw + "'");
    rs.next();
    aUser = rs.getInt(1);
    rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.patients WHERE Emailpatient = '" + 
	    	email +"'");
	rs.next();
	aPatient = rs.getInt(1);
    rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.physicians WHERE Emailphysician = '" + 
	    	email +"'");
	rs.next();
	aPhysician = rs.getInt(1);
	rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.administrators WHERE Emailadmin = '" + 
	    	email +"'");
	rs.next();
	aAdmin = rs.getInt(1);
    rs.close();
    stmt.close();
    con.close();
} catch(SQLException e) { 
    out.println("SQLException caught: " + e.getMessage()); 
}
					
%>
<script type="text/javascript">
function isUser(){
	var userFound = "<%= aUser %>";
	var patFound = "<%= aPatient %>";
	var physFound = "<%= aPhysician %>";
	var adminFound = "<%= aAdmin %>";
	
	if(userFound>0){
	 	if (patFound>0)
			window.location = "patientHome.jsp";
		else if (physFound>0)
			window.location = "physicianHome.jsp";
		else if (adminFound > 0)
			window.location = "adminHome.jsp";
	}
	else{
		alert("Invalid email or password");
		window.location = "loginPage.jsp";
	}
}
</script>


</html>

