<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@page import="com.haichaoaixuexi.bean.SalesOrder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String action_pay = request.getParameter("action_pay");
if (action_pay != null && action_pay.equals("pay")) {
	String oidString = request.getParameter("oid");
	SalesOrder salesOrder = SalesOrder.getSalesOrdersById(Integer.parseInt(oidString));
	salesOrder.setStatus(2);
	SalesOrder.updateSalesOrder(salesOrder);
	response.sendRedirect("order.jsp");
}
List<Category> categories = Category.getCategories();
User u = (User) session.getAttribute("user");
int count = 0;
if (u == null) {
	count = 0;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>付款界面</title>
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/shop_common.css" type="text/css" />
<link rel="stylesheet" href="css/shop_header.css" type="text/css" />
<link rel="stylesheet" href="css/shop_home.css" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/topNav.js"></script>
<script type="text/javascript" src="js/focus.js"></script>
<script type="text/javascript" src="js/shop_home_tab.js"></script>
</head>
<body>
	<!-- Header  -wll-2013/03/24 -->
	<div class="shop_hd">
		<!-- Header TopNav -->
		<div class="shop_hd_topNav">
			<div class="shop_hd_topNav_all">
				<!-- Header TopNav Left -->
				<div class="shop_hd_topNav_all_left">
					<%
					if(u==null){
					%>
					<p>
						您好，欢迎来到<b><a href="/">ShopCZ商城</a></b>[<a href="login.jsp">登录</a>][<a
							href="register.jsp">注册</a>]
					</p>
					<%
					}else{
				%>
					<p>
						欢迎你，<%=u.getUsername() %>&nbsp;&nbsp;&nbsp;&nbsp;[<a
							href="login.jsp">注销</a>]
					</p>
					<%		
					}
				%>
				</div>
				<!-- Header TopNav Left End -->

				<!-- Header TopNav Right -->
				<div class="shop_hd_topNav_all_right">
					<ul class="topNav_quick_menu">

						<li>
							<div class="topNav_menu">
								<a href="#" class="topNavHover">我的商城<i></i></a>
								<div class="topNav_menu_bd" style="display: none;">
									<ul>
										<li><a title="已买到的商品" target="_top" href="order.jsp">已买到的商品</a></li>
										<li><a title="个人主页" target="_top" href="member_info.jsp">个人主页</a></li>
									</ul>
								</div>
							</div>
						</li>
						<li>
							<div class="topNav_menu">
								<a href="#" class="topNavHover">卖家中心<i></i></a>
								<div class="topNav_menu_bd" style="display: none;">
									<ul>
										<li><a title="已售出的商品" target="_top" href="#">已售出的商品</a></li>
										<li><a title="销售中的商品" target="_top" href="#">销售中的商品</a></li>
									</ul>
								</div>
							</div>
						</li>

						<li>
							<div class="topNav_menu">
								<a href="flow.jsp" class="topNavHover">购物车<b><%=count %></b>种商品<i></i></a>
								<div class="topNav_menu_bd" style="display: none;">
									<!--
						            <ul>
						              <li><a title="已售出的商品" target="_top" href="#">已售出的商品</a></li>
						              <li><a title="销售中的商品" target="_top" href="#">销售中的商品</a></li>
						            </ul>
						        	-->
						        	<%if(count==0){ %>
									<p>还没有商品，赶快去挑选！</p>
									<% }%>
								</div>
							</div>
						</li>

						<li>
							<div class="topNav_menu">
								<a href="#" class="topNavHover">我的收藏<i></i></a>
								<div class="topNav_menu_bd" style="display: none;">
									<ul>
										<li><a title="收藏的商品" target="_top" href="favorite.jsp">收藏的商品</a></li>
										<li><a title="收藏的店铺" target="_top" href="#">收藏的店铺</a></li>
									</ul>
								</div>
							</div>
						</li>

						<li>
							<div class="topNav_menu">
								<a href="#">站内消息</a>
							</div>
						</li>

					</ul>
				</div>
				<!-- Header TopNav Right End -->
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<!-- Header TopNav End -->
请支付<%=request.getParameter("total") %>元
<center >
<img width="400px" height="600px" src="images/pay.jpg" />
<br /><br />
<form action="pay.jsp" method="post">
<input type="hidden" name="action_pay" value="pay" />
<input type="hidden" name="oid" value="<%=request.getParameter("oid")%>" />
<input type="submit" value="我已经支付成功" />
</form>
</center>
</body>
</html>