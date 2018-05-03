package com.haichaoaixuexi.dao;

import java.util.List;

import com.haichaoaixuexi.bean.SaleItem;
import com.haichaoaixuexi.bean.SalesOrder;

public interface SalesOrderDao {
	public List<SalesOrder> getSalesOrders();
	public SalesOrder getSalesOrdersById(int id);
	public List<SalesOrder> getSalesOrdersByUid(int uid);
	public void getSaleItemsByOid(int oid,List<SaleItem> list);
	public boolean deleteSalesOrderById(int id);
	public boolean updateSalesOrder(SalesOrder SalesOrder);
	public boolean addSalesOrder(SalesOrder SalesOrder);
	public boolean deleteSalesItemById(int id);
}
