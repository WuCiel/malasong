<%@page import="MessageBoard.Object.ProductCar"%>
<%@page import="MessageBoard.Object.Product"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>订单</title>
		<!--è´­ç©è½¦æ ·å¼è¡¨-->
		<link rel="stylesheet" type="text/css" href="css/cart.css" />
		<!--æä½cookieçjsæä»¶-->
		<script type="text/javascript" src="js/cookie.js"></script>
		
		<style type="text/css">
				.buttonstyle{
				width:50px;
		}
		
		</style>

	</head>

	<body>

		<div class="container">
			<h1>订单</h1>
			<h3><a href=<%=basePath %>GetProductList>返回商品页面</a></h3>
			<table id="productTable" border="1" cellspacing="0" cellpadding="0" ><!-- class="hide"-->
				<thead>
					<tr>

						<th>
							图片
						</th>
						<th>
							名字
						</th>
						<th>
							数量
						</th>
						<th>
							单价
						</th>
						<th>
							小计
						</th>
						<th>
							操作
						</th>
					</tr>
				</thead>
				
				<tbody id="tbody">
				<%
					double tolMon=0;
					ProductCar productCar = (ProductCar) session.getAttribute("productCar");
					java.text.DecimalFormat   df=new   java.text.DecimalFormat("#.##");   
					if(productCar!=null){
						int cnt=1;
						ArrayList<Product> productList = productCar.getProductList();
						for(Product p:productList){
						tolMon+=Double.parseDouble(p.getOriginal_price())*Double.parseDouble(p.getDiscnt_rate());
				 %>
					<tr>
						<td>
							<img src=<%=p.getImgUrl() %> id="productImg"/>
						</td>
						<td id="pName">
							<%=p.getPname() %>
						</td>
						<td>
							<button id="min" onclick="minCount(<%=cnt %>)" class="down">-</button>
							<input id="pcount<%=cnt %>" type="text" value="<%=p.getCount() %>" />
							<button id="add" onclick="addCount(<%=cnt %>)" class="up">+</button>库存<span id="qoh<%=cnt%>"><%=p.getQoh() %></span><!--readonly="readonly" -->
						</td>
						<td >
							￥<span id="singlePrice<%=cnt%>"><%=(int)(Double.parseDouble(p.getOriginal_price())*Double.parseDouble(p.getDiscnt_rate()))%></span>
						</td>
						<td >
							￥<span id="manyPrice<%=cnt %>"><%=(int)(Double.parseDouble(p.getOriginal_price())*Double.parseDouble(p.getDiscnt_rate())*p.getCount())%></span>
						</td>
						<td>
							<button id="delProduct" onclick="delPro(<%=cnt %>)" class="del">删除</button>
						</td>
					</tr>
				
				</tbody>
				<%
							cnt++;
						}
					}
				 %>
			</table>
			
			
			<script>

				var tb = document.getElementById("productTable");
					 var rows = tb.rows;
					              //åå¾è¿ä¸ªtableä¸çææè¡
					 for(var i=0;i<rows.length;i++)//å¾ªç¯éåææçtrè¡
					 {

				 		 for(var j=0;j<rows[i].cells.length;j++)//åå¾ç¬¬å è¡ä¸é¢çtdä¸ªæ°ï¼åæ¬¡å¾ªç¯éåè¯¥è¡ä¸é¢çtdåç´ 
				  		{
				     		var cell = rows[i].cells[j];//è·åæè¡ä¸é¢çæä¸ªtdåç´ 
							//document.write(rows[i].cells[j].innerHTML);
							//document.write(rows[i].cells[j].getElementByTagName("button").innerHTML);

				    	}
					 }
						function addCount(i)
						{
							var qoh=document.getElementById("qoh"+i).innerText;
							var numberQoh=Number(qoh);
							var count=document.getElementById("pcount"+i).value;
							var newCount=Number(count);
							if (newCount>=numberQoh){return ;}
							newCount=newCount+1;

							var sprice=document.getElementById("singlePrice"+i).innerText;
							var numSprice=Number(sprice);
							document.getElementById("manyPrice"+i).innerHTML=numSprice*newCount;
							document.getElementById("pcount"+i).value=newCount;

							var allPrice=document.getElementById("totalPrice").innerText;
							var numAllPrice=Number(allPrice);
							document.getElementById("totalPrice").innerHTML=numAllPrice+numSprice;
						}
						function minCount(i)
						{
							var count=document.getElementById("pcount"+i).value;
							var newCount=Number(count);
							if(newCount<=1){return ;}
							newCount=newCount-1;
							document.getElementById("pcount"+i).value=newCount;

							var sprice=document.getElementById("singlePrice"+i).innerText;
							var numSprice=Number(sprice);
							document.getElementById("manyPrice"+i).innerHTML=numSprice*newCount;
							document.getElementById("pcount"+i).value=newCount;

							var allPrice=document.getElementById("totalPrice").innerText;
							var numAllPrice=Number(allPrice);
							document.getElementById("totalPrice").innerHTML=numAllPrice-numSprice;
						}
						function delPro(i)
						{
							var maniPri=document.getElementById("manyPrice"+i).innerText;
							var mm=Number(maniPri);
							var allPrice=document.getElementById("totalPrice").innerText;
							var numAllPrice=Number(allPrice);
							document.getElementById("totalPrice").innerHTML=numAllPrice-mm;
							document.getElementById("productTable").deleteRow(i);
						}
						
						function tijiao(){
						alert("订单已提交");
						window.location.href="GetProductList";
						}
							
                        	
        </script>
			<!--<div class="box" id="box">è´­ç©è½¦éæ²¡æä»»ä½åå</div> -->
			<h2 id="h2" class="">总价￥<span id="totalPrice"><%=(int)tolMon %></span></h2>
			<button onclick="tijiao()" style="width:200px;height:30px;background-color:#FF6347;float:right;margin-top:30px;">提交订单</button>
		</div>
		<script src="../js/server.js" type="text/javascript" charset="utf-8"></script>
		<!--æä½è´­ç©è½¦é¡µé¢çcart.js-->
		<script src="../js/cart.js"></script>
	</body>

</html>