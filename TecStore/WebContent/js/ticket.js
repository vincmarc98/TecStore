//Validazione form del ticket
function checkTicketForm(){
	var codiceOrdine = ticketForm.codice;
	var titolo = ticketForm.titolo;
	var descrizione = signForm.descrizione;
	
	var spanError; //elemento span dove inserire la scritta per l'errore
	
	var patternCodiceOrdine = /^[0-9]{1,}$/g;
	var patternTitolo = /^[A-Za-z ]{2,30}$/g;
	var patternDescrizione = /^[A-Za-z ]{2,150}$/g;
	
	$(".error").html("");
	
	if(!patternCodiceOrdineFiscale.test(codiceOrdine.value)){
		spanError = document.getElementById("errorTicket");
		spanError.innerHTML = "Il codice ordine: <br/>" +
				"-deve contenere solo numeri";
				
		codiceOrdine.focus();
		
		return false;
	}
	
	if(!patternTitolo.test(titolo.value)){
		spanError = document.getElementById("errorTicket");
		spanError.innerHTML = "Il titolo: <br/>" +
				"-deve essere lungo tra i 2 e 30 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere";

		titolo.focus();
		
		return false;
	}
	
	if(!patternDescrizione.test(descrizione.value)){
		spanError = document.getElementById("errorTicket");
		spanError.innerHTML = "La descrizione: <br/>" +
				"-deve essere lunga tra i 2 e 150 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere";
		
		descrizione.focus();
		
		return false;
	}
	
	return true;
}

