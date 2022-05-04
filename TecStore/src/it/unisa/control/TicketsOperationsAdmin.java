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

import it.unisa.model.Ticket;
import it.unisa.model.TicketBean;


@WebServlet(name="/TicketsOperationsAdmin", urlPatterns="/TicketOpAdmin")
public class TicketsOperationsAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static Ticket model;
	
    public TicketsOperationsAdmin() {
        super();

    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		model = new Ticket();
		String action = request.getParameter("action");
		String numberPageString =(String)request.getParameter("numberPage");
		if(numberPageString==null||numberPageString==""){
			numberPageString="1";
		}
		
		int numberPage = Integer.parseInt(numberPageString);
		
		if(numberPage<1){
			numberPage=1;
		}
		
		boolean operatorLog = (boolean) request.getSession().getAttribute("operatorlog");
		
		if(operatorLog) {
			if((action!= null)&&(!action.equals(""))) {
				if (action.equalsIgnoreCase("showlist")){
					Collection<TicketBean> allTickets;
					try {
						allTickets=model.getAllTickets(numberPage);
						request.setAttribute("collection", allTickets);
						RequestDispatcher rd=request.getServletContext().getRequestDispatcher("/ticketmanagement.jsp");  
						rd.forward(request,response);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}  else if(action.equalsIgnoreCase("update")){
					
					int codiceticket = Integer.parseInt(request.getParameter("codiceticket"));
					String stato = request.getParameter("state");
					
					try {
						TicketBean ticket = model.searchTicketByCodiceTicket(codiceticket);
						ticket.setCodiceOrdine(codiceticket);
						ticket.setStato(stato);
						
						model.updateTicketState(ticket);
						RequestDispatcher rd = request.getRequestDispatcher("/updateTicketCompleted.jsp");
						rd.forward(request, response);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				} else if(action.equalsIgnoreCase("showlistbycodiceticket")){
					String codice= request.getParameter("codiceordine");
					Collection <TicketBean> collection = new LinkedList<TicketBean>();

					try {
						if(codice != null){
							TicketBean ticket= model.searchTicketByCodiceTicket(Integer.parseInt(codice));
							if(ticket.getCodiceTicket()!=0) collection.add(ticket);
							else collection=null;
						} else {
							collection=null;
						}

					} catch (SQLException e) {
						e.printStackTrace();
					}
					request.setAttribute("collection", collection);
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/ticketmanagement.jsp");
					rd.forward(request, response);
				} else if(action.equalsIgnoreCase("showlistbycodicefiscale")){
					String codice= request.getParameter("codicefiscale");
					Collection <TicketBean> collection = new LinkedList<TicketBean>();

					try {
						if(codice != null){
							collection = model.searchTicketsByCf(codice, numberPage);
						} else {
							collection=null;
						}

					} catch (SQLException e) {
						e.printStackTrace();
					}
					request.setAttribute("collection", collection);
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/ticketmanagement.jsp");
					rd.forward(request, response);
				}
			}
			else {
				// l'utente non è un'operatore quindi non può utilizzare la servlet
				RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
				rd.forward(request,response);
			}		
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
