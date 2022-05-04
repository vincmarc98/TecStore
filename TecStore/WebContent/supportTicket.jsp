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
	
	String error = (String) session.getAttribute("error");
	if(error == null)
		error = "";
	else
		session.removeAttribute("error");
	
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
	<jsp:include page="/functions/userNav.jsp"></jsp:include>
	<%
		}
	%>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div align="center">
		<h2>
			<i class="fas fa-question"></i><b> Sezione Supporto </b>
		</h2>
		<br>
		<h5>
			&nbsp;&nbsp;&nbsp;Benvenuto nella Sezione Supporto! <br>&nbsp;&nbsp;
			Hai problemi con un ordine? <b>Apri un nuovo ticket</b> compilando il
			form sottostante! <br>&nbsp;&nbsp;&nbsp;Puoi anche visualizzare
			la <b>lista dei tuoi ticket aperti o chiusi.</b>
		</h5>
	</div>
	<br>
	<hr>
	
	<div align="center">
		<h5>
			<a style="margin-right:10%" href="TicketOperations?action=searchOpenTicketsByUser"><i>Ticket Aperti</i></a> 
			<a href="TicketOperations?action=searchClosedTicketsByUser"><i>Ticket Chiusi</i></a>
		</h5>
	</div>

	<hr>
	<br>
	<!-- start form -->
	<div align="center">
		<h2>Apri un ticket</h2>
	</div>
	<div align="center">
		<h6>
			Compila attentamente tutti i campi e clicca su conferma.
		</h6>
	</div>

	<div align="center">
		
		<p class="error" id="errorTicket" style="color:red"> <%= error %> </p>
		
		<form name="ticketForm" action="TicketOperations" method="post" onsubmit="return checkTicketForm()">
			<input type="hidden" name="action" value="insert" id="action">

			<div class="cell">
				
				<label for="titolo">Codice Ordine</label> <br> 
				<input type="text" name="codice" placeholder="Inserisci codice ordine"
					maxlength="4" id="codice" required> <br> <br> 
					
				<label for="titolo">Titolo</label> <br> 
				<input style="width: 20%" type="text" name="titolo" placeholder="Inserisci titolo del ticket"
					maxlength="30" id="titolo" required> <br> <br>
				
				<label for="descrizione">Descrizione</label><br>
				<textarea style="width: 30%" rows="8" required name="descrizione"
					placeholder="Descrivi il tuo problema" 
					maxlength="150" id="descrizione"></textarea> <br> <br>
					
				<table>
					<tr>
						<th><input type="submit" name="submit" value="Conferma"
							id="finish"></th>
						<th>&nbsp;</th>
						<th><input type="button" onclick="location.href='index.jsp'"
							value="Annulla" id="cancel" style="cursor:pointer"></th>
					</tr>
				</table>
			</div>
		</form>
	</div>
	
	
	<table>
		<tr>
			<th>&nbsp;</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
		</tr>
	</table>

	
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
<script src="js/ticket.js"></script>

</html>