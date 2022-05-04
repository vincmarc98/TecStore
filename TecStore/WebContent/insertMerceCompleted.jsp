<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, it.unisa.model.*"%>

<%
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	Boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
	Boolean operatorlog = (Boolean) request.getSession().getAttribute("operatorlog");

	if (userlog == null) {
		userlog = false;
		adminlog = false;
	}

	if (adminlog == null) {
		adminlog = false;
	}

	if (adminlog == false) {
		response.sendRedirect("index.jsp");
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
<title>Operazione completata!</title>
</head>
<body>

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

	<!-- PopUp Login -->
	<jsp:include page="/functions/login.jsp"></jsp:include>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div align="center">
		<h1>Operazione completata con successo!</h1>
		<h2>
			Hai appena inserito l'oggetto.
		</h2>
		<br>
		<h1>
			Clicca <a style="color: #18BC9C" href="MerceOpAdmin?action=showlist">qui</a> per tornare alla gestione dei prodotti.
		</h1>
	</div>
</body>
</html>