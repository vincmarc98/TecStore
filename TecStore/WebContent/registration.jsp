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
	
	String error = (String) session.getAttribute("error");
	if(error == null)
		error = "";
	else
		session.removeAttribute("error");
	
%>


<!DOCTYPE html>
<html>
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
<body id="page-top">

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
	<div align="center">
		<h1>REGISTRAZIONE:</h1>
		<p class="error" id="errorSign" style="color:red"> <%= error %> </p>
		<br>
		
		<form name="signForm" action="UserOperations" method="post" onsubmit="return checkSignForm()">
		
		<table>
		
		<tr>
	
		<th>
			<input type="hidden" name="action" value="insert" id="action">
			<fieldset class="datianag">
				<legend>
					<h3>
						<i>DATI ANAGRAFICI</i>
					</h3>
				</legend>
				<label for="codicefiscale">Codice Fiscale</label><br> 
				<input type="text" name="codicefiscale" id="codicefiscale" maxlength="16" required> <br> <br> 
				
				<label for="nome">Nome</label><br> 
				<input type="text" name="nome" id="nome" required> <br> <br>
				
				<label for="cognome">Cognome</label><br> 
				<input type="text" name="cognome" id="cognome" required> <br> <br>
			</fieldset>
			<br>
		</th>
		
		<th>
		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		</th>
		<th>
		<fieldset class="datianag">
			<legend>
				<h3>
					<i>DATI LOG-IN</i>
				</h3>
			</legend>
			<label for="email">E-mail</label><br> 
			<input type="email" name="email" id="email" required> <br> <br>
			
			<label for="password">Password</label><br> 
			<input type="password" name="password" id="password" required> <br> <br>
		</fieldset>
		<br>
		</th>
		<th>
		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		</th>
		<th>
		<fieldset class="datianag">
			<legend>
				<h3>
					<i>DATI SPEDIZIONE</i>
				</h3>
			</legend>
			<label for="citta">Città</label><br> 
			<input type="text" name="citta" maxlength="35" id="citta" required> <br> <br> 
			
			<label for="via">Via</label><br> 
			<input type="text" name="via" id="via" required> <br> <br> 
			
			<label for="ncivico">Numero civico</label><br> 
			<input type="number" name="ncivico" id="ncivico" required> <br> <br> 
			
			<label for="cap">CAP</label><br> 
			<input type="number" name="cap" id="cap" required>
		</fieldset>
		</th>
		</tr>
		</table>
		<br>
		<br>
			<input class="final" id="conferma" type="submit" name="submit" value="Conferma"> 
			<input id="resetta" class="final" type="reset" name="reset" value="Reset"> 
		</form>
		</div>
	
	
		<br>

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
<script src="js/registration.js"></script>

</body>
</html>