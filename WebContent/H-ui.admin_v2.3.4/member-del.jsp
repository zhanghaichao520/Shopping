<%@page import="com.haichaoaixuexi.bean.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="_sessioncheck.jsp"%>
<%
	List<User> users = User.getUsers();
	int count = 0;
	for (int i = 0; i < users.size(); i++) {
		User u = users.get(i);
		if (u.getStatus().equals("1")) {
			count++;
		}
	}
	//永久删除会员
	String action_del = request.getParameter("action_del");
	if (action_del != null && action_del.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("id"));
		User.delUserForever(id);
	}
	//批量永久删除会员
	String action_delall = request.getParameter("action_delall");
	if (action_delall != null && action_delall.equals("deleteall")) {
		String id_array = request.getParameter("id_array");
		String[] ids = id_array.split(",");
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			User.delUserForever(id);
		}
		response.sendRedirect("member-del.jsp");
	}
	//还原会员
	String action_huanyuan = request.getParameter("action_huanyuan");
	if (action_huanyuan != null && action_huanyuan.equals("huanyuan")) {
		int id = Integer.parseInt(request.getParameter("id"));
		User.startUser(id);
	}
%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet"
	type="text/css" />
<title>删除的用户</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		用户中心 <span class="c-gray en">&gt;</span> 删除的用户<a
			class="btn btn-success radius r mr-20"
			style="line-height: 1.6em; margin-top: 3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a href="javascript:;" onclick="datadel()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a> </span> <span class="r">共有数据：<strong><%=count%></strong> 条
			</span>
		</div>
		<div class="mt-20">
			<table
				class="table table-border table-bordered table-hover table-bg table-sort">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" name="" value=""></th>
						<th width="80">ID</th>
						<th width="100">用户名</th>
						<th width="90">手机</th>
						<th width="200">地址</th>
						<th width="130">加入时间</th>
						<th width="70">状态</th>
						<th width="100">操作</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < users.size(); i++) {
							User u = users.get(i);
							if (!u.getStatus().equals("1"))
								continue;
					%>
					<tr class="text-c">
						<td><input type="checkbox" value="<%=u.getId()%>"
							name="userid"></td>
						<td><%=u.getId()%></td>
						<td><u style="cursor: pointer" class="text-primary"
							onclick="member_show('<%=u.getUsername()%>','member-show.html','<%=u.getId()%>','360','400')">
								<%=u.getUsername()%>
						</u></td>
						<td><%=u.getPhone()%></td>
						<td class="text-l"><%=u.getAddr()%></td>
						<td><%=u.getRdate()%></td>
						<td class="td-status"><span class="label label-danger radius">已删除</span></td>
						<td class="td-manage"><a style="text-decoration: none"
							href="javascript:;"
							onClick="member_huanyuan(this,'<%=u.getId()%>')" title="还原"><i
								class="Hui-iconfont">&#xe66b;</i></a> <a title="删除"
							href="javascript:;" onclick="member_del(this,'<%=u.getId()%>')"
							class="ml-5" style="text-decoration: none"><i
								class="Hui-iconfont">&#xe6e2;</i></a></td>
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
	<script type="text/javascript"
		src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="js/H-ui.js"></script>
	<script type="text/javascript" src="js/H-ui.admin.js"></script>
	<script type="text/javascript">
		/*批量删除*/
		function datadel() {
			var id_array = new Array();
			$('input[name="userid"]:checked').each(function() {
				id_array.push($(this).val());
			});
			location.href = 'member-del.jsp?id_array=' + id_array
					+ '&action_delall=deleteall';
		}
		/*用户-还原*/
		function member_huanyuan(obj, id) {
			layer.confirm('确认要还原吗？', function(index) {
				location.href = 'member-del.jsp?id=' + id
						+ '&action_huanyuan=huanyuan';
				layer.msg('已还原!', {
					icon : 6,
					time : 1000
				});
				location.reload(true);
			});
		}

		/*用户-删除*/
		function member_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				location.href = 'member-del.jsp?id=' + id
						+ '&action_del=delete';
				layer.msg('已删除!', {
					icon : 1,
					time : 1000
				});
				location.reload(true);
			});
		}
	</script>
</body>
</html>