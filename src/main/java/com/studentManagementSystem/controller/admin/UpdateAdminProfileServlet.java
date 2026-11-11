package com.studentManagementSystem.controller.admin;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studentManagementSystem.dao.AdminDAO;
import com.studentManagementSystem.model.AdminBean;

/**
 * Servlet implementation class UpdateAdminServlet
 */
@WebServlet("/UpdateAdminProfile")
public class UpdateAdminProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 try {
	            String user_name = request.getParameter("user_name");
	            String email = request.getParameter("email");
	            String password = request.getParameter("password");
	            String role = request.getParameter("role");
	            String contact = request.getParameter("contact");
	            String address = request.getParameter("address");
	            String dobstr = request.getParameter("dob");
	            LocalDate dob = LocalDate.parse(dobstr);           
	            boolean active = Boolean.parseBoolean(request.getParameter("active"));
	            
	          
	            Long id = Long.parseLong(request.getParameter("id"));
	            
	            AdminDAO ad = new AdminDAO();
	            
	              int result =ad.updateAdmin(id, user_name, email, password, role, dob, address, contact, active);
	              
	              if(result>0)
	              {
	            	  System.out.print("updated succesfully");
	            	  //getting updated admin detail fresh from DB and to previous session
	            	  
	            	AdminBean admin= ad.getAdminById(id);
	            	HttpSession session=request.getSession();
	            	 session.setAttribute("admin", admin);
	  	            request.setAttribute("updated", true); 
	  	            request.getRequestDispatcher("/Admin/admin-profile.jsp").forward(request, response);	
	            	  
	              }
	              else {
	            	  System.out.print("not updated");
	            	  request.setAttribute("error", "Update failed: ");
	            	  
	              }

	        } catch (Exception e) {
	            e.printStackTrace();
	            request.setAttribute("error", "Update failed: "+e.getMessage());
	            request.getRequestDispatcher("Admin/edit-student.jsp").forward(request, response);
	        }
	}

}

