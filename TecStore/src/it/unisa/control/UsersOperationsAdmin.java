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




@WebServlet(name="UsersOperationsAdmin" ,urlPatterns="/UsersOpAdmin")

public class UsersOperationsAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String SAVE_DIR="";
	static Cliente model;


	public UsersOperationsAdmin() {
		super();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=(String)request.getParameter("action");
		model= new Cliente();
		String numberPageString =(String)request.getParameter("numberPage");
		if(numberPageString==null||numberPageString==""){
			numberPageString="1";
		}

		int numberPage = Integer.parseInt(numberPageString);

		if(numberPage<1){
			numberPage=1;
		}

		/*Controllo lato admin*/
		if(action!=null){
			if(action.equalsIgnoreCase("showlist")){

				try {
					Collection<UserBean> collection= model.getUsers(numberPage);
					request.setAttribute("collection", collection);
				} catch (SQLException e1) {
					e1.printStackTrace();
				}

				RequestDispatcher rd= getServletContext().getRequestDispatcher("/userManagement.jsp");
				rd.forward(request, response);
			} else if(action.equalsIgnoreCase("delete")){
				String cf  = request.getParameter("cf");
				UserBean user = (UserBean) request.getSession().getAttribute("user");
				if(user.getTipo().equalsIgnoreCase("Amministratore")) {
					try {
						model.deleteUser(cf);
						RequestDispatcher rd= getServletContext().getRequestDispatcher("/deleteUserCompleted.jsp");
						rd.forward(request, response);
					} catch (SQLException e) {
						e.printStackTrace();
					}	
				}
			} else if(action.equalsIgnoreCase("showlistbycodice")){
				String email=request.getParameter("email");
				Collection <UserBean> collection = new LinkedList<UserBean>();

				try {
					if(email != null){
						UserBean utente= model.searchUser(email);
						if(utente.getEmail()!="")	collection.add(utente);
					}

				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.setAttribute("collection", collection);
				RequestDispatcher rd= getServletContext().getRequestDispatcher("/userManagement.jsp");
				rd.forward(request, response);
			} else if(action.equalsIgnoreCase("redirectForUpdate")){

				String cf= request.getParameter("cf");

				try {
					UserBean user = model.searchUser(cf);
					request.getSession().setAttribute("utente", user);
					/*Redirect alla pagina di modifica*/
					RequestDispatcher rd= getServletContext().getRequestDispatcher("/updateUser.jsp");
					rd.forward(request, response);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if(action.equalsIgnoreCase("update")){
				UserBean user = new UserBean();
				String cf = request.getParameter("cf");
				String rank=request.getParameter("rank");
				user.setCfUtente(cf);
				user.setRank(rank);

				try {
					model.updateUserRank(user);
					RequestDispatcher rd = request.getRequestDispatcher("/updateUserCompleted.jsp");
					rd.forward(request, response);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}


}
