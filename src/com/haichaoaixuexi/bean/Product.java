package com.haichaoaixuexi.bean;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.haichaoaixuexi.dao.ProductDao;
import com.haichaoaixuexi.dao.ProductMysqlDao;

public class Product {
	private int id;
	private int cid;
	private String name;
	private String descr;
	private String nomalPrice;
	private String memberPrice;
	private Timestamp pdate;
	private String picpath;
	static ProductDao dao = new ProductMysqlDao();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public String getNomalPrice() {
		return nomalPrice;
	}
	public void setNomalPrice(String nomalPrice) {
		this.nomalPrice = nomalPrice;
	}
	public String getMemberPrice() {
		return memberPrice;
	}
	public void setMemberPrice(String memberPrice) {
		this.memberPrice = memberPrice;
	}
	public Timestamp getPdate() {
		return pdate;
	}
	public void setPdate(Timestamp pdate) {
		this.pdate = pdate;
	}
	
	public String getPicpath() {
		return picpath;
	}
	public void setPicpath(String picpath) {
		this.picpath = picpath;
	}
	public static List<Product> getProducts() {
		return dao.getProducts();
	}
	public static List<Product> getProductsByCid(int cid) {
		return dao.getProductsByCid(cid);
	}
	public static int getProducts(List<Product> products,int cid,int pageNo,int pageSize) {
		return dao.getProducts(products,cid,pageNo, pageSize);
	}
	public static List<Product> findProducts(String keyWord,  String lowNomalPrice, String highNomalPrice,
			 int pageNo, int pageSize){
		return dao.findProducts(keyWord, lowNomalPrice, highNomalPrice, pageNo, pageSize);
	}
	public static List<Product> findProducts(String name){
		return null;
	}
			
	public static boolean deleteProductByCategoryId(int cid) {
		return false;
	}
	public static boolean deleteProductById(int id) {
		return dao.deleteProductById(id);
	}
	public static boolean updateProduct(Product product) {
		return dao.updateProduct(product);
	}
	public static boolean addProduct(Product product) {
		return dao.addProduct(product);
	}
	public static Product getProductById(int id) {
		return dao.getProductsById(id);
	}
	public static List<Product> getLatestProducts(int count) {
		return dao.getLatestProducts(count);
	}
}
