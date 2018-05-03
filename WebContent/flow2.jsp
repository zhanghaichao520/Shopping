<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.haichaoaixuexi.bean.SalesOrder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@page import="com.haichaoaixuexi.bean.Cart"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
User u = (User) session.getAttribute("user");
List<Cart> carts = new ArrayList<Cart>();
List<Category> categories = Category.getCategories();
SalesOrder so = new SalesOrder();
int count = 0;
String addr = "";
if (u == null) {
	response.sendRedirect("notlogin.html");
} else {
	addr = u.getUsername()+"  "+u.getAddr()+"   "+u.getPhone();
	String action = request.getParameter("action");
	String countStr = request.getParameter("count");
	carts = Cart.getCartsByUid(u.getId());
	count = carts.size();
	if (action != null && action.equals("updateCart")) {
		for(int i = 0;i < carts.size(); i ++){
			Cart c = carts.get(i);
			int pid = c.getPid();
			int num = Integer.parseInt(request.getParameter("goods_00"+pid));
			c.setCount(num);
			Cart.updateCart(c);
		}
	}
	String action_changeAddr = request.getParameter("action_changeaddr");
	if (action_changeAddr != null && action_changeAddr.equals("changeaddr")) {
		addr = request.getParameter("name")+"  "+request.getParameter("addr")+"  "+request.getParameter("phone");
		//out.println("<script>alert('11');</script>");
	}
	String action_confirm = request.getParameter("action_confirm");
	String addr_confirm = request.getParameter("addr_confirm");
	if (action_confirm != null && action_confirm.equals("confirmorder")) {
		so.setAddr(addr_confirm);
		so.setCarts(carts);
		so.setoDate(new Timestamp(System.currentTimeMillis()));
		so.setUid(u.getId());
		so.setStatus(0);
		SalesOrder.addSalesOrder(so);
		for(int i = 0; i < carts.size();i ++){
			Cart.deleteCartById(carts.get(i).getId());
		}
		response.sendRedirect("order.jsp");
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>购物车页面</title>
	<link rel="stylesheet" href="css/base.css" type="text/css" />
	<link rel="stylesheet" href="css/shop_common.css" type="text/css" />
	<link rel="stylesheet" href="css/shop_header.css" type="text/css" />
	<link rel="stylesheet" href="css/shop_gouwuche.css" type="text/css" />
    <script type="text/javascript" src="js/jquery.js" ></script>
    <script type="text/javascript" src="js/topNav.js" ></script>
    <script type="text/javascript" src="js/jquery.goodnums.js" ></script>
    <script type="text/javascript" src="js/shop_gouwuche.js" ></script>
    <style type="text/css">
    .shop_bd_shdz_title{width:1000px; margin-top: 10px; height:50px; line-height: 50px; overflow: hidden; background-color:#F8F8F8;}
    .shop_bd_shdz_title h3{width:120px; text-align: center; height:40px; line-height: 40px; font-size: 14px; font-weight: bold;  background:#FFF; border:1px solid #E8E8E8; border-radius:4px 4px 0 0; float: left;  position: relative; top:10px; left:10px; border-bottom: none;}
    .shop_bd_shdz_title p{float: right;}
    .shop_bd_shdz_title p a{margin:0 8px; color:#555555;}

	.shop_bd_shdz_lists{width:1000px;}
	.shop_bd_shdz_lists ul{width:1000px;}
	.shop_bd_shdz_lists ul li{width:980px; border-radius: 3px; margin:5px 0; padding-left:18px; line-height: 40px; height:40px; border:1px solid #FFE580; background-color:#FFF5CC;}
	.shop_bd_shdz_lists ul li label{color:#626A73; font-weight: bold;}
	.shop_bd_shdz_lists ul li label span{padding:10px;}
	.shop_bd_shdz_lists ul li em{margin:0 4px; color:#626A73;}

	.shop_bd_shdz{width:1000px; margin:10px auto 0;}
	.shop_bd_shdz_new{border:1px solid #ccc; width:998px;}
	.shop_bd_shdz_new div.title{width:990px; padding-left:8px; line-height:35px; height:35px; border-bottom:1px solid #ccc; background-color:#F2F2F2; font-color:#656565; font-weight: bold; font-size:14px;}
	.shdz_new_form{width:980px; padding:9px;}
	.shdz_new_form ul{width:100%;}
	.shdz_new_form ul li{clear:both; width:100%; padding:5px 0; height:25px; line-height: 25px;}
	.shdz_new_form ul li label{float:left;width:100px; text-align: right; padding-right: 10px;}
	.shdz_new_form ul li label span{color:#f00; font-weight: bold; font-size:14px; position: relative; left:-3px; top:2px;}
    </style>

	<script type="text/javascript">
	jQuery(function(){
		jQuery("#new_add_shdz_btn").toggle(function(){
			jQuery("#new_add_shdz_contents").show(500);
		},function(){
			jQuery("#new_add_shdz_contents").hide(500);
		});
	});
	</script>
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
								<a href="#" title=""><%=c.getName() %></a>
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
		<strong>当前位置：</strong>
		<span>
			<a href="">首页</a>&nbsp;›&nbsp;
			<a href="">我的商城</a>&nbsp;›&nbsp;
			<a href="">我的购物车</a>
		</span>
	</div>
	<div class="clear"></div>
	<!-- 面包屑 End -->

	<!-- Header End -->
	
	<!-- 购物车 Body -->
	<div class="shop_gwc_bd clearfix">
		<div class="shop_gwc_bd_contents clearfix">

			<!-- 购物流程导航 -->
			<div class="shop_gwc_bd_contents_lc clearfix">
				<ul>
					<li class="step_a">确认购物清单</li>
					<li class="step_b hover_b">确认收货人资料及送货方式</li>
					<li class="step_c">购买完成</li>
				</ul>
			</div>
			<!-- 购物流程导航 End -->
			<div class="clear"></div>
			<!-- 收货地址 title -->
			<div class="shop_bd_shdz_title">
				<h3>收货人地址</h3>
				<p><a href="javasrcipt:void(0);" id="new_add_shdz_btn">修改收货地址</a></p>
			</div>
			<div class="clear"></div>
			<!-- 收货人地址 Title End -->
			<div class="shop_bd_shdz clearfix">
				<div class="shop_bd_shdz_lists clearfix">
					<ul>
						<li><label>寄送至： <%=addr%></li>
					</ul>
				</div>
				<!-- 新增收货地址 -->
				<div id="new_add_shdz_contents" style="display:none;" class="shop_bd_shdz_new clearfix">
					<div class="title">修改收货地址</div>
					<div class="shdz_new_form">
				<form action="flow2.jsp" method="post">
						<input type="hidden" name="action_changeaddr" value="changeaddr" />
							<ul>
								<li><label for=""><span>*</span>收货人姓名：</label><input name="name" type="text" class="name" /></li>
								<li><label for=""><span>*</span>详细地址：</label><input name="addr" type="text" class="xiangxi" /></li>
								<li><label for=""><span></span>手机号：</label><input name="phone" type="text" class="shouji" /></li>
								<li><label for="">&nbsp;</label><input type="submit" value="修改" /></li>
							</ul>
				</form>
					</div>
				</div>
			</div>
			<!-- 新增收货地址 End -->
			<div class="clear"></div>
			<!-- 购物车列表 -->
			<div class="shop_bd_shdz_title">
				<h3>确认购物清单</h3>
			</div>
			<div class="clear"></div>
			<!-- 购物车列表 -->
			<form name="form1" action="flow2.jsp" method="post">
			<input type="hidden" name="action_confirm" value="confirmorder" />
			<input type="hidden" name="addr_confirm" value="<%=addr %>" />
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
						double total = 0;
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
						<td class="gwc_list_shuliang"><span><%=c.getCount() %></span></td>
						<td class="gwc_list_xiaoji"><span>￥<strong
								id="xiaoji_00<%=p.getId() %>" class="good_xiaojis"><%=Double.parseDouble(p.getMemberPrice())*c.getCount()%></strong></span></td>
						<td class="gwc_list_caozuo"><a href="">收藏</a><a
							onClick="cart_del(this,'<%=c.getId()%>')">删除</a></td>
					</tr>
				<%} %>
				</tbody>
				<tfoot>
						<tfoot>
					<tr>
						<td colspan="6">
							<div class="gwc_foot_zongjia">商品总价(不含运费)<span>￥<strong id="good_zongjia"><%=total %></strong></span></div>
							<div class="clear"></div>
							<div class="gwc_foot_links">
								<a href="flow.jsp" class="go">返回上一步</a>
								<input type="submit" class="op" value="确认收货地址" />
							</div>
						</td>
					</tr>
				</tfoot>
			</table>
			</form>
			<!-- 购物车列表 End -->

		</div>
	</div>
	<!-- 购物车 Body End -->

	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<div class="shop_footer">
            <div class="shop_footer_link">
                <p>
                    <a href="">首页</a>|
                    <a href="">招聘英才</a>|
                    <a href="">广告合作</a>|
                    <a href="">关于ShopCZ</a>|
                    <a href="">关于我们</a>
                </p>
            </div>
            <div class="shop_footer_copy">
                <p>Copyright 2007-2013 ShopCZ Inc.,All rights reserved.<br />d by ShopCZ 2.4 </p>
            </div>
        </div>
	<!-- Footer End -->

</body>
</html>