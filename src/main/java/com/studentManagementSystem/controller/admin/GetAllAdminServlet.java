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


@WebServlet("/GetAllAdmin")
public class GetAllAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminDAO ad = new AdminDAO();
        ArrayList<AdminBean> list = ad.getAllAdmin();
        
        // YAHI FIX HAI - naam same rakhna hai JSP ke jaisa
        request.setAttribute("adminList", list); // pehle Adminlist tha
        
        RequestDispatcher rd = request.getRequestDispatcher("Admin/admin.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
