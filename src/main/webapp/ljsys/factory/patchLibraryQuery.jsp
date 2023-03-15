<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询所有群组-->
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;
    let pop_pageAll = 1;
    let pop_pageCur = 1;
    let pageMax = 10;   //一页多少条数据
    let jsonObj = [];
    let pop_pageDate = []

</script>
<div style="height: 95%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:85%;height:20%;margin-left: 8%;padding-top:2%">
        <label>物料编码：</label><input type="text" name="materialcode" id="materialcode"
                                   style="width: 13%;height: 30px" class="form-control">
        <label style="margin-left: 2%">物料名称：</label><input type="text" name="materialname" id="materialname"
                                                           style="width: 13%;height: 30px" class="form-control">
        <label style="margin-left: 2%">项目名称：</label><input type="text" name="planname" id="planname"
                                                           style="width: 13%;height: 30px" class="form-control">
        <label style="margin-left: 2%">操作人：</label><input type="text" name="inspect_user" id="inspect_user"
                                                          style="width: 13%;height: 30px" class="form-control"><br><br>
        <label for="inspect_startDate">操作日期从：</label><input id="inspect_startDate" class="form-control"
                                                            type="date"
                                                            style="width: 13%;height: 30px">
        <label for="inspect_endDate" style="margin-left: 2%">至：</label><input id="inspect_endDate"
                                                                              class="form-control"
                                                                              type="date"
                                                                              style="width: 13%;height: 30px">
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:85%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>修补库信息</small></h3>
            <button type="button" style="position: absolute;right: 16%;top:18%;width: 60px"
                    class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="inspect()">
                合&nbsp;&nbsp;格
            </button>
            <button type="button" onclick="openPop()" style="position: absolute;right: 9%;top:18%;width: 60px"
                    class="btn btn-primary btn-sm">
                入&nbsp;&nbsp;库
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" cellspacing="0" cellpadding="0" width="100%" align="center">
                <tr>
                    <td class='tdStyle_title active' style="width: 5%"><input id="pre_checkbok" type="checkbox"></td>
                    <td class='tdStyle_title active' style="width: 15%">物料编码</td>
                    <td class='tdStyle_title active' style="width: 15%">物料名称</td>
                    <td class='tdStyle_title active' style="width: 15%">计划编号</td>
                    <td class='tdStyle_title active' style="width: 15%">不合格原因</td>
                    <td class='tdStyle_title active' style="width: 15%">修补库地址</td>
                    <td class='tdStyle_title active' style="width: 10%">操作日期</td>
                    <td class='tdStyle_title active' style="width: 10%">备注</td>
                    <td class='tdStyle_title active' style="width: 10%">操作人</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:35%;width:70%;height:10%;">
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
    <%--    入库弹框--%>
    <div class="modal fade" id="myModal"
         style="position: absolute;left: 2%;height: 95%;top: 3%;width: 95%;z-index: 5" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="width: 100%;height: 100%;margin: 0">
            <div class="modal-content" style="width: 100%;height: 100%">
                <div class="modal-header" style="height: 7%">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h5 class="modal-title">构建信息</h5>
                </div>
                <div class="modal-body" style="height: 90%;width: 100%">
                    <div name="query" id="pop_query" class="form-inline" style="width: 100%;height: 8%">
                        <div class="form-group" style="width: 100%;">
                            <label for="materialcode_pop">物料编码：</label>
                            <input id="materialcode_pop" class="form-control" style="width: 15%;height: 30px">
                            <label for="materialname_pop" style="margin-left: 1%">物料名称：</label>
                            <input id="materialname_pop" class="form-control" style="width: 15%;height: 30px">
                            <button id="pop_query_button" class="btn btn-primary" onclick="getDetailData(1)"
                                    style="margin-left:3%;height: 30px;padding: 0 10px">查&nbsp;&nbsp;询
                            </button>
                        </div>
                    </div>
                    <div style="height: 85%;">
                        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
                            <h3 style="margin-bottom: 0;margin-top: 0" id="inputDetail"><small>构建信息</small></h3>
                        </div>
                        <table class="table table-hover" style="text-align: center;">
                            <tr id="table_tr">
                                <td class='tdStyle_title active' style="width: 2%"><input
                                        id="detail_checkbok"
                                        type="checkbox"></td>
                                <td class='tdStyle_title active' style="width: 15%">物料编码</td>
                                <td class='tdStyle_title active' style="width: 15%">物料名称</td>
                                <td class='tdStyle_title active' style="width: 15%">规格</td>
                                <td class='tdStyle_title active' style="width: 15%">状态</td>
                            </tr>
                            <tbody id="detailTableText">
                            </tbody>
                        </table>
                    </div>
                    <div style="display: flex;width: 100%; justify-content: space-between;">
                        <div class="form-inline" style="width: 45%;">
                            <label for="path">地址：</label>
                            <input id="path" class="form-control" style="width: 35%;height: 30px">
                            <label for="remark" style="margin-left: 1%">备注：</label>
                            <input id="remark" class="form-control" style="width: 35%;height: 30px">
                        </div>
                        <button type="button" style="height:10%;width: 100px"
                                onclick="save()"
                                class="btn btn-primary btn-sm">保 存
                        </button>
                        <nav aria-label="Page navigation" style="width:45%;height:10%;" id="page">
                            <ul class="pagination" style="margin-top: 0;width: 100%">
                                <li><span id="total_d" style="width: 22%">0条，共0页</span></li>
                                <li>
                                    <a href="#" onclick="jumpToNewPage_p(2)" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <li id="li_d1"><a id="a_d1" href="#">1</a></li>
                                <li id="li_d2"><a id="a_d2" href="#">2</a></li>
                                <li id="li_d3"><a id="a_d3" href="#">3</a></li>
                                <li id="li_d4"><a id="a_d4" href="#">4</a></li>
                                <li id="li_d0"><a id="a_d0" href="#">5</a></li>
                                <li>
                                    <a href="#" onclick="jumpToNewPage_p(3)" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                                <li style="border: none"><span>跳转：</span></li>
                                <li class="input-group">
                                    <input type="text" id="jump_to_d" class="form-control" style="width: 10%">
                                </li>
                                <li><a href="#" onclick="jumpToNewPage_d2()">go!</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        window.onload = getTableData(1);

        function openPop() {
            $('#myModal').modal('show')
            getDetailData(1)
        }


        function getTableData(newPage) {
            let materialcode = $('#materialcode').val();
            let planname = $('#planname').val();
            let materialname = $('#materialname').val();
            let inspect_user = $('#inspect_user').val();
            let inspect_startDate = $('#inspect_startDate').val();
            let inspect_endDate = $('#inspect_endDate').val();
            let obj = {
                materialcode: materialcode,
                materialname: materialname,
                planname: planname,
                inspect_user: inspect_user,
                inspect_startDate: inspect_startDate,
                inspect_endDate: inspect_endDate,
                isPrint: "true",
                isPour: "true",
                inspectState: '2',
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetPreProduct",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data !== undefined) {
                        jsonObj = res.data;
                        updateTable();
                        $('#total').html(res.cnt + "条，共" + res.pageAll + "页");
                        // 重置查询为第一页
                        pageCur = newPage;
                        // 重置总页数
                        pageAll = parseInt(res.pageAll);
                        for (let i = 1; i < 6; i++) {
                            let k = i % 5;
                            if (i > pageAll) {
                                $('#a_' + k).text('.');
                            } else {
                                $('#li_' + newPage % 5).addClass('active');
                                if (k === 0) {
                                    $('#a_' + k).text(5);
                                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(5)');
                                    continue;
                                } else {
                                    $('#a_' + k).text(k);
                                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');
                                }
                            }
                        }
                    } else {
                        jsonObj = []
                        updateTable(pageCur);
                    }
                },
                error: function () {
                    jsonObj = [];
                    updateTable(pageCur);
                    alert("查询失败！")
                }
            })
        }

        function inspect() {
            let obj = [];
            $('#archTableText').find('input:checked').each(function () {
                obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
            });
            if (obj.length === 0) {
                alert("请勾选！")
                return;
            }
            let r = confirm("亲，确认质检！");
            if (r === false) {
                return;
            }

            $.post("${pageContext.request.contextPath}/Inspect", {
                pids: JSON.stringify(obj),
                inspect_user: sessionStorage.getItem("userName")
            }, function (result) {
                result = JSON.parse(result);
                alert(result.message);
                if (result.flag) {
                    getTableData(pageCur);
                }
            });
        }

        function save() {
            let obj = [];
            $('#detailTableText').find('input:checked').each(function () {
                obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
            });
            if (obj.length === 0) {
                alert("请勾选！")
                return;
            }
            let path = $("#path").val()
            let remark = $("#remark").val()
            if (!path) {
                alert("请填写地址")
                return;
            }
            // let r = confirm("亲，确认质检！");
            // if (r === false) {
            //     return;
            // }
            $.post("${pageContext.request.contextPath}/InspectNo", {
                pids: JSON.stringify(obj),
                // failure_reason: remark,
                patch_library: path,
                inspect_remark: remark,
                inspect_user: sessionStorage.getItem("userName")
            }, function (result) {
                result = JSON.parse(result);
                alert(result.message);
                if (result.flag) {
                    getTableData(pageCur);
                    $('#myModal').modal('hide')
                }
            });
        }

        let pre = 0
        let det_i = 0
        //全选
        $("#pre_checkbok").on("click", function () {
            if (pre == 0) {
                //把所有复选框选中
                $("#archTableText td :checkbox").prop("checked", true);
                pre = 1;
            } else {
                $("#archTableText td :checkbox").prop("checked", false);
                pre = 0;
            }
        });

        //全选
        $("#detail_checkbok").on("click", function () {
            if (det_i == 0) {
                //把所有复选框选中
                $("#detailTableText td :checkbox").prop("checked", true);
                det_i = 1;
            } else {
                $("#detailTableText td :checkbox").prop("checked", false);
                det_i = 0;
            }

        });

        function updateTable(flag) {
            document.getElementById('pre_checkbok').checked = false
            document.getElementById('detail_checkbok').checked = false
            pre = 0
            det_i = 0
            let str = '';
            if (flag) {
                for (let i = 0; i < pop_pageDate.length; i++) {
                    switch (pop_pageDate[i]['stock_status']) {
                        case '0' :
                            pop_pageDate[i]['stock_status'] = '待入库';
                            break;
                        case '1':
                            pop_pageDate[i]['stock_status'] = '已入库';
                            break;
                        case '2':
                            pop_pageDate[i]['stock_status'] = '已出库';
                            break;
                        default:
                            pop_pageDate[i]['stock_status'] = '待入库';
                    }
                    str += "<tr><td class='tdStyle_body' style='padding: 5px;'><input type='checkbox' data-id=" + pop_pageDate[i]["materialcode"] + ">" +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['materialcode'] + "'>" + pop_pageDate[i]['materialcode'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['materialname'] + "'>" + pop_pageDate[i]['materialname'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['standard'] + "'>" + pop_pageDate[i]['standard'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['stock_status'] + "'>" + pop_pageDate[i]['stock_status'] +
                        "</td></tr>";
                }
                $("#detailTableText").html(str);
            } else {
                for (let i = 0; i < jsonObj.length; i++) {
                    if (jsonObj[i]['inspect'] === 0) {
                        jsonObj[i]['inspect'] = '未质检'
                    } else {
                        jsonObj[i]['inspect'] = '质检不合格'
                    }
                    jsonObj[i]['checktime'] = jsonObj[i]['checktime'] === undefined ? '--' : jsonObj[i]['checktime'];
                    jsonObj[i]['inspect_user'] = jsonObj[i]['inspect_user'] === undefined ? '--' : jsonObj[i]['inspect_user'];
                    jsonObj[i]['inspect_remark'] = jsonObj[i]['inspect_remark'] === undefined ? '' : jsonObj[i]['inspect_remark'];
                    jsonObj[i]['failure_reason'] = jsonObj[i]['failure_reason'] === undefined ? '' : jsonObj[i]['failure_reason'];
                    str += "<tr><td class='tdStyle_body'><input type='checkbox' data-id=" + jsonObj[i]['materialcode'] + ">" +
                        "<td class='tdStyle_body' title='" + jsonObj[i]['materialcode'] + "'>" + jsonObj[i]['materialcode'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['materialname'] + "'>" + jsonObj[i]['materialname'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['plannumber'] + "'>" + jsonObj[i]['plannumber'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['failure_reason'] + "'>" + jsonObj[i]['failure_reason'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['patch_library'] + "'>" + jsonObj[i]['patch_library'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['checktime'] + "'>" + jsonObj[i]['checktime'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['inspect_remark'] + "'>" + jsonObj[i]['inspect_remark'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['inspect_user'] + "'>" + jsonObj[i]['inspect_user'] +
                        "</td></tr>";
                }
                $("#archTableText").html(str);
            }
        }

        function jumpToNewPage(newPageCode) {
            let newPage = 1;
            if (newPageCode === 1) newPage = 1;
            if (newPageCode === 2) {
                if (pageCur === 1) {
                    window.alert("已经在第一页!");
                    return
                } else {
                    newPage = pageCur - 1;
                }
            }
            if (newPageCode === 3) {
                if (pageCur === pageAll) {
                    window.alert("已经在最后一页!");
                    return
                } else {
                    newPage = pageCur + 1;
                }
            }
            let materialcode = $('#materialcode').val();
            let planname = $('#planname').val();
            let materialname = $('#materialname').val();
            let inspect_user = $('#inspect_user').val();
            let inspect_startDate = $('#inspect_startDate').val();
            let inspect_endDate = $('#inspect_endDate').val();
            let obj = {
                materialcode: materialcode,
                materialname: materialname,
                plannamne: planname,
                inspect_user: inspect_user,
                inspect_startDate: inspect_startDate,
                inspect_endDate: inspect_endDate,
                isPrint: "true",
                isPour: "true",
                inspectState: '2',
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetPreProduct",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data.length !== 0) {
                        jsonObj = res.data;
                        updateTable();
                        if (newPageCode === 3) {
                            setFooter(3, res.pageAll, pageCur, newPage);
                        }
                        if (newPageCode === 2) {
                            setFooter(2, res.pageAll, pageCur, newPage);
                        }
                        // 重置查询为第一页
                        pageCur = newPage;
                        // 重置总页数
                        pageAll = parseInt(res.pageAll);
                    } else {
                        jsonObj = []
                        updateTable();
                    }
                },
                error: function () {
                    jsonObj = [];
                    updateTable();
                    alert("查询失败！")
                }
            })
        }

        function jumpToNewPage1(newPage) {
            let materialcode = $('#materialcode').val();
            let planname = $('#planname').val();
            let materialname = $('#materialname').val();
            let inspect_user = $('#inspect_user').val();
            let inspect_startDate = $('#inspect_startDate').val();
            let inspect_endDate = $('#inspect_endDate').val();
            let obj = {
                materialcode: materialcode,
                materialname: materialname,
                plannamne: planname,
                inspect_user: inspect_user,
                inspect_startDate: inspect_startDate,
                inspect_endDate: inspect_endDate,
                isPrint: "true",
                isPour: "true",
                inspectState: '2',
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetPreProduct",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data.length !== 0) {
                        jsonObj = res.data;
                        updateTable();
                        $('#li_' + newPage % 5).addClass('active');
                        $('#li_' + pageCur % 5).removeClass('active');
                        pageCur = newPage;
                    } else {
                        jsonObj = []
                        updateTable();
                    }
                },
                error: function () {
                    jsonObj = [];
                    updateTable();
                    alert("查询失败！")
                }
            })
        }

        function jumpToNewPage2() {
            let newPage = parseInt($('#jump_to').val());
            let materialcode = $('#materialcode').val();
            let planname = $('#planname').val();
            let materialname = $('#materialname').val();
            let inspect_user = $('#inspect_user').val();
            let inspect_startDate = $('#inspect_startDate').val();
            let inspect_endDate = $('#inspect_endDate').val();
            if (newPage == "" || isNaN(newPage))
                return;
            if (newPage > pageAll) {
                alert("超过最大页数")
                return
            }
            let obj = {
                materialcode: materialcode,
                materialname: materialname,
                plannamne: planname,
                inspect_user: inspect_user,
                inspect_startDate: inspect_startDate,
                inspect_endDate: inspect_endDate,
                isPrint: "true",
                isPour: "true",
                inspectState: '2',
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetPreProduct",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data.length !== 0) {
                        jsonObj = res.data;
                        updateTable();
                        jump2(newPage, res.pageAll);
                        // 重置查询为第一页
                        pageCur = newPage;
                        // 重置总页数
                        pageAll = parseInt(res.pageAll);
                    } else {
                        jsonObj = []
                        updateTable();
                    }
                },
                error: function () {
                    jsonObj = [];
                    updateTable();
                    alert("查询失败！")
                }
            })
        }

        function jump2(newPage, pageAll) {
            if (newPage <= 5) {
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
                $('#li_' + newPage % 5).addClass('active');
            } else {
                let j = Math.floor(newPage / 5);
                let m = j * 5;
                if (newPage % 5 == 0) {
                    for (let i = 1; i < 6; i++) {
                        let k = i % 5;
                        let n = m - 5 + i;
                        if (n > pageAll) {
                            $('#a_' + k).text('.');
                        } else {
                            $('#a_' + k).text(n);
                            $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + n + ')');
                        }
                    }
                } else {
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
                $('#li_' + pageCur % 5).removeClass('active');
                $('#li_' + newPage % 5).addClass('active');
            }
        }

        function setFooter(newPageCode, pageAll, pageCur, newPage) {
            if (newPageCode === 3) {
                if (pageCur % 5 === 0) {
                    let j = Math.floor(newPage / 5);
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
                $('#li_' + newPage % 5).addClass('active');
                $('#li_' + pageCur % 5).removeClass('active');
            } else {
                if (pageCur % 5 === 1) {
                    let j = Math.floor(newPage / 5);
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
                $('#li_' + newPage % 5).addClass('active');
                $('#li_' + pageCur % 5).removeClass('active');
            }
        }

        //获取明细数据
        function getDetailData(newPage) {
            let materialcode = $('#materialcode_pop').val();
            let materialname = $('#materialname_pop').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialcode: materialcode,
                materialname: materialname,
                stockStatus: '2',
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
                    updateTable(true);
                    $('#total_d').html(result.cnt + "条，共" + result.pageAll + "页");
                    $('#li_d1').addClass('active');
                    // 重置查询为第一页
                    pop_pageCur = 1;
                    // 重置总页数
                    pop_pageAll = parseInt(result.pageAll);
                    for (let i = 1; i < 6; i++) {
                        let k = i % 5;
                        if (i > pop_pageAll) {
                            $('#a_d' + k).text('.');
                        } else {
                            if (k === 0) {
                                $('#a_d' + k).text(5);
                                $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(5)');
                                continue;
                            } else {
                                $('#a_d' + k).text(i);
                                $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(' + k + ')');
                            }
                        }
                    }
                }
            })
        }

        function jumpToNewPage_p(newPageCode) {
            pop_pageDate = []
            let newPage = 1;
            if (newPageCode === 1) newPage = 1;
            if (newPageCode === 2) {
                if (pop_pageCur == 1) {
                    window.alert("已经在第一页!");
                    return
                } else {
                    newPage = pop_pageCur - 1;
                }
            }
            if (newPageCode === 3) {
                if (pop_pageCur == pop_pageAll) {
                    // window.alert("已经在最后一页!");
                    // return
                } else {
                    newPage = pop_pageCur + 1;
                }
            }
            let materialcode = $('#materialcode_pop').val();
            let materialname = $('#materialname_pop').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialcode: materialcode,
                materialname: materialname,
                stock_status: '2',
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
                    updateTable(true);
                    if (newPageCode === 3) {
                        setFooter_d(3, pop_pageAll, pop_pageCur, newPage);
                    }
                    if (newPageCode === 2) {
                        setFooter_d(2, pop_pageAll, pop_pageCur, newPage);
                    }
                    pop_pageCur = newPage;
                }
            });
        }

        function jumpToNewPage_d1(newPage) {
            pop_pageDate = []
            let materialcode = $('#materialcode_pop').val();
            let materialname = $('#materialname').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialcode: materialcode,
                materialname: materialname,
                stock_status: '2',
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
                    updateTable(true);
                    $('#li_d' + newPage % 5).addClass('active');
                    $('#li_d' + pop_pageCur % 5).removeClass('active');
                    pop_pageCur = newPage;
                }
            });
        }

        function jumpToNewPage_d2() {
            pop_pageDate = []
            var newPage = parseInt(('#jump_to_d').val());
            if (newPage == "" || isNaN(newPage))
                return;
            if (newPage > pop_pageAll) {
                alert("超过最大页数")
                return
            }
            let materialcode = $('#materialcode_pop').val();
            let materialname = $('#materialname').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialcode: materialcode,
                materialname: materialname,
                stock_status: '2',
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
                    updateTable(true);
                    pop_pageCur = newPage;
                    jump_d2(newPage, pop_pageAll);
                }
            });
        }

        function jump_d2(newPage, pageAll) {
            if (newPage <= 5) {
                for (let i = 1; i < 6; i++) {
                    let k = i % 5;
                    if (i > pageAll) {
                        $('#a_' + k).text('.');
                    } else {
                        if (k === 0) {
                            $('#a_' + k).text(5);
                        } else {
                            $('#a_' + k).text(k);
                            $('#a_' + k).attr('onclick', 'jumpToNewPage_d1(' + k + ')');
                        }
                    }
                }
                $('#li_' + pop_pageCur % 5).removeClass('active');
                $('#li_' + newPage % 5).addClass('active');
            } else {
                let j = Math.floor(newPage / 5);
                let m = j * 5;
                for (let i = 1; i < 6; i++) {
                    let k = i % 5;
                    if (++m > pageAll) {
                        $('#a_' + k).text('.');
                    } else {
                        $('#a_' + k).text(m);
                        $('#a_' + k).attr('onclick', 'jumpToNewPage_d1(' + m + ')');
                    }
                }
                $('#li_' + pop_pageCur % 5).removeClass('active');
                $('#li_' + newPage % 5).addClass('active');
            }
        }

        function setFooter_d(newPageCode, pageAll, pageCur, newPage) {
            if (newPageCode === 3) {
                if (pageCur % 5 === 0) {
                    let j = Math.floor(newPage / 5);
                    let m = j * 5;
                    for (let i = 1; i < 6; i++) {
                        let k = i % 5;
                        if (++m > pageAll) {
                            $('#a_d' + k).text('.');
                        } else {
                            $('#a_d' + k).text(m);
                            $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(' + m + ')');
                        }
                    }

                }
                $('#li_d' + newPage % 5).addClass('active');
                $('#li_d' + pageCur % 5).removeClass('active');
            } else {
                if (pageCur % 5 === 1) {
                    let j = Math.floor(newPage / 5);
                    let m
                    if (j < 0) {
                        m = 5;    //5*1
                    } else {
                        m = j * 5;
                    }
                    for (let i = 5; i > 0; i--) {
                        let k = i % 5;
                        if (m > pageAll) {
                            $('#a_d' + k).text('');
                            m--;
                        } else {
                            $('#a_d' + k).text(m);
                            $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(' + m-- + ')');
                        }
                    }
                }
                $('#li_d' + newPage % 5).addClass('active');
                $('#li_d' + pageCur % 5).removeClass('active');
            }
        }
    </script>
</div>
<style>
    table {
        table-layout: fixed; /* 只有定义了表格的布局算法为fixed，下⾯td的定义才能起作⽤。 */
    }

    td {
        width: 100%;
        word-break: keep-all; /* 不换⾏ */
        white-space: nowrap; /* 不换⾏ */
        overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
        text-overflow: ellipsis; /* 当对象内⽂本溢出时显⽰省略标记(...) ；需与overflow:hidden;⼀起使⽤。*/
    }
</style>
