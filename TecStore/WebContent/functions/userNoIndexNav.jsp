<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TecStore</title>
</head>
<body>
	<nav
		class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase"
		id="mainNav">
	<div class="container">
		<a class="navbar-brand js-scroll-trigger" href="index.jsp">TecStore</a>
		<button
			class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded"
			type="button" data-toggle="collapse" data-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="false"
			aria-label="Toggle navigation">
			Menu <i class="fas fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
			<li class="nav-item mx-0 mx-lg-1"><a
					class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
					href="cart.jsp">Carrello</a></li>

				<li class="nav-item mx-0 mx-lg-1"><a
					class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
					href="shop.jsp">Shop</a></li>
				<li>&nbsp; &nbsp; &nbsp;</li>
				<li class="nav-item mx-0 mx-lg-1">
					<button
						onclick="document.getElementById('id01').style.display='block'"
						style="width: auto;" id="modal_trigger"
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger">
						<i class="fa fa-male" style="font-size: 20px"></i> Log in
					</button>
				</li>
			</ul>
		</div>
	</div>
	</nav>
</body>
</html>