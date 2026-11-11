package com.studentManagementSystem.controller.admin;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studentManagementSystem.dao.AdminDAO;
import com.studentManagementSystem.model.AdminBean;


@WebServlet("/DeleteAdmin")
public class DeleteAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Long id = Long.parseLong(request.getParameter("id"));
		AdminDAO ad = new AdminDAO();
		int result = ad.deleteAdinById(id);
		
		ArrayList<AdminBean> list = ad.getAllAdmin();
		request.setAttribute("adminList", list);
		
		// POPUP KE LIYE - Yahi kaam karega
		request.setAttribute("deleted", true);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Admin/admin.jsp");
		rd.forward(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // GET se aaye to bhi POST wala logic chala do - error mat de
	    doPost(request, response);
	}

}
