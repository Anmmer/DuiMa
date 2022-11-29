<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:70%;height:10%;margin-left: 14%;padding-top:2%">
        <div class="form-group">
            <label>堆场名称：</label><input type="text" name="query_planname" id="query_planname"
                                       style="" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>项目信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:11%" class="btn btn-primary btn-sm"
                    onclick="openAddPop(1)">
                新增堆场
            </button>
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
                    <td class="tdStyle_title active" style="width: 25%">堆场</td>
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
                                       class="col-sm-2 control-label">堆场信息:</label>
                                <input type="text" class="form-control" style="width:50%;" id="myModal1_name"
                                       name="myModal1_name">
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
                                <select type="text" class="form-control" style="width:50%;" id="myModal2_name1"
                                        name="myModal2_name1"></select><br>
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
                                <select class="form-control" style="width:50%;" id="myModal3_name1"
                                        name="myModal3_name1" onchange="getRegionData()"></select><br>
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

    window.onload = getTableData(1);

    //打开新增弹窗
    function openAddPop(index) {
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
            $("#myModal2_save").attr('onclick', 'region_save()');
            getYardData(index)
        }
        if (index === 3) {
            $('#myModal3').modal('show')
            $("#myModal3_title1").show();
            $("#myModal3_title2").hide();
            $("#myModal3_save").attr('onclick', 'location_save()');
            getYardData(index)
        }

    }

    //打开修改弹窗
    function openEditPop(pid, index, id, yard, region, location) {
        if (index === '1') {
            $('#myModal1').modal('show')
            $("#myModal1_title1").hide();
            $("#myModal1_title2").show();
            $("#myModal1_name").val(yard)
            $("#myModal1_save").attr('onclick', "yard_edit('" + id + "','" + pid + "')");
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
        $.post("${pageContext.request.contextPath}/GetFactory", {type: '1'}, function (result) {
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

    function yard_edit(id, pid) {
        let name = $("#myModal1_name").val()
        if (name === '') {
            alert("请输入")
            return
        }
        $.post("${pageContext.request.contextPath}/UpdateFactory", {id: id, name: name, pid: pid}, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal1').modal('hide');
                getTableData(1)
            }
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
        let pid = $('#myModal3_name1').val()
        if (pid === "") {
            $('#myModal3_name2').empty()
            return
        }
        $.post("${pageContext.request.contextPath}/GetFactory", {
            type: '2',
            pid: pid
        }, function (result) {
            result = JSON.parse(result);
            let yard = result.data

            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal3_name2').append(item)
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
        let obj = {
            name: $('#myModal2_name').val(),
            pid: $('#myModal2_name1').val(),
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
        if (obj.pid === '') {
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
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
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
                        jsonObj.push({id: o.id, yard: o.name, region: '', location: '', pid: o.pid})
                        for (let d of o.children) {
                            jsonObj.push({
                                id: d.id,
                                pid: d.pid,
                                yard: '',
                                yard_d: o.name,
                                location: '',
                                region: d.name,
                            })
                            for (let e of d.children) {
                                jsonObj.push({
                                    id: e.id,
                                    pid: e.pid,
                                    yard: '',
                                    yard_d: o.name,
                                    location: e.name,
                                    region: '',
                                    region_d: d.name,
                                })
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

    function delTableData(id) {
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
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
            str += "<tr><td class='tdStyle_body'>" + jsonObj[i]['yard'] + "</td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['region'] + "</td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['location'] + "</td>";
            if (jsonObj[i]['location'] !== '') {
                str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 3 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard_d'] + "','" + jsonObj[i]['region_d'] + "','" + jsonObj[i]['location'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a> <a href='#' onclick=openQrcode('" + jsonObj[i]['id'] + "','" + jsonObj[i]['location'] + "')>展码</a></td></tr>";
            }
            if (jsonObj[i]['yard'] !== '') {
                str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 1 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            }
            if (jsonObj[i]['region'] !== '') {
                str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 2 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard_d'] + "','" + jsonObj[i]['region'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            }
        }
        $("#archTableText").html(str);
    }

    $('.recover-btn').click(function () {
        reset();
    })

    function openQrcode(id, text) {
        document.getElementById("text").innerText = text + "："
        $("#qrcode").empty()
        //生成二维码
        jQuery('#qrcode').qrcode({
            // new QRCode(document.getElementById("qrcode_" + idx), {
            render: "canvas",
            text: id,
            width: 100,
            height: 100,
            colorDark: "#000000",
            colorLight: "#ffffff",
            src: './img/qr.jpg'
            // correctLevel: QRCode.CorrectLevel.H
        })
    }

</script>
