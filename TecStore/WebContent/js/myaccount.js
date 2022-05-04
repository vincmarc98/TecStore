//Validazione form di aggiornamento
function checkUpdateForm(){
	var citta = formUpdate.citta;
	var via = formUpdate.via;
	var civico = formUpdate.ncivico;
	var cap = formUpdate.cap;
	var pass_vecchia = formUpdate.oldPass;
	var pass_nuova = formUpdate.newPass;
	var ripetiPassword = formUpdate.rePass;
	
	var spanError; //elemento span dove inserire la scritta per l'errore
	
	var patternVia = /^[A-Z a-z.]{2,40}$/g;
	var patternCitta = /^[A-Z a-z.]{2,30}$/g;
	var patternPass = /^[a-zA-Z0-9.]{6,20}$/g;
	
	$(".error").html("");
	
	
	if(!patternCitta.test(citta.value)){
		spanError = document.getElementById("errorUpdate");
		spanError.innerHTML = "La citt&agrave;: <br/>" +
				"-deve essere lunga tra i 2 e 30 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere e caratteri come \".\")";
		
		citta.focus();
		
		return false;
	}
	
	if(!patternVia.test(via.value)){
		spanError = document.getElementById("errorUpdate");
		spanError.innerHTML = "La via: <br/>" +
				"-deve essere lunga tra i 2 e 40 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere e caratteri come \".\")";
		
		via.focus();
		
		return false;
	}
	
	if((civico.value < 1) || (civico.value > 9999)){
		spanError = document.getElementById("errorUpdate");
		spanError.innerHTML = "Il civico: <br/>" +
				"-deve essere compreso tra 1 e 9999; <br/>";
		
		civico.focus();
		
		return false;
	}
	
	if((cap.value < 10000) || (cap.value > 99999)){
		spanError = document.getElementById("errorUpdate");
		spanError.innerHTML = "Il cap: <br/>" +
				"-deve essere compreso tra 10000 e 99999; <br/>";
		
		cap.focus();
		
		return false;
	}
	

	return true;
}