<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, it.unisa.model.*"%>

<%
	MerceBean merce = (MerceBean) request.getSession().getAttribute("merce");
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

	if (merce == null) {
		merce = new MerceBean();
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
			<i class="fas fa-angle-double-right"></i> Modifica prodotto
		</h2>
	</div>

	<br>

	<div align="center">
		<div style="overflow: auto">
			<form id="updateForm" action="MerceOpAdmin" method="post" enctype="multipart/form-data" onsubmit="return checkUpdateForm()">
				<input type="hidden" name="action" value="update"> 
				<input type="hidden" name="codiceMerce" value="<%=merce.getCodiceMerce()%>">

				<p class="error" id="errorUpdate" style="color:red"> <%= error %> </p>
				
				<table id="ModCancMerceTableId" style="width: 70%">

					<tr>
						<th style="width: 15%"><div align="center">
								<h6>Prodotto</h6>
							</div></th>
						<td><input id="prodottoUp" type="text" name="prodotto" maxlength="20"
							value="<%=merce.getTitolo()%>"></td>
							
						<th style="width: 15%"><div align="center">
							<h6>Foto</h6>
							</div></th>
						<td><input style="width: 100%" id="fotoUp" type="file" 
							name="foto" accept="image/*" 
							value="<%=merce.getImmagine()%>"></td>
							
						<th style="width: 15%"><div align="center">
							<h6>Costo</h6>
							</div></th>
						<td><input style="width: 50%" id="costoUp" type="number"
							step=".01" name="costo" value="<%=merce.getCosto()%>"></td>
					</tr>

					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>


					<tr>
						<th style="width: 15%"><div align="center">
								<h6>Categoria</h6>
							</div></th>
						<td>
						<%
							if (merce.getCategoria().equalsIgnoreCase("Fotocamera")) {
						%> 	<select name="categoria">
								<option value="Fotocamera" selected>Fotocamera</option>
								<option value="Cellulare">Smartphone</option>
								<option value="PC">PC e Laptop</option>
							</select> <%
 							}
							%> <%
 							if (merce.getCategoria().equalsIgnoreCase("Cellulare")) {
 						%> 	<select name="categoria">
								<option value="Fotocamera">Fotocamera</option>
								<option value="Cellulare" selected>Smartphone</option>
								<option value="PC">PC e Laptop</option>
							</select> <%
 							}
 							%> <%
 							if (merce.getCategoria().equalsIgnoreCase("PC")) {
						%> <select name="categoria">
						   		<option value="Fotocamera">Fotocamera</option>
								<option value="Cellulare">Smartphone</option>
								<option value="PC" selected>PC e Laptop</option>
						   </select> <%
 							}
 						%>
						</td>
						<th style="width: 15%"><div align="center">
								<h6>Descrizione&nbsp;</h6>
							</div></th>
						<td><textarea id="descrizioneUp" 
								name="descrizione" maxlength="150" style="height: 100px; width: 300px"><%=merce.getDescrizione()%></textarea></td>
						
					</tr>

					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>

				<button type="submit" id="conferma" class="conferma">
					Modifica</button>

				<span style="margin-right: 1%">&nbsp;</span>

				<input type="button" value="Annulla"
					onclick="window.location.href='MerceOpAdmin?action=showlist'"
					id="resetta">
			</form>
			<br>
		</div>
	</div>

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
<script src="js/updatemerce.js"></script>

</html>