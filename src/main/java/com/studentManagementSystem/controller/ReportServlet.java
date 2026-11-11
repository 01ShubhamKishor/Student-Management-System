package com.studentManagementSystem.controller;

import com.studentManagementSystem.dao.FeeDAO;
import com.studentManagementSystem.dao.StudentDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/Reports")
public class ReportServlet extends HttpServlet {
   
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        FeeDAO feeDao = new FeeDAO();
        StudentDAO studentDao = new StudentDAO();
        
        List<Map<String, Object>> courseReport = feeDao.getCourseWiseFeeReportFixed();
        List<Map<String, Object>> dueStudents = feeDao.getDueFeeStudents();
        List<Map<String, Object>> topDueStudents = feeDao.getHighestDueTop10();
        
        // Ye naya add kiya - searchable form ke liye
        List<Map<String, Object>> allStudents = studentDao.getAllStudentsWithCourseFee();
        
        request.setAttribute("courseReport", courseReport);
        request.setAttribute("dueStudents", dueStudents);
        request.setAttribute("topDueStudents", topDueStudents);
        request.setAttribute("allStudents", allStudents);
        
        System.out.println("Course: "+courseReport.size() + " Due: "+dueStudents.size() + " TopDue: "+topDueStudents.size() + " AllStudents: "+allStudents.size());
        
        RequestDispatcher rd = request.getRequestDispatcher("Admin/report.jsp");
        rd.forward(request, response);
    }
}