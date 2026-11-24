package com.studentManagementSystem.controller.student;

import java.io.IOException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.studentManagementSystem.dao.FeeDAO;
import com.studentManagementSystem.model.FeeBean;

@WebServlet("/student-fee-report")
public class StudentFeeReportServlet extends HttpServlet {
    static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if(session == null || !"STUDENT".equals(session.getAttribute("role"))){
            res.sendRedirect(req.getContextPath()+"/login.jsp");
            return;
        }

       
        Long studentId = null;

        // taking from student and calling getId method for getting student id 
        //try to store studentBean and then call the method for getId 
        if(studentId == null && session.getAttribute("student") != null){
            try{
                Object s = session.getAttribute("student");
                Object sid = s.getClass().getMethod("getId").invoke(s);
                if(sid != null){
                    studentId = ((Number) sid).longValue();
                }
            }catch(Exception e){ e.printStackTrace(); }
        }

        if(studentId == null){
            res.sendRedirect(req.getContextPath()+"/login.jsp");
            return;
        }
       

        FeeDAO dao = new FeeDAO();
        List<FeeBean> feeHistory = dao.getFeeByStudentId(studentId);

        int totalFee = 0, paidFee = 0, dueFee = 0;
        Map<String,Integer> modeWise = new HashMap<>();
        Map<String,Integer> monthWise = new LinkedHashMap<>();
        String lastPaymentDate = "-";
        String lastMode = "-";

        if(!feeHistory.isEmpty()){
            totalFee = feeHistory.get(0).getTotalFee();
            lastPaymentDate = feeHistory.get(0).getPaymentDate();
            lastMode = feeHistory.get(0).getPaymentMode();
        }
        for(FeeBean f : feeHistory){
            paidFee += f.getPaidFee();
            String mode = f.getPaymentMode() == null ? "UNKNOWN" : f.getPaymentMode().toUpperCase();
            modeWise.put(mode, modeWise.getOrDefault(mode, 0) + f.getPaidFee());
            if(f.getPaymentDate() != null && f.getPaymentDate().length() >= 7){
                String month = f.getPaymentDate().substring(0,7);
                monthWise.put(month, monthWise.getOrDefault(month, 0) + f.getPaidFee());
            }
            dueFee = f.getDueFee();
        }
        if(dueFee < 0) dueFee = 0;
        if(totalFee == 0) totalFee = paidFee + dueFee;

        int percent = totalFee > 0 ? (paidFee * 100 / totalFee) : 0;

        req.setAttribute("feeHistory", feeHistory);
        req.setAttribute("courseTotalFee", totalFee);
        req.setAttribute("paidFee", paidFee);
        req.setAttribute("dueFee", dueFee);
        req.setAttribute("percent", percent);
        req.setAttribute("modeWise", modeWise);
        req.setAttribute("monthWise", monthWise);
        req.setAttribute("lastPaymentDate", lastPaymentDate);
        req.setAttribute("lastMode", lastMode);
        req.setAttribute("totalInstallments", feeHistory.size());

        req.getRequestDispatcher("/Student/student-fee-report.jsp").forward(req, res);
    }
}