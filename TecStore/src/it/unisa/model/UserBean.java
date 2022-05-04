package it.unisa.model;

public class UserBean {
	private String cfUtente;
	private String nome;
	private String cognome;
	private String via;
	private int nCivico;
	private String pass;
	private String citta;
	private String email;
	private int cap;
	private String tipo;

	public UserBean() {
		this.cfUtente = "0000000000000000"; /* 16 caratteri */
		this.nome = "";
		this.cognome = "";
		this.citta = "";
		this.via = "";
		this.nCivico = 0;
		this.email = "";
		this.pass = "";
		this.cap=0;
		this.tipo="";
	}
	
	public String getTipo() {
		return tipo;
	}
	
	public void setRank(String tipo) {
		this.tipo=tipo;
	}

	public String getCfUtente() {
		return cfUtente;
	}

	public void setCfUtente(String cfUtente) {
		this.cfUtente = cfUtente;
	}


	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
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

	public int getNCivico() {
		return nCivico;
	}

	public void setNCivico(int NCivico) {
		this.nCivico = NCivico;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}
	
	public void setCap(int n) {
		this.cap=n;
	}
	
	public int getCap() {
		return cap;
	}

	@Override
	public String toString() {
		return "UserBean [cfUtente=" + cfUtente + ", nome=" + nome
				+ ", cognome=" + cognome + ", citta=" + citta + ", via=" + via + ", nCivico="
				+ nCivico + ",CAP="+cap+", email=" + email + ", pass=" + pass + "]";
	}



}
