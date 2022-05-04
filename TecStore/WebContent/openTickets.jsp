<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*, it.unisa.model.* "
	session="true"%>

<%
	UserBean user = (UserBean) request.getSession().getAttribute("user");
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	Boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
	Boolean operatorlog = (Boolean) request.getSession().getAttribute("operatorlog");
	Collection<?> collection = (Collection<?>) request.getAttribute("openTicketsByUser");
	int numberPage;
	String numberPageString = (String) request.getParameter("numberPage");

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

	if (numberPageString == null) {
		numberPage = 1;
	} else {
		numberPage = Integer.parseInt(numberPageString);
	}

	if (numberPage <= 0) {
		numberPage = 1;
	}

	if (collection == null) {
		response.sendRedirect("TicketOperations?action=searchOpenTicketsByUser");
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
			<i class="fas fa-question"></i> Ticket Aperti
		</h2>
		<br>
		<h5>
			Benvenuto nei tuoi ticket aperti! Qui potrai visualizzare tutti i
			ticket ancora aperti, con le relative informazioni.<br>
		</h5>
	</div>

	<hr>


	<div align="center">
		<table id="ticketTable" style="width: 88%">

			<tr>
				<th><center>Codice Ticket</center></th>
				<th><center>Titolo</center></th>
				<th><center>Codice Ordine</center></th>
				<th><center>Stato</center></th>
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
				if (collection != null && collection.size() != 0) {

					Iterator<?> it = collection.iterator();

					while (it.hasNext()) {
						TicketBean ticket = (TicketBean) it.next();
			%>

			<tr style="margin-bottom: 2%">
				<td><div align="center"><%=ticket.getCodiceOrdine()%></div></td>
				<td><div align="center"><%=ticket.getTitolo()%></div></td>
				<td><div align="center"><%=ticket.getCodiceOrdine()%></div></td>
				<td><div align="center"><%=ticket.getStato()%></div></td>
				
				
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
				%>
			</tr>


			<%
				}
			%>

			<div id="previousPag" class="pagingAllOrders">
				<%
					if (numberPage > 1) {
				%>
				<a
					href="TicketOperations?action=searchOpenTicketsByUser&numberPage=<%=numberPage - 1%>">Pagina
					Precedente</a>
			</div>
			<%
				}
			%>
			 
			<%
				if (collection.size() == 6) {
			%>
			<div id="nextPage" class="pagingAllOrders">
				<a
					href="TicketOperations?action=searchOpenTicketsByUser&numberPage=<%=numberPage + 1%>">Pagina
					Successiva</a>
			</div>
			<%
				}
				if (collection.size() == 0 && numberPage <= 1) {
			%>
			<h1 class="noobject" style="text-align: center">Nessun Ticket Presente</h1>

			<%
				} else if (collection.size() == 0 && numberPage > 1) {
			%>
			<h1 class="noobject" style="text-align: center">Nessun Ticket Presente</h1>
			<a id="getback"
				href="TicketOperations?action=searchOpenTicketsByUser&numberPage=<%=numberPage - 1%>">
				<--- Torna indietro</a>
			<%
				}
			%>
		</table>

		<br> <br>
		<button style="width: 13%; cursor:pointer" id="cancel"
			onclick="window.location.href='supportTicket.jsp'">Torna indietro</button>
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