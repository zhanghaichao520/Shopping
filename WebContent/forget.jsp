<%@page import="com.haichaoaixuexi.util.emailSend"%>
<%@page import="com.haichaoaixuexi.util.Util"%>
<%@page import="java.util.Random"%>
<%@page import="com.haichaoaixuexi.bean.UserDeleteException"%>
<%@page import="com.haichaoaixuexi.bean.UserStopException"%>
<%@page import="com.haichaoaixuexi.data.Const"%>
<%@page import="com.haichaoaixuexi.bean.PasswordNotCorrectException"%>
<%@page import="com.haichaoaixuexi.bean.UserNotFindException"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	int res = 0; 
	if (action != null && action.equals("forget")) {
		String username = request.getParameter("user");
		String email = request.getParameter("email");
		if(User.userExist(username)){
			User user =User.getUserByUsername(username);
			try {
				emailSend.sendEmail(user,email);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.println("<script >alert('找回成功，请去邮箱查收密码');</script>");
			response.sendRedirect("login.jsp");
		}
	}

	String sRand="0000";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>密码找回</title>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/global.css" />
<link rel="stylesheet" href="css/login-register.css" />
<script src="H-ui.admin_v2.3.4/scripts/jquery/jquery-1.10.2.min.js"></script>
<script src="H-ui.admin_v2.3.4/scripts/plugins/layer/layer.js"></script>
</head>
<body>
	<script type="text/javascript">
    function loadImage(){
    	<%
    		sRand = Util.getRandom();
    	%>
	     document.getElementById("randImage").src = "${pageContext.request.contextPath}/image.jsp?code=<%=Util.getRandom()%>"+Math.random(); //Math.random()
        }
	$(function() {
		if (
<%=res%>
	== 1) {
			layer.msg("用户不存在，先去注册好吗", {
				icon : 2
			});
		} 
	});
		function onforget() {
			if (form.user.value == "") {
				layer.msg("不输入用户名无法找回", {
					icon : 2
				});
				$("#user").focus();
				return false;
			} else if (form.email.value == "") {
				layer.msg("不输入邮箱我发给谁", {
					icon : 2
				});
				$("#pwd").focus();
				return false;
			}else if (form.code.value == "") {
				layer.msg("请输入验证码", {
					icon : 2
				});
				$("#code").focus();
				return false;
			}else if (form.code.value != <%=sRand%>) {
				layer.msg("验证码错误", {
					icon : 2
				});
				$("#code").focus();
				return false;
			}
			return true;
		}
	</script>

	<div class="header wrap1000">
		<a href=""><img src="images/logo.png" alt="" /></a>
	</div>

	<div class="main">
		<div class="login-form fr">
			<div class="form-hd">
				<h3>密码找回</h3>
			</div>
			<div class="form-bd">
				<form name="form" id="form" action="forget.jsp" method="POST"
					onsubmit="return onforget()">
					<input type="hidden" name="action" value="forget" />
					<dl>
						<dt>用户名</dt>
						<dd>
							<input type="text" name="user" id="user" class="text" />
						</dd>
					</dl>
					<dl>
						<dt>邮&nbsp;&nbsp;&nbsp;&nbsp;箱</dt>
						<dd>
							<input type="text" name="email" id="email" class="text" />
						</dd>
					</dl>
					<dl>
						<dt>验证码</dt>
						<dd>
							<input type="text" name="code" class="text" size="10"
								style="width: 58px;"> <img
								onClick="javascript:loadImage();" title="换一张试试" id="randImage"
								src="${pageContext.request.contextPath}/image.jsp?code=<%=sRand %>"
								align="absmiddle" style="position: relative; top: -2px;" absmiddle" />
							<a onClick="javascript:loadImage();" style="color: #999;">看不清，换一张</a>
						</dd>
					</dl>
					<dl>
						<dt>&nbsp;</dt>
						<dd>
							<input type="submit" value="找 回" class="submit" />
						</dd>
					</dl>
				</form>
				<dl>
					<dt>&nbsp;</dt>
					<dd>
						还不是本站会员？立即 <a href="register.jsp" class="register">注册</a>
					</dd>
				</dl>
				<dl class="other">
					<dt>&nbsp;</dt>
					<dd>
						<p>您可以用合作伙伴账号登录：</p>
						<a href="" class="qq"></a> <a href="" class="sina"></a>
					</dd>
				</dl>
			</div>
			<div class="form-ft"></div>
		</div>

		<div class="login-form-left fl">
			<img src="images/left.jpg" alt="" />
		</div>
	</div>

	<div class="footer clear wrap1000">
		<p>
			<a href="">首页</a> | <a href="">招聘英才</a> | <a href="">广告合作</a> | <a
				href="">关于ShopCZ</a> | <a href="">联系我们</a>
		</p>
		<p>Copyright © 2017 zhanghaichao.,All rights reserved.</p>
	</div>


</body>
</html>