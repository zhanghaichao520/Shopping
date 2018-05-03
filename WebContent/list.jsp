<%@page import="java.util.ArrayList"%>
<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
List<Product> latestProducts = Product.getLatestProducts(2);
request.setCharacterEncoding("utf-8");
User u = (User) session.getAttribute("user");
int count = 0;
if (u == null) {
	count = 0;
}
List<Category> categories = Category.getCategories();
List<Product> products = new ArrayList<Product>();
int PAGE_SIZE = 8;
int PAGE_NO = 1;
int cid = 0;
int pageCount;
String action_list = request.getParameter("action_list");
String strPageNo = request.getParameter("pageno");
if (action_list != null && action_list.equals("list")) {
	cid = Integer.parseInt(request.getParameter("cid"));
}
if (strPageNo != null) {
	PAGE_NO = Integer.parseInt(strPageNo);
}
if (PAGE_NO < 1) {
	PAGE_NO = 1;
}
pageCount = Product.getProducts(products, cid, PAGE_NO, PAGE_SIZE);
if (PAGE_NO > pageCount) {
	PAGE_NO = pageCount;
}
String action= request.getParameter("action");
if (action != null && action.equals("search")) {
	String keyWords = request.getParameter("keyword");
	products = Product.findProducts(keyWords, "-1", "-1", 1, 2);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<title>商品列表页</title>
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/shop_common.css" type="text/css" />
<link rel="stylesheet" href="css/shop_header.css" type="text/css" />
<link rel="stylesheet" href="css/shop_list.css" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/topNav.js"></script>
<script type="text/javascript" src="js/shop_list.js"></script>
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
								<a href="favorite.jsp" class="topNavHover">我的收藏<i></i></a>
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
					<a href="index.jsp"><img src="images/logo.png" alt="ShopCZ" /></a><span>ShopCZ</span>
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

<div id="shop_hd_menu_all_category" class="shop_hd_menu_all_category">				<!-- 首页去掉 id="shop_hd_menu_all_category" 加上clsss shop_hd_menu_hover -->
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
						<%int k = 0,x=categories.size();
							if(categories.size()>6){
								x = 6;
							}
							for(int i = 0; i < x; i ++){
								Category c = categories.get(i);
									if(Integer.parseInt(c.getGride())==1){
										k += 1;
						%>
						<li id="cat_<%=k %>" class="">
							<h3>
								<a href="#" title=""><%=c.getName() %></a>
							</h3>
							<div id="cat_1_menu" class="cat_menu clearfix" >
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
		<strong>当前位置：</strong> <span> <a href="">首页</a>&nbsp;›&nbsp; <a
			href="">商品分类</a>&nbsp;&nbsp;

		</span>
	</div>
	<div class="clear"></div>
	<!-- 面包屑 End -->

	<!-- Header End -->


	<!-- List Body 2013/03/27 -->
	<div class="shop_bd clearfix">
		<div class="shop_bd_list_left clearfix">

			<!-- 热卖推荐商品 -->
			<div class="shop_bd_list_bk clearfix">
				<div class="title">热卖推荐商品</div>
				<div class="contents clearfix">
					<ul class="clearfix">
						<%
						for(int i = 0; i < latestProducts.size(); i ++){
							Product p = latestProducts.get(i);							
					%>
						<li class="clearfix">
							<div class="goods_name">
								<a href="goods.jsp?id=<%=p.getId()%>"><%=p.getName() %></a>
							</div>
							<div class="goods_pic">
								<span class="goods_price">¥ <%=p.getMemberPrice() %>
								</span><a href="goods.jsp?id=<%=p.getId()%>"><img
											src="<%=p.getPicpath() %>" style="width: 150px;height:160px"/></a>
							</div>
							<div class="goods_xiaoliang">
								<span class="goods_xiaoliang_link"><a href="goods.jsp?id=<%=p.getId()%>">去看看</a></span> <span
									class="goods_xiaoliang_nums">已销售<strong>99</strong>笔
								</span>
							</div>
						</li>
						<%} %>
					</ul>
				</div>
			</div>
			<!-- 热卖推荐商品 -->
			<div class="clear"></div>

			<!-- 浏览过的商品 -->
			<div class="shop_bd_list_bk clearfix">
				<div class="title">浏览过的商品</div>
				<div class="contents clearfix">
					<ul class="clearfix">
						<%
						for(int i = 0; i < latestProducts.size(); i ++){
							Product p = latestProducts.get(i);							
					%>
						<li class="clearfix">
							<div class="goods_name">
								<a href="goods.jsp?id=<%=p.getId()%>"><%=p.getName() %></a>
							</div>
							<div class="goods_pic">
								<span class="goods_price">¥ <%=p.getMemberPrice() %>
								</span><a href="goods.jsp?id=<%=p.getId()%>"><img
											src="<%=p.getPicpath() %>" style="width: 150px;height:160px"/></a>
							</div>
							<div class="goods_xiaoliang">
								<span class="goods_xiaoliang_link"><a href="goods.jsp?id=<%=p.getId()%>">去看看</a></span> <span
									class="goods_xiaoliang_nums">已销售<strong>99</strong>笔
								</span>
							</div>
						</li>
						<%} %>

					</ul>
				</div>
			</div>
			<!-- 浏览过的商品 -->

		</div>

		<div class="shop_bd_list_right clearfix">
			<!-- 条件筛选框 -->
			<div class="module_filter">
				<div class="module_filter_line">
					<dl>
						<dt>分类：</dt>
						<dd>
							<%
						for(int i = 0; i < categories.size(); i ++){
							Category c = categories.get(i);
							if(!c.isIsleaf()){
						%>
							<span><a
								href="list.jsp?action_list=list&cid=<%=c.getId()%>"><%=c.getName() %></a></span>
							<%} }%>
						</dd>
					</dl>

				</div>
				<div class="bottom"></div>
			</div>
			<!-- 条件筛选框 -->

			<!-- 显示菜单 -->
			<div class="sort-bar">
				<div class="bar-l">
					<!-- 查看方式S -->
					<div class="switch">
						<span class="selected"><a title="以方格显示" ecvalue="squares"
							nc_type="display_mode" class="pm" href="javascript:void(0)">大图</a></span><span
							style="border-left: none;"><a title="以列表显示" ecvalue="list"
							nc_type="display_mode" class="lm" href="javascript:void(0)">列表</a></span>
					</div>
					<!-- 查看方式E -->
					<!-- 排序方式S -->
					<ul class="array">
						<li class="selected"><a title="默认排序"
							onclick="javascript:dropParam(['key','order'],'','array');"
							class="nobg" href="javascript:void(0)">默认</a></li>
						<li><a title="点击按销量从高到低排序"
							onclick="javascript:replaceParam(['key','order'],['sales','desc'],'array');"
							href="javascript:void(0)">销量</a></li>
						<li><a title="点击按人气从高到低排序"
							onclick="javascript:replaceParam(['key','order'],['click','desc'],'array');"
							href="javascript:void(0)">人气</a></li>
						<li><a title="点击按信用从高到低排序"
							onclick="javascript:replaceParam(['key','order'],['credit','desc'],'array');"
							href="javascript:void(0)">信用</a></li>
						<li><a title="点击按价格从高到低排序"
							onclick="javascript:replaceParam(['key','order'],['price','desc'],'array');"
							href="javascript:void(0)">价格</a></li>
					</ul>
					<!-- 排序方式E -->
					<!-- 价格段S -->
					<div class="prices">
						<em>¥</em> <input type="text" value="" class="w30"> <em>-</em>
							<input type="text" value="" class="w30"> <input
								type="submit" value="确认" id="search_by_price">
					</div>
					<!-- 价格段E -->
				</div>
			</div>
			<div class="clear"></div>
			<!-- 显示菜单 End -->

			<!-- 商品列表 -->
			<div class="shop_bd_list_content clearfix">
				<ul>
					<%
						for(int i = 0; i < products.size(); i ++){
							Product p = products.get(i);
					%>
					<li>
						<dl>
							<dt>
								<a href="goods.jsp?id=<%=p.getId()%>"><img
											src="<%=p.getPicpath() %>" style="width: 150px;height:160px"/></a>
							</dt>
							<dd class="title">
								<a href="goods.jsp?id=<%=p.getId()%>"><%=p.getName() %></a>
							</dd>
							<dd class="content">
								<span class="goods_jiage">￥<strong><%=p.getMemberPrice() %></strong></span>
								<span class="goods_chengjiao">最近成交5笔</span>
							</dd>
						</dl>
					</li>
					<%} %>

				</ul>
			</div>
			<div class="clear"></div>
			<div class="pagination">
				<%if (action == null ) {%>
				<ul>
					<li><span><a
							href="list.jsp?cid=<%=cid%>&action_list=list&pageno=1">首页</a></span></li>
					<li><span><a
							href="list.jsp?cid=<%=cid%>&action_list=list&pageno=<%=PAGE_NO - 1%>">上一页</a></span></li>
					<%
					for(int i = 0; i < pageCount; i ++){
						if(PAGE_NO != i+1){
					%>
					<li><span><a
							href="list.jsp?cid=<%=cid%>&action_list=list&pageno=<%=i+1%>"><%=i+1%></a></span></li>
					<%}else{ %>
					<li><span class="currentpage"><%=PAGE_NO%></span></li>

					<%}}
						if (pageCount > PAGE_NO) {
					%>
					<li><span><a
							href="list.jsp?cid=<%=cid%>&action_list=list&pageno=<%=PAGE_NO + 1%>">下一页</a></span></li>
					<%} %>
					<li><span><a
							href="list.jsp?cid=<%=cid%>&action_list=list&pageno=<%=pageCount%>">末页</a></span></li>
				</ul>
				<%} %>
			</div>
			<!-- 商品列表 End -->


		</div>
	</div>
	<!-- List Body End -->

	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<div class="shop_footer">
		<div class="shop_footer_link">
			<p>
				<a href="">首页</a>| <a href="">招聘英才</a>| <a href="">广告合作</a>| <a
					href="">关于ShopCZ</a>| <a href="">关于我们</a>
			</p>
		</div>
		<div class="shop_footer_copy">
			<p>Copyright zhanghaichao,All rights reserved.</p>
		</div>
	</div>
	<!-- Footer End -->

</body>
</html>