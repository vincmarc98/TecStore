package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.*;


@WebServlet("/UserOperations")
public class UserOperations extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static Cliente model=new Cliente();
	
	public UserOperations() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if((action!= null)&&(!action.equals(""))){
			if(action.equalsIgnoreCase("insert")){
				request.getSession().setAttribute("adminlog", false);
				request.getSession().setAttribute("userlog", false);
				request.getSession().setAttribute("operatorlog", false);
				request.getSession().setAttribute("assistenzalog", false);
				String codicefiscale=request.getParameter("codicefiscale");
				
				codicefiscale.toUpperCase();
				String nome=request.getParameter("nome");
				String cognome=request.getParameter("cognome");
				String email=request.getParameter("email");
				String password=request.getParameter("password");
				String citta=request.getParameter("citta");
				String via=request.getParameter("via");
				int ncivico=Integer.parseInt(request.getParameter("ncivico"));
				int cap=Integer.parseInt(request.getParameter("cap"));
				String rank=""+"Cliente";


				UserBean newUser= new UserBean();

				newUser.setCfUtente(codicefiscale.toUpperCase());
				newUser.setNome(nome);
				newUser.setCognome(cognome);
				newUser.setEmail(email);
				newUser.setPass(password);
				newUser.setCitta(citta);
				newUser.setVia(via);
				newUser.setCap(cap);
				newUser.setNCivico(ncivico);
				newUser.setRank(rank);

				try {
					model.insertUser(newUser);
					newUser=model.searchUser(codicefiscale.toUpperCase());
					request.getSession().setAttribute("user", newUser);
					request.getSession().setAttribute("userlog", false);
	
					response.sendRedirect(request.getContextPath() + "/successful.jsp");
				} catch (SQLException e) {
					request.getSession().setAttribute("error","Il codice fiscale o l'email sono già presenti nel sistema");
					RequestDispatcher rd=request.getRequestDispatcher("/registration.jsp");  
					rd.forward(request,response); 
				}
			}

			else if(action.equalsIgnoreCase("login")){	
				String email=request.getParameter("email");
				String password=request.getParameter("password");
				UserBean user = new UserBean();
				try {
					user=model.searchUser(email);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				//se l'utente esiste... controllo se le password coincidono
				if(!(user.getCfUtente().equals("0000000000000000"))){
					if(user.getPass().equals(password)){
						request.getSession().setAttribute("user", user);
						request.getSession().setAttribute("userlog", true);

						//controllo se è amministratore
						if(user.getTipo().equals("Amministratore")){
							request.getSession().setAttribute("adminlog", true);
						}
						else{
							request.getSession().setAttribute("adminlog", false);
						}
						
						//controllo se è operatore
						if(user.getTipo().equals("Operatore")){
							request.getSession().setAttribute("operatorlog", true);
						}
						else{
							request.getSession().setAttribute("operatorlog", false);
						}
						
						RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");  
						rd.forward(request,response);
					}
					else{
						request.getSession().setAttribute("userlog", false);
						request.getSession().setAttribute("adminlog", false);		
						request.getSession().setAttribute("errPass", true);
						request.getSession().setAttribute("refresh", true);
						RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");  
						rd.forward(request,response);
					}
				}


				//nessun user con quel id trovato
				else{
					request.getSession().setAttribute("userlog", false);
					request.getSession().setAttribute("adminlog", false);
					request.getSession().setAttribute("operatorlog", false);
					request.getSession().setAttribute("errUser", true);
					request.getSession().setAttribute("refresh", true);
					RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");  
					rd.forward(request,response); 
				}

			}

			else if (action.equalsIgnoreCase("delete")){
				boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
				boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
				UserBean user = (UserBean) request.getSession().getAttribute("user");
				if(adminlog==false){
					if(userlog==true){
						try {
							model.deleteUser(user.getEmail());
							request.getSession().setAttribute("userlog", false);
							request.getSession().setAttribute("adminlog", false);
							request.getSession().setAttribute("user", new UserBean());
							request.getSession().invalidate();
						} catch (SQLException e) {
							//cancellazione non riuscita
							RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
							rd.forward(request,response); 
							e.printStackTrace();
						}
					}
					else{
						RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
						rd.forward(request,response); 
					}
				}
				else{
					RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
					rd.forward(request,response); 
				}
			} else if (action.equalsIgnoreCase("logout")){

				request.getSession().setAttribute("user", new UserBean());
				request.getSession().setAttribute("userlog", false);
				request.getSession().setAttribute("adminlog", false);
				request.getSession().setAttribute("operatorlog", false);
				request.getSession().invalidate();
				RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
				rd.forward(request,response); 

			} else if(action.equalsIgnoreCase("updatePassword")){
			
				UserBean user = (UserBean) request.getSession().getAttribute("user");

				String oldPassword=request.getParameter("oldPass");
				String newPassword=request.getParameter("newPass");
				String rePassword=request.getParameter("rePass");

				if(oldPassword!=null && oldPassword.equals(user.getPass())){
					if(newPassword!=null && newPassword.equals(rePassword)){
						user.setPass(newPassword);
						try {
							model.updateUserPass(user);	
							request.getSession().setAttribute("ok", "Password modificata");
							RequestDispatcher rd= getServletContext().getRequestDispatcher("/myaccount.jsp");  
							rd.forward(request,response);
						} catch (SQLException e) {
							e.printStackTrace();
						}
					} else {
						request.getSession().setAttribute("error", "Le due password non coincidono");
						RequestDispatcher rd= getServletContext().getRequestDispatcher("/myaccount.jsp");  
						rd.forward(request, response);
					}
				} else if(oldPassword!=null && !(oldPassword.equals(user.getPass()))) {
					request.getSession().setAttribute("error", "La vecchia password non è corretta");
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/myaccount.jsp");  
					rd.forward(request, response);
				}
			} else if(action.equalsIgnoreCase("update")){
				boolean userlog = (Boolean) request.getSession().getAttribute("userlog");
				boolean adminlog = (Boolean) request.getSession().getAttribute("adminlog");
				UserBean user = (UserBean) request.getSession().getAttribute("user");

				String citta=request.getParameter("citta");
				String via=request.getParameter("via");
				int cap=Integer.parseInt(request.getParameter("cap"));
				int ncivico=Integer.parseInt(request.getParameter("ncivico"));


				if(userlog==true||adminlog==true){
					if(citta==null||citta.equals("")){citta=user.getCitta();}
					if(via==null||via.equals("")){via=user.getVia();}
					if(cap==0) {cap=user.getCap();}
					if(ncivico==0){ncivico=user.getNCivico();}

					user.setCitta(citta);
					user.setVia(via);
					user.setCap(cap);
					user.setNCivico(ncivico);


					try {
						model.updateUser(user);	
						request.getSession().setAttribute("ok", "Dati modificati con successo");
						RequestDispatcher rd= getServletContext().getRequestDispatcher("/myaccount.jsp"); 
						rd.forward(request,response);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				} else{
					RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
					rd.forward(request,response);
				}
			} else{
				RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
				rd.forward(request,response);
			}
		} else{
			// action è uguale a null oppure a "" 
			RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
			rd.forward(request,response); 
		}
		
	}
}
