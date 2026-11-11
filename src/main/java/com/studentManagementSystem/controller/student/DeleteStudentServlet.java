package com.studentManagementSystem.controller.student;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studentManagementSystem.dao.StudentDAO;
import com.studentManagementSystem.model.StudentBean;


@WebServlet("/DeleteStudent")
public class DeleteStudentServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        int result = new StudentDAO().deleteStudentById(id);
        
        req.setAttribute("deleted", true);
        req.setAttribute("studentList", new StudentDAO().getAllStudents()); // ya jo list dikhani hai
        req.getRequestDispatcher("/Admin/display-student.jsp").forward(req, resp);
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}

