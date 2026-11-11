package com.studentManagementSystem.controller.admin;


import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.studentManagementSystem.dao.AdminDAO;
import com.studentManagementSystem.model.AdminBean;

@WebServlet("/Admin")
public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminDAO dao = new AdminDAO();
        ArrayList<AdminBean> adminList = dao.getAllAdmin();
        request.setAttribute("adminList", adminList);
        request.getRequestDispatcher("Admin//admin.jsp").forward(request, response);
    }

}
