package com.haichaoaixuexi.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {
	private static final String URL="jdbc:mysql://localhost:3306/shopping?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull";
	private static final String USER="root";
	private static final String PASSWORD="123456";
	private static Connection conn=null;
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public DB() {
		// TODO Auto-generated constructor stub
	}
	
	public static Connection getConnection() {
		try {
			conn=(Connection) DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	public static void closeConn(Connection conn) {
		try {
			conn.close();
			conn = null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static Statement getStmt(Connection conn) {
		Statement stmt = null;
		try {
			stmt =(Statement)conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return stmt;
	}
	public static PreparedStatement getPstmt(Connection conn,String sql) {
		PreparedStatement pStmt = null;
		try {
			pStmt = conn.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pStmt;
	}
	public static PreparedStatement getPstmt(Connection conn,String sql,boolean generateKey) {
		PreparedStatement pStmt = null;
		try {
			pStmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pStmt;
	}
	public static void closeStmt(Statement stmt) {
		try {
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static ResultSet executeQuery(Statement stmt,String sql) {
		ResultSet rs = null;
	    try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	    return rs;
	}
	public static ResultSet executeQuery(Connection conn,String sql) {
		ResultSet rs = null;
	    try {
			rs = conn.createStatement().executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	    return rs;
	}
	public static void closeResultSet(ResultSet rs) {
		try {
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

