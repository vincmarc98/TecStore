package it.unisa.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import it.unisa.model.Cliente;
import it.unisa.model.UserBean;

@WebServlet("/CheckEmailAtSignup")
public class CheckEmailAtSignup extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	private static Cliente model=new Cliente();
	
    public CheckEmailAtSignup() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");

		out.write("Error: GET method is used but POST method is required");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject jsonObj = new JSONObject(request.getParameter("json"));
		JSONObject jsonResponse = new JSONObject(); //json da inviare nella response
		UserBean user = null;
				
		try {
			user = model.searchUser(jsonObj.getString("email"));
			
			if(user.getEmail()=="")
				jsonResponse.put("esito", true);
			else if (user.getEmail()!="")
				jsonResponse.put("esito", false);
			
		} catch (JSONException | SQLException e) {
			e.printStackTrace();
		}
		
		response.setContentType("application/json");
		response.getWriter().write(jsonResponse.toString());
	}

}
