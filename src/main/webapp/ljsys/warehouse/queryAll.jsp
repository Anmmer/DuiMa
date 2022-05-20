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

</script>
<div style="height:100%;width:100%;background-color: white;">
    <button onclick="returnLastPage()" style="position: relative;left: 10%;top: 5%" class="btn btn-primary btn-sm">返回
    </button>
    <div style="width: 70%;margin: 0 auto; font-size:17px;font-weight: bolder">
        <span>仓库组织名：</span><span id="factoryName"></span>
    </div>
    <form name="query" class="form-inline" style="width:70%;height:8%;margin: 2% auto 0">
        <div class="form-group">
            <label>货位编号：</label><input type="text" id="warehouseId" name="warehouseId"
                                       style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>货位名：</label><input type="text" id="warehouseName" name="warehouseName"
                                      style="height:10%;" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="updateTable(1)">
            查 询
        </button>
    </form>
    <%--    <form name="query" style="font-family: Simsun;font-size:16px;">--%>
    <%--        <div style="width:100%;height: 20px;float: left;"></div>--%>
    <%--        <div style="width:70%;margin:0 auto;">--%>
    <%--            <div style="width:40%;float: left;">--%>
    <%--                <span>货位编号:</span><input type="text" name="warehouseId" id="warehouseId" class="FormInputStyle">--%>
    <%--            </div>--%>
    <%--            <div style="width:40%;float: left;">--%>
    <%--                <span>货位名:</span><input type="text" name="warehouseName" id="warehouseName" class="FormInputStyle">--%>
    <%--            </div>--%>
    <%--            <button type="button" style="font-family: Simsun;font-size:16px;" onclick="updateTable(1)">模糊查询</button>--%>
    <%--        </div>--%>
    <%--    </form>--%>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>货位信息</small></h3>
