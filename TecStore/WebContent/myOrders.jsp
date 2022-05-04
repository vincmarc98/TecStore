<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, it.unisa.model.*"%>

<%
	UserBean user = (UserBean) request.getSession().getAttribute("user");
	Collection<?> collectionOrders = (Collection<?>) request.getAttribute("allOrdersByUser");
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	Boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
	Boolean operatorlog = (Boolean) request.getSession().getAttribute("operatorlog");
	if (userlog == null) {
		userlog = false;
	}

	if (adminlog == null) {
		adminlog = false;
	}

	if (operatorlog == null) {
		operatorlog = false;
	}

	if (userlog == false || adminlog == true || operatorlog == true || collectionOrders == null) {
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
<title>TecHouse</title>
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
			<i class="fas fa-truck"></i> I miei ordini
		</h2>
		<br>
		<h5>
			Benvenuto nei tuoi ordini! Qui potrai visualizzare tutti gli ordini
			confermati.<br>Se lo stato dell'ordine è in<i>"Processing"</i> ,
			sei ancora in tempo per annullare l'acquisto!<br>Hai bisogno di
			assistenza per un ordine? Vai alla <a href="supportTicket.jsp">sezione
				Supporto</a>.
		</h5>
	</div>

	<hr>

	<div align="center">
		<table id="orderTable" style="width: 88%">
			<tr>
				<th style="width: 10%"><div align="center">Codice Ordine</div></th>
				<th style="width: 10%"><div align="center">Data Ordine</div></th>
				<th style="width: 10%"><div align="center">Metodo di spedizione</div></th>
				<th><div align="center">Numero Merci</div></th>
				<th style="width: 10%"><div align="center">Totale</div></th>
				<th><div align="center">Metodo di Pagamento</div></th>
				<th style="width: 20%"><div align="center">Numero di carta</div></th>
				<th style="width: 20%"><div align="center">Indirizzo di spedizione</div></th>
				<th><div align="center">Stato</div></th>
			</tr>
			<%
				if (collectionOrders != null && collectionOrders.size() != 0) {

					Iterator<?> it = collectionOrders.iterator();

					while (it.hasNext()) {
						OrderBean order = (OrderBean) it.next();
			%>

			<tr>
				<td><div align="center"><%=order.getCodiceOrdine()%></div></td>
				<td><div align="center"><%=order.getDataOrdine()%></div></td>
				<td><div align="center"><%=order.getMezzo()%></div></td>
				<td><div align="center"><%=order.getnMerci()%></div></td>
				<td><div align="center"><%=order.getTotale()%></div></td>
				<td><div align="center"><%=order.getMetodoDiPagamento()%></div></td>
				<td><div align="center"><%=order.getNumCard()%></div></td>
				<td><div align="center"><%=order.getVia() + ", "%><%=order.getCivico()%><br><%=order.getCitta() + ", "%><%=order.getCap()%></div></td>
				<td><div align="center"><%=order.getStato()%></div></td>
				<%
					if (order.getStato().equalsIgnoreCase("Processing")) {
				%>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><div align="center">
						<i style="color: red; font-size: 20px; cursor: pointer"
							class="fas fa-times" onclick="window.location.href='OrdersOperations?action=cancelByID&id=<%=order.getCodiceOrdine()%>'"></i>
					</div></td>
				<%
					}
				%>
			</tr>
			
			<tr>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
				<th>&nbsp;</th>
			</tr>

			<%
				}
				}
			%>
		</table>
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
</html>