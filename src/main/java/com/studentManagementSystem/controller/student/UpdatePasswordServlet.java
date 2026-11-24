package com.studentManagementSystem.controller.student;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.studentManagementSystem.dao.StudentDAO;
import com.studentManagementSystem.model.StudentBean;

@WebServlet("/update-password")
public class UpdatePasswordServlet extends HttpServlet {
    static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if(session == null || !"STUDENT".equals(session.getAttribute("role"))){
            res.sendRedirect(req.getContextPath()+"/login.jsp");
            return;
        }
        req.getRequestDispatcher("/Student/update-password.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if(session == null || !"STUDENT".equals(session.getAttribute("role"))){
            res.sendRedirect(req.getContextPath()+"/login.jsp");
            return;
        }

        
        StudentBean studentBean = (StudentBean) session.getAttribute("student");
        if(studentBean == null){
            res.sendRedirect(req.getContextPath()+"/login.jsp");
            return;
        }
        long studentId = studentBean.getId();

        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if(newPassword == null || !newPassword.equals(confirmPassword)){
            req.setAttribute("error", "New password & Confirm password Not matched!");
            req.getRequestDispatcher("/Student/update-password.jsp").forward(req, res);
            return;
        }
        if(newPassword.length() < 6){
            req.setAttribute("error", "Password must contain minimum 6 character!");
            req.getRequestDispatcher("/Student/update-password.jsp").forward(req, res);
            return;
        }

        StudentDAO dao = new StudentDAO();

   
        String dbPassword = dao.getPasswordById(studentId);
        if(dbPassword == null || !dbPassword.equals(currentPassword)){
            req.setAttribute("error", "Current password galat hai!");
            req.getRequestDispatcher("/Student/update-password.jsp").forward(req, res);
            return;
        }

       
        boolean updated = dao.updatePassword(studentId, newPassword);
        if(updated){
            session.setAttribute("passUpdated", "yes");
            res.sendRedirect(req.getContextPath()+"/Student/update-password.jsp");
        }else{
            req.setAttribute("error", "Password can't updated, dobara try again!");
            req.getRequestDispatcher("/Student/update-password.jsp").forward(req, res);
        }
    }
}