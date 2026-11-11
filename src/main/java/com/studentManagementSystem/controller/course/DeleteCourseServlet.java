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

@WebServlet("/DeleteCourse")
public class DeleteCourseServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        Long id = Long.parseLong(request.getParameter("id"));
        
        CourseDAO cd = new CourseDAO();
        int result = cd.deleteCourseById(id);
         
        if(result > 0) {
            // Fresh list DB se
            ArrayList<CourseBean> courses = cd.getAllCourses();
            
            // --- YAHAN FIX KIYA - Ek hi call me count ---
            int[] counts = cd.getCourseCounts();
            
            HttpSession session = request.getSession();
            session.setAttribute("courses", courses);
            session.setAttribute("totalCourses", counts[0]);
            session.setAttribute("activeCourses", counts[1]);
            session.setAttribute("inactiveCourses", counts[0] - counts[1]);
                
            response.sendRedirect(request.getContextPath() + "/courses");
        } else {
            System.out.print("not deleted");
            response.sendRedirect(request.getContextPath() + "/Admin/course.jsp?error=notdeleted");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/courses");
    }
}