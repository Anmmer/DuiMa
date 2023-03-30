<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:89%;height:16%;margin-left: 8%;padding-top:2%">
        <div class="form-group" style="width: 20%;">
            <label>堆场信息：</label>
            <input style="height:34%;width: 68%" name="factoryName"
                   id="factoryName"
                   onclick="openPop1()" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%;">
            <label>项目名称：</label><input type="text" id="planname"
                                       style="height:34%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%;">
            <label>楼栋：</label><input type="text" id="building_no"
                                     style="height:34%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;">
            <label>楼层：</label><input type="text" id="floor_no"
                                     style="height:34%;" class="form-control">
        </div>
        <br><br>
        <div class="form-group" style="width: 20%">
            <label>物料编码：</label><input type="text" id="materialcode"
                                       style="height:34%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%">
            <label>图号：</label><input type="text" id="drawing_no"
                                     style="height:34%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%">
            <label>构建编号：</label><input type="text" id="preproductid"
                                       style="height:34%;width: 68%" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:85%;height:78%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>仓库信息</small></h3>
            <button type="button" onclick="openOutPop()" style="position: absolute;right: 15%;top:16%;width: 60px"
                    class="btn btn-primary btn-sm">
                出&nbsp;&nbsp;库
            </button>
            <button type="button" onclick="openPop()" style="position: absolute;right: 9%;top:16%;width: 60px"
                    class="btn btn-primary btn-sm">
                入&nbsp;&nbsp;库
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" cellspacing="0" cellpadding="0" width="100%" align="center">
                <tr>
                    <td class='tdStyle_title active' style="width: 2%"><input
                            id="checkbok"
                            type="checkbox"></td>
                    <td class='tdStyle_title  active' style="width: 10%">物料编码</td>
                    <td class='tdStyle_title active' style="width: 10%">构件名称</td>
                    <td class='tdStyle_title active' style="width: 10%">构件编号</td>
                    <td class='tdStyle_title active' style="width: 10%">方量</td>
                    <td class='tdStyle_title active' style="width: 10%">构件类型</td>
                    <td class='tdStyle_title active' style="width: 10%">所属项目</td>
                    <td class='tdStyle_title active' style="width: 10%">楼栋</td>
                    <td class='tdStyle_title active' style="width: 10%">楼层</td>
                    <td class='tdStyle_title active' style="width: 15%">库位</td>
                    <td class='tdStyle_title active' style="width: 15%">操作</td>
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
                                <td class='tdStyle_title active' style="width: 15%">物料编号</td>
                                <td class='tdStyle_title active' style="width: 15%">物料名称</td>
                                <td class='tdStyle_title active' style="width: 10%">规格</td>
                                <td class='tdStyle_title active' style="width: 10%">状态</td>
                            </tr>
                            <tbody id="detailTableText">
                            </tbody>
                        </table>
                    </div>
                    <div style="display: flex;width: 100%; justify-content: space-between;">
                        <div class="form-inline" style="width: 30%;">
                            <label for="select">入库方式:</label>
                            <select id="select" class="form-control" style="width: 60%"></select>
                        </div>
                        <button type="button" style="height:10%;width: 100px" onclick="inWarehouseSave()"
                                class="btn btn-primary btn-sm">保 存
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
    <div class="modal fade" id="myModal2" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModal2_title1">出库方式</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="margin-top: 5%">
                            <label for="myModal2_name1" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">出库方式:</label>
                            <select class="form-control" style="width:50%;" id="myModal2_name1"
                                    name="myModal2_name1" onchange="getRegionDataPop()"></select><br>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" id="myModal2_save" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal3" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModal3_title1">选择目标货位</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="margin-top: 5%">
                            <label for="myModal3_name1" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">堆场信息:</label>
                            <select class="form-control" style="width:50%;" id="myModal3_name1"
                                    name="myModal3_name1" onchange="getRegionDataPop()"></select><br>
                            <label for="myModal3_name2" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">区域信息:</label>
                            <select class="form-control" onchange="getLocationPop()" style="width:50%;"
                                    id="myModal3_name2"
                                    name="myModal3_name2"></select><br>
                            <label for="myModal3_name3" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">货位信息:</label>
                            <select type="text" class="form-control" style="width:50%;" id="myModal3_name3"
                                    name="myModal3_name"></select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" id="myModal3_save" class="btn btn-primary">保存</button>
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
    <script type="text/javascript">
        let pageCur = 1;
        let pageAll = 1;
        let pageMax = 10;   //一页多少条数据
        let jsonObj = [];
        let pop_pageDate = []

        window.onload = getYardData();

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

        function inWarehouseSave() {
            let location = $("#location").val()
            if (location === null || location === '') {
                alert("请选择货位信息")
                return;
            }
            let ids = []
            $('#detailTableText').find('input:checked').each(function () {
                ids.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组ids
            });
            if (ids.length === 0) {
                alert("请选择入库构建")
                return;
            }
            let select = $("#select").val()
            if (select === '') {
                alert("请选择入库方式")
                return;
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/InOutWarehouse",
                type: 'post',
                dataType: 'json',
                data: {
                    ids: JSON.stringify(ids),
                    in_warehouse_id: location,
                    userName: sessionStorage.getItem("userName"),
                    method: select,
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
                alert("请选择堆场信息")
                $('#myModal_name').empty()
                $('#myModal_name2').empty()
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

            // if (location === null) {
            //     alert("请选择堆场货位信息")
            //     return
            // }
            let planname = $('#planname').val();
            let preproductid = $('#preproductid').val();
            let building_no = $('#building_no').val();
            let floor_no = $('#floor_no').val();
            let materialcode = $('#materialcode').val();
            let drawing_no = $('#drawing_no').val();
            let obj = {
                factoryName: name,
                planname: planname,
                preproductid: preproductid,
                building_no: building_no,
                floor_no: floor_no,
                materialcode: materialcode,
                drawing_no: drawing_no,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetWarehouseInfo",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res !== undefined) {
                        jsonObj = res.warehouseInfo;
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

        $('#myModal').on('hidden.bs.modal', function (e) {
            $('#li_d' + pop_pageCur % 5).removeClass('active');
            $("#detail_checkbok").prop("checked", false);
            $("#materialcode_pop").val('')
            $("#materialname_pop").val('')
            pop_pageAll = 1;
            pop_pageCur = 1;
        })

        $('#myModal2').on('hidden.bs.modal', function (e) {
            $('#myModal2_name1').empty()
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

        function openPop() {
            let location = $("#location").val()
            if (location === null || location === '') {
                alert("请选择货位信息")
                return;
            }
            $('#myModal').modal('show')
            getDetailData(1)
            getInWarehouseMethod('1')
        }

        function updateTable(flag) {
            document.getElementById('detail_checkbok').checked = false
            document.getElementById('checkbok').checked = false
            det_i = 0
            main_i = 0
            let str = '';
            if (flag) {
                for (let i = 0; i < jsonObj.length; i++) {
                    str += "<tr><td class='tdStyle_body' style='padding: 5px;'><input type='checkbox' data-id=" + jsonObj[i]["materialcode"] + ">" +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['materialcode'] + "'>" + jsonObj[i]['materialcode'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['materialname'] + "'>" + jsonObj[i]['materialname'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['preproductid'] + "'>" + jsonObj[i]['preproductid'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['fangliang'] + "'>" + jsonObj[i]['fangliang'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['build_type'] + "'>" + jsonObj[i]['build_type'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['planname'] + "'>" + jsonObj[i]['planname'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['building_no'] + "'>" + jsonObj[i]['building_no'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['floor_no'] + "'>" + jsonObj[i]['floor_no'] +
                        "</td><td class='tdStyle_body' title='" + jsonObj[i]['path'] + "'>" + jsonObj[i]['path'] +
                        "</td><td class='tdStyle_body' > <a href='#' onclick=openOutPop('" + jsonObj[i]['materialcode'] + "')>出库</a> <a href='#' onclick=moveWarehouse('" + jsonObj[i]['materialcode'] + "')>移库</a> </td></tr>";
                }
                $("#archTableText").html(str);
            } else {
                for (let i = 0; i < pop_pageDate.length; i++) {
                    pop_pageDate[i]['stock_status'] = pop_pageDate[i]['stock_status'] === '0' ? '待入库' : '已入库';
                    str += "<tr><td class='tdStyle_body' style='padding: 5px;'><input type='checkbox' data-id=" + pop_pageDate[i]["materialcode"] + ">" +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['materialcode'] + "'>" + pop_pageDate[i]['materialcode'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['materialname'] + "'>" + pop_pageDate[i]['materialname'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['standard'] + "'>" + pop_pageDate[i]['standard'] +
                        "</td><td class='tdStyle_body' title='" + pop_pageDate[i]['stock_status'] + "'>" + pop_pageDate[i]['stock_status'] +
                        "</td></tr>";
                }
                $("#detailTableText").html(str);
            }
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
            let location = $("#location").val()
            if (!location) {
                alert("请选择查询货位信息")
                return
            }
            let ids = []
            ids.push(materialcode)
            $.ajax({
                url: "${pageContext.request.contextPath}/InOutWarehouse",
                type: 'post',
                dataType: 'json',
                data: {
                    'ids': JSON.stringify(ids),
                    'in_warehouse_id': location_pop,
                    'out_warehouse_id': location,
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
            let materialcode = $('#materialcode_pop').val();
            let materialname = $('#materialname_pop').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                stockStatus: "0",
                inspectState: "1",
                materialcode: materialcode,
                materialname: materialname,
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
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
            let location = $("#location").val()
            if (!location) {
                alert("请选择查询货位信息")
                return
            }
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
                    out_warehouse_id: location,
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
            let planname = $('#planname').val();
            let preproductid = $('#preproductid').val();
            let building_no = $('#building_no').val();
            let floor_no = $('#floor_no').val();
            let materialcode = $('#materialcode').val();
            let drawing_no = $('#drawing_no').val();
            let obj = {
                factoryName: name,
                preproductid: preproductid,
                planname: planname,
                building_no: building_no,
                floor_no: floor_no,
                materialcode: materialcode,
                drawing_no: drawing_no,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetWarehouseInfo",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.warehouseInfo.length !== 0) {
                        jsonObj = res.warehouseInfo;
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
            let location = $('#location option:selected').val();
            let name = null;
            let myModal_name1 = $('#myModal_name1 option:selected').val()
            let myModal_name2 = $('#myModal_name2 option:selected').val()
            let preproductid = $('#preproductid').val();
            if (myModal_name1) {
                name = myModal_name1
            }
            if (myModal_name2) {
                name = myModal_name2
            }
            if (location) {
                name = location
            }
            let planname = $('#planname').val();
            let building_no = $('#building_no').val();
            let floor_no = $('#floor_no').val();
            let materialcode = $('#materialcode').val();
            let drawing_no = $('#drawing_no').val();
            let obj = {
                factoryName: name,
                planname: planname,
                preproductid: preproductid,
                building_no: building_no,
                floor_no: floor_no,
                materialcode: materialcode,
                drawing_no: drawing_no,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetWarehouseInfo",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.warehouseInfo.length !== 0) {
                        jsonObj = res.warehouseInfo;
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
            let planname = $('#planname').val();
            let building_no = $('#building_no').val();
            let floor_no = $('#floor_no').val();
            let materialcode = $('#materialcode').val();
            let drawing_no = $('#drawing_no').val();
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
            let preproductid = $('#preproductid').val();
            let obj = {
                factoryName: name,
                preproductid: preproductid,
                planname: planname,
                building_no: building_no,
                floor_no: floor_no,
                materialcode: materialcode,
                drawing_no: drawing_no,
                pageCur: newPage,
                pageMax: pageMax
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/GetWarehouseInfo",
                type: 'post',
                dataType: 'json',
                data: obj,
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.warehouseInfo.length !== 0) {
                        jsonObj = res.warehouseInfo;
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
            let materialcode = $('#materialcode_pop').val();
            let materialname = $('#materialname_pop').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialcode: materialcode,
                materialname: materialname,
                stockStatus: "0",
                inspectState: "1",
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
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
            let materialcode = $('#materialcode_pop').val();
            let materialname = $('#materialname').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialname: materialname,
                materialcode: materialcode,
                stockStatus: "0",
                inspectState: "1",
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
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
            let materialcode = $('#materialcode_pop').val();
            let materialname = $('#materialname').val();
            $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialname: materialname,
                materialcode: materialcode,
                stockStatus: "0",
                inspectState: "1",
                pageCur: newPage,
                pageMax: pageMax
            }, function (result) {
                result = JSON.parse(result);
                if (result.data !== undefined) {
                    pop_pageDate = result.data;
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
