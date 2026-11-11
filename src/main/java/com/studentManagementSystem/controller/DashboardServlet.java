//package com.studentManagementSystem.controller;
//
//import java.io.IOException;
//import java.util.ArrayList;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.studentManagementSystem.dao.StudentDAO;
//import com.studentManagementSystem.model.StudentBean;
//
//@WebServlet("/Dashboard")
//public class DashboardServlet extends HttpServlet {
//    /**
//	 * 
//	 */
//	private static final long serialVersionUID = 1L;
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        StudentDAO sd = new StudentDAO();
//        
//        ArrayList<StudentBean> studentList = sd.getAllStudents();
//        int totalStudents = sd.getTotalStudentCount(); // ye line nayi hai
//        
//        request.setAttribute("studentList", studentList);
//        request.setAttribute("totalStudents", totalStudents); // ye bhi nayi
//        
//        RequestDispatcher rd = request.getRequestDispatcher("admin-pannel.jsp");
//        rd.forward(request, response);
//    }
//}