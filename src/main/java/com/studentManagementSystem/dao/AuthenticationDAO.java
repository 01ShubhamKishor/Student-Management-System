package com.studentManagementSystem.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.studentManagementSystem.model.AdminBean;
import com.studentManagementSystem.model.StudentBean;
import com.studentManagementSystem.utils.DBconnection;

public class AuthenticationDAO {
      
	//this method return admin bean if that criteria setisfy
	  public AdminBean validateAdmin(String email,String password) throws ClassNotFoundException, SQLException {
		   
		  AdminBean adminbean=null;
		  
		  //create connection
		
		
		  //query to get result
		  String query="select id,user_name,email,password,role,address,contact,dob from admin_detail where email=? and password=?";
		   
		  try(Connection con= DBconnection.getConnection();
			  PreparedStatement ps=con.prepareStatement(query);)
		  {
			
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next())
			{
			    adminbean=new AdminBean();
				adminbean.setId(rs.getLong(1));
				adminbean.setUser_name(rs.getString(2));
				adminbean.setEmail(rs.getString(3));
				adminbean.setPassword(rs.getString(4));
				adminbean.setRole(rs.getString(5));
				adminbean.setAddress(rs.getString(6));
				adminbean.setContact(rs.getString(7));
				adminbean.setDob(rs.getDate(8).toLocalDate()); // <-- DOB ke liye ye
			}
		} catch (SQLException e) {
			System.out.print("SQL exception");
			e.printStackTrace();
		}
		  
		return adminbean;
		  
	  }
	  
	//this method return student bean if that criteria setisfy
	  public StudentBean validateStudent(String email,String password) throws ClassNotFoundException, SQLException {
		   
		  StudentBean sb=null;
		
		  //query to get result
		  String query="SELECT ID, FULL_NAME, ROLL_NUMBER, EMAIL, PHONE, DOB, COURSE_CODE, SEMESTER, ADDRESS, ACTIVE, ROLE, PASSWORD, ADMISSION_YEAR, STATUS FROM student_details where EMAIL=? and PASSWORD=?";
		  try(Connection con= DBconnection.getConnection(); //create connection
			  PreparedStatement ps=con.prepareStatement(query);) 
		  {
			
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs=ps.executeQuery(); // executing Query
			
			if(rs.next())
			{
				sb=new StudentBean();
				sb.setId(rs.getLong("ID"));
				sb.setFull_name(rs.getString("FULL_NAME"));
				sb.setRoll_number(rs.getString("ROLL_NUMBER"));
				sb.setEmail(rs.getString("EMAIL"));
				sb.setPhone(rs.getString("PHONE"));
				sb.setDob(rs.getDate("DOB").toLocalDate());
				sb.setCourse_code(rs.getString("COURSE_CODE"));
				sb.setSemester(rs.getString("SEMESTER"));
				sb.setAddress(rs.getString("ADDRESS"));
				sb.setActive(rs.getBoolean("ACTIVE"));
				sb.setRole(rs.getString("ROLE"));
				sb.setPassword(rs.getString("PASSWORD"));
				
				
				sb.setAdmissionYear(rs.getInt("ADMISSION_YEAR")); // <-- NEW
				sb.setStatus(rs.getString("STATUS"));             // <-- NEW
			    
			}
		} catch (SQLException e) {
			System.out.print("SQL exception");
			e.printStackTrace();
		}
		  
		return sb;
		  
	  }
	  
	

}
