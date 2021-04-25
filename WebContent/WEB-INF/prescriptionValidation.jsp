<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="createPrescription()">
</body>
<%
	String userEmail = (String)session.getAttribute("SES_USEREMAIL");
	String patientEmail = request.getParameter("email");
	String medName = request.getParameter("med-name");
	String frequency = request.getParameter("frequency");
	String dosage = request.getParameter("dosage");
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
	    		patientEmail +"'");
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
	function createPrescription(){
		var patFound = "<%= aPatient %>";
		var patEmail = "<%= patientEmail %>";
		if(patFound>0){
			<%
			if(aPatient>0){	
				try {
				    
				    java.sql.Connection con; 
				    Class.forName("com.mysql.cj.jdbc.Driver");
				    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
				    Statement stmt = con.createStatement();
				    int i = stmt.executeUpdate(
							"insert into prescription (frequency, dosage) value ('" + frequency + "', '" + dosage + "mL')");
				    i = stmt.executeUpdate(
							"INSERT INTO receives VALUES('" + patientEmail + "',(SELECT last_insert_id()))");
				    i = stmt.executeUpdate(
							"INSERT INTO prescribes VALUES('" + userEmail + "',(SELECT last_insert_id()))");
				    i = stmt.executeUpdate(
							"INSERT INTO has VALUES((select med_id from medication where med_name ='" + medName + "'"+ "),(SELECT last_insert_id()));");
				    stmt.close();
				    con.close();
				} catch(SQLException e) { 
				    out.println("SQLException caught: " + e.getMessage()); 
				}
			}
			%>
						
			alert("Prescription Created");
		}
		else{
			alert("Physician not found");
			
		}
		window.location= "physicianHome.jsp";
	}
</script>

</html>