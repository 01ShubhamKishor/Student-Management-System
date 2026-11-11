package com.studentManagementSystem.controller.course;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studentManagementSystem.dao.CourseDAO;
import com.studentManagementSystem.dao.StudentDAO;
import com.studentManagementSystem.model.CourseBean;
import com.studentManagementSystem.model.StudentBean;

/**
 * Servlet implementation class EditCourseServlet
 */
@WebServlet("/LoadEditCourse")
public class LoadEditCourseFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
             Long id=Long.parseLong(request.getParameter("id"));
             
		
		
		
		CourseBean updateCourse=new CourseBean();
		
		CourseDAO sd=new CourseDAO();
		
		
		updateCourse =sd.getCourseById(id);
		
	    
	    if(updateCourse !=null)
	    {
	    HttpSession session= request.getSession();
	    session.setAttribute("ucourse", updateCourse);
	    
	     response.sendRedirect("Admin/edit-course.jsp");
	    }

	}
}
