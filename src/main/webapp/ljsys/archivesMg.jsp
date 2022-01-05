<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>基础档案管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/css/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/css/pop_up.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/ljsys/js/jquery-3.3.1.min.js"></script>
</head>
<body class="BodyStyle">
<!-- 左边的菜单栏 -->
<%@ include file="menu.jsp" %>
<!-- 右边-->
<div style="height:100%;width:85%;background-color: white;float:left;">
    <!-- 顶部消息 -->
    <div style="height: 5%;width:100%;background-color: rgb(239,242,247);">
        <p id="userInfo" style="margin: 0 0;float: right;font-family: 宋体;font-size:20px;line-height: 40px;">TEXT</p>
    </div>
    <!-- 内容窗口 -->
    <div style="height: 95%;width: 100%">
        <div style="position:relative;top: 5%;left: 15%;height:15%;width:70%;font-family: Simsun;font-size:16px;">
            <label for="planname">项目名:</label><input id="planname" style="width: 15%;">
            <label for="qc" style="margin-left: 5%">质检员:</label><input id="qc" style="width: 15%;">
            <button style="width: 8%;margin-left: 5%" onclick="getTableData()">查 询</button>

        </div>
        <div style="width: 70%;height:85%;margin: 0 auto">
            <button style="position:absolute;top: 19%;width: 5%">新 增</button>
            <h3 style="text-align: center;margin-top: 0;">已导入计划列表</h3>
            <div style="height: 70%;">
                <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                    <tr>
                        <td class='tdStyle_title'>项目名称</td>
                        <td class='tdStyle_title'>产线信息</td>
                        <td class='tdStyle_title'>工厂</td>
                        <td class='tdStyle_title'>质检员</td>
                        <td class='tdStyle_title' style="width: 8%">操作</td>
                    </tr>
                    <tbody id="planTableText">
                    </tbody>
                </table>
            </div>
            <div style="height:30px;margin-top: 2%">
                <div style="width:33%;float: left;">
                    <button id="first" type="button" style="font-family: Simsun;font-size:16px;"
                            onclick="jumpToNewPage(1,false)">
                        第一页
                    </button>
                    <button id="last" type="button" style="font-family: Simsun;font-size:16px;"
                            onclick="jumpToNewPage(2,false)">
                        最后一页
                    </button>
                </div>
                <div style="width:34%;float: left;">
                    <p id="planResultTip"
                       style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">
                        1/1</p>
                </div>
                <div style="width:33%;float: left;">
                    <button id="next" type="button"
                            style="font-family: Simsun;font-size:16px;float:right;margin-left: 5px"
                            onclick="jumpToNewPage(4,false)">
                        后一页
                    </button>
                    <button id="pre" type="button" style="font-family: Simsun;font-size:16px;float:right;"
                            onclick="jumpToNewPage(3,false)">
                        前一页
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    } else {
        var userInfo = document.getElementById("userInfo");
        userInfo.innerHTML = sessionStorage.getItem("userName").toString() + ",您好,欢迎使用相城绿建堆码后台管理系统!<a href='login.jsp'>点击登出</a>";
    }
</script>
</html>
