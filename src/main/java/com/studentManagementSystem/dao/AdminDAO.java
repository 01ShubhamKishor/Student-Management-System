package com.studentManagementSystem.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import com.studentManagementSystem.model.AdminBean;
import com.studentManagementSystem.utils.DBconnection;

public class AdminDAO {

	//Get All Admin
 public ArrayList<AdminBean> getAllAdmin()
 {
	 ArrayList<AdminBean> list = new ArrayList<>();
	    String query = "SELECT ID, USER_NAME,EMAIL,ADDRESS,CONTACT,DOB,ACTIVE FROM admin_detail";
	   
	    try(Connection con = DBconnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(query);
	        ResultSet rs = ps.executeQuery();) {
	        
	        while(rs.next()) {
	            AdminBean Adminbean = new AdminBean();
	            Adminbean.setId(rs.getLong("ID"));
	            Adminbean.setUser_name(rs.getString("USER_NAME"));
	            Adminbean.setEmail(rs.getString("EMAIL"));
	            Adminbean.setAddress(rs.getString("ADDRESS"));
	            Adminbean.setContact(rs.getString("CONTACT"));
	            Adminbean.setActive(rs.getBoolean("ACTIVE"));
	            if(rs.getDate("DOB") != null) {
	                Adminbean.setDob(rs.getDate("DOB").toLocalDate());
	            }
	           
	            
	            list.add(Adminbean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } 
	    return list;
	}
 //Add Admin
 public boolean addAdmin(AdminBean s) {
	    String query = "INSERT INTO admin_detail (USER_NAME,EMAIL,PASSWORD,ROLE,ADDRESS,CONTACT,DOB,ACTIVE) VALUES (?,?,?,?,?,?,?,?)";
	    try(Connection con=DBconnection.getConnection();
	        PreparedStatement ps=con.prepareStatement(query)) {
	        ps.setString(1, s.getUser_name());
	        ps.setString(2, s.getEmail());
	        ps.setString(3, s.getPassword());
	        ps.setString(4, s.getRole());
	        ps.setString(5, s.getAddress());
	        ps.setString(6, s.getContact());
	        ps.setDate(7, java.sql.Date.valueOf(s.getDob()));
	        ps.setBoolean(8, s.getActive());
	       
	        
//	        ps.setBoolean(6, s.getActive());
	      
	       
	        return ps.executeUpdate() > 0;
	    } catch(Exception e){ e.printStackTrace(); }
	    return false;
	}
 
  //Delete Admin
 public int deleteAdinById(Long id)  {
	   
	   int result=0;
  	    String sql = "DELETE FROM admin_detail WHERE id = ?";
  	   
  	    try(Connection con= DBconnection.getConnection();
  	    	PreparedStatement ps=con.prepareStatement(sql);)
  	    {
  	    	ps.setLong(1,id);
	    	 result=ps.executeUpdate();
  	    	
  	    } catch (ClassNotFoundException | SQLException e) {
				
				e.printStackTrace();
			}
  	
  	
  	return result;
  }
 
 
	// updateAdminByAdmin
	public int updateAdmin(Long id ,String user_name, String email, String password, String role, LocalDate dob, String address, String contact, boolean active ) {
	    int result = 0;
	    String query = "UPDATE admin_detail SET USER_NAME=?, EMAIL=?, PASSWORD=?, ROLE=?, DOB=?, ADDRESS=?, CONTACT=? , ACTIVE=? WHERE ID=?";
	    try (Connection con = DBconnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query)) {
	        ps.setString(1, user_name);
	        ps.setString(2, email);
	        ps.setString(3, password);
	        ps.setString(4, "ADMIN");
	        ps.setDate(5, java.sql.Date.valueOf(dob));
	        ps.setString(6, address);
	        ps.setString(7, contact);  
	        ps.setBoolean(8, active);
	        ps.setLong(9, id);
	        result = ps.executeUpdate();
	        System.out.println("Updated rows: " + result);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	
	// getStudentById FIXED
	public AdminBean getAdminById(long id) {
	    AdminBean sb = null;
	    String query = "SELECT * from admin_detail WHERE ID=?";
	    try(Connection con = DBconnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(query);
	    ) {
	        ps.setLong(1, id);
	        ResultSet rs = ps.executeQuery();
	        if(rs.next()) {
	            sb = new AdminBean();
	            sb.setId(rs.getLong("ID"));
	            sb.setUser_name(rs.getString("USER_NAME"));
	            sb.setEmail(rs.getString("EMAIL"));
	            sb.setPassword(rs.getString("PASSWORD"));
	            sb.setRole(rs.getString("ROLE"));
	            sb.setAddress(rs.getString("ADDRESS"));
		        sb.setContact(rs.getString("CONTACT"));
		        sb.setActive(rs.getBoolean("ACTIVE"));
	            if(rs.getDate("DOB") != null) {
	                sb.setDob(rs.getDate("DOB").toLocalDate());
	            }

	           
	           
	
	        }
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    } 
	    return sb;
	}

 

}
