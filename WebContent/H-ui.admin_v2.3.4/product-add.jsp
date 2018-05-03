<%@page import="com.haichaoaixuexi.dao.CategoryDao"%>
<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.haichaoaixuexi.bean.Product"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
List<Category> topCategories = CategoryDao.getTopCategories();
String action;
/* if(action != null && action.equals("productadd")){
	String name = request.getParameter("productname");
	String descr = request.getParameter("productdescr");
	String normalPrice = request.getParameter("normalprice");
	String memberPrice = request.getParameter("memberprice");
	Product product = new Product();
	product.setId(-1);
	//product.setCid(Integer.parseInt(cid));
	product.setDescr(descr);
	product.setMemberPrice(memberPrice);
	product.setName(name);
	product.setNomalPrice(normalPrice);
	product.setPdate(new Timestamp(System.currentTimeMillis()));
	if(Product.addProduct(product))
	out.println("add product success!");
//	response.sendRedirect("product-list.jsp");
} */
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
<title>新增产品</title>
<script type="text/javascript">
$(function(){
	   $("#topCate").blur(function(){
		   var topId=$(this).val();
		   if(topId==0){
			   alert("please select category！");
		   }else{
			   $.ajax({
				   type:'POST',
				   url:'../ProductSever',
				   cache:false,
				   data:'topId='+topId+"&action=getCate",
				   dataType:'text',
				   success:function(result){
					   var category=eval("("+result+")");
					   $("#seCate").empty();
					   for(var i=0;i<category.length;i++){
						   $("#seCate").append("<option value="+category[i].id+">"+category[i].name+"</option>");
					   }
				   },
				   error:function(){
					   alert('响应失败！');
				   }
				   
			   })
		   }
		   
	   });
}),
function checkinput() {
	alert("hah");
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
	}else if (form.cid.value==0) {
		layer.msg("请选择分类", {
			icon : 2
		});
		return false;
	}
	else if (form.productdescr.value=="") {
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
	<form action="../ProductSever?action=productadd" method="post" class="form form-horizontal" id="form" onsubmit="return checkinput()" enctype="multipart/form-data">
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>产品名称：</label>
			<div class="formControls col-10">
				<input type="text" class="input-text" value="" placeholder="" id="productname" name="productname">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>一级分类：</label>
			<div class="formControls col-2"> 
				<span class="select-box">
					<select id="topCate" class="select">
					<option value="0" disabled="disabled" selected="selected">请选择--</option>
					<%
						for(int i = 0 ;i < topCategories.size(); i ++)
						{
							Category tc = topCategories.get(i);
					%>
						<option value="<%=tc.getId()%>"><%=tc.getName() %></option>
					<%
						}
					%>
					</select>
				</span> 
			</div>
			<label class="form-label col-2"><span class="c-red">*</span>二级分类：</label>
			<div class="formControls col-2"> 
				<span class="select-box">
					<select id="seCate" name="cid" class="select">
						<option value="0" disabled="disabled" selected="selected">请选择--</option>
					</select>
				</span> 
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>产品展示价格：</label>
			<div class="formControls col-2">
				<input type="text" name="normalprice" id="normalprice" placeholder="" value="" class="input-text" style="width:90%">
				元</div>
			<label class="form-label col-2"><span class="c-red">*</span>会员价格：</label>
			<div class="formControls col-2">
				<input type="text" name="memberprice" id="memberprice" placeholder="" value="" class="input-text" style="width:90%">
				元</div>
		</div>
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>产品描述：</label>
			<div class="formControls col-10">
				<textarea name="productdescr" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" nullmsg="描述不能为空！" onKeyUp="textarealength(this,200)"></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">0</em>/200</p>
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>缩略图：</label>
			<div class="formControls col-10">
				<div class="uploader-thum-container">
					<span class="btn btn-default btn-uploadstar radius ml-10"><input name="picpath" type="file" value="选择图片"></span>
				</div>
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