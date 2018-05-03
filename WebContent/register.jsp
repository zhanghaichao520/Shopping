<%@page import="com.haichaoaixuexi.util.MD5"%>
<%@page import="com.haichaoaixuexi.util.Util"%>
<%@page import="com.haichaoaixuexi.dao.UserDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");
if(action != null && action.equals("register")){
	String username = request.getParameter("username");
	String password = request.getParameter("pwd");
	String repassword = request.getParameter("repwd");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	MD5 md5 = new MD5();
	password = md5.getMD5ofStr(username+password);
	User u = new User();
	u.setUsername(username);
	u.setPassword(password);
	u.setPhone(phone);
	u.setAddr(addr);
	u.setStatus("0");
	u.setRdate(new Timestamp(System.currentTimeMillis()));
	u.save(u);
	//session.setAttribute("user", u);
	response.sendRedirect("registerok.html");
}
	String sRand = "0000";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户注册</title>
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
function regist() {
	if (form.username.value=="") {
		layer.msg("用户名不能为空", {
			icon : 2
		});
		$("#username").focus();
		return false;
	}else if (form.username.value.length<2||form.username.value.length>16) {
		layer.msg("用户名请填写2到16位任意字符！", {
			icon : 2
		});
		$("#username").focus();
		return false;
	}else if (form.pwd.value.length<6||form.pwd.value.length>18) {
		layer.msg("密码请填写6到18位任意字符！", {
			icon : 2
		});
		$("#pwd").focus();
		return false;
	}else if (form.pwd.value=="") {
		layer.msg("密码不能为空", {
			icon : 2
		});
		$("#pwd").focus();
		return false;
	}else if (form.repwd.value=="") {
		layer.msg("请确认密码", {
			icon : 2
		});
		$("#repwd").focus();
		return false;
	}else if (form.phone.value=="") {
		layer.msg("电话不能为空", {
			icon : 2
		});
		$("#phone").focus();
		return false;
	}else if (form.addr.value=="") {
		layer.msg("地址不能为空", {
			icon : 2
		});
		$("#addr").focus();
		return false;
	}
	if(form.pwd.value!=form.repwd.value){
		layer.msg("密码不一致", {
			icon : 2
		});
		return false;
	}
	if (form.code.value != <%=sRand%>) {
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
		<a href="index.jsp"><img src="images/logo.png" alt="" /></a>
	</div>

	<div class="main">
		<div class="login-form fr">
			<div class="form-hd">
				<h3>用户注册</h3>
			</div>
			<div class="form-bd">
				<form name="form" id="form" action="register.jsp" method="POST" onsubmit="return regist()">
				<input type="hidden" name="action" value="register"/>
					<dl>
						<dt>用户名</dt>
						<dd>
							<input type="text" name="username" class="text" />
						</dd>
					</dl>
					<dl>
						<dt>密码</dt>
						<dd>
							<input type="password" name="pwd" class="text" />
						</dd>
					</dl>
					<dl>
						<dt>确认密码</dt>
						<dd>
							<input type="password" name="repwd" class="text" />
						</dd>
					</dl>
					<dl>
						<dt>电话</dt>
						<dd>
							<input type="text" name="phone" class="text" />
						</dd>
					</dl>
					<dl>
						<dt>地址</dt>
						<dd>
							<textarea rows="2" cols="20" name="addr"></textarea>
						</dd>
					</dl>
										<dl>
						<dt>验证码</dt>
						<dd>
							<input type="text" name="code" class="text" size="10"
								style="width: 58px;">
								 <img onClick="javascript:loadImage();"  title="换一张试试" id="randImage" 
				          			  src="${pageContext.request.contextPath}/image.jsp?code=<%=sRand %>" align="absmiddle" style="position: relative; top: -2px; align="absmiddle" />
								  <a onClick="javascript:loadImage();" style="color: #999;">看不清，换一张</a>
						</dd>
					</dl>
					<dl>
						<dt>&nbsp;</dt>
						<dd>
							<input type="submit" value="立即注册" class="submit" /> <input
								type="checkbox" checked="checked" />阅读并同意<a href=""
								class="forget">服务协议</a>
						</dd>
					</dl>
				</form>

			</div>
			<div class="form-ft"></div>
		</div>

		<div class="login-form-left fl">
			<dl class="func clearfix">
				<dt>注册之后您可以</dt>
				<dd class="ico05">
					<i></i>购买商品支付订单
				</dd>
				<dd class="ico01">
					<i></i>申请开店销售商品
				</dd>
				<dd class="ico03">
					<i></i>空间好友推送分享
				</dd>
				<dd class="ico02">
					<i></i>收藏商品关注店铺
				</dd>
				<dd class="ico06">
					<i></i>商品资讯服务评价
				</dd>
				<dd class="ico04">
					<i></i>安全交易诚信无忧
				</dd>
			</dl>

			<div class="if">
				<h2>如果您是本站用户</h2>
				<p>
					我已经注册过账号，立即 <a href="login.jsp" class="register">登录</a> 或是 <a href=""
						class="findpwd">找回密码？</a>
				</p>
			</div>
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