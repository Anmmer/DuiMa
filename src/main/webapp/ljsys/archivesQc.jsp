<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>质检员管理管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/css/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/css/pop_up.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/ljsys/js/jquery-3.3.1.min.js"></script>
</head>
<body class="BodyStyle">
<!-- 左边的菜单栏 -->
<%@ include file="menu.jsp" %>
<div style="height:100%;width:85%;background-color: white;float:left;">
    <!-- 顶部消息 -->
    <div style="height: 5%;width:100%;background-color: rgb(239,242,247);">
        <p id="userInfo" style="margin: 0 0;float: right;font-family: 宋体;font-size:20px;line-height: 40px;">TEXT</p>
    </div>
    <!-- 内容窗口 -->
    <%@include file="archivesMg/qc.jsp"%>
</div>
</body>
</html>
