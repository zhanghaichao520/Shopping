<%@page import="com.haichaoaixuexi.dao.CategoryDao"%>
<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");
String pid = request.getParameter("pid");
String pidString = request.getParameter("cpid");
if(action != null && action.equals("add")){
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	if(pidString.equals("0")){
		Category.addTopCategory(name, descr);
	}else{
		Category.addChildCategory(pidString, name, descr);
	}
	out.print("<script>alert('add success!');</script>");

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
<title>添加产品分类</title>
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
  <form action="product-category-add.jsp" method="post" class="form form-horizontal" id="form" name="form" onsubmit="return checkinput()">
  <input type="hidden" name="action" value="add">
  <input type="hidden" name="cpid" value=<%=pid %>>
    <label class="form-label col-2">父目录id：<%=pid %></label><br />
    <div class="row cl">
      <label class="form-label col-2"><span class="c-red">*</span>分类名称:</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="" datatype="*1-100" dragonfly="true" nullmsg="名字不能为空！"  placeholder="" id="name" name="name">
      </div>
      <div class="col-5"> </div>
    </div>
    <div class="row cl">
      <label class="form-label col-2">描述：</label>
      <div class="formControls col-5">
        <textarea name="descr" id="descr" cols="" rows="" class="textarea"  placeholder="说点什么..." datatype="*1-100" dragonfly="true" nullmsg="描述不能为空！" onKeyUp="textarealength(this,100)"></textarea>
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

</body>
</html>