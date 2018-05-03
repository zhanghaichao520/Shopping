package com.haichaoaixuexi.dao;

import java.util.Date;
import java.util.List;
import com.haichaoaixuexi.bean.Product;

public interface ProductDao {
	public List<Product> getLatestProducts(int count);
	public List<Product> getProducts();
	public List<Product> getProductsByCid(int cid);
	public Product getProductsById(int id);
	public int getProducts(List<Product> products,int cid,int pageNo, int pageSize);

	public List<Product> findProducts(String keyWord,  String lowNomalPrice, String highNomalPrice,
			 int pageNo, int pageSize);

	public boolean deleteProductByCategoryId(int cid);

	public boolean deleteProductById(int id);

	public boolean updateProduct(Product product);
	public boolean addProduct(Product product);
	
}
