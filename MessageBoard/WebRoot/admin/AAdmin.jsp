<%@page import="MessageBoard.Dao.DbDao"%>
<%@ page language="java" import="java.util.*,MessageBoard.Object.Product" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<meta charset="UTF-8">
		<title>购物车</title>
		<link rel="stylesheet" type="text/css" href="../css/cart.css" />
		<link href="../css/contactus-main.css" rel="stylesheet" type="text/css">
	</head>
	
	
	<script type="text/javascript">

	function add(){
	
		document.getElementById("add").submit();
  	}
  	
  	function modify(){
		document.getElementById("modify").submit();
  	}
  	
  	
  	function del(){
		document.getElementById("del").submit();
  	}
  	

</script>

	<body>


<div id="home">
    <div id="div-contact">
		<div class="container">
			<h1>商品</h1>
			<h3><a href=<%=basePath %>logout>退出</a></h3>
			<table id="productTable" border="1" cellspacing="0" cellpadding="0" ><!-- class="hide"-->
				<thead>
					<tr>
						<th>
							ID
						</th>
						<th>
							名字
						</th>
						<th>
							库存
						</th>
						<th>
							单价
						</th>
						<th>
							折扣
						</th>
						<th>
							描述
						</th>
						<th>
							图片地址
						</th>

					</tr>
				</thead>
				<%
					DbDao db  = DbDao.getDbOperator();
					ArrayList<Product> productList = db.getProduct();
					if(productList!=null){
						for(Product p:productList){
						
				 %>
				<tbody id="tbody">
					<tr>
						<td>
							<%=p.getPid() %>
						</td>
						<td>
							<%=p.getPname() %>
						</td>
						<td >
							<%=p.getQoh() %>
						</td>
						<td >
							<%=p.getOriginal_price() %>
						</td>
						<td >
							<%=p.getDiscnt_rate() %>
						</td>
						<td >
							<%=p.getDeps() %>
						</td>
						<td >
							<%=p.getImgUrl() %>
						</td>
					</tr>
				</tbody>
				<%
						}	
					}
				 %>
				 
				<%
				
					if(request.getMethod().equals("POST")){
						
						String type= request.getParameter("type");
							if("modify".equals(type)){
								String pid = (String)request.getParameter("pid");
								String pname = (String)request.getParameter("pname");
								String qoh = request.getParameter("qoh");
								String original = request.getParameter("original");
								String discnt = request.getParameter("discnt");
								String deps =(String) request.getParameter("deps");
								String imgUrl =(String) request.getParameter("imgUrl");
								Product pp = new Product();
								pp.setDeps(deps);
								pp.setDiscnt_rate(discnt);
								pp.setOriginal_price(original);
								pp.setQoh(qoh);
								pp.setQoh_threshold(10+"");
								pp.setImgUrl(imgUrl);
								boolean is = db.updateProduct(pp);
								if(is )out.print("ok ");
								else out.print("fail"); 
							}else{
								String pid = request.getParameter("pid");
								Product pp =new Product();
								pp.setPid(pid);
								boolean is = db.delectProduct(pp);
								if(is )out.print("ok ");
								else out.print("fail");
							}
						
					}
				 %>
				
			</table>
			
		</div>
<br>
<br>
<br>
<br>
<br>
<hr/>
<br>
<br>

        <div id="div-form">
            <div id="div-form-mes">
                <form class="contact_form" id="modify" action="" method="post">
                <input name="type" type="hidden" value="modify"/> 
                    <ul>
                        <li style="font:bold 25px Arial;color:rgb(124,124,125);">修改商品</li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            <label>商品编号</label>
                            <input type="text"  name="pid"/><!--required是规定该位置必填-->
                        </li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            <label>名称</label>
                            <input type="tel" name="pname" />
                        </li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            <label>库存</label>
                            <input type="text" name="qoh"/>
                        </li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            <label>单价</label>
                            <input type="text" name="original"/>
                        </li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            <label>折扣</label>
                            <input  name="discnt" /></input>
                        </li>
						<li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            <label>图片地址</label>
                            <input  name="imgUrl" /></input>
                        </li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            <label>描述</label>
                            <textarea rows="10" cols="200"  name="deps" /></textarea>
                        </li>
						
                        <li>
                            <button type="submit" onclick="modify()">修改</button>
                        </li>
                   
                    </ul>
                </form>
            </div>
        </div>


<br>
<br>
<br>
<br>
<br>
<hr/>
<br>
<br>
<br>
<br>
<br>
<br>


        <div id="div-form">
            <div id="div-form-mes">
                <form class="contact_form" id="del" action="#">
                    <ul>
                        <li style="font:bold 25px Arial;color:rgb(124,124,125);">删除商品</li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);width:auto">
                            <label style="width:auto;">请输入商品编号&nbsp &nbsp &nbsp </label>
                            <input type="text"  name="name0"/><!--requiredÊÇ¹æ¶¨¸ÃÎ»ÖÃ±ØÌî-->
                        </li>
                    
                    <li>
                            <button type="submit" onclick="del()">提交</button>
                     </li>
                     </ul>
                </form>
            </div>
        </div>

    </div>

    </div>
	</body>

</html>
