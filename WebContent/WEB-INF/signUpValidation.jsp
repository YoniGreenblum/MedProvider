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
<body onload="isNotNewEmail()">

</body>

<%

String db = "medprovider";
String user = "root"; // assumes database name is the same as username
String password = "Cannucks123!";
int aUser = -1;
try {
	java.sql.Connection con;
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT", user, password);
	Statement stmt = con.createStatement();
	String email = request.getParameter("email");
	ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM medprovider.users WHERE Email = '" + email + "' ");
	rs.next();
	aUser = rs.getInt(1);
	rs.close();
	stmt.close();
	con.close();
} catch (SQLException e) {
	out.println("SQLException caught: " + e.getMessage());
}
%>


<script type="text/javascript">
<%String type = request.getParameter("radAnswer");%>



function isNotNewEmail() {
	var emailfound = "<%=aUser%>";
	
	if(emailfound > 0)
	{
			alert("Cannot create new account with this email");
			window.location = "signUpPage.jsp";
	}
	else{	
		var chosen = "<%=type%>";
		console.log(chosen);
		
		<%
			String name = request.getParameter("username");
			String email = request.getParameter("email");
			String pass = request.getParameter("psw");

			System.out.println(type);
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider", "root",
						"Cannucks123!");
				Statement st = conn.createStatement();

				int i = st.executeUpdate(
						"INSERT INTO users(email,password,name)VALUES('" + email + "','" + pass + "','" + name + "')");
			

				if (type.equals("patient")) {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider", "root",
						"Cannucks123!");
				st = conn.createStatement();

				Random r = new Random();
				int number = r.nextInt((99999 - 10000) + 1) + 10000;

				i = st.executeUpdate(
						"INSERT INTO patients(patient_id,emailpatient)VALUES('PA" + number + "','" + email + "')");

			} else if (type.equals("physician")) {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider", "root", "Cannucks123!");
				st = conn.createStatement();
				Random r = new Random();
				int number = r.nextInt((99999 - 10000) + 1) + 10000;


				i = st.executeUpdate("INSERT INTO physicians(physician_id,emailphysician)VALUES('PH" + number + "','"
						+ email + "')");
			} else {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider", "root", "Cannucks123!");
				st = conn.createStatement();
				Random r = new Random();
				int number = r.nextInt((99999 - 10000) + 1) + 10000;
				i = st.executeUpdate(
						"INSERT INTO administrators(admin_id,emailadmin)VALUES('AD" + number + "','" + email + "')");
			}
			} catch (Exception e) {
				System.out.print(e);
				e.printStackTrace();
			}
			%>
	alert("User Created");
	window.location = "loginPage.jsp";
		}

	}
</script>


</html>