<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
    <%@ page import="java.time.LocalDate"%>
     
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="createMessages()">
</body>
<%
	String userEmail = (String)session.getAttribute("SES_USEREMAIL");
	String physEmail = request.getParameter("email");
	
	//converting current date to a string - might find a better way
	Date date = Date.valueOf(LocalDate.now());
	
	String msgContent = request.getParameter("message");
	
	String db = "medprovider";
	String user = "root"; // assumes database name is the same as username
	String password = "Cannucks123!";
	int aPhysician = -1;
	try {
	    
	    java.sql.Connection con; 
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.physicians WHERE Emailphysician = '" + 
		    	physEmail +"'");
		rs.next();
		aPhysician = rs.getInt(1);
	    rs.close();
	    stmt.close();
	    con.close();
	} catch(SQLException e) { 
	    out.println("SQLException caught: " + e.getMessage()); 
	}
%>

<script type="text/javascript">
	function createMessages(){
		var physFound = "<%= aPhysician %>";
		if(physFound>0){
			<%
			if(aPhysician>0){	
				try {
				    
				    java.sql.Connection con; 
				    Class.forName("com.mysql.cj.jdbc.Driver");
				    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
				    Statement stmt = con.createStatement();
				    int i = stmt.executeUpdate(
							"INSERT INTO messages(content, date)VALUES('" + msgContent + "','" + date +"')");
				    i = stmt.executeUpdate(
							"INSERT INTO patients_msg VALUES('" + userEmail + "',(SELECT last_insert_id()))");
				    i = stmt.executeUpdate(
							"INSERT INTO physician_msg VALUES('" + physEmail + "',(SELECT last_insert_id()))");
				    stmt.close();
				    con.close();
				} catch(SQLException e) { 
				    out.println("SQLException caught: " + e.getMessage()); 
				}
			}
			%>
			window.location= "patientHome.jsp";
			alert("Message Sent");
		}
		else{
			alert("Physician not found");
			window.location= "patientHome.jsp";
		}
	}
</script>

</html>