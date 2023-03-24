<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width: 100%">
    <form name="query" class="form-inline" style="width:70%;height:10%;margin-left: 14%;padding-top:2%">
        <div class="form-group">
            <label>产线名称：</label><input type="text" name="query_line" id="query_line"
                                     style="" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>产线信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:11%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="openAddPop()">
                新 增
            </button>
            <%--            <button style="position:absolute;top: 15%;width: 5%" onclick="openAddPop()">新 增</button>--%>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="tdStyle_title active" style="width: 35%">产线信息</td>
                    <td class="tdStyle_title active" style="width: 30%;text-align: center">操作</td>
                </tr>
                <tbody id="archTableText">
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
                    <h4 class="modal-title" id="title1">产线信息新增</h4>
                    <h4 class="modal-title" id="title2">产线信息修改</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="margin-top: 5%">
                            <label for="pop_line" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">产线信息:</label>
                            <input type="text" class="form-control" style="width:50%;" id="pop_line"
                                   name="newGroupName">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" id="save" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
    <%--    <div class="pop_up" style="width: 25%;left: 47%;top:23%;height: 25%">--%>
    <%--        <div class="pop_title title1">产线信息新增</div>--%>
    <%--        <div class="pop_title title2">产线信息修改</div>--%>
    <%--        <div class="close_btn"><img src="./img/close.png" onclick="closePop()"></div>--%>
    <%--        <div style="position: relative;left: 15%;height: 40%;margin: 0 auto">--%>
    <%--            <label for="pop_line">--%>
    <%--                产线信息:--%>
    <%--            </label>--%>
    <%--            <input name="pop_line" id="pop_line" style="margin-top: 6%;margin-bottom: 5%"><br>--%>
    <%--        </div>--%>
    <%--        <div class="pop_footer" style="display: flex;align-items: center;justify-content: center;">--%>
    <%--            <button id="save" class="saveo save-btn">保存</button>--%>
    <%--            <button class="recover-btn">重置</button>--%>
    <%--        </div>--%>
    <%--    </div>--%>
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

    window.onload = getTableData(1);

    //打开新增弹窗
    function openAddPop() {
        $('#myModal').modal('show')
        $("#title1").show();
        $("#title2").hide();
        $("#save").attr('onclick', 'save()');
    }

    //打开修改弹窗
    function openEditPop(id, line) {
        queryData(id);
        $('#myModal').modal('show')
        $("#title1").hide();
        $("#title2").show();
        $("#save").attr('onclick', "edit('" + id + "','" + line + "')");
    }

    //关闭弹窗
    function closePop() {
        $('#myModal').modal('hide')
        reset();
    }

    $('#myModal').on('hidden.bs.modal', function (e) {
        $('#pop_line').val('');
    })

    //重置弹窗
    function reset() {
        $('#pop_line').val('');
    }

    function getTableData(newPage) {
        let query_line = $('#query_line').val();
        let obj = {
            'line': query_line,
            'pageCur': newPage,
            'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetLine",
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
                updateTable();
                alert("查询失败！")
            }
        })
    }

    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle_body'>" + jsonObj[i]['line'] +
                "</td><td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['id'] + "','" + jsonObj[i]['line'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "','" + jsonObj[i]['line'] + "')>删除</a></td></tr>";
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
            url: "${pageContext.request.contextPath}/GetLine",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    $('#pop_line').val(res.data[0].line);
                }
            },
            error: function () {
                alert("查询失败！")
            }
        })
    }

    function delTableData(id, line) {
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        $.post("${pageContext.request.contextPath}/DeleteLine", {id: id, line: line}, function (result) {
            result = JSON.parse(result);
            if (result.flag) {
                getTableData(1);
                alert(result.message);
            } else {
                alert(result.message);
            }
        });
    }

    function save() {
        let obj = {
            line: $('#pop_line').val(),
        }
        if (obj.line === '') {
            alert("请输入！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddLine", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getTableData(1);
                $('#myModal').modal('hide');
            }
        })
    }

    function edit(id, line) {
        let obj = {
            line: $('#pop_line').val(),
            id: id,
            line_old: line
        }
        if (obj.line === '') {
            alert("请输入！");
            return;
        }
        if ($('#pop_line').val() == line) {
            return;
        }

        $.post("${pageContext.request.contextPath}/UpdateLine", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getTableData(1);
                $('#myModal').modal('hide');
            }
        });
    }

    $('.recover-btn').click(function () {
        reset();
    })

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
        let query_line = $('#query_line').val();
        let obj = {
            'line': query_line,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetLine",
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
        let query_line = $('#query_line').val();
        let obj = {
            'line': query_line,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetLine",
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
        let query_line = $('#query_line').val();
        var newPage = $('#jump_to').val();
        if (newPage > pageAll) {
            alert("超过最大页数")
        }
        let obj = {
            'line': query_line,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetLine",
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
