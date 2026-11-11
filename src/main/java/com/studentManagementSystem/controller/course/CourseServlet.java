package com.studentManagementSystem.controller.course;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studentManagementSystem.dao.CourseDAO;
import com.studentManagementSystem.model.CourseBean;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        CourseDAO dao = new CourseDAO();
        ArrayList<CourseBean> courses = dao.getAllCourses();
        
        // --- NEW - Ek hi call me sab ---
        int[] counts = dao.getCourseCounts();
        int total = counts[0];
        int active = counts[1];
        int inactive = total - active;
        
        HttpSession session = request.getSession();
        session.setAttribute("courses", courses);
        session.setAttribute("totalCourses", total);
        session.setAttribute("activeCourses", active);
        session.setAttribute("inactiveCourses", inactive); // ye naya add kiya
        
        request.getRequestDispatcher("Admin/course.jsp").forward(request, response);
    }
}
