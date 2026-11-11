package com.studentManagementSystem.controller.course;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studentManagementSystem.dao.CourseDAO;
import com.studentManagementSystem.model.CourseBean;



@WebServlet("/AddCourse")
public class AddCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    String course_code=request.getParameter("course_code");
		String course=request.getParameter("course");
		String department=request.getParameter("department");
		int fee= Integer.parseInt(request.getParameter("fee"));
		
		int duration_year=Integer.parseInt(request.getParameter("duration_year"));
		int total_semester=Integer.parseInt(request.getParameter("total_semester"));
		String description=request.getParameter("description");
		
		boolean active=Boolean.parseBoolean(request.getParameter("active"));
		
		CourseDAO cd=new CourseDAO();
		CourseBean cs=new CourseBean();
		cs=cd.addCourse(course_code, course, department, duration_year, total_semester, fee, description, active);
		
		if(cs != null) 
		{
		    request.setAttribute("course", cs);
		    request.setAttribute("added", true); 
		    request.getRequestDispatcher("course-profile.jsp").forward(request, response);
		}
		else {
			System.out.print("course not added");
		}
	}
}
