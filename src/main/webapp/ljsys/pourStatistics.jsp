<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="BodyStyle">
<head>
    <meta charset="utf-8">
    <title>质检缺陷目录查询</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" type="text/css"/>
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="./js/util.js"></script>
    <script type="text/javascript" src="./js/echarts.js"></script>
</head>
<body class="BodyStyle">
<!-- 内容窗口 -->
<%@ include file="./statistic/pourStatistic.jsp" %>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        window.parent.location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    } else {
        if (!checkAuthority('17')) {
            window.parent.location.href = "login.jsp"
            window.alert("您没有访问权限！")
        }
    }

    function checkAuthority(au) {
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (var i = 0; i < authority.length; i++) {
            if (authority[i].fa_id == au) flag = true;
        }
        return flag;
    }
</script>
</body>
</html>
