<%@page import="java.security.acl.Owner,MessageBoard.Object.Message"%>

<%@ page language="java" import="java.util.*,java.sql.*,java.net.*"
	 pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+
	request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="/MessageBoard/css/styles.css">
	<link rel="stylesheet" type="text/css" href="/MessageBoard/css/annotation.css">
	
</script>
    <base href="<%=basePath%>">
    <title>My MessageBoard1</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"> 

  </head>
  
  <body class="bgColor">
      <div style="width:100%;
		margin: 0 auto;">
	<div class="right">
		<div class="ownerMsg">
			<img src="./img/bg.jpg"> 
			</img>
			<h3>许焕峰</h3>
			<h5>email:xuhuanfeng232@gmail.com</h5>
		</div>
		<div class="onlineUse">
			<h3>当前在线用户列表</h3>
			<ui>
			<%
				ArrayList<String> useList = (ArrayList<String>)application.getAttribute("useList");
				if(useList!=null){
					for(String use:useList){
						out.print("<li>"+use+"</li>");
					}
				}
			%>
			<ui>
		</div>
		<div class="friendLink">
			<h3>友情链接</h3>
			<h5><a href="http://blog.csdn.net/xuhuanfeng232">许焕峰的博客</a></h5>
		</div>
	</div>
	<div class="container">
  	<%!

		  String nbsp = "&nbsp;";
		  String testPage ="<a href='/MessageBoard/jsp/replyPage.jsp?id=";
		  String timeType="<span class='time'>";
		  String Msg="<div class='message'>";
		  String RMsg="<div class='replyMessage'>";
		  String admin = "admin";
		  String dotLine = "<hr style='border-top: dotted 2px;' />";
		  String rep="'>回复</a>";
		  
		// 判断属主 用于决定是否显示回复按钮
		public  boolean judgeOwner(String owner,String mowner){
			if(owner=="" || mowner=="" || mowner==null || owner==null)return false;
			if(owner.equals(mowner)) return true;
			if(mowner.equals(admin)) return true;
			return false;
		}
		
		public String getFiltString(String content){
			return content.replaceAll("<", "&lt")
							.replaceAll(">", "&gt")
							.replace("\n", "<br/>");
		}
		// 打印回复的信息
		public void printReplyMessage(String[] needMsg,JspWriter out,ArrayList<Message> replyMsg){
			
			try{
				for(Message msg:replyMsg){
						String mowner =msg.getMowner();
						String rid =msg.getId(); 
						String rtime = msg.getMtime();
						String rcontent = msg.getContent();
				   	 	
				   	 	out.print(RMsg+nbsp+nbsp+mowner+nbsp);
				   	 	
						if(judgeOwner(mowner,needMsg[0])){
							out.print(testPage+needMsg[1]+"&mowner="+needMsg[0]+rep);
						}
						
						out.print(timeType+rtime+"</span>");
						out.print("<pre>"+rcontent+"</pre></div>");
				  	 }		
			}catch (Exception e){}
		}

	%>	
		
	    <%
			String name =null;
			String pwd = null;
			
			HttpSession usession = request.getSession();
			name = (String)usession.getAttribute("name");
	    	
			boolean change=true;
			
	    	if(name==null || name==""){
			%>
			<div class="InputBorder" align="center">
				<font align="center">您尚未登录，请选择
					<a href="<%=path%>/html/register.html">注册</a>或者
					<a href="<%=path%>/html/login.html">登录</a>
				</font>
			</div>
			<%
		  	}else{
			%>
			欢迎您&nbsp;<%=name %>&nbsp;<a href="./logout">退出登录</a>
			
	  <form action="/MessageBoard/handin" method="post" class="InputBorder">
		<textarea name="text" required ></textarea><br/><br/>
  		<input type="submit" class="button1" value="发表留言">  			
	  </form>
		  <%
		  	}
	    %>
  	  <% 	
  	  		Integer pid = (Integer)request.getAttribute("pageId");
  	  		
   			ArrayList<Message> msgList = (ArrayList<Message>)application.getAttribute("msgList");
   			HashMap<String,ArrayList<Message>> replyMsg = (HashMap<String,ArrayList<Message>>)application.getAttribute("replyMsg");
   				if(msgList!=null){
   					for(Message msg:msgList){
			   			
			   			String id = msg.getId();
			   			String time = msg.getMtime();
			   			String content = msg.getContent();
			   			String owner = msg.getMowner();
			   			 
						out.print(Msg+"第 "+id+" 楼"+nbsp+owner+ nbsp);
						
						if( judgeOwner(owner, name)){
							out.print( testPage+id+"&mowner="+name+ rep);
						}
						
						out.print( timeType+time+"</span>");
						out.print("<pre>"+nbsp+nbsp+content+"</pre>");
						
			   			String[]  MsgMessage=new String[2];
			   			MsgMessage[0]=name;MsgMessage[1]=id;
			   			if(replyMsg!=null)
					  	  printReplyMessage(MsgMessage,out,replyMsg.get(id));
						  out.print("</div>");
					}
				}else{
				
					out.print("no message now");
				}

		%>
	     <div class='message' align="center">
		    <a href="<%=path %>/MessageBoard?page=1">首页</a>
		    <a href="<%=path %>/MessageBoard?page=<%= pid+1 %>">下一页</a>
		    <a href="<%=path %>/MessageBoard?page=<%= pid-1 %>">上一页</a>
		    <a href="<%=path %>/MessageBoard?page=<%= pid*10000000 %>">末页</a>
	    </div>
    </div>
  </body>
</html>
