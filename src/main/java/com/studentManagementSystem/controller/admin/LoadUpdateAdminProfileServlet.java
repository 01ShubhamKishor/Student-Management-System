package com.studentManagementSystem.controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studentManagementSystem.dao.AdminDAO;
import com.studentManagementSystem.model.AdminBean;

/**
 * Servlet implementation class LoadUpdateAdminServlet
 */
@WebServlet("/LoadUpdateAdminProfile")
public class LoadUpdateAdminProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		 String idParm = request.getParameter("id");
	        if(idParm == null || idParm.equals("null") || idParm.isEmpty()){
	            // session se backup
	            Object sid = request.getSession().getAttribute("adminId");
	            if(sid != null) idParm = sid.toString();
	        }
	        Long id = Long.parseLong(idParm.trim());
	        AdminDAO ad = new AdminDAO();
	        AdminBean uAdmin = ad.getAdminById(id);
	        request.setAttribute("UAdmin", uAdmin);
	        request.getRequestDispatcher("/Admin/edit-admin.jsp").forward(request, response);
	    }
	
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
