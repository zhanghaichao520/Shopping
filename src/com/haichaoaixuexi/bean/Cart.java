package com.haichaoaixuexi.bean;

import java.util.List;

import com.haichaoaixuexi.dao.CartDao;
import com.haichaoaixuexi.dao.CartMysqlDao;

public class Cart {
	private int id;
	private int pid;
	private int count;
	private double price;
	private int userid;
	static CartDao dao = new CartMysqlDao();

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Cart(int userid) {
		// TODO Auto-generated constructor stub
		this.userid = userid;
	}
	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
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
	public double getTotalPrice() {
		return price*count;
	}
	public static boolean addCart(Cart cart,int uid) {
		List<Cart> carts = dao.getCartsByUid(uid);
		for (int i = 0; i < carts.size(); i++) {
			Cart c = carts.get(i);
			if (c.getPid()==cart.getPid()) {
				c.setCount(c.getCount()+1);
				return dao.updateCart(c);
			}
		}
		return dao.addCart(cart);
	}
	public static List<Cart> getCartsByUid(int uid){
		return dao.getCartsByUid(uid);
	}
	public static boolean deleteCartById(int id) {
		return dao.deleteCartById(id);
	}
	public static boolean updateCart(Cart cart) {
		return dao.updateCart(cart);
	}
}

