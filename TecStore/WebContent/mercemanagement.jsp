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
			<i class="fas fa-angle-double-right"></i> Gestione Merce
		</h2>
	</div>
	<br>
	<h5>
		&nbsp;&nbsp;&nbsp;Benvenuto amministratore "<%=user.getNome() + " " + user.getCognome()%>"  
		nella Gestione Merce! <br>&nbsp;&nbsp;&nbsp;Qui potrai: <br>
		<br>
		<ul>
			<li>Visualizzare tutti i prodotti nel sistema</li>
			<li>Filtrare i prodotti per Codice Merce</li>
			<li>Modificare o cancellare un prodotto cliccando sull'apposita
				voce</li>
			<li>Aggiungere un nuovo prodotto cliccando sul bottone <i
				class="fas fa-plus-circle"></i> sottostante.
			</li>
		</ul>
	</h5>

	<hr>

	<div align="center">
		<table>
			<tr>
				<td>
					<form action="MerceOpAdmin" method="get">
						<input type="hidden" name="action" value="showlistbycodice" id="action">
						<label for="campoServer"><h6>Cerca prodotto:</h6></label> <br> 
						<input id="markBar" type="text" name="codicemerce" maxlength="10" id="codice" placeholder="Codice Merce" required>
						<input type="submit" value="Conferma">
					</form>
				</td>
				
				<td style="width: 10%">&nbsp;</td>
				
				<td>	
					<form action="MerceOpAdmin" method="get">
						<input type="hidden" name="action" value="showlistbytitolo" id="action"> 
						<label for="campoServer"><h6>Cerca prodotto:</h6></label> <br> 
						<input id="markBar" type="text" name="titolo" maxlength="30" id="titolo" placeholder="Titolo Prodotto" required> 
						<input type="submit" value="Conferma">
					</form>
				</td>

				<td style="width: 20%">&nbsp;</td>

				<td>
					<div align ="center">
						<h5>Aggiungi</h5>
						<a href="insertMerce.jsp"><h1>
							<i class="fas fa-plus-circle"></i>
						</h1></a>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<br>
	
	<h2 style="text-align: center">
		<a href="MerceOpAdmin?action=showlist">LISTA PRODOTTI</a>
	</h2>
	<br>
	<div align="center">
		<div style="overflow: auto" class="table-responsive-xl">
			<table style="width: 86%" id="ModCancMerceTableId">

				<%
					if (collection != null && collection.size() != 0) {
				%>
				<tr>
					<th style="width: 15%"><h6>Codice</h6></th>
					<th style="width: 20%"><h6>Titolo</h6></th>
					<th style="width: 15%"><h6>Categoria</h6></th>
					<th style="width: 20%"><h6>Descrizione</h6></th>
					<th style="width: 10%"><h6>Costo</h6></th>
					<th style="width: 10%"><h6>Opzioni</h6></th>
				</tr>
				<%
					Iterator<?> it = collection.iterator();

						while (it.hasNext()) {
							MerceBean merce = (MerceBean) it.next();
				%>


				<tr>
					<td style="width: 15%"><%=merce.getCodiceMerce()%></td>
					<td style="width: 20%"><%=merce.getTitolo()%></td>
					<td style="width: 15%"><%=merce.getCategoria()%></td>
					<td style="width: 20%"><%=merce.getDescrizione()%></td>
					<td style="width: 10%"><%=merce.getCosto()%></td>
					<td style="width: 10%"><button
							onclick="window.location.href='MerceOpAdmin?action=redirectForUpdate&CodiceMerce=<%=merce.getCodiceMerce()%>'"
							id="conferma" class="conferma">
							<i class="fas fa-screwdriver"></i><br>Modifica
						</button></td>
				
					<td><button
							onclick="openForm('<%=merce.getCodiceMerce() %>')" id="resetta"
							class="final">
							<i class="fas fa-trash-alt"></i><br> Elimina
						</button></td>

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
					<h1 class="noobject" style="text-align: center">Nessun Oggetto Presente</h1>
				<% 		
					}
				%>

			</table>
		</div>
	</div>

	<br>


	<div class="form-popup" id="myForm">
		<form action="MerceOpAdmin" method="get" class="form-container">
			<input type="hidden" name="action" value="delete" id="action">
			<input type="hidden" id="codiceMerce" name="codiceMerce" value="">
			<h3>Conferma rimozione prodotto</h3>
			<button type="submit" id="conferma" class="btn">Conferma</button>
			<button type="button" class="btn" id="cancel"
				onclick="document.getElementById('myForm').style.display='none'">Annulla</button>
		</form>
	</div>


	<%
		if (numberPage > 1) {
	%>
	<div id="previousPag" class="paging">
		<a href="MerceOpAdmin?action=showlist&numberPage=<%=numberPage - 1%>">Pagina
			Precedente</a>
	</div>
	<%
		}
	%>
	
	<%
		if (numberPage == 1) {
	%>
		<div id="nextPage" class="paging">
			<a href="MerceOpAdmin?action=showlist&numberPage=<%=numberPage + 1%>">Pagina Successiva</a>
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
		document.getElementById("codiceMerce").value=obj;
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
<script src="js/mercemanagement.js"></script>

</html>