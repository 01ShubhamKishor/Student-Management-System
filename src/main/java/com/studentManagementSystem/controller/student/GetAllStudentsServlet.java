package com.studentManagementSystem.controller.student;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studentManagementSystem.dao.StudentDAO;
import com.studentManagementSystem.model.StudentBean;

@WebServlet("/GetAllStudents")
public class GetAllStudentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  

	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        ArrayList<StudentBean> list = new ArrayList<>();
	        StudentDAO sd = new StudentDAO();
	        list = sd.getAllStudents();
	        
	        

	        request.setAttribute("studentList", list);
	        RequestDispatcher rd = request.getRequestDispatcher("/Admin/display-student.jsp");
	        rd.forward(request, response);
	    }
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        doGet(request, response);
	    }

}
