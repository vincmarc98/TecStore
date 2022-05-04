<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="it.unisa.model.*, java.util.*" session="true"%>

<%
	CartBean cart = (CartBean) request.getSession().getAttribute("cart");
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
	<br>

	<div align="center">
		<h2>
			<i class="fas fa-shopping-cart"></i> Il tuo carrello
		</h2>
		<br>
		<h4>
			Benvenuto nel tuo carrello! Qui potrai visualizzare tutti i prodotti
			che hai inserito.<br>Vuoi rimuovere un prodotto dal carrello?
			Premi sull'apposita voce!<br>Quando sei pronto, procedi con il
			pagamento per finalizzare l'ordine.
		</h4>
	</div>

	<hr>
	<br>


	<div align="center">
		<table id="cartTable">

			<%
				double totale = 0;
				if (cart != null && cart.getCart().size() != 0) { 
					
			%>

			<tr>
				<th><h3>TITOLO</h3></th>
				<th><h3>DESCRIZIONE</h3></th>
				<th><h3>COSTO</h3></th>
				<th><h3>OPZIONI</h3></th>
			</tr>
			<%

					Iterator<?> it = cart.getCart().iterator();

					while (it.hasNext()) {
						MerceBean merce = (MerceBean) it.next();
						int codice = merce.getCodiceMerce();
			%>


			<tr>
				<td style="width: 150px"><%=merce.getTitolo()%></td>
				<td style="width: 200px"><%=merce.getDescrizione()%></td>
				<td style="width: 150px"><%=merce.getCosto()%></td>
				<td style="width: 150px"><button
						onclick="window.location.href='MerceOpUser?action=deleteFromCart&codiceMerce=<%=codice%>'"
						id="resetta" class="final">
						<i class="fas fa-trash-alt"></i> Elimina
					</button></td>
			</tr>

			<%
				totale += merce.getCosto();
					}
				} else {
			%>
		</table>
	</div>
	
	<div align="center">
		<h2 id="noProducts">
			Non ci sono prodotti nel carrello!
		</h2>

		<h3>
			<a href="shop.jsp">Comincia lo shopping!</a>
		</h3>
	</div>
	<%
		}
	%>

	<div id="totaleCarrello">
		<%
			if (cart != null && cart.getCart().size() != 0) {
		%>
		<h3 id=total>
			Totale: €
			<%=totale%></h3>
		<br>
	
		<table>
			<br>
			<br>
			<tr>
				<th>
					<button
						onclick="window.location.href='MerceOpUser?action=emptyCart'"
						id="resetta" class="final">
						<i class="fas fa-shopping-cart"></i><br>Svuota
					</button>
				</th>

				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th><button onclick="window.location.href='checkout.jsp'"
						id="conferma" class="conferma">
						<i class="fas fa-credit-card"></i><br>Checkout
					</button></th>
			</tr>
		
		</table>

		<%
			}
		%>
	</div>
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
</html>