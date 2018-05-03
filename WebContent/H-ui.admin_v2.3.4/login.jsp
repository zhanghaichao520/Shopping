<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	if (action != null && action.equals("login")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		session.setAttribute("admin", "true");
		response.sendRedirect("index.jsp");

	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width" />
<title>后台登录</title>
<meta name="keywords" />
<meta name="description" />
<link href="styles/bootcss.css" rel="stylesheet" />
<link href="styles/common_new.css" rel="stylesheet" />
<link href="styles/login.css" rel="stylesheet" />
<script src="scripts/jquery/jquery-1.10.2.min.js"></script>
<script src="scripts/plugins/layer/layer.js"></script>
<script type="text/javascript">
	function loginCheck() {
		var userName = $("#username").val();
		var passWord = $("#password").val();
		if (userName == "") {
			layer.msg("用户名不能为空", {
				icon : 2
			});
			$("#username").focus();
			return false;
		} else if (passWord == "") {
			layer.msg("密码不能为空", {
				icon : 2
			});
			$("#password").focus();
			return false;
		} else {
			if (userName == "admin" && passWord == "admin") {
				return true;
			} else {
				layer.msg("用户名或密码错误", {
					icon : 2
				});
				return false;
			}
		}

	}
</script>
</head>
<body background="images/admin-login-bg.jpg">
	<section class="login_con">
	<div class="container-fluid max_width_1170">
		<div class="row">
			<div class="col-md-4 pull-right">
				<div class="form_con">
					<h3>后台登录</h3>
					<div class="form-group">
						<div class="alert alert-danger">
							<i class="fa fa-exclamation-triangle"></i>&nbsp;&nbsp;<span
								id="login_tips">请输入登录信息</span>
						</div>
					</div>
					<form name="form" action="login.jsp" method="POST"
						onsubmit="return loginCheck()">
						<input type="hidden" name="action" value="login" />
						<div class="form-group">
							<input type="text" class="form-control" id="username"
								name="username" maxlength="50" placeholder="请输入用户名">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="password"
								name="password" placeholder="请输入密码">
						</div>
						<div class="form-group">
							<div class="clearfix">
								<div class="checkbox fl">
									<label><input type="checkbox" id="IsRemember"
										name="IsRemember">自动登录</label>
								</div>
								<a class="c5bcd37 fr f12" href="/sso/getpassword" title="忘记密码">忘记密码?</a>
							</div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn_green" id="login_submit"
								onclick="login()">登录</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</section>
</body>
</html>