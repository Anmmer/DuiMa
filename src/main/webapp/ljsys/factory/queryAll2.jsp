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
    <form name="query" class="form-inline" style="width:85%;height:15%;margin-left: 8%;padding-top:2%">
        <div class="form-group">
            <label>堆场名称：</label><input type="text" id="factoryName"
                                       style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>项目：</label><input type="text" id="planName"
                                     style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>楼栋：</label><input type="text" id="buildNo"
                                     style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>楼层：</label><input type="text" id="floorNo"
                                     style="height:10%;" class="form-control">
        </div>
        <br><br>
        <div class="form-group" style="">
            <label>物料编码：</label><input type="text" id="materialCode"
                                       style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>构件类型：</label><input type="text" id="buildType"
                                       style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>图号：</label><input type="text" id="drawNo"
                                     style="height:10%;" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="updateTable(1)">
            查 询
        </button>
    </form>
    <div style="width:85%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>仓库信息</small></h3>
            <%--            <button type="button" style="position: absolute;right: 15%;top:15%" class="btn btn-primary btn-sm"--%>
            <%--                    data-toggle="modal"--%>
            <%--                    data-target="#myModal">--%>
            <%--                添加仓库--%>
            <%--            </button>--%>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" cellspacing="0" cellpadding="0" width="100%" align="center">
                <tr>
                    <td class='tdStyle_title  active' style="width: 10%">物料编码</td>
                    <td class='tdStyle_title active' style="width: 10%">构件名称</td>
                    <td class='tdStyle_title active' style="width: 10%">构件类型</td>
                    <td class='tdStyle_title active' style="width: 10%">所属项目</td>
                    <td class='tdStyle_title active' style="width: 10%">楼栋</td>
                    <td class='tdStyle_title active' style="width: 10%">楼层</td>
                    <td class='tdStyle_title active' style="width: 10%">图号</td>
                    <td class='tdStyle_title active' style="width: 10%">方量</td>
                    <td class='tdStyle_title active' style="width: 15%">库位</td>
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
                        <div class="form-group" style="height: 100%;margin-top: 5%">
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
    <script type="text/javascript">
        var pageCur = 1;
        var pageAll = 1;
        let pageMax = 10;   //一页多少条数据
        let jsonObj = [];

        window.onload = getTableData(1);

        function getTableData(newPage) {
            let factoryName = $('#factoryName').val();
            let planName = $('#planName').val();
            let buildNo = $('#buildNo').val();
            let floorNo = $('#floorNo').val();
            let materialCode = $('#materialCode').val();
            let buildType = $('#buildType').val();
            let drawNo = $('#drawNo').val();
            let obj = {
                factoryName: factoryName,
                planName: planName,
                buildNo: buildNo,
                floorNo: floorNo,
                materialCode: materialCode,
                buildType: buildType,
                drawNo: drawNo,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetYard",
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


        function updateTable() {
            let str = '';
            for (let i = 0; i < jsonObj.length; i++) {
                let location = jsonObj[i]['factory'] + '-' + jsonObj[i]['region'] + '-' +  jsonObj[i]['warehouse']
                str += "<tr><td class='tdStyle_body' title='" + jsonObj[i]['materialcode'] + "'>" + jsonObj[i]['materialcode'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['materialname'] + "'>" + jsonObj[i]['materialname'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['build_type'] + "'>" + jsonObj[i]['build_type'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['planname'] + "'>" + jsonObj[i]['planname'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['building_no'] + "'>" + jsonObj[i]['building_no'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['floor_no'] + "'>" + jsonObj[i]['floor_no'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['drawing_no'] + "'>" + jsonObj[i]['drawing_no'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['fangliang'] + "'>" + jsonObj[i]['fangliang'] +
                    "</td><td class='tdStyle_body' title='" + location + "'>" + location +
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
            let materialname = $('#materialname').val();
            let obj = {
                materialcode: materialcode,
                materialname: materialname,
                isPrint: "true",
                isPour: "true",
                inspectState: '2',
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetYard",
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
            let obj = {
                materialcode: materialcode,
                materialname: materialname,
                inspectState: '2',
                isPrint: "true",
                isPour: "true",
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetYard",
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
            let materialname = $('#materialname').val();
            if (newPage == "" || isNaN(newPage))
                return;
            if (newPage > pageAll) {
                alert("超过最大页数")
                return
            }
            let obj = {
                materialcode: materialcode,
                materialname: materialname,
                inspectState: '2',
                isPrint: "true",
                isPour: "true",
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetYard",
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
