<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="BodyStyle">
<head>
    <meta charset="utf-8">
    <title>二维码设置</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="dist/css/bootstrap.css" type="text/css"/>
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="./js/qrcode.min.js"></script>
</head>
<body class="BodyStyle">
<%@ include file="qrcode/info.jsp" %>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    }
</script>
</body>
</html>
