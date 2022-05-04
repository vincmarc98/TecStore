<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*, it.unisa.model.* "
	session="true"%>

<%
    UserBean user=(UserBean) request.getSession().getAttribute("user");
	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
	Boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
	Boolean operatorlog = (Boolean) request.getSession().getAttribute("operatorlog");
	Collection<?> collection = (Collection<?>) request.getAttribute("collection");
	int numberPage;
	String numberPageString = (String) request.getParameter("numberPage");
	String gen = (String) request.getParameter("genere");
	
	if(user==null){
		user=new UserBean();
	}

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

	if (gen == null) {
		gen = "nada";
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
		response.sendRedirect("MerceOpUser?action=showlist");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">

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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="css/shop.css">


<title>Shop</title>
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
			<i class="fas fa-shopping-bag"></i> Sezione Shop
		</h2>
		<br>
		<h5>
			&nbsp;&nbsp;&nbsp;Benvenuto nella nostra pagina shopping! Qui potrai
			visualizzare tutti i prodotti disponibili. <br>&nbsp;&nbsp;Se
			cerchi qualcosa in particolare, ti consigliamo di filtrarli per titolo 
			o per categoria. <br>&nbsp;&nbsp;Che aspetti?
			Inizia subito la tua elettrificante spesa!
		</h5>
	</div>
	<br>
	<hr>

	<table style="margin-left: 3%" >

		<tr>
			<th style="width: 30%">&nbsp;</th>

			<th><label for="campoServer"><h3>Ricerca per categoria:</h3></label> <br>
				<ul>
					<li class="Fotocamere"><h5>
							<a href="MerceOpUser?action=showlistbygen&genere=Fotocamera">Fotocamere</a>
						</h5></li>
					<li class="CellulariTablets"><h5>
							<a href="MerceOpUser?action=showlistbygen&genere=Cellulare">Smartphone</a>
						</h5></li>
					<li class="PCeLaptop"><h5>
							<a href="MerceOpUser?action=showlistbygen&genere=PC">PC e Laptop</a>
						</h5></li>
				</ul>
			</th>
			
			<th style="width: 20%">&nbsp;</th>
			
			<th>
				<form action="MerceOpUser" method="get">
					<input type="hidden" name="action" value="showlistbytitolo"
						id="action"> <label for="campoServer"><h3>Ricerca
							per titolo:</h3></label> <br> <input id="markBar" type="text"
						name="titolo" maxlength="35" id="titolo" placeholder="Titolo"
						required> <input type="submit" value="Conferma">
				</form>
			</th>
		</tr>
	</table>
	<hr>

	<br>

	<table style="margin-left: 18%; margin-right: 18%">
		<tr>
			<%
				if (collection != null && collection.size() != 0) {
					int count = 0;
					int k = 0;
					Iterator<?> it = collection.iterator();

					while (it.hasNext()) {
						MerceBean merce = (MerceBean) it.next();
						if (merce != null) {
							request.getSession().setAttribute("merce", merce.getCodiceMerce());
			%>

			<th>
				<div class="bigger">
					<div align="center">
						<img id="shopImg" src="<%=response.encodeURL("GetPicture?merce=" + merce.getCodiceMerce())%>" alt="Immagine non disponibile">
					</div>

					<div class="little">
						<h2 class="mark"><%=merce.getTitolo()%></h2>
						<span class="hiddenContent<%=k%>" style="display: none">
							<h6>Categoria:</h6> <%=merce.getCategoria()%> <br>
							<h6>Descrizione:</h6> <%=merce.getDescrizione()%> <br>
							<h6>Prezzo:</h6> <%=merce.getCosto()%> &euro;<br> <br>
							<%if(user.getTipo().equalsIgnoreCase("Cliente") || user.getTipo().equals("")){ %> 
							<a onclick="msg('<%=merce.getTitolo()%> aggiunto al carrello.')"
							class="buttonlist" href="MerceOpUser?action=addToCart&codiceMerce=<%=merce.getCodiceMerce()%>">
							<b>Aggiungi	al Carrello</b></a>
							 <br>
							<% } %> 
							<br>
						</span>
						<button id="conferma" class="button<%=k%>"
							onclick="function<%=k%>()">Mostra altro</button>
					</div>
				</div>
			</th>
				<%
						k++;
					if (count == 2) {
				%>
		</tr>

		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
		</tr>
		<tr>

			<%
				count = 0;

							} else {
								count++;
			%>

			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>

			<%
				}
			%>


			<%
				}
					}
			%>
		</tr>

		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>
		<tr class="hiddenContent1" style="display: none">
			<th>&nbsp;</th>
		</tr>

	</table>

<br>
<div align="center">
	<%
		if (numberPage > 1 && gen.equals("nada")) {
	%>
	<div id="previousPag" class="paging">
		<a href="MerceOpUser?action=showlist&numberPage=<%=numberPage - 1%>">
			Pagina Precedente</a>
	</div>
	<br>
	<%
		}
	%>
	<%
		if (collection.size() == 6 && gen.equals("nada")) {
	%>
	<div id="nextPage">
		<a id="nextPageAhref"
			href="MerceOpUser?action=showlist&numberPage=<%=numberPage + 1%>">Pagina
			Successiva</a>
	</div>

	<%
		} else if (numberPage > 1 && !(gen.equals("nada"))) {
	%>
	<div id="previousPag" class="paging">
		<a
			href="MerceOpUser?action=showlistbygen&genere=<%=gen%>&numberPage=<%=numberPage - 1%>">
			Pagina Precedente</a>
	</div>
	<br>
	<%
		}
	%>


	<%
		if (collection.size() == 6 && !(gen.equals("nada"))) {
	%>

	<div id="nextPage">
		<a id="nextPageAhref"
			href="MerceOpUser?action=showlistbygen&genere=<%=gen%>&numberPage=<%=numberPage + 1%>">Pagina
			Successiva</a>
	</div>

	<%
		}
		} else if (gen.equals("nada")) {
	%>
	<h1 class="noobject" style="text-align: center">Nessun Oggetto
		Presente</h1>
	<a id="getback"  style="text-align: center" href="MerceOpUser?action=showlist">Torna
		indietro</a>

	<%
		} else if (gen.equals("nada") && numberPage == 1) {
	%>
	<h1 class="noobject" style="text-align: center">Nessun Oggetto
		Presente</h1>
	<a id="getback"  style="text-align: center" href="MerceOpUser?action=showlist">Torna
		indietro</a>

	<%
		} else if (!gen.equals("nada")) {
	%>
	<h1 class="noobject" style="text-align: center">Nessun Oggetto
		Presente</h1>
	<a id="getback"  style="text-align: center" href="MerceOpUser?action=showlist"> Torna
		indietro</a>
	<%
		} else if (!gen.equals("nada") && numberPage == 1) {
	%>
	<h1 class="noobject" style="text-align: center">Nessun Oggetto
		Presente</h1>
	<a id="getback"  style="text-align: center" href="MerceOpUser?action=showlist">Torna
		indietro</a>
	<%
		} else if (gen.equals("nada")) {
	%>
	<h1 class="noobject" style="text-align: center">Nessun Oggetto
		Presente</h1>
	<a id="getback"  style="text-align: center" href="MerceOpUser?action=showlist"> Torna
		indietro</a>
	<%
		}
	%>

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

	
	<script type="text/javascript">
		var x;

		function msg(a) {
			alert(a);
		}
	</script>

	<script>
		function function0(){
				$("span.hiddenContent0").delay(50).fadeToggle("slow");
				$("tr.hiddenContent").fadeToggle();
			};
	</script>

	<script>
		function function1(){
				$("span.hiddenContent1").delay(50).fadeToggle("slow");
				$("tr.hiddenContent").fadeToggle();
			};
	</script>

	<script>
		function function2(){
				$("span.hiddenContent2").delay(50).fadeToggle("slow");
				$("tr.hiddenContent").fadeToggle();
			};
	</script>

	<script>
		function function3(){
				$("span.hiddenContent3").delay(50).fadeToggle("slow");
				$("tr.hiddenContent1").fadeToggle();
			};
	</script>

	<script>
		function function4(){
				$("span.hiddenContent4").delay(50).fadeToggle("slow");
				$("tr.hiddenContent1").fadeToggle();
			};
	</script>

	<script>
		function function5(){
				$("span.hiddenContent5").delay(100).fadeToggle("slow");
				$("tr.hiddenContent1").fadeToggle();
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
</body>
</html>