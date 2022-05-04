//Validazione form di aggiornamento merce
function checkUpdateForm(){
	var prodotto = formInsert.prodotto;
	var descrizione = formInsert.descrizione;
	
	
	var spanError; //elemento span dove inserire la scritta per l'errore
	
	var patternProdotto = /^[A-Za-z 0-9]{2,20}$/g;
	var patternDescrizione = /^[A-Za-z 0-9]{2,150}$/g;
	
	$(".error").html("");
	
	
	if(!patternProdotto.test(prodotto.value)){
		spanError = document.getElementById("errorUpdate");
		spanError.innerHTML = "Il nome del prodotto;: <br/>" +
				"-deve essere lungo tra i 2 e 20 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere e numeri";
		
		prodotto.focus();
		
		return false;
	}
	
	if(!patternDescrizione.test(descrizione.value)){
		spanError = document.getElementById("errorUpdate");
		spanError.innerHTML = "La descrizione;: <br/>" +
				"-deve essere lunga tra i 2 e 150 caratteri; <br/>" +
				"-pu&ograve; contenere solo lettere e numeri";
		
		descrizione.focus();
		
		return false;
	}
	
	return true;
}