package it.unisa.model;

public class OrderBean {
	private int codiceOrdine;
	private String dataOrdine;
	private String mezzo;
	private int nMerci;
	private double totale;
	private String metodoDiPagamento;
	private String numCard;
	private String cfCliente;
	private String citta;
	private String via;
	private int civico;
	private int cap;
	private String stato;

	public OrderBean() {
		this.codiceOrdine= 0;
		this.dataOrdine = "";
		this.mezzo = "";
		this.nMerci = 0;
		this.totale = 0;
		this.metodoDiPagamento = "";
		this.numCard = "";
		this.cfCliente = "";
		this.citta="";
		this.via="";
		this.cap=0;
		this.civico=0;
		this.stato="";
	}
	
	public String getCitta() {
		return citta;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}
	
	public String getVia() {
		return via;
	}

	public void setVia(String via) {
		this.via = via;
	}
	
	public int getCivico() {
		return civico;
	}

	public void setCivico(int codice) {
		this.civico = codice;
	}
	
	public int getCap() {
		return cap;
	}

	public void setCap(int codice) {
		this.cap = codice;
	}
	
	public String getStato() {
		return stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
	}

	public int getCodiceOrdine() {
		return codiceOrdine;
	}

	public void setCodiceOrdine(int codiceOrdine) {
		this.codiceOrdine = codiceOrdine;
	}

	public String getDataOrdine() {
		return dataOrdine;
	}

	public void setDataOrdine(String dataOrdine) {
		this.dataOrdine = dataOrdine;
	}

	public String getMezzo() {
		return mezzo;
	}

	public void setMezzo(String mezzo) {
		this.mezzo = mezzo;
	}

	public int getnMerci() {
		return nMerci;
	}

	public void setnMerci(int nMerci) {
		this.nMerci = nMerci;
	}

	public double getTotale() {
		return totale;
	}

	public void setTotale(double totale) {
		this.totale = totale;
	}

	public String getMetodoDiPagamento() {
		return metodoDiPagamento;
	}

	public void setMetodoDiPagamento(String metodoDiPagamento) {
		this.metodoDiPagamento = metodoDiPagamento;
	}

	public String getNumCard() {
		return numCard;
	}

	public void setNumCard(String numCard) {
		this.numCard = numCard;
	}

	public String getCfCliente() {
		return cfCliente;
	}

	public void setCfCliente(String cfCliente) {
		this.cfCliente = cfCliente;
	}

	@Override
	public String toString() {
		return "TicketBean [codiceOrdine=" + codiceOrdine + ", dataOrdine=" + dataOrdine + ", mezzo=" + mezzo
				+ ", nMerci=" + nMerci + ", totale=" + totale + ", metodoDiPagamento=" + metodoDiPagamento
				+ ", numCard=" + numCard + ", cfCliente=" + cfCliente + "]";
	}
	
}
