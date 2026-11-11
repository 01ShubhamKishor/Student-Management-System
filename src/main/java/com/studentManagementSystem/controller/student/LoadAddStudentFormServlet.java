package com.studentManagementSystem.controller.student;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.studentManagementSystem.utils.DBconnection;

@WebServlet("/LoadAddServlet")
public class LoadAddStudentFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> courseList = new ArrayList<>();
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT COURSE_CODE, COURSE, DEPARTMENT, DURATION_YEAR, TOTAL_SEMESTER, FEE FROM course_detail WHERE ACTIVE=1 ORDER BY COURSE"
             );
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("COURSE_CODE", rs.getString("COURSE_CODE"));
                map.put("COURSE", rs.getString("COURSE"));
                map.put("DEPARTMENT", rs.getString("DEPARTMENT"));
                map.put("DURATION_YEAR", String.valueOf(rs.getInt("DURATION_YEAR")));
                // YE SABSE IMPORTANT HAI - TOTAL_SEMESTER DIRECT TABLE SE
                map.put("TOTAL_SEMESTER", String.valueOf(rs.getInt("TOTAL_SEMESTER")));
                map.put("FEE", String.valueOf(rs.getInt("FEE")));
                courseList.add(map);
            }
            System.out.println("Found " + courseList.size() + " courses");

        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("courseList", courseList);
        request.getRequestDispatcher("Admin/addStudent.jsp").forward(request, response);
    }
}