<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html style="height: 100%;width: 100%">
<head>
    <meta charset="utf-8">
    <title>菜单</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="dist/css/bootstrap.min.css" type="text/css"/>
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="./js/util.js"></script>
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

        function check() {
            let index = 0;
            if (checkAuthority("3")) {
                $('#user_query_li').css('display', 'block');
            } else {
                $('#user_query_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("4")) {
                $('#user_add_li').css('display', 'block');
            } else {
                $('#user_add_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("5")) {
                $('#user_index_li').css('display', 'block');
            } else {
                $('#user_index_li').css('display', 'none');
                index++;
            }
            //权限判断隐藏大节点
            if (index === 3) {
                $('#userManage').css('display', 'none');
            } else {
                $('#userManage').css('display', 'block');
            }
            index = 0;

            if (checkAuthority("6")) {
                $('#group_query_li').css('display', 'block');
            } else {
                $('#group_query_li').css('display', 'none');
                index++;
            }
            //权限判断隐藏大节点
            if (index === 1) {
                $('#groupManage').css('display', 'none');
            } else {
                $('#groupManage').css('display', 'block');
            }

            index = 0;
            if (checkAuthority("7")) {
                $('#Factory_li').css('display', 'block');
            } else {
                $('#Factory_li').css('display', 'none');
                index++;
            }
            //权限判断隐藏大节点
            if (index === 1) {
                $('#factoryManage').css('display', 'none');
            } else {
                $('#factoryManage').css('display', 'block');
            }

            index = 0;
            if (checkAuthority("8")) {
                $('#qrCode_set_li').css('display', 'block');
            } else {
                $('#qrCode_set_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("9")) {
                $('#plan_name_li').css('display', 'block');
            } else {
                $('#plan_name_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("10")) {
                $('#plan_line_li').css('display', 'block');
            } else {
                $('#plan_line_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("11")) {
                $('#plan_fant_li').css('display', 'block');
            } else {
                $('#plan_fant_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("12")) {
                $('#plan_qc_li').css('display', 'block');
            } else {
                $('#plan_qc_li').css('display', 'none');
                index++;
            }
            //权限判断隐藏大节点
            if (index === 5) {
                $('#equipmentManage').css('display', 'none');
            } else {
                $('#equipmentManage').css('display', 'block');
            }

            index = 0;
            if (checkAuthority("13")) {
                $('#print_li').css('display', 'block');
            } else {
                $('#print_li').css('display', 'none');
                index++;
            }
            //权限判断隐藏大节点
            if (index === 1) {
                $('#qrCodeManage').css('display', 'none');
            } else {
                $('#qrCodeManage').css('display', 'block');
            }
        }
    </script>
</head>
<body style="height: 100%;width: 100%">
<div class="MenuStyle">
    <div class="li_TopItemStyle" style="height: 5%;text-align: center;">
        相城绿建堆码
    </div>
    <!--用户管理-->
    <ul class="ul_TopListStyle" id="userManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('User','user_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left"><span style="margin-right: 5%;"
                                                                                            class="glyphicon glyphicon-tree-conifer"></span>用户管理
                </div>
                <span id="user_icon" style="float: right;margin-top: 4%" class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="User">
            <li id="user_query_li">
                <button class="li_ItemStyle" id="user_query" onclick="jumpTo('userQueryAll.jsp','user_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>查询用户
                </button>
            </li>
            <li id="user_add_li">
                <button class="li_ItemStyle" id="user_add" onclick="jumpTo('userAdd.jsp','user_add')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>新增用户
                </button>
            </li>
            <li id="user_index_li">
                <button class="li_ItemStyle" id="user_index" onclick="jumpTo('index.jsp','user_index')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>主页
                </button>
            </li>
        </ul>
    </ul>
    <!--群组管理-->
    <ul class="ul_TopListStyle" id="groupManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Group','group_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>权限管理
                </div>
                <span id="group_icon"
                      style="float: right;margin-top: 4%"
                      class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Group">
            <li id="group_query_li">
                <button class="li_ItemStyle" id="group_query" onclick="jumpTo('groupQueryAll.jsp','group_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>查询/新增角色
                </button>
            </li>
        </ul>
    </ul>
    <!--库存管理-->
    <ul class="ul_TopListStyle" id="factoryManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Factory','factory_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>库存管理
                </div>
                <span id="factory_icon" style="float: right;margin-top: 4%"
                      class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Factory">
            <li id="factory_query_li">
                <button class="li_ItemStyle" id="factory_query" onclick="jumpTo('factoryQueryAll.jsp','factory_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>信息查询
                </button>
            </li>
        </ul>
    </ul>
    <!--生产管理-->
    <ul class="ul_TopListStyle" id="productManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('product','product_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>生产管理
                </div>
                <span id="product_icon" style="float: right;margin-top: 4%"
                      class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="product">
            <li id="query_set_li">
                <button class="li_ItemStyle" id="query_set" onclick="jumpTo('productQueryAll.jsp','query_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>生产查询
                </button>
            </li>
            <li id="pour_set_li">
                <button class="li_ItemStyle" id="pour_set" onclick="jumpTo('pourQueryAll.jsp','pour_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>浇捣
                </button>
            </li>
            <li id="inspect_set_li">
                <button class="li_ItemStyle" id="inspect_set" onclick="jumpTo('inspectQueryAll.jsp','inspect_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>质检
                </button>
            </li>
        </ul>
    </ul>
    <!--二维码-->
    <ul class="ul_TopListStyle" id="equipmentManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Equipment','equipment_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>基础档案管理
                </div>
                <span id="equipment_icon" style="float: right;margin-top: 4%"
                      class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="Equipment">
            <li id="qrCode_set_li">
                <button class="li_ItemStyle" id="qrCode_set" onclick="jumpTo('qrcodeQueryAll.jsp','qrCode_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>二维码设置
                </button>
            </li>
            <li  id="plan_name_li">
                <button class="li_ItemStyle" id="plan_name" onclick="jumpTo('archivesPlanName.jsp','plan_name')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>项目管理
                </button>
            </li>
            <li id="plan_line_li">
                <button class="li_ItemStyle" id="plan_line" onclick="jumpTo('archivesLine.jsp','plan_line')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>产线管理
                </button>
            </li>
            <li id="plan_fant_li">
                <button class="li_ItemStyle" id="plan_fant" onclick="jumpTo('archivesPlant.jsp','plan_fant')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>工厂管理
                </button>
            </li>
            <li id="plan_qc_li">
                <button class="li_ItemStyle" id="plan_qc" onclick="jumpTo('archivesQc.jsp','plan_qc')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>质检员管理
                </button>
            </li>
        </ul>
    </ul>
    <!--打印管理-->
    <ul class="ul_TopListStyle" id="qrCodeManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('rqCode','rqCode_icon')">
            <button style="width: 100%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>打印管理
                </div>
                <span id="rqCode_icon" style="float: right;margin-top: 4%" class="glyphicon glyphicon-menu-down"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: block;" id="rqCode">
            <!--<li class="li_ItemStyle" onclick="jumpTo('printQueryAll.jsp')">信息查询</li>-->
            <li id="print_li">
                <button class="li_ItemStyle" id="print" onclick="jumpTo('print2.jsp','print')"><span
                        style="margin-left: 15%;margin-right: 5%;"
                        class="glyphicon glyphicon-grain"></span>打印界面
                </button>
            </li>
        </ul>
    </ul>
</div>
</body>
<script>
    window.onload = check();
</script>
<style>
    .li_ItemStyle:hover {
        border: 1px solid #337ab7;
    }

    .current {
        background-color: #337ab7;
    }
</style>
</html>
