<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <form name="query" class="form-inline" style="width:85%;height:10%;margin-left: 6%;padding-top:2%">
        <label for="type" style="margin-left: 2%">类型：</label>
        <select type="text" name="type" id="type" style="width: 13%;height: 30px" class="form-control">
            <option value=""></option>
            <option value="1">入库</option>
            <option value="2">出库</option>
            <option value="3">移库</option>
        </select>
        <label for="startDate" style="margin-left: 3%">操作日期从：</label>
        <input id="startDate" class="form-control" type="date" style="width: 13%;height: 30px">
        <label for="endDate" style="margin-left: 2%">至：</label>
        <input id="endDate" class="form-control" type="date" style="width: 13%;height: 30px">
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 3%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:85%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>出入库信息</small></h3>
            <button type="button" style="position: absolute;right: 10%;top:10%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="printDataF()">
                打印单据
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" cellspacing="0" cellpadding="0" width="100%"
                   align="center">
                <tr>
                    <td class='tdStyle_title table_td active' style="width: 10%">物料编码</td>
                    <td class='tdStyle_title table_td active' style="width: 5%">类型</td>
                    <td class='tdStyle_title table_td active' style="width: 8%">方式</td>
                    <td class='tdStyle_title table_td active' style="width: 10%">入库地址</td>
                    <td class='tdStyle_title table_td active' style="width: 15%">出库地址</td>
                    <td class='tdStyle_title table_td active' style="width: 5%">操作人</td>
                    <td class='tdStyle_title table_td active' style="width: 10%">操作日期</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:35%;width:70%;height:10%;">
            <ul class="pagination" style="margin-top: 0;width: 100%">
                <li><span id="total"></span></li>
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
    <div class="modal fade" id="myModal"
         style="position: absolute;left: 2%;height: 95%;top: 3%;width: 95%;z-index: 5" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="width: 100%;height: 100%;margin: 0">
            <div class="modal-content" style="width: 100%;height: 100%">
                <div class="modal-header" style="height: 7%">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h5 class="modal-title">打印信息</h5>
                </div>
                <div class="modal-body" id="print" style="height: 90%;width: 100%">
                    <!--startprint-->
                    <div id="title" style="font-size: 25px;height:50px;text-align: center">出库单</div>
                    <table border="1" style="text-align: center;width: 100%;">
                        <tr>
                            <td class='print_tdStyle_title active' style="width: 10%">物料编码</td>
                            <td class='print_tdStyle_title active' style="width: 20%">类型 规格 图号</td>
                            <td class='print_tdStyle_title active' style="width: 5%">方量</td>
                            <td class='print_tdStyle_title active' style="width: 5%">重量</td>
                            <td class='print_tdStyle_title active' style="width: 8%">方式</td>
                            <td class='print_tdStyle_title active' style="width: 15%">货位</td>
                            <td class='print_tdStyle_title active' style="width: 5%">操作人</td>
                            <td class='print_tdStyle_title active' style="width: 10%">操作日期</td>
                        </tr>
                        <tbody id="printTableText">
                        </tbody>
                    </table>
                    <div style="display: flex;margin-top: 30px">
                        <div id="print_name" style="width: 150px"></div>
                        <div id="print_date" style="width: 400px"></div>
                        <div>签字：</div>
                    </div>
                    <!--endprint-->
                </div>
            </div>
        </div>
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
    let printData = []  //打印数据


    function getTableData(newPage) {
        let type = $('#type').val();
        let endDate = $('#endDate').val();
        let startDate = $('#startDate').val();
        if (!type) {
            alert("请选择类型")
            return
        }
        if (!startDate || !endDate) {
            alert("请选择操作日期")
            return
        }
        let obj = {
            type: type,
            startDate: startDate,
            endDate: endDate,
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseLog",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
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


    function printDataF() {
        let type = $('#type').val();
        let endDate = $('#endDate').val();
        let startDate = $('#startDate').val();
        if (!type) {
            alert("请选择类型1111")
            return
        }
        if (!startDate || !endDate) {
            alert("请选择操作日期")
            return
        }
        $('#myModal').modal('show')
        document.getElementById("print_name").innerText = "制单人：" + sessionStorage.getItem("userName")
        document.getElementById("print_date").innerText = "打印时间：" + new Date().toLocaleString()
        document.getElementById("title").innerText = type === '1' ? "入库单" : "出库单"
        let obj = {
            type: type, endDate: endDate, startDate: startDate, pageCur: 1,
            pageMax: 500
        }
        getPrintData(obj)

    }


    function getPrintData(obj) {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseLog",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    printData = res.data;
                    updatePrintTable();
                }
            },
            error: function () {
                printData = [];
                updatePrintTable();
                alert("查询失败！")
            }
        })
    }

    function updatePrintTable() {
        let str = '';
        for (let i = 0; i < printData.length; i++) {
            let some = printData[i]['build_type'] + " " + printData[i]['standard'] + " " + printData[i]['drawing_no']
            printData[i]['method'] = printData[i]['method'] === void 0 ? "" : printData[i]['method']
            let path = !!printData[i]['in_warehouse_path'] ? printData[i]['in_warehouse_path'] : printData[i]['out_warehouse_path']
            str += "<tr><td class='tdStyle_body' title='" + printData[i]['materialcode'] + "'>" + printData[i]['materialcode'] +
                "</td><td class='tdStyle_body' title='" + some + "'>" + some +
                "</td><td class='tdStyle_body' title='" + printData[i]['fangliang'] + "'>" + printData[i]['fangliang'] +
                "</td><td class='tdStyle_body' title='" + printData[i]['weigh'] + "'>" + printData[i]['weigh'] +
                "</td><td class='tdStyle_body' title='" + printData[i]['method'] + "'>" + printData[i]['method'] +
                "</td><td class='tdStyle_body' title='" + path + "'>" + path +
                "</td><td class='tdStyle_body' title='" + printData[i]['user_name'] + "'>" + printData[i]['user_name'] +
                "</td><td class='tdStyle_body' title='" + printData[i]['create_date'] + "'>" + printData[i]['create_date'] +
                "</td></tr>";
        }
        $("#printTableText").html(str);
        setTimeout(() => {
            let printhtml = document.getElementById("print").innerHTML;
            $('#myModal').modal('hide')
            let bdhtml = window.document.body.innerHTML;
            let sprnstr = "<!--startprint-->";
            let eprnstr = "<!--endprint-->";
            let prnhtml = printhtml.substr(printhtml.indexOf(sprnstr) + 17);
            prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
            window.document.body.innerHTML = prnhtml;
            window.print();
            window.document.body.innerHTML = bdhtml;
            location.reload()
        }, 500)

    }

    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            jsonObj[i]['in_warehouse_path'] = jsonObj[i]['in_warehouse_path'] === void 0 ? '' : jsonObj[i]['in_warehouse_path']
            jsonObj[i]['out_warehouse_path'] = jsonObj[i]['out_warehouse_path'] === void 0 ? '' : jsonObj[i]['out_warehouse_path']
            jsonObj[i]['method'] = jsonObj[i]['method'] === void 0 ? '' : jsonObj[i]['method']
            switch (jsonObj[i]['type']) {
                case '1':
                    jsonObj[i]['type'] = "入库"
                    break;
                case '2':
                    jsonObj[i]['type'] = "出库"
                    break;
                case '3':
                    jsonObj[i]['type'] = "移库"
                    break;
            }
            str += "<tr><td class='tdStyle_body' title='" + jsonObj[i]['materialcode'] + "'>" + jsonObj[i]['materialcode'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['type'] + "'>" + jsonObj[i]['type'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['method'] + "'>" + jsonObj[i]['method'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['in_warehouse_path'] + "'>" + jsonObj[i]['in_warehouse_path'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['out_warehouse_path'] + "'>" + jsonObj[i]['out_warehouse_path'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['user_name'] + "'>" + jsonObj[i]['user_name'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['create_date'] + "'>" + jsonObj[i]['create_date'] +
                "</td></tr>";
        }
        $("#archTableText").html(str);
    }


    function jumpToNewPage(newPageCode) {
        let newPage = 1;
        if (newPageCode === 1) newPage = 1;
        if (newPageCode === 2) {
            if (pageCur == 1) {
                window.alert("已经在第一页!");
                return
            } else {
                newPage = pageCur - 1;
            }
        }
        if (newPageCode === 3) {
            if (pageCur == pageAll) {
                window.alert("已经在最后一页!");
                return
            } else {
                newPage = pageCur + 1;
            }
        }
        let materialcode = $('#materialcode').val();
        let materialname = $('#materialname').val();
        let pourState = $('#pourState').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            pourState: pourState,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }
        if (on_or_off == '1') {
            obj.isTest = "true"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseLog",
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
        let materialname = $('#materialname').val();
        let pourState = $('#pourState').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            pourState: pourState,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }
        if (on_or_off == '1') {
            obj.isTest = "true"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseLog",
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
        let newPage = parseInt($('#jump_to').val())
        let materialcode = $('#materialcode').val();
        let materialname = $('#materialname').val();
        let pourState = $('#pourState').val();
        if (newPage == "" || isNaN(newPage))
            return;
        if (newPage > pageAll) {
            alert("超过最大页数")
            return
        }
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            pourState: pourState,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }
        if (on_or_off == '1') {
            obj.isTest = "true"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseLog",
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
<style>
    table {
        table-layout: fixed; /* 只有定义了表格的布局算法为fixed，下⾯td的定义才能起作⽤。 */
    }

    .table_td {
        width: 100%;
        word-break: keep-all; /* 不换⾏ */
        white-space: nowrap; /* 不换⾏ */
        overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
        text-overflow: ellipsis; /* 当对象内⽂本溢出时显⽰省略标记(...) ；需与overflow:hidden;⼀起使⽤。*/
    }
</style>
