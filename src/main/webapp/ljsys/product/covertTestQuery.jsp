<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <form name="query" class="form-inline" style="width:85%;height:20%;margin-left: 8%;padding-top:2%">
        <label>物料编码：</label><input type="text" name="materialcode" id="materialcode"
                                   style="width: 13%;height: 30px" class="form-control">
        <label style="margin-left: 2%">物料名称：</label><input type="text" name="materialname" id="materialname"
                                                           style="width: 13%;height: 30px" class="form-control">
        <label style="margin-left: 2%">图号：</label><input type="text" name="drawing_no" id="drawing_no"
                                                         style="width: 13%;height: 30px" class="form-control">
        <label style="margin-left: 2%">项目名称：</label><input type="text" name="planname" id="planname"
                                                           style="width: 13%;height: 30px" class="form-control">
        <label style="margin-left: 2%">质检状态：</label>
        <select id="testState" class="form-control" style="width: 13%;height: 30px">
            <option value=""></option>
            <option value="0">待检验</option>
            <option value="1">检验合格</option>
            <option value="2">检验不合格</option>
        </select> <br><br>
        <label style="margin-left: 1%">操作人：</label><input type="text" name="covert_test_user" id="covert_test_user"
                                                          style="width: 13%;height: 30px" class="form-control">

        <label for="covert_test_startDate">操作日期从：</label><input id="covert_test_startDate" class="form-control"
                                                                type="date"
                                                                style="width: 13%;height: 30px">
        <label for="covert_test_endDate" style="margin-left: 2%">至：</label><input id="covert_test_endDate"
                                                                                  class="form-control"
                                                                                  type="date"
                                                                                  style="width: 13%;height: 30px">
        <label>楼栋：</label><input type="text" name="building_no" id="building_no"
                                 style="width: 8%;height: 30px" class="form-control">
        <label style="margin-left: 2%">楼层：</label><input type="text" name="floor_no" id="floor_no"
                                                         style="width: 8%;height: 30px" class="form-control">
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:85%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>隐蔽性检验信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:18%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="cancelInspect()">
                取消检验
            </button>
            <button type="button" style="position: absolute;right: 22%;top:18%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="openPop()">
                不合格
            </button>
            <button type="button" style="position: absolute;right: 27%;top:18%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="inspect()">
                合格
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class='tdStyle_title active' style="width: 5%"><input id="pre_checkbok" type="checkbox"></td>
                    <td class='tdStyle_title active' style="width: 15%">物料编码</td>
                    <td class='tdStyle_title active' style="width: 15%">物料名称</td>
                    <td class='tdStyle_title active' style="width: 15%">图号</td>
                    <td class='tdStyle_title active' style="width: 8%">楼栋</td>
                    <td class='tdStyle_title active' style="width: 8%">楼层</td>
                    <td class='tdStyle_title active' style="width: 12%">检验状态</td>
                    <td class='tdStyle_title active' style="width: 15%">不合格原因</td>
                    <td class='tdStyle_title active' style="width: 10%">操作日期</td>
                    <td class='tdStyle_title active' style="width: 10%">操作人</td>
                    <td class='tdStyle_title active' style="width: 10%">备注</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:30%;width:70%;height:10%;">
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
    <div class="modal fade" id="myModal" tabindex="-1"
         style="height: 90%;width: 30%;position: absolute;left: 30%;top: 10%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="width: 100%;height: 85%;">
            <div class="modal-content" style="width: 100%;height: 100%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="title1">不通过原因录入</h4>
                </div>
                <div class="modal-body" style="height: 75%;margin: 0 auto">
                    <div class="form-inline" style="width: 100%">
                        <div class="form-group" style="width:100%;margin-top: 5%">
                            <label for="covert_test_remark" style="width:25%;text-align: left;padding-right: 5px"
                                   class="col-sm-2 control-label">备注:</label>
                            <input class="form-control" style="width:40%;" id="covert_test_remark" placeholder="备注"
                                   name="covert_test_remark"/><br><br>
                            <label for="pop_classification" style="width:25%;text-align: left;padding-right: 5px"
                                   class="col-sm-2 control-label">缺陷分类:</label>
                            <select class="form-control" style="width:40%;" id="pop_classification"
                                    name="pop_classification_1" onchange="getFailClass(false);"></select><br><br>
                            <label for="pop_defect_name" style="width:25%;text-align: left;padding-right: 5px"
                                   class="col-sm-2 control-label">缺陷名称:</label>
                            <select class="form-control" style="width:40%;" id="pop_defect_name"
                                    name="pop_defect_name"></select>
                            <button style="" class="btn btn-primary btn-sm" onclick="addReason()">添加
                            </button>
                        </div>
                    </div>
                    <br>
                    <div class="panel panel-default" style="width:80%;height:50%;overflow-y:hidden;">
                        <div class="panel-heading">不通过原因:</div>
                        <div id="newGroups" class="panel-body" style="height:100%;overflow-y:scroll;">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" id="save" onclick="no_inspect()" class="btn btn-primary">保存</button>
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
    let checked = null;
    let reasons = [];
    let selectName = []; //缺陷名称下拉框信息

    getFailClass(true)
    window.onload = getData();

    function reset() {
        $("#covert_test_remark").val('')
        $("#newGroups").empty()
        reasons = []
    }

    $('#myModal').on('hidden.bs.modal', function (e) {
        reset()
    })

    function getData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetDefaultSet",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data !== undefined) {
                    res.data.forEach((item) => {
                        if (item.name == 'concealed_process') {
                            on_or_off = item.on_or_off;
                        }
                    })
                }
            }
        }).then(() => {
            if (on_or_off == '1') {
                getTableData(1)
            } else {
                alert('未开启此状态！')
            }
        })
    }

    function getFailClass(index) {
        //查询缺陷分类
        if (index) {
            $.post("${pageContext.request.contextPath}/GetFailClass", {index: '0'}, function (result) {
                result = JSON.parse(result);
                $('#pop_classification').empty()
                for (let o of result.data) {
                    let item = $("<option value='" + o['id'] + "'>" + o['classification'] + "</option>")
                    $('#pop_classification').append(item)
                }
            });
        } else {
            //查询缺陷名称，也就是分类子项
            let pid = $("#pop_classification").val();
            $.post("${pageContext.request.contextPath}/GetFailClass", {index: '1', pid: pid}, function (result) {
                result = JSON.parse(result);
                selectName = result.data;
                $('#pop_defect_name').empty()
                for (let o of result.data) {
                    let item = $("<option value='" + o['id'] + "'>" + o['defect_name'] + "</option>")
                    $('#pop_defect_name').append(item)
                }
            });
        }
    }

    function getTableData(newPage) {
        let materialcode = $('#materialcode').val();
        let materialname = $('#materialname').val();
        let testState = $('#testState').val();
        let covert_test_user = $('#covert_test_user').val();
        let covert_test_startDate = $('#covert_test_startDate').val();
        let covert_test_endDate = $('#covert_test_endDate').val();
        let drawing_no = $('#drawing_no').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let planname = $('#planname').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            testState: testState,
            covert_test_user: covert_test_user,
            covert_test_startDate: covert_test_startDate,
            covert_test_endDate: covert_test_endDate,
            drawing_no: drawing_no,
            floor_no: floor_no,
            building_no: building_no,
            planname: planname,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }
        if (covert_test_startDate !== '' && covert_test_endDate !== '') {
            if (covert_test_startDate > covert_test_endDate) {
                alert("开始时间不能大于结束时间！");
                return;
            }
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPreProduct",
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

    let pre = 0
    //全选
    $("#pre_checkbok").on("click", function () {
        if (pre == 0) {
            //把所有复选框选中
            $("#archTableText td :checkbox").prop("checked", true);
            pre = 1;
        } else {
            $("#archTableText td :checkbox").prop("checked", false);
            pre = 0;
        }
    });

    function inspect() {
        let obj = [];
        let flag = false
        $('#archTableText').find('input:checked').each(function () {
            let id = $(this).attr('data-id')
            obj.push(id);   //找到对应checkbox中data-id属性值，然后push给空数组pids
            for (let item of jsonObj) {
                if (parseInt(id) == item.pid && item.covert_test == "隐蔽检验不合格") {
                    flag = true
                    alert("物料名称为：" + item.materialname + " 的构建处于不合格状态，需要先取消检验！")
                    break
                }
                if (parseInt(id) == item.pid && item.covert_test == "隐蔽检验合格") {
                    flag = true
                    alert("物料名称为：" + item.materialname + " 的构建处于合格状态，不要重复检验！")
                    break
                }
            }
            if (flag) {
                return false
            }
        });
        if (flag) {
            return;
        }
        if (obj.length === 0) {
            alert("请勾选！")
            return;
        }
        let r = confirm("亲，确认检验！");
        if (r === false) {
            return;
        }

        $.post("${pageContext.request.contextPath}/ConcealedProcess", {
            index: '1',
            covert_test: '1',
            covert_test_user: sessionStorage.getItem("userName"),
            pids: JSON.stringify(obj)
        }, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getTableData(pageCur);
            }
        });
    }

    function openPop() {
        let obj = [];
        let flag = false
        $('#archTableText').find('input:checked').each(function () {
            let id = $(this).attr('data-id')
            obj.push(id);   //找到对应checkbox中data-id属性值，然后push给空数组pids
            for (let item of jsonObj) {
                if (parseInt(id) == item.pid && item.covert_test == "隐蔽检验合格") {
                    flag = true
                    alert("物料名称为：" + item.materialname + " 的构建处于合格状态，需要先取消检验！")
                    break
                }
                if (parseInt(id) == item.pid && item.covert_test == "隐蔽检验不合格") {
                    flag = true
                    alert("物料名称为：" + item.materialname + " 的构建处于不合格状态，不要重复检验！")
                    break
                }
            }
            if (flag) {
                return false
            }
        });
        if (flag) {
            return;
        }
        if (obj.length === 0) {
            alert("请勾选！")
            return;
        }
        reasons = [];
        $("#newGroups").empty();
        $('#myModal').modal('show')
        getFailClass(false);
    }

    function no_inspect() {
        let obj = [];
        $('#archTableText').find('input:checked').each(function () {
            obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
        });
        if (obj.length === 0) {
            alert("请勾选构建信息！")
            return;
        }
        if (reasons.length === 0) {
            alert("请添加不合格原因！")
            return;
        }
        let str = '';
        for (let i = 0; i < reasons.length - 1; i++) {
            str += reasons[i].name + '，';
        }
        str += reasons[reasons.length - 1].name
        let covert_test_remark = $("#covert_test_remark").val()
        $.post("${pageContext.request.contextPath}/ConcealedProcess", {
            index: '0',
            pids: JSON.stringify(obj),
            covert_test_failure_reason: str,
            covert_test_remark: covert_test_remark,
            covert_test_user: sessionStorage.getItem("userName")
        }, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getTableData(pageCur);
                $('#myModal').modal('hide')
                document.getElementById('pre_checkbok').checked = false
                pre = 0;
            }
        });
    }

    function addReason() {
        var id = $("#pop_defect_name :selected").val()
        var name = $("#pop_defect_name :selected").text()

        for (let obj of selectName) {
            let flag = false
            for (let item of reasons) {
                if (item.id == id) {
                    flag = true
                    alert("不合格原因已添加！")
                    break
                }
            }
            if (flag) {
                break
            }
            if (obj.id == id) {
                reasons.push({id: id, name: obj.defect_name});
                var groupdiv = $("#newGroups")
                var newitem = $("<div id='gpname_" + id + "'>" + "<p class='pStyle' style='width:80%;height:30px;float:left;'>" + name + "</p>" + "<button style='width:15%;height:30px;float:left;' class='btn btn-primary  btn-xs' onclick='removeGroup(" + id + ")'>删除</button></br></div>")
                groupdiv.append(newitem)
                break;
            }
        }
    }

    function removeGroup(gpid) {
        // 找到在reasons中的下标
        var idx = 0;
        for (var i = 0; i < reasons.length; i++) {
            if (reasons[i].id == gpid) {
                idx = i
            }
        }
        // 在reasons中删除
        reasons.splice(idx, 1)
        $("#gpname_" + gpid).remove()
    }

    function cancelInspect() {
        let obj = [];
        $('#archTableText').find('input:checked').each(function () {
            obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
        });
        if (obj.length === 0) {
            alert("请勾选！")
            return;
        }
        let r = confirm("亲，确认取消！");
        if (r === false) {
            return;
        }
        $.post("${pageContext.request.contextPath}/ConcealedProcess", {
            index: '1',
            covert_test: '0',
            pids: JSON.stringify(obj)
        }, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getTableData(pageCur);
                document.getElementById('pre_checkbok').checked = false
                pre = 0;
            }
        });
    }

    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            let disable = '';
            let style
            if (on_or_off == '1') {
                if (jsonObj[i]['pourmade'] === 1) {
                    disable = 'disabled'
                } else {
                    disable = ''
                }
            }
            if (jsonObj[i]['covert_test'] === 1) {
                jsonObj[i]['covert_test'] = '隐蔽检验合格'
                jsonObj[i]['covert_test_failure_reason'] = '--'
                style = "style='background-color: green;'"
            } else if (jsonObj[i]['covert_test'] === 2) {
                jsonObj[i]['covert_test'] = '隐蔽检验不合格'
                style = "style='background-color: red;'"
            } else {
                jsonObj[i]['covert_test'] = '未检验'
                jsonObj[i]['covert_test_failure_reason'] = '--'
                style = "style='background-color: grey;'"
            }
            jsonObj[i]['covert_test_time'] = jsonObj[i]['covert_test_time'] === undefined ? '--' : jsonObj[i]['covert_test_time'];
            jsonObj[i]['covert_test_remark'] = jsonObj[i]['covert_test_remark'] === undefined ? '--' : jsonObj[i]['covert_test_remark'];
            jsonObj[i]['covert_test_user'] = jsonObj[i]['covert_test_user'] === undefined ? '--' : jsonObj[i]['covert_test_user'];
            jsonObj[i]['covert_test_failure_reason'] = jsonObj[i]['covert_test_failure_reason'] === undefined ? '--' : jsonObj[i]['covert_test_failure_reason'];
            str += "<tr><td class='tdStyle_body'><input type='checkbox'" + disable + " data-id=" + jsonObj[i]['pid'] + ">" +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['materialcode'] + "'>" + jsonObj[i]['materialcode'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['materialname'] + "'>" + jsonObj[i]['materialname'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['drawing_no'] + "'>" + jsonObj[i]['drawing_no'] +
                "</td><td class='tdStyle_body' title='" + (jsonObj[i]['building_no'] || '') + "'>" + (jsonObj[i]['building_no'] || '') +
                "</td><td class='tdStyle_body' title='" + (jsonObj[i]['floor_no'] || '') + "'>" + (jsonObj[i]['floor_no'] || '') +
                "</td><td class='tdStyle_body'  title='" + jsonObj[i]['covert_test'] + "'" + style + ">" + jsonObj[i]['covert_test'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['covert_test_failure_reason'] + "'>" + jsonObj[i]['covert_test_failure_reason'] +
                "</td><td class='tdStyle_body' >" + jsonObj[i]['covert_test_time'] +
                "</td><td class='tdStyle_body' >" + jsonObj[i]['covert_test_user'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['covert_test_remark'] + "'>" + jsonObj[i]['covert_test_remark'] +
                "</td></tr>";
        }
        document.getElementById('pre_checkbok').checked = false
        pre = 0;
        $("#archTableText").html(str);
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
        let materialcode = $('#materialcode').val();
        let materialname = $('#materialname').val();
        let testState = $('#testState').val();
        let covert_test_user = $('#covert_test_user').val();
        let covert_test_startDate = $('#covert_test_startDate').val();
        let covert_test_endDate = $('#covert_test_endDate').val();
        let drawing_no = $('#drawing_no').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let planname = $('#planname').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            testState: testState,
            covert_test_user: covert_test_user,
            covert_test_startDate: covert_test_startDate,
            covert_test_endDate: covert_test_endDate,
            drawing_no: drawing_no,
            floor_no: floor_no,
            building_no: building_no,
            planname: planname,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPreProduct",
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
        let testState = $('#testState').val();
        let covert_test_user = $('#covert_test_user').val();
        let covert_test_startDate = $('#covert_test_startDate').val();
        let covert_test_endDate = $('#covert_test_endDate').val();
        let drawing_no = $('#drawing_no').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let planname = $('#planname').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            testState: testState,
            covert_test_user: covert_test_user,
            covert_test_startDate: covert_test_startDate,
            covert_test_endDate: covert_test_endDate,
            drawing_no: drawing_no,
            floor_no: floor_no,
            building_no: building_no,
            planname: planname,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }
        if (covert_test_endDate !== '' && covert_test_endDate !== '') {
            if (covert_test_endDate > covert_test_endDate) {
                alert("开始时间不能大于结束时间！");
                return;
            }
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPreProduct",
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
        let materialcode = $('#materialcode').val();
        let materialname = $('#materialname').val();
        let testState = $('#testState').val();
        let covert_test_user = $('#covert_test_user').val();
        let covert_test_startDate = $('#covert_test_startDate').val();
        let covert_test_endDate = $('#covert_test_endDate').val();
        let drawing_no = $('#drawing_no').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let planname = $('#planname').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            testState: testState,
            covert_test_user: covert_test_user,
            covert_test_startDate: covert_test_startDate,
            covert_test_endDate: covert_test_endDate,
            drawing_no: drawing_no,
            floor_no: floor_no,
            building_no: building_no,
            planname: planname,
            isPrint: "true",
            pageCur: newPage,
            pageMax: pageMax
        }
        if (covert_test_endDate !== '' && covert_test_endDate !== '') {
            if (covert_test_endDate > covert_test_endDate) {
                alert("开始时间不能大于结束时间！");
                return;
            }
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPreProduct",
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
