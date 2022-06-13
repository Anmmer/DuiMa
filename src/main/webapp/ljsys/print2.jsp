<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="BodyStyle">
<head>
    <title>打印</title>
    <meta charset="utf-8">
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <link rel="stylesheet" href="css/style.css" type="text/css">
<%--    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>--%>
<%--    <script type="text/javascript" src="./js/qrcode.min.js"></script>--%>
    <script type="text/javascript" src="js/jquery-1.11.1.js" ></script>
    <script type="text/javascript" src="js/jquery.qrcode.js" ></script>
    <script type="text/javascript" src="js/utf.js" ></script>
    <script type="text/javascript" src="./js/xlsx.core.min.js"></script>
    <script type="text/javascript" src="./js/util.js"></script>
    <script type="text/javascript" src="dist/js/bootstrap.js"></script>
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" type="text/css"/>
<%--    <link rel="stylesheet" type="text/css" href="./css/pop_up.css">--%>
    <script type="text/javascript" src="./js/util.js"></script>
</head>
<body class="BodyStyle">
<%--            <%@ include file="./print/print2.jsp" %>--%>
<%@ include file="./print/print3.jsp" %>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        window.parent.location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    } else {
        if (!checkAuthority('13')) {
            window.parent.location.href = "login.jsp"
            window.alert("您没有访问权限！")
        }
    }
</script>
</body>
</html>
