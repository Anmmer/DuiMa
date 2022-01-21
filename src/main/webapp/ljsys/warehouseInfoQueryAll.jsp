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
<%@ include file="./warehouseInfo/queryAll.jsp" %>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    } else {
        var userInfo = document.getElementById("userInfo");
        userInfo.innerHTML = sessionStorage.getItem("userName").toString() + ",您好,欢迎使用相城绿建堆码后台管理系统!<a href='login.jsp'>点击登出</a>";
    }
</script>
</body>
</html>
