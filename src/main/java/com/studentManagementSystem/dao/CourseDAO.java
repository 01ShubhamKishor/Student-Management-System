package com.studentManagementSystem.dao;


import java.util.ArrayList;
import com.studentManagementSystem.model.CourseBean;
import com.studentManagementSystem.utils.DBconnection;
import java.sql.*;

public class CourseDAO {

	// CourseDAO me ye ek hi method rakh
	public int[] getCourseCounts() {
	    int[] counts = new int[2]; // [0]=total, [1]=active
	    String query = "SELECT COUNT(*) as total, SUM(CASE WHEN Active = 1 THEN 1 ELSE 0 END) as active FROM course_detail";
	    try (Connection con = DBconnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(query);
	         ResultSet rs = ps.executeQuery()) {
	        if (rs.next()) {
	            counts[0] = rs.getInt("total");
	            counts[1] = rs.getInt("active");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return counts;
	}
	
	//get all course 
	public ArrayList<CourseBean> getAllCourses(){
		
	    ArrayList<CourseBean> list = new ArrayList<>();
	    
	    String sql = "SELECT * FROM course_detail ORDER BY Id DESC";
	    
	    try( Connection con = DBconnection.getConnection();
	       
	        PreparedStatement ps = con.prepareStatement(sql);) 
	    {
	       
	        ResultSet rs = ps.executeQuery();
	        while(rs.next()){
	            CourseBean bean = new CourseBean();
	            bean.setId(rs.getLong("ID"));
	            bean.setCourse_code(rs.getString("COURSE_CODE"));
	            bean.setCourse(rs.getString("COURSE"));
	            bean.setDepartment(rs.getString("DEPARTMENT"));
	            bean.setDuration_year(rs.getInt("DURATION_YEAR"));
	            bean.setTotal_semester(rs.getInt("TOTAL_SEMESTER"));
	            bean.setFee(rs.getInt("FEE"));
	            bean.setDescription(rs.getString("DESCRIPTION"));
	            bean.setActive(rs.getBoolean("ACTIVE"));
	            list.add(bean);
	        }
	        con.close();
	    } catch(Exception e){
	        e.printStackTrace();
	    }
	    return list;
	}
	

	
	//add course
	
	public CourseBean addCourse(String course_code, String course, String department, int duration_year, int total_semester, int fee, String description, boolean active) 
	{
	    String query = "INSERT INTO course_detail(COURSE_CODE, COURSE, DEPARTMENT, DURATION_YEAR, TOTAL_SEMESTER, FEE, DESCRIPTION, ACTIVE) VALUES (?,?,?,?,?,?,?,?)";
	    
	    try(Connection con = DBconnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
	        
	        ps.setString(1, course_code);
	        ps.setString(2, course);
	        ps.setString(3, department);
	        ps.setInt(4, duration_year);
	        ps.setInt(5, total_semester);
	        ps.setInt(6, fee);
	        ps.setString(7, description);
	        ps.setBoolean(8, active);
	        
	        int result = ps.executeUpdate();
	        
	        if(result > 0) {
	            try(ResultSet rs = ps.getGeneratedKeys()){
	                if(rs.next()){
	                    long generatedId = rs.getLong(1);
	                    
	                    CourseBean bean = new CourseBean();
	                    bean.setId(generatedId);
	                    bean.setCourse_code(course_code);
	                    bean.setCourse(course);
	                    bean.setDepartment(department);
	                    bean.setDuration_year(duration_year);
	                    bean.setTotal_semester(total_semester);
	                    bean.setFee(fee);
	                    bean.setDescription(description);
	                    bean.setActive(active);
	                    return bean;
	                }
	            }
	        }
	        
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    } 
	    return null;
	}

	//update course
	public int updateCourse(Long id, String course_code, String course , String department, int duration_year,int total_semester,double fee, String description,boolean active)
	{
	     int result = 0;
	        String query = "UPDATE course_detail SET COURSE_CODE=?, COURSE=?, DEPARTMENT=?, DURATION_YEAR=?, TOTAL_SEMESTER=?, FEE=?, DESCRIPTION=?, ACTIVE=? WHERE ID=?";

	        try (Connection con = DBconnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(query)) {
	             
	            ps.setString(1, course_code);
	            ps.setString(2,  course);
	            ps.setString(3, department);
	            ps.setInt(4, duration_year);
	            ps.setInt(5, total_semester);
	            ps.setDouble(6, fee);
	            ps.setString(7, description);
	            ps.setBoolean(8, active);
	            
	            ps.setLong(9, id); 

	            result = ps.executeUpdate();
	            System.out.println("Updated rows: " + result);
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return result;
	}
	
	// get course by id
	public CourseBean getCourseById(Long id)
	{
		CourseBean sb = null;
    	
	     String query= "SELECT * from course_detail WHERE ID=?";
	     
	     try(Connection con=DBconnection.getConnection();
	    		 PreparedStatement ps= con.prepareStatement(query);
	    		 )
	     {
	    	 ps.setLong(1, id);
	    	 
			ResultSet rs= ps.executeQuery();
			
			if(rs.next())
			{
				sb=new CourseBean();
				sb.setId(id);
				sb.setCourse_code(rs.getString("COURSE_CODE"));
				sb.setCourse(rs.getString("COURSE"));
				sb.setDepartment(rs.getString("DEPARTMENT"));
				sb.setDuration_year(rs.getInt("DURATION_YEAR"));
				sb.setTotal_semester(rs.getInt("TOTAL_SEMESTER"));
				sb.setFee(rs.getInt("FEE"));
				sb.setDescription(rs.getString("DESCRIPTION"));
				sb.setActive(rs.getBoolean("ACTIVE"));
				
			}
	    	 
	     } catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		} 
	    	
	    	return sb;
	}
	
	//delete course by id
	 public int deleteCourseById(Long id)  {
		   
		   int result=0;
	    	    String sql = "DELETE FROM course_detail WHERE id = ?";
	    	   
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
	 
	 public CourseBean getCourseByCode(String courseCode) {
		    CourseBean course = null;
		    try {
		        Connection con = DBconnection.getConnection();
		        PreparedStatement ps = con.prepareStatement("SELECT * FROM course_detail WHERE COURSE_CODE = ?");
		        ps.setString(1, courseCode);
		        ResultSet rs = ps.executeQuery();
		        if(rs.next()){
		            course = new CourseBean();
		            course.setId(rs.getLong("ID"));
		            course.setCourse_code(rs.getString("COURSE_CODE"));
		            course.setCourse(rs.getString("COURSE"));
		            course.setDepartment(rs.getString("DEPARTMENT"));
		            course.setDuration_year(rs.getInt("DURATION_YEAR"));
		            course.setTotal_semester(rs.getInt("TOTAL_SEMESTER"));
		            course.setFee(rs.getInt("FEE"));
		            course.setDescription(rs.getString("DESCRIPTION"));
		            course.setActive(rs.getBoolean("ACTIVE"));
		        }
		        con.close();
		    } catch(Exception e){
		        e.printStackTrace();
		    }
		    return course;
		}
	 
	
}
