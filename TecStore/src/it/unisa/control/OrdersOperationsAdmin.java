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


@WebServlet(name="/OrdersOperationsAdmin", urlPatterns="/OrdineOpAdmin")
public class OrdersOperationsAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	static OrdineCliente model;
	
    public OrdersOperationsAdmin() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		model = new OrdineCliente();
		String action = request.getParameter("action");
		String numberPageString =(String)request.getParameter("numberPage");
		if(numberPageString==null||numberPageString==""){
			numberPageString="1";
		}
		
		int numberPage = Integer.parseInt(numberPageString);
		
		if(numberPage<1){
			numberPage=1;
		}
		
		boolean adminLog = (boolean) request.getSession().getAttribute("adminlog");
		boolean userLog = (boolean) request.getSession().getAttribute("userlog");
		
		if(userLog||adminLog){
			if((action!= null)&&(!action.equals(""))){
				
				if(action.equalsIgnoreCase("delete")){
					int code = Integer.parseInt(request.getParameter("codiceOrdine"));
					try {
						model.deleteOrder(code);
						RequestDispatcher rd=request.getServletContext().getRequestDispatcher("/ordermanagement.jsp");  
						rd.forward(request,response);
					} catch (SQLException e) {
						e.printStackTrace();	
					}
				} else if (action.equalsIgnoreCase("showlist")){
					Collection<OrderBean> allOrders;
					try {
						allOrders=model.getAllOrders(numberPage);
						request.setAttribute("collection", allOrders);
						RequestDispatcher rd=request.getServletContext().getRequestDispatcher("/ordermanagement.jsp");  
						rd.forward(request,response);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				} else if(action.equalsIgnoreCase("update")){
					
					OrderBean order = new OrderBean();
					int codiceordine = Integer.parseInt(request.getParameter("codiceordine"));
					String stato = request.getParameter("state");
					order.setCodiceOrdine(codiceordine);
					order.setStato(stato);

					try {
						model.updateOrderState(order);
						RequestDispatcher rd = request.getRequestDispatcher("/updateOrderCompleted.jsp");
						rd.forward(request, response);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				} else if(action.equalsIgnoreCase("showlistbycodiceordine")){
					String codice= request.getParameter("codiceordine");
					Collection <OrderBean> collection = new LinkedList<OrderBean>();

					try {
						if(codice != null){
							OrderBean ordine= model.searchByCodeOrder(Integer.parseInt(codice));
							if(ordine.getCodiceOrdine()!=0)	collection.add(ordine);
							else collection=null;
						} else {
							collection=null;
						}

					} catch (SQLException e) {
						e.printStackTrace();
					}
					request.setAttribute("collection", collection);
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/ordermanagement.jsp");
					rd.forward(request, response);
				} else if(action.equalsIgnoreCase("showlistbycodicefiscale")){
					String codice= request.getParameter("codicefiscale");
					Collection <OrderBean> collection = new LinkedList<OrderBean>();

					try {
						if(codice != null){
							collection = model.searchByCFUser(codice);
						} else {
							collection=null;
						}

					} catch (SQLException e) {
						e.printStackTrace();
					}
					request.setAttribute("collection", collection);
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/ordermanagement.jsp");
					rd.forward(request, response);
				}
			}	
		}
		else {
			// l' utente non è loggato quindi non può utilizzare la servlet
			RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
			rd.forward(request,response);
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
