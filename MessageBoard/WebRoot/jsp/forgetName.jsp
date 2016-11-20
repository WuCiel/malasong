<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>


<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+
	request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>忘记用户名</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">


  </head>
  
  <body>
		<h3>	非常抱歉，目前我没有时间完善该功能，如果你忘记了你的用户名，请发注册时的邮箱以及你的真实姓名(如果你有提交的话)到我的邮箱xuhuanfeng232@gmail.com
		</h3>
		
		<p>	我会在下个版本完善该功能，不便之处还请谅解。</p>
		</center>
  </body>
</html>
