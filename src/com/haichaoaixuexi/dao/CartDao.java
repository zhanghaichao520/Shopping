package com.haichaoaixuexi.dao;

import java.util.List;

import com.haichaoaixuexi.bean.Cart;
import com.haichaoaixuexi.bean.Cart;

public interface CartDao {
	public List<Cart> getCartsByUid(int uid);
	public boolean deleteCartById(int id);
	public boolean updateCart(Cart Cart);
	public boolean addCart(Cart cart);
}
