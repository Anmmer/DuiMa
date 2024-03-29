<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width: 100%">
    <form name="query" class="form-inline" style="width:85%;height:10%;margin-left: 8%;padding-top:2%">
        <div class="form-group">
            <label>项目名称：</label><input type="text" name="query_planname" id="query_planname"
                                       style="" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:85%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>生产情况汇总信息</small></h3>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="tdStyle_title active" style="width: 15%">项目名称</td>
                    <td class="tdStyle_title active" style="width: 12%">项目总量</td>
                    <td class="tdStyle_title active" style="width: 12%;text-align: center">浇捣总量</td>
                    <td class="tdStyle_title active" style="width: 12%;text-align: center">产成品总量</td>
                    <td class="tdStyle_title active" style="width: 12%;text-align: center">入库总量</td>
                    <td class="tdStyle_title active" style="width: 10%;text-align: center">出库总量</td>
                    <td class="tdStyle_title active" style="width: 10%;text-align: center">已完工</td>
                    <td class="tdStyle_title active" style="width: 10%;text-align: center">已交付</td>
                    <td class="tdStyle_title active" style="width: 5%;text-align: center">操作</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:30%;width:70%;height:10%;">
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
</div>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    }

    let count = 1;      //分页总页数
    let jsonObj = [];   //档案信息
    let pageCur = 1;    //分页当前页
    let pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let planname_old = null;

    window.onload = getTableData(1);


    function getTableData(newPage) {
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
            'pageCur': newPage,
            'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetProductionSummary",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = res.data;
                    updateTable();
                    $('#total').html(res.cnt + "条，共" + res.pageAll + "页");
                    $('#li_1').addClass('active');
                    // 重置查询为第一页
                    pageCur = newPage;
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
                } else {
                    jsonObj = []
                    updateTable();
                }
            },
            error: function () {
                jsonObj = [];
                updateTable(false);
                alert("查询失败！")
            }
        })
    }


    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            let plannumber_sum = jsonObj[i]['plannumber_sum'] === void 0 ? '0件/0方量' : jsonObj[i]['plannumber_sum']
            let pourmade_sum = jsonObj[i]['pourmade_sum'] === void 0 ? '0件/0方量' : jsonObj[i]['pourmade_sum']
            let inspect_sum = jsonObj[i]['inspect_sum'] === void 0 ? '0件/0方量' : jsonObj[i]['inspect_sum']
            let stock_in_sum = jsonObj[i]['stock_in_sum'] === void 0 ? '0件/0方量' : jsonObj[i]['stock_in_sum']
            let stock_out_sum = jsonObj[i]['stock_out_sum'] === void 0 ? '0件/0方量' : jsonObj[i]['stock_out_sum']
            if (jsonObj[i].all_num === "0") {
                jsonObj[i].all_num = "1"
            }
            str += "<tr><td class='tdStyle_body'>" + jsonObj[i]['planname'] +
                "<td class='tdStyle_body'>" + plannumber_sum + "</td>" +
                "<td class='tdStyle_body'>" + pourmade_sum + "</td>" +
                "<td class='tdStyle_body'>" + inspect_sum + "</td>" +
                "<td class='tdStyle_body'>" + stock_in_sum + "</td>" +
                "<td class='tdStyle_body'>" + stock_out_sum + "</td>" +
                "<td class='tdStyle_body'>" + (jsonObj[i].finished_num * 100 / jsonObj[i].all_num).toFixed(2) + "%" + "</td>" +
                "<td class='tdStyle_body'>" + (jsonObj[i].out_num * 100 / jsonObj[i].all_num).toFixed(2) + "%" + "</td>" +
                "<td class='tdStyle_body'><a href='buildingNoSummaryQueryAll.jsp?planname=" + jsonObj[i]['planname'] + "'>楼栋</a></td></tr>";
        }
        $("#archTableText").html(str);
    }

    function queryData(id) {
        let obj = {
            'id': id,
            'pageCur': 1,
            'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetProductionSummary",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    $('#pop_planname').val(res.data[0].planname);
                }
            },
            error: function () {
                alert("查询失败！")
            }
        })
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
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetProductionSummary",
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
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetProductionSummary",
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
        let query_planname = $('#query_planname').val();
        var newPage = $('#jump_to').val();
        if (newPage > pageAll) {
            alert("超过最大页数")
        }
        let obj = {
            'planname': query_planname,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetProductionSummary",
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
