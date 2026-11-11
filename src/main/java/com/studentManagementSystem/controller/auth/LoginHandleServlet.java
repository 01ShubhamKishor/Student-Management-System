package com.studentManagementSystem.controller.auth;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studentManagementSystem.dao.AuthenticationDAO;
import com.studentManagementSystem.dao.CourseDAO;
import com.studentManagementSystem.dao.StudentDAO;
import com.studentManagementSystem.model.AdminBean;
import com.studentManagementSystem.model.StudentBean;

@WebServlet("/login")
public class LoginHandleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if(email == null || password == null || email.trim().isEmpty()) {
            request.setAttribute("errorMsg", "Email and password required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        AuthenticationDAO authDao = new AuthenticationDAO();
        try {
            // Admin check - SUPER_ADMIN + ADMIN dono allow
            AdminBean adminBean = authDao.validateAdmin(email, password);
            if (adminBean != null) {
                String role = adminBean.getRole();
                if ("ADMIN".equals(role) || "SUPER_ADMIN".equals(role)) {
                    
                    StudentDAO sd = new StudentDAO();
                    CourseDAO cd = new CourseDAO();
                    
                    // --- Ek hi call me Course counts ---
                    int[] courseCounts = cd.getCourseCounts();

                    HttpSession session = request.getSession();
                    session.setAttribute("admin", adminBean);
                    session.setAttribute("role", role);
                    session.setAttribute("adminId", adminBean.getId());
                    session.setAttribute("adminRole", role);
                    session.setAttribute("adminName", adminBean.getUser_name());
                    
                    
                    
                    // Dashboard ke liye bas ye 7 chahiye
                    session.setAttribute("totalStudents", sd.getTotalStudentCount());
                    session.setAttribute("totalActiveStudentCount", sd.getActiveStudentCount());
                    session.setAttribute("totalCourses", courseCounts[0]);
                    session.setAttribute("activeCourses", courseCounts[1]);
                    session.setAttribute("inactiveCourses", courseCounts[0] - courseCounts[1]);
                    session.setAttribute("totalFeecollected", sd.getTotalFeecollected());
                    session.setAttribute("passoutCount", sd.getPassoutStudentCount());
                    System.out.print("Admin id from login servlet"+adminBean.getId());
                    response.sendRedirect("Admin/admin-pannel.jsp");
                    return;
                }
            }

            // Student check
            StudentBean studentBean = authDao.validateStudent(email, password);
            if (studentBean != null && "STUDENT".equals(studentBean.getRole())) {
                HttpSession session = request.getSession();
                session.setAttribute("student", studentBean);
                session.setAttribute("role", studentBean.getRole());
                session.setAttribute("studentId", studentBean.getId());
                response.sendRedirect("Student/student-dashboard.jsp");
                return;
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error, try again later");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        request.setAttribute("errorMsg", "details are incorrect");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}