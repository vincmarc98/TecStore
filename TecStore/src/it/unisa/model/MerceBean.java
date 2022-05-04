package it.unisa.model;

public class MerceBean {

	private int codiceMerce;
	private String titolo;
	private String categoria;
	private String descrizione;
	private double costo;
	private byte[] immagine;
	
	public MerceBean() {
		this.codiceMerce = 0; /* 10 caratteri */
		this.titolo="";
		this.categoria="";
		this.descrizione = "";
		this.costo = 0.0;
	}

	public int getCodiceMerce() {
		return codiceMerce;
	}


	public void setCodiceMerce(int codice) {
		this.codiceMerce = codice;
	}
	
	public String getTitolo() {
		return titolo;
	}


	public void setTitolo(String codice) {
		this.titolo = codice;
	}
	
	public String getCategoria() {
		return categoria;
	}


	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public String getDescrizione() {
		return descrizione;
	}


	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}


	public double getCosto() {
		return costo;
	}


	public void setCosto(double costo) {
		this.costo = costo;
	}


	public byte[] getImmagine() {
		return immagine;
	}


	public void setImmagine(byte[] immagine) {
		this.immagine = immagine;
	}


	@Override
	public String toString() {
		return "MerceBean [codice merce=" + codiceMerce + ", categoria=" + categoria + ", descrizione=" + descrizione + ", costo=" + costo + ", codice magazzino="
				+ ", codice ordine="+ ", immagine=" + immagine + "]";
	}

	

}
