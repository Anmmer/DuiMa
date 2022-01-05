<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    function ShowOrHide(str) {
        var element = document.getElementById(str)
        if (element.style.display == "block") {
            element.style.display = "none"
        } else {
            element.style.display = "block"
        }
    }

    function jumpTo(str) {
        location.href = str
    }
</script>
<div class="MenuStyle">
    <!--用户管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('User')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <img src="pictures/right.png">
            </div>
            <span>用户管理</span>
        </li>
        <ul class="ul_ListStyle" id="User">
            <li class="li_ItemStyle" onclick="jumpTo('userQueryAll.jsp')">查询用户</li>
            <li class="li_ItemStyle" onclick="jumpTo('userAdd.jsp')">新增用户</li>
            <li class="li_ItemStyle" onclick="jumpTo('index.jsp')">主页</li>
        </ul>
    </ul>
    <!--群组管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Group')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <img src="pictures/right.png">
            </div>
            群组管理
        </li>
        <ul class="ul_ListStyle" id="Group">
            <li class="li_ItemStyle" onclick="jumpTo('groupQueryAll.jsp')">查询/新增群组</li>
        </ul>
    </ul>
    <!--工厂管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Factory')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <img src="pictures/right.png">
            </div>
            库存管理
        </li>
        <ul class="ul_ListStyle" id="Factory">
            <li class="li_ItemStyle" onclick="jumpTo('factoryQueryAll.jsp')">信息查询</li>
        </ul>
    </ul>
    <!--二维码-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('Equipment')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <img src="pictures/right.png">
            </div>
            基础档案管理
        </li>
        <ul class="ul_ListStyle" id="Equipment">
            <li class="li_ItemStyle" onclick="jumpTo('qrcodeQueryAll.jsp')">二维码设置</li>
            <li class="li_ItemStyle" onclick="jumpTo('archivesMg.jsp')">档案信息管理</li>
        </ul>
    </ul>
    <!--打印管理-->
    <ul class="ul_TopListStyle">
        <li class="li_TopItemStyle" onclick="ShowOrHide('rqCode')">
            <div style="height:30px;width:50px;float:left">
                <div style="height:2px;width:100%;float:left"></div>
                <img src="pictures/right.png">
            </div>
            打印管理
        </li>
        <ul class="ul_ListStyle" id="rqCode">
            <!--<li class="li_ItemStyle" onclick="jumpTo('printQueryAll.jsp')">信息查询</li>-->
            <li class="li_ItemStyle" onclick="jumpTo('print2.jsp')">打印界面</li>
        </ul>
    </ul>
</div>
