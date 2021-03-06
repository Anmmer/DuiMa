<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="BodyStyle">
<head>
    <meta charset="utf-8">
    <title>查询/新增角色</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" type="text/css"/>
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="dist/js/bootstrap.js"></script>
</head>
<body class="BodyStyle">
<!-- 内容窗口 -->
<%@ include file="./group/queryAll.jsp" %>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        window.parent.location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    }else{
        if(!checkAuthority('6')){
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
