package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.*;

@WebServlet("/OrdersOperations")
public class OrdersOperations extends HttpServlet {
	private static final long serialVersionUID = 1L;

	OrdineCliente model = new OrdineCliente();

	public OrdersOperations() {
		super();
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		CartBean cart = (CartBean) request.getSession().getAttribute("cart");
		boolean userLog = (boolean) request.getSession().getAttribute("userlog");

		if(userLog){
			if((action!= null)&&(!action.equals(""))){

				if(action.equalsIgnoreCase("insert")){			
					double totalCart=this.getTotal(cart.getCart());
					int nMerci=cart.getCart().size();
					String dataOdierna=this.getDataOdierna();
					String mezzo=request.getParameter("mezzo");
					String metodoDiPagamento=request.getParameter("metodoDiPagamento");
					String numCard=request.getParameter("numCard");
					String radiochoice=request.getParameter("radiochoice");
					String citta;
					String via;
					String civico;
					String cap;

					OrderBean newOrder = new OrderBean();
					newOrder.setDataOrdine(dataOdierna);
					newOrder.setMezzo(mezzo);
					newOrder.setnMerci(nMerci);
					newOrder.setTotale(totalCart);
					newOrder.setMetodoDiPagamento(metodoDiPagamento);
					newOrder.setNumCard(numCard);
					UserBean user = (UserBean)request.getSession().getAttribute("user");
					newOrder.setCfCliente(user.getCfUtente());

					if(radiochoice.equals("diverso")) {
						citta=request.getParameter("citta");
						if (citta==null) citta=user.getCitta();
						via=request.getParameter("via");
						if (via==null) via=user.getVia();
						civico=request.getParameter("ncivico");
						if (civico==null) civico=""+user.getNCivico();
						cap=request.getParameter("cap");
						if (cap==null) cap=""+user.getCap();
						user=new UserBean();
						user.setCfUtente("0000000000000000");
						user.setCitta(citta);
						user.setVia(via);
						user.setNCivico(Integer.parseInt(civico));
						user.setCap(Integer.parseInt(cap));
						try {
							model.insertNewOrder(newOrder,user);
							request.getSession().setAttribute("cart", new CartBean());
							RequestDispatcher rd=request.getRequestDispatcher("orderCompleted.jsp");  
							rd.forward(request,response);
						} catch (SQLException e) {
							e.printStackTrace();
						}
					} else {
						try {
							model.insertNewOrder(newOrder,user);
							request.getSession().setAttribute("cart", new CartBean());
							RequestDispatcher rd=request.getRequestDispatcher("orderCompleted.jsp");  
							rd.forward(request,response);
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
				} else if(action.equalsIgnoreCase("cancelByID")) {
					int codice=Integer.parseInt(request.getParameter("id"));
					try {
						model.deleteOrder(codice);
						RequestDispatcher rd=request.getServletContext().getRequestDispatcher("/orderCanceled.jsp");  
						rd.forward(request,response);
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();	
					}
				} else if(action.equalsIgnoreCase("searchByUser")){
					Collection<OrderBean> allOrdersByUser;
					UserBean user = (UserBean) request.getSession().getAttribute("user");

					try {
						allOrdersByUser=model.searchByCFUser(user.getCfUtente());
						request.setAttribute("allOrdersByUser", allOrdersByUser);
						RequestDispatcher rd=request.getRequestDispatcher("myOrders.jsp");  
						rd.forward(request,response);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} else {
					RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
					rd.forward(request,response);
				}
			} else {
				RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
				rd.forward(request,response);
			}
		} else {
			// l' utente non è loggato non può utilizzare la servlet
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}


	private String getDataOdierna(){
		Calendar dataodierna = Calendar.getInstance(); 
		// rilevo data 
		int mese_int = dataodierna.get(Calendar.MONTH);
		int anno_int = dataodierna.get(Calendar.YEAR);
		int giorno_int = dataodierna.get(Calendar.DAY_OF_MONTH);	
		String mese = new String(""+mese_int);
		String anno = new String(""+anno_int);
		String giorno = new String(""+giorno_int);

		return anno+"-"+mese+"-"+giorno;
	}

	private double getTotal(List<?> cart){
		double total=0;

		MerceBean merce=new MerceBean();


		for(int i=0; i<cart.size();i++){
			merce=(MerceBean)cart.get(i); 

			total = total + merce.getCosto();

		}

		return total;
	}

}
