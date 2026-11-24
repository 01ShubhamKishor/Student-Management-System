package com.studentManagementSystem.utils;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DBconnection {
	//Singleton dB connection
//	private static final String URL="jdbc:mysql://localhost:3306/mydb";
//	private static final String USERNAME="root";
//	private static final  String Password="2023";
//	
//	
//	//parametrized constructor
//	public DBconnection() {}
//	
//	public static Connection getConnection() throws ClassNotFoundException, SQLException
//	{
//		  //Load the Driver
//		  Class.forName("com.mysql.cj.jdbc.Driver");
//		   
//		  //get the connection
//		 Connection con= DriverManager.getConnection(URL, USERNAME, Password);
//		 
//		return con;
//	}
	
	

	    // Singleton Pool 
	    private static HikariDataSource dataSource;

	    static {
	        try {
	            // Render se lega, nahi mila toh localhost
	            String url = System.getenv("DB_URL");
	            if (url == null || url.isEmpty()) {
	                url = "jdbc:mysql://localhost:3306/mydb";
	            }

	            String user = System.getenv("DB_USER");
	            if (user == null || user.isEmpty()) {
	                user = "root";
	            }

	            String pass = System.getenv("DB_PASS");
	            if (pass == null || pass.isEmpty()) {
	                pass = "2023";
	            }

	            HikariConfig config = new HikariConfig();
	            config.setJdbcUrl(url);
	            config.setUsername(user);
	            config.setPassword(pass);
	            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

	            // Pooling Settings
	            config.setMaximumPoolSize(10);          // Max 10 connection
	            config.setMinimumIdle(2);               // Kam se kam 2 ready rahenge
	            config.setIdleTimeout(30000);           // 30 sec idle toh band
	            config.setConnectionTimeout(30000);     // 30 sec tak wait karega
	            config.setMaxLifetime(1800000);         // 30 min baad naya connection
	            config.setPoolName("StudentMS-Pool");
	            config.addDataSourceProperty("cachePrepStmts", "true");
	            config.addDataSourceProperty("prepStmtCacheSize", "250");
	            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

	            dataSource = new HikariDataSource(config);
	            System.out.println("Hikari Pool Started Successfully!");

	        } catch (Exception e) {
	            e.printStackTrace();
	            throw new RuntimeException("DB Pool Init Failed!", e);
	        }
	    }

	    private DBconnection() {}

	   
	    public static Connection getConnection() throws SQLException {
	        return dataSource.getConnection();
	    }

	    // when server close pool is close
	    public static void closePool() {
	        if (dataSource != null && !dataSource.isClosed()) {
	            dataSource.close();
	        }
	    }
	
	
}
