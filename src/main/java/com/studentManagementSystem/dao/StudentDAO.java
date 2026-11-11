package com.studentManagementSystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.studentManagementSystem.model.StudentBean;
import com.studentManagementSystem.utils.DBconnection;

public class StudentDAO {

	//Get All Student completed - YE SAHI HAI, ISKO Aise hi rehne de
	public ArrayList<StudentBean> getAllStudents() {
	    ArrayList<StudentBean> list = new ArrayList<>();
	    String query = "SELECT s.ID, s.FULL_NAME, s.ROLL_NUMBER, s.EMAIL, s.PHONE, s.DOB, " +
	                   "s.COURSE_CODE, s.SEMESTER, s.ADDRESS, s.ACTIVE, s.ADMISSION_YEAR, s.STATUS " +
	                   "FROM student_details s ORDER BY s.ID DESC";
	    try(Connection con = DBconnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(query);
	        ResultSet rs = ps.executeQuery();) {
	        
	        while(rs.next()) {
	            StudentBean studentbean = new StudentBean();
	            studentbean.setId(rs.getLong("ID"));
	            studentbean.setFull_name(rs.getString("FULL_NAME"));
	            studentbean.setRoll_number(rs.getString("ROLL_NUMBER"));
	            studentbean.setEmail(rs.getString("EMAIL"));
	            studentbean.setPhone(rs.getString("PHONE"));
	            if(rs.getDate("DOB") != null) {
	                studentbean.setDob(rs.getDate("DOB").toLocalDate());
	            }
	            studentbean.setCourse_code(rs.getString("COURSE_CODE"));
	            studentbean.setSemester(rs.getString("SEMESTER"));
	            studentbean.setAddress(rs.getString("ADDRESS"));
	            studentbean.setActive(rs.getBoolean("ACTIVE"));
	            studentbean.setAdmissionYear(rs.getInt("ADMISSION_YEAR"));
	            studentbean.setStatus(rs.getString("STATUS"));
	            
	            list.add(studentbean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } 
	    return list;
	}

	// 2. Saare Active Students - FIXED (TOTAL_FEE hata diya)
	public ArrayList<StudentBean> getAllActiveStudents() {
	    ArrayList<StudentBean> list = new ArrayList<>();
	    String query = "SELECT ID, FULL_NAME, ROLL_NUMBER, EMAIL, PHONE, DOB, COURSE_CODE, SEMESTER, ADDRESS, ACTIVE, ADMISSION_YEAR, STATUS, ROLE, PASSWORD FROM student_details WHERE STATUS='ACTIVE'";
	    try (Connection con = DBconnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {
	        
	        while (rs.next()) {
	            StudentBean s = new StudentBean();
	            s.setId(rs.getLong("ID"));
	            s.setFull_name(rs.getString("FULL_NAME"));
	            s.setRoll_number(rs.getString("ROLL_NUMBER"));
	            s.setEmail(rs.getString("EMAIL"));
	            s.setPhone(rs.getString("PHONE"));
	            if(rs.getDate("DOB") != null) {
	                s.setDob(rs.getDate("DOB").toLocalDate());
	            }
	            s.setCourse_code(rs.getString("COURSE_CODE"));
	            s.setSemester(rs.getString("SEMESTER"));
	            s.setAddress(rs.getString("ADDRESS"));
	            s.setActive(rs.getBoolean("ACTIVE"));
	            s.setAdmissionYear(rs.getInt("ADMISSION_YEAR"));
	            s.setStatus(rs.getString("STATUS"));
	            s.setRole(rs.getString("ROLE"));
	            s.setPassword(rs.getString("PASSWORD"));
	            // s.setTotal_fee(rs.getInt("TOTAL_FEE")); // HATA DIYA - ab fee table se ayega
	            list.add(s);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	    
	// Adding new Student - FIXED for COURSE_CODE (TOTAL_FEE hata diya)
	public boolean addStudent(StudentBean s) {
	    String query = "INSERT INTO student_details (FULL_NAME, ROLL_NUMBER, EMAIL, PHONE, DOB, COURSE_CODE, SEMESTER, ADDRESS, ACTIVE, PASSWORD, ROLE, ADMISSION_YEAR, STATUS) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
	    try(Connection con=DBconnection.getConnection();
	        PreparedStatement ps=con.prepareStatement(query)) {
	        ps.setString(1, s.getFull_name());
	        ps.setString(2, s.getRoll_number());
	        ps.setString(3, s.getEmail());
	        ps.setString(4, s.getPhone());
	        ps.setDate(5, java.sql.Date.valueOf(s.getDob()));
	        ps.setString(6, s.getCourse_code());
	        ps.setString(7, s.getSemester());
	        ps.setString(8, s.getAddress());
	        ps.setBoolean(9, s.getActive());
	        ps.setString(10, s.getPassword());
	        ps.setString(11, s.getRole());
	        ps.setInt(12, s.getAdmissionYear());
	        ps.setString(13, s.getStatus());
	        return ps.executeUpdate() > 0;
	    } catch(Exception e){ e.printStackTrace(); }
	    return false;
	}

	// getStudentById FIXED
	public StudentBean getStudentById(long id) {
	    StudentBean sb = null;
	    String query = "SELECT * from student_details WHERE ID=?";
	    try(Connection con = DBconnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(query);
	    ) {
	        ps.setLong(1, id);
	        ResultSet rs = ps.executeQuery();
	        if(rs.next()) {
	            sb = new StudentBean();
	            sb.setId(rs.getLong("ID"));
	            sb.setFull_name(rs.getString("FULL_NAME"));
	            sb.setRoll_number(rs.getString("ROLL_NUMBER"));
	            sb.setEmail(rs.getString("EMAIL"));
	            sb.setPhone(rs.getString("PHONE"));
	            if(rs.getDate("DOB") != null) {
	                sb.setDob(rs.getDate("DOB").toLocalDate());
	            }
	            sb.setCourse_code(rs.getString("COURSE_CODE"));
	            sb.setSemester(rs.getString("SEMESTER"));
	            sb.setAddress(rs.getString("ADDRESS"));
	            sb.setActive(rs.getBoolean("ACTIVE"));
	            sb.setRole(rs.getString("ROLE"));
	            sb.setPassword(rs.getString("PASSWORD"));
	            sb.setAdmissionYear(rs.getInt("ADMISSION_YEAR"));
	            sb.setStatus(rs.getString("STATUS"));
	            // TOTAL_FEE nahi lena
	        }
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    } 
	    return sb;
	}

	public Long getUserIdByEmailAndRoll(String email, String rollNumber) {
	    Long userId = null;
	    String query = "SELECT ID FROM student_details WHERE EMAIL = ? AND ROLL_NUMBER = ?";
	    try (Connection con = DBconnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query)) {
	        ps.setString(1, email);
	        ps.setString(2, rollNumber);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            userId = rs.getLong("ID");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return userId;
	}

	// updateStudentByAdmin FIXED - total_fee param hata diya
	public int updateStudentByAdmin(Long id ,String full_name, String roll_number, String email, String phone, LocalDate dob, String course_code, String semester, String address, boolean active, String password ,int admissionYear,String status ) {
	    int result = 0;
	    String query = "UPDATE student_details SET FULL_NAME=?, ROLL_NUMBER=?, EMAIL=?, PHONE=?, DOB=?, COURSE_CODE=?, SEMESTER=?, ADDRESS=?, ACTIVE=?, PASSWORD=?, ADMISSION_YEAR=?, STATUS=? WHERE ID=?";
	    try (Connection con = DBconnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query)) {
	        ps.setString(1, full_name);
	        ps.setString(2, roll_number);
	        ps.setString(3, email);
	        ps.setString(4, phone);
	        ps.setDate(5, java.sql.Date.valueOf(dob));
	        ps.setString(6, course_code);
	        ps.setString(7, semester);
	        ps.setString(8, address);
	        ps.setBoolean(9, active);
	        ps.setString(10, password);
	        ps.setInt(11, admissionYear);
	        ps.setString(12, status);     
	        ps.setLong(13, id);
	        result = ps.executeUpdate();
	        System.out.println("Updated rows: " + result);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}

	// getting overall collected money - FIXED (ab fee table se)
	public long getTotalFeecollected() {
	    long total = 0;
	    String query = "SELECT SUM(PAID_FEE) AS total FROM fee";
	    try (Connection con = DBconnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {
	        if (rs.next()) {
	            total = rs.getLong("total");
	        }
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    }
	    return total;
	}
    
     
   //delete student
   public int deleteStudentById(Long id) {
	    Connection con = null;
	    PreparedStatement ps1 = null;
	    PreparedStatement ps2 = null;
	    int result = 0;
	    try {
	        con = DBconnection.getConnection();
	        con.setAutoCommit(false); // transaction start

	        // 1. Pehle child table - fee delete karo
	        ps1 = con.prepareStatement("DELETE FROM fee WHERE STUDENT_ID = ?");
	        ps1.setLong(1, id);
	        ps1.executeUpdate();

	        // 2. Phir parent table - student delete karo
	        ps2 = con.prepareStatement("DELETE FROM student_details WHERE ID = ?");
	        ps2.setLong(1, id);
	        result = ps2.executeUpdate();

	        con.commit(); // dono ho gaye to save

	    } catch (Exception e) {
	        try { if(con != null) con.rollback(); } catch(Exception ex){}
	        e.printStackTrace();
	    } finally {
	        try { if(ps1 != null) ps1.close(); } catch(Exception e){}
	        try { if(ps2 != null) ps2.close(); } catch(Exception e){}
	        try { if(con != null) con.close(); } catch(Exception e){}
	    }
	    return result;
	}
   
	 // Get Active Students COUNT
   public int getActiveStudentCount() {
       int count = 0;
       String query = "SELECT COUNT(*) FROM student_details WHERE STATUS='ACTIVE'";
       try (Connection con = DBconnection.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery()) {
           if (rs.next()) {
               count = rs.getInt(1);
           }
       } catch (Exception e) {
           e.printStackTrace();
       }
       return count;
   }
   
   
	// Get Total count of Student
	public int getTotalStudentCount() {
	    int count = 0;
	    String query = "SELECT COUNT(*) FROM student_details";
	    try (Connection con = DBconnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}
	
	 // Get Passout Students COUNT
	public int getPassoutStudentCount() {
	    int count = 0;
	    String query = "SELECT COUNT(*) FROM student_details WHERE STATUS='PASSOUT'";
	    try (Connection con = DBconnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}
	

	public int getDropoutStudentCount() {
	    try {
	        Connection con = DBconnection.getConnection();
	        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM student_details WHERE STATUS='DROPOUT'");
	        ResultSet rs = ps.executeQuery();
	        if(rs.next()) return rs.getInt(1);
	    } catch(Exception e){ e.printStackTrace(); }
	    return 0;
	}
	
	public List<Map<String, Object>> getAllStudentsWithCourseFee(){
	    List<Map<String, Object>> list = new ArrayList<>();
	    String sql = "SELECT s.ID, s.FULL_NAME, s.COURSE_CODE, c.FEE as COURSE_FEE FROM student_details s JOIN course_detail c ON s.COURSE_CODE = c.COURSE_CODE ORDER BY s.ID DESC";
	    try(Connection con = DBconnection.getConnection(); 
	        PreparedStatement ps = con.prepareStatement(sql); 
	        ResultSet rs = ps.executeQuery()){
	        while(rs.next()){
	            Map<String, Object> m = new HashMap<>();
	            m.put("ID", rs.getInt("ID"));
	            m.put("FULL_NAME", rs.getString("FULL_NAME"));
	            m.put("COURSE_CODE", rs.getString("COURSE_CODE"));
	            m.put("COURSE_FEE", rs.getInt("COURSE_FEE"));
	            list.add(m);
	        }
	    }catch(Exception e){ e.printStackTrace(); }
	    return list;
	}
    
    
    
}

