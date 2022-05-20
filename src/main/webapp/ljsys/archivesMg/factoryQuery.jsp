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
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:70%;height:15%;margin-left: 14%;padding-top:2%">
        <div class="form-group">
            <label>仓库编号：</label><input type="text" name="factoryId"
                                        class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>仓库名：</label><input type="text" name="factoryName"
                                       class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="updateTable(1)">
            查 询
        </button>
    </form>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>仓库信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:15%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    data-target="#myModal">
                添加仓库
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" cellspacing="0" cellpadding="0" width="100%" align="center">
                <tr>
                    <td class='tdStyle_title  active' style="width: 20%">仓库编号</td>
                    <td class='tdStyle_title active' style="width: 30%">仓库名称</td>
                    <td class='tdStyle_title active' style="width: 30%">仓库地址</td>
                    <td class='tdStyle_title active' style="width: 20%">操作</td>
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
    <div class="modal fade" id="myModal" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加仓库</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="margin-top: 5%">
                            <label for="newFactoryName" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">仓库名:</label>
                            <input type="text" class="form-control" style="width:50%;" id="newFactoryName"
                                   name="newFactoryName"><br>
                            <label for="newFactoryAddress" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">仓库地址:</label>
                            <input type="text" class="form-control" style="width:50%;" id="newFactoryAddress"
                                   name="newFactoryAddress">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" class="btn btn-primary" onclick="addFactory()()">保存</button>
                </div>
            </div>
        </div>
    </div>
    <%--        <div style="width:70%;height:2px;background-color: black;margin: 0 auto;"></div>--%>
    <%--        <div style="width:70%;height:16px;margin:0 auto;"></div>--%>
    <%--        <div style="width:70%;height:17%;margin:0 auto;">--%>
    <%--            <form name="newFactory" id="newFactory">--%>
    <%--                <span class="pStyle">新增仓库组织名:</span><input type="text" name="newFactoryName" id="newFactoryName">--%>
    <%--                <span class="pStyle">新增仓库组织地址:</span><input type="text" name="newFactoryAddress" id="newFactoryAddress">--%>
    <%--                <span class="pStyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>--%>
    <%--                <button type="button" style="font-size: 16px;font-family: Simsun;" onclick="addFactory()">提交新增</button>--%>
    <%--            </form>--%>
    <%--        </div>--%>
    <!-- 查询所有群组 -->
    <script type="text/javascript">
        function updateTable(newpage) {
            let fieldNamestmp = {
                factory_id: "INT",
                factory_name: "STRING",
                factory_address: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var factoryId = document.forms["query"]["factoryId"].value;
            var factoryName = document.forms["query"]["factoryName"].value;
            var sqlStrtmp = "select factory_id,factory_name,factory_address from factory where factory_status = 1 and factory_id like '%" + factoryId + "%' and factory_name like '%" + factoryName + "%';";
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
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['factory_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['factory_name'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['factory_address'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询

                        str += "<a href='archivesWarehouseQuery.jsp?factoryId=" + jsonobj[i]['factory_id'] + "&factoryName=" + jsonobj[i]['factory_name'] + "'>详情</a>&nbsp"
                        str += "<a href='javascript:void(0);' onclick='removeFactory(" + jsonobj[i]['factory_id'] + ")'>删除</a>"
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
                gp_id: "INT",
                gp_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var factoryId = document.forms["query"]["factoryId"].value;
            var factoryName = document.forms["query"]["factoryName"].value;
            var sqlStrtmp = "select factory_id,factory_name,factory_address from factory where facotry_status = 1 and factory_id like '%" + factoryId + "%' and factory_name like '%" + factoryName + "%';";
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
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['factory_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['factory_name'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['factory_address'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "<a href='warehouseQuery.jsp?factoryId=" + jsonobj[i]['factory_id'] + "&factoryName=" + jsonobj[i]['factory_name'] + "'>详情</a>&nbsp"
                        str += "<a href='javascript:void(0);' onclick='removeFactory(" + jsonobj[i]['factory_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    if (newpageCode === 3) {
                        setFooter(3, res.pageAll, pageCur, newpage);
                    }
                    if (newpageCode === 2) {
                        setFooter(2, res.pageAll, pageCur, newpage);
                    }
                    // 重置查询为第一页
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                },
                error: function (message) {
                }
            });
        }

        function jumpToNewPage2() {
            let fieldNamestmp = {
                gp_id: "INT",
                gp_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var factoryId = document.forms["query"]["factoryId"].value;
            var factoryName = document.forms["query"]["factoryName"].value;
            var sqlStrtmp = "select factory_id,factory_name,factory_address from factory where facotry_status = 1 and factory_id like '%" + factoryId + "%' and factory_name like '%" + factoryName + "%';";
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
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['factory_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['factory_name'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['factory_address'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "<a href='warehouseQuery.jsp?factoryId=" + jsonobj[i]['factory_id'] + "&factoryName=" + jsonobj[i]['factory_name'] + "'>详情</a>&nbsp"
                        str += "<a href='javascript:void(0);' onclick='removeFactory(" + jsonobj[i]['factory_id'] + ")'>删除</a>"
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
            $('#newFactoryName').val('');
            $('#newFactoryAddress').val('');
        })

        function reset() {
            $('#newFactoryName').val('');
            $('#newFactoryAddress').val('');
        }

        function addFactory() {
            var factoryName = $("#newFactoryName").val();
            var factoryAddress = $("#newFactoryAddress").val();
            var json = {
                factoryName: factoryName,
                factoryAddress: factoryAddress,
                id: sessionStorage.getItem("userId"),
                name: sessionStorage.getItem("userName")
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/AddFactory",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    $('#myModal').modal('hide');
                    updateTable(pageCur);
                    window.alert(res.message);
                },
                error: function (message) {
                }
            });
        }

        function removeFactory(factoryid) {
            // 库房清零后方可删除
            // 查询该工厂是否有库房
            let r = confirm("亲，确认删除！");
            if (r === false) {
                return;
            }
            var fieldNames = {
                warehouse_id: "INT"
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/QuerySQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: {
                    sqlStr: "select warehouse_id from warehouse where factory_id = " + factoryid + ";",
                    fieldNames: JSON.stringify(fieldNames),
                    pageCur: 1,
                    pageMax: 100
                },
                success: function (res) {
                    if (res.cnt == 0) {
                        // 可以删除工厂
                        $.ajax({
                            url: "${pageContext.request.contextPath}/ExecuteSQL",
                            type: 'post',
                            dataType: 'json',
                            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                            data: {
                                sqlStr: "update factory set factory_status = 0 where factory_id =" + factoryid + ";",
                                id: sessionStorage.getItem("userId"),
                                name: sessionStorage.getItem("userName"),
                                message: "删除了库存组织(其编号为" + factoryid + ")"
                            },
                            success: function (res) {
                                window.alert("删除成功!")
                                updateTable(pageCur)
                            },
                            error: function (message) {
                                window.alert("删除失败!")
                            }
                        });
                    } else {
                        window.alert("未成功!请删除该仓库组织下所有仓库!");
                    }
                },
                error: function (message) {
                    window.alert("删除失败!请查看您的网络状态或联系运维人员!")
                }
            })

        }
    </script>
</div>
