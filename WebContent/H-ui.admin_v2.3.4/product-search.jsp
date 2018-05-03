<%@page import="com.haichaoaixuexi.util.Util"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="_sessioncheck.jsp"%>
<%
List<Product> products = new ArrayList<Product>();
int PAGE_SIZE = 2;
int PAGE_NO = 1;
int tid = 0;
int pageCount;
String action= request.getParameter("action");
String strPageNo = request.getParameter("pageno");
if (action != null && action.equals("search")) {
	String keyWords = request.getParameter("keyword");
	String priceMax = request.getParameter("pricemax");
	String priceMin = request.getParameter("pricemin");
	products = Product.findProducts(keyWords, priceMin, priceMax, 1, 2);
	if(products.size()==0){
		out.println("<script>alert('没有搜索到任何结果')</script>");
	}
}
if(strPageNo != null){
	PAGE_NO = Integer.parseInt(strPageNo);
}
if(PAGE_NO<1){
	PAGE_NO = 1;
}
/* pageCount = Product.getProducts(products, tid, PAGE_NO, PAGE_SIZE);
if(PAGE_NO > pageCount){
	PAGE_NO = pageCount;
} */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet" type="text/css" />
<title>产品搜索</title>
<script type="text/javascript">
function checkdata() {
	if(form.pricemin.value==""){
		pricemin.value = -1;
	}
	if(form.pricemax.value==""){
		pricemax.value = -1;
	}
}
</script>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 产品管理 <span class="c-gray en">&gt;</span> 产品搜索 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
  <form action="product-search.jsp" name="form" method="post" onsubmit="checkdata()">
  <input type="hidden" name="action" value="search">
  <div class="text-c"> 价格范围：
     <input type="text" id="pricemin" class="input-text Wdate" style="width:120px;">
    -
    <input type="text" id="pricemax" class="input-text Wdate" style="width:120px;">
    <input type="text" name="keyword" id="keyword" placeholder="关键字" style="width:250px" class="input-text"><button name="" id="" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
    </form>
  </div>
  <div class="cl pd-5 bg-1 bk-gray mt-20"></span> <span class="r">共有数据：<strong><%=products.size() %></strong> 条</span> </div>
  <div class="mt-20">
			<table class="table table-border table-bordered table-bg table-hover ">
				<thead>
					<tr class="text-c">
						<th width="40"><input name="" type="checkbox" value=""></th>
						<th width="40">ID</th>
						<th width="100">产品名称</th>
						<th>描述</th>
						<th width="100">市场价格</th>
						<th width="100">会员价格</th>
						<th width="150">发布日期</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(int i = 0; i < products.size(); i ++){
						Product product = products.get(i);
				%>
					<tr class="text-c va-m">
						<td><input name="" type="checkbox" value=""></td>
						<td><%=product.getId() %></td>
						<td><%=product.getName() %></td>
						<td class="text-l"><%=product.getDescr() %></td>
						<td><%=product.getNomalPrice() %></td>
						<td><%=product.getMemberPrice() %></td>
						<td class="text-l"><%=product.getPdate().getYear() %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
		<%-- 	<center>
			第<%=PAGE_NO %>页 &nbsp; &nbsp;
			共<%=pageCount %>页 &nbsp; &nbsp;
			<a href="product-seasearchp?tid=<%=tid %>&action_list=list&pageno=<%=PAGE_NO-1%>">上一页</a>
			&nbsp; &nbsp;
			<%
				if(pageCount > PAGE_NO){
			%>
			<a href="product-searca.jsp?tid=<%=tid %>&action_list=list&pageno=<%=PAGE_NO+1%>">下一页</a>
			&nbsp; &nbsp;
			<%} %>
			<a href="product-seasearchp?tid=<%=tid %>&action_list=list&pageno=<%=pageCount%>">最后一页</a>
			
			
			</center> --%>
		</div>
</body>

</html>