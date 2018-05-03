<%@page import="com.haichaoaixuexi.bean.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="_sessioncheck.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	User user = new User();
	user = User.getUser(Integer.parseInt(id));
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
<title>编辑用户</title>
</head>
<body>
	<div class="pd-20">
		<form action="/" method="post" class="form form-horizontal"
			id="form-admin-add" name="form-admin-add">
			<input type="hidden" name="action_edit" value="edit_user" />
			<div class="row cl">
				<label class="form-label col-3"><span class="c-red">*</span>用户名：</label>
				<div class="formControls col-5">
					<input type="text" class="input-text"
						value="<%=user.getUsername()%>" placeholder="" id="user-name"
						name="user-name" datatype="*2-16" nullmsg="用户名不能为空">
				</div>
				<div class="col-4"></div>
			</div>

			<div class="row cl">
				<label class="form-label col-3"><span class="c-red">*</span>手机：</label>
				<div class="formControls col-5">
					<input type="text" class="input-text" value="<%=user.getPhone()%>"
						placeholder="" id="user-phone" name="user-phone" datatype="m"
						nullmsg="手机不能为空">
				</div>
				<div class="col-4"></div>
			</div>

			<div class="row cl">
				<label class="form-label col-3">地址：</label>
				<div class="formControls col-5">
					<textarea name="user-addr" id = "user-addr" cols="" rows="" class="textarea"
						placeholder="您的送货地址" dragonfly="true"
						onKeyUp="textarealength(this,100)"><%=user.getAddr()%></textarea>
					<p class="textarea-numberbar">
						<em class="textarea-length">0</em>/100
					</p>
				</div>
				<div class="col-4"></div>
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-3">
					<input class="btn btn-primary radius" type="submit" onclick="tips()",
						value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript"
		src="lib/Validform/5.3.2/Validform.min.js"></script>
	<script type="text/javascript" src="lib/layer/2.1/layer.js"></script>
	<script type="text/javascript" src="js/H-ui.js"></script>
	<script type="text/javascript" src="js/H-ui.admin.js"></script>
	<script>
		$(function() {
			$("#form-admin-add").Validform({
				tiptype : 2,
				callback : function(form) {
					form[0].submit();
					var name = $("#user-name").val();
					var phone = $("#user-phone").val();
					var addr = $("#user-addr").val();
					var action_edit = "edit_user";
					$.ajax({
		                type: "post",
		                cache:false,
		                dataType:'text',
		                url: "member-list.jsp",
		                data: { action_edit: action_edit, user_name:name,user_phone:phone,user_addr:addr,id_edit:<%=id%>},
		            })
				}
			});

		});
		function tips() {
			location.reload(true);
		}
	</script>
</body>
</html>