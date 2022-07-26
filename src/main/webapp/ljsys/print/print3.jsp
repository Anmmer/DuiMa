<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width: 95%">
    <form name="query" class="form-inline" style="width:85%;height:20%;margin-left: 5%;padding-top:2%">
        <div class="form-group">
            <label for="startDate">开始时间：</label><input id="startDate" class="form-control" type="date"
                                                       style="width: 13%;height: 30px">
            <label for="endDate" style="margin-left: 2%">结束时间：</label><input id="endDate" class="form-control"
                                                                             type="date"
                                                                             style="width: 13%;height: 30px">
            <label for="planname" style="margin-left: 2%">项目名称：</label><input id="planname" class="form-control"
                                                                              style="width: 13%;height:10%;">
            <label for="materialcode" style="margin-left: 2%">物料编号：</label><input id="materialcode" class="form-control"
                                                                                  style="width: 13%;height:10%;"><br><br>
            <label for="materialname">物料名称：</label><input id="materialname" class="form-control"
                                                          style="width: 13%;height:10%;">
            <label for="preproductid" style="margin-left: 2%">构建编号：</label><input id="preproductid" class="form-control"
                                                                                  style="width: 13%;height:10%;">
            <label for="query_line" style="margin-left: 2%">产线：</label><input id="query_line" class="form-control"
                                                                              style="width: 13%;height:10%;">
            <%--            <label for="query_printstate" style="margin-left: 2%">打印状态：</label>--%>
            <%--            <select id="query_printstate" class="form-control" style="width: 13%;height:10%;">--%>
            <%--                <option value=''></option>--%>
            <%--                <option value='1'>已打印</option>--%>
            <%--                <option value='0'>打印中</option>--%>
            <%--            </select>--%>
            <button type="button" class="btn btn-primary btn-sm" style="margin-left: 1%"
                    onclick="getTableData(1)">
                查 询
            </button>
        </div>
    </form>
    <button type="button" style="position: absolute;right: 17%;top:13%" class="btn btn-primary btn-sm"
            data-toggle="modal"
            onclick="openPop()">
        上传文件
    </button>
    <button style="position: absolute;right: 10%;top:13%" class="btn btn-primary btn-sm"
            onclick="delTableData()">批量删除
    </button>
    <div style="width:90%;height:80%;margin:0 auto;">
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class='tdStyle_title active' style="width: 3%;"><input id="plan_checkbok" type="checkbox"></td>
                    <td class='tdStyle_title active' style="width: 10%">计划编号</td>
                    <td class='tdStyle_title active' style="width: 10%">项目名称</td>
                    <td class='tdStyle_title active' style="width: 8%">打印状态</td>
                    <td class='tdStyle_title active' style="width: 10%">工厂</td>
                    <td class='tdStyle_title active' style="width: 8%">生产日期</td>
                    <td class='tdStyle_title active' style="width: 8%">产线</td>
                    <td class='tdStyle_title active' style="width: 8%">楼栋楼层</td>
                    <td class='tdStyle_title active' style="width: 10%">构建数(个)</td>
                    <td class='tdStyle_title active' style="width: 8%">合计方量</td>
                    <td class='tdStyle_title active' style="width: 8%">操作</td>
                </tr>
                <tbody id="planTableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:25%;width:80%;height:10%;">
            <ul class="pagination" style="margin-top: 0;width: 70%">
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
        <!-- Modal -->
        <div class="modal fade" id="myModal"
             style="position: absolute;left: 2%;height: 96%;top: 2%;width: 95%;z-index: 5" role="dialog"
             data-backdrop="false"
             aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document" style="width: 100%;height: 100%;margin: 0">
                <div class="modal-content" style="width: 100%;height: 100%">
                    <div class="modal-header" style="height: 7%">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h5 class="modal-title" id="title_1">上传Excel</h5>
                        <h5 class="modal-title" id="title_2">构件信息</h5>
                    </div>
                    <div class="modal-body" style="height: 85%">
                        <div name="query" id="pop_query" class="form-inline"
                             style="width: 100%;height: 18%;padding: 10px 0 0 0">
                            <div class="form-group">
                                <label for="print_build">楼栋楼层：</label><input id="print_build" class="form-control"
                                                                             style="width: 12%;height: 30px" disabled>
                                <label for="print_line" style="margin-left: 1%">产线：</label><input id="print_line"
                                                                                                  class="form-control"
                                                                                                  style="width: 10%;height: 30px"
                                                                                                  disabled>
                                <label for="updatedate" style="margin-left: 1%">最后修改时间：</label><input id="updatedate"
                                                                                                      class="form-control"
                                                                                                      style="width: 10%;height: 30px"
                                                                                                      disabled>
                                <label for="print_materialcode" style="margin-left: 1%">物料编码：</label><input
                                    id="print_materialcode" class="form-control"
                                    style="width: 15%;height: 30px">
                                <label for="print_materialname" style="margin-left: 1%">物料名称：</label><input
                                    id="print_materialname" class="form-control"
                                    style="width: 15%;height: 30px"><br><br>
                                <label for="print_planname">项目名称：</label><input id="print_planname" class="form-control"
                                                                                style="width: 12%;height: 30px"
                                                                                disabled>
                                <label for="print_liner" style="margin-left: 1%">线长：</label><input id="print_liner"
                                                                                                   class="form-control"
                                                                                                   style="width: 10%;height: 30px"
                                                                                                   disabled>
                                <label for="print_plantime" style="margin-left: 1%">计划生产时间：</label><input
                                    id="print_plantime" class="form-control" style="width: 10%;height: 30px" disabled>
                                <label for="print_preproductid" style="margin-left: 1%">构建编号：</label><input
                                    id="print_preproductid" class="form-control"
                                    style="width: 15%;height: 30px">
                                <button id="pop_query_button" class="btn btn-primary" onclick="getPopData(1)"
                                        style="margin-left:15%;width: 80px;height: 30px;padding: 0;font-size: 12px !important;">
                                    查&nbsp;&nbsp;询
                                </button>
                            </div>
                        </div>
                        <div name="query" id="pop_input" class="form-inline" style="width: 100%;height: 20%">
                            <div class="form-group">
                                <input type="file" id="excel-file"
                                       accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                                       style="position: relative;margin-top: 0%;height: 24px;font-size: 12px;margin-bottom: 5px">
                                <label for="build">楼栋楼层：</label>
                                <input id="build" class="form-control" style="width: 20%;height: 24px;">
                                <label for="pop_planname" style="margin-left: 1%">项&nbsp;&nbsp;目&nbsp;&nbsp;名&nbsp;称&nbsp;&nbsp;：</label>
                                <input id="pop_planname" class="form-control" style="width: 20%;height: 24px;" disabled>
                                <label for="line" style="margin-left: 1%">产&nbsp;&nbsp;&nbsp;线：</label>
                                <input id="line" class="form-control" style="width: 20%;height: 24px;" disabled><br><br>
                                <label for="liner">线&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长：&nbsp;</label><input
                                    id="liner" class="form-control" style="width: 20%;height: 24px;" disabled>
                                <label for="plantime" style="margin-left: 1%">计划生产时间：</label>
                                <input id="plantime" class="form-control" style="width: 20%;height: 24px;" disabled>
                                <label for="qc" style="margin-left: 1%">质检员：</label><select id="qc" class="form-control"
                                                                                            style="width: 20%;height: 24px;padding: 0"></select>
                            </div>
                        </div>
                        <div style="height: 75%;">
                            <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
                                <h3 style="margin-bottom: 0;margin-top: 0" id="inputDetail"><small>导入预览</small></h3>
                            </div>
                            <table class="table table-hover" style="text-align: center;">
                                <tr id="table_tr">
                                    <td class='table_tr_print tdStyle_title active' style="width: 2%;"><input
                                            id="detail_checkbok"
                                            type="checkbox"></td>
                                    <td class='tdStyle_title active' style="width: 14%">物料编号</td>
                                    <td class='tdStyle_title active' style="width: 20%">物料名称</td>
                                    <td class='tdStyle_title active' style="width: 10%">构建编号</td>
                                    <td class='tdStyle_title active' style="width: 10%">规格</td>
                                    <td class='tdStyle_title active' style="width: 6%">方量</td>
                                    <td class='tdStyle_title active' style="width: 6%">重量</td>
                                    <td class='tdStyle_title active' style="width: 6%">砼标号</td>
                                    <td class='table_tr_print tdStyle_title active' style="width: 6%">质检员</td>
                                    <td class='table_tr_print tdStyle_title active' style='width: 6%'>打印数</td>
                                    <td class='table_tr_print tdStyle_title active' style="width: 5%;">操作</td>
                                </tr>
                                <tbody id="detailTableText">
                                </tbody>
                            </table>
                        </div>
                        <nav aria-label="Page navigation" style="margin-left:50%;width:80%;height:8%;" id="page">
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
                        <div id="pop_print" class="form-inline" style="width: 100%;height: 8%;margin: 0 auto">
                            <div class="form-group" style="width: 100%;">
                                <label for="qrcodestyles">选择一个样式：</label>
                                <select class="form-control" id="qrcodestyles" class="form-control"
                                        style="width: 15%;height: 30px;padding: 0"></select>
                                <button type="button" id="print_data"
                                        style="margin-left: 1%;height: 30px;padding: 0;font-size: 12px !important;width: 70px"
                                        class="btn btn-primary" onclick="checkdata(false)">打印数据
                                </button>
                                <button type="button" id="print_datas"
                                        style="margin-left: 1%;height: 30px;padding: 0;font-size: 12px !important;width: 70px"
                                        class="btn btn-primary" onclick="checkdata(true)">全部打印
                                </button>
                                <button type="button"
                                        style="margin-left: 1%;height: 30px;padding: 0;font-size: 12px !important;width: 70px"
                                        class="btn btn-primary"
                                        onclick="delDetailData()">批量删除
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer" style="text-align: center;height: 6%;padding: 10px">
                        <button type="button" class="btn btn-default"
                                style="height: 28px;width:70px;font-size: 12px !important;padding: 0;"
                                onclick="reset()">重置
                        </button>
                        <button type="button" id="save"
                                style="height: 28px;width:70px;font-size: 12px !important;padding: 0;"
                                class="save-btn btn btn-primary">保存
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!--打印主界面-->
        <div id="printArea" style="width:100%;height:100%;display: none">
        </div>
        <div class="gif" style="z-index: 999;">
            <img src="./img/loading.gif"/>
        </div>
    </div>
