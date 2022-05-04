package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.*;



/**
 * Servlet implementation class OrdersOperations
 */
@WebServlet("/TicketOperations")
public class TicketOperations extends HttpServlet {
	private static final long serialVersionUID = 1L;

	Ticket model = new Ticket();

	public TicketOperations() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		boolean userLog = (boolean) request.getSession().getAttribute("userlog");
	    String numberPageString =(String)request.getParameter("numberPage");
		if(numberPageString==null||numberPageString==""){
			numberPageString="1";
		}
		
		int numberPage = Integer.parseInt(numberPageString);

		if(userLog){
			if((action!= null)&&(!action.equals(""))){

				if(action.equalsIgnoreCase("insert")){			
					String titolo=request.getParameter("titolo");
					String descrizione=request.getParameter("descrizione");
					String stato="Aperto";
					int codiceOrdine=Integer.parseInt(request.getParameter("codice"));
					UserBean user=(UserBean) request.getSession().getAttribute("user");
					String cfCliente=user.getCfUtente();

					TicketBean newTicket = new TicketBean();
					newTicket.setTitolo(titolo);
					newTicket.setDescrizione(descrizione);
					newTicket.setStato(stato);
					newTicket.setCodiceOrdine(codiceOrdine);
					newTicket.setCodiceFiscale(cfCliente);

				
					try {
						model.insertNewticket(newTicket);
						RequestDispatcher rd=request.getRequestDispatcher("ticketCreated.jsp");  
						rd.forward(request,response);
					} catch (SQLException e) {
						e.printStackTrace();
					}
					request.getSession().setAttribute("error","Il codice ordine inserito non esiste");
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/supportTicket.jsp");  
					rd.forward(request, response);
				
				} else if(action.equalsIgnoreCase("searchOpenTicketsByUser")) {
					Collection<TicketBean>openTicketsByUser;
					UserBean user = (UserBean) request.getSession().getAttribute("user");
					try {
						openTicketsByUser=model.searchOpenTicketsByCf(user.getCfUtente(), numberPage);
						request.setAttribute("openTicketsByUser", openTicketsByUser);
						RequestDispatcher rd=request.getServletContext().getRequestDispatcher("/openTickets.jsp");  
						rd.forward(request,response);	
					} catch (SQLException e) {
						e.printStackTrace();	
					}
				} else if(action.equalsIgnoreCase("searchClosedTicketsByUser")){
					Collection<TicketBean> closedTicketsByUser;
					UserBean user = (UserBean) request.getSession().getAttribute("user");
					try {
						closedTicketsByUser=model.searchClosedTicketsByCf(user.getCfUtente(), numberPage);
						request.setAttribute("closedTicketsByUser", closedTicketsByUser);
						RequestDispatcher rd=request.getServletContext().getRequestDispatcher("/closedTickets.jsp");  
						rd.forward(request,response);	
					} catch (SQLException e) {
						e.printStackTrace();	
					}
				} else {
					RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
					rd.forward(request,response);
				}
			} else {
				// action è uguale a null oppure a ""
				RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
				rd.forward(request,response);
			}
		} else {
			// l' utente non è loggato non può utilizzare la servlet
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}
}
