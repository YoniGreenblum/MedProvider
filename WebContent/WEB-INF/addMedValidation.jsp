<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="addMedication()">
</body>
<%
	String userEmail = (String)session.getAttribute("SES_USEREMAIL");
	String medName = request.getParameter("medication");
	
	String db = "medprovider";
	String user = "root"; // assumes database name is the same as username
	String password = "Cannucks123!";
	int aMed = -1;
	try {
	    
	    java.sql.Connection con; 
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.medication WHERE med_name like '" + 
		    	medName +"'");
		rs.next();
		aMed = rs.getInt(1);
	    rs.close();
	    stmt.close();
	    con.close();
	} catch(SQLException e) { 
	    out.println("SQLException caught: " + e.getMessage()); 
	}
%>

<script type="text/javascript">
	function addMedication(){
		var medFound = "<%= aMed %>";
		var user = "<%= userEmail %>";

		if(medFound == 0){
			<%
			if(aMed == 0){	
				try {
				    
				    java.sql.Connection con; 
				    Class.forName("com.mysql.cj.jdbc.Driver");
				    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
				    Statement stmt = con.createStatement();
				    int i = stmt.executeUpdate(
							"INSERT INTO medication (med_name) VALUES('" + medName +"')");
				    i = stmt.executeUpdate(
							"INSERT INTO addmed VALUES('" + userEmail + "',(SELECT last_insert_id()))");
				    stmt.close();
				    con.close();
				} catch(SQLException e) { 
				    out.println("SQLException caught: " + e.getMessage()); 
				}
			}
			%>
			
			alert("Medication Added");
		}
		else{
			alert("Medication already in database");
			
		}
		window.location= "adminHome.jsp";
	}
</script>

</html>