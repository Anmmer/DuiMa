<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <form name="query" class="form-inline" style="width:80%;height:15%;margin-left: 14%;padding-top:2%">
        <div class="form-group" style="width: 100%;">
            <label for="planname" style="margin-left: 2%">项目名称：</label>
            <input id="planname" class="form-control" style="width: 13%;height:10%;">
            <label for="materialcode" style="margin-left: 2%">物料编号：</label>
            <input id="materialcode" class="form-control" style="width: 13%;height:10%;">
            <label for="productState" style="margin-left: 2%">生产状态：</label>
            <select id="productState" class="form-control" style="width: 13%;">
                <option value=""></option>
                <option value="0">待生产</option>
                <option value="1">已生产</option>
            </select>
            <button type="button" class="btn btn-primary btn-sm" style="margin-left: 1%"
                    onclick="getTableData(1)">
                查 询
            </button>
        </div>
    </form>
    <div style="width:80%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>生产计划信息</small></h3>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class='tdStyle_title active' style="width: 10%">计划编号</td>
                    <td class='tdStyle_title active' style="width: 10%">项目名称</td>
                    <td class='tdStyle_title active' style="width: 10%">生产状态</td>
                    <td class='tdStyle_title active' style="width: 8%">计划生产日期</td>
                    <td class='tdStyle_title active' style="width: 8%">楼栋楼层</td>
                    <td class='tdStyle_title active' style="width: 10%">构建数(个)</td>
                    <td class='tdStyle_title active' style="width: 8%">合计方量</td>
                    <td class='tdStyle_title active' style="width: 8%">操作</td>
                </tr>
                <tbody id="planTableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:20%;width:80%;height:10%;">
            <ul class="pagination" style="margin-top: 0;width: 70%">
                <li><span id="total" style="width: 30%"></span></li>
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
        <!-- Modal -->
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
                                <label for="productState_pop" style="margin-left: 1%">生产状态：</label>
                                <select id="productState_pop" class="form-control" style="width: 15%;height: 30px">
                                </select>
                                <button id="pop_query_button" class="btn btn-primary" onclick="getData(1)"
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
                                    <td class='tdStyle_title active' style="width: 15%">物料编号</td>
                                    <td class='tdStyle_title active' style="width: 15%">物料名称</td>
                                    <td class='tdStyle_title active' style="width: 10%">构建编号</td>
                                    <td class='tdStyle_title active' style="width: 10%">隐蔽检验</td>
                                    <td class='tdStyle_title active' style="width: 8%">检验日期</td>
                                    <td class='tdStyle_title active' style="width: 8%">浇捣状态</td>
                                    <td class='tdStyle_title active' style="width: 8%">浇捣日期</td>
                                    <td class='tdStyle_title active' style="width: 8%">质检状态</td>
                                    <td class='tdStyle_title active' style="width: 8%">质检日期</td>
                                    <td class='tdStyle_title active' style="width: 10%">生产状态</td>
                                </tr>
                                <tbody id="detailTableText">
                                </tbody>
                            </table>
                        </div>
                        <nav aria-label="Page navigation" style="margin-left:50%;width:80%;height:10%;" id="page">
                            <ul class="pagination" style="margin-top: 0;width: 70%">
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
</div>
<script>
    let pageCur = 1;    //分页当前页
    let pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let plannumber = '';
    let pop_pageDate = [];

    let pop_pageCur = 1;    //弹框分页当前页
    let pop_pageAll = 1;  //弹框分页总页数
    let on_or_off = '';

    let jsonObj = [];

    window.onload = getDataSet();

    function getDataSet() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetDefaultSet",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data !== undefined) {
                    res.data.forEach((item) => {
                        if (item.name == 'concealed_process') {
                            on_or_off = item.on_or_off;
                        }
                    })
                }
            }
        }).then(() => {
            getTableData(1)
        })
    }

    $('#myModal').on('hidden.bs.modal', function (e) {
        $('#li_d' + pop_pageCur % 5).removeClass('active');
        pop_pageAll = 1;
        pop_pageCur = 1;
    })

    //查询plan表数据
    function getTableData(newPage) {
        let productState = $('#productState').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        let obj = {
            productState: productState,
            planname: planname,
            materialcode: materialcode,
            on_or_off: on_or_off,
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlan",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data !== undefined) {
                    jsonObj = res.data;
                    updateTable(false);
                    pageAll = res.pageAll;
                    setBegin(res.cnt, res.pageAll, '', newPage);
                } else {
                    jsonObj = []
                    updateTable(false);
                }
            },
            error: function () {
                jsonObj = [];
                updateTable(false);
                alert("查询失败！")
            }
        })
    }

    //更新表格
    function updateTable(detail) {
        let str = "";
        if (detail) {
            for (let i = 0; i < pop_pageDate.length; i++) {
                let style = ''
                let state = ''
                if (pop_pageDate[i]['pourmade'] === 0 && pop_pageDate[i]['inspect'] === 0) {
                    state = '待浇捣'
                    style = "style='background-color: grey;'"
                }
                if (pop_pageDate[i]['pourmade'] === 1 && pop_pageDate[i]['inspect'] === 0) {
                    state = '待质检'
                    style = "style='background-color: #f78f00;'"
                }
                if (pop_pageDate[i]['pourmade'] === 1 && pop_pageDate[i]['inspect'] === 1) {
                    state = '质检合格'
                    style = "style='background-color: green;'"
                }
                if (pop_pageDate[i]['pourmade'] === 1 && pop_pageDate[i]['inspect'] === 2) {
                    state = '质检不合格'
                    style = "style='background-color: red;'"
                }
                if (on_or_off == '1') {
                    if (pop_pageDate[i]['covert_test'] === 1 && pop_pageDate[i]['inspect'] === 0 && pop_pageDate[i]['pourmade'] === 0) {
                        state = '待浇捣'
                        style = "style='background-color: yellow;'"
                    }
                    if (pop_pageDate[i]['covert_test'] === 0) {
                        state = '待检验'
                        style = "style='background-color: grey;'"
                    }
                    if (pop_pageDate[i]['covert_test'] === 2) {
                        state = '检验不合格'
                        style = "style='background-color: #a94442;'"
                    }
                }
                pop_pageDate[i]['pourmade'] = pop_pageDate[i]['pourmade'] === 0 ? '未浇捣' : '已浇捣'
                if (pop_pageDate[i]['inspect'] === 0) {
                    pop_pageDate[i]['inspect'] = '未质检'
                } else if (pop_pageDate[i]['inspect'] === 1) {
                    pop_pageDate[i]['inspect'] = '质检合格'
                } else {
                    pop_pageDate[i]['inspect'] = '质检不合格'
                }
                pop_pageDate[i]['pourtime'] = pop_pageDate[i]['pourtime'] === undefined ? '--' : pop_pageDate[i]['pourtime'];
                pop_pageDate[i]['checktime'] = pop_pageDate[i]['checktime'] === undefined ? '--' : pop_pageDate[i]['checktime'];
                pop_pageDate[i]['covert_test_time'] = pop_pageDate[i]['covert_test_time'] === undefined ? '--' : pop_pageDate[i]['covert_test_time'];
                if (on_or_off == '1') {
                    if (pop_pageDate[i]['covert_test'] === 0) {
                        pop_pageDate[i]['covert_test'] = '未检验'
                    } else if (pop_pageDate[i]['covert_test'] === 1) {
                        pop_pageDate[i]['covert_test'] = '检验合格'
                    } else {
                        pop_pageDate[i]['covert_test'] = '检验不合格'
                    }
                } else {
                    pop_pageDate[i]['covert_test'] = '--';
                    pop_pageDate[i]['covert_test_time'] = '--';
                }
                str += "<tr><td class='tdStyle_body' >" + pop_pageDate[i]['materialcode'] +
                    "</td><td class='tdStyle_body'>" + pop_pageDate[i]['materialname'] +
                    "</td><td class='tdStyle_body'>" + pop_pageDate[i]['preproductid'] +
                    "</td><td class='tdStyle_body'>" + pop_pageDate[i]['covert_test'] +
                    "</td><td class='tdStyle_body'>" + pop_pageDate[i]['covert_test_time'] +
                    "</td><td class='tdStyle_body'>" + pop_pageDate[i]['pourmade'] +
                    "</td><td class='tdStyle_body'>" + pop_pageDate[i]['pourtime'] +
                    "</td><td class='tdStyle_body'>" + pop_pageDate[i]['inspect'] +
                    "</td><td class='tdStyle_body'>" + pop_pageDate[i]['checktime'] +
                    "</td><td class='tdStyle_body'" + style + ">" + state +
                    "</td></tr>";
            }
            $("#detailTableText").html(str);
        } else {
            for (let i = 0; i < jsonObj.length; i++) {
                let style = ''
                let state = ''
                if (jsonObj[i]['pourmadestate'] === 1 && jsonObj[i]['checkstate'] === 1) {
                    state = '已完成'
                    style = "style='background-color: green;'"
                } else {
                    state = '未完成'
                    style = "style='background-color: red;'"
                }
                str += "<tr><td class='tdStyle_body' title='" + jsonObj[i]['plannumber'] + "'>" + jsonObj[i]['plannumber'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plannumber'] + "'>" + jsonObj[i]['planname'] +
                    "</td><td class='tdStyle_body' title='" + state + "'" + style + ">" + state +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plantime'] + "'>" + jsonObj[i]['plantime'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['build'] + "'>" + jsonObj[i]['build'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['tasknum'] + "'>" + jsonObj[i]['tasknum'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['tasksqure'] + "'>" + jsonObj[i]['tasksqure'] +
                    "</td><td class='tdStyle_body'><a href='#' onclick='getDetailData(" + jsonObj[i]['plannumber'] + ',1' + ")'>详情</a></td></tr>";
            }
            $("#planTableText").html(str);
        }
    }

    function getData(newPage) {
        let materialcode_pop = $('#materialcode_pop').val();
        let productState_pop = $('#productState_pop').val();
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
            materialcode: materialcode_pop,
            productState: productState_pop,
            plannumber: plannumber,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }, function (result) {
            result = JSON.parse(result);
            if (result.data !== undefined) {
                pop_pageDate = result.data;
                updateTable(true);
                $('#total_d').html(result.cnt + "条，共" + result.pageAll + "页");
                $('#li_d1').addClass('active');
                $('#li_d' + pop_pageCur % 5).removeClass('active');
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

    //获取明细数据
    function getDetailData(plannumber_p, newPage) {
        plannumber = plannumber_p;
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
            plannumber: plannumber_p,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }, function (result) {
            result = JSON.parse(result);
            if (result.data !== undefined) {
                pop_pageDate = result.data;
                $('#myModal').modal('show')
                $('#productState_pop').empty()
                if (on_or_off == 1) {
                    $('#productState_pop').append($("<option value=\"0\"></option>\n" +
                        "                                    <option value=\"1\">待生产</option>\n" +
                        "                                    <option value=\"2\">待检验</option>\n" +
                        "                                    <option value=\"3\">浇捣完成</option>\n" +
                        "                                    <option value=\"4\">质检完成</option>"))
                } else {
                    $('#productState_pop').append($("<option value=\"0\"></option>\n" +
                        "                                    <option value=\"1\">待生产</option>\n" +
                        "                                    <option value=\"2\">浇捣完成</option>\n" +
                        "                                    <option value=\"3\">质检完成</option>"))
                }
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

    function setBegin(cnt, pageAll, index, newPage) {
        $('#total' + index).html(cnt + "条，共" + pageAll + "页");
        $('#li_' + index + '1').addClass('active');
        // 重置查询为第一页
        pageCur = newPage;
        // 重置总页数
        pageAll = parseInt(pageAll);
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
                    $('#a_' + k).text(k);
                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');
                }
            }
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
        let productState = $('#productState').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        let obj = {
            productState: productState,
            planname: planname,
            materialcode: materialcode,
            'pageCur': newPage,
            'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlan",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = res.data;
                    updateTable(false);
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
        let productState = $('#productState').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        let obj = {
            productState: productState,
            planname: planname,
            materialcode: materialcode,
            'pageCur': newPage,
            'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlan",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = res.data;
                    updateTable(false);
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
        let productState = $('#productState').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        let newPage = $('#jump_to').val();
        if (newPage > pageAll) {
            alert("超过最大页数")
            return
        }
        let obj = {
            productState: productState,
            planname: planname,
            materialcode: materialcode,
            'pageCur': newPage,
            'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlan",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = res.data;
                    updateTable(false);
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

    function jumpToNewPage_p(newPageCode) {
        pop_pageDate = []
        let newPage = 1;
        if (newPageCode === 1) newPage = 1;
        if (newPageCode === 2) {
            if (pop_pageCur === 1) {
                window.alert("已经在第一页!");
                return
            } else {
                newPage = pop_pageCur - 1;
            }
        }
        if (newPageCode === 3) {
            if (pop_pageCur === pop_pageAll) {
                // window.alert("已经在最后一页!");
                // return
            } else {
                newPage = pop_pageCur + 1;
            }
        }
        let materialcode = $('#materialcode_pop').val();
        let productState = $('#productState_pop').val();
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
            plannumber: plannumber,
            materialcode: materialcode,
            productState: productState,
            isPrint: "true",
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
        let productState = $('#productState_pop').val();
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
            plannumber: plannumber,
            materialcode: materialcode,
            productState: productState,
            isPrint: "true",
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
        var newPage = $('#jump_to_d').val();
        if (newPage > pop_pageAll) {
            alert("超过最大页数")
            return
        }
        let materialcode = $('#materialcode_pop').val();
        let productState = $('#productState_pop').val();
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
            plannumber: plannumber,
            materialcode: materialcode,
            productState: productState,
            isPrint: "true",
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
