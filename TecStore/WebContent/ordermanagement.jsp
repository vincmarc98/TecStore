<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*, it.unisa.model.* "
	session="true"%>
	
<%
	UserBean user = (UserBean) request.getSession().getAttribute("user");
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	Boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
	Boolean operatorlog = (Boolean) request.getSession().getAttribute("operatorlog");
	Collection<?> collection = (Collection<?>) request.getAttribute("collection");
	int numberPage;
	String numberPageString = (String) request.getParameter("numberPage");

	if (userlog == null) {
		userlog = false;
		adminlog = false;
		operatorlog = false;
	}

	if (user == null) {
		user = new UserBean();
		response.sendRedirect("index.jsp");
	}

	if (adminlog == null) {
		adminlog = false;
	}
	
	if (operatorlog == null) {
		operatorlog = false;
	}


	if (numberPageString == null) {
		numberPage = 1;
	} else {
		numberPage = Integer.parseInt(numberPageString);
	}

	if (numberPage <= 0) {
		numberPage = 1;
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
			<i class="fas fa-angle-double-right"></i> Gestione Ordine
		</h2>
	</div>
	<br>
	<h5>
		&nbsp;&nbsp;&nbsp;Benvenuto operatore "<%=user.getNome() + " " + user.getCognome()%>"  
		nella Gestione Ordine! <br>&nbsp;&nbsp;&nbsp;Qui potrai: <br>
		<br>
		<ul>
			<li>Visualizzare tutti gli ordini nel sistema</li>
			<li>Filtrare gli ordini per CF del Cliente o per codice ordine</li>
			<li>Modificare lo stato di un'ordine</li>
		</ul>
	</h5>
	
	<hr>
	
	<div align="center">
		<table>
			<tr>
				<td>
					<form action="OrdineOpAdmin" method="get">
						<input type="hidden" name="action" value="showlistbycodiceordine"
							id="action"> <label for="campoServer"><h6>Cerca ordine per Codice Ordine:</h6></label> <br> <input id="markBar" type="text"
							name="codiceordine" maxlength="35" id="codice"
							placeholder="Codice Ordine" required> <input type="submit" value="Conferma">
					</form>
				</td>

				<td style="width: 40%">&nbsp;</td>

				<td>
					<form action="OrdineOpAdmin" method="get">
						<input type="hidden" name="action" value="showlistbycodicefiscale"
							id="action"> <label for="campoServer"><h6>Cerca ordine per CF del Cliente:</h6></label> <br> <input id="markBar" type="text"
							name="codicefiscale" maxlength="35" id="codice"
							placeholder="Codice Fiscale" required> <input type="submit"	value="Conferma">
					</form>
				</td>
			</tr>
		</table>
	</div>
	
	<br>
	
	<h2 style="text-align: center">
		<a href="OrdineOpAdmin?action=showlist">LISTA ORDINI</a>
	</h2>
	<br>
	
	<div align="center">
		<div style="overflow: auto" class="table-responsive-xl">
			<table style="width: 86%" id="ModCancOrdineTableId">  

				<%
					if (collection != null && collection.size() != 0) {
				%>
				<tr>
					<th style="width: 10%"><h6>Cod.Ordine</h6></th>
					<th style="width: 10%"><h6>Data Ordine</h6></th>
					<th style="width: 15%"><h6>Metodo Spedizione</h6></th>
					<th style="width: 10%"><h6>Totale</h6></th>
					<th style="width: 10%"><h6>Metodo di Pagamento</h6></th>
					<th style="width: 15%"><h6>C.F. Cliente</h6></th>
					<th style="width: 20%"><h6>Indirizzo di Spedizione</h6></th>
					<th style="width: 15%"><h6>Stato</h6></th>
					<th style="width: 15%"><h6>Opzioni</h6></th>
				</tr>
				<%
					Iterator<?> it = collection.iterator();

						while (it.hasNext()) {
							OrderBean ordine = (OrderBean) it.next();
				%>


				<tr>
					<td style="width: 10%"><%=ordine.getCodiceOrdine()%></td>
					<td style="width: 10%"><%=ordine.getDataOrdine()%></td>
					<td style="width: 15%"><%=ordine.getMezzo()%></td>
					<td style="width: 10%"><%=ordine.getTotale()%></td>
					<td style="width: 10%"><%=ordine.getMetodoDiPagamento()%></td>
					<td style="width: 15%"><%=ordine.getCfCliente()%></td>
					<td style="width: 20%"><%=ordine.getVia() + " " + ordine.getCivico() + "," + ordine.getCitta() + " " + ordine.getCap() %></td>
					<td style="width: 15%"><%=ordine.getStato()%></td>
					<td style="width: 15%">
						<%if(ordine.getStato().equalsIgnoreCase("Processing")){ %>
						<button onclick="openForm('<%=ordine.getCodiceOrdine()%>')"
							id="conferma" class="conferma">
							<i class="fas fa-angle-double-up"></i><br>Stato
						</button> <%} %>
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>

				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
					<%
						}
					%>

				<%
					} else {
				%>		
					<h1 class="noobject" style="text-align: center">Nessun Ordine Presente</h1>
				<% 		
					}
				%>

			</table>
		</div>
	</div>

	<br>

	<div class="form-popup" id="myForm">
		<form action="OrdineOpAdmin" method="get" class="form-container">
			<input type="hidden" name="action" value="update" id="action">
			<input type="hidden" id="codiceordine" name="codiceordine" value="">
			<h2>Seleziona stato ordine</h2>
			<label for="state">Seleziona il nuovo stato: </label> 
			<select name="state">
				<option value="Processing" selected>Processing</option>
				<option value="Shipped">Shipped</option>
			</select>

			<button type="submit" id="conferma" class="btn">Conferma</button>
			<button type="button" class="btn" id="cancel" onclick="window.location.href='OrdineOpAdmin?action=showlist'">Annulla</button>
		</form>
	</div>

	<%
		if (numberPage > 1) {
	%>
	<div id="previousPag" class="paging">
		<a href="OrdineOpAdmin?action=showlist&numberPage=<%=numberPage - 1%>">Pagina
			Precedente</a>
	</div>
	<%
		}
	%>
	
	<%
		if (numberPage == 1) {
	%>
		<div id="nextPage" class="paging">
			<a href="OrdineOpAdmin?action=showlist&numberPage=<%=numberPage + 1%>">Pagina Successiva</a>
		</div>
	<%
		}
	%>
	
	<br>
	<br>
	<br>
	<br>
	<br>

</body>

<script>
	function openForm(obj) {
		document.getElementById("myForm").style.display = "block";
		document.getElementById("codiceordine").value = obj;
	}
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