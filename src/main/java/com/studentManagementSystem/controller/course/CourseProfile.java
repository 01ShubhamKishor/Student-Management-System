package com.studentManagementSystem.controller.course;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studentManagementSystem.dao.CourseDAO;
import com.studentManagementSystem.model.CourseBean;


@WebServlet("/CourseProfile")
public class CourseProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	 Long id=Long.parseLong(request.getParameter("id"));
	 
	 if(id!= null)
	 {
		 CourseDAO cd=new CourseDAO();
		  CourseBean courseBean=cd.getCourseById(id);
		  
		  request.setAttribute("course", courseBean);
		  request.getRequestDispatcher("course-profile.jsp").forward(request, response);
				 
	 }
	 
	       
	 
	 
	}

}
