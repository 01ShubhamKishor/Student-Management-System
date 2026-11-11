package com.studentManagementSystem.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
	
	private static final String URL="jdbc:mysql://localhost:3306/mydb";
	private static final String USERNAME="root";
	private static final  String Password="2023";
	
	
	//parametrized constructor
	public DBconnection() {}
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException
	{
		  //Load the Driver
		  Class.forName("com.mysql.cj.jdbc.Driver");
		   
		  //get the connection
		 Connection con= DriverManager.getConnection(URL, USERNAME, Password);
		 
		return con;
	}
	
	
	
	
	
			

	
}
