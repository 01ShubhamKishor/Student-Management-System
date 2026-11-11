package com.studentManagementSystem.dao;
import java.sql.*;
import java.util.*;

import com.studentManagementSystem.model.FeeBean;
import com.studentManagementSystem.utils.DBconnection;

public class FeeDAO {


 // Course Wise Report - FINAL FIXED
    public List<Map<String, Object>> getCourseWiseFeeReportFixed() {
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            Connection con = DBconnection.getConnection();
            String sql = "SELECT c.COURSE_CODE, c.COURSE as COURSE_NAME, c.FEE as COURSE_FEE, " +
                         "COUNT(DISTINCT s.ID) as total_students, " +
                         "COALESCE(SUM(f.PAID_FEE),0) as total_collected " +
                         "FROM course_detail c " +
                         "LEFT JOIN student_details s ON s.COURSE_CODE = c.COURSE_CODE " +
                         "LEFT JOIN fee f ON f.STUDENT_ID = s.ID " +
                         "GROUP BY c.COURSE_CODE, c.COURSE, c.FEE";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Map<String, Object> map = new HashMap<>();
                int courseFee = rs.getInt("COURSE_FEE");
                int totalStudents = rs.getInt("total_students");
                int collected = rs.getInt("total_collected");
                
                // Sahi Due Calculation
                int totalExpected = totalStudents * courseFee;
                int due = totalExpected - collected;

                map.put("courseName", rs.getString("COURSE_NAME"));
                map.put("courseCode", rs.getString("COURSE_CODE"));
                map.put("courseFee", courseFee);
                map.put("totalStudents", totalStudents);
                map.put("collected", collected);
                map.put("due", due); // Ab ye sahi ayega
                list.add(map);
            }
            con.close();
        } catch(Exception e){ e.printStackTrace(); }
        return list;
    }

    public List<FeeBean> getFeeByStudentId(int studentId) {
        List<FeeBean> list = new ArrayList<>();
        try {
            Connection con = DBconnection.getConnection();
            String sql = "SELECT * FROM fee WHERE STUDENT_ID=? ORDER BY ID DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                FeeBean f = new FeeBean();
                f.setId(rs.getInt("ID"));
                f.setStudentId(rs.getInt("STUDENT_ID"));
                f.setCourseCode(rs.getString("COURSE_CODE"));
                f.setTotalFee(rs.getInt("TOTAL_FEE"));
                f.setPaidFee(rs.getInt("PAID_FEE"));
                f.setDueFee(rs.getInt("DUE_FEE"));
                f.setPaymentDate(rs.getString("PAYMENT_DATE"));
                f.setPaymentMode(rs.getString("PAYMENT_MODE"));
                list.add(f);
            }
            con.close();
        } catch(Exception e){ e.printStackTrace(); }
        return list;
    }
    

    public List<Map<String, Object>> getDueFeeStudents() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.ID, s.FULL_NAME, s.COURSE_CODE, c.FEE as COURSE_FEE, " +
                     "COALESCE(SUM(f.PAID_FEE),0) as total_paid, " +
                     "(c.FEE - COALESCE(SUM(f.PAID_FEE),0)) as dueAmount " + // FIXED
                     "FROM student_details s " +
                     "JOIN course_detail c ON s.COURSE_CODE = c.COURSE_CODE " +
                     "LEFT JOIN fee f ON s.ID = f.STUDENT_ID " +
                     "GROUP BY s.ID, s.FULL_NAME, s.COURSE_CODE, c.FEE " +
                     "HAVING dueAmount > 0 ORDER BY dueAmount DESC";
        try(Connection con = DBconnection.getConnection(); 
            PreparedStatement ps = con.prepareStatement(sql); 
            ResultSet rs = ps.executeQuery()){
            while(rs.next()){
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getLong("ID"));
                map.put("full_name", rs.getString("FULL_NAME"));
                map.put("course_code", rs.getString("COURSE_CODE"));
                map.put("total_fee", rs.getInt("COURSE_FEE"));
                map.put("dueAmount", rs.getInt("dueAmount"));
                map.put("paid_fee", rs.getInt("total_paid"));
                list.add(map);
            }
        }catch(Exception e){ e.printStackTrace(); }
        return list;
    }

    public List<Map<String, Object>> getHighestDueTop10() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.ID, s.FULL_NAME, s.COURSE_CODE, c.FEE as COURSE_FEE, " +
                     "COALESCE(SUM(f.PAID_FEE),0) as total_paid, " +
                     "(c.FEE - COALESCE(SUM(f.PAID_FEE),0)) as dueAmount " + // FIXED
                     "FROM student_details s " +
                     "JOIN course_detail c ON s.COURSE_CODE = c.COURSE_CODE " +
                     "LEFT JOIN fee f ON s.ID = f.STUDENT_ID " +
                     "GROUP BY s.ID, s.FULL_NAME, s.COURSE_CODE, c.FEE " +
                     "HAVING dueAmount > 0 ORDER BY dueAmount DESC LIMIT 10";
        try(Connection con = DBconnection.getConnection(); 
            PreparedStatement ps = con.prepareStatement(sql); 
            ResultSet rs = ps.executeQuery()){
            while(rs.next()){
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getLong("ID"));
                map.put("full_name", rs.getString("FULL_NAME"));
                map.put("course_code", rs.getString("COURSE_CODE"));
                map.put("total_fee", rs.getInt("COURSE_FEE"));
                map.put("dueAmount", rs.getInt("dueAmount"));
                map.put("total_paid", rs.getInt("total_paid"));
                list.add(map);
            }
        }catch(Exception e){ e.printStackTrace(); }
        return list;
    }
    
    public int addFee(FeeBean fee) {
        String sql = "INSERT INTO fee (STUDENT_ID, COURSE_CODE, TOTAL_FEE, PAID_FEE, DUE_FEE, PAYMENT_DATE, PAYMENT_MODE) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, fee.getStudentId());
            ps.setString(2, fee.getCourseCode());
            ps.setInt(3, fee.getTotalFee());
            ps.setInt(4, fee.getPaidFee());
            ps.setInt(5, fee.getDueFee());
            ps.setString(6, fee.getPaymentDate()); // yyyy-MM-dd
            ps.setString(7, fee.getPaymentMode());
            
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
}