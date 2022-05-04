package it.unisa.control;


import static org.apache.commons.io.IOUtils.toByteArray;

//import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import java.util.Collection;
import java.util.LinkedList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import it.unisa.model.Merce;
import it.unisa.model.MerceBean;
import it.unisa.model.UserBean;


@WebServlet(name="MerceOperationsAdmin" ,urlPatterns="/MerceOpAdmin", 
initParams={@WebInitParam(name="file-upload", value="images")})
@MultipartConfig(fileSizeThreshold=1024*1024*2,maxFileSize=1024*1024*50, maxRequestSize=1024*1024*50)

public class MerceOperationsAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String SAVE_DIR="";
	static Merce model;

	public void init(){
		SAVE_DIR = getServletConfig().getInitParameter("file-upload");
	}

	public MerceOperationsAdmin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=(String)request.getParameter("action");
		model = new Merce();
		String numberPageString =(String)request.getParameter("numberPage");
		if(numberPageString==null||numberPageString==""){
			numberPageString="1";
		}

		int numberPage = Integer.parseInt(numberPageString);

		if(numberPage<1){
			numberPage=1;
		}

		if(action!=null){
			if(action.equalsIgnoreCase("showlist")){

				try {
					Collection<MerceBean> collection= model.getAllMerce(null,numberPage);
					request.setAttribute("collection", collection);
				} catch (SQLException e1) {
					e1.printStackTrace();
				}

				RequestDispatcher rd= getServletContext().getRequestDispatcher("/mercemanagement.jsp");
				rd.forward(request, response);


			} else if(action.equalsIgnoreCase("showlistbycodice")){
				String codice=request.getParameter("codicemerce");
				Collection <MerceBean> collection = new LinkedList<MerceBean>();

				try {
					if(codice != null){
						MerceBean merce= model.searchMerceByCodiceMerce(codice);
						if(merce.getCodiceMerce()!=0)	collection.add(merce);
						else collection=null;
					} else {
						collection=null;
					}

				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.setAttribute("collection", collection);
				RequestDispatcher rd= getServletContext().getRequestDispatcher("/mercemanagement.jsp");
				rd.forward(request, response);
				
			} else if(action.equalsIgnoreCase("showlistbytitolo")){
				String codice = request.getParameter("titolo");
				Collection <MerceBean> collection = new LinkedList<MerceBean>();

				try {
					if(codice != null){
						collection = model.searchMerceByTitolo(codice,numberPage);
					} else {
						collection=null;
					}

				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.setAttribute("collection", collection);
				RequestDispatcher rd= getServletContext().getRequestDispatcher("/mercemanagement.jsp");
				rd.forward(request, response);
				
			} else if(action.equalsIgnoreCase("insert")){

				MerceBean merce= new MerceBean();
		
				String prodotto= request.getParameter("prodotto");
				String categoria=request.getParameter("categoria");
				String descrizione=request.getParameter("descrizione");
				double costo=Double.parseDouble(request.getParameter("costo"));
				
				Part part = request.getPart("foto");
				if(part != null)
					merce.setImmagine(toByteArray(part.getInputStream()));

				merce.setTitolo(prodotto);
				merce.setCategoria(categoria);
				merce.setDescrizione(descrizione);
				merce.setCosto(costo);

				try {
					model.insertNewMerce(merce);
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/insertMerceCompleted.jsp");
					rd.forward(request, response);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if(action.equalsIgnoreCase("delete")){
				String codiceMerce= request.getParameter("codiceMerce");
				UserBean user = (UserBean) request.getSession().getAttribute("user");
				if(user.getTipo().equalsIgnoreCase("Amministratore")) {
					try {
						model.deleteMerce(codiceMerce);
						RequestDispatcher rd= getServletContext().getRequestDispatcher("/deleteMerceCompleted.jsp");
						rd.forward(request, response);
					} catch (SQLException e) {
						e.printStackTrace();
					}				
				}	
			} else if(action.equalsIgnoreCase("redirectForUpdate")){
			
				String codiceMerce= request.getParameter("CodiceMerce");

				try {
					MerceBean merce = model.searchMerceByCodiceMerce(codiceMerce);
					request.getSession().setAttribute("merce", merce);
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/updateMerce.jsp");
					rd.forward(request, response);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if(action.equalsIgnoreCase("update")){
				double costo=0.0;
				MerceBean merce = new MerceBean();
				String codiceMerce=request.getParameter("codiceMerce");
				String prodotto=request.getParameter("prodotto");
				String categoria=request.getParameter("categoria");
				String descrizione=request.getParameter("descrizione");
				if(request.getParameter("costo")!=null || !request.getParameter("costo").equals("")){
					costo = Double.parseDouble(request.getParameter("costo"));
				}
				
				Part part = request.getPart("foto");
				if(part != null)
					merce.setImmagine(toByteArray(part.getInputStream()));

				
				merce.setCodiceMerce(Integer.parseInt(codiceMerce));
				merce.setTitolo(prodotto);
				merce.setCategoria(categoria);
				merce.setDescrizione(descrizione);
				merce.setCosto(costo);
	

				try {
					model.updateMerce(merce);
					RequestDispatcher rd = request.getRequestDispatcher("/updateMerceCompleted.jsp");
					rd.forward(request, response);
				} catch (SQLException e) {
					e.printStackTrace();
				}	
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}
		
}
