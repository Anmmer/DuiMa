<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html class="BodyStyle">
<head>
    <meta charset="utf-8">
    <title>菜单</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" type="text/css"/>
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script>
        function ShowOrHide(str, id) {
            var element = document.getElementById(str)
            if (element.style.display === "block") {
                element.style.display = "none"
            } else {
                element.style.display = "block"
            }
            let picture = $('#' + id).attr('src');
            if (picture === 'pictures/right.png') {
                $('#' + id).attr('src', 'pictures/down.png');
            } else {
                $('#' + id).attr('src', 'pictures/right.png');
            }
        }

        function jumpTo(str) {
            window.parent.jumpTo(str);
        }
    </script>
</head>
<body class="BodyStyle">
<div class="MenuStyle">
    <div class="li_TopItemStyle" style="height: 5%;text-align: center">
        相城绿建堆码
    </div>
    <!--用户管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('User','usr_pic')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none">
                <span class="glyphicon glyphicon-menu-down"></span>用户管理
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="User">
            <li class="li_ItemStyle" onclick="jumpTo('userQueryAll.jsp')">查询用户</li>
            <li class="li_ItemStyle" onclick="jumpTo('userAdd.jsp')">新增用户</li>
            <li class="li_ItemStyle" onclick="jumpTo('index.jsp')">主页</li>
        </ul>
    </ul>
    <!--群组管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Group','group_pic')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <%--                <img id="group_pic" style="margin-left: 10px" src="pictures/right.png">--%>
            </div>
            <span class="glyphicon glyphicon-menu-down"></span>群组管理
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Group">
            <li class="li_ItemStyle" onclick="jumpTo('groupQueryAll.jsp')">查询/新增群组</li>
        </ul>
    </ul>
    <!--工厂管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Factory','factory_pic')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <%--                <img id="factory_pic" style="margin-left: 10px" src="pictures/right.png">--%>
            </div>
            <span class="glyphicon glyphicon-menu-down"></span>库存管理
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Factory">
            <li class="li_ItemStyle" onclick="jumpTo('factoryQueryAll.jsp')">信息查询</li>
        </ul>
    </ul>
    <!--二维码-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Equipment','equipment_pic')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <%--                <img id="equipment_pic" style="margin-left: 10px" src="pictures/right.png">--%>
            </div>
            <span class="glyphicon glyphicon-menu-down"></span>基础档案管理
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Equipment">
            <li class="li_ItemStyle" onclick="jumpTo('qrcodeQueryAll.jsp')">二维码设置</li>
            <li class="li_ItemStyle" onclick="jumpTo('archivesPlanName.jsp')">项目管理</li>
            <li class="li_ItemStyle" onclick="jumpTo('archivesLine.jsp')">产线管理</li>
            <li class="li_ItemStyle" onclick="jumpTo('archivesPlant.jsp')">工厂管理</li>
            <li class="li_ItemStyle" onclick="jumpTo('archivesQc.jsp')">质检员管理</li>
        </ul>
    </ul>
    <!--打印管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('rqCode','rqCode_pic')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <%--                <img id="rqCode_pic" style="margin-left: 10px" src="pictures/right.png">--%>
            </div>
            <span class="glyphicon glyphicon-menu-down"></span>打印管理
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="rqCode">
            <!--<li class="li_ItemStyle" onclick="jumpTo('printQueryAll.jsp')">信息查询</li>-->
            <li class="li_ItemStyle" onclick="jumpTo('print2.jsp')">打印界面</li>
        </ul>
    </ul>
</div>
</body>
</html>
