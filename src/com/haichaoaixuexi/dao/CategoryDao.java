package com.haichaoaixuexi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.haichaoaixuexi.bean.Category;
import com.haichaoaixuexi.bean.User;
import com.haichaoaixuexi.util.DB;

public class CategoryDao {
	public static void add(Category c) {
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "";
		try {
			if (c.getId()==-1) {
				sql = "insert into Category values (null,?,?,?,?,?)";
			}else {
				sql = "insert into Category values ("+c.getId()+",?,?,?,?,?)";
			}
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setString(1, c.getName());
			pStmt.setString(2, c.getDescr());
			pStmt.setInt(3, c.getPid());
			pStmt.setString(4, c.isIsleaf()?"0":"1");
			pStmt.setString(5, c.getGride());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeStmt(pStmt);
			DB.closeConn(conn);
		}
	}
	public static void getCategories(List<Category> list, int id) {
		Connection conn = null;
		conn = DB.getConnection();
		getCategories(conn, list, id);
	}
	private static void getCategories(Connection conn,List<Category> list, int id) {
		ResultSet rs = null;
		String sql = "select * from Category where pid = "+id;
		try {
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setIsleaf(rs.getString("isleaf").equals("0")?true:false);
				c.setPid(rs.getInt("pid"));
				c.setGride(rs.getString("grade"));
				list.add(c);
				if (!c.isIsleaf()) {
					getCategories(list, c.getId());
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
		}
	}
	public static void delCategory(int id) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConnection();
			stmt = DB.getStmt(conn);
			String sql = "delete from Category where id = " + id;
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
	}
	public static void updateCategory(Category c) {
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "UPDATE Category SET name=?,descr=?,pid=?,isleaf=?,grade=? WHERE id = ?";
		try {
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setString(1, c.getName());
			pStmt.setString(2, c.getDescr());
			pStmt.setInt(3, c.getPid());
			pStmt.setString(4, c.isIsleaf()?"0":"1");
			pStmt.setString(5, c.getGride());
			pStmt.setInt(6, c.getId());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeStmt(pStmt);
			DB.closeConn(conn);
		}

	}
	public static Category getCategory(int id) {
		Category c = new Category();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM Category where Id = " + id;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getString("isleaf").equals("0")?true:false);
				c.setGride(rs.getString("grade"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		return c;
	}
	public static List<Category> getTopCategories() {
		List<Category> list = new ArrayList<>();
		Connection conn = null;
		ResultSet rs = null;
		String sql = "select * from Category where grade = 1";
		try {
			conn = DB.getConnection();
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setIsleaf(rs.getString("isleaf").equals("0")?true:false);
				c.setPid(rs.getInt("pid"));
				c.setGride(rs.getString("grade"));
				list.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
		}
		return list;
	}
}
