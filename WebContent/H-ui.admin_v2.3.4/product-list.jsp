<%@page import="java.util.ArrayList"%>
<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.dao.CategoryDao"%>
<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="_sessioncheck.jsp"%>
<%
	List<Category> categories = Category.getCategories();
	List<Product> products = new ArrayList<Product>();
	int PAGE_SIZE = 5;
	int PAGE_NO = 1;
	int tid = 0;
	int pageCount;
	String action_list = request.getParameter("action_list");
	String strPageNo = request.getParameter("pageno");
	if (action_list != null && action_list.equals("list")) {
		tid = Integer.parseInt(request.getParameter("tid"));
	}
	if (strPageNo != null) {
		PAGE_NO = Integer.parseInt(strPageNo);
	}
	if (PAGE_NO < 1) {
		PAGE_NO = 1;
	}
	pageCount = Product.getProducts(products, tid, PAGE_NO, PAGE_SIZE);
	if (PAGE_NO > pageCount) {
		PAGE_NO = pageCount;
	}
	
	//删除产品
	String action_del = request.getParameter("action_del");
	if (action_del != null && action_del.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("del_id"));
		if(Product.deleteProductById(id))
			out.println("delete success");
	}
	//批量永久删除产品
		String action_delall = request.getParameter("action_delall");
		if (action_delall != null && action_delall.equals("deleteall")) {
			String id_array = request.getParameter("id_array");
			String[] ids = id_array.split(",");
			for (int i = 0; i < ids.length; i++) {
				int id = Integer.parseInt(ids[i]);
				Product.deleteProductById(id);
			}
			response.sendRedirect("product-list.jsp");
		}
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<title>商品列表</title>
</head>
<body class="pos-r">
	
	<div style="margin-left: 0px;">
		<nav class="breadcrumb">
			<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
			产品管理 <span class="c-gray en">&gt;</span> 产品列表 <a
				class="btn btn-success radius r mr-20"
				style="line-height: 1.6em; margin-top: 3px"
				href="javascript:location.replace(location.href);" title="刷新"><i
				class="Hui-iconfont">&#xe68f;</i></a>
		</nav>
		<div class="pd-20">
			<div class="cl pd-5 bg-1 bk-gray mt-20">
				<span class="l"><a href="javascript:;" onclick="datadel()"
					class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
						批量删除</a> <a class="btn btn-primary radius"
					onclick="product_add('添加产品','product-add.jsp')"
					href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加产品</a></span> <span
					class="r">共有数据：<strong><%=products.size()%></strong> 条
				</span>
			</div>
			<div class="mt-20">
				<table
					class="table table-border table-bordered table-bg table-hover ">
					<thead>
						<tr class="text-c">
							<th width="40"><input name="" type="checkbox" value=""></th>
							<th width="40">ID</th>
							<th width="100">产品名称</th>
							<th>描述</th>
							<th width="100">市场价格</th>
							<th width="100">会员价格</th>
							<th width="60">发布日期</th>
							<th width="100">操作</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (int i = 0; i < products.size(); i++) {
								Product product = products.get(i);
						%>
						<tr class="text-c va-m">
							<td><input name="productid" id="productid" type="checkbox" value="<%=product.getId()%>"></td>
							<td><%=product.getId()%></td>
							<td><%=product.getName()%></td>
							<td class="text-l"><%=product.getDescr()%></td>
							<td><%=product.getNomalPrice()%></td>
							<td><%=product.getMemberPrice()%></td>
							<td class="text-l"><%=product.getPdate()%></td>
							<td class="td-manage"><a style="text-decoration: none"
								class="ml-5"
								onClick="product_edit('产品编辑','product-edit.jsp?id=<%=product.getId()%>','10001')"
								href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
								<a style="text-decoration: none" class="ml-5"
								onClick="product_del(this,'<%=product.getId()%>')" href="javascript:;"
								title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<center>
					第<%=PAGE_NO%>页 &nbsp; &nbsp; 共<%=pageCount%>页 &nbsp; &nbsp; <a
						href="product-list.jsp?tid=<%=tid%>&action_list=list&pageno=<%=PAGE_NO - 1%>">上一页</a>
					&nbsp; &nbsp;
					<%
						if (pageCount > PAGE_NO) {
					%>
					<a
						href="product-list.jsp?tid=<%=tid%>&action_list=list&pageno=<%=PAGE_NO + 1%>">下一页</a>
					&nbsp; &nbsp;
					<%
						}
					%>
					<a
						href="product-list.jsp?tid=<%=tid%>&action_list=list&pageno=<%=pageCount%>">最后一页</a>


				</center>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="lib/layer/2.1/layer.js"></script>
	<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript"
		src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
	<script type="text/javascript" src="js/H-ui.js"></script>
	<script type="text/javascript" src="js/H-ui.admin.js"></script>
	<script type="text/javascript">

$('.table-sort').dataTable({
	"aaSorting": [[ 1, "desc" ]],//默认第几个排序
	"bStateSave": true,//状态保存
	"aoColumnDefs": [
	  {"orderable":false,"aTargets":[0,7]}// 制定列不参与排序
	]
});
/*商品-添加*/
function product_add(title,url){

	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}

/*图片-编辑*/
function product_edit(title,url,id){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*批量删除*/
function datadel() {
	var id_array = new Array();
	$('input[name="productid"]:checked').each(function() {
		id_array.push($(this).val());
	});
	alert("删除成功");
	location.href = 'product-list.jsp?id_array=' + id_array
			+ '&action_delall=deleteall';
}
/*图片-删除*/
function product_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$(obj).parents("tr").remove();
		location.href = 'product-list.jsp?del_id=' + id
		+ '&action_del=delete';
		alert("删除成功");
		layer.msg('已删除!',{icon:1,time:1000});
	});
}
</script>
</body>
</html>