<%--            <button type="button" style="position: absolute;right: 15%;top:15%" class="btn btn-primary btn-sm"--%>
<%--                    data-toggle="modal"--%>
<%--                    data-target="#myModal">--%>
<%--                添加货位--%>
<%--            </button>--%>
        </div>
        <div style="height: 80%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="tdStyle_title active" style="width: 35%">货位编号</td>
                    <td class="tdStyle_title active" style="width: 35%">货位名称</td>
                    <td class="tdStyle_title active" style="width: 30%;text-align: center">操作</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:40%;width:80%;height:10%;">
            <ul class="pagination" style="margin-top: 0;width: 70%">
                <li><span id="total" style="width: 22%"></span></li>
                <li>
                    <a href="#" onclick="jumpToNewPage(2)" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li id="li_1"><a id="a_1" href="#">1</a></li>
                <li id="li_2"><a id="a_2" href="#">2</a></li>
                <li id="li_3"><a id="a_3" href="#">3</a></li>
                <li id="li_4"><a id="a_4" href="#">4</a></li>
                <li id="li_0"><a id="a_0" href="#">5</a></li>
                <li>
                    <a href="#" onclick="jumpToNewPage(3)" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <li style="border: none"><span>跳转：</span></li>
                <li class="input-group">
                    <input type="text" id="jump_to" class="form-control" style="width: 10%">
                </li>
                <li><a href="#" onclick="jumpToNewPage2()">go!</a></li>
            </ul>
        </nav>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加货位</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="height: 100%;margin-top: 5%">
                            <label for="newWarehouseName" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">货位名:</label>
                            <input type="text" class="form-control" style="width:50%;" id="newWarehouseName"
                                   name="newWarehouseName">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" class="btn btn-primary" onclick="addWarehouse()()">保存</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function reset() {
            $('#newWarehouseName').val('')
        }

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
                pageMax: 10
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
                        // str += "&nbsp<a href='javascript:void(0);' onclick='removeWarehouse(" + jsonobj[i]['warehouse_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    $('#total').html(res.cnt + "条，共" + res.pageAll + "页");
                    $('#li_1').addClass('active');
                    // 重置查询为第一页
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    for (let i = 1; i < 6; i++) {
                        let k = i % 5;
                        if (i > pageAll) {
                            $('#a_' + k).text('.');
                        } else {
                            if (k === 0) {
                                $('#a_' + k).text(5);
                                $('#a_' + k).attr('onclick', 'jumpToNewPage1(5)');
                                continue;
                            } else {
                                $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');
                            }
                        }
                    }
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
                pageMax: 10
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
                        // str += "&nbsp<a href='javascript:void(0);' onclick='removeWarehouse(" + jsonobj[i]['warehouse_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    if (newpageCode === 3) {
                        setFooter(3, res.pageAll, pageCur, newpage);
                    }
                    if (newpageCode === 2) {
                        setFooter(2, res.pageAll, pageCur, newpage);
                    }
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                },
                error: function (message) {
                }
            });
        }

        function jumpToNewPage1(newPage) {
            if (newPage == pageCur) {
                return;
            }
            let fieldNamestmp = {
                warehouse_id: "INT",
                warehouse_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var warehouseId = $("#warehouseId").text()
            var warehouseName = $("#warehouseName").text()
            var sqlStrtmp = "select warehouse_id,warehouse_name from warehouse where factory_id=" + factoryId + " and warehouse_id like '%" + warehouseId + "%' and warehouse_name like '%" + warehouseName + "%' and warehouse_status = 1;";
            if (newPage <= 0 || newPage > pageAll || isNaN(newPage)) {
                window.alert("请输入一个在范围内的正确页码数字!")
                return
            }
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames: fieldNamesStr,
                pageCur: newPage,
                pageMax: 10
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
                        // str += "&nbsp<a href='javascript:void(0);' onclick='removeWarehouse(" + jsonobj[i]['warehouse_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    $('#li_' + newPage % 5).addClass('active');
                    $('#li_' + pageCur % 5).removeClass('active');
                    pageCur = newPage;
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
            var warehouseName = $("#warehouseName").text()
            var sqlStrtmp = "select warehouse_id,warehouse_name from warehouse where factory_id=" + factoryId + " and warehouse_id like '%" + warehouseId + "%' and warehouse_name like '%" + warehouseName + "%' and warehouse_status = 1;";
            var newpageStr = $('#jump_to').val();
            var newpage = parseInt(newpageStr)
            if (newpage <= 0 || newpage > pageAll || isNaN(newpage)) {
                window.alert("请输入一个在范围内的正确页码数字!")
                return
            }
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames: fieldNamesStr,
                pageCur: newpage,
                pageMax: 10
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
                        // str += "&nbsp<a href='javascript:void(0);' onclick='removeWarehouse(" + jsonobj[i]['warehouse_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    jump2(newpage, res.pageAll);
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                },
                error: function (message) {
                }
            });
        }

        function jump2(newpage, pageAll) {
            if (newpage <= 5) {
                for (let i = 1; i < 6; i++) {
                    let k = i % 5;
                    if (i > pageAll) {
                        $('#a_' + k).text('.');
                    } else {
                        if (k === 0) {
                            $('#a_' + k).text(5);
                        } else {
                            $('#a_' + k).text(k);
                            $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');
                        }
                    }
                }
                $('#li_' + pageCur % 5).removeClass('active');
                $('#li_' + newpage % 5).addClass('active');
            } else {
                let j = Math.floor(newpage / 5);
                let m = j * 5;
                for (let i = 1; i < 6; i++) {
                    let k = i % 5;
                    if (++m > pageAll) {
                        $('#a_' + k).text('.');
                    } else {
                        $('#a_' + k).text(m);
                        $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m + ')');
                    }
                }
                $('#li_' + pageCur % 5).removeClass('active');
                $('#li_' + newpage % 5).addClass('active');
            }
        }

        function setFooter(newpageCode, pageAll, pageCur, newpage) {
            if (newpageCode === 3) {
                if (pageCur % 5 === 0) {
                    let j = Math.floor(newpage / 5);
                    let m = j * 5;
                    for (let i = 1; i < 6; i++) {
                        let k = i % 5;
                        if (++m > pageAll) {
                            $('#a_' + k).text('.');
                        } else {
                            $('#a_' + k).text(m);
                            $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m + ')');
                        }
                    }

                }
                $('#li_' + newpage % 5).addClass('active');
                $('#li_' + pageCur % 5).removeClass('active');
            } else {
                if (pageCur % 5 === 1) {
                    let j = Math.floor(newpage / 5);
                    let m
                    if (j < 0) {
                        m = 5;    //5*1
                    } else {
                        m = j * 5;
                    }
                    for (let i = 5; i > 0; i--) {
                        let k = i % 5;
                        if (m > pageAll) {
                            $('#a_' + k).text('');
                            m--;
                        } else {
                            $('#a_' + k).text(m);
                            $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m-- + ')');
                        }
                    }
                }
                $('#li_' + newpage % 5).addClass('active');
                $('#li_' + pageCur % 5).removeClass('active');
            }
        }

        $('#myModal').on('hidden.bs.modal', function (e) {
            $('#newWarehouseName').val('');
        })

        function addWarehouse() {
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
                    $('#myModal').modal('hide');
                    window.alert(res.message)
                },
                error: function (message) {
                    window.alert("新建货位失败!")
                }
            });
        }

        // 删除warehouse
        function removeWarehouse(warehouseid) {
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
