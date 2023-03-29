<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:89%;height:10%;margin-left: 8%;padding-top:2%">
        <div class="form-group" style="width: 100%;">
            <label>堆场名称：</label><select style="width:15%" name="query_yard"
                                        id="query_yard"
                                        onchange="getRegionDataQuery()" class="form-control"></select>
            <label style="margin-left: 10px">区域名称：</label><select style="width:15%;" name="query_region"
                                                                  id="query_region"
                                                                  class="form-control"></select>
            <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                    onclick="getTableData(1)">
                查 询
            </button>
        </div>

    </form>
    <div style="width:75%;height:80%;margin-left: 8%;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>项目信息</small></h3>
            <button type="button" class="btn btn-primary btn-sm" style="position:absolute;right: 21%;top:11%"
                    onclick="openAddPop(2)">新增区域
            </button>
            <button type="button" class="btn btn-primary btn-sm" style="position:absolute;right: 27%;top:11%"
                    onclick="openAddPop(3)">新增货位
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <%--                    <td class="tdStyle_title active" style="width: 25%">堆场</td>--%>
                    <td class="tdStyle_title active" style="width: 25%">区域</td>
                    <td class="tdStyle_title active" style="width: 25%">货位</td>
                    <td class="tdStyle_title active" style="width: 25%;text-align: center">操作</td>
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
        <div class="modal fade" id="myModal1" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
             data-backdrop="false"
             aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width:60%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModal1_title1">新增堆场</h4>
                        <h4 class="modal-title" id="myModal1_title2">修改堆场</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group" style="margin-top: 5%">
                                <label for="myModal1_name" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">区域信息:</label>
                                <input type="text" class="form-control" style="width:50%;" id="myModal1_name"
                                       name="myModal1_name"><br><br>
                                <label for="myModal1_name2" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">货位信息:</label>
                                <input type="text" class="form-control" style="width:50%;" id="myModal1_name2"
                                       name="myModal1_name2">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                        <button type="button" id="myModal1_save" class="btn btn-primary">保存</button>
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
                        <h4 class="modal-title" id="myModal2_title1">新增区域</h4>
                        <h4 class="modal-title" id="myModal2_title2">修改区域</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group" style="margin-top: 5%">
                                <label for="myModal2_name1" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">堆场信息:</label>
                                <input type="text" class="form-control" disabled style="width:50%;" id="myModal2_name1"
                                       name="myModal2_name1"><br>
                                <label for="myModal2_name" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">区域信息:</label>
                                <input type="text" class="form-control" style="width:50%;" id="myModal2_name"
                                       name="myModal2_name">
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
                        <h4 class="modal-title" id="myModal3_title1">新增货位</h4>
                        <h4 class="modal-title" id="myModal3_title2">修改货位</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group" style="margin-top: 5%">
                                <label for="myModal3_name1" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">堆场信息:</label>
                                <input class="form-control" style="width:50%;" id="myModal3_name1"
                                       name="myModal3_name1" disabled><br>
                                <label for="myModal3_name2" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">区域信息:</label>
                                <select class="form-control" style="width:50%;" id="myModal3_name2"
                                        name="myModal3_name2"></select><br>
                                <label for="myModal3_name" style="width: 28%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">货位信息:</label>
                                <input type="text" class="form-control" style="width:50%;" id="myModal3_name"
                                       name="myModal3_name">
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
    </div>
    <div style="position: absolute;right:5%;top: 17%;">
        <div id="text">展示二维码：</div>
        <div id="qrcode" style="height: 99px;width: 99px;border: 1px solid #5bc0de"></div>
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

    window.onload = getYardData();

    //打开新增弹窗
    function openAddPop(index) {
        let query_yard = $('#query_yard option:selected').text();
        if (query_yard === '') {
            alert("请选择仓库信息")
            return
        }
        if (index === 1) {
            $('#myModal1').modal('show')
            $("#myModal1_title1").show();
            $("#myModal1_title2").hide();
            $("#myModal1_save").attr('onclick', 'yard_save()');
        }
        if (index === 2) {
            $('#myModal2').modal('show')
            $("#myModal2_title1").show();
            $("#myModal2_title2").hide();
            $("#myModal2_name1").val(query_yard)
            $("#myModal2_save").attr('onclick', 'region_save()');
        }
        if (index === 3) {
            $('#myModal3').modal('show')
            $("#myModal3_title1").show();
            $("#myModal3_title2").hide();
            $("#myModal3_name1").val(query_yard)
            getRegionData()
            $("#myModal3_save").attr('onclick', 'location_save()');
        }

    }

    //打开修改弹窗
    function openEditPop(region_id, index, location_id, region, location) {
        if (index === '1') {
            if (location_id === 'undefined') {
                alert("请先新增货位")
                return
            }
            $('#myModal1').modal('show')
            $("#myModal1_title1").hide();
            $("#myModal1_title2").show();
            $("#myModal1_name").val(region)
            $("#myModal1_name2").val(location)
            $("#myModal1_save").attr('onclick', "yard_edit('" + region_id + "','" + location_id + "')");
        }
        if (index === '2') {
            $('#myModal2').modal('show')
            $("#myModal2_title1").hide();
            $("#myModal2_title2").show();
            let item = $("<option value=''>" + yard + "</option>")
            $('#myModal2_name1').append(item)
            $("#myModal2_name1").attr("disabled", "disabled")
            $("#myModal2_name").val(region)
            $("#myModal2_save").attr('onclick', "region_edit('" + id + "','" + pid + "')");
        }
        if (index === '3') {
            $('#myModal3').modal('show')
            $("#myModal3_title1").hide();
            $("#myModal3_title2").show();
            let item1 = $("<option value=''>" + yard + "</option>")
            $('#myModal3_name1').append(item1)
            $("#myModal3_name1").attr("disabled", "disabled")
            let item2 = $("<option value=''>" + region + "</option>")
            $('#myModal3_name2').append(item2)
            $("#myModal3_name2").attr("disabled", "disabled")
            $("#myModal3_name").val(location)
            $("#myModal3_save").attr('onclick', "location_edit('" + id + "','" + pid + "')");
        }
    }

    function getYardData(index) {
        $.post("${pageContext.request.contextPath}/GetFactory", {
            type: '1',
            pageCur: '1',
            pageMax: '999'
        }, function (result) {
            result = JSON.parse(result);
            let yard = result.data
            $('#myModal' + index + '_name1').empty()
            $('#myModal' + index + '_name1').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal' + index + '_name1').append(item)
            }
        })

    }

    function yard_edit(regin_id, location_id) {
        let name1 = $("#myModal1_name").val()
        let name2 = $("#myModal1_name2").val()
        if (name1 === '') {
            alert("区域不能为空")
            return
        }
        if (name2 === '') {
            alert("货位不能为空")
            return
        }
        $.post("${pageContext.request.contextPath}/UpdateFactory", {
            id: regin_id,
            name: name1,
            pid: $('#query_yard option:selected').val()
        }, function (result) {
        }).then(() => {
            $.post("${pageContext.request.contextPath}/UpdateFactory", {
                id: location_id,
                name: name2,
                pid: regin_id
            }, function (result) {
                result = JSON.parse(result);
                alert(result.message);
                if (result.flag) {
                    $('#myModal1').modal('hide');
                    getTableData(1)
                }
            })
        })
    }

    function region_edit(id, pid) {
        let name = $("#myModal2_name").val()
        if (name === '') {
            alert("请输入")
            return
        }
        $.post("${pageContext.request.contextPath}/UpdateFactory", {id: id, name: name, pid: pid}, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal2').modal('hide');
                getTableData(1)
            }
        })
    }

    function location_edit(id, pid) {
        let name = $("#myModal3_name").val()
        if (name === '') {
            alert("请输入")
            return
        }
        $.post("${pageContext.request.contextPath}/UpdateFactory", {id: id, name: name, pid: pid}, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal3').modal('hide');
                getTableData(1)
            }
        })
    }

    function getRegionData() {
        let pid = $('#query_yard').val()
        if (pid === "") {
            alert("请选择堆场信息")
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
            console.log(yard)
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal3_name2').append(item)
            }
        })

    }

    function getRegionDataQuery() {
        let pid = $('#query_yard').val()
        if (pid === "") {
            alert("请选择堆场信息")
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
            $("#query_region").empty()
            let item = $("<option value=''></option>")
            $('#query_region').append(item)
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#query_region').append(item)
            }
        })

    }


    function yard_save() {
        let obj = {
            name: $('#myModal1_name').val(),
            pid: '0',
            type: '1'
        }
        if (obj.name === '') {
            alert("请输入！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddFactory", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal1').modal('hide');
                getTableData(1)
            }
        })
    }


    function region_save() {
        let query_yard = $('#query_yard').val()
        if (!query_yard) {
            alert("请选择仓库信息")
            return;
        }
        let obj = {
            name: $('#myModal2_name').val(),
            pid: query_yard,
            type: '2'
        }
        if (obj.name === '') {
            alert("请输入！");
            return;
        }
        if (obj.pid === '') {
            alert("请选择！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddFactory", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal2').modal('hide');
                getTableData(1)
            }
        })
    }

    function location_save() {
        let obj = {
            name: $('#myModal3_name').val(),
            pid: $('#myModal3_name2').val(),
            type: '3'
        }
        if (obj.name === '') {
            alert("请输入！");
            return;
        }
        if (obj.pid === '' || obj.pid === null) {
            alert("请选择！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddFactory", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal3').modal('hide');
                getTableData(1)
            }
        })
    }

    //关闭弹窗
    function closePop() {
        $('#myModal').modal('hide')
        reset();
    }

    //重置弹窗
    function reset() {
        $('#myModal1_name').val('');
        $('#myModal2_name').val('');
        $('#myModal3_name').val('');
    }

    $('#myModal1').on('hidden.bs.modal', function (e) {
        $('#myModal1_name').val('');
    })

    $('#myModal2').on('hidden.bs.modal', function (e) {
        $('#myModal2_name').val('');
    })

    $('#myModal3').on('hidden.bs.modal', function (e) {
        $('#myModal3_name').val('');
        $('#myModal3_name2').empty();
    })

    function getTableData(newPage) {
        let factoryId = $('#query_yard option:selected').val();
        let regionId = $('#query_region option:selected').val();
        let obj = {
            factoryId: factoryId,
            regionId: regionId
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetFactory",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = [];
                    for (let o of res.data) {
                        for (let d of o.children) {
                            let obj = {}
                            obj.region = d.name
                            obj.region_id = d.id
                            if (!d.children.length) {
                                obj.location = ''
                                jsonObj.push(obj)
                                continue
                            }
                            for (let e of d.children) {
                                let obj = {}
                                obj.region = d.name
                                obj.region_id = d.id
                                obj.location = e.name
                                obj.location_id = e.id
                                jsonObj.push(obj)
                            }
                        }
                    }
                    updateTable();
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

    function getYardData() {
        $.post("${pageContext.request.contextPath}/GetFactory", {
            type: '1',
            pageCur: '1',
            pageMax: '999'
        }, function (result) {
            result = JSON.parse(result);
            let yard = result.data
            $('#query_yard').empty()
            $('#query_yard').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#query_yard').append(item)
            }
        })
    }



    function getLocation() {
        let pid = $('#myModal_name2 option:selected').val()
        $('#myModal_name').empty()
        $.post("${pageContext.request.contextPath}/GetFactory", {
            type: '3',
            pid: pid,
            pageCur: '1',
            pageMax: '999'
        }, function (result) {
            result = JSON.parse(result);
            let yard = result.data
            $('#myModal_name').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal_name').append(item)
            }
        })
    }

    function delTableData(regin_id, location_id) {
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        let id
        if (location_id !== 'undefined') {
            id = location_id
        } else {
            id = regin_id
        }
        $.post("${pageContext.request.contextPath}/DeleteFactory", {id: id}, function (result) {
            result = JSON.parse(result);
            if (result.flag) {
                alert(result.message);
                getTableData(1)
            }
        })
    }

    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            str += "<tr>" +
                // "<td class='tdStyle_body'>" + jsonObj[i]['yard'] + "</td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['region'] + "</td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['location'] + "</td>";
            // if (jsonObj[i]['location'] !== '') {
            str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['region_id'] + "','" + 1 + "','" + jsonObj[i]['location_id'] + "','" + jsonObj[i]['region'] + "','" + jsonObj[i]['location'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['region_id'] + "','" + jsonObj[i]['location_id'] + "')>删除</a> <a href='#' onclick=openQrcode('" + jsonObj[i]['location_id'] + "','" + jsonObj[i]['location'] + "')>展码</a></td></tr>";
            // }
            // if (jsonObj[i]['yard'] !== '') {
            //     str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 1 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            // }
            // if (jsonObj[i]['region'] !== '') {
            //     str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 2 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard_d'] + "','" + jsonObj[i]['region'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            // }
        }
        $("#archTableText").html(str);
    }

    $('.recover-btn').click(function () {
        reset();
    })

    function openQrcode(id, text) {
        if (id === 'undefined') {
            alert("请先添加货位信息")
            return
        }
        document.getElementById("text").innerText = text + "："
        $("#qrcode").empty()
        //生成二维码
        jQuery('#qrcode').qrcode({
            // new QRCode(document.getElementById("qrcode_" + idx), {
            render: "canvas",
            text: 'https://mes.ljzggroup.com/DuiMaNew/ToView?warehouseId=' + id + '&id=2',
            width: 100,
            height: 100,
            colorDark: "#000000",
            colorLight: "#ffffff",
            src: './img/qr.jpg'
            // correctLevel: QRCode.CorrectLevel.H
        })
    }

</script>
