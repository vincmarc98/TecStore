// Quando l'utente clicca al di fuori del modal, chiudilo

	var modal = document.getElementById('id01');

	window.onclick = function(event) {
   		if (event.target == modal) {
   			modal.style.display = "none";
   		}
	}
