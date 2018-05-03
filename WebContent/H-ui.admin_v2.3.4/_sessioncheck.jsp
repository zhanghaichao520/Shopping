<%
String admin = (String)session.getAttribute("admin");
if(admin == null || !admin.equals("true")){
	response.sendRedirect("login.jsp");
}
%>