<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html style="margin:0px;padding:0px;height: 100%;width: 100%">
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
                $('#factory_qrcode_query_li').css('display', 'block');
            } else {
                $('#factory_qrcode_query_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("25")) {
                $('#factory_query_li').css('display', 'block');
            } else {
                $('#factory_query_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("20")) {
                $('#patch_library_query_li').css('display', 'block');
            } else {
                $('#patch_library_query_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("26")) {
                $('#production_in_out__warehouse_li').css('display', 'block');
            } else {
                $('#production_in_out__warehouse_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("29")) {
                $('#warehouse_log_li').css('display', 'block');
            } else {
                $('#warehouse_log_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("30")) {
                $('#warehouse_scrap_li').css('display', 'block');
            } else {
                $('#warehouse_scrap_li').css('display', 'none');
                index++;
            }
            //权限判断隐藏大节点
            if (index === 5) {
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
            if (checkAuthority("17")) {
                $('#fail_content_li').css('display', 'block');
            } else {
                $('#fail_content_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("18")) {
                $('#default_set_li').css('display', 'block');
            } else {
                $('#default_set_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("23")) {
                $('#factory_set_li').css('display', 'block');
            } else {
                $('#factory_set_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("31")) {
                $('#location_set_li').css('display', 'block');
            } else {
                $('#location_set_li').css('display', 'none');
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
            if (checkAuthority("27")) {
                $('#out_warehouse_li').css('display', 'block');
            } else {
                $('#out_warehouse_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("28")) {
                $('#in_warehouse_li').css('display', 'block');
            } else {
                $('#in_warehouse_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("32")) {
                $('#construction_unit_manage_li').css('display', 'block');
            } else {
                $('#construction_unit_manage_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("33")) {
                $('#site_info_manage_li').css('display', 'block');
            } else {
                $('#site_info_manage_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("35")) {
                $('#rebar_name_manage_li').css('display', 'block');
            } else {
                $('#rebar_name_manage_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("34")) {
                $('#production_unit_manage_li').css('display', 'block');
            } else {
                $('#production_unit_manage_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("36")) {
                $('#fillingInfo1_manage_li').css('display', 'block');
            } else {
                $('#fillingInfo1_manage_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("37")) {
                $('#fillingInfo2_manage_li').css('display', 'block');
            } else {
                $('#fillingInfo2_manage_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("38")) {
                $('#cementType_manage_li').css('display', 'block');
            } else {
                $('#cementType_manage_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("39")) {
                $('#cementGrade_manage_li').css('display', 'block');
            } else {
                $('#cementGrade_manage_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("40")) {
                $('#ConcreteMaterialsAreaManage_manage_li').css('display', 'block');
            } else {
                $('#ConcreteMaterialsAreaManage_manage_li').css('display', 'none');
                index++;
            }

            //权限判断隐藏大节点
            if (index === 20) {
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

            index = 0;
            if (checkAuthority("14")) {
                $('#query_set_li').css('display', 'block');
            } else {
                $('#query_set_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("15")) {
                $('#pour_set_li').css('display', 'block');
            } else {
                $('#pour_set_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("16")) {
                $('#inspect_set_li').css('display', 'block');
            } else {
                $('#inspect_set_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("19")) {
                $('#test_set_li').css('display', 'block');
            } else {
                $('#test_set_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("21")) {
                $('#build_upload_li').css('display', 'block');
            } else {
                $('#build_upload_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("22")) {
                $('#build_query_li').css('display', 'block');
            } else {
                $('#build_query_li').css('display', 'none');
                index++;
            }
            if (checkAuthority("24")) {
                $('#production_summary_li').css('display', 'block');
            } else {
                $('#production_summary_li').css('display', 'none');
                index++;
            }
            //权限判断隐藏大节点
            if (index === 7) {
                $('#productManage').css('display', 'none');
            } else {
                $('#productManage').css('display', 'block');
            }
        }
    </script>
</head>
<body style="margin:0px;padding:0px;height: 100%;width: 100%">
<div class="MenuStyle">
    <div class="li_TopItemStyle" style="height: 5%;text-align: center;">
        相城绿建堆码
    </div>
    <!--用户管理-->
    <ul class="ul_TopListStyle" id="userManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('User','user_icon')">
            <button style="width: 95%;height:40px;background-color: rgb(50, 64, 87);border: none;">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left"><span style="margin-right: 5%;"
                                                                                            class="glyphicon glyphicon-tree-conifer"></span>用户管理
                </div>
                <span id="user_icon" style="float: right;margin-top: 7%;color: #909399;font-size: 12px"
                      class="glyphicon glyphicon-menu-left"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: none;" id="User">
            <li id="user_index_li">
                <button class="li_ItemStyle" id="user_index" onclick="jumpTo('index.jsp','user_index')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>主页
                </button>
            </li>
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
        </ul>
    </ul>
    <!--群组管理-->
    <ul class="ul_TopListStyle" id="groupManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Group','group_icon')">
            <button style="width: 95%;height:40px;background-color: rgb(50, 64, 87);border: none;">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>权限管理
                </div>
                <span id="group_icon"
                      style="float: right;margin-top: 7%;color: #909399;font-size: 12px"
                      class="glyphicon glyphicon-menu-left"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: none;" id="Group">
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
            <button style="width: 95%;height:40px;background-color: rgb(50, 64, 87);border: none;">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>库存管理
                </div>
                <span id="factory_icon" style="float: right;margin-top: 7%;color: #909399;font-size: 12px"
                      class="glyphicon glyphicon-menu-left"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: none;" id="Factory">
            <li id="factory_qrcode_query_li">
                <button class="li_ItemStyle" id="factory_qrcode_query"
                        onclick="jumpTo('factoryQrcodeQueryAll.jsp','factory_qrcode_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>堆场展码
                </button>
            </li>
            <li id="factory_query_li">
                <button class="li_ItemStyle" id="factory_query" onclick="jumpTo('factoryQueryAll.jsp','factory_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>堆场查询
                </button>
            </li>
            <li id="patch_library_query_li">
                <button class="li_ItemStyle" id="patch_library_query"
                        onclick="jumpTo('patchLibraryQueryAll.jsp','patch_library_query')">
                    <span style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>修补库查询
                </button>
            </li>
            <li id="production_in_out__warehouse_li">
                <button class="li_ItemStyle" id="production_in_out__warehouse"
                        onclick="jumpTo('productInOutWarehouseQuery.jsp','production_in_out__warehouse')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>出入移库
                </button>
            </li>
            <li id="warehouse_scrap_li">
                <button class="li_ItemStyle" id="warehouse_scrap"
                        onclick="jumpTo('productWarehouseScrapQuery.jsp','warehouse_scrap')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>报废出入库
                </button>
            </li>
            <li id="warehouse_log_li">
                <button class="li_ItemStyle" id="warehouse_log"
                        onclick="jumpTo('productWarehouseLogQuery.jsp','warehouse_log')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>出入库单打印
                </button>
            </li>
        </ul>
    </ul>
    <!--生产管理-->
    <ul class="ul_TopListStyle" id="productManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('product','product_icon')">
            <button style="width: 95%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>生产管理
                </div>
                <span id="product_icon" style="float: right;margin-top: 7%;color: #909399;font-size: 12px"
                      class="glyphicon glyphicon-menu-left"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: none;" id="product">
            <li id="query_set_li">
                <button class="li_ItemStyle" id="query_set" onclick="jumpTo('productQueryAll.jsp','query_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>生产查询
                </button>
            </li>
            <li id="test_set_li">
                <button class="li_ItemStyle" id="test_set" onclick="jumpTo('coverTestQueryAll.jsp','test_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>隐蔽性检验
                </button>
            </li>
            <li id="pour_set_li">
                <button class="li_ItemStyle" id="pour_set" onclick="jumpTo('pourQueryAll.jsp','pour_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>浇捣
                </button>
            </li>
            <li id="inspect_set_li">
                <button class="li_ItemStyle" id="inspect_set"
                        onclick="jumpTo('inspectQueryAll.jsp','inspect_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>质检
                </button>
            </li>
            <li id="build_upload_li">
                <button class="li_ItemStyle" id="build_upload"
                        onclick="jumpTo('archivesBuildUpload.jsp','build_upload')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>构件上传
                </button>
            </li>
            <li id="build_query_li">
                <button class="li_ItemStyle" id="build_query"
                        onclick="jumpTo('archivesBuildQuery.jsp','build_query')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>构件查询
                </button>
            </li>
            <li id="production_summary_li">
                <button class="li_ItemStyle" id="production_summary"
                        onclick="jumpTo('productionSummaryQueryAll.jsp','production_summary')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>生产查询汇总
                </button>
            </li>
        </ul>
    </ul>
    <!--基础档案-->
    <ul class="ul_TopListStyle" id="equipmentManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Equipment','equipment_icon')">
            <button style="width: 95%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>基础档案管理
                </div>
                <span id="equipment_icon" style="float: right;margin-top: 7%;color: #909399;font-size: 12px"
                      class="glyphicon glyphicon-menu-left"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: none;" id="Equipment">
            <li id="qrCode_set_li">
                <button class="li_ItemStyle" id="qrCode_set" onclick="jumpTo('qrcodeQueryAll.jsp','qrCode_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>二维码设置
                </button>
            </li>
            <li id="fail_content_li">
                <button class="li_ItemStyle" id="fail_content"
                        onclick="jumpTo('failContentQueryAll.jsp','fail_content')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>质检缺陷目录维护
                </button>
            </li>
            <li id="default_set_li">
                <button class="li_ItemStyle" id="default_set" onclick="jumpTo('archivesSet.jsp','default_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>系统设置
                </button>
            </li>
            <li id="factory_set_li">
                <button class="li_ItemStyle" id="factory_set"
                        onclick="jumpTo('archivesFactory.jsp','factory_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>仓库管理
                </button>
            </li>
            <li id="location_set_li">
                <button class="li_ItemStyle" id="location_set"
                        onclick="jumpTo('archivesLocation.jsp','location_set')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>货位管理
                </button>
            </li>
            <li id="plan_name_li">
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
            <li id="out_warehouse_li">
                <button class="li_ItemStyle" id="out_warehouse"
                        onclick="jumpTo('archivesOutWarehouseMethod.jsp','out_warehouse')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>出库方式
                </button>
            </li>
            <li id="in_warehouse_li">
                <button class="li_ItemStyle" id="in_warehouse"
                        onclick="jumpTo('archivesInWarehouseMethod.jsp','in_warehouse')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>入库方式
                </button>
            </li>
            <li id="construction_unit_manage_li">
                <button class="li_ItemStyle" id="construction_unit_manage"
                        onclick="jumpTo('archivesConstructionUnitManage.jsp','construction_unit_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>施工单位名称
                </button>
            </li>
            <li id="site_info_manage_li">
                <button class="li_ItemStyle" id="site_info_manage"
                        onclick="jumpTo('archivesSiteInfoManage.jsp','site_info_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>工地编号
                </button>
            </li>
            <li id="rebar_name_manage_li">
                <button class="li_ItemStyle" id="rebar_name_manage"
                        onclick="jumpTo('archivesRebarNameManage.jsp','rebar_name_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>构建用钢筋名称
                </button>
            </li>
            <li id="production_unit_manage_li">
                <button class="li_ItemStyle" id="production_unit_manage"
                        onclick="jumpTo('archivesProdcutionUnitManage.jsp','production_unit_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>构件生产单位
                </button>
            </li>
            <li id="fillingInfo1_manage_li">
                <button class="li_ItemStyle" id="fillingInfo1_manage"
                        onclick="jumpTo('archivesFillingInfo1Manage.jsp','fillingInfo1_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>钢筋生产企业备案证编号
                </button>
            </li>
            <li id="fillingInfo2_manage_li">
                <button class="li_ItemStyle" id="fillingInfo2_manage"
                        onclick="jumpTo('archivesFillingInfo2Manage.jsp','fillingInfo2_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>水泥生产企业备案证编号
                </button>
            </li>
            <li id="cementType_manage_li">
                <button class="li_ItemStyle" id="cementType_manage"
                        onclick="jumpTo('archivesCementTypeManage.jsp','cementType_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>混凝土用水泥种类
                </button>
            </li>
            <li id="cementGrade_manage_li">
                <button class="li_ItemStyle" id="cementGrade_manage"
                        onclick="jumpTo('archivesCementGradeManage.jsp','cementGrade_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>混凝土用水泥等级
                </button>
            </li>
            <li id="ConcreteMaterialsAreaManage_manage_li">
                <button class="li_ItemStyle" id="ConcreteMaterialsAreaManage_manage"
                        onclick="jumpTo('archivesConcreteMaterialsAreaManage.jsp','ConcreteMaterialsAreaManage_manage')"><span
                        style="margin-left: 15%;margin-right: 5%;" class="glyphicon glyphicon-grain"></span>混凝土用沙用石产地
                </button>
            </li>
        </ul>
    </ul>
    <!--打印管理-->
    <ul class="ul_TopListStyle" id="qrCodeManage">
        <li class="li_TopItemStyle" onclick="ShowOrHide('rqCode','rqCode_icon')">
            <button style="width: 95%;height:40px;background-color: rgb(50, 64, 87);border: none;text-align:left">
                <div style="float: left;margin-left: 10%;width: 80%;text-align: left">
                <span style="margin-right: 5%;"
                      class="glyphicon glyphicon-tree-conifer"></span>打印管理
                </div>
                <span id="rqCode_icon" style="float: right;margin-top: 7%;color: #909399;font-size: 12px"
                      class="glyphicon glyphicon-menu-left"></span>
            </button>
        </li>
        <ul class="ul_ListStyle" style="display: none;" id="rqCode">
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
        /*background-color: rgb(67, 74, 80)*/
    }


    .current {
        background-color: #337ab7;
    }

    ::-webkit-scrollbar {
        /*滚动条整体样式*/
        width: 6px;
        /*高宽分别对应横竖滚动条的尺寸*/
        height: 6px;
    }

    ::-webkit-scrollbar-thumb {
        /*滚动条里面小方块*/
        border-radius: 10px;
        background-color: skyblue;
        background-image: -webkit-linear-gradient(45deg,
        rgba(255, 255, 255, 0.2) 25%,
        transparent 25%,
        transparent 50%,
        rgba(255, 255, 255, 0.2) 50%,
        rgba(255, 255, 255, 0.2) 75%,
        transparent 75%,
        transparent);
    }

    ::-webkit-scrollbar-track {
        /*滚动条里面轨道*/
        box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
        background: #ededed;
        border-radius: 10px;
    }
</style>
</html>
