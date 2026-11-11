package com.studentManagementSystem.controller.student;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.studentManagementSystem.dao.StudentDAO;
import com.studentManagementSystem.model.StudentBean;

@WebServlet("/LoadEditStudent")
public class LoadEditStudentFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        try {
            String idParam = request.getParameter("id");
            if(idParam == null || idParam.trim().isEmpty()){
                response.sendRedirect(request.getContextPath()+"/GetAllStudents?msg=invalidId");
                return;
            }

            Long id = Long.parseLong(idParam);
            StudentDAO sd = new StudentDAO();
            StudentBean updateStudent = sd.getStudentById(id);
            
            if(updateStudent != null) {
                // Session nahi, request pe bhejo - tera course_code getter sahi kaam karega
                request.setAttribute("ustudent", updateStudent);
                request.getRequestDispatcher("Admin/edit-student.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath()+"/GetAllStudents?msg=notfound");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()+"/GetAllStudents?msg=invalidId");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()+"/GetAllStudents?msg=error");
        }
	}
}