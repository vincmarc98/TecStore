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
	
	String error = (String) session.getAttribute("error");
	if(error == null)
		error = "";
	else {
		session.removeAttribute("error");
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
<link rel="stylesheet" href="css/shop.css">


<title>TecStore</title>
</head>
<body id="page-top">

	<!-- Navigation -->
	<%
		if (userlog == true && adminlog != true && operatorlog != true) {
	%>
	<jsp:include page="/functions/loggedNav.jsp"></jsp:include>
	<%
		} else if (adminlog == true) {
	%>
	<jsp:include page="/functions/adminNav.jsp"></jsp:include>
	<%
		} else if (operatorlog == true) {
	%>
	<jsp:include page="/functions/operatorNav.jsp"></jsp:include>
	<%
		} else if (userlog != true) {
	%>
	<jsp:include page="/functions/userNoIndexNav.jsp"></jsp:include>
	<%
		}
	%>

	<!-- PopUp Login -->
	<jsp:include page="/functions/login.jsp"></jsp:include>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div align="center">
		<h2>
			<i class="fas fa-plus-circle"></i> Inserisci prodotto
		</h2>
	</div>

	<br>

	<!-- start form -->
	<div align="center">
		<h5>
			Compila attentamente tutti i campi e clicca su conferma.
		</h5>
	</div>
	<hr>
	<form id="formInsert" action="MerceOpAdmin" method="post" enctype="multipart/form-data" onsubmit="return checkInsertForm()">
		<input type="hidden" name="action" value="insert" id="action">

		<div class="cell">

			<div class="interno">

				<div align="center">
					<p class="error" id="errorInsert" style="color:red"> <%= error %> </p>
					
					<label for="prodotto"><b>Prodotto</b></label> <br> 
					<input type="text" name="prodotto" maxlength="20" id="prodotto" required> <br> <br> 
						   
					<label for="categoria"><b>Categoria</b></label> <br> 
					<select name="categoria">
						<option value="Cellulare" selected>Smartphone</option>
		  				<option value="PC">PC e Laptop</option>
						<option value="Fotocamera">Fotocamera</option>
					</select> <br> <br> 
					
					<label for="descrizione"><b>Descrizione</b></label> <br>
						<textarea rows="8" style="width: 25%" required name="descrizione" maxlength="150" id="descrizione"></textarea><br><br>
							
					<label for="costo"><b>Costo</b></label> <br> 
						<input style="width:10%" type="number" name="costo" 
						title="Solo numeri" id="costo" step=".01" required> <br> <br> 
						
					<label for="foto"><b>Foto</b></label> <br>
						<input type="file" name="foto" accept="image/*"> <br> <br>
					<br> 

					<table>
						<tr>
							<th><input type="submit" name="submit" value="Conferma"
								id="finish"></th>
							<th>&nbsp;</th>
							<th><input type="button" onclick="location.href='MerceOpAdmin?action=showlist'"
								value="Annulla" id="cancel"></th>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>

	<br>
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
<script src="js/insertmerce.js"></script>
</html>