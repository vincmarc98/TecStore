package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.Merce;
import it.unisa.model.MerceBean;

@WebServlet("/GetPicture")
public class PictureOperations extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public MerceBean film;

	public PictureOperations() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codice = (String) request.getParameter("merce");
		Merce m = new Merce();
		try {
			film = m.searchMerceByCodiceMerce(codice);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		byte[] bt = film.getImmagine();
		
		if (bt != null) {
			ServletOutputStream out = response.getOutputStream();
			out.write(bt);
			response.setContentType("image/png");
			out.close();
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	
	
	
	
	

}
