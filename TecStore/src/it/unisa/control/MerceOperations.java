package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.*;


@WebServlet(name="MerceOperations" ,urlPatterns="/MerceOpUser")
public class MerceOperations extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static Merce model;
  
	public MerceOperations() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		model= new Merce();
		String action=request.getParameter("action");
		response.setContentType("text/html");
		String numberPageString =(String)request.getParameter("numberPage");
		
		if(numberPageString==null||numberPageString==""){
			numberPageString="1";
		}
		
		int numberPage = Integer.parseInt(numberPageString);
		
		if(action!=null){
			if(action.equalsIgnoreCase("showlist")){
				try {
					Collection<MerceBean> collection=model.getAllMerce(null,numberPage);
					request.setAttribute("collection", collection);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				RequestDispatcher rd= (RequestDispatcher) getServletContext().getRequestDispatcher("/shop.jsp");
				rd.forward(request, response);
			
			} else if (action.equalsIgnoreCase("addToCart")){
				
				String codiceMerce = request.getParameter("codiceMerce");
				CartBean cart = (CartBean)request.getSession().getAttribute("cart");
				
				if(cart==null){
					cart= new CartBean();
				}
				
				MerceBean merceToCart = new MerceBean();
				

				try {
					merceToCart = model.searchMerceByCodiceMerce(codiceMerce);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				cart.addMerceBean(merceToCart);
				request.getSession().setAttribute("cart", cart);

				RequestDispatcher rd = (RequestDispatcher) getServletContext().getRequestDispatcher("/MerceOpUser?action=showlist");
				rd.forward(request, response);
				
			} else if(action.equalsIgnoreCase("emptyCart")){
				
				request.getSession().removeAttribute("cart");
				CartBean cart = new CartBean();
				request.getSession().setAttribute("cart", cart);

				RequestDispatcher rd = (RequestDispatcher) getServletContext().getRequestDispatcher("/cart.jsp");
				rd.forward(request, response);
				
			} else if(action.equals("deleteFromCart")){
				
				CartBean cart = (CartBean) request.getSession().getAttribute("cart");
				String codiceMerce = request.getParameter("codiceMerce");	
				
				try {
					MerceBean merce= model.searchMerceByCodiceMerce(codiceMerce);
					cart.deleteMerceBean(merce);
					request.getSession().setAttribute("cart", cart);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				RequestDispatcher rd = (RequestDispatcher) getServletContext().getRequestDispatcher("/cart.jsp");
				rd.forward(request, response);
				
			} else if(action.equalsIgnoreCase("searchFor")){
				
				String opzione= (String) request.getParameter("campoServer");
				String userText= (String) request.getParameter("campoUtente");
				Collection<MerceBean> collection = new LinkedList<MerceBean>();
				CartBean cart = (CartBean)request.getSession().getAttribute("cart");
				
				if(cart == null){
					cart = new CartBean();
				}
				
				if(userText.equals("") || userText == null){
					try {
						collection = model.getAllMerce(null,numberPage);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				else {
					try {
						if(opzione.equalsIgnoreCase("codice")) {
							collection.add(model.searchMerceByCodiceMerce(userText));
						}
						else if (opzione.equalsIgnoreCase("categoria")){
								collection = model.searchMerceByCategoria(userText,numberPage);	
						} 
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				request.setAttribute("collection", collection);
				request.getSession().setAttribute("cart", cart);
				RequestDispatcher rd = (RequestDispatcher) getServletContext().getRequestDispatcher("/shop.jsp");
				rd.forward(request, response);
			} else if(action.equalsIgnoreCase("showlistbygen")){

				String genere = request.getParameter("genere");
				
				Collection <MerceBean> collection = new LinkedList<MerceBean>();
				
				try {
					if(genere != null){
							collection = model.searchMerceByCategoria(genere,numberPage);
						
					} else {
						collection = null;
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.setAttribute("collection", collection);
				RequestDispatcher rd = (RequestDispatcher) getServletContext().getRequestDispatcher("/shop.jsp");
				rd.forward(request, response);
			} else if(action.equalsIgnoreCase("showlistbytitolo")){

				String titolo = request.getParameter("titolo");
				
				Collection <MerceBean> collection = new LinkedList<MerceBean>();
				
				try {
					if(titolo != null){
							collection = model.searchMerceByTitolo(titolo,numberPage);
					} else {
						collection = model.getAllMerce(null,numberPage);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.setAttribute("collection", collection);
				RequestDispatcher rd = (RequestDispatcher) getServletContext().getRequestDispatcher("/shop.jsp");
				rd.forward(request, response);
			}
		}	
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
			doGet(request, response);
	
	}
	
}
