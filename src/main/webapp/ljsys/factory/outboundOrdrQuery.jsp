<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <form name="query" class="form-inline" style="width:90%;height:12%;margin-left: 6%;padding-top:2%">
        <label style="margin-left: 2%">项目名称：</label><input type="text" id="planname"
                                                           style="height: 30px;width: 10%" class="form-control">
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 3%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:85%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>出库单信息</small></h3>
            <button type="button" style="position: absolute;right: 10%;top:11.5%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="addOrder()">
                新 增
            </button>
            <%--            <button type="button" style="position: absolute;right: 10%;top:11.5%" class="btn btn-primary btn-sm"--%>
            <%--                    data-toggle="modal"--%>
            <%--                    onclick="printDataF(false)">--%>
            <%--                全部打印--%>
            <%--            </button>--%>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" cellspacing="0" cellpadding="0" width="100%"
                   align="center">
                <tr>
                    <td class='tdStyle_title table_td active' style="width: 20%">出库单号</td>
                    <td class='tdStyle_title table_td active' style="width: 8%">出库时间</td>
                    <td class='tdStyle_title table_td active' style="width: 10%">客户名称</td>
                    <td class='tdStyle_title table_td active' style="width: 15%">送货地址</td>
                    <td class='tdStyle_title table_td active' style="width: 10%">现场联系人</td>
                    <td class='tdStyle_title table_td active' style="width: 10%">收料员</td>
                    <td class='tdStyle_title table_td active' style="width: 8%">构建数量</td>
                    <td class='tdStyle_title table_td active' style="width: 8%">操作</td>
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
         style="position: absolute;left: 10%;height: 95%;top: 3%;width: 82%;z-index: 5" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="width: 100%;height: 100%;margin: 0">
            <div class="modal-content" style="width: 100%;height: 100%">
                <div class="modal-header" style="height: 7%">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h5 class="modal-title">打印信息</h5>
                </div>
                <div class="modal-body" id="print" style="height: 90%;width: 95%;margin: 0 auto">
                    <!--startprint-->
                    <div style="height: 10px;width: 100%"></div>
                    <div id="title"
                         style="width: 100%;margin-bottom: 10px;display: flex;justify-content: center;align-items: center;flex-direction: column">
                        <div class="title" style="width: 100%;">
                            <img style="height: 32px;position: absolute;left: 15px"
                                 src="./img/qr1.jpg">
                            <div style="text-align: center;font-size: 20px;">苏州绿建住工科技有限公司<br>PC构件出库单</div>
                        </div>

                        <div class="title_text"
                             style="line-height: 25px;width: 100%;display: flex;justify-content: space-between;">
                            <div id="create_time" class="title_item" style="max-width: 400px;"></div>
                            <div id="order_id" class="title_item" style="max-width: 400px;"></div>
                        </div>
                        <div class="title_text"
                             style="line-height: 25px;width: 100%;display: flex;justify-content: space-between;">
                            <div id="customer_name_print" class="title_item" style="max-width: 400px;"></div>
                            <div id="contact_name_print" class="title_item" style="max-width: 400px;"></div>
                        </div>
                        <div class="title_text"
                             style="line-height: 25px;width: 100%;display: flex;justify-content: space-between;">
                            <div id="planname_print" class="title_item" style="max-width: 400px;"></div>
                            <div id="material_receiver_print" class="title_item" style="max-width: 400px;"></div>
                        </div>
                        <div class="title_text"
                             style="line-height: 25px;width: 100%;display: flex;justify-content: space-between;">
                            <div id="address_print" class="title_item" style="max-width: 400px;"></div>
                        </div>

                    </div>
                    <table border="1" style="text-align: center;width: 100%;">
                        <tr id="printTableTr">

                        </tr>
                        <tbody id="printTableText">
                        </tbody>
                    </table>
                    <div style="margin-top: 5px;line-height: 25px">
                        <div style="width: 100%;text-align: center;font-weight: bolder;font-size: 13px">备注：财务（白） 客户（红）
                            运输（蓝） 工厂（黄）
                        </div>
                        <div>请仔细核对货物型号、数量和品质，如果有问题请于收货三日内与我司现场业务负责人联系，项目质保资料已齐全并提供，逾期视为对产品数量质量型号无异议。<br>公司总部地址：苏州相城区阳澄湖镇东横港街
                        </div>
                    </div>
                    <div style="display: flex;justify-content: space-between;margin-top: 30px">
                        <div id="print_name" style="width: 120px"></div>
                        <div id="qc" style="width: 120px">质检：</div>
                        <div id="deliver_goods" style="width: 120px">送货员：</div>
                        <div id="plate_number" style="width: 120px">车牌号：</div>
                        <div id="confirmation" style="width: 120px">出厂确认：</div>
                        <div id="signature" style="width: 120px">客户签收：</div>
                    </div>
                    <!--endprint-->
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal4" style="position: absolute;left: 15%;top: 12%;z-index: 9"
         role="dialog"
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
                                    name="location"></select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" id="myModal_save" onclick="saveFactory()" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal1"
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
                    <div name="query" id="pop_query" class="form-inline" style="width: 100%;height: 18%">
                        <div class="form-group" style="width: 20%;">
                            <label>堆场信息：</label>
                            <input style="height:34%;width: 68%" name="factoryName"
                                   id="factoryName"
                                   onclick="openPop1()" class="form-control">
                        </div>
                        <%--                        <div class="form-group" style="margin-left:3%;width: 20%;">--%>
                        <%--                            <label>项目名称：</label><input type="text" id="pop_planname"--%>
                        <%--                                                       style="height:34%;width: 68%" class="form-control">--%>
                        <%--                        </div>--%>
                        <div class="form-group" style="">
                            <label>楼栋：</label><input type="text" id="building_no"
                                                     style="height:34%;width: 80px" class="form-control">
                        </div>
                        <div class="form-group" style="margin-left:3%;">
                            <label>楼层：</label><input type="text" id="floor_no"
                                                     style="height:34%;width: 80px" class="form-control">
                        </div>
                        <%--                        <br><br>--%>
                        <%--                        <div class="form-group" style="width: 20%">--%>
                        <%--                            <label>物料编码：</label><input type="text" id="materialcode"--%>
                        <%--                                                       style="height:34%;width: 68%" class="form-control">--%>
                        <%--                        </div>--%>
                        <div class="form-group" style="margin-left:3%;width: 15%">
                            <label>图号：</label><input type="text" id="drawing_no"
                                                     style="height:34%;width: 68%" class="form-control">
                        </div>
                        <div class="form-group" style="width: 15%">
                            <label>构件类型：</label><input type="text" id="build_type"
                                                       style="height:34%;width: 55%" class="form-control">
                        </div>
                        <div class="form-group" style="width: 15%">
                            <label>发货日期：</label><input type="date" id="out_time"
                                                       style="height:32px;width: 150px" class="form-control">
                        </div>
                        <%--                        <div class="form-group" style="margin-left:3%;width: 20%">--%>
                        <%--                            <label>构建编号：</label><input type="text" id="preproductid"--%>
                        <%--                                                       style="height:34%;width: 68%" class="form-control">--%>
                        <%--                        </div>--%>
                        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 0%"
                                onclick="getDetailData(1)">
                            查 询
                        </button>
                        <br><br>
                        <div class="form-group" style="width: 20%;">
                            <label>项目名称：</label>
                            <select style="height:34%;width: 68%" name="pop_planname"
                                    id="pop_planname"
                                    onchange="selectData()" class="form-control">
                            </select>
                        </div>
                        <div class="form-group" style="margin-left:1%;width: 18%;">
                            <label>客户名称：</label><input disabled type="text" id="customer_name"
                                                       style="height:34%;width: 60%" class="form-control">
                        </div>
                        <div class="form-group" style="margin-left:1%;width: 18%;">
                            <label>现场联系人：</label><select type="text" id="contact_name"
                                                         style="height:34%;width: 60%" class="form-control"></select>
                        </div>
                        <div class="form-group" style="margin-left:1%;width: 18%;">
                            <label>收货地址：</label><input disabled type="text" id="address"
                                                       style="height:34%;width: 60%" class="form-control">
                        </div>
                        <div class="form-group" style="margin-left:1%;width: 18%;">
                            <label>收料员：</label><select type="text" id="material_receiver"
                                                       style="height:34%;width: 60%" class="form-control"></select>
                        </div>
                    </div>
                    <div style="height: 75%;display: flex">
                        <div style="width: 60%">
                            <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
                                <h3 style="margin-bottom: 0;margin-top: 0"><small>构建信息</small></h3>
                            </div>
                            <div style="height:85%;overflow: auto">
                                <table class="table table-hover" style="text-align: center;">
                                    <tr id="table_tr">
                                        <td class='tdStyle_title active' style="width: 40px"><input
                                                id="detail_checkbok"
                                                type="checkbox"></td>
                                        <td class='tdStyle_title active' style="width: 150px">物料编码</td>
                                        <td class='tdStyle_title active' style="width: 250px">物料名称</td>
                                        <td class='tdStyle_title active' style="width: 250px">构件类型</td>
                                        <td class='tdStyle_title active' style="width: 150px">图号</td>
                                        <td class='tdStyle_title active' style="width: 150px">所属项目</td>
                                        <td class='tdStyle_title active' style="width: 100px">楼栋</td>
                                        <td class='tdStyle_title active' style="width: 100px">楼层</td>
                                        <td class='tdStyle_title active' style="width: 250px">货位</td>
                                    </tr>
                                    <tbody id="detailTableText">
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <div style="width: 38%;height:100%;overflow-y:auto;margin-left: 20px">
                            <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
                                <h3 style="margin-bottom: 0;margin-top: 0"><small id="title_1">已选信息0个</small></h3>
                            </div>
                            <table class="table table-hover" style="text-align: center;">
                                <tr id="table_tr1">
                                    <td class='tdStyle_title active' style="width: 25%">物料名称</td>
                                    <td class='tdStyle_title active' style="width: 20%">图号</td>
                                    <td class='tdStyle_title active' style="width: 20%">所属项目</td>
                                    <td class='tdStyle_title active' style="width: 10%">操作</td>
                                </tr>
                                <tbody id="detailTableText1">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <nav aria-label="Page navigation" style="margin-left:10%;width:80%;height:10%;" id="page">
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
                            <button style="margin-left: 50px;width: 70px" onclick="save()"
                                    class="btn btn-primary btn-sm">保 存
                            </button>
                        </ul>
                    </nav>
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
    let pop_pageDate = []  //弹框数据
    let pop_pageCur = 1;    //弹框分页当前页
    let pop_pageAll = 1;  //弹框分页总页数
    let pop_pageDate2 = []
    let list = []   //现场联系人
    let list2 = []   //现场联系人
    let det_i = 0;

    window.onload = getTableData(1)

    $('#myModal1').on('hidden.bs.modal', function (e) {
        location.reload()
    })

    function addOrder() {
        $('#myModal1').modal('show')
        getYardData()
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
                $('#pop_planname').empty()
                $('#pop_planname').append($("<option value=''></option>"))
                if (res.data.length !== 0) {
                    for (let v of res.data) {
                        let item = $("<option value='" + v['id'] + "'>" + v['planname'] + "</option>")
                        $('#pop_planname').append(item)
                    }
                }
            }
        })
        $.ajax({
            url: "${pageContext.request.contextPath}/Contact",
            type: 'post',
            dataType: 'json',
            data: {
                type: '1',
                'pageCur': 1,
                'pageMax': 999
            },
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                $('#contact_name').empty()
                list = res.data
                if (res.data.length !== 0) {
                    for (let v of res.data) {
                        let item = $("<option>" + v['name'] + " " + v['phone'] + "</option>")
                        $('#contact_name').append(item)
                    }
                }
            }
        })
        $.ajax({
            url: "${pageContext.request.contextPath}/MaterialReceiver",
            type: 'post',
            dataType: 'json',
            data: {
                type: '1',
                'pageCur': 1,
                'pageMax': 999
            },
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                $('#material_receiver').empty()
                list2 = res.data
                if (res.data.length !== 0) {
                    for (let v of res.data) {
                        let item = $("<option>" + v['name'] + " " + v['phone'] + "</option>")
                        $('#material_receiver').append(item)
                    }
                }
            }
        })
    }

    function openPop1() {
        $('#myModal4').modal('show')
    }

    $("#detail_checkbok").on("click", function () {
        if (det_i == 0) {
            //把所有复选框选中
            $("#detailTableText td :checkbox").prop("checked", true);
            det_i = 1;
            let arr = pop_pageDate.filter((val) => {
                return !pop_pageDate2.some((val1) => {
                    return val.materialcode == val1.materialcode
                })
            })
            pop_pageDate2.push(...arr)
        } else {
            $("#detailTableText td :checkbox").prop("checked", false);
            det_i = 0;
            pop_pageDate2 = pop_pageDate2.filter((value => {
                return !pop_pageDate.some((val) => {
                    return value.materialcode == val.materialcode
                })
            }))
        }

        updateTable2()

    });


    function getTableData(newPage) {
        let planname = $('#planname').val();
        let obj = {
            name: planname,
            type: '1',
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/OutboundOrder",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data) {
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

    function selectData() {
        let id = $("#pop_planname option:selected").val()
        if (!id) {
            return
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlanName",
            type: 'post',
            dataType: 'json',
            data: {
                id: id,
                pageCur: 1,
                pageMax: 999
            },
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (result) {
                if (result.data[0]) {
                    $("#customer_name").val(result.data[0].customer_name)
                    $("#address").val(result.data[0].address)
                    if (result.data[0].contact_name) {
                        $('#contact_name').empty()
                        for (let v of list) {
                            if (result.data[0].contact_name.includes(v['name'])) {
                                let item = $("<option>" + v['name'] + " " + v['phone'] + "</option>")
                                $('#contact_name').append(item)
                            }
                        }
                    }
                    if (result.data[0].material_receiver) {
                        $('#material_receiver').empty()
                        for (let v of list2) {
                            if (result.data[0].material_receiver.includes(v['name'])) {
                                let item = $("<option>" + v['name'] + " " + v['phone'] + "</option>")
                                $('#material_receiver').append(item)
                            }
                        }
                    }
                }
                getDetailData(1)
            }
        })
    }

    function getYardData() {
        $.post("${pageContext.request.contextPath}/GetFactory", {
            type: '1',
            pageCur: '1',
            pageMax: '999'
        }, function (result) {
            getDetailData()
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

    function getRegionData() {
        let pid = $('#myModal_name1 option:selected').val()
        if (pid === "") {
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

    function saveFactory() {
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

    function save() {
        if (!pop_pageDate2.length) {
            alert("请勾选构建信息！")
            return
        }
        let obj = {
            type: '2',
            materialcodes: JSON.stringify(pop_pageDate2.map((v) => {
                return v.materialcode
            })),
            name: $('#pop_planname option:selected').text(),
            customer_name: $("#customer_name").val(),
            contact_name: $("#contact_nameoption option:selected").text(),
            address: $("#address").val(),
            out_time: $("#out_time").val(),
            material_receiver: $("#material_receiver option:selected").text(),
        }
        if (!obj.name) {
            alert('请选择项目信息')
            return;
        }
        if (!obj.customer_name || !obj.contact_name || !obj.address || !obj.material_receiver) {
            alert('请完善项目信息')
            return;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/OutboundOrder",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.message) {
                    alert(res.message)
                }
                if (res.flag) {
                    location.reload()
                }
            }
        })

    }


    function getDetailData() {
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
        let planname = $('#pop_planname option:selected').text();
        let preproductid = $('#preproductid').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let materialcode = $('#materialcode').val();
        let drawing_no = $('#drawing_no').val();
        let build_type = $('#build_type').val();
        let obj = {
            factoryName: name,
            planname: planname,
            preproductid: preproductid,
            building_no: building_no,
            floor_no: floor_no,
            materialcode: materialcode,
            drawing_no: drawing_no,
            build_type: build_type,
            isOrder: false,
            pageCur: 1,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseInfo",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (result) {
                if (result.warehouseInfo) {
                    pop_pageDate = result.warehouseInfo
                    updateTable(true);
                    $('#total_d').html(result.cnt + "条，共" + result.pageAll + "页");
                    if (pop_pageCur !== 1) {
                        $('#li_d' + pop_pageCur).removeClass('active')
                    }
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
            }
        })
    }


    function printDataF(i) {
        document.getElementById("print_name").innerText = "制单：" + sessionStorage.getItem("userName")
        document.getElementById("order_id").innerText = "出仓单号：" + "JSLJ-" + (jsonObj[i]['number'] || '')
        document.getElementById("customer_name_print").innerText = "客户名称：" + jsonObj[i]['customer_name']
        document.getElementById("contact_name_print").innerText = "现场联系人：" + jsonObj[i]['contact_name']
        document.getElementById("planname_print").innerText = "项目名称：" + jsonObj[i]['planname']
        document.getElementById("material_receiver_print").innerText = "收料员：" + jsonObj[i]['material_receiver']
        document.getElementById("address_print").innerText = "送货地址：" + jsonObj[i]['address']
        document.getElementById("create_time").innerText = "出货日期：" + jsonObj[i]['out_time']
        let str = ''
        str += "<td class='print_tdStyle_title active' style='width: 5%'>序号</td>" +
            "<td class='print_tdStyle_title active' style='width: 22%'>PC构件名称</td>" +
            "<td class='print_tdStyle_title active' style='width: 18%'>构件编号</td>" +
            "<td class='print_tdStyle_title active' style='width: 15%'>长*宽*高</td>" +
            "<td class='print_tdStyle_title active' style='width: 10%'>体积(m3)</td>" +
            "<td class='print_tdStyle_title active' style='width: 10%'>数量（个）</td>" +
            "<td class='print_tdStyle_title active' style='width: 10%'>备注</td>"
        $("#printTableTr").html(str);
        $("#myModal").modal('show')
        getPrintData(jsonObj[i]['id'])

    }


    function getPrintData(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/OutboundOrder",
            type: 'post',
            dataType: 'json',
            data: {
                id: id,
                type: '5'
            },
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data) {
                    printData = res.data;
                    updatePrintTable(res.total);
                }
            },
            error: function () {
                printData = [];
                updatePrintTable();
                alert("查询失败！")
            }
        })
    }

    function updatePrintTable(total) {
        let str = '';
        for (let i = 0; i < printData.length; i++) {
            str += "<tr><td class='tdStyle_body' title='" + (i + 1) + "'>" + (i + 1) +
                "</td><td class='tdStyle_body' title='" + printData[i]['materialname'] + "'>" + printData[i]['materialname'] +
                "</td><td class='tdStyle_body' title='" + printData[i]['preproductid'] + "'>" + printData[i]['preproductid'] +
                "</td><td class='tdStyle_body' title='" + printData[i]['standard'] + "'>" + printData[i]['standard'] +
                "</td><td class='tdStyle_body' title='" + printData[i]['fangliang'] + "'>" + printData[i]['fangliang'] +
                "</td><td class='tdStyle_body' title='" + 1 + "'>" + '1' +
                "</td><td class='tdStyle_body'>" + "</td></tr>"
        }
        str += "<tr><td class='tdStyle_body' title='" + '合计' + "'>" + '合计' +
            "</td><td class='tdStyle_body' >" +
            "</td><td class='tdStyle_body' >" +
            "</td><td class='tdStyle_body'>" +
            "</td><td class='tdStyle_body' title='" + total + "'>" + total +
            "</td><td class='tdStyle_body' >" + printData.length +
            "</td><td class='tdStyle_body'>" + "</td></tr>"
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

    function change(index) {
        if (pop_pageDate2.find((v, i) => {
            return v.materialcode === pop_pageDate[index].materialcode
        })) {
            pop_pageDate2 = pop_pageDate2.filter((value => {
                return value.materialcode !== pop_pageDate[index].materialcode
            }))
        } else {
            pop_pageDate2.push(pop_pageDate[index])
        }
        updateTable2()
    }

    function updateTable2() {
        let str = ''
        let sum = 0
        for (let i = 0; i < pop_pageDate2.length; i++) {
            str += "<tr>" +
                "</td><td class='tdStyle_body table_td' title='" + pop_pageDate2[i]['materialname'] + "'>" + pop_pageDate2[i]['materialname'] +
                "</td><td class='tdStyle_body table_td' title='" + pop_pageDate2[i]['preproductid'] + "'>" + pop_pageDate2[i]['preproductid'] +
                "</td><td class='tdStyle_body table_td' title='" + pop_pageDate2[i]['planname'] + "'>" + pop_pageDate2[i]['planname'] +
                "</td><td class='tdStyle_body table_td' ><a href='#' onclick=delTableData(" + i + ")>删除</a>" +
                "</td></tr>";
            sum += parseFloat(pop_pageDate2[i]['fangliang'])
        }
        $("#detailTableText1").html(str);

        document.getElementById("title_1").innerText = '已选信息' + pop_pageDate2.length + '个 ' + "合计方量：" + sum.toFixed(3)
        setCheckBox()
    }

    function delTableData(i) {
        pop_pageDate2.splice(i, 1)
        updateTable2()
    }

    function delTableData1(id) {
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/OutboundOrder",
            type: 'post',
            dataType: 'json',
            data: {id: id, type: '4'},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.message) {
                    alert(res.message)
                }
                if (res.flag) {
                    getTableData(pageCur)
                }
            }
        })
    }

    function setCheckBox() {
        pop_pageDate.forEach((v, i) => {
            if (pop_pageDate2.find((v1, i1) => {
                return v.materialcode === v1.materialcode
            })) {
                $("#checkbox_" + v.materialcode).prop("checked", true);
            } else {
                $("#checkbox_" + v.materialcode).prop("checked", false);
                $("#detail_checkbok").prop("checked", false);
                det_i = 0
            }
        })

    }

    function updateTable(detail) {
        if (detail) {
            let str = ''
            for (let i = 0; i < pop_pageDate.length; i++) {
                str += "<tr><td class='tdStyle_body table_td' style='padding: 5px;'><input id='checkbox_" + pop_pageDate[i]['materialcode'] + "' type='checkbox'  onclick=change(" + i + ") data-id=" + pop_pageDate[i]["materialcode"] + "></td>" +
                    "</td><td class='tdStyle_body table_td' title='" + pop_pageDate[i]['materialcode'] + "'>" + pop_pageDate[i]['materialcode'] +
                    "</td><td class='tdStyle_body table_td' title='" + pop_pageDate[i]['materialname'] + "'>" + pop_pageDate[i]['materialname'] +
                    "</td><td class='tdStyle_body table_td' title='" + pop_pageDate[i]['build_type'] + "'>" + pop_pageDate[i]['build_type'] +
                    "</td><td class='tdStyle_body table_td' title='" + pop_pageDate[i]['preproductid'] + "'>" + pop_pageDate[i]['preproductid'] +
                    "</td><td class='tdStyle_body table_td' title='" + pop_pageDate[i]['planname'] + "'>" + pop_pageDate[i]['planname'] +
                    "</td><td class='tdStyle_body table_td' title='" + pop_pageDate[i]['building_no'] + "'>" + pop_pageDate[i]['building_no'] +
                    "</td><td class='tdStyle_body table_td' title='" + pop_pageDate[i]['floor_no'] + "'>" + pop_pageDate[i]['floor_no'] +
                    "</td><td class='tdStyle_body table_td' title='" + pop_pageDate[i]['path'] + "'>" + pop_pageDate[i]['path'] +
                    "</td></tr>";
            }
            $("#detailTableText").html(str);
            setCheckBox()
        } else {
            let str = '';
            for (let i = 0; i < jsonObj.length; i++) {
                jsonObj[i].orderId = "JSLJ-" + (jsonObj[i]['number'] || '')
                str += "<tr><td class='tdStyle_body table_td' title='" + jsonObj[i]['orderId'] + "'>" + jsonObj[i]['orderId'] +
                    "</td><td class='tdStyle_body table_td' title='" + jsonObj[i]['out_time'] + "'>" + (jsonObj[i]['out_time'] || '') +
                    "</td><td class='tdStyle_body table_td' title='" + jsonObj[i]['customer_name'] + "'>" + (jsonObj[i]['customer_name'] || '') +
                    "</td><td class='tdStyle_body table_td' title='" + jsonObj[i]['address'] + "'>" + (jsonObj[i]['address'] || '') +
                    "</td><td class='tdStyle_body table_td' title='" + jsonObj[i]['contact_name'] + "'>" + (jsonObj[i]['contact_name'] || '') +
                    "</td><td class='tdStyle_body table_td' title='" + jsonObj[i]['material_receiver'] + "'>" + (jsonObj[i]['material_receiver'] || '') +
                    "</td><td class='tdStyle_body table_td' title='" + jsonObj[i]['num'] + "'>" + (jsonObj[i]['num'] || '') +
                    "</td><td class='tdStyle_body table_td' ><a href='#' onclick=printDataF(" + i + ")>打印</a> <a href='#' onclick=delTableData1('" + jsonObj[i].id + "')>删除</a>" +
                    "</td></tr>";
            }
            $("#archTableText").html(str);
        }
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
        let obj = {
            name: $("#planname"),
            type: "1",
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/OutboundOrder",
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
        let obj = {
            name: $("#planname"),
            type: "1",
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/OutboundOrder",
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
        if (newPage == "" || isNaN(newPage))
            return;
        if (newPage > pageAll) {
            alert("超过最大页数")
            return
        }
        let obj = {
            name: $("#planname"),
            type: "1",
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/OutboundOrder",
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

        // if (location === null) {
        //     alert("请选择堆场货位信息")
        //     return
        // }
        let planname = $('#pop_planname option:selected').text();
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
            isOrder: false,
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseInfo",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (result) {
                // result = JSON.parse(result);
                console.log(result)
                if (result.warehouseInfo !== undefined) {
                    pop_pageDate = result.warehouseInfo;
                    updateTable(true);
                    if (newPageCode === 3) {
                        setFooter_d(3, pop_pageAll, pop_pageCur, newPage);
                    }
                    if (newPageCode === 2) {
                        setFooter_d(2, pop_pageAll, pop_pageCur, newPage);
                    }
                    pop_pageCur = newPage;
                }
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

        // if (location === null) {
        //     alert("请选择堆场货位信息")
        //     return
        // }
        let planname = $('#pop_planname option:selected').text();
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
            isOrder: false,
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseInfo",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (result) {
                // result = JSON.parse(result);
                if (result.warehouseInfo !== undefined) {
                    pop_pageDate = result.warehouseInfo;
                    updateTable(true);
                    $('#li_d' + newPage % 5).addClass('active');
                    $('#li_d' + pop_pageCur % 5).removeClass('active');
                    pop_pageCur = newPage;
                }
            }
        });
    }

    function jumpToNewPage_d2() {
        pop_pageDate = []
        var newPage = parseInt($('#jump_to_d').val());
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

        // if (location === null) {
        //     alert("请选择堆场货位信息")
        //     return
        // }
        let planname = $('#pop_planname option:selected').text();
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
            isOrder: false,
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetWarehouseInfo",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (result) {
                if (result.warehouseInfo !== undefined) {
                    pop_pageDate = result.warehouseInfo;
                    updateTable(true);
                    jump_d2(newPage, pop_pageAll);
                    pop_pageCur = newPage;
                }
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
</script>
<style>
    table {
        table-layout: fixed; /* 只有定义了表格的布局算法为fixed，下⾯td的定义才能起作⽤。 */
    }

    .title {
        width: 100%;
    }

    .title_text {
        line-height: 25px;
        width: 100%;
        display: flex;
        justify-content: space-between;
    }

    .title_item {
        width: 250px;
    }

    .table_td {
        width: 100%;
        word-break: keep-all; /* 不换⾏ */
        white-space: nowrap; /* 不换⾏ */
        overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
        text-overflow: ellipsis; /* 当对象内⽂本溢出时显⽰省略标记(...) ；需与overflow:hidden;⼀起使⽤。*/
    }

    ::-webkit-scrollbar {
        /*滚动条整体样式*/
        /*高宽分别对应横竖滚动条的尺寸*/
        height: 8px;
    }

</style>
