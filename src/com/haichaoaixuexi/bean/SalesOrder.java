package com.haichaoaixuexi.bean;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.haichaoaixuexi.dao.SalesOrderDao;
import com.haichaoaixuexi.dao.SalesOrderMysqlDao;
import com.haichaoaixuexi.dao.UserDao;
import com.haichaoaixuexi.data.Const;
import com.haichaoaixuexi.dao.SalesOrderDao;
import com.haichaoaixuexi.dao.SalesOrderMysqlDao;

public class SalesOrder {
	private int id;
	private int uid;
	private List<Cart> carts;
	private String addr;
	private Timestamp oDate;
	private int status;
	static SalesOrderDao dao = new SalesOrderMysqlDao();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public List<Cart> getCarts() {
		return carts;
	}
	public void setCarts(List<Cart> carts) {
		this.carts = carts;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Timestamp getoDate() {
		return oDate;
	}
	public void setoDate(Timestamp oDate) {
		this.oDate = oDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public static boolean deleteSalesOrderById(int id) {
		boolean flag = true;
		List<SaleItem> si = null;
		si = SalesOrder.getSalesItemsByoid(id);
		for (int i = 0; i <  si.size(); i++) {
			if (!dao.deleteSalesItemById(si.get(i).getId())) {
				flag = false;
			}
		}
		if (dao.deleteSalesOrderById(id)) {
			flag = false;
		}
		return flag;
	}
	public static boolean updateSalesOrder(SalesOrder so) {
		return dao.updateSalesOrder(so);
	}
	public static boolean addSalesOrder(SalesOrder so) {
		return dao.addSalesOrder(so);
	}
	public static void startOrder(int id) {
		SalesOrder od = dao.getSalesOrdersById(id);
		od.setStatus(Const.ORDER_SATATUS_START);
		dao.updateSalesOrder(od);
	}
	public static void stopOrder(int id) {
		SalesOrder od = dao.getSalesOrdersById(id);
		od.setStatus(Const.ORDER_SATATUS_STOP);
		dao.updateSalesOrder(od);
	}
	public static List<SaleItem> getSalesItemsByoid(int oid) {
		List<SaleItem> si = new ArrayList<SaleItem>();
		dao.getSaleItemsByOid(oid, si);
		return si;
	}
	public static List<SalesOrder> getSalesOrder(int uid){
		List<SalesOrder> so = new ArrayList<SalesOrder>();
		so = dao.getSalesOrdersByUid(uid);
		return so;
	}
	public static SalesOrder getSalesOrdersById(int id){
		return dao.getSalesOrdersById(id);
	}
	public static List<SalesOrder> getSalesOrder(){
		List<SalesOrder> so = new ArrayList<SalesOrder>();
		so = dao.getSalesOrders();
		return so;
	}
}
