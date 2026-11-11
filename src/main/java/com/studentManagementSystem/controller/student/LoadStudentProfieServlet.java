package com.studentManagementSystem.controller.student;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
	            int id = Integer.parseInt(request.getParameter("id"));
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
	            
	            

	            request.getRequestDispatcher("student-profile.jsp").forward(request, response);
	        } catch(Exception e){
	            e.printStackTrace();
	        }
	    }
	}