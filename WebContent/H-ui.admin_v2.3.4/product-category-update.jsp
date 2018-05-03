<%@page import="com.haichaoaixuexi.dao.CategoryDao"%>
<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");
String ids = request.getParameter("id");
int id = Integer.parseInt(ids);
Category category = Category.getCategory(id);

if(action != null && action.equals("update")){
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	category.setName(name);
	category.setDescr(descr);
	Category.updateCategory(category);
	out.println("update success!");
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
<title>修改产品分类</title>
<script type="text/javascript">
function checkinput() {
	if (form.name.value=="") {
		layer.msg("分类名不能为空", {
			icon : 2
		});
		$("#name").focus();
		return false;
	}else if (form.descr.value=="") {
		layer.msg("描述不能为空", {
			icon : 2
		});
		$("#descr").focus();
		return false;
	}else
	return true;
}

</script>
</head>
<body>
<div class="pd-20">
  <form action="product-category-update.jsp" method="post" class="form form-horizontal" id="form" name="form" onsubmit="return checkinput()">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="id" value="<%=id %>">
    <label class="form-label col-2">目录id：<%=id %></label><br />
    <div class="row cl">
      <label class="form-label col-2"><span class="c-red">*</span>分类名称:</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="<%=category.getName() %>" datatype="*1-100" dragonfly="true" nullmsg="名字不能为空！"  placeholder="" id="name" name="name">
      </div>
      <div class="col-5"> </div>
    </div>
    <div class="row cl">
      <label class="form-label col-2">描述：</label>
      <div class="formControls col-5">
        <textarea name="descr" id="descr" cols="" rows="" class="textarea"  placeholder="说点什么..." datatype="*1-100" dragonfly="true" nullmsg="描述不能为空！" onKeyUp="textarealength(this,100)"><%=category.getDescr() %></textarea>
        <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
      </div>
      <div class="col-5"> </div>
    </div>
    <div class="row cl">
      <div class="col-9 col-offset-2">
        <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
      </div>
    </div>
  </form>
</div>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script> 
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#form").Validform({
		tiptype:2,
		callback:function(form){
			form[0].submit();
			windows.parent.reload();
			var index = parent.layer.getFrameIndex(window.name);
			parent.$('.btn-refresh').click();
			parent.layer.close(index);
		}
	});
});
</script>
</body>
</html>