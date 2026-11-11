package com.studentManagementSystem.controller.admin;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studentManagementSystem.dao.AdminDAO;
import com.studentManagementSystem.model.AdminBean;

@WebServlet("/AddAdmin")
public class AddAdminServlet extends HttpServlet {
	  
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AdminBean bean = new AdminBean();
        bean.setUser_name(req.getParameter("user_name"));
        bean.setEmail(req.getParameter("email"));
        bean.setPassword(req.getParameter("password"));
        bean.setRole("ADMIN");
        bean.setAddress(req.getParameter("address"));
        bean.setContact(req.getParameter("contact"));
        bean.setDob(LocalDate.parse(req.getParameter("dob")));
        bean.setActive(Boolean.parseBoolean(req.getParameter("active")));

        new AdminDAO().addAdmin(bean);
        
        // POPUP KE LIYE SESSION ME SET KARO
        req.getSession().setAttribute("added", true);
        resp.sendRedirect("Admin"); // ye tera Admin list page hai
    }
}


