package com.studentManagementSystem.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.studentManagementSystem.dao.FeeDAO;
import com.studentManagementSystem.model.FeeBean;

@WebServlet("/AddFee")
public class AddFeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            String courseCode = request.getParameter("courseCode");
            int totalFee = Integer.parseInt(request.getParameter("totalFee"));
            int paidFee = Integer.parseInt(request.getParameter("paidFee"));
            int dueFee = Integer.parseInt(request.getParameter("dueFee"));
            String paymentMode = request.getParameter("paymentMode");
            String paymentDate = request.getParameter("paymentDate");

            FeeBean fee = new FeeBean();
            fee.setStudentId(studentId);
            fee.setCourseCode(courseCode);
            fee.setTotalFee(totalFee);
            fee.setPaidFee(paidFee);
            fee.setDueFee(dueFee);
            fee.setPaymentDate(paymentDate);
            fee.setPaymentMode(paymentMode);

            int result = new FeeDAO().addFee(fee);

            if (result > 0) {
                // TERA SERVLET /Reports HAI, ISLIYE YAHI PE REDIRECT
                response.sendRedirect(request.getContextPath() + "/Reports?msg=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/Reports?msg=fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Reports?msg=error");
        }
    }
}