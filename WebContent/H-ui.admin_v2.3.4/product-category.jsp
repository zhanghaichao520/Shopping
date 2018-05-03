<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.haichaoaixuexi.dao.CategoryDao"%>
<%@page import="com.haichaoaixuexi.bean.Category"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="_sessioncheck.jsp"%>
<%
int ia= 0;
List<Category> categories = Category.getCategories();

//删除目录
String action = request.getParameter("action");
if (action != null && action.equals("delete")) {
	int id = Integer.parseInt(request.getParameter("id"));
	Category.delCategory(id);
}
//批量删除
String action_del = request.getParameter("action_del");
if (action_del != null && action_del.equals("delete")) {
	String id_array = request.getParameter("id_array");
	String[] ids = id_array.split(",");
	for (int i = 0; i < ids.length; i++) {
		int id = Integer.parseInt(ids[i]);
		Category.delCategory(id);
	}
}
%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<title>目录分类</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 目录管理 <span class="c-gray en">&gt;</span> 目录分类 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" onclick="category_add('添加','product-category-add.jsp?pid=0','-1','700px','410px')" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加目录</a></span> <span class="r">共有数据：<strong><%=categories.size() %></strong> 条</span> </div>
		<div class="mt-20">
			<table class="table table-border table-bordered table-bg table-hover table-sort">
				<thead>
					<tr class="text-c">
						<th width="40"><input name="" type="checkbox" value=""></th>
						<th width="40">ID</th>
						<th width="60">目录名称</th>
						<th width="100">父目录id</th>
						<th>描述</th>
						<th width="60">级别</th>
						<th width="100">操作</th>
					</tr>
				</thead>
				<tbody>
				<%
				for(int a = 0; a < categories.size(); a ++){
					Category c = categories.get(a);
					String preStr = "";
					for(int i = 1;i < Integer.parseInt(c.getGride());i++){
						preStr += "--";
					}
				%>
					<tr class="text-c va-m">
						<td><input name="categoryid" type="checkbox" value="<%=c.getId()%>"></td>
						<td><%=c.getId() %></td>
						<td><%=preStr+c.getName() %></td>
						<td><%=c.getPid() %></td>
						<td class="text-l"><%=c.getDescr() %></td>
						<td><%=c.getGride() %></td>
						<td class="td-manage">
						<a style="text-decoration:none" class="ml-5" onClick="category_add('修改','product-category-update.jsp?id='+<%=c.getId()+""%>,'<%=c.getId()%>','700px','410px')"><i class="Hui-iconfont">&#xe6df;</i></a> 
						<a style="text-decoration:none" class="ml-5" onClick="category_add('添加','product-category-add.jsp?pid='+<%=c.getId()+""%>,'<%=c.getId()%>','700px','410px')"><i class="Hui-iconfont">&#xe600;</i></a> 
						<a style="text-decoration:none" class="ml-5" onClick="category_del(this,'<%=c.getId()%>')"  href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
					</tr>
				<%
				}
				%>
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="lib/layer/2.1/layer.js"></script>
	<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="js/H-ui.js"></script>
	<script type="text/javascript" src="js/H-ui.admin.js"></script>
	<script type="text/javascript">
		/*批量删除*/
		function datadel() {
			 var id_array = new Array();
	            $('input[name="categoryid"]:checked').each(function () {
	                id_array.push($(this).val());
	            });
	            location.href = 'product-category.jsp?id_array=' + id_array + '&action_del=delete';
				//location.reload(true);
		}
		/*目录-添加*/
		function category_add(title, url, id, w, h) {
			layer.open({
                id: 'add-form',
                type: 2,
                title: title,
                shadeClose: true,
                shade: 0.3,
                area: [w, h],
                content: url,
               
            });
		}

		/*目录-删除*/
		function category_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				layer.msg('已删除!', {
					icon : 1,
					time : 1000
				});
				location.href = 'product-category.jsp?id=' + id + '&action=delete';
				alert("删除成功");
				location.reload(true);
			});
			
		}
	</script>
</body>
</html>