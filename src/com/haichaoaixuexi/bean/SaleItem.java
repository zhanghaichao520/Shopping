package com.haichaoaixuexi.bean;

import java.util.List;

import com.haichaoaixuexi.dao.CartDao;
import com.haichaoaixuexi.dao.CartMysqlDao;

public class SaleItem {
	private int id;
	private int pid;
	private int count;
	private double price;
	private int oid;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	
}

