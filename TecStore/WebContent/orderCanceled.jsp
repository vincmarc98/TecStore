<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="it.unisa.model.*"%>

<%
	UserBean user = (UserBean) request.getSession().getAttribute("user");
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	Boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
	Boolean operatorlog = (Boolean) request.getSession().getAttribute("operatorlog");

	if (userlog == null) {
		userlog = false;
		adminlog = false;
		operatorlog = false;
	}

	if (adminlog == null) {
		adminlog = false;
	}

	if (operatorlog == null) {
		operatorlog = false;
	}
	
	if (user == null || userlog == false) {
		user = new UserBean();
		request.getSession().setAttribute("refresh", true);
		response.sendRedirect("index.jsp");
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
	
		<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div align="center">
		<h1>Operazione completata con successo!</h1>
		<h3>
			Il tuo ordine è stato annullato.
		</h3>
		<br>
		<h1>
			Clicca <a style="color: #18BC9C" href="OrdersOperations?action=searchByUser">qui</a> per tornare
			ai tuoi ordini.
		</h1>
	</div>

</body>
</html>