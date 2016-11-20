<%@page import="MessageBoard.Object.Product"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<title>编程马拉松</title>
<link href="css/index-top.css" rel="stylesheet" type="text/css">
<link href="css/index-left.css" rel="stylesheet" type="text/css">
<script src="image/saved_resource.js"></script>
<script src="js/index.js"></script>
<link rel="stylesheet" href="image/16sucai.css">

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css">


<script type="text/javascript">
		  function add(pid,qoh){
		  ding=document.getElementById("pid1");
		  ding.innerHTML=pid+":"qoh;
		  }
		  function add(){
		  ding=document.getElementById("widget-header");
		  ding.innerHTML="fuck";
		  }
		  
			function myfunction()
			{
				alert("您好！")
			}
			$('#oo').bind('click',function(event){
    alert('im a');
    event.stopPropagation();

});
			
		  </script>

</head>


<body style="text-align:center">


<!--顶部选项-->
<div id=head>
	<div class="chl-poster simple" id=header>
		<div id=site-nav>
			<UL class=quick-menu>
			<div id="title">
			  <LI><A href=<%=basePath %>GetProductList>首页</A> </LI>
			  <LI><A href=<%=basePath %>cart.jsp>订单</A> </LI>
			  <%
			  		if(session.getAttribute("cname")!=null){				  		
			   %>
				  <LI><A href="#">欢迎你<%=(String)session.getAttribute("cname") %></A></LI>
				<% }else{
						
					}
				%>	  
			  <LI><A href=<%=basePath %>logout>退出</A></LI>
		    </UL>
		</div>
	</div>
</div>


<div class="ct-pageWrapper">
  <main>
	<div class="container">
	
	  <div class="row">  
			<div class="col-md-3">
				  <div class="widget">
					<h2 class="widget-header" id="asd"></h2>
					<p id="pid1"></p>
					<div class="ct-cart"></div>
				  </div>  
			</div>
		<div class="col-md-8">
		<div class="row">
		
		<%
			ArrayList<Product> productList = (ArrayList<Product>)request.getAttribute("productList");
			if(productList!=null){
				for(Product p:productList){
				session.setAttribute(p.getPid(), p);
		 %>
		 	
			<a href=<%=path %>/shop/xiang.jsp?Pid=<%=p.getPid() %>>
								  
						<div class="col-sm-4" >
						  <div class="ct-product" style="width:250px;height:400px;">
							  <!-- 图片div -->
								<div class="image" style="height:60%"><img  style="height:250px;" src=<%=p.getImgUrl() %> alt=""></div>
							  <!-- 内容div -->
								<div class="inner">
								  <h2 class="ct-product-title"><%=p.getPname() %></h2>
								  <p class="ct-product-description"><%=p.getDeps() %></p>
								  <span class="ct-product-price"><%=((int)(100*Double.parseDouble(p.getOriginal_price())*Double.parseDouble(p.getDiscnt_rate())))/100.0%></span>
								</div>
						   </div>
						</div>
					
			</a>
			<% 
				}
					}
			%>	
		</div>
		</div>
	  </div>
	</div>
  </main>

</div>


</body>
</html>