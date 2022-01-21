<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html style="height: 100%;width: 100%">
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
            let icon = $('#' + id).attr('class');
            if (icon == 'glyphicon glyphicon-menu-down') {
                $('#' + id).attr('class', 'glyphicon glyphicon-menu-left');
            } else {
                $('#' + id).attr('class', 'glyphicon glyphicon-menu-down');
            }
        }

        let current = null;

        function jumpTo(str, id) {
            window.parent.jumpTo(str);
            if (current !== null) {
                $('#' + current).removeClass('current');
            }
            $('#' + id).addClass('current');
            current = id;
        }
    </script>
</head>
<body style="height: 100%;width: 100%">
<div class="MenuStyle">
    <div class="li_TopItemStyle" style="height: 5%;text-align: center;">
        相城绿建堆码
    </div>
    <!--用户管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('User','user_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none; text-align:left">
                <span style="margin-left: 10%;margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>用户管理<span id="user_icon"
                                                                                style="position: relative;right: -40%"
                                                                                class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="User">
            <li>
                <button class="li_ItemStyle" id="user_query" onclick="jumpTo('userQueryAll.jsp','user_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>查询用户
                </button>
            </li>
            <li>
                <button class="li_ItemStyle" id="user_add" onclick="jumpTo('userAdd.jsp','user_add')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>新增用户
                </button>
            </li>
            <li>
                <button class="li_ItemStyle" id="user_index" onclick="jumpTo('index.jsp','user_index')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>主页
                </button>
            </li>
        </ul>
    </ul>
    <!--群组管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Group','group_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <span style="margin-left: 10%;margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>群组管理<span id="group_icon"
                                                                                style="position: relative;right: -40%"
                                                                                class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Group">
            <li>
                <button class="li_ItemStyle" id="group_query" onclick="jumpTo('groupQueryAll.jsp','group_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>查询/新增群组
                </button>
            </li>
        </ul>
    </ul>
    <!--工厂管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Factory','factory_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <span style="margin-left: 10%;margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>库存管理<span id="factory_icon"
                                                                                style="position: relative;right: -40%"
                                                                                class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Factory">
            <li>
                <button class="li_ItemStyle" id="factory_query" onclick="jumpTo('factoryQueryAll.jsp','factory_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>信息查询
                </button>
            </li>
        </ul>
    </ul>
    <!--二维码-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Equipment','equipment_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <span style="margin-left: 10%;margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>基础档案管理<span id="equipment_icon"
                                                                                  style="position: relative;right: -27%"
                                                                                  class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Equipment">
            <li>
                <button class="li_ItemStyle" id="qrCode_set" onclick="jumpTo('qrcodeQueryAll.jsp','qrCode_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>二维码设置
                </button>
            </li>
            <li>
                <button class="li_ItemStyle" id="plan_name" onclick="jumpTo('archivesPlanName.jsp','plan_name')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>项目管理
                </button>
            </li>
            <li>
                <button class="li_ItemStyle" id="plan_line" onclick="jumpTo('archivesLine.jsp','plan_line')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>产线管理
                </button>
            </li>
            <li>
                <button class="li_ItemStyle" id="plan_fant" onclick="jumpTo('archivesPlant.jsp','plan_fant')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>工厂管理
                </button>
            </li>
            <li>
                <button class="li_ItemStyle" id="plan_qc" onclick="jumpTo('archivesQc.jsp','plan_qc')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>质检员管理
                </button>
            </li>
        </ul>
    </ul>
    <!--打印管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('rqCode','rqCode_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <span style="margin-left: 10%;margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>打印管理<span id="rqCode_icon"
                                                                                style="position: relative;right: -40%"
                                                                                class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="rqCode">
            <!--<li class="li_ItemStyle" onclick="jumpTo('printQueryAll.jsp')">信息查询</li>-->
            <li>
                <button class="li_ItemStyle" id="print" onclick="jumpTo('print2.jsp','print')"><span
                        style="margin-left: 15%;margin-right: 5%;"
                        class="glyphicon glyphicon-grain"></span>打印界面
                </button>
            </li>
        </ul>
    </ul>
</div>
</body>
<style>
    .li_ItemStyle:hover {
        border: 1px solid #337ab7;
    }

    .current {
        background-color: #337ab7;
    }
</style>
</html>
