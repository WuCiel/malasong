<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <link rel="stylesheet" type="text/css" href="<%=path %>/css/styles.css">

    <base href="<%=basePath%>">
    <title>回复</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
      	<div style="width:100%;
		height:100%;
		margin: 0 auto;
		background-size: cover;" >
	<div class="container">
  	<%     
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String owner = request.getParameter("mowner");
		
		String method = request.getMethod();
		if(method.equals("GET")){
  	%>
	 	 <form action='./ReplyMessage' method='post' class="InputBorder">
			<textarea name="rcontent"></textarea><br/><br/>
			<input type="hidden" name="id" value=<%=id %>>
			<input type="hidden" name="mowner" value=<%=owner %>>
  			<input type="submit" class="button" value="发表留言">  			
  		</form>
		<%
			}			
		 %>
		 </div>
		</div>
  </body>
</html>
