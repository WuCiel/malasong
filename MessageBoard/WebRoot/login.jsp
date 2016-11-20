<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>


<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+
	request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <meta http-equiv="x-ua-compatible" content="IE=edge"><!--对IE设置兼容-->
    <link rel="SHORTCUT ICON" href="image/show.png"><!--用一个矢量图做为网站图标-->
    <link href=<%=basePath %>css/contactus-main.css rel="stylesheet" type="text/css">
    <script src="js/jQuery.js" type="text/javascript"></script>
    <script src="js/contactus-main.js" type="text/javascript"></script>
</head>

<body>
<div id="home-father">
    <div id="home">
        <!--图片-->
        <div id="top">
            <div id="header_right"><a href=""><img src=<%=basePath %>image/show.png width="200px" height="100px" /></a></div>
            <div id="header_left">
                <div  id="div_text1"><a href="">编程马拉松</a></div>
                <div id="div_text2"><p>编程马拉松</p></div>
            </div>
        </div>


    <!--联系我们区域-->
    <div id="div-contact">

        <div id="div-form">
            <div id="div-form-mes">
                <form class="contact_form" method="post" name="loginForm" action="http://172.29.107.233:8080/MessageBoard/JudgeLogin">
                    <center>
                    <ul>
                        <li style="font:bold 25px Arial;color:rgb(124,124,125);" >登 录</li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            账号 &nbsp;&nbsp;
                            <input type="text"  placeholder="666666" name="cname" required/>
                            <!-- pattern="[0-9]{6}" -->
                            <!--required是规定该位置必填-->
                        </li>
                        <li style="font:normal 18px Arial;color:rgb(124,124,125);">
                            密码 &nbsp;&nbsp;
                            <input type="password" placeholder="666666" name="cpwd" required/>
                        </li>
                        <li>
                            <button type="regist" onclick="window.location.href='<%=basePath %>regieter.html' " style="margin-left:60px;">注册</button>
                            <button type="submit" onclick="text_is_right()" style="margin-left:50px;">提交</button>
                        </li>
                    </ul>
                </center>
                </form>
            </div>
        </div>

    </div>
   
</div>
</div>
</body>
</html>