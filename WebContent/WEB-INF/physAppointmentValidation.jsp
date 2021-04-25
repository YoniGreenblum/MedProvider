<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="createAppointment()">
</body>
<%
	String userEmail = (String)session.getAttribute("SES_USEREMAIL");
	String patEmail = request.getParameter("email");
	String date = request.getParameter("appoint_date");
	String time = request.getParameter("appoint_time");
	
	String db = "medprovider";
	String user = "root"; // assumes database name is the same as username
	String password = "Cannucks123!";
	int aPatient = -1;
	try {
	    
	    java.sql.Connection con; 
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.patients WHERE Emailpatient = '" + 
	    		patEmail +"'");
		rs.next();
		aPatient = rs.getInt(1);
	    rs.close();
	    stmt.close();
	    con.close();
	} catch(SQLException e) { 
	    out.println("SQLException caught: " + e.getMessage()); 
	}
%>

<script type="text/javascript">
	function createAppointment(){
		var patFound = "<%= aPatient %>";
		var phys = "<%= patEmail %>";
		var user = "<%= userEmail %>";
		var date = "<%= date %>";
		console.log(date)
		if(patFound>0){
			<%
			if(aPatient>0){	
				try {
				    
				    java.sql.Connection con; 
				    Class.forName("com.mysql.cj.jdbc.Driver");
				    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
				    Statement stmt = con.createStatement();
				    int i = stmt.executeUpdate(
							"INSERT INTO appointment (appointment_date, appointment_time) VALUES('" + date + "','" + time +"')");
				    i = stmt.executeUpdate(
							"INSERT INTO appointment_patient VALUES('" + patEmail + "',(SELECT last_insert_id()))");
				    i = stmt.executeUpdate(
							"INSERT INTO appointment_physician VALUES('" + userEmail + "',(SELECT last_insert_id()))");
				    stmt.close();
				    con.close();
				} catch(SQLException e) { 
				    out.println("SQLException caught: " + e.getMessage()); 
				}
			}
			%>
			
			window.location= "physicianHome.jsp";
			alert("Appointment Created");
		}
		else{
			alert("Patient not found");
			window.location= "physicianHome.jsp";
		}
	}
</script>

</html>