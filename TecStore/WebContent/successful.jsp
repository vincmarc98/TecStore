<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	if (userlog == null) {
		userlog = false;
	}

	if (userlog == true) {
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
	<jsp:include page="/functions/userNoIndexNav.jsp"></jsp:include>

	<!-- PopUp Login -->
	<jsp:include page="/functions/login.jsp"></jsp:include>
	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<div align="center"><h1>Operazione completata con successo!</h1><h3>Ora puoi effettuare il Log in</h3><br><h1>Clicca <a style="color: #18BC9C" href="index.jsp">qui</a> per tornare alla homepage.</h1></div>
</body>
</html>