<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@page import="com.haichaoaixuexi.bean.SalesOrder"%>
<%@page import="com.haichaoaixuexi.bean.SaleItem"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
List<SaleItem> si = null;
String action = request.getParameter("action");
if (action != null && action.equals("show")) {
	int oid = Integer.parseInt(request.getParameter("oid"));
	si = SalesOrder.getSalesItemsByoid(oid);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet"
	type="text/css" />
<title>订单详情</title>
</head>
<body>
	<div class="pd-20">
	
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-hover table-bg table-sort">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" name="" value=""></th>
						<th width="80">ID</th>
						<th width="100">商品</th>
						<th width="200">价格</th>
						<th width="70">数量</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < si.size(); i++) {
							SaleItem item = si.get(i);
							Product p = Product.getProductById(item.getPid());
					%>
					<tr class="text-c">
						<td><input type="checkbox" value="<%=item.getId()%>" name="oid"></td>
						<td><%=item.getId()%></td>
						<td><%=p.getName()%></td>
						<td class="text-l"><%=item.getPrice()%></td>
						<td><%=item.getCount()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="lib/layer/2.1/layer.js"></script>
	<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="js/H-ui.js"></script>
	<script type="text/javascript" src="js/H-ui.admin.js"></script>

</body>
</html>