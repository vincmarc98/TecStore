<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="it.unisa.model.*"%>

<%
	UserBean user = (UserBean) request.getSession().getAttribute("user");
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	Boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
	Boolean operatorlog = (Boolean) request.getSession().getAttribute("operatorlog");
	CartBean cart = (CartBean) request.getSession().getAttribute("cart");

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

	if (cart == null || cart.getCart().isEmpty()) {
		response.sendRedirect("cart.jsp");
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

	<div align="center">
		<h2>
			<i class="far fa-money-bill-alt"></i> Checkout
		</h2>
		<br>
		<h4>
			Ci siamo quasi! Compila attentamente tutti i campi e clicca su
			conferma.<br> Nota: Il prodotto verrà spedito
			all'indirizzo di residenza associato al profilo!<br>Se desideri
			un altro indirizzo, seleziona l'apposita voce.
		</h4>
	</div>

	<hr>
	<br>

	<div align="center">
		<form action="OrdersOperations" method="get" id="newOrder"
			style="width: 30%">
			<input type="hidden" name="action" value="insert" id="action">
			<fieldset class="datipagam">
				<legend>
					<div align="center">
						<h3>Dati del pagamento</h3>
					</div>
				</legend>
				<label for="mezzo">Tipo di spedizione</label><br> <select
					name="mezzo">
					<option value="Corriere" selected>Corriere</option>
					<option value="Ritiro in sede">Ritiro in sede</option>
				</select> <br> <br> <label for="metodopagamento">Metodo di
					pagamento</label><br> <select name="metodoDiPagamento">
					<option value="Carta" selected>Carta</option>
				</select> <br> <br> <input type="radio" name="radiochoice" checked
					value="uguale" onclick="function1()"> L'indirizzo di
				spedizione è l'indirizzo di residenza<br> <input type="radio"
					name="radiochoice" value="diverso" onclick="function2()">
				L'indirizzo di spedizione è diverso dall'indirizzo di residenza <span
					class="hiddenContent" style="display: none"> <br> <br>
					<label for="citta">Città</label><br> <input type="text"
					name="citta" pattern="[A-Za-z.]{2,}" title="Solo caratteri"
					maxlength="35" id="citta"> <br> <br> <label
					for="via">Via</label><br> <input type="text" name="via"
					pattern="[A-Z a-z.]{2,}" title="Solo caratteri" maxlength="45"
					id="via"> <br> <br> <label for="ncivico">Numero
						civico</label><br> <input type="number" name="ncivico" min="1"
					max="9999" id="ncivico" > <br> <br> <label
					for="cap">CAP</label><br> <input type="number" name="cap"
					min="10000" max="99999" title="5 cifre" id="cap" >
					<hr>
				</span> <br> <br> <label for="numcarta">Numero Carta</label><br>
				<input type="text" name="numCard" pattern="[0-9]{13,16}" maxlength="16"
					id="numCard" required> <br> <br> <label
					for="intestatario">Intestatario Carta</label><br> <input
					type="text" name="intestatarioCard" pattern="[A-Z a-z]{2,}"
					title="40 caratteri max" maxlength="40" id="intestatariocarta"
					required> <br> <br> <label for="cvvcarta">CVV
					Carta</label><br> <input type="text" name="cvv" pattern="[0-9]{3,3}"
					maxlength="3" id="cvvCard" required> <br>
			</fieldset>
			<br>
			<table>
				<tr>
					<th>
						<button onclick="window.location.href='cart.jsp'" id="resetta"
							class="final">Annulla</button>
					</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th><input id="conferma" type="submit" name="submit"
						value="Conferma"></th>
				</tr>
			</table>
		</form>
	</div>

	<br>
	<br>
	<br>

</body>



<script>
	function function1() {
		$("span.hiddenContent").delay(50).hide("slow");
	};
</script>

<script>
	function function2() {
		$("span.hiddenContent").delay(50).show("slow");
	};
</script>

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
</html>