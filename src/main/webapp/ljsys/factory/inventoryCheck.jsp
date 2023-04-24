<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:89%;height:16%;margin-left: 8%;padding-top:2%">
        <div class="form-group" style="width: 20%;">
            <label>盘库批次号：</label>
            <input style="height:34%;width: 68%" name="batch_id"
                   id="batch_id"
                   class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%;">
            <label>制单人：</label><input type="text" id="user_name"
                                      style="height:34%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 40%;">
            <label for="startDate" style="margin-left: 3%">操作日期从：</label>
            <input id="startDate" class="form-control" type="date" style="width: 30%;height: 30px">
            <label for="endDate" style="margin-left: 2%">至：</label>
            <input id="endDate" class="form-control" type="date" style="width: 30%;height: 30px">
        </div>
        <br><br>
        <div class="form-group" style="margin-left:3%;width: 20%">
            <label>状态：</label>
            <select type="text" id="isOrder"
                    style="height:34%;width: 68%" class="form-control">
                <option value=""></option>
                <option value="true">已生成</option>
                <option value="false">未生成</option>
            </select>
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%;"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:85%;height:78%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>盘库单信息</small></h3>
            <button type="button" onclick="openPop()" style="position: absolute;right: 9%;top:16%;width: 60px"
                    class="btn btn-primary btn-sm">
                新&nbsp;&nbsp;增
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" cellspacing="0" cellpadding="0" width="100%" align="center">
                <tr>
                    <%--                    <td class='tdStyle_title active' style="width: 2%"><input--%>
                    <%--                            id="checkbok"--%>
                    <%--                            type="checkbox"></td>--%>
                    <td class='tdStyle_title  active' style="width: 10%">盘库批次号</td>
                    <td class='tdStyle_title active' style="width: 10%">创建日期</td>
                    <td class='tdStyle_title active' style="width: 10%">制单人</td>
                    <td class='tdStyle_title active' style="width: 10%">应盘数量（个）</td>
                    <td class='tdStyle_title active' style="width: 10%">已盘数量（个）</td>
                    <td class='tdStyle_title active' style="width: 10%">状态</td>
                    <td class='tdStyle_title active' style="width: 10%">操作</td>
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
                    <div>
                        <div name="query" id="pop_query" class="form-inline" style="width: 100%;height: 8%">
                            <div class="form-group" style="width: 100%;">
                                <label>堆场信息：</label>
                                <input style="height:30px;width: 15%" name="factoryName"
                                       id="factoryName"
                                       onclick="openPop1()" class="form-control">
                                <label for="planname" style="margin-left: 1%">项目名称：</label>
                                <select id="planname" class="form-control" style="width: 15%;height: 30px"></select>
                                <label for="build_type" style="margin-left: 1%">构建类型：</label>
                                <input id="build_type" class="form-control" style="width: 15%;height: 30px">
                                <button id="pop_query_button" class="btn btn-primary" onclick="getDetailData(1)"
                                        style="margin-left:3%;height: 30px;padding: 0 10px">查&nbsp;&nbsp;询
                                </button>
                            </div>
                        </div>
                    </div>

                    <div name="query" id="pop_query1" class="form-inline" style="width: 100%;height: 16%">
                        <div class="form-group" style="width: 100%;">
                            <label>堆场信息：</label>
                            <input style="height:30px;width: 15%" name="factoryName1"
                                   id="factoryName1" disabled class="form-control">
                            <label for="planname1" style="margin-left: 1%">项目名称：</label>
                            <input id="planname1" disabled class="form-control" style="width: 15%;height: 30px">
                            <label for="build_type1" style="margin-left: 1%">构建类型：</label>
                            <input id="build_type1" disabled class="form-control"
                                   style="width: 15%;height: 30px">
                            <button id="pop_query_button1" class="btn btn-primary"
                                    onclick="getCheckData('should_check')"
                                    style="margin-left:3%;height: 30px;padding: 0 10px">应盘构件：0个
                            </button>
                            <button id="pop_query_button2" class="btn btn-primary" onclick="getCheckData('real_check')"
                                    style="margin-left:3%;height: 30px;padding: 0 10px">实盘构件：0个
                            </button>
                            <button id="pop_query_button3" class="btn btn-primary" onclick="getCheckData('leak_check')"
                                    style="margin-left:3%;height: 30px;padding: 0 10px">漏盘构件：0个
                            </button>
                            <br><br>
                            <label style="margin-left: 1%">制单人：</label>
                            <input style="height:30px;width: 15%" disabled name="user_name1"
                                   id="user_name1" class="form-control">
                            <label for="batch_id1" style="margin-left: 1%">批 次 号 ：</label>
                            <input id="batch_id1" disabled class="form-control" style="width: 15%;height: 30px">
                            <label for="create_time1" style="margin-left: 1%">创建日期：</label>
                            <input id="create_time1" disabled class="form-control" style="width: 15%;height: 30px">

                            <button id="pop_query_button4" class="btn btn-primary" onclick="getCheckData('full_check')"
                                    style="margin-left:3%;height: 30px;padding: 0 10px">盈盘构件：0个
                            </button>
                            <button id="pop_query_button5" class="btn btn-primary" onclick="finish()"
                                    style="margin-left:3%;height: 30px;padding: 0 10px">盘库结束
                            </button>
                        </div>
                    </div>
                    <div style="height: 80%;">
                        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
                            <h3 style="margin-bottom: 0;margin-top: 0" id="inputDetail"><small id="small">构建信息</small>
                            </h3>
                        </div>
                        <table class="table table-hover" style="text-align: center;">
                            <tr id="table_tr">
                                <%--                                <td class='tdStyle_title active' style="width: 2%"><input--%>
                                <%--                                        id="detail_checkbok"--%>
                                <%--                                        type="checkbox"></td>--%>
                                <td class='tdStyle_title active' style="width: 10%">物料编码</td>
                                <td class='tdStyle_title active' style="width: 10%">物料名称</td>
                                <td class='tdStyle_title active' style="width: 10%">图号</td>
                                <td class='tdStyle_title active' style="width: 10%">项目名称</td>
                                <td class='tdStyle_title active' style="width: 10%">类型</td>
                                <td class='tdStyle_title active' style="width: 10%">仓库</td>
                                <td class='tdStyle_title active' style="width: 10%">楼栋</td>
                                <td class='tdStyle_title active' style="width: 10%">楼层</td>
                                <td class='tdStyle_title active remark' style="width: 10%">备注</td>
                                <td class='tdStyle_title active real' style="width: 10%">操作人</td>
                                <td class='tdStyle_title active real' style="width: 10%">操作时间</td>
                                <td class='tdStyle_title active detail_action' style="width: 10%">操作</td>

                            </tr>
                            <tbody id="detailTableText">
                            </tbody>
                        </table>
                    </div>
                    <div style="display: flex;width: 100%; justify-content: space-between;">
                        <div class="form-inline" style="width: 30%;">
                            <%--                            <label for="select">入库方式:</label>--%>
                            <%--                            <select id="select" class="form-control" style="width: 60%"></select>--%>
                        </div>
                        <button type="button" id="inventorySave" style="height:10%;width: 100px"
                                onclick="inventorySave()"
                                class="btn btn-primary btn-sm">保 存
                        </button>
                        <button type="button" id="export" style="height:10%;width: 100px" onclick="exportData()"
                                class="btn btn-primary btn-sm">导出数据
                        </button>
                        <nav aria-label="Page navigation" style="width:50%;height:10%;" id="page">
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
    <div class="modal fade" id="myModal4" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModal_title">选择货位信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="margin-top: 5%">
                            <label for="myModal_name1" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">堆场信息:</label>
                            <select class="form-control" style="width:50%;" id="myModal_name1"
                                    name="myModal_name1" onchange="getRegionData()"></select><br>
                            <label for="myModal_name2" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">区域信息:</label>
                            <select class="form-control" style="width:50%;" id="myModal_name2"
                                    name="myModal_name2" onchange="getLocation()"></select><br>
                            <label for="location" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">货位信息:</label>
                            <select type="text" class="form-control" style="width:50%;" id="location"
                                    name="location" onchange="setLocation()"></select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" id="myModal_save" onclick="save()" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal5" tabindex="-1" style="position: absolute;left: 15%;top: 15%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">备注信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="margin-top: 5%">
                            <label for="myModal_name1" style="width: 25%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">备注:</label>
                            <input class="form-control" style="width:60%;" id="myModal_name5"
                                   name="myModal_name1">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" id="myModal_save5" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        let pageCur = 1;
        let pageAll = 1;
        let pageMax = 10;   //一页多少条数据
        let jsonObj = [];
        let pop_pageDate = []
        let pop_pageCur = 1;
        let check_id = ''
        let check_type = ''
        let allData = []

        window.onload = getYardData();

        $('#myModal').on('hidden.bs.modal', function (e) {
            $('#li_d' + pop_pageCur % 5).removeClass('active');
            pop_pageDate = []
            pop_pageCur = 1
            check_id = ''
            check_type = ''
            $("#factoryName").val('')
            $("#planname").val('')
            $("#build_type").val('')
        })

        function openPop1() {
            $('#myModal4').modal('show')
        }

        function save() {
            let myModal_name1 = $("#myModal_name1 option:selected").text() ? $("#myModal_name1 option:selected").text() + '/' : '../'
            let myModal_name2 = $("#myModal_name2 option:selected").text() ? $("#myModal_name2 option:selected").text() + '/' : '../'
            let myModal_name3 = $("#location option:selected").text() ? $("#location option:selected").text() : '..'
            let str
            if (myModal_name1 === '' && myModal_name2 === '' && myModal_name3 === '') {
                str = ''
            } else {
                str = myModal_name1 + myModal_name2 + myModal_name3
            }
            $("#factoryName").val(str)
            $('#myModal4').modal('hide')
        }

        function GetPlanName() {
            $.ajax({
                url: "${pageContext.request.contextPath}/GetPlanName",
                type: 'post',
                dataType: 'json',
                data: {
                    'pageCur': 1,
                    'pageMax': 999
                },
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    $('#planname').empty()
                    $('#planname').append($("<option value=''></option>"))
                    if (res.data.length !== 0) {
                        for (let v of res.data) {
                            let item = $("<option value='" + v['id'] + "'>" + v['planname'] + "</option>")
                            $('#planname').append(item)
                        }
                    }
                }
            })
        }

        function exportData() {
            const data = [
                ["序号", "物料编码", "名称"],
                [101, 10001, "第一个"],
                [102, 10002, "第二个"]
            ]
            // 定义工作演
            const worksheet = XLSX.utils.aoa_to_sheet(data)
            // 定义工作名称
            const workbook = XLSX.utils.book_new()
            XLSX.utils.book_append_sheet(workbook, worksheet, 'sheet1')
            // 导出Excel文件
            XLSX.writeFile(workbook, 'yourfile.xlsx')

            return
            let obj = {
                check_id: check_id,
                check_type: check_type,
                type: '4',
                pageCur: 1,
                pageMax: 9999
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InventoryCheck",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (result) {

                }
            })
        }

        function inventorySave() {
            if (!allData.length) {
                alert("查询数据不能为空")
                return
            }
            let location = $('#location option:selected').val();
            let name = null;
            let myModal_name1 = $('#myModal_name1 option:selected').val()
            let myModal_name2 = $('#myModal_name2 option:selected').val()
            if (myModal_name1) {
                name = myModal_name1
            }
            if (myModal_name2) {
                name = myModal_name2
            }
            if (location) {
                name = location
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InventoryCheck",
                type: 'post',
                dataType: 'json',
                data: {
                    materialcodes: JSON.stringify(allData),
                    warehouse_id: name,
                    planname_id: $("#planname option:selected").val(),
                    build_type: $("#build_type").val(),
                    user_name: sessionStorage.getItem("userName"),
                    type: '1'
                },
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (result) {
                    alert(result.msg)
                    if (result.flag) {
                        $('#myModal').modal('hide');
                        getTableData(1)
                    }
                }
            })
        }


        function getYardData() {
            $.post("${pageContext.request.contextPath}/GetFactory", {
                type: '1',
                pageCur: '1',
                pageMax: '999'
            }, function (result) {
                getTableData(1)
                result = JSON.parse(result);
                let yard = result.data
                $('#myModal_name1').empty()
                $('#myModal_name1').append($("<option value=''></option>"))
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#myModal_name1').append(item)
                }
                $('#myModal3_name1').empty()
                $('#myModal3_name1').append($("<option value=''></option>"))
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#myModal3_name1').append(item)
                }
            })
        }

        function getYardDataPop() {
            $.post("${pageContext.request.contextPath}/GetFactory", {
                type: '1',
                pageCur: '1',
                pageMax: '999'
            }, function (result) {
                result = JSON.parse(result);
                let yard = result.data
                $('#myModal3_name1').empty()
                $('#myModal3_name1').append($("<option value=''></option>"))
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#myModal3_name1').append(item)
                }
            })
        }

        function getRegionData() {
            let pid = $('#myModal_name1 option:selected').val()
            if (pid === "") {
                $('#myModal_name2').empty()
                $('#location').empty()
                return
            }
            $.post("${pageContext.request.contextPath}/GetFactory", {
                type: '2',
                pid: pid,
                pageCur: '1',
                pageMax: '999'
            }, function (result) {
                result = JSON.parse(result);
                let yard = result.data
                $('#myModal_name2').empty()
                $('#myModal_name2').append($("<option value=''></option>"))
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#myModal_name2').append(item)
                }
                $('#myModal3_name1').val(pid)
                $('#myModal3_name2').empty()
                $('#myModal3_name2').append($("<option value=''></option>"))
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#myModal3_name2').append(item)
                }
            })
        }

        function getRegionDataPop() {
            let pid = $('#myModal3_name1').val()
            $('#myModal3_name3').empty()
            $('#myModal3_name2').empty()
            $.post("${pageContext.request.contextPath}/GetFactory", {
                type: '2',
                pid: pid,
                pageCur: '1',
                pageMax: '999'
            }, function (result) {
                result = JSON.parse(result);
                let yard = result.data
                $('#myModal3_name2').empty()
                $('#myModal3_name2').append($("<option value=''></option>"))
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#myModal3_name2').append(item)
                }
            })
        }

        function getLocation() {
            let pid = $('#myModal_name2 option:selected').val()
            $('#location').empty()
            $.post("${pageContext.request.contextPath}/GetFactory", {
                type: '3',
                pid: pid,
                pageCur: '1',
                pageMax: '999'
            }, function (result) {
                result = JSON.parse(result);
                let yard = result.data
                $('#location').empty()
                $('#location').append($("<option value=''></option>"))
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#location').append(item)
                }
                $('#myModal3_name3').empty()
                $('#myModal3_name3').append($("<option value=''></option>"))
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#myModal3_name3').append(item)
                }
                $('#myModal3_name2').val(pid)
            })
        }

        function getLocationPop() {
            let pid = $('#myModal3_name2').val()
            $('#myModal3_name3').empty()
            $.post("${pageContext.request.contextPath}/GetFactory", {
                type: '3',
                pid: pid,
                pageCur: '1',
                pageMax: '999'
            }, function (result) {
                result = JSON.parse(result);
                let yard = result.data
                if (yard.length == 0) {
                    $('#myModal3_name3').empty()
                }
                for (let o of yard) {
                    let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                    $('#myModal3_name3').append(item)
                }
            })
        }

        function setLocation() {
            $('#myModal3_name3').val($('#location option:selected').val())
        }

        function getTableData(newPage) {
            let batch_id = $('#batch_id').val();
            let user_name = $('#user_name').val();
            let startDate = $('#startDate').val();
            let endDate = $('#endDate').val();
            let obj = {
                batch_id: batch_id,
                user_name: user_name,
                type: '0',
                startDate: startDate,
                endDate: endDate,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InventoryCheck",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res !== undefined) {
                        jsonObj = res.data;
                        updateTable(true);
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
                        updateTable(true);
                    }
                },
                error: function () {
                    jsonObj = [];
                    updateTable(true);
                    alert("查询失败！")
                }
            })
        }


        $('#myModal2').on('hidden.bs.modal', function (e) {
            $('#myModal2_name1').empty()
            // pop_pageDate = []
            // pop_pageCur = 1
        })

        // $('#myModal3').on('hidden.bs.modal', function (e) {
        //     $('#myModal3_name1').empty()
        //     $('#myModal3_name2').empty()
        //     $('#myModal3_name3').empty()
        // })

        let det_i = 0
        let main_i = 0
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

        $("#checkbok").on("click", function () {
            if (main_i == 0) {
                //把所有复选框选中
                $("#archTableText td :checkbox").prop("checked", true);
                main_i = 1;
            } else {
                $("#archTableText td :checkbox").prop("checked", false);
                main_i = 0;
            }

        });

        function openPop(id) {
            $('#myModal').modal('show')
            if (!id) {
                getDetailData(1)
                GetPlanName()
                type = 1
                $("#pop_query").show();
                $("#pop_query1").hide()
                $("#inventorySave").show()
                $("#export").hide()
                $(".real").hide()
                $(".remark").hide()
                $(".detail_action").hide()
            } else {
                type = 2
                $("#pop_query").hide();
                $("#pop_query1").show()
                $("#inventorySave").hide()
                $("#export").show()
                $(".real").hide()
                $(".remark").hide()
                $(".detail_action").hide()
                check_id = id
                getCheckData('should_check')
            }

        }

        function finish() {
            $.post("${pageContext.request.contextPath}/InventoryCheck", {
                type: '7',
                check_id: check_id,
            }, function (result) {
                result = JSON.parse(result);
                alert(result.msg)
                if (result.flag) {
                    $("#myModal").modal('hide')
                    getTableData(1)
                }
            })
        }

        function getCheckData(type) {
            check_type = type
            if (type === 'should_check') {
                document.getElementById("small").innerText = '应盘构件信息'
                $(".remark").hide()
                $(".real").hide()
                $(".detail_action").hide()
            }
            if (type === 'real_check') {
                document.getElementById("small").innerText = '实盘构件信息'
                $(".remark").hide()
                $(".real").show()
                $(".detail_action").show()
            }
            if (type === 'leak_check') {
                document.getElementById("small").innerText = '漏盘构件信息'
                $(".remark").show()
                $(".real").hide()
                $(".detail_action").show()
            }
            if (type === 'full_check') {
                document.getElementById("small").innerText = '盈盘构件信息'
                $(".remark").show()
                $(".real").hide()
                $(".detail_action").show()
            }

            let obj = {
                check_id: check_id,
                check_type: check_type,
                type: '4',
                pageCur: pop_pageCur,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InventoryCheck",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (result) {
                    $('#li_d' + pop_pageCur % 5).removeClass('active');
                    $("#planname1").val(result.planname || '')
                    $("#factoryName1").val(result.path || '')
                    $("#build_type1").val(result.build_type || '')
                    $("#user_name1").val(result.user_name || '')
                    $("#batch_id1").val(result.batch_id || '')
                    $("#create_time1").val(result.create_time || '')
                    document.getElementById("pop_query_button1").innerText = "应盘构件：" + (result.should_check_num || 0) + "个"
                    document.getElementById("pop_query_button2").innerText = "实盘构件：" + (result.real_check_num || 0) + "个"
                    let num1 = result.should_check_num - result.real_check_num
                    document.getElementById("pop_query_button3").innerText = "漏盘构件：" + (num1 > 0 ? num1 : 0) + "个"
                    document.getElementById("pop_query_button4").innerText = "盈盘构件：" + (num1 < 0 ? -num1 : 0) + "个"
                    if (result.status === '2') {
                        $("#pop_query_button5").attr('disabled', 'true')
                    }
                    if (result.data !== undefined) {
                        pop_pageDate = result.data;
                        updateTable(false);
                        $('#total_d').html(result.cnt + "条，共" + result.pageAll + "页");
                        $('#li_d' + pop_pageCur % 5).removeClass('active');
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

        function updateTable(flag) {
            // document.getElementById('detail_checkbok').checked = false
            // document.getElementById('checkbok').checked = false
            det_i = 0
            main_i = 0
            let str = '';
            if (flag) {
                for (let i = 0; i < jsonObj.length; i++) {
                    str += "<tr><td class='tdStyle_body' title='" + jsonObj[i]['batch_id'] + "'>" + jsonObj[i]['batch_id'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['create_time'] + "'>" + jsonObj[i]['create_time'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['user_name'] + "'>" + jsonObj[i]['user_name'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['should_check_num'] + "'>" + jsonObj[i]['should_check_num'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['real_check_num'] + "'>" + jsonObj[i]['real_check_num'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['status'] + "'>" + (jsonObj[i]['status'] === '1' ? '未完成' : '已完成') +
                        "</td><td class='tdStyle_body' > <a href='#' onclick=openPop('" + jsonObj[i]['check_id'] + "')>详情</a>  <a href='#' onclick=deleteData('" + jsonObj[i]['check_id'] + "')>删除</a> " +
                        "</td></tr>";
                }
                $("#archTableText").html(str);
            } else {
                for (let i = 0; i < pop_pageDate.length; i++) {
                    str += "<tr><td class='tdStyle_body' title='" + pop_pageDate[i]['materialcode'] + "'>" + pop_pageDate[i]['materialcode'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['materialname'] + "'>" + pop_pageDate[i]['materialname'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['drawing_no'] + "'>" + pop_pageDate[i]['drawing_no'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['planname'] + "'>" + pop_pageDate[i]['planname'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['build_type'] + "'>" + pop_pageDate[i]['build_type'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['path'] + "'>" + pop_pageDate[i]['path'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['building_no'] + "'>" + pop_pageDate[i]['building_no'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['floor_no'] + "'>" + pop_pageDate[i]['floor_no'] +
                        "</td>";
                    if (check_id !== '') {
                        if (check_type === 'real_should') {
                            str += "<td class='tdStyle_body' title='" + pop_pageDate[i]['create_user'] + "'>" + pop_pageDate[i]['create_user'] +
                                "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['create_time'] + "'>" + pop_pageDate[i]['create_time'] +
                                "</td><td class='tdStyle_body'> <a href='#' onclick=detailDeleteData('" + pop_pageDate[i]['id'] + "')>删除</a></td>"
                        }
                        if (check_type === 'leak_check') {
                            str += "<td class='tdStyle_body' title='" + (pop_pageDate[i]['remark'] || '') + "'>" + (pop_pageDate[i]['remark'] || '') +
                                "</td><td class='tdStyle_body'> <a href='#' onclick=remarkData('" + pop_pageDate[i]['id'] + "','" + (pop_pageDate[i]['remark'] || '') + "')>写备注</a></td>"
                        }
                        if (check_type === 'full_check') {
                            str += "<td class='tdStyle_body' title='" + (pop_pageDate[i]['remark'] || '') + "'>" + (pop_pageDate[i]['remark'] || '') +
                                "</td><td class='tdStyle_body'> <a href='#' onclick=remarkData('" + pop_pageDate[i]['id'] + "','" + (pop_pageDate[i]['remark'] || '') + "')>写备注</a></td>"
                        }
                    }
                    str += "</tr>";
                }
                $("#detailTableText").html(str);
            }
        }

        function saveRemark(id) {
            $.post("${pageContext.request.contextPath}/InventoryCheck", {
                type: '6',
                id: id,
                remark: $("#myModal_name5").val(),
                check_type: check_type
            }, function (result) {
                result = JSON.parse(result);
                alert(result.msg)
                if (result.flag) {
                    $("#myModal5").modal('hide')
                    getCheckData(check_type)
                }
            })
        }

        function remarkData(id, value) {
            $("#myModal5").modal('show')
            $("#myModal_save5").attr('onclick', "saveRemark('" + id + "')")
            $("#myModal_name5").val(value)
        }

        function detailDeleteData(id) {
            $.post("${pageContext.request.contextPath}/InventoryCheck", {
                type: '3',
                id: id
            }, function (result) {
                result = JSON.parse(result);
                alert(result.msg)
                if (result.flag) {
                    getCheckData(check_type)
                }
            })
        }

        function deleteData(check_id) {
            let r = confirm("亲，确认删除！");
            if (r === false) {
                return;
            }
            $.post("${pageContext.request.contextPath}/InventoryCheck", {
                type: '3',
                check_id: check_id
            }, function (result) {
                result = JSON.parse(result);
                alert(result.msg)
                if (result.flag) {
                    getTableData(1)
                }
            })
        }

        function getInWarehouseMethod(type) {
            $.post("${pageContext.request.contextPath}/GetInOutWarehouseMethod", {type: type}, function (result) {
                result = JSON.parse(result);
                let method = result.data
                $('#select').empty()
                $('#select').append($("<option value=''></option>"))
                for (let o of method) {
                    let item = $("<option value='" + o['name'] + "'>" + o['name'] + "</option>")
                    $('#select').append(item)
                }
            })
        }

        function getOutWarehouseMethod(type) {
            $.post("${pageContext.request.contextPath}/GetInOutWarehouseMethod", {type: type}, function (result) {
                result = JSON.parse(result);
                let method = result.data
                $('#myModal2_name1').empty()
                $('#myModal2_name1').append($("<option value=''></option>"))
                for (let o of method) {
                    let item = $("<option value='" + o['name'] + "'>" + o['name'] + "</option>")
                    $('#myModal2_name1').append(item)
                }
            })
        }

        function moveWarehouse(materialcode) {
            $('#myModal3').modal('show')
            // getYardDataPop()
            $("#myModal3_save").attr('onclick', "moveWarehouseSave('" + materialcode + "')");
        }

        function moveWarehouseSave(materialcode) {
            let location_pop = $("#myModal3_name3").val()
            if (!location_pop) {
                alert("请选择移库货位信息")
                return
            }
            // let location = $("#location").val()
            // if (!location) {
            //     alert("请选择查询货位信息")
            //     return
            // }
            let ids = []
            ids.push(materialcode)
            $.ajax({
                url: "${pageContext.request.contextPath}/InOutWarehouse",
                type: 'post',
                dataType: 'json',
                data: {
                    'ids': JSON.stringify(ids),
                    'in_warehouse_id': location_pop,
                    // 'out_warehouse_id': location,
                    'userName': sessionStorage.getItem("userName"),
                    'type': '3'
                },
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (result) {
                    alert(result.msg)
                    if (result.flag) {
                        $('#myModal3').modal('hide');
                        getTableData(1)
                    }
                }
            })
        }


        //获取明细数据
        function getDetailData(newPage) {
            let location = $('#location option:selected').val();
            let name = null;
            let myModal_name1 = $('#myModal_name1 option:selected').val()
            let myModal_name2 = $('#myModal_name2 option:selected').val()
            if (myModal_name1) {
                name = myModal_name1
            }
            if (myModal_name2) {
                name = myModal_name2
            }
            if (location) {
                name = location
            }
            let planname = $('#planname option:selected').text();
            let build_type = $('#build_type').val();
            $.post("${pageContext.request.contextPath}/GetWarehouseInfo", {
                factoryName: name,
                planname: planname,
                allData: true,
                build_type: build_type,
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                allData = result.allData
                if (result.warehouseInfo !== undefined) {
                    pop_pageDate = result.warehouseInfo;
                    updateTable(false);
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

        function openOutPop(materialcode) {
            if (!materialcode) {
                let ids = []
                $('#archTableText').find('input:checked').each(function () {
                    ids.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组ids
                });
                if (!ids.length) {
                    alert("请勾选")
                    return;
                }
            }
            $('#myModal2').modal('show')
            getOutWarehouseMethod('2')
            $("#myModal2_save").attr('onclick', "outWarehouse('" + materialcode + "')");
        }

        function outWarehouse(materialcode) {
            let ids = []
            if (materialcode !== 'undefined') {
                ids.push(materialcode)
            } else {
                $('#archTableText').find('input:checked').each(function () {
                    ids.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组ids
                });
                if (!ids.length) {
                    alert("请勾选")
                    return;
                }
            }
            // let location = $("#location").val()
            // if (!location) {
            //     alert("请选择查询货位信息")
            //     return
            // }
            let method = $("#myModal2_name1").val()
            if (!method) {
                alert("请选择出库方式信息")
                return;
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InOutWarehouse",
                type: 'post',
                dataType: 'json',
                data: {
                    ids: JSON.stringify(ids),
                    // out_warehouse_id: location,
                    userName: sessionStorage.getItem("userName"),
                    method: method,
                    type: '2'
                },
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (result) {
                    alert(result.msg)
                    if (result.flag) {
                        $('#myModal2').modal('hide')
                        getTableData(1)
                    }
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
            let batch_id = $('#batch_id').val();
            let user_name = $('#user_name').val();
            let startDate = $('#startDate').val();
            let endDate = $('#endDate').val();
            let obj = {
                batch_id: batch_id,
                user_name: user_name,
                type: '0',
                startDate: startDate,
                endDate: endDate,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InventoryCheck",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data.length !== 0) {
                        jsonObj = res.data;
                        updateTable(true);
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
            let batch_id = $('#batch_id').val();
            let user_name = $('#user_name').val();
            let startDate = $('#startDate').val();
            let endDate = $('#endDate').val();
            let obj = {
                batch_id: batch_id,
                user_name: user_name,
                type: '0',
                startDate: startDate,
                endDate: endDate,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InventoryCheck",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data.length !== 0) {
                        jsonObj = res.data;
                        updateTable(true);
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
            if (newPage == "" || isNaN(newPage))
                return;
            if (newPage > pageAll) {
                alert("超过最大页数")
                return
            }
            let batch_id = $('#batch_id').val();
            let user_name = $('#user_name').val();
            let startDate = $('#startDate').val();
            let endDate = $('#endDate').val();
            let obj = {
                batch_id: batch_id,
                user_name: user_name,
                type: '0',
                startDate: startDate,
                endDate: endDate,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InventoryCheck",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data.length !== 0) {
                        jsonObj = res.data;
                        updateTable(true);
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
            let location = $('#location option:selected').val();
            let name = null;
            let myModal_name1 = $('#myModal_name1 option:selected').val()
            let myModal_name2 = $('#myModal_name2 option:selected').val()
            if (myModal_name1) {
                name = myModal_name1
            }
            if (myModal_name2) {
                name = myModal_name2
            }
            if (location) {
                name = location
            }
            let planname = $('#planname option:selected').text();
            let build_type = $('#build_type').val();
            let obj
            let url
            if (check_id !== '') {
                url = "${pageContext.request.contextPath}/InventoryCheck"
                document.getElementById("small").innerText = '应盘构件信息'
                obj = {
                    check_id: check_id,
                    check_type: check_type,
                    type: '4',
                    pageCur: newPage,
                    pageMax: pageMax
                }
            } else {
                url = "${pageContext.request.contextPath}/GetWarehouseInfo"
                obj = {
                    factoryName: name,
                    planname: planname,
                    allData: true,
                    build_type: build_type,
                    pageCur: newPage,
                    pageMax: pageMax
                }
            }
            $.post(url, obj, function (result) {
                result = JSON.parse(result);
                let data
                if (check_id !== '') {
                    data = result.data
                } else {
                    data = result.warehouseInfo
                }
                if (data !== undefined) {
                    pop_pageDate = data;
                    updateTable(false);
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
            let location = $('#location option:selected').val();
            let name = null;
            let myModal_name1 = $('#myModal_name1 option:selected').val()
            let myModal_name2 = $('#myModal_name2 option:selected').val()
            if (myModal_name1) {
                name = myModal_name1
            }
            if (myModal_name2) {
                name = myModal_name2
            }
            if (location) {
                name = location
            }
            let planname = $('#planname option:selected').text();
            let build_type = $('#build_type').val();
            let obj
            let url
            if (check_id !== '') {
                url = "${pageContext.request.contextPath}/InventoryCheck"
                obj = {
                    check_id: check_id,
                    check_type: check_type,
                    type: '4',
                    pageCur: newPage,
                    pageMax: pageMax
                }
            } else {
                url = "${pageContext.request.contextPath}/GetWarehouseInfo"
                obj = {
                    factoryName: name,
                    planname: planname,
                    allData: true,
                    build_type: build_type,
                    pageCur: newPage,
                    pageMax: pageMax
                }
            }
            $.post(url, obj, function (result) {
                result = JSON.parse(result);
                let data
                if (check_id !== '') {
                    data = result.data
                } else {
                    data = result.warehouseInfo
                }
                if (data !== undefined) {
                    pop_pageDate = data;
                    updateTable(false);
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
            let location = $('#location option:selected').val();
            let name = null;
            let myModal_name1 = $('#myModal_name1 option:selected').val()
            let myModal_name2 = $('#myModal_name2 option:selected').val()
            if (myModal_name1) {
                name = myModal_name1
            }
            if (myModal_name2) {
                name = myModal_name2
            }
            if (location) {
                name = location
            }
            let planname = $('#planname option:selected').text();
            let build_type = $('#build_type').val();
            let obj
            let url
            if (check_id !== '') {
                url = "${pageContext.request.contextPath}/InventoryCheck"
                obj = {
                    check_id: check_id,
                    check_type: check_type,
                    type: '4',
                    pageCur: newPage,
                    pageMax: pageMax
                }
            } else {
                url = "${pageContext.request.contextPath}/GetWarehouseInfo"
                obj = {
                    factoryName: name,
                    planname: planname,
                    allData: true,
                    build_type: build_type,
                    pageCur: newPage,
                    pageMax: pageMax
                }
            }
            $.post(url, obj, function (result) {
                result = JSON.parse(result);
                let data
                if (check_id !== '') {
                    data = result.data
                } else {
                    data = result.warehouseInfo
                }
                if (data !== undefined) {
                    pop_pageDate = data;
                    updateTable(false);
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
