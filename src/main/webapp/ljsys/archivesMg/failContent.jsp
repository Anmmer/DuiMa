<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <form name="query" class="form-inline" style="width:70%;height:12%;margin-left: 14%;padding-top:2%">
        <div class="form-group" style="width: 100%;">
            <label for="classification">分类：</label><select id="classification" style="width: 15%"
                                                           class="form-control"></select>
            <button type="button" class="btn btn-primary btn-sm" style="margin-left: 2%"
                    onclick="getTableData()">
                查 询
            </button>
        </div>
    </form>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>质检缺陷信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:11%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="openNamePop()">
                新增名称
            </button>
            <button type="button" style="position: absolute;right: 21%;top:11%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="openClassPop()">
                新增分类
            </button>
        </div>
        <div style="height: 85%;width:100%;overflow-y: scroll">
            <table class="table table-hover" style="width:100%;text-align: center;">
                <tr>
                    <td class='tdStyle_title active' style="width: 20%">缺陷分类</td>
                    <td class='tdStyle_title active'>缺陷名称</td>
                    <td class='tdStyle_title active' style="width: 20%">操作</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
        <%--        <nav aria-label="Page navigation" style="margin-left:40%;width:80%;height:10%;">--%>
        <%--            <ul class="pagination" style="margin-top: 0;width: 70%">--%>
        <%--                <li><span id="total" style="width: 22%"></span></li>--%>
        <%--                <li>--%>
        <%--                    <a href="#" onclick="jumpToNewPage(2)" aria-label="Previous">--%>
        <%--                        <span aria-hidden="true">&laquo;</span>--%>
        <%--                    </a>--%>
        <%--                </li>--%>
        <%--                <li id="li_1"><a id="a_1" href="#">1</a></li>--%>
        <%--                <li id="li_2"><a id="a_2" href="#">2</a></li>--%>
        <%--                <li id="li_3"><a id="a_3" href="#">3</a></li>--%>
        <%--                <li id="li_4"><a id="a_4" href="#">4</a></li>--%>
        <%--                <li id="li_0"><a id="a_0" href="#">5</a></li>--%>
        <%--                <li>--%>
        <%--                    <a href="#" onclick="jumpToNewPage(3)" aria-label="Next">--%>
        <%--                        <span aria-hidden="true">&raquo;</span>--%>
        <%--                    </a>--%>
        <%--                </li>--%>
        <%--                <li style="border: none"><span>跳转：</span></li>--%>
        <%--                <li class="input-group">--%>
        <%--                    <input type="text" id="jump_to" class="form-control" style="width: 10%">--%>
        <%--                </li>--%>
        <%--                <li><a href="#" onclick="jumpToNewPage2()">go!</a></li>--%>
        <%--            </ul>--%>
        <%--        </nav>--%>
        <!-- Modal -->
        <div class="modal fade" id="myModalClass" tabindex="-1" style="position: absolute;left: 15%;top: 12%;"
             role="dialog"
             data-backdrop="false"
             aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width:60%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="title_class_add">分类新增</h4>
                        <h4 class="modal-title" id="title_class_update">分类修改</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group" style="margin-top: 5%">
                                <label for="pop_classification" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">分类:</label>
                                <input type="text" class="form-control" style="width:50%;" id="pop_classification"
                                       name="pop_classification">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                        <button type="button" id="class_save" class="btn btn-primary">保存</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModalName" tabindex="-1" style="position: absolute;left: 15%;top: 12%;"
             role="dialog"
             data-backdrop="false"
             aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width:60%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="title_name_add">名称新增</h4>
                        <h4 class="modal-title" id="title_name_update">名称修改</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group" style="margin-top: 5%">
                                <label for="pop_classification_1" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">缺陷分类:</label>
                                <select class="form-control" style="width:50%;" id="pop_classification_1"
                                        name="pop_classification_1"></select><br>
                                <label for="pop_defect_name" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">缺陷名称:</label>
                                <input type="text" class="form-control" style="width:50%;" id="pop_defect_name"
                                       name="pop_defect_name">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                        <button type="button" id="name_save" class="btn btn-primary">保存</button>
                    </div>
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

    let jsonObj = [];   //数据信息
    let selectClass = []

    getFailClass();
    window.onload = getTableData();

    //打开新增弹窗
    function openClassPop(id, classification) {
        $('#myModalClass').modal('show')
        if (id !== undefined) {
            $("#title_class_update").show();
            $("#title_class_add").hide();
            $("#pop_classification").val(classification)
            $("#class_save").attr('onclick', 'class_edit()');
        } else {
            $("#title_class_update").hide();
            $("#title_class_add").show();
            $("#pop_classification").val('')
            $("#class_save").attr('onclick', 'class_save()');
        }
    }

    //打开修改弹窗
    function openNamePop(id, defect_name, classification) {
        $('#myModalName').modal('show')
        if (id !== undefined) {
            $("#title_name_update").show();
            $("#title_name_add").hide();
            $('#pop_classification_1').empty();
            for (let o of selectClass) {
                let item = $("<option value='" + o['classification'] + "'>" + o['classification'] + "</option>")
                $('#pop_classification_1').append(item)
            }
            $("#pop_classification_1").val(classification)
            $("#pop_classification_1").attr("disabled", "disabled")
            $("#pop_defect_name").val(defect_name)
            $("#name_save").attr('onclick', "name_edit('" + id + "')");
        } else {
            $("#title_name_update").hide();
            $("#title_name_add").show();
            $("#pop_classification_1").removeAttr("disabled");
            $("#pop_defect_name").val('')
            $("#name_save").attr('onclick', 'name_save()');
            $('#pop_classification_1').empty();
            for (let o of selectClass) {
                let item = $("<option value='" + o['classification'] + "'>" + o['classification'] + "</option>")
                $('#pop_classification_1').append(item)
            }
        }
    }

    //关闭弹窗
    function closePop() {
        $('#myModal').modal('hide')
        reset();
    }

    //重置弹窗
    function reset() {
        $('#pop_classification').val('');
    }

    $('#myModal').on('hidden.bs.modal', function (e) {
        $('#pop_classification').val('');
    })

    function getTableData() {
        let classification = $('#classification').val();
        let obj = {
            classification: classification
            // 'pageCur': newPage,
            // 'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetFailContent",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = [];
                    for (let o of res.data) {
                        jsonObj.push({id: o.id, classification: o.classification, defect_name: ''})
                        for (let d of o.child) {
                            jsonObj.push({
                                id: d.id,
                                pid: d.pid,
                                classification: '',
                                classification_p: d.classification,
                                defect_name: d.defect_name
                            })
                        }
                    }
                    updateTable();
                    // $('#total').html(res.cnt + "条，共" + res.pageAll + "页");
                    // $('#li_1').addClass('active');
                    // // 重置查询为第一页
                    // pageCur = newPage;
                    // // 重置总页数
                    // pageAll = parseInt(res.pageAll);
                    // for (let i = 1; i < 6; i++) {
                    //     let k = i % 5;
                    //     if (i > pageAll) {
                    //         $('#a_' + k).text('.');
                    //     } else {
                    //         if (k === 0) {
                    //             $('#a_' + k).text(5);
                    //             $('#a_' + k).attr('onclick', 'jumpToNewPage1(5)');
                    //             continue;
                    //         } else {
                    //             $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');
                    //         }
                    //     }
                    // }
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

    function getFailClass() {
        $.post("${pageContext.request.contextPath}/GetFailClass", null, function (result) {
            result = JSON.parse(result);
            selectClass = result.data;
            let item_ = $("<option></option>")
            $('#classification').append(item_)
            for (let o of result.data) {
                let item = $("<option value='" + o['classification'] + "'>" + o['classification'] + "</option>")
                $('#classification').append(item)
            }
        });
    }

    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle_body'>" + jsonObj[i]['classification'] +
                "</td><td class='tdStyle_body'>" + jsonObj[i]['defect_name'];
            if (jsonObj[i].classification === '') {
                str += "</td><td class='tdStyle_body'><a href='#' onclick=openNamePop('" + jsonObj[i].id + "','" + jsonObj[i].defect_name + "','" + jsonObj[i].classification_p + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            } else {
                str += "</td><td class='tdStyle_body'><a href='#' onclick=openClassPop('" + jsonObj[i].id + "','" + jsonObj[i].classification + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            }
        }
        $("#archTableText").html(str);
    }


    function delTableData(id, qc) {
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        $.post("${pageContext.request.contextPath}/DeleteQc", {id: id, qc: qc}, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                closePop();
                getTableData(pageCur);
            }
        });
    }

    function name_save() {
        let obj = {
            index: '1',
            classification: $('#pop_classification_1').val(),
            defect_name: $('#pop_defect_name').val(),
        }
        for (let o of selectClass) {
            if (o.classification == obj.classification) {
                obj.pid = o.id
                break;
            }
        }
        if (obj.defect_name === '') {
            alert("请输入！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddFailContent", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                let r = confirm("亲，是否继续添加！");
                if (r === false) {
                    $('#myModalName').modal('hide');
                    getTableData();
                } else {
                    $('#pop_defect_name').val('')
                    getTableData();
                }
            }
        })
    }

    function name_edit(id) {
        let obj = {
            index: '2',
            id: id,
            classification: $('#pop_classification_1').val(),
            defect_name: $('#pop_defect_name').val(),
        }
        for (let o of selectClass) {
            if (o.classification == obj.classification) {
                obj.pid = o.id
                break;
            }
        }
        if (obj.defect_name === '') {
            alert("请输入！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddFailContent", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                let r = confirm("亲，是否继续添加！");
                if (r === false) {
                    $('#myModalName').modal('hide');
                    getTableData();
                } else {
                    $('#pop_defect_name').val('')
                    getTableData();
                }
            }
        })
    }

    function class_save() {
        let obj = {
            index: '2',
            classification: $('#pop_classification').val(),
        }
        if (obj.defect_name === '') {
            alert("请输入！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddFailContent", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModalClass').modal('hide');
                $('#pop_classification').val('')
                getTableData();
            }
        })
    }

    function edit(id, qc) {
        let obj = {
            qc: $('#pop_qc').val(),
            id: id,
            qc_old: qc
        }
        if (obj.qc === '') {
            alert("请输入！");
            return;
        }
        if ($('#pop_qc').val() == qc) {
            return;
        }
        $.post("${pageContext.request.contextPath}/UpdateQc", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal').modal('hide');
                getTableData(pageCur);
            }
        });
    }

    $('.recover-btn').click(function () {
        reset();
    })

    <%--function jumpToNewPage(newPageCode) {--%>
    <%--    let newPage = 1;--%>
    <%--    if (newPageCode === 1) newPage = 1;--%>
    <%--    if (newPageCode === 2) {--%>
    <%--        if (pageCur === 1) {--%>
    <%--            window.alert("已经在第一页!");--%>
    <%--            return--%>
    <%--        } else {--%>
    <%--            newPage = pageCur - 1;--%>
    <%--        }--%>
    <%--    }--%>
    <%--    if (newPageCode === 3) {--%>
    <%--        if (pageCur === pageAll) {--%>
    <%--            window.alert("已经在最后一页!");--%>
    <%--            return--%>
    <%--        } else {--%>
    <%--            newPage = pageCur + 1;--%>
    <%--        }--%>
    <%--    }--%>
    <%--    let classification = $('#classification').val();--%>
    <%--    let obj = {--%>
    <%--        'classification': classification,--%>
    <%--        'pageCur': newPage,--%>
    <%--        'pageMax': pageMax--%>
    <%--    }--%>
    <%--    $.ajax({--%>
    <%--        url: "${pageContext.request.contextPath}/GetFailContent",--%>
    <%--        type: 'post',--%>
    <%--        dataType: 'json',--%>
    <%--        data: obj,--%>
    <%--        contentType: 'application/x-www-form-urlencoded;charset=utf-8',--%>
    <%--        success: function (res) {--%>
    <%--            if (res.data.length !== 0) {--%>
    <%--                jsonObj = res.data;--%>
    <%--                updateTable();--%>
    <%--                if (newPageCode === 3) {--%>
    <%--                    setFooter(3, res.pageAll, pageCur, newPage);--%>
    <%--                }--%>
    <%--                if (newPageCode === 2) {--%>
    <%--                    setFooter(2, res.pageAll, pageCur, newPage);--%>
    <%--                }--%>
    <%--                // 重置查询为第一页--%>
    <%--                pageCur = newPage;--%>
    <%--                // 重置总页数--%>
    <%--                pageAll = parseInt(res.pageAll);--%>
    <%--            } else {--%>
    <%--                jsonObj = []--%>
    <%--                updateTable();--%>
    <%--            }--%>
    <%--        },--%>
    <%--        error: function () {--%>
    <%--            jsonObj = [];--%>
    <%--            updateTable();--%>
    <%--            alert("查询失败！")--%>
    <%--        }--%>
    <%--    })--%>
    <%--}--%>

    <%--function jumpToNewPage1(newPage) {--%>
    <%--    let classification = $('#classification').val();--%>
    <%--    let obj = {--%>
    <%--        'classification': classification,--%>
    <%--        'pageCur': newPage,--%>
    <%--        'pageMax': pageMax--%>
    <%--    }--%>
    <%--    $.ajax({--%>
    <%--        url: "${pageContext.request.contextPath}/GetFailContent",--%>
    <%--        type: 'post',--%>
    <%--        dataType: 'json',--%>
    <%--        data: obj,--%>
    <%--        contentType: 'application/x-www-form-urlencoded;charset=utf-8',--%>
    <%--        success: function (res) {--%>
    <%--            if (res.data.length !== 0) {--%>
    <%--                jsonObj = res.data;--%>
    <%--                updateTable();--%>
    <%--                $('#li_' + newPage % 5).addClass('active');--%>
    <%--                $('#li_' + pageCur % 5).removeClass('active');--%>
    <%--                pageCur = newPage;--%>
    <%--            } else {--%>
    <%--                jsonObj = []--%>
    <%--                updateTable();--%>
    <%--            }--%>
    <%--        },--%>
    <%--        error: function () {--%>
    <%--            jsonObj = [];--%>
    <%--            updateTable();--%>
    <%--            alert("查询失败！")--%>
    <%--        }--%>
    <%--    })--%>
    <%--}--%>

    <%--function jumpToNewPage2() {--%>
    <%--    let classification = $('#classification').val();--%>
    <%--    let newPage = $('#jump_to').val();--%>
    <%--    if (newPage > pageAll) {--%>
    <%--        alert("超过最大页数")--%>
    <%--    }--%>
    <%--    let obj = {--%>
    <%--        'classification': classification,--%>
    <%--        'pageCur': newPage,--%>
    <%--        'pageMax': pageMax--%>
    <%--    }--%>
    <%--    $.ajax({--%>
    <%--        url: "${pageContext.request.contextPath}/GetFailContent",--%>
    <%--        type: 'post',--%>
    <%--        dataType: 'json',--%>
    <%--        data: obj,--%>
    <%--        contentType: 'application/x-www-form-urlencoded;charset=utf-8',--%>
    <%--        success: function (res) {--%>
    <%--            if (res.data.length !== 0) {--%>
    <%--                jsonObj = res.data;--%>
    <%--                updateTable();--%>
    <%--                jump2(newPage, res.pageAll);--%>
    <%--                // 重置查询为第一页--%>
    <%--                pageCur = newPage;--%>
    <%--                // 重置总页数--%>
    <%--                pageAll = parseInt(res.pageAll);--%>
    <%--            } else {--%>
    <%--                jsonObj = []--%>
    <%--                updateTable();--%>
    <%--            }--%>
    <%--        },--%>
    <%--        error: function () {--%>
    <%--            jsonObj = [];--%>
    <%--            updateTable();--%>
    <%--            alert("查询失败！")--%>
    <%--        }--%>
    <%--    })--%>
    <%--}--%>

    <%--function jump2(newPage, pageAll) {--%>
    <%--    if (newPage <= 5) {--%>
    <%--        for (let i = 1; i < 6; i++) {--%>
    <%--            let k = i % 5;--%>
    <%--            if (i > pageAll) {--%>
    <%--                $('#a_' + k).text('.');--%>
    <%--            } else {--%>
    <%--                if (k === 0) {--%>
    <%--                    $('#a_' + k).text(5);--%>
    <%--                } else {--%>
    <%--                    $('#a_' + k).text(k);--%>
    <%--                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');--%>
    <%--                }--%>
    <%--            }--%>
    <%--        }--%>
    <%--        $('#li_' + pageCur % 5).removeClass('active');--%>
    <%--        $('#li_' + newPage % 5).addClass('active');--%>
    <%--    } else {--%>
    <%--        let j = Math.floor(newPage / 5);--%>
    <%--        let m = j * 5;--%>
    <%--        for (let i = 1; i < 6; i++) {--%>
    <%--            let k = i % 5;--%>
    <%--            if (++m > pageAll) {--%>
    <%--                $('#a_' + k).text('.');--%>
    <%--            } else {--%>
    <%--                $('#a_' + k).text(m);--%>
    <%--                $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m + ')');--%>
    <%--            }--%>
    <%--        }--%>
    <%--        $('#li_' + pageCur % 5).removeClass('active');--%>
    <%--        $('#li_' + newPage % 5).addClass('active');--%>
    <%--    }--%>
    <%--}--%>

    <%--function setFooter(newPageCode, pageAll, pageCur, newPage) {--%>
    <%--    if (newPageCode === 3) {--%>
    <%--        if (pageCur % 5 === 0) {--%>
    <%--            let j = Math.floor(newPage / 5);--%>
    <%--            let m = j * 5;--%>
    <%--            for (let i = 1; i < 6; i++) {--%>
    <%--                let k = i % 5;--%>
    <%--                if (++m > pageAll) {--%>
    <%--                    $('#a_' + k).text('.');--%>
    <%--                } else {--%>
    <%--                    $('#a_' + k).text(m);--%>
    <%--                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m + ')');--%>
    <%--                }--%>
    <%--            }--%>

    <%--        }--%>
    <%--        $('#li_' + newPage % 5).addClass('active');--%>
    <%--        $('#li_' + pageCur % 5).removeClass('active');--%>
    <%--    } else {--%>
    <%--        if (pageCur % 5 === 1) {--%>
    <%--            let j = Math.floor(newPage / 5);--%>
    <%--            let m--%>
    <%--            if (j < 0) {--%>
    <%--                m = 5;    //5*1--%>
    <%--            } else {--%>
    <%--                m = j * 5;--%>
    <%--            }--%>
    <%--            for (let i = 5; i > 0; i--) {--%>
    <%--                let k = i % 5;--%>
    <%--                if (m > pageAll) {--%>
    <%--                    $('#a_' + k).text('');--%>
    <%--                    m--;--%>
    <%--                } else {--%>
    <%--                    $('#a_' + k).text(m);--%>
    <%--                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m-- + ')');--%>
    <%--                }--%>
    <%--            }--%>
    <%--        }--%>
    <%--        $('#li_' + newPage % 5).addClass('active');--%>
    <%--        $('#li_' + pageCur % 5).removeClass('active');--%>
    <%--    }--%>
    <%--}--%>
</script>
