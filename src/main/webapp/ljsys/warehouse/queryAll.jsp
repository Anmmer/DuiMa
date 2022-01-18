<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询所有群组-->
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;

    function checkAuthority(au) {
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (var i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }

    if (!checkAuthority("查看仓库组织详情")) {
        window.alert("您无查看仓库组织详情的权限!")
        window.history.go(-1)
    }
</script>
<div style="height:10%;width:100%;background-color: white;">
    <div style="width:70%;height:100%;margin:0 auto;background-color: white;">
        <div style="height:20px;width:100%"></div>
        <button onclick="returnLastPage()">返回</button>
        <div style="height:20px;width:100%"></div>
        <div>
            <span class="pStyle">仓库组织名:</span><span class="pStyle" id="factoryName"></span>
        </div>
    </div>
</div>
<div style="height:90%;width:100%;background-color:white;">
    <div style="width:100%;height:10%;">
        <form name="query" style="font-family: Simsun;font-size:16px;">
            <div style="width:100%;height: 20px;float: left;"></div>
            <div style="width:70%;margin:0 auto;">
                <div style="width:40%;float: left;">
                    <span>货位编号:</span><input type="text" name="warehouseId" id="warehouseId" class="FormInputStyle">
                </div>
                <div style="width:40%;float: left;">
                    <span>货位名:</span><input type="text" name="warehouseName" id="warehouseName" class="FormInputStyle">
                </div>
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="updateTable(1)">模糊查询</button>
            </div>
        </form>
    </div>
    <div style="width:100%;height:90%;">
        <!--表格显示-->
        <div style="width:70%;height:85%;margin:0 auto;">
            <!--结果显示提示：一共有多少记录，共几页-->
            <p id="resultTip" style="margin-top: 0px;font-family: Simsun;font-size: 16px">请在上方输入框内输入相应信息并点击“模糊查询按钮”</p>
            <form name="jumpPage" style="font-family: Simsun;font-size:16px;" onsubmit="return false;">
                <span>输入页码进行跳转:</span><input type="text" name="page" class="FormInputStyle">
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage2()">跳转</button>
            </form>
            <div style="width:100%;height:30px;"></div>
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle_title'>货位编号</td>
                    <td class='tdStyle_title'>货位名</td>
                    <td class='tdStyle_title'>操作</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
            <div style="width:100%;height:30px;"></div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(1)">第一页
                </button>
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(2)">前一页
                </button>
            </div>
            <div style="width:33%;float: left;">
                <p id="resultTip2" style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">
                    1/1</p>
            </div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:16px;float:right;"
                        onclick="jumpToNewPage(4)">最后一页
                </button>
                <button type="button" style="font-family: Simsun;font-size:16px;float:right;"
                        onclick="jumpToNewPage(3)">后一页
                </button>
            </div>
        </div>
        <div style="width:70%;height:2px;background-color: black;margin: 0 auto;"></div>
        <div style="width:70%;height:20px;margin:0 auto;"></div>
        <div style="width:70%;height:10%;margin:0 auto;">
            <form name="newFactory" id="newFactory">
                <span class="pStyle">新增货位名:</span><input type="text" name="newWarehouseName" id="newWarehouseName">
                <span class="pStyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <button type="button" style="font-size: 16px;font-family: Simsun;" onclick="addWarehouse()">提交新增
                </button>
            </form>
        </div>
    </div>
    <!-- 查询所有群组 -->
    <script type="text/javascript">
        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (pair[0] == variable) return pair[1];
            }
            return (false);
        }

        $("#factoryName").html(decodeURIComponent(getQueryVariable("factoryName")))
        factoryId = getQueryVariable("factoryId")

        function updateTable(newpage) {
            let fieldNamestmp = {
                warehouse_id: "INT",
                warehouse_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var warehouseId = $("#warehouseId").val()
            var warehouseName = $("#warehouseName").val()
            var sqlStrtmp = "select warehouse_id,warehouse_name from warehouse where factory_id=" + factoryId + " and warehouse_id like '%" + warehouseId + "%' and warehouse_name like '%" + warehouseName + "%' and warehouse_status = 1;";
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames: fieldNamesStr,
                pageCur: newpage,
                pageMax: 15
            };
            $.ajax({
                url: "${pageContext.request.contextPath}/QuerySQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for (var i = 0; i < jsonobj.length; i++) {
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['warehouse_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['warehouse_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "<a href='warehouseInfoQueryAll.jsp?warehouseId=" + jsonobj[i]['warehouse_id'] + "&warehouseName=" + encodeURIComponent(jsonobj[i]['warehouse_name']) + "'>详情</a>"
                        str += "&nbsp<a href='javascript:void(0);' onclick='removeWarehouse(" + jsonobj[i]['warehouse_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到" + res.cnt + "条记录,结果共有" + res.pageAll + "页!"
                    $("#resultTip").html(tipStr);
                    // 重置查询为第一页
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur + "/" + pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error: function (message) {
                }
            });
        }

        updateTable(1);

        function jumpToNewPage(newpageCode) {
            let fieldNamestmp = {
                warehouse_id: "INT",
                warehouse_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var warehouseId = $("#warehouseId").text()
            var warehouseName = $("warehouseName").text()
            var sqlStrtmp = "select warehouse_id,warehouse_name from warehouse where factory_id=" + factoryId + " and warehouse_id like '%" + warehouseId + "%' and warehouse_name like '%" + warehouseName + "%' and warehouse_status =1;";
            var newpage = 1;
            if (newpageCode == 1) newpage = 1;
            if (newpageCode == 2) {
                if (pageCur == 1) {
                    window.alert("已经在第一页!");
                    return
                } else {
                    newpage = pageCur - 1;
                }
            }
            if (newpageCode == 3) {
                if (pageCur == pageAll) {
                    window.alert("已经在最后一页!");
                    return
                } else {
                    newpage = pageCur + 1;
                }
            }
            if (newpageCode == 4) newpage = pageAll;
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames: fieldNamesStr,
                pageCur: newpage,
                pageMax: 15
            };
            $.ajax({
                url: "${pageContext.request.contextPath}/QuerySQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for (var i = 0; i < jsonobj.length; i++) {
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['warehouse_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['warehouse_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "详情"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到" + res.cnt + "条记录,结果共有" + res.pageAll + "页!"
                    $("#resultTip").html(tipStr);
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur + "/" + pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error: function (message) {
                }
            });
        }

        function jumpToNewPage2() {
            let fieldNamestmp = {
                warehouse_id: "INT",
                warehouse_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var warehouseId = $("#warehouseId").text()
            var warehouseName = $("warehouseName").text()
            var sqlStrtmp = "select warehouse_id,warehouse_name from warehouse where factory_id=" + factoryId + " and warehouse_id like '%" + warehouseId + "%' and warehouse_name like '%" + warehouseName + "%' and warehouse_status = 1;";
            var newpageStr = document.forms["jumpPage"]["page"].value;
            var newpage = parseInt(newpageStr)
            if (newpage <= 0 || newpage > pageAll || isNaN(newpage)) {
                window.alert("请输入一个在范围内的正确页码数字!")
                return
            }
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames: fieldNamesStr,
                pageCur: newpage,
                pageMax: 15
            };
            $.ajax({
                url: "${pageContext.request.contextPath}/QuerySQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for (var i = 0; i < jsonobj.length; i++) {
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['warehouse_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['warehouse_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "详情"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到" + res.cnt + "条记录,结果共有" + res.pageAll + "页!"
                    $("#resultTip").html(tipStr);
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur + "/" + pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error: function (message) {
                }
            });
        }

        function addWarehouse() {
            if (!checkAuthority("新增货位")) {
                window.alert("您无新增货位的权限!")
                return;
            }
            var newWarehouseName = $("#newWarehouseName").val();
            var json = {
                factoryId: factoryId,
                warehouseName: newWarehouseName,
                id: sessionStorage.getItem("userId"),
                name: sessionStorage.getItem("userName")
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/AddWarehouse",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    updateTable(1)
                    window.alert(res.message)
                },
                error: function (message) {
                    window.alert("新建货位失败!")
                }
            });
        }

        // 删除warehouse
        function removeWarehouse(warehouseid) {
            if (!checkAuthority("删除货位")) {
                window.alert("您无删除货位的权限!")
                return;
            }
            // 先判断该warehouse中没有产品
            var fieldNames = {
                product_id: "STRING"
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/QuerySQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: {
                    sqlStr: "select product_id from product where warehouse_id=" + warehouseid + ";",
                    fieldNames: JSON.stringify(fieldNames),
                    pageCur: 1,
                    pageMax: 100
                },
                success: function (res) {
                    if (res.cnt == "0") {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/ExecuteSQL",
                            type: 'post',
                            dataType: 'json',
                            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                            data: {
                                sqlStr: "update warehouse set warehouse_status = 0 where warehouse_id =" + warehouseid + ";",
                                id: sessionStorage.getItem("userId"),
                                name: sessionStorage.getItem("userName"),
                                message: "删除了库位(编号为" + warehouseid + ")"
                            },
                            success: function (res) {
                                window.alert("删除成功!")
                                updateTable(pageCur)
                            },
                            error: function (message) {
                                window.alert("删除失败")
                            }
                        })
                    } else {
                        window.alert("删除失败!请清空该货位的货物!")
                    }
                },
                error: function (message) {
                    window.alert("删除失败!请查看您的网络状态或联系运维人员!")
                }
            })
        }

        function returnLastPage() {
            window.history.go(-1);
        }
    </script>
</div>
