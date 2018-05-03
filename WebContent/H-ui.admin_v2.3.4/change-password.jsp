<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ include file="_sessioncheck.jsp"%>
	
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");

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
<title>修改密码</title>
</head>
<body>
	<div class="pd-20">
		<form action="/" method="post"
			class="form form-horizontal" id="form-change-password"
			name="form-change-password">
			<input type="hidden" name="action_changepwd" value="change_password" />
			<div class="row cl">
				<label class="form-label col-4"><span class="c-red">*</span>用户id
					：</label>
				<div class="formControls col-4"><%=id%></div>
				<div class="col-4"></div>
			</div>
			<div class="row cl">
				<label class="form-label col-4"><span class="c-red">*</span>新密码：</label>
				<div class="formControls col-4">
					<input type="password" class="input-text" autocomplete="off"
						placeholder="不修改请留空" name="new-password" id="new-password"
						datatype="*6-18" ignore="ignore">
				</div>
				<div class="col-4"></div>
			</div>
			<div class="row cl">
				<label class="form-label col-4"><span class="c-red">*</span>确认密码：</label>
				<div class="formControls col-4">
					<input type="password" class="input-text" autocomplete="off"
						placeholder="不修改请留空" name="new-password2" id="new-password2"
						recheck="new-password" datatype="*6-18" errormsg="您两次输入的密码不一致！"
						ignore="ignore">
				</div>
				<div class="col-4"></div>
			</div>
			<div class="row cl">
				<div class="col-8 col-offset-4">
					<input class="btn btn-primary radius" type="submit"
						value="&nbsp;&nbsp;保存&nbsp;&nbsp;">
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
			$("#form-change-password").Validform({
				tiptype : 2,
				callback : function(form) {
					form[0].submit();
					var pwd = $("#new-password").val();
					var pwd2 = $("#new-password2").val();
					var action_changepwd = "change_password";
					if(pwd2 == ""){
						action_changepwd = "notchange_password";
					}
					var j$ = jQuery.noConflict();
					j$.ajax({
		                type: "post",
		                url: "member-list.jsp",
		                data: { action_changepwd: action_changepwd, new_password:pwd,id_changepwd:<%=id%>},
		            })
					var index = parent.layer.getFrameIndex(window.name);
					parent.layer.close(index);
					layer.msg('修改成功!', {
						icon : 1,
						time : 1000
					});
				}
			});

		});
	</script>
</body>
</html>