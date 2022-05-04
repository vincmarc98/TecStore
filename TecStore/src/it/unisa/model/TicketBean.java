package it.unisa.model;

public class TicketBean {

	private int codiceTicket;
	private String titolo;
	private String descrizione;
	private String stato;
	private int codiceOrdine;
	private String cfCliente;
	

	public TicketBean() {
		this.codiceTicket =0; /* 10 caratteri */
		this.titolo="";
		this.descrizione = "";
		this.stato = "";
		this.codiceOrdine = 0;
		this.cfCliente="";
	}


	public int getCodiceTicket() {
		return codiceTicket;
	}


	public void setCodiceTicket(int codice) {
		this.codiceTicket = codice;
	}
	
	public String getTitolo() {
		return titolo;
	}


	public void setTitolo(String codice) {
		this.titolo = codice;
	}
	


	public String getDescrizione() {
		return descrizione;
	}


	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}


	public String getStato() {
		return stato;
	}


	public void setStato(String stato) {
		this.stato = stato;
	}


	public String getCodiceFiscale() {
		return cfCliente;
	}


	public void setCodiceFiscale(String cf) {
		this.cfCliente = cf;
	}
	
	public int getCodiceOrdine() {
		return codiceOrdine;
	}
	
	public void setCodiceOrdine(int codice) {
		this.codiceOrdine=codice;
	}


	@Override
	public String toString() {
		return "MerceBean [codice ticket=" + codiceTicket + ", titolo=" + titolo+ ", descrizione=" + descrizione + ", stato=" + stato + ", codice ordine="
				+ codiceOrdine + ", codice fiscale="+ cfCliente+ "]";
	}

	

}
