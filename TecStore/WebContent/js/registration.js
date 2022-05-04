//Validazione form di registrazione
function checkSignForm(){
	var codice_fiscale = signForm.codicefiscale;
	var nome = signForm.nome;
	var cognome = signForm.cognome;
	var email = signForm.email;
	var pass = signForm.password;
	var citta = signForm.citta;
	var via = signForm.via;
	var civico = signForm.ncivico;
	var cap = signForm.cap;
	
	
	var spanError; //elemento span dove inserire la scritta per l'errore
	
	var patternCodiceFiscale = /^[A-Za-z0-9]{16,16}$/g;
	var patternNome = /^[A-Za-z]{2,15}$/g;
	var patternCognome = /^[A-Za-z]{2,15}$/g;
	var patternMail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/g;
	var patternPass = /^[a-zA-Z0-9.]{6,20}$/g;
	var patternVia = /^[A-Z a-z.]{2,40}$/g;
	var patternCitta = /^[A-Z a-z.]{2,30}$/g;
	
	$(".error").html("");
	
	if(!patternCodiceFiscale.test(codice_fiscale.value)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "Il codice fiscale: <br/>" +
				"-deve essere lungo esattamente 16 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere e numeri";
				
		codice_fiscale.focus();
		
		return false;
	}
	
	if(!patternNome.test(nome.value)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "Il nome: <br/>" +
				"-deve essere lungo tra i 2 e 15 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere";

		nome.focus();
		
		return false;
	}
	
	if(!patternCognome.test(cognome.value)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "Il cognome: <br/>" +
				"-deve essere lungo tra i 2 e 15 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere";
		
		cognome.focus();
		
		return false;
	}
	
	if(!patternMail.test(email.value)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "L'email non rispetta il formato standard.";
		
		email.focus();
		
		return false;
	}
	
	if(!patternPass.test(pass.value)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "La password: <br/>" +
				"-deve essere lunga tra gli 6 e 20 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere, numeri e caratteri come \".\")";
		
		
		pass.focus();
		
		return false;
	}
	
	if(!patternCitta.test(citta.value)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "La citt&agrave;: <br/>" +
				"-deve essere lunga tra i 2 e 30 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere e caratteri come \".\")";
		
		citta.focus();
		
		return false;
	}
	
	if(!patternVia.test(via.value)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "La via: <br/>" +
				"-deve essere lunga tra i 2 e 40 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere e caratteri come \".\")";
		
		via.focus();
		
		return false;
	}
	
	if((civico.value < 1) || (civico.value > 9999)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "Il civico: <br/>" +
				"-deve essere compreso tra 1 e 9999; <br/>";
		
		civico.focus();
		
		return false;
	}
	
	if((cap.value < 10000) || (cap.value > 99999)){
		spanError = document.getElementById("errorSign");
		spanError.innerHTML = "Il cap: <br/>" +
				"-deve essere compreso tra 10000 e 99999; <br/>";
		
		cap.focus();
		
		return false;
	}
		
	return true;
}

$("input#email").on('input', function(){
	var jsonObj = {};
	jsonObj.email = $("input#email").val();
	var jsonStr = JSON.stringify(jsonObj);
	
	
	$.ajax({
		url: "CheckEmailAtSignup",
		type: "POST",
		data: "json=" + encodeURIComponent(jsonStr),
		success: function(result){					  
				    if(result.esito === false){
				   		$("input#email").css("background-color", "#FF0000");
				   		
				   	} else if(result.esito === true) {
				   		$("input#email").css("background-color", "#00FF00");
				   	}	
				   	
				   	if(!$("input#email").val()) {
				   		$("input#email").css("background-color", "#FFFFFF");
				   	}
			}
	});
	
	return false;
})

$("input#codicefiscale").on('input', function(){
	var jsonObj = {};
	jsonObj.codicefiscale = $("input#codicefiscale").val();
	var jsonStr = JSON.stringify(jsonObj);
	
	
	$.ajax({
		url: "CheckCFAtSignup",
		type: "POST",
		data: "json=" + encodeURIComponent(jsonStr),
		success: function(result){					  
				    if(result.esito === false){
				   		$("input#codicefiscale").css("background-color", "#FF0000");
				   			   		
				   	} else if(result.esito === true) {
				   		$("input#codicefiscale").css("background-color", "#00FF00");
				   	}	
				   	
				   	if(!$("input#codicefiscale").val()) {
				   		$("input#codicefiscale").css("background-color", "#FFFFFF");
				   	}
			}
	});
	
	return false;
})
