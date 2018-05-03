package com.haichaoaixuexi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.haichaoaixuexi.bean.Cart;
import com.haichaoaixuexi.bean.Cart;
import com.haichaoaixuexi.util.DB;

public class CartMysqlDao implements CartDao{

	@Override
	public List<Cart> getCartsByUid(int uid) {
		// TODO Auto-generated method stub
		List<Cart> list = new ArrayList<Cart>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM Cart where userid = "+uid;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Cart c = new Cart(uid);
				c.setPid(rs.getInt("pid"));
				c.setCount(rs.getInt("count"));
				c.setId(rs.getInt("id"));
				c.setPrice(Double.parseDouble(rs.getString("price")));
				list.add(c);
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

	@Override
	public boolean deleteCartById(int id) {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConnection();
			stmt = DB.getStmt(conn);
			String sql = "delete from Cart where Id = " + id;
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		return true;
	}

	@Override
	public boolean updateCart(Cart cart) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "";
		try {
			sql = "update Cart set userid=?,pid=?,count=?,price=? where id=?";
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setInt(1, cart.getUserid());
			pStmt.setInt(2, cart.getPid());
			pStmt.setInt(3, cart.getCount());
			pStmt.setString(4, cart.getPrice()+"");
			pStmt.setInt(5, cart.getId());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally {
			DB.closeStmt(pStmt);
			DB.closeConn(conn);
		}
		return true;
	}

	@Override
	public boolean addCart(Cart cart) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "";
		try {
			sql = "insert into Cart values (null,?,?,?,?)";
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setInt(1, cart.getUserid());
			pStmt.setInt(2, cart.getPid());
			pStmt.setInt(3, cart.getCount());
			pStmt.setString(4, cart.getPrice()+"");
			pStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally {
			DB.closeStmt(pStmt);
			DB.closeConn(conn);
		}
		return true;
	}

}
