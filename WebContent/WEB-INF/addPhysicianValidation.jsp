<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
    <%@ page import="java.util.Random"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="addPhysician()">
</body>
<%
	String userEmail = (String)session.getAttribute("SES_USEREMAIL");
	String physEmail = request.getParameter("email");
	String physName = request.getParameter("name");
	String physPsw = request.getParameter("psw");
	
	String db = "medprovider";
	String user = "root"; // assumes database name is the same as username
	String password = "Cannucks123!";
	int aPhys = -1;
	try {
	    
	    java.sql.Connection con; 
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.users WHERE Email like '" + 
	    		physEmail +"'");
		rs.next();
		aPhys = rs.getInt(1);
	    rs.close();
	    stmt.close();
	    con.close();
	} catch(SQLException e) { 
	    out.println("SQLException caught: " + e.getMessage()); 
	}
%>

<script type="text/javascript">
	function addPhysician(){
		var physFound = "<%= aPhys %>";
		var user = "<%= userEmail %>";

		if(physFound == 0){
			<%
			
			if(aPhys == 0){	
				try {
				    
				    java.sql.Connection con; 
				    Class.forName("com.mysql.cj.jdbc.Driver");
				    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
				    Statement stmt = con.createStatement();
				    int i = stmt.executeUpdate(
							"INSERT INTO users (Email, password, name) VALUES('" + physEmail +"','" + physPsw +"','" + physName +"')");
				    
				    Random r = new Random();
					int number = r.nextInt((99999 - 10000) + 1) + 10000;
					i = stmt.executeUpdate("INSERT INTO physicians(physician_id,emailphysician)VALUES('PH" + number + "','"
							+ physEmail + "')");
					
					i = stmt.executeUpdate(
							"INSERT INTO addphysician VALUES('" + userEmail +"','" + physEmail + "')");
				    stmt.close();
				    con.close();
				} catch(SQLException e) { 
				    out.println("SQLException caught: " + e.getMessage()); 
				}
			}
			%>
			
			alert("Physician Added");
		}
		else{
			alert("Physician already in database");
			
		}
		window.location= "adminHome.jsp";
	}
</script>

</html>