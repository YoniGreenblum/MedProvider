<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>Administrator Homepage</title>
</head>
<body>
	<div class="row">
		<div class="column left"></div>
		<div class="column middle">
			<div class="middle-header">
				<div class="logout" style="float:right">
					<div id="logout-btn" style="align:center;">
						<a href="loginPage.jsp">Log out</a>
					</div>
				</div>
				
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
			<div class="middle-body">
				<div class="body-btns">
					<button id="add-medication-btn" onClick="initAddForm()">Add
						a Medication</button>
				</div>
				<div class="body-btns">
					<button id="add-physician-btn" onClick="initAddPhysiciansForm()">Add
						a Physician</button>
				</div>
				<div class="body-btns">
					<button id="view-appoint-btn" onClick="showAppointments()">View
							All Appointments</button>
						
				</div>
				<div class="body-btns">
					<button id="view-prescriptions-btn" onClick="showPrescriptions()">View
							Prescriptions</button>
				</div>
			<div class="form-container">
					<form id="add-medication-form" action="addMedValidation.jsp"
						method="post" style="display: none">
						<div class="add-medication-body">
							<label for="email"><b>Medication Name</b></label> <input
								id="adminEmail" type="text" placeholder="Enter Medication"
								name="medication" required>
							<button id=submit-btn type="submit">Submit</button>

							<script type="text/javascript">
							function hideAll() {
								var formVis = document
								.getElementById('add-medication-form');
								var physiciansVis = document
								.getElementById('add-physician-form');
								var appVis = document
								.getElementById('view_app_table');
								var prescVis = document
								.getElementById('view_presc_table');
								
								formVis.style.display = "none";
								physiciansVis.style.display = "none";
								appVis.style.display = "none";
								prescVis.style.display = "none";
								
							}
							
							function showAppointments() {
								
								var formVis = document
											.getElementById('view_app_table');
									if (formVis.style.display === "none") {
										hideAll();
										formVis.style.display = "block";
									} else {
										formVis.style.display = "none";
									}
								}
							function showPrescriptions() {
								
								var formVis = document
											.getElementById('view_presc_table');
									if (formVis.style.display === "none") {
										hideAll();
										formVis.style.display = "block";
									} else {
										formVis.style.display = "none";
									}
								}
							
								function initAddForm() {
								
									var formVis = document
											.getElementById('add-medication-form');
									if (formVis.style.display === "none") {
										hideAll();
										formVis.style.display = "block";
									} else {
										formVis.style.display = "none";
									}
								}
								function submitAdd() {
									var adminEmail = document
											.getElementById('adminEmail').value;
									var date = document
											.getElementById('datePicker').value;
									var time = document
											.getElementById('timePicker').value;
									console.log(adminEmail);
									console.log(date);
									console.log(time);
								}
							</script>
						</div>
					</form>
					
					<%-- add physician form --%>
					<div class="form-container">
						<form id="add-physician-form" action="addPhysicianValidation.jsp" method="post" style="display: none">
							<div class="add-physician-form">
								<label for="name"><b>Physician's Name</b></label>
								<input id="physName" type="text" placeholder="Enter name" name="name" required> 
								<label for="email"><b>Physician's Email</b></label>
								<input id="physEmail" type="text" placeholder="Enter Email" name="email" required> 
								<label for="psw"><b>Password</b></label>
								<input type="password" placeholder="Enter Password" name="psw" required>
								<button id=submit-btn type="submit">Submit</button>

								<script type="text/javascript">
									
									function initAddPhysiciansForm() {
										var formVis = document
												.getElementById('add-physician-form');
										if (formVis.style.display === "none") {
											hideAll();
											formVis.style.display = "block";
											var today = new Date();
											var year = today.getFullYear();
											var month = String(
													today.getMonth() + 1)
													.padStart(2, '0');
											var day = String(today.getDate())
													.padStart(2, '0');
										} else {
											formVis.style.display = "none";
										}
									}
									
									function showPhysicians() {
									
									var formVis = document
												.getElementById('view_phys_table');
										if (formVis.style.display === "none") {
											hideAll();
											formVis.style.display = "block";
										} else {
											formVis.style.display = "none";
										}
									}
									
									function showModify() {
								
									var formVis = document
												.getElementById('view_modify_table');
										if (formVis.style.display === "none") {
											hideAll();
											formVis.style.display = "block";
										} else {
											formVis.style.display = "none";
										}
									}
									function addPhysicain() {
										var adminEmail = document
												.getElementById('adminEmail').value;
										var add = document
												.getElementById('addphysician').value;
									}
								</script>
							</div>
						</form>
					</div>
					<div id="view_app_table" style="display: none">

						<table class=fixed-table rules="all">
							<tr>
								<th>Patient Email</th>
								<th>Physician Email</th>
								<th>Date</th>
								<th>Time</th>
							</tr>
							
								
								<%
									String userEmail = (String)session.getAttribute("SES_USEREMAIL");
									String db = "medprovider";
									String user = "root"; // assumes database name is the same as username
									String password = "Cannucks123!";
									try {
										java.sql.Connection con;
										Class.forName("com.mysql.cj.jdbc.Driver");
										con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT", user, password);
										Statement stmt = con.createStatement();
										ResultSet rs = stmt
												.executeQuery("select patientemail_app, physicianemail_app, appointment_date, appointment_time "
														+ " from appointment_patient join appointment on (appointment_id = patient_app_id) "
														+ " join appointment_physician on(appointment_id = physician_app_id)");
										while (rs.next()) {
								
											%>
											
										<tr>
											 <td><%=rs.getString(1) %></td>
											 <td><%=rs.getString(2) %></td>
											 <td><%=rs.getString(3) %></td>
											 <td><%=rs.getString(4) %></td>
										</tr>
										<%
										}
										rs.close();
										stmt.close();
										con.close();
									} catch (SQLException e) {
										out.println("SQLException caught: " + e.getMessage());
									}
								%>
							
						</table>
					</div>
					<div id="view_presc_table" style="display: none">

						<table class=fixed-table rules="all">
							<tr>
								<th>Physician's Email</th>
								<th>Medication</th>
							</tr>		
								<%
									try {

										java.sql.Connection con;
										Class.forName("com.mysql.cj.jdbc.Driver");
										con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT", user, password);
										Statement stmt = con.createStatement();
										ResultSet rs = stmt
												.executeQuery("select Emailphysician, med_name from has join medication on (med_id_has = med_id) join prescribes on (prescription_id_has = prescriptionid)" );

										while (rs.next()) {
								
											%>
											
										<tr>
											 <td><%=rs.getString(1) %></td>
											 <td><%=rs.getString(2) %></td>
										</tr>
										<%
										}
										rs.close();
										stmt.close();
										con.close();
									} catch (SQLException e) {
										out.println("SQLException caught: " + e.getMessage());
									}
								%>
							
						</table>
					</div>
				</div>
			</div>
		</div>


		<div class="column right"></div>
	</div>
	
</body>
</html>