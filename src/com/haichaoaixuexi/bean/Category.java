package com.haichaoaixuexi.bean;

import java.util.ArrayList;
import java.util.List;

import com.haichaoaixuexi.dao.CategoryDao;
import com.haichaoaixuexi.dao.UserDao;

public class Category {
	private int id;
	private int pid;
	private String name;
	private String descr;
	private String gride;
	private boolean isleaf;
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
	public String getGride() {
		return gride;
	}
	public void setGride(String gride) {
		this.gride = gride;
	}
	public boolean isIsleaf() {
		return isleaf;
	}
	public void setIsleaf(boolean isleaf) {
		this.isleaf = isleaf;
	}

	public static void save(Category c){
		CategoryDao.add(c);
	}
	public static void addTopCategory(String name, String descr){
		Category c = new Category();
		c.setId(-1);
		c.setName(name);
		c.setDescr(descr);
		c.setPid(0);
		c.setIsleaf(true);
		c.setGride("1");
		CategoryDao.add(c);
		//save(c);
	}
	public static void addChildCategory(String pidString,String name, String descr){
		int pid = Integer.parseInt(pidString);
		Category pCategory = CategoryDao.getCategory(pid);
		Category c = new Category();
		c.setName(name);
		c.setDescr(descr);
		c.setPid(pid);
		c.setIsleaf(true);
		c.setGride(Integer.parseInt(pCategory.getGride())+1+"");
		CategoryDao.add(c);
		//save(c);
		//更新父节点
		pCategory.setIsleaf(false);
		CategoryDao.updateCategory(pCategory);
	}
	public static List<Category> getCategories() {
		List<Category> list = new ArrayList<Category>();
		CategoryDao.getCategories(list,0);
		return list;
	}
	public static Category getCategory(int id) {
		Category category = new Category();
		category = CategoryDao.getCategory(id);
		return category;
	}
	public static void updateCategory(Category c) {
		CategoryDao.updateCategory(c);
	}
	public static void delCategory(int id) {
		Category c = CategoryDao.getCategory(id);
		List<Product> products = Product.getProductsByCid(id);
		for(int i = 0; i < products.size(); i ++){
			Product.deleteProductById(products.get(i).getId());
		}
		if (c.isleaf) {
			CategoryDao.delCategory(id);

		}else {
			List<Category> list = new ArrayList<Category>();
			CategoryDao.getCategories(list,0);
			for(int i = 0;i < list.size();i++){
				if (list.get(i).getPid() == id) {
					CategoryDao.delCategory(id);
					delCategory(list.get(i).getId());
				}
			}
		}
	}
}
