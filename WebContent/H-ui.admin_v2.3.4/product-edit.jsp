<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");
String id = request.getParameter("id");
Product product = Product.getProductById(Integer.parseInt(id));
if(action != null && action.equals("productupdate")){
	String name = request.getParameter("productname");
	String descr = request.getParameter("productdescr");
	String normalPrice = request.getParameter("normalprice");
	String memberPrice = request.getParameter("memberprice");
	product.setDescr(descr);
	product.setMemberPrice(memberPrice);
	product.setName(name);
	product.setNomalPrice(normalPrice);
	if(Product.updateProduct(product)) 
	out.println("update product success!");
	//response.sendRedirect("product-list.jsp");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet" type="text/css" />
<link href="lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script> 
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<title>更新产品</title>
<script type="text/javascript">
function checkinput() {
	if (form.productname.value=="") {
		layer.msg("产品名不能为空", {
			icon : 2
		});
		$("#productname").focus();
		return false;
	}else if (form.normalprice.value=="") {
		layer.msg("展示价格不能为空", {
			icon : 2
		});
		$("#normalprice").focus();
		return false;
	}else if (form.memberprice.value=="") {
		layer.msg("会员价格不能为空", {
			icon : 2
		});
		$("#memberprice").focus();
		return false;
	}else if (form.productdescr.value=="") {
		layer.msg("描述不能为空", {
			icon : 2
		});
		$("#productdescr").focus();
		return false;
	}else
	return true;
}
</script>
</head>
<body>
<div class="pd-20">
	<form action="product-edit.jsp" method="post" class="form form-horizontal" id="form" onsubmit="return checkinput()">
	<input type="hidden" name="action" value="productupdate">
	<input type="hidden" name="id" value="<%=id %>">
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>产品名称：</label>
			<div class="formControls col-10">
				<input type="text" class="input-text" value="<%=product.getName() %>" placeholder="" id="productname" name="productname">
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>产品展示价格：</label>
			<div class="formControls col-4">
				<input type="text" name="normalprice" id="normalprice" placeholder="" value="<%=product.getNomalPrice() %>" class="input-text" style="width:90%">
				元</div>
			<label class="form-label col-2"><span class="c-red">*</span>会员价格：</label>
			<div class="formControls col-4">
				<input type="text" name="memberprice" id="memberprice" placeholder="" value="<%=product.getMemberPrice() %>" class="input-text" style="width:90%">
				元</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>产品描述：</label>
			<div class="formControls col-10">
				<textarea name="productdescr" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" nullmsg="描述不能为空！" onKeyUp="textarealength(this,200)"><%=product.getDescr() %></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">0</em>/200</p>
			</div>
		</div>
		
		<div class="row cl">
			<div class="col-10 col-offset-2">
				<button class="btn btn-primary radius" type="submit"><i class="Hui-iconfont">&#xe632;</i> 保存并提交</button>
			</div>
		</div>
	</form>
</div>
</body>
</html>