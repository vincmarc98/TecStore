<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
 	Boolean userlog = (Boolean) request.getSession().getAttribute("userlog"); 	
    Boolean errPass = (Boolean) request.getSession().getAttribute("errPass");
    Boolean errUser = (Boolean) request.getSession().getAttribute("errUser");
    
	if (userlog==null){
		userlog=false;
	}
	
	if (errPass==null){
		errPass=false;
	}
	
	if (errUser==null){
		errUser=false;
	}
	
 
	if(userlog==true){
		response.sendRedirect("index.jsp");
	}
	
 %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="css/freelancer.css" rel="stylesheet">
	<title>Log-In</title>
</head>
<body>


<% if(errPass==true) {
	request.getSession().setAttribute("errPass",false);
	
%>

<!-- PopUp Login False Password -->
	<div id="id01" class="modal" align="center">
    	<form class="modal-content animate" action="UserOperations" method="post">
   	 		<input type="hidden" name="action" value="login" id="action">
   	 		
   			<div class="imgcontainer"> 
   				<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
   				<img src="img/profile.png" alt="Avatar" class="avatar">
   			</div>
   			
			<div align="center"><p style="color:red">Password Errata!</p></div>
		
    		<div class="container">
      			<label for="uname"><b>Email</b></label><br>
     			<input type="text" placeholder="Enter E-mail" name="email" required><br><br>

    			<label for="psw"><b>Password</b></label><br>
      			<input type="password" placeholder="Enter Password" name="password" required><br>
      			<br>  
      			<button id="finish" type="submit" style="color:white; background-color:green">Log in</button>
      		</div>
			<br>
	
    		<div class="container" style="background-color:#f1f1f1">
     			<a href="registration.jsp">Sei nuovo? Registrati!</a>
    		</div>
  		</form>
	</div>
<%} else if(errUser==true) {
	request.getSession().setAttribute("errUser",false); 

%>
<!-- PopUp Login False User -->
	<div id="id01" class="modal" align="center">
 		<form class="modal-content animate" action="UserOperations" method="post">
    		<input type="hidden" name="action" value="login" id="action">
    		
    		<div class="imgcontainer">
      			<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
      			<img src="img/profile.png" alt="Avatar" class="avatar" id="img">
    		</div>
    
			<div align="center"><p style="color:red">Username Errato!</p></div>
    		
   		 	<div class="container">
      			<label for="uname"><b>Email</b></label><br>
      			<input type="text" placeholder="Enter Username" name="email" required><br><br>

	  	    	<label for="psw"><b>Password</b></label><br>
    		  	<input type="password" placeholder="Enter Password" name="password" required><br><br>
      
     		 	<button id="finish" type="submit" style="color:white; background-color:green">Log in</button>
     		 	
    		</div>

    		<div class="container" style="background-color:#f1f1f1">
    			<a href="registration.jsp">Sei nuovo? Registrati!</a>
   			</div>
 		 </form>
	</div>
<%} else { %>

<!-- PopUp Login -->
    <div id="id01" class="modal" align="center">
    	<form class="modal-content animate" action="UserOperations" method="post">
    		<input type="hidden" name="action" value="login" id="action">
    		
   	 		<div class="imgcontainer"> 
    	  		<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
    	  		<img src="img/profile.png" alt="Avatar" class="avatar" id="img">
    		</div>
    	
    		<div class="container">
      			<label for="uname"><b>Email</b></label><br>
      			<input type="text" placeholder="Enter Email" name="email" required><br><br>

    	  		<label for="psw"><b>Password</b></label><br>
      	  		<input type="password" placeholder="Enter Password" name="password" required><br><br>
  
 	     		<button id="finish" type="submit" style="color:white; background-color:green">Log in</button>
 	     			     		
    		</div>

   			<div class="container" style="background-color:#f1f1f1">
    			<a href="registration.jsp">Sei nuovo? Registrati!</a>
   			</div>
  		</form>
	</div>
<%}%>

</body>

<script src="js/login.js"></script>
</html>
