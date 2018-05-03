<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@page import="com.haichaoaixuexi.bean.Cart"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	User u = (User) session.getAttribute("user");
	List<Category> categories = Category.getCategories();
	int count = 0;
	double total = 0;
	List<Cart> carts = null;
	if (u == null) {
		response.sendRedirect("notlogin.html");
	} else {
		carts = Cart.getCartsByUid(u.getId());
		count = carts.size();
	}
	//删除
	String action_del = request.getParameter("action_del");
	if (action_del != null && action_del.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("id_del"));
		Cart.deleteCartById(id);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>购物车页面</title>
<script type="text/javascript" src="H-ui.admin_v2.3.4/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="H-ui.admin_v2.3.4/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="H-ui.admin_v2.3.4/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="H-ui.admin_v2.3.4/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="H-ui.admin_v2.3.4/js/H-ui.js"></script>
<script type="text/javascript" src="H-ui.admin_v2.3.4/js/H-ui.admin.js"></script>
<script type="text/javascript">
function cart_del(obj, id) {
	layer.confirm('确认要删除吗？', function(index) {
		layer.msg('已删除!', {
			icon : 1,
			time : 1000
		});
		alert("删除成功");
		location.href = 'flow.jsp?id_del=' + id + '&action_del=delete';
	});
	
}
</script>
<link rel="stylesheet" href="css/base.css" type="text/css" />
<link rel="stylesheet" href="css/shop_common.css" type="text/css" />
<link rel="stylesheet" href="css/shop_header.css" type="text/css" />
<link rel="stylesheet" href="css/shop_gouwuche.css" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/topNav.js"></script>
<script type="text/javascript" src="js/jquery.goodnums.js"></script>
<script type="text/javascript" src="js/shop_gouwuche.js"></script>

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
		<strong>当前位置：</strong> <span> <a href="">首页</a>&nbsp;›&nbsp; <a
			href="">我的商城</a>&nbsp;›&nbsp; <a href="">我的购物车</a>
		</span>
	</div>
	<div class="clear"></div>
	<!-- 面包屑 End -->

	<!-- Header End -->

	<!-- 购物车 Body -->
	<div class="shop_gwc_bd clearfix">
		<!-- 在具体实现的时候，根据情况选择其中一种情况 -->
		<%if(count==0){ %>
		<!-- 购物车为空 -->
		<div class="empty_cart mb10">
			<div class="message">
				<p>
					购物车内暂时没有商品，您可以<a href="index.jsp">去首页</a>挑选喜欢的商品
				</p>
			</div>
		</div>
		<!-- 购物车为空 end-->
		<%}else{ %>
		<!-- 购物车有商品 -->
		<div class="shop_gwc_bd_contents clearfix">
			<!-- 购物流程导航 -->
			<div class="shop_gwc_bd_contents_lc clearfix">
				<ul>
					<li class="step_a hover_a">确认购物清单</li>
					<li class="step_b">确认收货人资料及送货方式</li>
					<li class="step_c">购买完成</li>
				</ul>
			</div>
			<!-- 购物流程导航 End -->

			<!-- 购物车列表 -->
			<form action="flow2.jsp" method="post">
			<input type="hidden" name="action" value="updateCart" />
			<input type="hidden" name="count" value="<%=count %>" />
			<table>
				<thead>
					<tr>
						<th colspan="2"><span>商品</span></th>
						<th><span>单价(元)</span></th>
						<th><span>数量</span></th>
						<th><span>小计</span></th>
						<th><span>操作</span></th>
					</tr>
				</thead>
				<tbody>
					<%
						for(int i = 0; i < carts.size(); i ++){
							Cart c = carts.get(i);	
							Product p = Product.getProductById(c.getPid());
							total += Double.parseDouble(p.getMemberPrice())*c.getCount();
					%>
					<tr>
						<td class="gwc_list_pic"><a href=""><img
											src="<%=p.getPicpath() %>" style="width: 50px;height:60px"/></a></td>
						<td class="gwc_list_title"><a href="goods.jsp?id=<%=p.getId()%>"><%=p.getName() %>
						</a></td>
						<td class="gwc_list_danjia"><span>￥<strong
								id="danjia_00<%=p.getId() %>"><%=p.getMemberPrice() %></strong></span></td>
						<td class="gwc_list_shuliang"><span><a
								class="good_num_jian this_good_nums" did="danjia_00<%=p.getId() %>"
								xid="xiaoji_00<%=p.getId() %>" ty="-" valId="goods_00<%=p.getId() %>"
								href="javascript:void(0);">-</a><input type="text" value="<%=c.getCount() %>"
								name="goods_00<%=p.getId() %>" id="goods_00<%=p.getId() %>" class="good_nums" /><a
								href="javascript:void(0);" did="danjia_00<%=p.getId() %>" xid="xiaoji_00<%=p.getId() %>"
								max = "1000" ty="+" class="good_num_jia this_good_nums" valId="goods_00<%=p.getId() %>">+</a></span></td>
						<td class="gwc_list_xiaoji"><span>￥<strong
								id="xiaoji_00<%=p.getId() %>" class="good_xiaojis"><%=Double.parseDouble(p.getMemberPrice())*c.getCount()%></strong></span></td>
						<td class="gwc_list_caozuo"><a href="">收藏</a><a
							onClick="cart_del(this,'<%=c.getId()%>')">删除</a></td>
					</tr>
				<%} %>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6">
							<div class="gwc_foot_zongjia">
								商品总价(不含运费)<span>￥<strong id="good_zongjia"><%=total %></strong></span>
							</div>
							<div class="clear"></div>
							<div class="gwc_foot_links">
								<a href="index.jsp" class="go">继续购物</a> 
								<input type="submit" class="op" value="确认并填写订单" />
							</div>
						</td>
					</tr>
				</tfoot>
			</table>
			</form>
			<!-- 购物车列表 End -->
		</div>
		<!-- 购物车有商品 end -->
	<%} %>
	</div>
	<!-- 购物车 Body End -->

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
			<p>Copyright zhanghaichao.,All rights reserved.</p>
		</div>
	</div>
	<!-- Footer End -->

</body>
</html>