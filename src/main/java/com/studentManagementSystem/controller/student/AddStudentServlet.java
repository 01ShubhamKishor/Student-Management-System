package com.studentManagementSystem.controller.student;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studentManagementSystem.dao.CourseDAO;
import com.studentManagementSystem.dao.FeeDAO;
import com.studentManagementSystem.dao.StudentDAO;
import com.studentManagementSystem.model.CourseBean;
import com.studentManagementSystem.model.FeeBean;
import com.studentManagementSystem.model.StudentBean;

@MultipartConfig
@WebServlet("/AddStudent")
public class AddStudentServlet extends HttpServlet {
	  private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        try {
	            String full_name = request.getParameter("full_name");
	            String roll_no = request.getParameter("roll_no");
	            String phone = request.getParameter("phone");
	            String email = request.getParameter("email");
	            String course_code = request.getParameter("course_code"); 
	            String semester = request.getParameter("semester");
	            String address = request.getParameter("address");
	            String dobstr = request.getParameter("dob");
	            LocalDate dob = LocalDate.parse(dobstr);
	            
	            StudentDAO sd = new StudentDAO();
	            StudentBean sBean = new StudentBean();
	            sBean.setFull_name(full_name);
	            sBean.setRoll_number(roll_no);
	            sBean.setEmail(email);
	            sBean.setPhone(phone);
	            sBean.setDob(dob);
	            sBean.setCourse_code(course_code);
	            sBean.setSemester(semester);
	            sBean.setAddress(address);
	            sBean.setActive(true);
	            sBean.setStatus("ACTIVE");
	            sBean.setRole("STUDENT");
	            sBean.setAdmissionYear(LocalDate.now().getYear());
	            sBean.setPassword("LMS1234");

	            boolean added = sd.addStudent(sBean); 

	            if(added) {
	                Long id = sd.getUserIdByEmailAndRoll(email, roll_no);
	                HttpSession session = request.getSession();
	                session.setAttribute("totalStudents", sd.getTotalStudentCount());
	                session.setAttribute("totalActiveStudentCount", sd.getActiveStudentCount());
	                request.setAttribute("added", true);
	                // Profile pe bhej de
	                response.sendRedirect(request.getContextPath() + "/LoadStudenProfile?id=" + id);
	            } else {
	                request.setAttribute("error", "Student add nahi hua");
	                request.getRequestDispatcher("Admin/addStudent.jsp").forward(request, response);
	            }
	        } catch(Exception e){
	            e.printStackTrace();
	        }
	    }
	}