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

	

	    private static HikariDataSource dataSource;
	    private static String finalUrl;

	    static {
	        try {
	            // 1. Pehle Render / Clever Cloud wala URL dhoondo
	            String url = System.getenv("DB_URL");
	            if (url == null || url.isEmpty()) {
	                url = System.getenv("DATABASE_URL");
	            }
	            if (url == null || url.isEmpty()) {
	                url = System.getenv("MYSQL_ADDON_URI"); // Clever Cloud yahi bhejta hai
	            }

	            // 2. Nahi mila toh localhost
	            if (url == null || url.isEmpty()) {
	                url = "jdbc:mysql://localhost:3306/mydb";
	            }

	            // 3. Clever Cloud ka URL fix karo -> mysql:// ko jdbc:mysql:// banao
	            if (url.startsWith("mysql://")) {
	                url = "jdbc:" + url;
	            }

	            String user = System.getenv("DB_USER");
	            if (user == null || user.isEmpty()) {
	                user = System.getenv("MYSQL_ADDON_USER");
	            }
	            if (user == null || user.isEmpty()) {
	                user = "root";
	            }

	            String pass = System.getenv("DB_PASS");
	            if (pass == null || pass.isEmpty()) {
	                pass = System.getenv("MYSQL_ADDON_PASSWORD");
	            }
	            if (pass == null || pass.isEmpty()) {
	                pass = "2023";
	            }

	            // 4. Agar URL me hi user:pass hai (Clever Cloud jaisa) toh usko nikal lo
	            // Example: jdbc:mysql://user:pass@host:3306/db
	            if (url.contains("@") && url.contains("://") && url.split("://")[1].contains(":")) {
	                try {
	                    String afterProtocol = url.substring(url.indexOf("://") + 3);
	                    String credentials = afterProtocol.substring(0, afterProtocol.indexOf("@"));
	                    if (credentials.contains(":")) {
	                        String[] parts = credentials.split(":", 2);
	                        user = parts[0];
	                        pass = parts[1];
	                        // URL se user:pass hata do, sirf host rakho
	                        url = url.substring(0, url.indexOf("://") + 3) + afterProtocol.substring(afterProtocol.indexOf("@") + 1);
	                    }
	                } catch (Exception e) {
	                    // Agar parse na ho toh purana URL hi use karo
	                }
	            }

	            finalUrl = url;
	            System.out.println("========== DB CONNECTING TO ==========");
	            System.out.println("URL : " + finalUrl);
	            System.out.println("USER: " + user);
	            System.out.println("=======================================");

	            HikariConfig config = new HikariConfig();
	            config.setJdbcUrl(finalUrl);
	            config.setUsername(user);
	            config.setPassword(pass);
	            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

	            config.setMaximumPoolSize(3);
	            config.setMinimumIdle(1);
	            config.setIdleTimeout(30000);
	            config.setConnectionTimeout(30000);
	            config.setMaxLifetime(1800000);
	            config.setPoolName("StudentMS-Pool");
	            config.addDataSourceProperty("cachePrepStmts", "true");
	            config.addDataSourceProperty("prepStmtCacheSize", "250");
	            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
	            // Clever Cloud ke liye SSL zaroori hai kabhi kabhi
	            config.addDataSourceProperty("useSSL", "false");
	            config.addDataSourceProperty("allowPublicKeyRetrieval", "true");

	            dataSource = new HikariDataSource(config);
	            System.out.println("Hikari Pool Started Successfully!");

	        } catch (Exception e) {
	            e.printStackTrace();
	            throw new RuntimeException("DB Pool Init Failed! URL was: " + finalUrl, e);
	        }
	    }

	    private DBconnection() {}

	    public static Connection getConnection() throws SQLException {
	        return dataSource.getConnection();
	    }

	    public static void closePool() {
	        if (dataSource != null && !dataSource.isClosed()) {
	            dataSource.close();
	        }
	    }
	}
