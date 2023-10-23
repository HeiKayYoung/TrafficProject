package com.tech.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConPostgres {
	private static Connection con=null;
	public static Connection getConnection() throws Exception {
		// DB Driver
	    String dbDriver = "org.postgresql.Driver";
	    
	    // DB URL
	    // IP:PORT/스키마 
	    String dbUrl = "jdbc:postgresql://127.0.0.1:5432/postgres";
	    
	    // DB ID/PW
	    String dbUser = "postgres";
	    String dbPassword = "111111";
		
		if(con==null) {
			 Class.forName(dbDriver);
            con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);    
            System.out.println("DB Connection [성공]");
		}
		return con;
	}
}
