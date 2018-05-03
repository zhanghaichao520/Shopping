<%@page import="com.haichaoaixuexi.bean.SalesOrder"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="_sessioncheck.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	List<SalesOrder> orders = null;
	orders = SalesOrder.getSalesOrder();
	//删除
	String action = request.getParameter("action");
	if (action != null && action.equals("delete")) {
		int oid = Integer.parseInt(request.getParameter("oid"));
		SalesOrder.deleteSalesOrderById(oid);
	}
	//批量删除
	String action_del = request.getParameter("action_del");
	if (action_del != null && action_del.equals("delete")) {
		String oid_array = request.getParameter("oid_array");
		String[] oids = oid_array.split(",");
		for (int i = 0; i < oids.length; i++) {
			int oid = Integer.parseInt(oids[i]);
			SalesOrder.deleteSalesOrderById(oid);
		}
		response.sendRedirect("order-manager.jsp");
	}
	//修改
	String action_edit = request.getParameter("action_edit");
	if (action_edit != null && action_edit.equals("edit_user")) {
		String name = request.getParameter("user_name");
		String phone = request.getParameter("user_phone");
		String addr = request.getParameter("user_addr");
		int id_edit = Integer.parseInt(request.getParameter("id_edit"));
		User.changeUserInfo(id_edit, name, phone, addr);
	}
	//改为已支付用订单
	String action_stop = request.getParameter("action_stop");
	if (action_stop != null && action_stop.equals("stop")) {
		int id = Integer.parseInt(request.getParameter("id"));
		SalesOrder.stopOrder(id);
		
	}
	//改为待支付订单
	String action_start = request.getParameter("action_start");
	if (action_start != null && action_start.equals("start")) {
		int id = Integer.parseInt(request.getParameter("id"));
		SalesOrder.startOrder(id);
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
<title>订单浏览</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 订单管理 <span class="c-gray en">&gt;</span>
	订单浏览<a class="btn btn-success radius r mr-20"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a href="javascript:;" onclick="datadel()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a></span> <span class="r">共有数据：<strong><%=orders.size()%></strong>
				条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-hover table-bg table-sort">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" name="" value=""></th>
						<th width="80">ID</th>
						<th width="100">下单用户</th>
						<th width="200">送货地址</th>
						<th width="130">下单时间</th>
						<th width="70">状态</th>
						<th width="100">操作</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < orders.size(); i++) {
							SalesOrder o = orders.get(i);
							User user = User.getUser(o.getUid());
					%>
					<tr class="text-c">
						<td><input type="checkbox" value="<%=o.getId()%>" name="orderid"></td>
						<td><%=o.getId()%></td>
						<td><u style="cursor: pointer" class="text-primary"
							onclick="member_show('<%=user.getUsername()%>','order-show.jsp?action=show&oid=<%=o.getId()%>','<%=o.getId()%>','360','400')"><%=user.getUsername()%></u></td>
						<td class="text-l"><%=o.getAddr()%></td>
						<td><%=o.getoDate().toString().substring(0, 10	)%></td>
						<%
							if (o.getStatus()==0) {
						%>
						<td class="td-status"><span
							class="label label-success radius">待支付</span></td>
						<td class="td-manage"><a style="text-decoration: none"
							onClick="member_stop(this,'<%=o.getId()%>')" href="javascript:;"
							title="待支付"> <i class="Hui-iconfont">&#xe631;</i></a> <%
 	}
 %> <%
 	if (o.getStatus()==2) {
 %>
						<td class="td-status"><span
							class="label label-defaunt radius">已支付</span></td>
						<td class="td-manage"><a style="text-decoration: none"
							onClick="member_start(this,'<%=o.getId()%>')" href="javascript:;"
							title="已支付"> <i class="Hui-iconfont">&#xe6e1;</i></a> <%
 	}
 %> 
							<a title="删除" href="javascript:;"
							onclick="member_del(this,'<%=o.getId()%>')" class="ml-5"
							style="text-decoration: none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
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
	<script type="text/javascript">
		/*批量删除*/
		function datadel() {
			 var oid_array = new Array();
	            $('input[name="orderid"]:checked').each(function () {
	                oid_array.push($(this).val());
	            });
	            location.href = 'order-manager.jsp?oid_array=' + oid_array + '&action_del=delete';
				//location.reload(true);
		}
		/*查看*/
		function member_show(title, url, id, w, h) {
			layer_show(title, url, w, h);
		}
		/*订单已经支付*/
		function member_stop(obj, id) {
			layer
					.confirm(
							'确认要更改为已付款吗？',
							function(index) {
								$(obj)
										.parents("tr")
										.find(".td-manage")
										.prepend(
												'<a style="text-decoration:none" onClick="member_start(this,id)" href="javascript:;" title="改为待支付"><i class="Hui-iconfont">&#xe6e1;</i></a>');
								$(obj)
										.parents("tr")
										.find(".td-status")
										.html(
												'<span class="label label-defaunt radius">已支付</span>');
								$(obj).remove();
								location.href = 'order-manager.jsp?id=' + id + '&action_stop=stop';
								location.reload(true);
								layer.msg('已支付!', {
									icon : 5,
									time : 1000
								});
							});
		}

		/*用户-改为待支付*/
		function member_start(obj, id) {
			layer
					.confirm(
							'确认要改为待支付吗？',
							function(index) {
								$(obj)
										.parents("tr")
										.find(".td-manage")
										.prepend(
												'<a style="text-decoration:none" onClick="member_stop(this,id)" href="javascript:;" title="改为已支付用"><i class="Hui-iconfont">&#xe631;</i></a>');
								$(obj)
										.parents("tr")
										.find(".td-status")
										.html(
												'<span class="label label-success radius">已改为待支付</span>');
								$(obj).remove();
								location.href = 'order-manager.jsp?id=' + id + '&action_start=start';
								location.reload(true);
								layer.msg('已改为待支付!', {
									icon : 6,
									time : 1000
								});
							});
		}
		/*订单-删除*/
		function member_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				layer.msg('已删除!', {
					icon : 1,
					time : 1000
				});
				location.href = 'order-manager.jsp?oid=' + id + '&action=delete';
				alert("删除成功");
				location.reload(true);
			});
			
		}
	</script>
</body>
</html>