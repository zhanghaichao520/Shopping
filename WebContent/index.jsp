<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@page import="com.haichaoaixuexi.bean.Cart"%>
<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.bean.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
List<Category> categories = Category.getCategories();
List<Product> latestProducts = Product.getLatestProducts(5);
System.out.println(latestProducts.get(0).getPicpath());
User u = (User) session.getAttribute("user");
int count = 0;
if (u == null) {
	count = 0;
}else{
List<Cart> carts = Cart.getCartsByUid(u.getId());
count = carts.size();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>特产商城-首页</title>
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
						您好，欢迎来到<b><a href="#">特产商城</a></b>[<a href="login.jsp">登录</a>][<a
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
					<a href="#"><img src="images/logo.png" alt="特产商城" /></a><span>特产商城</span>
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

			<div class="shop_hd_menu_all_category shop_hd_menu_hover">
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
	<!-- Header End -->


	<!-- Body -wll-2013/03/24 -->
	<div class="shop_bd clearfix">
		<!-- 第一块区域  -->
		<div class="shop_bd_top clearfix">
			<div class="shop_bd_top_left"></div>
			<div class="shop_bd_top_center">
				<!-- 图片切换  begin  -->
				<div class="xifan_sub_box">
					<div id="p-select" class="sub_nav">
						<div class="sub_no" id="xifan_bd1lfsj">
							<ul></ul>
						</div>
					</div>
					<div id="xifan_bd1lfimg">
						<div>
							<dl class=""></dl>
							<dl class="">
								<dt>
									<a href="http://www.zztuku.com" title="" target="_blank"><img
										src="images/e2dfe57add8fff66ed0964b1effd39b9.jpg"
										alt="爆款  大闸蟹	"></a>
								</dt>
								<dd>
									<h2>
										<a href="http://www.zztuku.com" target="_blank">爆款  大闸蟹	</a>
									</h2>
								</dd>
							</dl>
							<dl class="">
								<dt>
									<a href="http://www.zztuku.com" title="" target="_blank"><img
										src="images/ad02.jpg"
										alt="贵州美食"></a>
								</dt>
								<dd>
									<h2>
										<a href="http://www.zztuku.com" target="_blank">贵州美食</a>
									</h2>
								</dd>
							</dl>
							<dl class="">
								<dt>
									<a href="http://www.zztuku.com" title="" target="_blank"><img
										src="images/ad03.jpg"
										alt="桐河特产 特质精品"></a>
								</dt>
								<dd>
									<h2>
										<a href="http://www.zztuku.com" target="_blank">桐河特产 特质精品</a>
									</h2>
								</dd>
							</dl>
							<dl class="">
								<dt>
									<a href="http://www.zztuku.com" title="" target="_blank"><img
										src="images/ad04.jpg"
										alt="停不了口的诱惑"></a>
								</dt>
								<dd>
									<h2>
										<a href="http://www.zztuku.com" target="_blank">停不了口的诱惑</a>
									</h2>
								</dd>
							</dl>
							<dl class="">
								<dt>
									<a href="http://www.zztuku.com" title="" target="_blank"><img
										src="images/ad05.jpg"
										alt="话梅"></a>
								</dt>
								<dd>
									<h2>
										<a href="http://www.zztuku.com" target="_blank">话梅</a>
									</h2>
								</dd>
							</dl>

							<dl class="">
								<dt>
									<a href="http://www.zztuku.com" title="" target="_blank"><img
										src="images/ad06.jpg"
										alt="潜入城市周边清幽之地"></a>
								</dt>
								<dd>
									<h2>
										<a href="http://www.zztuku.com" target="_blank">潜入城市周边清幽之地</a>
									</h2>
								</dd>
							</dl>
							
						</div>
					</div>
				</div>
				<script type="text/javascript">movec();</script>
				<!-- 图片切换  end -->
			  <div class="clear"></div>
                    <div class="shop_bd_top_center_hot"><img src="images/index.guanggao.png" /></div>
                </div>

			<!-- 右侧 -->
			<div class="shop_bd_top_right clearfix">
				<div class="shop_bd_top_right_quickLink">
					<a href="login.jsp" class="login" title="会员登录"><i></i>会员登录</a> <a href="register.jsp"
						class="register" title="免费注册"><i></i>免费注册</a> <a href=""
						class="join" title="商家开店"><i></i>帮助中心</a>
				</div>

				<div class="shop_bd_top_right-style1 nc-home-news">
					<ul class="tabs-nav">
						<li><a href="javascript:void(0);" class="hover">商城广告</a></li>
						<li><a href="javascript:void(0);">关于我们</a></li>
					</ul>
					<div class="clear"></div>
					<div class="tabs-panel">
						<ul class="list-style01">
							<li><a title="如何申请开店" href="article-15.html">如何申请开店</a><span>(2011-01-11)</span></li>
							<li><a title="商城商品推荐" href="article-14.html">商城商品推荐</a><span>(2011-01-11)</span></li>
							<li><a title="如何发货" href="article-13.html">如何发货</a><span>(2011-01-11)</span></li>
							<li><a title="查看售出商品" href="article-12.html">查看售出商品</a><span>(2011-01-11)</span></li>
							<li><a title="如何管理店铺" href="article-11.html">如何管理店铺</a><span>(2011-01-11)</span></li>
							<li><a title="如何申请开店" href="article-15.html">如何申请开店</a><span>(2011-01-11)</span></li>
							<li><a title="商城商品推荐" href="article-14.html">商城商品推荐</a><span>(2011-01-11)</span></li>
							<li><a title="如何发货" href="article-13.html">如何发货</a><span>(2011-01-11)</span></li>
							<li><a title="查看售出商品" href="article-12.html">查看售出商品</a><span>(2011-01-11)</span></li>
							<li><a title="如何管理店铺" href="article-11.html">如何管理店铺</a><span>(2011-01-11)</span></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- 右侧 End -->
		</div>
		<div class="clear"></div>
		<!-- 第一块区域 End -->
<div class="clear"></div>
		<!-- 第二块区域 -->
		<div class="shop_bd_2 clearfix">
			<!-- 特别推荐 -->
			<div class="shop_bd_tuijian">
				<ul class="tuijian_tabs">
					<li class="hover" onmouseover="easytabs('1', '1');"
						onfocus="easytabs('1', '1');" onclick="return false;"
						id="tuijian_content_btn_1"><a href="javascript:void(0);">特别推荐</a></li>
					<li onmouseover="easytabs('1', '2');" onfocus="easytabs('1', '2');"
						onclick="return false;" id="tuijian_content_btn_2"><a
						href="javascript:void(0);">热门商品</a></li>
					<li onmouseover="easytabs('1', '3');" onfocus="easytabs('1', '3');"
						onclick="return false;" id="tuijian_content_btn_3"><a
						href="javascript:void(0);">新品上架</a></li>
				</ul>
				<div class="tuijian_content">
					<div id="tuijian_content_1" class="tuijian_shangpin"
						style="display: block;">
						<ul>
							<%
						for(int i = 0; i < latestProducts.size()-1; i ++){
							Product p = latestProducts.get(i);							
						%>
							<li>
								<dl>
									<dt>
										<a href="goods.jsp?id=<%=p.getId()%>"><img
											src="<%=p.getPicpath() %>" style="width: 150px;height:160px"/></a>
									</dt>
									<dd>
										<a href="goods.jsp?id=<%=p.getId()%>"><%=p.getName() %></a>
									</dd>
									<dd>
										会员价：<em><%=p.getMemberPrice() %></em>元
									</dd>
								</dl>
							</li>
					<%
						}
					%>

						</ul>
					</div>

					<div id="tuijian_content_2" class="tuijian_shangpin">
						<ul>
							<%
						for(int i = 0; i < latestProducts.size(); i ++){
							Product p = latestProducts.get(i);							
						%>
							<li>
								<dl>
									<dt>
										<a href="goods.jsp?id=<%=p.getId()%>"><img
											src="<%=p.getPicpath() %>" style="width: 150px;height:160px"/></a>
									</dt>
									<dd>
										<a href="goods.jsp?id=<%=p.getId()%>"><%=p.getName() %></a>
									</dd>
									<dd>
										会员价：<em><%=p.getMemberPrice() %></em>元
									</dd>
								</dl>
							</li>
					<%
						}
					%>

						</ul>
					</div>
					<div id="tuijian_content_3"
						class="tuijian_shangpin tuijian_content">
						<ul>
						<%
						for(int i = 0; i < latestProducts.size()-1; i ++){
							Product p = latestProducts.get(i);							
						%>
							<li>
								<dl>
									<dt>
										<a href="goods.jsp?id=<%=p.getId()%>"><img
											src="<%=p.getPicpath() %>" style="width: 150px;height:160px"/></a>
									</dt>
									<dd>
										<a href="goods.jsp?id=<%=p.getId()%>"><%=p.getName() %></a>
									</dd>
									<dd>
										会员价：<em><%=p.getMemberPrice() %></em>元
									</dd>
								</dl>
							</li>
					<%
						}
					%>
						</ul>
					</div>

				</div>

			</div>
			<!-- 特别推荐 End -->

		</div>
		<div class="clear"></div>
		<!-- 第二块区域 End -->

		<div class="faq">
			<dl>
				<dt>帮助中心</dt>
				<dd>
					<a href=""><span>积分兑换说明</span></a>
				</dd>
				<dd>
					<a href=""><span>积分明细</span></a>
				</dd>
				<dd>
					<a href=""><span>查看已购买商</span></a>
				</dd>
				<dd>
					<a href=""><span>我要买</span></a>
				</dd>
				<dd>
					<a href=""><span>忘记密码</span></a>
				</dd>
			</dl>

			<dl>
				<dt>店主之家</dt>
				<dd>
					<a href=""><span>如何申请开店</span></a>
				</dd>
				<dd>
					<a href=""><span>商城商品推荐</span></a>
				</dd>
				<dd>
					<a href=""><span>如何发货</span></a>
				</dd>
				<dd>
					<a href=""><span>查看已售商品</span></a>
				</dd>
				<dd>
					<a href=""><span>如何管理店铺</span></a>
				</dd>
			</dl>

			<dl>
				<dt>支付方式</dt>
				<dd>
					<a href=""><span>公司转账</span></a>
				</dd>
				<dd>
					<a href=""><span>邮局汇款</span></a>
				</dd>
				<dd>
					<a href=""><span>分期付款</span></a>
				</dd>
				<dd>
					<a href=""><span>在线支付</span></a>
				</dd>
				<dd>
					<a href=""><span>如何注册支付</span></a>
				</dd>
			</dl>

			<dl>
				<dt>售后服务</dt>
				<dd>
					<a href=""><span>退款申请</span></a>
				</dd>
				<dd>
					<a href=""><span>返修/退换货</span></a>
				</dd>
				<dd>
					<a href=""><span>退换货流程</span></a>
				</dd>
				<dd>
					<a href=""><span>退换货政策</span></a>
				</dd>
				<dd>
					<a href=""><span>联系卖家</span></a>
				</dd>
			</dl>

			<dl>
				<dt>客服中心</dt>
				<dd>
					<a href=""><span>修改收货地址</span></a>
				</dd>
				<dd>
					<a href=""><span>商品发布</span></a>
				</dd>
				<dd>
					<a href=""><span>会员修改个人</span></a>
				</dd>
				<dd>
					<a href=""><span>会员修改密码</span></a>
				</dd>

			</dl>

			<dl>
				<dt>关于我们</dt>
				<dd>
					<a href=""><span>合作及洽谈</span></a>
				</dd>
				<dd>
					<a href=""><span>招聘英才</span></a>
				</dd>
				<dd>
					<a href=""><span>联系我们</span></a>
				</dd>
				<dd>
					<a href=""><span>关于Shop</span></a>
				</dd>
			</dl>


		</div>
		<div class="clear"></div>
	</div>
	<!-- Body End -->

	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<div class="shop_footer">
		<div class="shop_footer_link">
			<p>
				<a href="">首页</a>| <a href="">招聘英才</a>| <a href="">广告合作</a>| <a
					href="">关于特产商城</a>| <a href="">关于我们</a>
			</p>
		</div>
		<div class="shop_footer_copy">
			<p>Copyright © 2017 zhanghaichao.,All rights reserved.</p>
		</div>
	</div>
	<!-- Footer End -->

</body>
</html>