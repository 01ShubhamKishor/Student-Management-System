package com.studentManagementSystem.controller.student;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
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



@WebServlet("/LoadStudenProfile")
public class LoadStudentProfieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        try {
	            Long id = Long.parseLong(request.getParameter("id"));
	            
	            
	            
	            StudentDAO sDao = new StudentDAO();
	            FeeDAO fDao = new FeeDAO();
	            CourseDAO cDao = new CourseDAO();

	            StudentBean student = sDao.getStudentById(id);
	            CourseBean course = cDao.getCourseByCode(student.getCourse_code());
	            
	            int courseFee = 50000;
	            if(course != null && course.getFee() > 0){
	                courseFee = course.getFee();
	            }

	            List<FeeBean> feeHistory = fDao.getFeeByStudentId(id);
	            int totalPaid = 0;
	            for(FeeBean f : feeHistory) totalPaid += f.getPaidFee();
	            
	            int dueFee = courseFee - totalPaid;
	            if(dueFee < 0) dueFee = 0;

	            request.setAttribute("student", student);
	            request.setAttribute("course", course);
	            request.setAttribute("feeHistory", feeHistory);
	            request.setAttribute("paidFee", totalPaid);
	            request.setAttribute("courseTotalFee", courseFee);
	            request.setAttribute("dueFee", dueFee);
	            
	            
                //manage student profile from both student and admin
	            HttpSession session=request.getSession();
	             
	            
	            if(session ==null || session.getAttribute("adminRole")==null && session.getAttribute("role")==null){
	            	response.sendRedirect(request.getContextPath()+"/login.jsp");
	            	return;
	            }
	            String adminrole=(String)session.getAttribute("adminRole");
	            String studentrole=(String)session.getAttribute("role");
	            
	            if("ADMIN".equals(adminrole) || "SUPER_ADMIN".equals(adminrole))
	            {
	            	request.getRequestDispatcher("student-profile.jsp").forward(request, response);
	            }
	            if("STUDENT".equals(studentrole))
	            {
	            	request.getRequestDispatcher("/Student/student-profile.jsp").forward(request, response);
	            }
	            else {
	            	response.sendRedirect(request.getContextPath()+"/login.jsp");
	            }
	            
	            	
	            	
	            
	         
	            
	        } catch(Exception e){
	            e.printStackTrace();
	        }
	    }
	}