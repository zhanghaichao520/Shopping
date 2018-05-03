<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.dao.UserDao"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	int res = 0;
request.setCharacterEncoding("utf-8");
List<Category> categories = Category.getCategories();
int count = 0;
User u = new User();
u.setId(0);
Enumeration<?>  enumeration = session.getAttributeNames();
while(enumeration.hasMoreElements()){
	String name = enumeration.nextElement().toString();
	if(name.equals("user")){
		u = (User)session.getAttribute(name);
		break;
	}
}
if(u.getId()==0){
	response.sendRedirect("notlogin.html");
}else{
	//修改个人信息
	String action_edit = request.getParameter("action_edit");
	if (action_edit != null && action_edit.equals("edit_user")) {
		String username = request.getParameter("username");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");
		u.setUsername(username);
		u.setPhone(phone);
		u.setAddr(addr);
		User.updateUser(u);
		res = 1;
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>修改个人资料</title>
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/shop_common.css" type="text/css" />
<link rel="stylesheet" href="css/shop_header.css" type="text/css" />
<link rel="stylesheet" href="css/shop_manager.css" type="text/css" />
<link rel="stylesheet" href="css/shop_form.css" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/topNav.js"></script>
<script src="H-ui.admin_v2.3.4/scripts/jquery/jquery-1.10.2.min.js"></script>
<script src="H-ui.admin_v2.3.4/scripts/plugins/layer/layer.js"></script>
</head>
<body>
	<script type="text/javascript">
		$(function() {
			if (
	<%=res%>
		== 1) {
				layer.msg("信息修改成功", {
					icon : 1
				});
			}
		});
		function checkinput() {
			if (form.username.value == "") {
				layer.msg("用户名不能为空", {
					icon : 2
				});
				$("#username").focus();
				return false;
			} else if (form.phone.value == "") {
				layer.msg("电话不能为空", {
					icon : 2
				});
				$("#phone").focus();
				return false;
			}else if (form.addr.value == "") {
				layer.msg("地址不能为空", {
					icon : 2
				});
				$("#addr").focus();
				return false;
			}
			return true;
		}
	</script>
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

		<!-- TopHeader Center -->
		<div class="shop_hd_header">
			<div class="shop_hd_header_logo">
				<h1 class="logo">
					<a href="/"><img src="images/logo.png" alt="ShopCZ" /></a><span>ShopCZ</span>
				</h1>
			</div>
			<div class="shop_hd_header_search">
				<ul class="shop_hd_header_search_tab">
					<li id="search" class="current">商品</li>
					<li id="shop_search">店铺</li>
				</ul>
				<div class="clear"></div>
				<div class="search_form">
					<form method="post" action="list.jsp">
						<div class="search_formstyle">
							<input type="hidden" name="action" value="search" /> <input
								type="text" class="search_form_text" name="keyword"
								placeholder="搜索其实很简单！" /> <input type="submit"
								class="search_form_sub" name="secrch_submit" value="" title="搜索" />
						</div>
					</form>
				</div>
				<div class="clear"></div>
				<div class="search_tag">
					<%
					for(int i = 0; i < categories.size(); i ++){
						Category c = categories.get(i);
						if(c.isIsleaf()){
				%>
					<a href="list.jsp?action_list=list&cid=<%=c.getId()%>"><%=c.getName() %></a>
					<%}
					if(i > 4) {
						break;
					}
				}%>
				</div>

			</div>
		</div>
		<div class="clear"></div>
		<!-- TopHeader Center End -->

		<!-- Header Menu -->
		<div class="shop_hd_menu">
			<!-- 所有商品菜单 -->
			<div id="shop_hd_menu_all_category" class="shop_hd_menu_all_category">
				<!-- 首页去掉 id="shop_hd_menu_all_category" 加上clsss shop_hd_menu_hover -->
				<div class="shop_hd_menu_all_category_title">
					<h2 title="所有商品分类">
						<a href="javascript:void(0);">所有商品分类</a>
					</h2>
					<i></i>
				</div>
				<div id="shop_hd_menu_all_category_hd"
					class="shop_hd_menu_all_category_hd">
					<ul class="shop_hd_menu_all_category_hd_menu clearfix">
						<!-- 单个菜单项 -->
						<%int k = 0;
							for(int i = 0; i < categories.size(); i ++){
								Category c = categories.get(i);
									if(Integer.parseInt(c.getGride())==1){
										k += 1;
						%>
						<li id="cat_<%=k %>" class="">
							<h3>
								<a href="#" title="男女服装"><%=c.getName() %></a>
							</h3>
							<div id="cat_1_menu" class="cat_menu clearfix" style="">
								<dl class="clearfix">
									<dd>
										<%
											for(int j = 0; j < categories.size(); j ++){
												Category c1 = categories.get(j);
												if(Integer.parseInt(c1.getGride())==2&&c1.getPid()==c.getId()){
										%>
										<a href="list.jsp?action_list=list&cid=<%=c1.getId()%>"><%=c1.getName() %></a>
										<%}} %>
									</dd>
								</dl>
								<%}} %>
								<li class="more"><a href="#">查看更多分类</a></li>
					</ul>
				</div>
			</div>
			<!-- 所有商品菜单 END -->

			<!-- 普通导航菜单 -->
			<ul class="shop_hd_menu_nav">
				<li class="current_link"><a href=""><span>首页</span></a></li>
				<li class="link"><a href="#"><span>团购</span></a></li>
				<li class="link"><a href="#"><span>品牌</span></a></li>
				<li class="link"><a href="#"><span>优惠卷</span></a></li>
				<li class="link"><a href="#"><span>积分中心</span></a></li>
				<li class="link"><a href="#"><span>专场</span></a></li>
				<li class="link"><a href="#"><span>微商城</span></a></li>
			</ul>
			<!-- 普通导航菜单 End -->
		</div>
		<!-- Header Menu End -->
	</div>
	<div class="clear"></div>
	<!-- 面包屑 注意首页没有 -->
	<div class="shop_hd_breadcrumb">
		<strong>当前位置：</strong> <span> <a href="index.jsp">首页</a>&nbsp;›&nbsp;
			<a href="">我的商城</a>&nbsp;›&nbsp; <a href="">已买到商品</a>
		</span>
	</div>
	<div class="clear"></div>
	<!-- 面包屑 End -->

	<!-- Header End -->

	<!-- 我的个人中心 -->
	<div class="shop_member_bd clearfix">
		<!-- 左边导航 -->
		<div class="shop_member_bd_left clearfix">

			<div class="shop_member_bd_left_pic">
				<a href="index.jsp"><img src="images/avatar.png" /></a>
			</div>
			<div class="clear"></div>

			<dl>
				<dt>我的交易</dt>
				<dd>
					<span><a href="order.jsp">已购买商品</a></span>
				</dd>
				<dd>
					<span><a href="favorite.jsp">我的收藏</a></span>
				</dd>
				<dd>
					<span><a href="comment.jsp">评价管理</a></span>
				</dd>
			</dl>

			<dl>
				<dt>我的账户</dt>
				<dd>
					<span><a href="member_info.jsp">个人资料</a></span>
				</dd>
				<dd>
					<span><a href="password_edit.jsp">密码修改</a></span>
				</dd>
			</dl>

		</div>
		<!-- 左边导航 End -->

		<!-- 右边购物列表 -->
		<div class="shop_member_bd_right clearfix">

			<div class="shop_meber_bd_good_lists clearfix">
				<div class="title">
					<h3>基本信息</h3>
				</div>
				<div class="clear"></div>
				<dic class="shop_home_form">
				<form name="form" action="member_info.jsp" id="form"
					class="shop_form" method="post" onsubmit="return checkinput()">
					<input type="hidden" name="action_edit" value="edit_user" />
					<ul>
						<li><label>用户名：</label><input type="text" id="username"
							name="username" class="truename form-text"
							value="<%=u.getUsername() %>" /></li>
						<li><label>手机:</label> <input type="text" class="input-text"
							value="<%=u.getPhone() %>" placeholder="" id="phone"
							name="phone" datatype="m" nullmsg="手机不能为空"></li>
						<li><label>地址:</label> <textarea name="addr" id="addr"
								cols="" rows="" class="textarea" placeholder="您的送货地址"
								dragonfly="true" onKeyUp="textarealength(this,100)"><%=u.getAddr() %></textarea></li>
						<li class="bn"><label>&nbsp;</label><input type="submit"
							class="form-submit" value="保存修改" /></li>
					</ul>
				</form>
			</div>
		</div>
	</div>
	<!-- 右边购物列表 End -->

	</div>
	<!-- 我的个人中心 End -->

	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<div class="shop_footer">
		<div class="shop_footer_link">
			<p>
				<a href="index.jsp">首页</a>| <a href="">招聘英才</a>| <a href="">广告合作</a>|
				<a href="">关于ShopCZ</a>| <a href="">关于我们</a>
			</p>
		</div>
		<div class="shop_footer_copy">
			<p>Copyright © 2017 zhanghaichao.,All rights reserved.</p>
		</div>
	</div>
	<!-- Footer End -->
</body>
</html>