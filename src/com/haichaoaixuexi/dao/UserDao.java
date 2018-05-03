package com.haichaoaixuexi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.haichaoaixuexi.bean.User;
import com.haichaoaixuexi.data.Const;
import com.haichaoaixuexi.util.DB;

public class UserDao {
	public static void add(User u) {
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "insert into User values (null,?,?,?,?,?,?)";
		try {
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setString(1, u.getUsername());
			pStmt.setString(2, u.getPassword());
			pStmt.setString(3, u.getPhone());
			pStmt.setString(4, u.getAddr());
			pStmt.setString(5, u.getStatus());
			pStmt.setTimestamp(6, u.getRdate());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeStmt(pStmt);
			DB.closeConn(conn);
		}

	}

	public static void updateUser(User u) {
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "UPDATE USER SET username=?,PASSWORD=?,phone=?,addr=?,STATUS=? WHERE id = ?";
		try {
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setString(1, u.getUsername());
			pStmt.setString(2, u.getPassword());
			pStmt.setString(3, u.getPhone());
			pStmt.setString(4, u.getAddr());
			pStmt.setString(5, u.getStatus());
			pStmt.setInt(6, u.getId());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeStmt(pStmt);
			DB.closeConn(conn);
		}

	}

	public static List<User> getUsers() {
		List<User> list = new ArrayList<User>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM USER";
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setStatus(rs.getString("status"));
				u.setRdate(rs.getTimestamp("rdate"));
				list.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		return list;
	}

	public static User getUser(int id) {
		User u = new User();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM USER where Id = " + id;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setStatus(rs.getString("status"));
				u.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		return u;
	}

	public static User getUser(String username) {
		User u = new User();
		Connection conn = null;
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM USER WHERE username = ?";
		try {
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setString(1, username);
			rs = pStmt.executeQuery();
			if (!rs.next()) {
				u.setId(Const.USER_NOT_EXIST);
			} else {
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setStatus(rs.getString("status"));
				u.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeStmt(pStmt);
			DB.closeConn(conn);
		}
		return u;
	}

	public static void delUser(int id) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConnection();
			stmt = DB.getStmt(conn);
			String sql = "delete from User where Id = " + id;
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
	}
}