</div>
<script>
    let pop_pageCur = 1;    //弹框分页当前页
    let pop_pageDate = []
    let pop_pageAll = 1;  //弹框分页总页数
    let excelData = {}; //excel数据
    let jsonObj = [];   //plan数据
    let printsData = [] //打印的数据
    let print = false;  //是否显示打印勾选按钮
    let pageCur = 1;    //分页当前页
    let pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let plannumber = null; //
    let plan_i = 0;       //两个函数的绑定全选
    let det_i = 0;        //两个函数的绑定全选

    window.onload = getTableData(1);

    //打开弹窗
    function openPop() {
        $('#myModal').modal('show')
        $("#title_1").show();
        $("#title_2").hide();
        $("#pop_print").hide();
        $("#pop_input").show();
        $(".pop_footer").show();
        $('.table_tr_print').hide();
        $('#pop_query').hide();
        $('#inputDetail').show();
        getArchives();
        print = false;
    }

    //关闭弹窗
    function closePop() {
        $('#myModal').modal('hide')
        $("#detail_checkbok").prop("checked", false);
        $("#print_materialcode")
        $("#detailTableText td :checkbox").prop("checked", false);
        det_i = 0;
        reset();
    }

    $('#myModal').on('hidden.bs.modal', function (e) {
        location.reload()
    })

    //重置弹窗
    function reset() {
        $("#pop_planname").val('');
        $("#build").val('');
        $("#line").val('');
        $("#liner").val('');
        $("#plantime").val('');
        $('#excel-file').val('')
        $('#qc').val('')
        $("#detailTableText").html('')
        $('#pop_next').attr('disabled', true);
        $('#pop_pre').attr('disabled', true);
        $('#fist').attr('disabled', true);
        $('#last').attr('disabled', true);
        excelData = {};
    }

    //保存
    $('.save-btn').click(function () {
        if ($('#build').val() === '') {
            alert("请输入楼栋楼层！")
            return;
        }
        if ($('#qc option:selected').val() == 0) {
            alert('请选择质检员！');
            return;
        }
        if (Object.keys(excelData).length !== 0) {
            excelData.plan.qc = $('#qc option:selected').val();
            excelData.plan.build = $('#build').val();
            $.post("${pageContext.request.contextPath}/AddPlan", {str: JSON.stringify(excelData)}, function (result) {
                let jsonObject = JSON.parse(result)
                alert(jsonObject.message);
                if (jsonObject.flag) {
                    closePop();
                }
            })
        } else {
            alert('请上传excel！');
        }
    })

    $('.recover-btn').click(() => {
        reset();
    })

    //查询plan表数据
    function getTableData(newPage) {
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        let preproductid = $('#preproductid').val();
        let materialname = $('#materialname').val();
        // let printstate = $('#query_printstate').val();
        let line = $('#query_line').val();
        if (startDate !== '' && endDate !== '') {
            if (startDate > endDate) {
                alert("开始时间不能大于结束时间！");
                return;
            }
        }
        let obj = {
            'startDate': startDate,
            'endDate': endDate,
            'planname': planname,
            'materialcode': materialcode,
            'materialname': materialname,
            'preproductid': preproductid,
            // printstate: printstate,
            'line': line,
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
                if (res.data !== undefined) {
                    jsonObj = res.data;
                    updateTable(false);
                    $('#total').html(res.cnt + "条，共" + res.pageAll + "页");
                    $('#li_' + pageCur % 5).removeClass('active');
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

    function getPopData(newPage) {
        let materialcode = $('#print_materialcode').val();
        let preproductid = $('#print_preproductid').val();
        let materialname = $('#print_materialname').val();
        let line = $('#query_line').val();
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
            plannumber: plannumber,
            materialcode: materialcode,
            preproductid: preproductid,
            materialname: materialname,
            line: line,
            pageCur: newPage,
            pageMax: pageMax
        }, function (result) {
            result = JSON.parse(result);
            pop_pageDate = result.data;
            updateTable(true);
            // 重置查询为第一页
            // 重置总页数
            pop_pageAll = parseInt(result.pageAll);
            $('#total_d').html(result.cnt + "条，共" + result.pageAll + "页");
            $('#li_d' + newPage % 5).addClass('active');
            if (pop_pageCur % 5 !== newPage % 5) {
                $('#li_d' + pop_pageCur % 5).removeClass('active');
            }
            pop_pageCur = newPage;
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
                        $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(' + k + ')');
                    }
                }
            }
        });
    }


    //获取明细数据
    function getDetailData(plannumber_p, newPage) {
        plannumber = plannumber_p;
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
            'plannumber': plannumber_p,
            pageCur: newPage,
            pageMax: pageMax
        }, function (result) {
            result = JSON.parse(result);
            if (result.data !== undefined) {
                pop_pageDate = result.data;
                excelData.plan = jsonObj.find((item) => {
                    return item.plannumber == plannumber_p;
                });
                $('#print_build').val(excelData.plan.build);
                $('#print_line').val(excelData.plan.line);
                $('#print_liner').val(excelData.plan.liner);
                $('#updatedate').val(excelData.plan.updatedate);
                $('#print_plantime').val(excelData.plan.plantime);
                $('#print_planname').val(excelData.plan.planname);
                $('#myModal').modal('show')
                $("#title_1").hide();
                $("#title_2").show();
                $("#pop_print").show();
                $("#pop_input").hide();
                $('#page').show();
                $(".modal-footer").hide();
                getStyleList();
                $('.table_tr_print').show();
                $('#pop_query').show();
                $('#inputDetail').hide();
                print = true;
                updateTable(true);
                getFieldMap();
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


    //全选
    $("#plan_checkbok").on("click", function () {
        if (plan_i == 0) {
            //把所有复选框选中
            $("#planTableText td :checkbox").prop("checked", true);
            plan_i = 1;
        } else {
            $("#planTableText td :checkbox").prop("checked", false);
            plan_i = 0;
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

    function delDetailData(pid, fangliang) {
        let obj = [];
        if (pid === undefined) { //批量删除
            $('#detailTableText').find('input:checked').each(function () {
                obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，obj
            });
            if (obj.length === 0) {
                alert("请勾选！")
                return;
            }
            fangliang = 0;
            pop_pageDate.forEach((item) => {
                obj.forEach((val) => {
                    if (item.pid == val) {
                        fangliang += item.fangliang;
                    }
                })
            })
        } else {
            obj.push(pid);
        }
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        $.post("${pageContext.request.contextPath}/DeletePreProduct", {
            pids: JSON.stringify(obj),
            plannumber: excelData.plan.plannumber,
            fangliang: fangliang
        }, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getPopData(1);
            }
        });
    }

    //删除plan数据
    function delTableData(plannumber) {
        let obj = [];
        if (plannumber === undefined) { //批量删除
            $('#planTableText').find('input:checked').each(function () {
                obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
            });
            if (obj.length === 0) {
                alert("请勾选！")
                return;
            }
        } else {
            obj.push(plannumber);
        }
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }

        $.post("${pageContext.request.contextPath}/DeletePlan", {plannumbers: JSON.stringify(obj)}, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getTableData(1);
            }
        });
    }


    //更新表格
    function updateTable(detail) {
        let str = "";
        if (detail) {
            for (let i = 0; i < pop_pageDate.length; i++) {
                if (print) {
                    str += "<tr><td class='tdStyle_body' style='padding: 5px;'><input type='checkbox' data-id=" + pop_pageDate[i]["pid"] + "></td>"
                } else {
                    str += "<tr>"
                }
                str += "<td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['materialcode'] + "'>" + pop_pageDate[i]['materialcode'] +
                    "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['materialname'] + "'>" + pop_pageDate[i]['materialname'] +
                    "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['preproductid'] + "'>" + pop_pageDate[i]['preproductid'] +
                    "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['standard'] + "'>" + pop_pageDate[i]['standard'] +
                    "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['fangliang'] + "'>" + pop_pageDate[i]['fangliang'] +
                    "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['weigh'] + "'>" + pop_pageDate[i]['weigh'] +
                    "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['concretegrade'] + "'>" + pop_pageDate[i]['concretegrade'];
                if (print) {
                    str += "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['qc'] + "'>" + pop_pageDate[i]['qc'] +
                        "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['print'] + "'>" + pop_pageDate[i]['print'] +
                        "</td><td class='tdStyle_body' style='padding: 5px;'><a href='#' onclick='delDetailData(" + pop_pageDate[i]['pid'] + "," + pop_pageDate[i]['fangliang'] + ")'>删除</a>" +
                        "</td></tr>"
                } else {
                    str += "</td></tr>"
                }
            }
            $("#detailTableText").html(str);
        } else {
            for (let i = 0; i < jsonObj.length; i++) {
                let style = ''
                let state = ''
                if (jsonObj[i]['printstate'] !== 0) {
                    state = '已打印'
                    style = "style='background-color: rgb(0,176,80);padding: 5px;'"
                } else {
                    state = '打印中'
                    style = "style='background-color: red;padding: 5px;'"
                }
                str += "<tr><td class='tdStyle_body'><input type='checkbox' data-id=" + jsonObj[i]["plannumber"] + ">" +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plannumber'] + "'>" + jsonObj[i]['plannumber'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plannumber'] + "'>" + jsonObj[i]['planname'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['state'] + "'" + style + ">" + state +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plant'] + "'>" + jsonObj[i]['plant'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plantime'] + "'>" + jsonObj[i]['plantime'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['line'] + "'>" + jsonObj[i]['line'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['build'] + "'>" + jsonObj[i]['build'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['tasknum'] + "'>" + jsonObj[i]['tasknum'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['tasksqure'] + "'>" + jsonObj[i]['tasksqure'] +
                    "</td><td class='tdStyle_body'><a href='#' onclick='getDetailData(" + jsonObj[i]['plannumber'] + ',1' + ")'>详情</a></td></tr>";
            }
            $("#planTableText").html(str);
        }
        document.getElementById('plan_checkbok').checked = false
        plan_i = 0;
    }

    //给input标签绑定change事件，一上传选中的.xls文件就会触发该函数
    $('#excel-file').change(function (e) {
        let file = e.target.files[0];
        if (file === undefined) {
            return;
        }
        let name = file.name;
        //正则表达式，文件名为字母、数字或下划线，且不能为空。尾缀为.xls或.xlsx
        let pattern = /((\.xls)|(\.xlsx)){1}$/;
        if (!pattern.test(name)) {
            alert("请选择excel文件")
            return;
        }
        let reader = new FileReader();
        reader.onload = function (event) {
            let data = event.target.result;
            let workbook = XLSX.read(data, {type: 'binary'});
            excelData = outputWorkbook(workbook)
            if (excelData.preProduct.length === 0) {
                return
            }
            let str = '';
            let flag = excelData.preProduct.some((val, index) => {
                for (let i = index + 1; i < excelData.preProduct.length; i++) {
                    if (val.materialcode === excelData.preProduct[i].materialcode) {
                        str += val.materialcode;
                        return true;
                    }
                }
            })
            if (flag) {
                alert('物料编码：' + str + '重复');
                return;
            }
            $.post("${pageContext.request.contextPath}/CheckArchives", {
                    planname: excelData.plan.planname,
                    line: excelData.plan.line,
                    plant: excelData.plan.plant
                }, function (result) {
                    result = JSON.parse(result);
                    if (!result.flag) {
                        alert(result.message)
                        return
                    } else {
                        $.post("${pageContext.request.contextPath}/GetPreProductMaterialcode", null, function (result) {
                            result = JSON.parse(result);
                            excelData.preProduct.forEach((item) => {
                                result.data.forEach((res_item) => {
                                    if (item.materialcode.toString() === res_item.materialcode) {
                                        if (str === '') {
                                            str += item.materialcode
                                        } else {
                                            str += '，' + item.materialcode;
                                        }
                                    }
                                })
                            });
                        }).then(function () {
                            if (str !== '') {
                                excelData = {};
                                $('#excel-file').val('');
                                alert('物料编码：[' + str + ']已存在');
                                return;
                            }
                            $('#pop_planname').val(excelData.plan.planname);
                            $('#line').val(excelData.plan.line);
                            $('#plantime').val(excelData.plan.plantime);
                            $('#liner').val(excelData.plan.liner);
                            pop_count = Math.ceil(excelData.preProduct.length / 10);
                            // 重置查询为第一页
                            pop_pageCur = 1;
                            for (let i = 10 * (pop_pageCur - 1); i < 10 * (pop_pageCur) && i < excelData.preProduct.length; i++) {
                                pop_pageDate.push(excelData.preProduct[i]);
                            }
                            updateTable(true);
                            $('#total_d').html(excelData.preProduct.length + "条，共" + pop_count + "页");
                            $('#li_d1').addClass('active');
                            // 重置总页数
                            pop_pageAll = parseInt(pop_count);
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
                        });
                    }
                }
            )
        }
        reader.readAsBinaryString(file);
    });

    function getPlanName() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetDefaultQc",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    let data = res.data;
                    $('#qc').find("option[value=" + data[0].qc + "]").attr('selected', true);
                } else {
                    alert("产线默认质检员不存在！，请先在基础档案管理设置默认质检员信息")
                }
            },
            error: function () {
                alert("查询失败！")
            }
        });
    }

    function getDefaultQc() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetDefaultQc",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    let data = res.data;
                    $('#qc').find("option[value=" + data[0].qc + "]").attr('selected', true);
                } else {
                    alert("产线默认质检员不存在！，请先在基础档案管理设置默认质检员信息")
                }
            },
            error: function () {
                alert("查询失败！")
            }
        });
    }

    function getArchives() {
        let obj = {
            'pageCur': 1,
            'pageMax': 100
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetQc",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    let data = res.data;
                    let qc = document.getElementById("qc");
                    $('#qc').empty();
                    // qc.options.add(new Option('', 0));
                    for (let i = 0; i < data.length; i++) {
                        qc.options.add(new Option(data[i].qc, data[i].qc))
                    }
                } else {
                    alert("产线质检员不存在！，请先在基础档案管理录入质检员信息")
                }
            },
            error: function () {
                alert("查询失败！")
            }
        }).then(() => {
            getDefaultQc();
        });
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
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        let line = $('#query_line').val();
        if (startDate !== '' && endDate !== '') {
            if (startDate > endDate) {
                alert("开始时间不能大于结束时间！");
                return;
            }
        }
        let obj = {
            'startDate': startDate,
            'endDate': endDate,
            'planname': planname,
            'materialcode': materialcode,
            'line': line,
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
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        let line = $('#query_line').val();
        if (startDate !== '' && endDate !== '') {
            if (startDate > endDate) {
                alert("开始时间不能大于结束时间！");
                return;
            }
        }
        let obj = {
            'startDate': startDate,
            'endDate': endDate,
            'planname': planname,
            'materialcode': materialcode,
            'line': line,
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

    function jumpToNewPage2() {
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        let line = $('#query_line').val();
        var newPage = parseInt($('#jump_to').val());
        if (newPage == "" || isNaN(newPage))
            return;
        if (newPage > pageAll) {
            alert("超过最大页数")
            return;
        }
        if (startDate !== '' && endDate !== '') {
            if (startDate > endDate) {
                alert("开始时间不能大于结束时间！");
                return;
            }
        }
        let obj = {
            'startDate': startDate,
            'endDate': endDate,
            'planname': planname,
            'materialcode': materialcode,
            'line': line,
            'pageCur': parseInt(newPage),
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
                if (!print) {
                    for (let i = 10 * (newPage - 1); i < excelData.preProduct.length && i < 10 * newPage; i++) {
                        pop_pageDate.push(excelData.preProduct[i]);
                    }
                }
            }
        }
        if (newPageCode === 3) {
            if (pop_pageCur == pop_pageAll) {
                window.alert("已经在最后一页!");
                return
            } else {
                newPage = pop_pageCur + 1;
                if (!print) {
                    for (let i = 10 * (newPage - 1); i < excelData.preProduct.length && i < 10 * newPage; i++) {
                        pop_pageDate.push(excelData.preProduct[i]);
                    }
                }
            }
        }
        if (print) {
            let materialcode = $('#print_materialcode').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                plannumber: plannumber,
                materialcode: materialcode,
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
        } else {
            if (newPageCode === 3) {
                setFooter_d(3, pop_pageAll, pop_pageCur, newPage);
            }
            if (newPageCode === 2) {
                setFooter_d(2, pop_pageAll, pop_pageCur, newPage);
            }
            updateTable(true);
            pop_pageCur = newPage;
        }
    }

    function jumpToNewPage_d1(newPage) {
        pop_pageDate = []
        if (print) {
            let materialcode = $('#print_materialcode').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                plannumber: plannumber,
                materialcode: materialcode,
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
        } else {
            for (let i = 10 * (newPage - 1); i < excelData.preProduct.length && i < 10 * newPage; i++) {
                pop_pageDate.push(excelData.preProduct[i]);
            }
            updateTable(true);
            $('#li_d' + newPage % 5).addClass('active');
            $('#li_d' + pop_pageCur % 5).removeClass('active');
            pop_pageCur = newPage;
        }
    }

    function jumpToNewPage_d2() {
        pop_pageDate = []
        var newPage = $('#jump_to_d').val();
        if (newPage > pop_pageAll) {
            alert("超过最大页数")
            return
        }
        if (print) {
            let materialcode = $('#print_materialcode').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                plannumber: plannumber,
                materialcode: materialcode,
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
                    updateTable(true);
                    // pop_pageCur = newPage;
                    jump_d2(newPage, pop_pageAll);
                }
            });
        } else {
            for (let i = 10 * (newPage - 1); i < excelData.preProduct.length && i < 10 * newPage; i++) {
                pop_pageDate.push(excelData.preProduct[i]);
            }
            updateTable(true);
            jump_d2(newPage, pop_pageAll);
            pop_pageCur = newPage;
        }
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
            $('#li_d' + pop_pageCur % 5).removeClass('active');
            $('#li_d' + newPage % 5).addClass('active');
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
            $('#li_d' + pop_pageCur % 5).removeClass('active');
            $('#li_d' + newPage % 5).addClass('active');
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

    // 二维码样式
    let qrstyle = {}
    // 字段映射
    let fieldmap = {}

    // 获取所有样式并放入select
    function getStyleList() {
        let fieldNames = {
            qrcode_id: "INT",
            qrcode_name: "STRING"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select qrcode_id, qrcode_name from qrcode where qrcode_status=1;",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                let jsonobj = JSON.parse(res.data);
                let qrcodestyles = document.getElementById("qrcodestyles")
                $('#qrcodestyles').empty();
                qrcodestyles.options.add(new Option('', 0));
                for (let i = 0; i < jsonobj.length; i++) {
                    qrcodestyles.options.add(new Option(jsonobj[i].qrcode_name, jsonobj[i].qrcode_id))
                }
                // 测试
                //getStyle()
            },
            error: function (message) {
                (message)
            }
        })
    }

    //检查数据并打印
    function checkdata(isAll) {
        if ($("#qrcodestyles option:selected").val() === '0') {
            alert("请选择一个样式！");
            return;
        }
        let pids = []
        if (!isAll) {
            $('#detailTableText').find('input:checked').each(function () {
                pids.push({pid: $(this).attr('data-id')});   //找到对应checkbox中data-id属性值，然后push给空数组pids
            });
            if (pids.length === 0) {
                alert("请勾选！");
                return;
            }
            pids.forEach((val) => {
                printsData.push(pop_pageDate.find((item) => {
                    return item.pid == val.pid;
                }));
            });
            let str = ''
            //打印信息添加计划信息
            printsData.forEach((item, index) => {
                printsData[index] = Object.assign(item, excelData.plan);
                if (item.print > 0) {
                    str += item.preproductid + '，';
                }
            })
            if (str !== '') {
                let r = confirm("亲，构建编号：" + str + " 已经打印过，确定重复打印？");
                if (r === false) {
                    printsData = [];
                    return;
                }
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/PrintPreProduct",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: {
                    productIds: JSON.stringify(pids),
                    plannumber: printsData[0].plannumber,
                    tasknum: printsData[0].tasknum
                },
                success: function (res) {
                    if (res.flag) {
                        getStyle()
                    } else {
                        alert("打印失败！")
                    }
                },
            })
        } else {
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                plannumber: plannumber,
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    printsData = result.data;
                }
            }).then(() => {
                for (let i = 0; i < printsData.length; i++) {
                    pids.push({pid: printsData[i].pid})
                }
                if (pids.length === 0) {
                    alert("暂无打印数据");
                    return;
                }
                let str = ''

                printsData.forEach((item, index) => {
                    printsData[index] = Object.assign(item, excelData.plan);
                    if (item.print > 0) {
                        str += item.preproductid + '，';
                    }
                })
                if (str !== '') {
                    let r = confirm("亲，构建编号：" + str + " 已经打印过，确定重复打印？");
                    if (r === false) {
                        printsData = [];
                        return;
                    }
                }
                $.ajax({
                    url: "${pageContext.request.contextPath}/PrintPreProduct",
                    type: 'post',
                    dataType: 'json',
                    contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                    data: {
                        productIds: JSON.stringify(pids),
                        plannumber: printsData[0].plannumber,
                        tasknum: printsData[0].tasknum
                    },
                    success: function (res) {
                        if (res.flag) {
                            getStyle()
                        } else {
                            alert("打印失败！")
                        }
                    },
                })
            });
        }
    }

    // 获取样式
    function getStyle() {
        for (let i = 0; i < printsData.length; i++) {
            printsData[i].print = printsData[i].print + 1;
        }
        // 把样式设定为目前选中的样式
        let qrcodeid = $("#qrcodestyles :selected").val()
        if (qrcodeid === '0') {
            return
        }
        let fieldNames = {
            qrcode_content: "STRING"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select qrcode_content from qrcode where qrcode_id=" + qrcodeid + ";",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                let datatmp = JSON.parse(res.data)[0]
                if (datatmp.qrcode_content == undefined) {
                    alert("请设置二维码内容");
                    return
                }
                qrstyle = JSON.parse(datatmp.qrcode_content)
                $(".gif").css("display", "flex");
                printData()
            },
            error: function (message) {
            }
        })

    }

    // 获取字段映射
    function getFieldMap() {
        let fieldNames = {
            pi_key: "STRING",
            pi_value: "STRING"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select pi_key,pi_value from project_item;",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                let jsonobj = JSON.parse(res.data)
                for (let i = 0; i < jsonobj.length; i++) {
                    fieldmap[jsonobj[i].pi_key] = jsonobj[i].pi_value
                }
            }
        })
    }


    //设置打印内容
    function printData() {
        let startStr = "<!--startprint-->"
        let endStr = "<!--endprint-->"
        // 获取样式中的长宽
        let xsize = qrstyle.xsize
        let ysize = qrstyle.ysize
        let startitem = $(startStr)
        $("#printArea").empty()
        $("#printArea").append(startitem)
        for (let i = 0; i < printsData.length; i++) {
            //二维码设置
            let qrCode = {}
            qrCode.qr_wh_value = qrstyle.qRCode.qr_wh_value
            qrCode.qrcodeContent = 'https://mes.ljzggroup.com/DuiMa/ToView?code=' + printsData[i].materialcode + '&id=' + $("#qrcodestyles :selected").val()
            // 已判断是否都已获取
            // 先填充内容，后设置位置
            let item_draw = "<div id='draw" + i + "' style='page-break-after:always;position:relative;width:" + xsize + "px;height:" + ysize + "px;'></div>"
            $("#printArea").append($(item_draw))
            $("#printArea").append($("<div class=\"gif\" style=\"z-index: 999;display: flex\">\n" +
                "            <img src=\"./img/loading.gif\"/>\n" +
                "        </div>"))
            // start
            // 放置二维码,后续需要往里面填充内容
            let xsituation = qrstyle.qRCode['xsituation']
            let ysituation = qrstyle.qRCode['ysituation']
            let qr_wh_value = qrstyle.qRCode['qr_wh_value']
            let horizontal_offset = qrstyle.qRCode['horizontal_offset']
            let transform = horizontal_offset !== "0" && horizontal_offset !== "" ? 'transform: rotate(180deg);' : ''
            let item_text = "<span class='pStyle draw' style='position: absolute;font-size: 21px;" + transform + "left:" + qrstyle.qRCode.textXsituation + "px;top: " + qrstyle.qRCode.textYsituation + "px;font-weight: bold' draggable='true' id='draw_text_" + i + "'>" + qrstyle.qRCode['text'] + "</span>";
            $("#draw" + i).append($(item_text))
            let item_qrcode = "<div id='qrcode_" + i + "' style='position: absolute;" + transform + "left:" + xsituation + "px;top:" + ysituation + "px;height:" + qr_wh_value + "px;'></div>"
            $("#draw" + i).append($(item_qrcode))
            // 放置其他各项
            for (let j = 0; j < qrstyle.items.length; j++) {
                let node = qrstyle.items[j]
                let nodevalue = node.content;
                let xsituation_item = node.xsituation
                let ysituation_item = node.ysituation
                let nodestr = fieldmap[nodevalue] + ":" + printsData[i][nodevalue]
                let item = $("<span class='pStyle' id = 'draw_" + i + "_" + (j + 1) + "' style='position: absolute;" + transform + "font-size: " + qrstyle.qRCode.font_style_value + ";left:" + xsituation_item + "px;top:" + ysituation_item + "px;'></span>").text(nodestr)
                $("#draw" + i).append(item)
            }
            //另一份二维码
            if (horizontal_offset !== "0" && horizontal_offset !== "") {
                let other = ''
                let textYsituation = parseInt(qrstyle.qRCode.textYsituation) + parseInt(horizontal_offset)
                let ysituation = parseInt(qrstyle.qRCode.ysituation) + parseInt(horizontal_offset)
                other += "<span class='pStyle draw' style='position: absolute;font-size: 21px;left:" + qrstyle.qRCode.textXsituation + "px;top: " + textYsituation + "px;font-weight: bold' draggable='true' id='draw_text_h'>" + qrstyle.qRCode['text'] + "</span>";
                other += "<div id='qrcode_h" + i + "' style='position: absolute;left:" + xsituation + "px;top:" + ysituation + "px;'></div>"
                // 放置其他各项
                for (let j = 0; j < qrstyle.items.length; j++) {
                    let node = qrstyle.items[j]
                    let nodevalue = node.content;
                    let xsituation_item = node.xsituation
                    let ysituation_item = parseInt(node.ysituation) + parseInt(horizontal_offset)
                    let nodestr = fieldmap[nodevalue] + ":" + printsData[i][nodevalue]
                    other += "<span class='pStyle' style='position: absolute;font-size: " + qrstyle.qRCode.font_style_value + ";left:" + xsituation_item + "px;top:" + ysituation_item + "px;'>" + nodestr + "</span>"
                }
                $("#draw" + i).append($(other))
            }
            // end
            // let newItem = $(item)
            // $("#printArea").append(newItem)
            // 设置二维码内容
            // let qrcodeContent = ""
            // let tmp = qrstyle.qRCode.qRCodeContent
            // for (let j = 0; j < tmp.length; j++) {
            //     qrcodeContent += fieldmap[tmp[j]] + ":" + printsData[i][tmp[j]] + "\n"
            // }

            // getQRCode(i, qrstyle.qRCode)
            QrCode.push({id: i, qRCode: qrCode})
            QrCode.push({id: 'h' + i, qRCode: qrCode})
            qrstyle.qr_wh_value = qr_wh_value
        }
        let enditem = $(endStr)
        $("#printArea").append(enditem)
        setTimeout("printLabels()", 500)
    }

    function set(j, length, qr_wh_value) {
        let bottom = 0
        let width = 0;
        let item_offsetWidth
        for (let i = 1; i <= length; i++) {
            let item = document.getElementById("draw_" + j + "_" + i);
            let offsetHeight = item.offsetHeight;
            let offsetWidth = item.offsetWidth
            let left = parseInt(item.style.left.match(/(\d+)px/)[1])
            let top = parseInt(item.style.top.match(/(\d+)px/)[1])
            //获取单个页面最下端
            if (top + offsetHeight > bottom) {
                bottom = top + offsetHeight
            }
            //获取单个页面最右端
            if (offsetWidth + left >= width) {
                width = offsetWidth + left
                item_offsetWidth = offsetWidth
            }
        }
        let draw0 = document.getElementById("qrcode_" + j);
        let draw0_left = parseInt(draw0.style.left.match(/(\d+)px/)[1])
        let draw0_width = parseInt(qr_wh_value)
        let draw0_top = parseInt(draw0.style.top.match(/(\d+)px/)[1])
        let draw0_offsetHeight = parseInt(draw0.style.height.match(/(\d+)px/)[1])
        if (draw0_top + draw0_offsetHeight > bottom) {
            bottom = draw0_top + draw0_offsetHeight
        }
        let draw_text = document.getElementById("draw_text_" + j);
        let draw_text_top = parseInt(draw_text.style.top.match(/(\d+)px/)[1])
        let draw_text_left = parseInt(draw_text.style.left.match(/(\d+)px/)[1])
        let draw_text_offsetHeight = draw_text.offsetHeight
        let draw_text_offsetWidth = draw_text.offsetWidth
        if (draw_text_left + draw_text_offsetWidth > width) {
            width = draw_text_offsetWidth + draw_text_left
        }
        let text_for_draw0_width = parseInt(draw_text.style.left.match(/(\d+)px/)[1]) - draw0_left //标题与二维码里最左边的距离
        //设置标题选择后的位置水平
        draw_text.style.left = width - text_for_draw0_width - draw_text.offsetWidth + "px"
        //设置标题高度用于旋转
        draw_text.style.height = bottom - draw_text_top + (draw0_top - draw_text_top - draw_text_offsetHeight) + draw_text_offsetHeight - 5 + "px"
        draw0.style.width = width - parseInt(draw0.style.left.match(/(\d+)px/)[1]) + "px"
        for (let i = 1; i <= length; i++) {
            let item = document.getElementById("draw_" + j + "_" + i)
            let item_left = parseInt(item.style.left.match(/(\d+)px/)[1])
            let item_top = parseInt(item.style.top.match(/(\d+)px/)[1])
            let item_height = item.offsetHeight
            let item_void = (item_left - draw0_left - draw0_width) //标签与二维码之间的空隙
            let item_t_void = item_top - draw_text_top - draw_text_offsetHeight //标签与标题的距离
            if (item_left > draw0_left + draw0_width) { //如果标签在二维码右侧，则标签向左平移
                item.style.left = width - draw0_width - item.offsetWidth - item_void + "px"
            } else { //否则标签宽度对于二维码宽度，用于选择
                item.style.width = draw0.style.width
            }
            //重新设置到标题的距离
            item.style.top = draw_text_top + parseInt(draw_text.style.height.match(/(\d+)px/)[1]) - item_t_void - draw_text_offsetHeight - item_height + "px"
        }
    }

    let QrCode = []

    //生成二维码
    function getQRCode(idx, qRCode) {
        jQuery('#qrcode_' + idx).qrcode({
            // new QRCode(document.getElementById("qrcode_" + idx), {
            render: "canvas",
            text: qRCode.qrcodeContent,
            width: qRCode.qr_wh_value,
            height: qRCode.qr_wh_value,
            colorDark: "#000000",
            colorLight: "#ffffff",
            src: './img/qr.jpg'
            // correctLevel: QRCode.CorrectLevel.H
        })
    }

    // 打印标签
    function printLabels() {
        let bdhtml = window.document.body.innerHTML;
        let sprnstr = "<!--startprint-->";
        let eprnstr = "<!--endprint-->";
        let prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        for (let obj of QrCode) {
            getQRCode(obj.id, obj.qRCode)
        }
        if (qrstyle.qRCode['horizontal_offset'] !== '0' && qrstyle.qRCode['horizontal_offset'] !== '') {
            for (let i = 0; i < QrCode.length / 2; i++) {
                set(i, qrstyle.items.length, qrstyle.qr_wh_value)
            }
        }
        setTimeout(() => {
                $(".gif").css("display", "none");
                window.print()
                window.document.body.innerHTML = bdhtml;
                location.reload();
                printsData = []
                QrCode = []
            }, 500
        )
    }


</script>
<style>
    /*.table > tbody > tr > td,*/
    /*.table > tbody > tr > th,*/
    /*.table > tfoot > tr > td,*/
    /*.table > tfoot > tr > th,*/
    /*.table > thead > tr > td,*/
    /*.table > thead > tr > th {*/
    /*    padding: 5px;*/
    /*}*/
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
