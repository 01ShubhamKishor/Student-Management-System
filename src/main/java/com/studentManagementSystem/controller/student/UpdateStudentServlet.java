package com.studentManagementSystem.controller.student;

import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.studentManagementSystem.dao.StudentDAO;
import com.studentManagementSystem.model.StudentBean;

@WebServlet("/UpdateStudent")
public class UpdateStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    try {
            String full_name = request.getParameter("FULL_NAME");
            String roll_no = request.getParameter("ROLL_NUMBER");
            String phone = request.getParameter("PHONE");
            String email = request.getParameter("EMAIL");
            
            String course_code = request.getParameter("COURSE_CODE");
            String semester = request.getParameter("SEMESTER");
            String address = request.getParameter("ADDRESS");
            
            String dobstr = request.getParameter("DOB");
            // int fee = Integer.parseInt(request.getParameter("TOTAL_FEE")); // HATA DIYA - ab fee table me hai
            String password = request.getParameter("PASSWORD");
            LocalDate dob = LocalDate.parse(dobstr);
            
            int admissionYear = Integer.parseInt(request.getParameter("ADMISSION_YEAR"));
            String status = request.getParameter("STATUS");
            
            if(admissionYear < 2000 || admissionYear > 2030){
                request.setAttribute("error", "Admission Year 2000-2030 ke beech hona chahiye");
                request.getRequestDispatcher("Admin/edit-student.jsp").forward(request, response);
                return;
            }
            
            Long id = Long.parseLong(request.getParameter("id"));
            
            StudentDAO sd = new StudentDAO();
        
            boolean active = "ACTIVE".equals(status);

            // DAO method - TOTAL_FEE param nahi bhejna ab
            int result = sd.updateStudentByAdmin(id, full_name, roll_no, email, phone, dob, course_code, semester, address, active, password, admissionYear, status); 
                
            StudentBean s = sd.getStudentById(id);
            request.setAttribute("student", s);
            request.setAttribute("updated", true); 
            request.getRequestDispatcher("student-profile.jsp").forward(request, response);	
        
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Update failed: "+e.getMessage());
            request.getRequestDispatcher("Admin/edit-student.jsp").forward(request, response);
        }
}}