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
					<button id="make-appoint-btn" onClick="initAppointmentForm()">Make
						an Appointment</button>
					<button id="view-appoint-btn" onClick="showAppointments()">View
						Your Appointments</button>
				</div>
				<div class="body-btns">
					<button id="contact-physician-btn" onClick="initMessageForm()">Contact
						a Physician</button>
					<button id="view-messages-btn" onClick="showMessages()">View
						Messages</button>
				</div>
				<div class="body-btns">
					<button id="view-prescriptions-btn" onClick="showPrescriptions()">View
						Prescriptions</button>
				</div>
				</div>
				<div class="form-container">
					<form id="make-appoint-form" action="appointmentValidation.jsp"
						method="post" style="display: none">
						<div class="make-appoint-body">
							<label for="email"><b>Physician's Email</b></label> <input
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
								var prescTableVis = document
								.getElementById('view_presc_table');
								
								formVis.style.display = "none";
								appVis.style.display = "none";
								messagesVis.style.display = "none";
								msgTableVis.style.display = "none";
								prescTableVis.style.display = "none";
								
								
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

								function submitAppointment() {
									var physEmail = document
											.getElementById('physEmail').value;
									var date = document
											.getElementById('datePicker').value;
									var time = document
											.getElementById('timePicker').value;
									console.log(physEmail);
									console.log(date);
									console.log(time);
								}
							</script>
						</div>
					</form>

					<%-- message form --%>
					<div class="form-container">
						<form id="make-message-form" action="patientMessageValidation.jsp" method="post" style="display: none">
							<div class="make-message-form">
								<label for="email"><b>Physician's Email</b></label>
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
								<th>Physician Email</th>
								<th>Message</th>
								<th>Date</th>
							</tr>
							
								
								<%
									String userEmail = (String)session.getAttribute("SES_USEREMAIL");
									String db = "medprovider";
									String user = "root"; // assumes database name is the same as username
									String password = "Cannucks123!";
									String test = "nothing changed";
									try {

										java.sql.Connection con;
										Class.forName("com.mysql.cj.jdbc.Driver");
										con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT", user, password);
										Statement stmt = con.createStatement();
										ResultSet rs = stmt
												.executeQuery("SELECT physicianemail_msg, content, date FROM messages, physician_msg,"
														+ "(SELECT patients_msg_id from patients_msg WHERE patientsemail_msg = '" + userEmail
														+ "')Temp"
														+ " WHERE Temp.patients_msg_id = msg_id AND Temp.patients_msg_id = physician_msg_id "
														+ "ORDER BY Temp.patients_msg_id DESC");

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
												.executeQuery("SELECT physicianemail_app, appointment_date, appointment_time" 
														+ " FROM appointment, appointment_physician,"
														+ "(SELECT patient_app_id FROM appointment_patient WHERE patientemail_app = '" + userEmail
														+ "')Temp"
														+ " WHERE Temp.patient_app_id = appointment_id AND Temp.patient_app_id = physician_app_id "
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
					<div id="view_presc_table" style="display: none">

						<table class=fixed-table rules="all">
							<tr>
								<th>Medication</th>
								<th>Frequency</th>
								<th>Dosage</th>
							</tr>
							
								
								<%
									try {

										java.sql.Connection con;
										Class.forName("com.mysql.cj.jdbc.Driver");
										con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medprovider?serverTimezone=EST5EDT", user, password);
										Statement stmt = con.createStatement();
										ResultSet rs = stmt
												.executeQuery("select med_name, TempHas.frequency, TempHas.dosage " 
														+ " from medication, (select med_id_has, frequency, dosage "
														+ "from prescription, has, (select prescriptionid from receives where Emailpatient_receive = '" + userEmail
														+ "')Temp"
														+ " where Temp.prescriptionid = prescription_id and Temp.prescriptionid = prescription_id_has)TempHas "
														+ "where med_id = TempHas.med_id_has");

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