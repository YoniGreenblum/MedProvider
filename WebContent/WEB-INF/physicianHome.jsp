<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="styles.css">
<title>Patient Homepage</title>
</head>
<body>

	<div class="row">
		<div class="column left"></div>
		<div class="column middle">
			<div class="middle-header">
				<div class="logout" style="float: right">
					<div id="logout-btn" style="align: center;">
						<a href="loginPage.jsp">Log out</a>
					</div>
				</div>

				<div class="logo">
					<div class="container">
						<img src="images/logo.png" alt="Logo">
						<p>
							<b> <i>MedProvider</i>
							</b>
						</p>
					</div>
				</div>
			</div>
			<div class="middle-body">
				<div id="btn-container">
				<div class="body-btns">
					<button id="phys-make-appoint-btn" onClick="initAppointmentForm()">Make
						an Appointment</button>
					<button id="view-appoint-btn" onClick="showAppointments()">View
						Your Appointments</button>
				</div>
				<div class="body-btns">
					<button id="contact-patient-btn" onClick="initMessageForm()">Contact
						a Patient</button>
					<button id="view-messages-btn" onClick="showMessages()">View
						Messages</button>
				</div>
				<div class="body-btns">
					<button id="make-prescriptions-btn" onClick="showPrescriptionForm()">Create
						Prescription</button>
				</div>
				</div>
				<div class="form-container">
					<form id="make-appoint-form" action="physAppointmentValidation.jsp"
						method="post" style="display: none">
						<div class="make-appoint-body">
							<label for="email"><b>Patient's Email</b></label> <input
								id="physEmail" type="text" placeholder="Enter Email"
								name="email" required> <label for="appoint-date"><b>Date&Time</b></label>
							<input id="datePicker" type="date" name="appoint_date" required>
							<input id="timePicker" type="time" name="appoint_time" min="8:00"
								max="18:00" step="60" required>
							<button id=submit-btn type="submit">Submit</button>

							<script type="text/javascript">
							function hideAll() {
								var formVis = document
								.getElementById('make-appoint-form');
								var appVis = document
								.getElementById('view_app_table');
								var messagesVis = document
								.getElementById('make-message-form');
								var msgTableVis = document
								.getElementById('view_msg_table');
								var prescFormVis = document
								.getElementById('make-prescription-form');
								
								formVis.style.display = "none";
								appVis.style.display = "none";
								messagesVis.style.display = "none";
								msgTableVis.style.display = "none";
								prescFormVis.style.display = "none";
								
								
							}
							
							function initAppointmentForm() {
								
								var formVis = document
										.getElementById('make-appoint-form');
								if (formVis.style.display === "none") {
									hideAll();
									formVis.style.display = "block";
									var today = new Date();
									var year = today.getFullYear();
									var month = String(today.getMonth() + 1)
											.padStart(2, '0');
									var day = String(today.getDate())
											.padStart(2, '0');
									document.getElementById('datePicker').min = year
											+ "-" + month + "-" + day;
								} else {
									formVis.style.display = "none";
								}

							}
							</script>
						</div>
					</form>

					<%-- message form --%>
					<div class="form-container">
						<form id="make-message-form" action="physicianMessageValidation.jsp" method="post" style="display: none">
							<div class="make-message-form">
								<label for="email"><b>Patient's Email</b></label>
								<input id="physEmail" type="text" placeholder="Enter Email" name="email" required> 
								<label for="message"><b>Message</b></label>
								<textarea id="messagefrompatient" rows="10" cols="60"
									placeholder="Enter Message" name="message" required></textarea>
								<button id=submit-btn type="submit">Submit</button>

								<script type="text/javascript">
									
									function initMessageForm() {
										var formVis = document
												.getElementById('make-message-form');
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
									
									function showMessages() {
									
									var formVis = document
												.getElementById('view_msg_table');
										if (formVis.style.display === "none") {
											hideAll();
											formVis.style.display = "block";
										} else {
											formVis.style.display = "none";
										}
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
									function submitMessage() {
										var physEmail = document
												.getElementById('physEmail').value;
										var message = document
												.getElementById('messagefrompatient').value;
									}
								</script>
							</div>
						</form>
					</div>
					<div class="form-container">
						<form id="make-prescription-form" action="prescriptionValidation.jsp" method="post" style="display: none">
							<div class="make-prescription-form">
								<label for="email"><b>Patient's Email</b></label>
								<input id="patientEmail" type="text" placeholder="Enter Email" name="email" required> 
								<label for="medication"><b>Medication</b></label>
								<select name="med-name">
									<%				
									String db = "medprovider";
									String user = "root"; // assumes database name is the same as username
									String password = "Cannucks123!";
									try {
									    
									    java.sql.Connection con; 
									    Class.forName("com.mysql.cj.jdbc.Driver");
									    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT",user, password);
									    Statement stmt = con.createStatement();
									    ResultSet rs = stmt.executeQuery("SELECT med_name FROM medprovider.medication");
										rs.next();


								
										while (rs.next()) {
									%>
									<option><%=rs.getString(1)%></option>
									<%
										}
									    rs.close();
									    stmt.close();
									    con.close();
									} catch(SQLException e) { 
									    out.println("SQLException caught: " + e.getMessage()); 
									}
									%>
									
								</select> 
								<br><br>
								<label for="medication"><b>Frequency</b></label>
								<input id="frequency" type="text" placeholder="Enter Frequency" name="frequency" required> 
								<label for="medication"><b>Dosage</b></label>
								<input id="med-name" type="number" placeholder="Enter Dosage" name="dosage" required min="1"> 
								<label for="unit">mL</label>
								<button id=submit-btn type="submit">Submit</button>

								<script type="text/javascript">
									
									function initMessageForm() {
										var formVis = document
												.getElementById('make-message-form');
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
									
									function showMessages() {
									
									var formVis = document
												.getElementById('view_msg_table');
										if (formVis.style.display === "none") {
											hideAll();
											formVis.style.display = "block";
										} else {
											formVis.style.display = "none";
										}
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
									
									function showPrescriptionForm() {
										
										var formVis = document
													.getElementById('make-prescription-form');
											if (formVis.style.display === "none") {
												hideAll();
												formVis.style.display = "block";
											} else {
												formVis.style.display = "none";
											}
										}
									function submitMessage() {
										var physEmail = document
												.getElementById('physEmail').value;
										var message = document
												.getElementById('messagefrompatient').value;
									}
								</script>
							</div>
						</form>
					</div>
					<div id="view_msg_table" style="display: none">

						<table class=fixed-table rules="all">
							<tr>
								<th>Patient Email</th>
								<th>Message</th>
								<th>Date</th>
							</tr>
							
								
								<%
									String userEmail = (String)session.getAttribute("SES_USEREMAIL");
									/* String db = "medprovider";
									String user = "root"; // assumes database name is the same as username
									String password = "Cannucks123!"; */
									try {

										java.sql.Connection con;
										Class.forName("com.mysql.cj.jdbc.Driver");
										con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT", user, password);
										Statement stmt = con.createStatement();
										ResultSet rs = stmt
												.executeQuery("SELECT patientsemail_msg, content, date FROM messages, patients_msg, "
														+ "(SELECT physician_msg_id from physician_msg WHERE physicianemail_msg = '" + userEmail
														+ "')Temp"
														+ " WHERE Temp.physician_msg_id = msg_id AND Temp.physician_msg_id = patients_msg_id "
														+ "ORDER BY Temp.physician_msg_id DESC");

										while (rs.next()) {
								
											%>
											
										<tr>
											 <td><%=rs.getString(1) %></td>
											 <td><%=rs.getString(2) %></td>
											 <td><%=rs.getString(3) %></td>
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
					<div id="view_app_table" style="display: none">

						<table class=fixed-table rules="all">
							<tr>
								<th>Physician Email</th>
								<th>Date</th>
								<th>Time</th>
							</tr>
							
								
								<%
									try {

										java.sql.Connection con;
										Class.forName("com.mysql.cj.jdbc.Driver");
										con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT", user, password);
										Statement stmt = con.createStatement();
										ResultSet rs = stmt
												.executeQuery("SELECT patientemail_app, appointment_date, appointment_time" 
														+ " FROM appointment, appointment_patient,"
														+ "(SELECT physician_app_id FROM appointment_physician WHERE physicianemail_app = '" + userEmail
														+ "')Temp"
														+ " WHERE Temp.physician_app_id = appointment_id AND Temp.physician_app_id = patient_app_id "
														+ "ORDER BY appointment_date DESC");

										while (rs.next()) {
								
											%>
											
										<tr>
											 <td><%=rs.getString(1) %></td>
											 <td><%=rs.getString(2) %></td>
											 <td><%=rs.getString(3) %></td>
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