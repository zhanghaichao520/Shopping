<%@page import="com.haichaoaixuexi.util.MD5"%>
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
	List<User> users = null;
	users = User.getUsers();
	int count = 0;
	for (int i = 0; i < users.size(); i++) {
		User u = users.get(i);
		if (u.getStatus().equals("0")) {
			count++;
		}
	}
	//删除会员
	String action = request.getParameter("action");
	if (action != null && action.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("id"));
		User.delUser(id);
	}
	//批量删除会员
	String action_del = request.getParameter("action_del");
	if (action_del != null && action_del.equals("delete")) {
		String id_array = request.getParameter("id_array");
		String[] ids = id_array.split(",");
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			User.delUser(id);
		}
		response.sendRedirect("member-list.jsp");
	}

	//修改密码
	String action_changepwd = request.getParameter("action_changepwd");
	if (action_changepwd != null && action_changepwd.equals("change_password")) {
		String new_password = request.getParameter("new_password");
		MD5 md5 = new MD5();
		new_password = md5.getMD5ofStr(new_password);
		int id_changepwd = Integer.parseInt(request.getParameter("id_changepwd"));
		User.changePassword(id_changepwd, new_password);
	}
	//修改会员信息
	String action_edit = request.getParameter("action_edit");
	if (action_edit != null && action_edit.equals("edit_user")) {
		String name = request.getParameter("user_name");
		String phone = request.getParameter("user_phone");
		String addr = request.getParameter("user_addr");
		int id_edit = Integer.parseInt(request.getParameter("id_edit"));
		User.changeUserInfo(id_edit, name, phone, addr);
		out.print("<script>alert('success!');</script>");

	}
	//停用会员
	String action_stop = request.getParameter("action_stop");
	if (action_stop != null && action_stop.equals("stop")) {
		int id = Integer.parseInt(request.getParameter("id"));
		User.stopUser(id);
	}
	//启用会员
	String action_start = request.getParameter("action_start");
	if (action_start != null && action_start.equals("start")) {
		int id = Integer.parseInt(request.getParameter("id"));
		User.startUser(id);
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
<title>用户管理</title>
</head>
<body>
	<nav class="breadcrumb"> <i class="Hui-iconfont">&#xe67f;</i> 首页
	<span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span>
	用户管理 <a class="btn btn-success radius r mr-20"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<span class="l"><a href="javascript:;" onclick="datadel()"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a></span> <span class="r">共有数据：<strong><%=count%></strong> 条
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
							if (u.getStatus().equals("1"))
								continue;
					%>
					<tr class="text-c">
						<td><input type="checkbox" value="<%=u.getId()%>"
							name="userid"></td>
						<td><%=u.getId()%></td>
						<td><u style="cursor: pointer" class="text-primary"
							onclick="member_show('<%=u.getUsername()%>','member-show.html','<%=u.getId()%>','360','400')"><%=u.getUsername()%></u></td>
						<td><%=u.getPhone()%></td>
						<td class="text-l"><%=u.getAddr()%></td>
						<td><%=u.getRdate()%></td>
						<%
							if (u.getStatus().equals("0")) {
						%>
						<td class="td-status"><span
							class="label label-success radius">已启用</span></td>
						<td class="td-manage"><a style="text-decoration: none"
							onClick="member_stop(this,'<%=u.getId()%>')" href="javascript:;"
							title="停用"> <i class="Hui-iconfont">&#xe631;</i></a> <%
 	}
 %> <%
 	if (u.getStatus().equals("2")) {
 %>
						<td class="td-status"><span
							class="label label-defaunt radius">已停用</span></td>
						<td class="td-manage"><a style="text-decoration: none"
							onClick="member_start(this,'<%=u.getId()%>')" href="javascript:;"
							title="启用"> <i class="Hui-iconfont">&#xe6e1;</i></a> <%
 	}
 %> <a title="编辑" href="javascript:;"
							onclick="member_edit('编辑','member-add.jsp?id='+<%=u.getId()%>,'<%=u.getId()%>','700px','410px')"
							class="ml-5" style="text-decoration: none"><i
								class="Hui-iconfont">&#xe6df;</i></a> <a
							style="text-decoration: none" class="ml-5"
							onClick="change_password('修改密码','change-password.jsp?id='+<%=u.getId()%>,'<%=u.getId()%>','700px','410px')"
							href="javascript:;" title="修改密码"><i class="Hui-iconfont">&#xe63f;</i></a>
							<a title="删除" href="javascript:;"
							onclick="member_del(this,'<%=u.getId()%>')" class="ml-5"
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
			 var id_array = new Array();
	            $('input[name="userid"]:checked').each(function () {
	                id_array.push($(this).val());
	            });
	            location.href = 'member-list.jsp?id_array=' + id_array + '&action_del=delete';
				//location.reload(true);
		}
		/*用户-查看*/
		function member_show(title, url, id, w, h) {
			layer_show(title, url, w, h);
		}
		/*用户-停用*/
		function member_stop(obj, id) {
			layer
					.confirm(
							'确认要停用吗？',
							function(index) {
								$(obj)
										.parents("tr")
										.find(".td-manage")
										.prepend(
												'<a style="text-decoration:none" onClick="member_start(this,id)" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>');
								$(obj)
										.parents("tr")
										.find(".td-status")
										.html(
												'<span class="label label-defaunt radius">已停用</span>');
								$(obj).remove();
								location.href = 'member-list.jsp?id=' + id + '&action_stop=stop';
								location.reload(true);
								layer.msg('已停用!', {
									icon : 5,
									time : 1000
								});
							});
		}

		/*用户-启用*/
		function member_start(obj, id) {
			layer
					.confirm(
							'确认要启用吗？',
							function(index) {
								$(obj)
										.parents("tr")
										.find(".td-manage")
										.prepend(
												'<a style="text-decoration:none" onClick="member_stop(this,id)" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>');
								$(obj)
										.parents("tr")
										.find(".td-status")
										.html(
												'<span class="label label-success radius">已启用</span>');
								$(obj).remove();
								location.href = 'member-list.jsp?id=' + id + '&action_start=start';
								location.reload(true);
								layer.msg('已启用!', {
									icon : 6,
									time : 1000
								});
							});
		}
		/*用户-编辑*/
		function member_edit(title, url, id, w, h) {
			layer.open({
                id: 'edit-form',
                type: 2,
                title: title,
                shadeClose: true,
                shade: 0.3,
                area: [w, h],
                content: url,
                end:function(){
                  location.reload(true);
        		}
            });
		}
		/*密码-修改*/
		function change_password(title, url, id, w, h) {
			layer.open({
                id: 'delete-form',
                type: 2,
                title: title,
                shadeClose: true,
                shade: 0.3,
                area: [w, h],
                content: url,
                end:function(){
                	layer.msg('修改成功!', {
						icon : 1,
						time : 1000
					});
        		}
            });
		}
		/*用户-删除*/
		function member_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				layer.msg('已删除!', {
					icon : 1,
					time : 1000
				});
				location.href = 'member-list.jsp?id=' + id + '&action=delete';
				alert("删除成功");
				location.reload(true);
			});
			
		}
	</script>
</body>
</html>