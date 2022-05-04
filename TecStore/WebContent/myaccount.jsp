<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*, it.unisa.model.* "
	session="true"%>

<%
	UserBean user = (UserBean) request.getSession().getAttribute("user");
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	Boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
	Boolean operatorlog = (Boolean)request.getSession().getAttribute("operatorlog");

	if (userlog==null){
		userlog=false;
		adminlog=false;
		operatorlog=false;
	}
	
	if(adminlog==null){
		adminlog=false;
	}
	
	if(operatorlog==null){
		operatorlog=false;
	}
	
	if (user == null || userlog == false) {
		user = new UserBean();
		response.sendRedirect("index.jsp");
	}
	
	String error = (String) session.getAttribute("error");
	if(error == null)
		error = "";
	else {
		session.removeAttribute("error");
	}
	
	String ok = (String) session.getAttribute("ok");
	if(ok == null)
		ok = "";
	else {
		session.removeAttribute("ok");
	}
%>

<!DOCTYPE html>
<html lang="it">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css">
<!-- Plugin CSS -->
<link href="vendor/magnific-popup/magnific-popup.css" rel="stylesheet"
	type="text/css">
<!-- Custom styles for this template -->
<link href="css/freelancer.css" rel="stylesheet">
<!-- Log-in W3SCHOOL Icon -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>TecStore</title>
</head>

<body id="page-top">

	<!-- Navigation -->
	<%if(userlog==true && adminlog!=true && operatorlog!=true) {%>
	<jsp:include page="/functions/loggedNav.jsp"></jsp:include>
	<%}
	else if(adminlog==true) {%>
	<jsp:include page="/functions/adminNav.jsp"></jsp:include>
	<%} 
	else if(operatorlog==true) {%>
	<jsp:include page="/functions/operatorNav.jsp"></jsp:include>
	<%} 
	else if(userlog!=true){ %>
	<jsp:include page="/functions/userNav.jsp"></jsp:include>
	<%}
	%>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<div align="center">
		
		
		<p class="ok" id="okUpdate" style="color:green"> <%= ok %> </p>
		<p class="error" id="errorUpdate" style="color:red"> <%= error %> </p>
		
		<table id="containerForms">
		<tr>
			<th>
				<table id="userTable">
				<legend id="legendUser">
					<h3><i>DATI ACCOUNT</i></h3>
				</legend>
				<tr>
					<th>Codice Fiscale</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getCfUtente()%></td>
				</tr>
				<tr>
					<th>Nome</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getNome()%></td>
				</tr>
				<tr>
					<th>Cognome</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getCognome()%></td>
				</tr>
				<tr>
					<th>Email</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getEmail()%></td>
				</tr>
				<tr>
					<th>Città</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getCitta()%></td>
				</tr>
				<tr>
					<th>Via</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getVia()%>
				</tr>
				<tr>
					<th>Numero Civico</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getNCivico()%></td>
				</tr>
				<tr>
					<th>CAP</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getCap()%></td>
				</tr>
				<tr>
					<th>Rank</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><%=user.getTipo()%></td>
				</tr>
			</table>
			</th>
		
			<th style="width: 10%">&nbsp;</th>
			
			<th>
				<form id="formUpdate" action="UserOperations" method="post" onsubmit="return checkUpdateForm()">
					<fieldset id="fieldUser">
						<legend id="legendUser">
							<h3>
								<i>MODIFICA DATI ANAGRAFICI</i>
							</h3>
						</legend>
						<table>
							<input type="hidden" name="action" value="update">
							<tr>
								<label for="citta"><b>Città</b></label>
								<br>
								<input id="cit" type="text" name="citta" maxlength="30" required>
								<br>
							</tr>
							<pre></pre>
							<tr>
								<label for="via"><b>Via</b></label>
								<br>
								<input id="via" type="text" name="via" maxlenght="40" required>
								<br>
							</tr>
							<pre></pre>
							<tr>
								<label for="ncivico"><b>Numero Civico</b></label>
								<br>
								<input id="civico" name="ncivico" type="number" maxlength="5" required>
								<br>
							</tr>
							<pre></pre>
							<tr>
								<label for="cap"><b>CAP</b></label>
								<br>
								<input id="num" name="cap" type="number" maxlength="5" required>
								<br>
							</tr>
							<tr>
								<br>
								<input id="conferma" type="submit" name="conferma"
									value="Modifica">
								<input id="resetta" type="reset" name="reset" value="Azzera">
							</tr>
						</table>
					</fieldset>
				</form>
			</th>

			<th style="width: 10%">&nbsp;</th>

			<th>
				<form id="formUpdate" action="UserOperations" method="post" onsubmit="return checkUpdateForm()">
					<fieldset id="fieldUser">
						<legend id="legendUser">
							<h3>
								<i>MODIFICA PASSWORD</i>
							</h3>
						</legend>
						<table>
							<input type="hidden" name="action" value="updatePassword">
							<tr>
								<label for="OldPassword"><b>Password vecchia</b></label>
								<br>
								<input id="oldPass" type="password" name="oldPass"
									pattern=".{8,20}" maxlenght="20" required>
								<br>
							</tr>
							<pre></pre>
							<tr>
								<label for="NewPassword"><b>Password nuova</b></label>
								<br>
								<input id="newPass" type="password" name="newPass"
									pattern=".{8,20}" maxlenght="20" required>
								<br>
							</tr>
							<pre></pre>
							<tr>
								<label for="RePassword"><b>Reinserisci password</b></label>
								<br>
								<input id="rePass" type="password" name="rePass" 
									maxlenght="20" pattern=".{8,20}" required>
								<br>
							</tr>
							<br>
							<input id="conferma" type="submit" name="conferma"
								value="Modifica">
							<input id="resetta" type="reset" name="reset" value="Azzera">
							</tr>
						</table>
					</fieldset>
				</form>
			</th>
		</tr>
	</table>
	</div>
	<br>
	<br>

</body>

<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
<div class="scroll-to-top d-lg-none position-fixed ">
	<a class="js-scroll-trigger d-block text-center text-white rounded"
		href="#page-top"> <i class="fa fa-chevron-up"></i>
	</a>
</div>

<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Plugin JavaScript -->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="vendor/magnific-popup/jquery.magnific-popup.min.js"></script>
<!-- Custom scripts for this template -->
<script src="js/freelancer.min.js"></script>
<script src="js/myaccount.js"></script>
</html>