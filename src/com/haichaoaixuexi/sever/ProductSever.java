package com.haichaoaixuexi.sever;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.alibaba.fastjson.JSONArray;
import com.haichaoaixuexi.bean.Category;
import com.haichaoaixuexi.bean.Product;
import com.haichaoaixuexi.dao.CategoryDao;

/**
 * Servlet implementation class ProductSever
 */
@WebServlet("/ProductSever")
public class ProductSever extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductSever() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		if (action.equals("productadd")) {
			//添加产品
			String name = "";
			String descr = "";
			String normalPrice = "";
			String memberPrice = "";
			int cid=0;
			String picpath="";
			String file=request.getSession().getServletContext().getRealPath("upload");
			System.out.println("file:"+file);
			//创建文件工厂对象
			DiskFileItemFactory df=new DiskFileItemFactory();
			//设置缓存大小
			df.setSizeThreshold(4096); 
			//创建上传处理对象
			ServletFileUpload su=new ServletFileUpload(df);
			try {
				//得到所有的表单对象
				List<FileItem> list= su.parseRequest(request);
				System.out.println("表单个数："+list.size());
				
				for (FileItem fileItem : list) {
					if(fileItem.isFormField()){
						//处理普通表单字段
						System.out.println(fileItem.getFieldName()+fileItem.getString("utf-8"));
						if("productname".equals(fileItem.getFieldName())){
							name=fileItem.getString("utf-8");
						}else if("productdescr".equals(fileItem.getFieldName())){
							descr=fileItem.getString("utf-8");
						}else if("normalprice".equals(fileItem.getFieldName())){
							normalPrice=fileItem.getString("utf-8");
						}else if("memberprice".equals(fileItem.getFieldName())){
							memberPrice=fileItem.getString("utf-8");
						}else if("cid".equals(fileItem.getFieldName())){
							cid=Integer.parseInt(fileItem.getString("utf-8"));
						}
					}else{
						//处理非普通表单字段
						//upload\boy.jpg
						String picname=fileItem.getName();	
						//截取字符串
						int i=file.lastIndexOf("\\");
						picpath=file.substring(i+1,file.length())+"\\"+picname;						
						System.out.println("path:"+picname);
						//
						fileItem.write(new File(file,picname));
					}
				}
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Product product = new Product();
			product.setId(-1);
			product.setCid(cid);
			product.setDescr(descr);
			product.setMemberPrice(memberPrice);
			product.setName(name);
			product.setNomalPrice(normalPrice);
			product.setPdate(new Timestamp(System.currentTimeMillis()));
			product.setPicpath(picpath);
			if(Product.addProduct(product)){
				out.print("<script>alert(decodeURIComponent('add product success!'));</script>");
			}else {
				out.print("<script>alert(decodeURIComponent('添加失敗'));</script>");

			}
		}else if (action.equals("getCate")) {
			//根据大分类得到小分类
			String topId=request.getParameter("topId");
			List<Category> cate = new ArrayList<>();
			CategoryDao.getCategories(cate, Integer.parseInt(topId));
			System.out.println(JSONArray.toJSON(cate));
			out.print(JSONArray.toJSON(cate));
		}
	}

}
