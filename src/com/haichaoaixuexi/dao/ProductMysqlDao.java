package com.haichaoaixuexi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.haichaoaixuexi.bean.Category;
import com.haichaoaixuexi.bean.Product;
import com.haichaoaixuexi.util.DB;
import com.haichaoaixuexi.util.Util;

public class ProductMysqlDao implements ProductDao{

	@Override
	public List<Product> getProducts() {
		// TODO Auto-generated method stub
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM Book ";
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNomalPrice(rs.getString("normalprice"));
				p.setMemberPrice(rs.getString("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCid(rs.getInt("categoryid"));
				p.setPicpath(rs.getString("picpath"));
				list.add(p);
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
	public int getProducts(List<Product> products,int cid,int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		int pageCount = 0;
		String sql = "";
		conn = DB.getConnection();
		int grade = 1;
		try {
		
				if (cid == 0) {
					sql = "SELECT * FROM Book limit "+(pageNo-1)*pageSize+","+pageSize;
					rsCount = DB.executeQuery(conn, "select count(*) from Book");
				}else {
					sql = "SELECT * FROM Book WHERE categoryid in (select id from category where pid="+cid+") limit "+(pageNo-1)*pageSize+","+pageSize;
					rsCount = DB.executeQuery(conn, "select count(*) from Book where categoryid in (select id from category where pid="+cid+")" );
				}
			
			rsCount.next();
			pageCount = (rsCount.getInt(1)+pageSize-1)/pageSize;
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNomalPrice(rs.getString("normalprice"));
				p.setMemberPrice(rs.getString("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCid(rs.getInt("categoryid"));
				p.setPicpath(rs.getString("picpath"));
				products.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeResultSet(rsCount);
			DB.closeConn(conn);
		}
		return pageCount;
	}

	
	@Override
	public boolean deleteProductByCategoryId(int cid) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteProductById(int id) {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConnection();
			stmt = DB.getStmt(conn);
			String sql = "delete from Book where Id = " + id;
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
	public boolean updateProduct(Product product) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "";
		try {
			sql = "update Book set name=?,descr=?,normalprice=?,memberprice=? where id=?";
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setString(1, product.getName());
			pStmt.setString(2, product.getDescr());
			pStmt.setString(3, product.getNomalPrice());
			pStmt.setString(4, product.getMemberPrice());
			pStmt.setInt(5, product.getId());
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
	public boolean addProduct(Product product) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pStmt = null;
		String sql = "";
		try {
			sql = "insert into Book values (null,?,?,?,?,?,?,?)";
			conn = DB.getConnection();
			pStmt = DB.getPstmt(conn, sql);
			pStmt.setString(1, product.getName());
			pStmt.setString(2, product.getDescr());
			pStmt.setString(3, product.getNomalPrice());
			pStmt.setString(4, product.getMemberPrice());
			pStmt.setTimestamp(5, product.getPdate());
			pStmt.setInt(6, product.getCid());
			pStmt.setString(7, product.getPicpath());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("exception");
			e.printStackTrace();
			return false;
		} finally {
			DB.closeStmt(pStmt);
			DB.closeConn(conn);
		}
		return true;
	}

	@Override
	public List<Product> getProductsByCid(int cid) {
		// TODO Auto-generated method stub
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM Book where categoryid = " + cid;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNomalPrice(rs.getString("normalprice"));
				p.setMemberPrice(rs.getString("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCid(rs.getInt("categoryid"));
				p.setPicpath(rs.getString("picpath"));
				list.add(p);
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
	public Product getProductsById(int id) {
		// TODO Auto-generated method stub
		Product p = new Product();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM Book where Id = " + id;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNomalPrice(rs.getString("normalprice"));
				p.setMemberPrice(rs.getString("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCid(rs.getInt("categoryid"));
				p.setPicpath(rs.getString("picpath"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		return p;
	}

	@Override
	public List<Product> findProducts(String keyWord, String lowNomalPrice, String highNomalPrice, int pageNo,
			int pageSize) {
		// TODO Auto-generated method stub
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConnection();
			String sql = "SELECT * FROM Book where 1 = 1 " ;
			if (keyWord != null && !keyWord.equals("")) {
				sql += " and name like '%"+keyWord+"%' or descr like '%"+keyWord+"%'";
			}
			/*if (Integer.parseInt(lowNomalPrice)>=0&&false) {
				sql += " and normalprice>"+lowNomalPrice;
			}
			if (Integer.parseInt(highNomalPrice)>0) {
				sql += " and normalprice < "+Integer.parseInt(highNomalPrice);
			}*/
			System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNomalPrice(rs.getString("normalprice"));
				p.setMemberPrice(rs.getString("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCid(rs.getInt("categoryid"));
				p.setPicpath(rs.getString("picpath"));
				list.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeResultSet(rs);
			DB.closeConn(conn);
		}
		return list;
	}

	@Override
	public List<Product> getLatestProducts(int count) {
		// TODO Auto-generated method stub
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = DB.getConnection();
		stmt = DB.getStmt(conn);
		String sql = "SELECT * FROM Book order by pdate desc limit 0," + count;
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNomalPrice(rs.getString("normalprice"));
				p.setMemberPrice(rs.getString("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCid(rs.getInt("categoryid"));
				p.setPicpath(rs.getString("picpath"));
				list.add(p);
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


}
