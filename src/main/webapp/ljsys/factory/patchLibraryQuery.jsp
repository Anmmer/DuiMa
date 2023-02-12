<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询所有群组-->
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let jsonObj = [];

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
            <button type="button" style="position: absolute;right: 18%;top:18%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="inspect()">
                合格
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
    <script type="text/javascript">

        window.onload = getTableData(1);

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

            $.post("${pageContext.request.contextPath}/Inspect", {pids: JSON.stringify(obj)}, function (result) {
                result = JSON.parse(result);
                alert(result.message);
                if (result.flag) {
                    getTableData(pageCur);
                }
            });
        }

        let pre = 0
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

        function updateTable() {
            document.getElementById('pre_checkbok').checked = false
            pre = 0
            let str = '';
            for (let i = 0; i < jsonObj.length; i++) {
                if (jsonObj[i]['inspect'] === 0) {
                    jsonObj[i]['inspect'] = '未质检'
                } else {
                    jsonObj[i]['inspect'] = '质检不合格'
                }
                jsonObj[i]['checktime'] = jsonObj[i]['checktime'] === undefined ? '--' : jsonObj[i]['checktime'];
                jsonObj[i]['inspect_user'] = jsonObj[i]['inspect_user'] === undefined ? '--' : jsonObj[i]['inspect_user'];
                jsonObj[i]['inspect_remark'] = jsonObj[i]['inspect_remark'] === undefined ? '' : jsonObj[i]['inspect_remark'];
                str += "<tr><td class='tdStyle_body'><input type='checkbox' data-id=" + jsonObj[i]['pid'] + ">" +
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
