<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="BodyStyle">
    <head>
        <meta charset="utf-8">
        <title>相城绿建堆码后台管理系统</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="./js/qrcode.min.js"></script>
    </head>
    <body class="BodyStyle">
        <!-- 左边的菜单栏 -->
        <%@ include file="menu.jsp" %>
        <!-- 右边-->
        <div style="height:100%;width:85%;background-color: aqua;float:left;">
            <!-- 顶部消息 -->
            <div style="height: 5%;width:100%;background-color: rgb(239,242,247);">
                <p id="userInfo" style="margin: 0 0;float: right;font-family: 宋体;font-size:20px;line-height: 40px;">TEXT</p>
            </div>
            <!-- 内容窗口 -->
            <%@ include file="./warehouseInfo/queryAll.jsp" %>
        </div>
        <script type="text/javascript">
            if(sessionStorage.getItem("userName")==null){
                location.href = "login.jsp"
                window.alert("您未登陆，请先登陆！")
            }
            else{
                var userInfo = document.getElementById("userInfo");
                userInfo.innerHTML = sessionStorage.getItem("userName").toString()+",您好,欢迎使用相城绿建堆码后台管理系统!<a href='login.jsp'>点击登出</a>";
            }
        </script>
    </body>
</html>