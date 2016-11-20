<%@page import="MessageBoard.Object.ProductCar"%>
<%@ page language="java" import="java.util.*,MessageBoard.Object.Product" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html >
  <head>

   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品详情</title>
<meta name="keywords" content="详情" />
<meta name="description" content="详情" />

 <link rel="stylesheet" type="text/css" href="css/normalize.css"/>
 <link href="css/index-top.css" rel="stylesheet" type="text/css">

 <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
 <script src="js/common.js" type="text/javascript" charset="utf-8"></script>
   <script type="text/javascript">
   
   function addToCart()
	{
		
		pro=document.getElementById("product").innerHTML;
		qoh=document.getElementById("text_box").value;
		alert("购买物品: "+pro+"\n购买数量: "+qoh);
		
		document.getElementById("info").submit();

	}
</script>
</head>
<body>
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

	<%
		String pid = request.getParameter("Pid");
		Product p = (Product)session.getAttribute(pid);
		if(p!=null){
	%>
 <div class="showall">
	                <!--left -->
	                <div class="showbot">
                    <div id="showbox">
                        <img src=<%=p.getImgUrl() %> width="450" height="450" alt=<%=p.getPname() %> />
                    </div><!--展示图片盒子-->
                      
                        </div>
                        <div class="tb-property">
                        	<div class="tr-nobdr">
                        		<h3 id="product"> <%=p.getPname() %></h3>
                        	</div>
                        		<div class="txt">
                        			<span class="nowprice" align="center">￥<%=((int)(100*Double.parseDouble(p.getOriginal_price())*Double.parseDouble(p.getDiscnt_rate())))/100.0%></a></span>
                        		</div>
							<form id="info" action="" method="post">
                        	<div class="gcIpt">
                        		<span class="guT">数量</span>
                        		<input id="min" name="" type="button" value="-" />  
                        		<input name="npid" value=<%=p.getPid() %> type="hidden"/>
                        		<input id="text_box" name="ncnt" type="text" value="1"style="width:60px; text-align: center; color: #0F0F0F;"/>  
                        		<input id="add" name="" type="button" value="+" />
                        		<span class="Hgt">库存（<%=p.getQoh() %>）</span>
                        	</div>
                        	<div class="nobdr-btns">
                        		<button class="addcart hu" onclick="addToCart()">
                        		<img src="<%=basePath %>shop/images/shop.png" width="25" height="25"/>加入购物车</button>
                        		<button class="addcart2" onclick="window.location.href='dingdan.html'">提交订单</button>
                        	</div>
                        	<form>
                        	<div class="guarantee" >
                        		<span><font size="5px">简介：<%=p.getDeps() %></font></span>
                        	</div>
                        </div>
                    </div>  
                 <% 
                 }
                 //out.print(request.getMethod());
                 if(request.getMethod().equals("POST")){
                 		//out.print("asdf");
	                 	ProductCar productCar = (ProductCar)session.getAttribute("productCar");
	                 	if(productCar==null){
	                 		productCar = new ProductCar();
	                 	}
	                 	String npid = request.getParameter("npid");
	                 	String ccnt = request.getParameter("ncnt");
	                 	if(npid!=null && ccnt!=null){

		                 	int ncnt = Integer.parseInt(ccnt);
		                 	Product pp = (Product)session.getAttribute(npid);
		                 	pp.setCount(ncnt);
		                 	productCar.addProduct(pp);
		                 	session.setAttribute("productCar", productCar);
		                 	
		                 	productCar = (ProductCar)session.getAttribute("productCar");
		                 	ArrayList<Product> productList = productCar.getProductList();
                 		}
                 	}
                 %>              
                
</body>
</html>
