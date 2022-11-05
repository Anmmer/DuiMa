<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>生产情况汇总</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/css/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/css/pop_up.css" type="text/css">
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ljsys/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="./js/util.js"></script>
</head>
<body class="BodyStyle">
<!-- 内容窗口 -->
<%@include file="product/productionSummary.jsp"%>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        window.parent.location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    }else{
        if(!checkAuthority('24')){
            window.parent.location.href = "login.jsp"
            window.alert("您没有访问权限！")
        }
    }
</script>
</body>
</html>
