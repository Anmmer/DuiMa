<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width: 100%">
    <form name="query" class="form-inline" style="width:80%;height:10%;margin-left: 10%;padding-top:2%">
        <div class="form-group">
            <label>项目名称：</label><input type="text" name="query_planname" id="query_planname"
                                       style="" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:80%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>项目信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:10%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="openAddPop()">
                新 增
            </button>
            <%--            <button style="position:absolute;top: 15%;width: 5%" onclick="openAddPop()">新 增</button>--%>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="tdStyle_title active" style="width: 16%">项目信息</td>
                    <td class="tdStyle_title active" style="width: 16%">客户名称</td>
                    <td class="tdStyle_title active" style="width: 16%">现场联系人</td>
                    <td class="tdStyle_title active" style="width: 16%">送货地址</td>
                    <td class="tdStyle_title active" style="width: 16%">收料员</td>
                    <td class="tdStyle_title active" style="width: 10%">每方钢筋用量(kg)</td>
                    <td class="tdStyle_title active" style="width: 16%;text-align: center">操作</td>
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
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
             data-backdrop="false"
             aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width:75%">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="title1">项目新增</h4>
                        <h4 class="modal-title" id="title2">项目修改</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="form-group" style="margin-left:2%;margin-top: 5%">
                                <label for="pop_planname" style="width: 32%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">项目信息:</label>
                                <input type="text" class="form-control" style="width:50%;" id="pop_planname"
                                       name="pop_planname"><br>
                                <label for="pop_planname" style="width: 32%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">客户名称:</label>
                                <input type="text" class="form-control" style="width:50%;" id="pop_customer_name"
                                       name="pop_customer_name"><br>
                                <label for="pop_planname" style="width: 32%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">现场联系人:</label>
                                <input type="text" class="form-control" onclick="openName(1)" style="width:50%;"
                                       id="pop_contact_name"
                                       name="pop_contact_name"><br>
                                <label for="pop_planname" style="width: 32%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">送货地址:</label>
                                <input type="text" class="form-control" style="width:50%;" id="pop_address"
                                       name="pop_address"><br>
                                <label for="pop_planname" style="width: 32%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">收料员:</label>
                                <input type="text" class="form-control" onclick="openName(2)" style="width:50%;"
                                       id="pop_material_receiver"
                                       name="pop_material_receiver"><br>
                                <label for="pop_consumption" style="width: 32%;text-align: left;padding-right: 0"
                                       class="col-sm-2 control-label">每方钢筋用量(kg):</label>
                                <input type="text" class="form-control" style="width:50%;" id="pop_consumption"
                                       name="pop_consumption">
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
        <!-- Modal -->
        <div class="modal fade" id="myModal1" tabindex="2" style="position: absolute;left: 15%;top: 12%;" role="dialog"
             data-backdrop="false"
             aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width:80%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="name1">现场联系人</h4>
                        <h4 class="modal-title" id="name2">收料员</h4>
                    </div>
                    <div class="modal-body" style="height: 50%;overflow: auto">
                        <table class="table table-hover" style="text-align: center">
                            <tr>
                                <td class="tdStyle_title active" style="width: 10%">勾选</td>
                                <td class="tdStyle_title active" id="table_name" style="width: 35%">收料员姓名</td>
                                <td class="tdStyle_title active" style="width: 35%">手机号</td>
                            </tr>
                            <tbody id="nameTableText">
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                        <button type="button" id="save_name" class="btn btn-primary">保存</button>
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

    let count = 1;      //分页总页数
    let jsonObj = [];   //档案信息
    let pageCur = 1;    //分页当前页
    let pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let planname_old = null;
    let jsonObjName = []

    window.onload = getTableData(1);

    //打开新增弹窗
    function openAddPop() {
        $('#myModal').modal('show')
        $("#title1").show();
        $("#title2").hide();
        $("#save").attr('onclick', 'save()');
    }

    function openName(index) {
        if (index === 1) {
            $('#myModal1').modal('show')
            $("#name1").show();
            $("#name2").hide();
            document.getElementById("table_name").innerText = "现场联系人"
            $.ajax({
                url: "${pageContext.request.contextPath}/Contact",
                type: 'post',
                dataType: 'json',
                data: {
                    type: '1',
                    pageCur: 1,
                    pageMax: 999
                },
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data.length !== 0) {
                        jsonObjName = res.data
                        updateNameTable()
                    }
                }
            })
        } else {
            $('#myModal1').modal('show')
            $("#name1").hide();
            $("#name2").show();
            document.getElementById("table_name").innerText = "收料员"
            $.ajax({
                url: "${pageContext.request.contextPath}/MaterialReceiver",
                type: 'post',
                dataType: 'json',
                data: {
                    type: '1',
                    pageCur: 1,
                    pageMax: 999
                },
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                success: function (res) {
                    if (res.data.length !== 0) {
                        jsonObjName = res.data
                        updateNameTable()
                    }
                }
            })
        }

        $("#save_name").attr('onclick', 'saveName(' + index + ')');
    }

    function saveName(index) {
        let arr = []
        $('#nameTableText').find('input:checked').each(function () {
            //找到对应checkbox中data-id属性值，然后push给空数组pids
            console.log($(this).attr('data-id'))
            let id = $(this).attr('data-id')
            let obj = jsonObjName.find((val) => {
                return id === val.id
            })
            if (obj) {
                arr.push(obj)
            }
        });
        console.log(arr)
        let str = arr.map((val) => {
            return val.name + ' ' + val.phone
        }).join('，')
        if (index === 1) {
            $("#pop_contact_name").val(str)
        } else {
            $("#pop_material_receiver").val(str)
        }
        $('#myModal1').modal('hide')
    }

    //打开修改弹窗
    function openEditPop(id, planname, unit_consumption) {
        planname_old = planname
        queryData(id);
        $('#myModal').modal('show')
        $("#title1").hide();
        $("#title2").show();
        $("#save").attr('onclick', 'edit(' + id + ')');
    }

    //关闭弹窗
    function closePop() {
        $('#myModal').modal('hide')
        reset();
    }

    //重置弹窗
    function reset() {
        $('#pop_planname').val('');
    }

    $('#myModal').on('hidden.bs.modal', function (e) {
        $('#pop_planname').val('');
    })

    function updateNameTable() {
        let str = '';
        for (let i = 0; i < jsonObjName.length; i++) {
            str += "<tr><td class='tdStyle_body'><input type='checkbox' data-id=" + jsonObjName[i]["id"] + ">" +
                "</td><td class='tdStyle_body'>" + jsonObjName[i]['name'] +
                "</td><td class='tdStyle_body'>" + jsonObjName[i]['phone'] +
                "</td></tr>";
        }
        $("#nameTableText").html(str);
    }

    function getTableData(newPage) {
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
            'pageCur': newPage,
            'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlanName",
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
                updateTable(false);
                alert("查询失败！")
            }
        })
    }

    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle_body' title='" + (jsonObj[i]['planname'] || '') + "'>" + jsonObj[i]['planname'] +
                "</td><td class='tdStyle_body' title='" + (jsonObj[i]['customer_name'] || '') + "'>" + (jsonObj[i]['customer_name'] || '') +
                "</td><td class='tdStyle_body' title='" + (jsonObj[i]['contact_name'] || '') + "'>" + (jsonObj[i]['contact_name'] || '') +
                "</td><td class='tdStyle_body' title='" + (jsonObj[i]['address'] || '') + "'>" + (jsonObj[i]['address'] || '') +
                "</td><td class='tdStyle_body' title='" + (jsonObj[i]['material_receiver'] || '') + "'>" + (jsonObj[i]['material_receiver'] || '') +
                "</td><td class='tdStyle_body' title='" + (jsonObj[i]['unit_consumption'] || '') + "'>" + (jsonObj[i]['unit_consumption'] || '') +
                "</td><td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['id'] + "','" + jsonObj[i]['planname'] + "','" + jsonObj[i]['unit_consumption'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "','" + jsonObj[i]['planname'] + "')>删除</a></td></tr>";
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
            url: "${pageContext.request.contextPath}/GetPlanName",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    $('#pop_planname').val(res.data[0].planname);
                    $('#pop_customer_name').val(res.data[0].customer_name);
                    $('#pop_contact_name').val(res.data[0].contact_name);
                    $('#pop_address').val(res.data[0].address);
                    $('#pop_material_receiver').val(res.data[0].material_receiver);
                    $('#pop_consumption').val(res.data[0].unit_consumption);
                }
            },
            error: function () {
                alert("查询失败！")
            }
        })
    }

    function delTableData(id, planname) {
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        $.post("${pageContext.request.contextPath}/DeletePlanName", {id: id, planname: planname}, function (result) {
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
            planname: $('#pop_planname').val(),
            unit_consumption: $('#pop_consumption').val(),
            customer_name: $('#pop_customer_name').val(),
            contact_name: $('#pop_contact_name').val(),
            address: $('#pop_address').val(),
            material_receiver: $('#pop_material_receiver').val(),
        }
        if (obj.planname === '') {
            alert("请输入项目名称！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddPlanName", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal').modal('hide');
                getTableData(1);
            }
        })
    }

    function edit(id) {
        let obj = {
            planname: $('#pop_planname').val(),
            planname_old: planname_old,
            unit_consumption: $('#pop_consumption').val(),
            customer_name: $('#pop_customer_name').val(),
            contact_name: $('#pop_contact_name').val(),
            address: $('#pop_address').val(),
            material_receiver: $('#pop_material_receiver').val(),
            id: id
        }
        if (obj.planname === '') {
            alert("请输入！");
            return;
        }
        $.post("${pageContext.request.contextPath}/UpdatePlanName", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                $('#myModal').modal('hide');
                getTableData(1);
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
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlanName",
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
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlanName",
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
        let query_planname = $('#query_planname').val();
        var newPage = $('#jump_to').val();
        if (newPage > pageAll) {
            alert("超过最大页数")
        }
        let obj = {
            'planname': query_planname,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlanName",
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
