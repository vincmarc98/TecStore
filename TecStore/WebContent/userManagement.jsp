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

	if (adminlog == false) {
		response.sendRedirect("index.jsp");
	}

	if (collection == null) {
		response.sendRedirect("UserOpAdmin?action=showlist");
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
			<i class="fas fa-users"></i> Gestione Utente
		</h2>
	</div>
	<br>
	<h5>
		&nbsp;&nbsp;&nbsp;Benvenuto amministratore "<%=user.getNome() + " " + user.getCognome()%>"
		nella Gestione Utente! <br>&nbsp;&nbsp;&nbsp;Qui potrai: <br>
		<br>
	<ul>
		<li>Visualizzare tutti gli utenti registrati nel sistema</li>
		<li>Filtrare gli utenti per e-mail</li>
		<li>Cancellare dal Sistema o promuovere un utente cliccando
				sull'apposita voce</li>
	</ul>
	</h5>
	


	<hr>

	<table style="margin-left: 5%">
		<tr>
			<td><form action="UsersOpAdmin" method="get">
					<input type="hidden" name="action" value="showlistbycodice"
						id="action"> <label for="campoServer">Cerca
							Utente:</label> <br> <input id="markBar" type="text" name="email"
						maxlength="35" id="email" placeholder="User e-mail" required>
					<input type="submit" value="Conferma">
				</form></td>

			<td style="width: 65%">&nbsp;</td>
		</tr>
	</table>
	<h2 style="text-align: center">
		<a href="UsersOpAdmin?action=showlist">LISTA UTENTI</a>
	</h2>
	<br>
	<div align="center">
		<div style="overflow: auto" class="table-responsive-xl">
			<table style="width: 99%" id="ModCancUserTableId">

				<%
					if (collection != null && collection.size() != 0) {
				%>
				<tr>
					<th><div align="center">
							<h6>Codice Fiscale</h6>
						</div></th>
					<th><div align="center">
							<h6>Nome</h6>
						</div></th>
					<th><div align="center">
							<h6>Cognome</h6>
						</div></th>
					<th><div align="center">
							<h6>E-mail</h6>
						</div></th>
					<th><div align="center">
							<h6>Indirizzo di residenza</h6>
						</div></th>
					<th><div align="center">
							<h6>Ruolo</h6>
						</div></th>
					<th><div align="center">
							<h6>Opzioni</h6>
						</div></th>
				</tr>
				<%
					Iterator<?> it = collection.iterator();

						while (it.hasNext()) {
							UserBean utente = (UserBean) it.next();
				%>


				<tr>
					<td><div align="center"><%=utente.getCfUtente()%></div></td>
					<td><div align="center"><%=utente.getNome()%></div></td>
					<td><div align="center"><%=utente.getCognome()%></div></td>
					<td><div align="center"><%=utente.getEmail()%></div></td>
					<td><div align="center"><%=utente.getCitta()+", "%><br><%=utente.getVia() + ", "%><%=utente.getNCivico()%><br><%=utente.getCap()%></div></td>
					<td><div align="center">
							<%=utente.getTipo()%></div></td>
					<td style="padding-left: 1%"><div align="center">
						<%if(!(utente.getTipo().equalsIgnoreCase("amministratore"))){ %>
						<button onclick="openForm2('<%=utente.getCfUtente()%>')"
							id="conferma" class="conferma">
							<i class="fas fa-angle-double-up"></i><br>Rank
						</button></div> <%} %>
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>
						<%if(!(utente.getTipo().equalsIgnoreCase("amministratore"))){ %>
						<button onclick="openForm('<%=utente.getCfUtente()%>')"
							id="resetta" class="final">
							<i class="fas fa-trash-alt"></i><br> Elimina
						</button> <%} %>
					</td>

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

			</table>
		</div>
	</div>

	<br>

	<div class="form-popup" id="myForm2">
		<form action="UsersOpAdmin" method="get" class="form-container">
			<input type="hidden" name="action" value="update" id="action">
			<input type="hidden" id="cfUser2" name="cf" value="">
			<h3>Seleziona rank</h3>
			<label for="rank">Seleziona il nuovo ruolo: </label> 
			<select name="rank">
				<option value="Cliente" selected>Cliente</option>
				<option value="Operatore">Operatore</option>
			</select>

			<button type="submit" id="conferma" class="btn">Conferma</button>
			<button type="button" class="btn" id="cancel"
				onclick="window.location.href='UsersOpAdmin?action=showlist'">Annulla</button>
		</form>
	</div>


	<div class="form-popup" id="myForm">
		<form action="UsersOpAdmin" method="get" class="form-container">
			<input type="hidden" name="action" value="delete" id="action">
			<input type="hidden" id="cfUser" name="cf" value="">
			<h3>Conferma rimozione account utente</h3>
			<button type="submit" id="conferma" class="btn">Conferma</button>
			<button type="button" class="btn" id="cancel"
				onclick="document.getElementById('myForm').style.display='none'">Annulla</button>
		</form>                                  
	</div>
	
	
	<%
		if (collection.size() == 0) {
	%>
	<div id="nextPage" class="paging">
		<a href="UsersOpAdmin?action=showlist&numberPage=<%=numberPage + 1%>">Pagina
			Successiva</a>
	</div>
	<%
		}
	%>


	<%
		if (numberPage > 1) {
	%>
	<h1 class="noobject" style="text-align: center">Nessun Oggetto
		Presente</h1>
	<a id="getback"
		href="UsersOpAdmin?action=showlist">
		<i class="fas fa-angle-double-left"></i> Torna indietro
	</a>

	<%
		}
	%>
	<%
		if (collection.size() == 6) {
	%>
	<div id="nextPage" class="paging">
		<a href="UsersOpAdmin?action=showlist&numberPage=<%=numberPage + 1%>">Pagina
			Successiva</a>
	</div>
	<%
		}
	%>

	<%
		} else {
	%>
	<h1 class="noobject" style="text-align: center">Nessun Oggetto
		Presente</h1>
	<a id="getback"
		href="UsersOpAdmin?action=showlist&numberPage=<%=numberPage - 1%>">
		<i class="fas fa-angle-double-left"></i> Torna indietro
	</a>

	<%
		}
	%>
	<br>
	<br>

</body>



<script>
	function openForm(obj) {
		document.getElementById("myForm").style.display = "block";
		document.getElementById("cfUser").value = obj;
	}
</script>

<script>
	function openForm2(obj) {
		document.getElementById("myForm2").style.display = "block";
		document.getElementById("cfUser2").value = obj;
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