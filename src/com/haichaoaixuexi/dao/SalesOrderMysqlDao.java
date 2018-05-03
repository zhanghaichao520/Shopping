package com.haichaoaixuexi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.haichaoaixuexi.bean.Cart;
import com.haichaoaixuexi.bean.SaleItem;
import com.haichaoaixuexi.bean.SalesOrder;
import com.haichaoaixuexi.util.DB;

public class SalesOrderMysqlDao implements SalesOrderDao{

	@Override
	public List<SalesOrder> getSalesOrdersByUid(int uid) {
		// TODO Auto-generated method stub
		List<SalesOrder> list = new ArrayList<SalesOrder>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM SalesOrder where userid = "+uid;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				SalesOrder so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setUid(uid);
				so.setoDate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				list.add(so);
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
	public boolean deleteSalesOrderById(int id) {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConnection();
			stmt = DB.getStmt(conn);
			String sql = "delete from SalesOrder where Id = " + id;
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
	public boolean updateSalesOrder(SalesOrder so) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "";
		try {
			sql = "update SalesOrder set addr=?,status=? where id=?";
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setString(1,so.getAddr());
			pStmt.setInt(2, so.getStatus());
			pStmt.setInt(3, so.getId());
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
	public boolean addSalesOrder(SalesOrder so) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pStmt = null;
		ResultSet rsKey = null;
		String sql = "";
		try {
			sql = "insert into SalesOrder values (null,?,?,?,?)";
			conn = DB.getConnection();
			conn.setAutoCommit(false);
			pStmt = DB.getPstmt(conn, sql,true);
			pStmt.setInt(1, so.getUid());
			pStmt.setString(2, so.getAddr());
			pStmt.setTimestamp(3, so.getoDate());
			pStmt.setInt(4, so.getStatus());
			pStmt.executeUpdate();
			
			rsKey = pStmt.getGeneratedKeys();
			rsKey.next();
			int key = rsKey.getInt(1);
			
			String sqlItem = "insert into SalesItem values (null,?,?,?,?)";
			pStmt = DB.getPstmt(conn, sqlItem);
			List<Cart> items = so.getCarts();
			for (int i = 0; i < items.size(); i++) {
				Cart ci = items.get(i);
				pStmt.setInt(1, ci.getPid());
				pStmt.setString(2, ci.getPrice()+"");
				pStmt.setInt(3, ci.getCount());
				pStmt.setInt(4, key);
				pStmt.addBatch();
			}
			pStmt.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.setAutoCommit(true);
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		} finally {
			DB.closeStmt(pStmt);
			DB.closeResultSet(rsKey);
			DB.closeConn(conn);
		}
		return true;
	}

	@Override
	public void getSaleItemsByOid(int oid,List<SaleItem> list) {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM SalesItem where orderedid = "+oid;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				SaleItem si = new SaleItem();
				si.setId(rs.getInt("id"));
				si.setPid(rs.getInt("bookid"));
				si.setCount(rs.getInt("bcount"));
				si.setOid(oid);
				si.setPrice(Double.parseDouble(rs.getString("uniprice")));
				list.add(si);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
	}

	@Override
	public SalesOrder getSalesOrdersById(int id) {
		// TODO Auto-generated method stub
		SalesOrder salesOrder = new SalesOrder();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM SalesOrder where id = "+id;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				salesOrder.setId(rs.getInt("id"));
				salesOrder.setAddr(rs.getString("addr"));
				salesOrder.setUid(rs.getInt("userid"));
				salesOrder.setoDate(rs.getTimestamp("odate"));
				salesOrder.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		return salesOrder;
	}

	@Override
	public List<SalesOrder> getSalesOrders() {
		// TODO Auto-generated method stub
		List<SalesOrder> list = new ArrayList<SalesOrder>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM SalesOrder ";
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				SalesOrder so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setUid(rs.getInt("userid"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				list.add(so);
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
	public boolean deleteSalesItemById(int id) {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConnection();
			stmt = DB.getStmt(conn);
			String sql = "delete from SalesItem where id = " + id;
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

}
