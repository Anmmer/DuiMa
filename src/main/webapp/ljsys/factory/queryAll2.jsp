<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询所有群组-->
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;

    function checkAuthority(au) {
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (var i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
</script>
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:95%;height:16%;margin-left: 5%;padding-top:2%">
        <div class="form-group" style="width: 20%;">
            <label>堆场信息：</label>
            <input style="height:10%;width: 68%" name="factoryName"
                   id="factoryName"
                   onclick="openPop()" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%;">
            <label>项目名称：</label><input type="text" id="planname"
                                       style="height:10%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%;">
            <label>楼栋：</label><input type="text" id="building_no"
                                     style="height:10%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;">
            <label>楼层：</label><input type="text" id="floor_no"
                                     style="height:10%;" class="form-control">
        </div>
        <br><br>
        <div class="form-group" style="width: 20%">
            <label>物料编码：</label><input type="text" id="materialcode"
                                       style="height:10%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%">
            <label>构件类型：</label><input type="text" id="build_type"
                                       style="height:10%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%">
            <label>构件编号：</label><input type="text" id="preproductid"
                                       style="height:10%;width: 68%" class="form-control">
        </div>
        <div class="form-group" style="margin-left:3%;width: 20%">
            <label>图号：</label><input type="text" id="drawing_no"
                                     style="height:10%;width: 68%" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:90%;height:78%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>仓库信息</small></h3>
            <%--            <button type="button" style="position: absolute;right: 15%;top:15%" class="btn btn-primary btn-sm"--%>
            <%--                    data-toggle="modal"--%>
            <%--                    data-target="#myModal">--%>
            <%--                添加仓库--%>
            <%--            </button>--%>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td class='tdStyle_title  active' style="width: 150px">物料编码</td>
                    <td class='tdStyle_title active' style="width: 150px">构件名称</td>
                    <td class='tdStyle_title active' style="width: 150px">构件编号</td>
                    <td class='tdStyle_title active' style="width: 100px">构件类型</td>
                    <td class='tdStyle_title active' style="width: 100px">所属项目</td>
                    <td class='tdStyle_title active' style="width: 50px">楼栋</td>
                    <td class='tdStyle_title active' style="width: 50px">楼层</td>
                    <td class='tdStyle_title active' style="width: 80px">方量</td>
                    <td class='tdStyle_title active' style="width: 100px">图号</td>
                    <%--                    <td class='tdStyle_title active' style="width: 10%">方量</td>--%>
                    <td class='tdStyle_title active' style="width: 150px">库位</td>
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
    <div class="modal fade" id="myModal" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
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
                            <label for="myModal_name" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">货位信息:</label>
                            <select type="text" class="form-control" style="width:50%;" id="myModal_name"
                                    name="myModal_name"></select>
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
</div>
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let jsonObj = [];


    window.onload = getYardData(1);

    function openPop() {
        $('#myModal').modal('show')
    }

    function save() {
        let myModal_name1 = $("#myModal_name1 option:selected").text() ? $("#myModal_name1 option:selected").text() + '/' : '../'
        let myModal_name2 = $("#myModal_name2 option:selected").text() ? $("#myModal_name2 option:selected").text() + '/' : '../'
        let myModal_name3 = $("#myModal_name3 option:selected").text() ? $("#myModal_name3 option:selected").text() : '..'
        let str
        if (myModal_name1 === '' && myModal_name2 === '' && myModal_name3 === '') {
            str = ''
        } else {
            str = myModal_name1 + myModal_name2 + myModal_name3
        }
        $("#factoryName").val(str)
        $('#myModal').modal('hide')
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

    function getTableData(newPage) {
        let myModal_name1 = $("#myModal_name1 option:selected").val()
        let myModal_name2 = $("#myModal_name2 option:selected").val()
        let myModal_name = $("#myModal_name option:selected").val()
        let factoryName = '';
        if (myModal_name1) {
            factoryName = myModal_name1
        }
        if (myModal_name2) {
            factoryName = myModal_name2
        }
        if (myModal_name) {
            factoryName = myModal_name
        }
        let planname = $('#planname').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let materialcode = $('#materialcode').val();
        let build_type = $('#build_type').val();
        let drawing_no = $('#drawing_no').val();
        let preproductid = $('#preproductid').val();
        let obj = {
            factoryName: factoryName,
            planname: planname,
            preproductid: preproductid,
            building_no: building_no,
            floor_no: floor_no,
            materialcode: materialcode,
            build_type: build_type,
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


    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle_body' title='" + jsonObj[i]['materialcode'] + "'>" + jsonObj[i]['materialcode'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['materialname'] + "'>" + jsonObj[i]['materialname'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['preproductid'] + "'>" + jsonObj[i]['preproductid'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['build_type'] + "'>" + jsonObj[i]['build_type'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['planname'] + "'>" + jsonObj[i]['planname'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['building_no'] + "'>" + jsonObj[i]['building_no'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['floor_no'] + "'>" + jsonObj[i]['floor_no'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['fangliang'] + "'>" + jsonObj[i]['fangliang'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['drawing_no'] + "'>" + jsonObj[i]['drawing_no'] +
                "</td><td class='tdStyle_body' title='" + jsonObj[i]['path'] + "'>" + jsonObj[i]['path'] +
                "</td></tr>";
        }
        $("#archTableText").html(str);
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
        let myModal_name1 = $("#myModal_name1 option:selected").val()
        let myModal_name2 = $("#myModal_name2 option:selected").val()
        let myModal_name = $("#myModal_name option:selected").val()
        let factoryName = '';
        if (myModal_name1) {
            factoryName = myModal_name1
        }
        if (myModal_name2) {
            factoryName = myModal_name2
        }
        if (myModal_name) {
            factoryName = myModal_name
        }
        let planname = $('#planname').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let materialcode = $('#materialcode').val();
        let build_type = $('#build_type').val();
        let drawing_no = $('#drawing_no').val();
        let preproductid = $('#preproductid').val();
        let obj = {
            factoryName: factoryName,
            planname: planname,
            preproductid: preproductid,
            building_no: building_no,
            floor_no: floor_no,
            materialcode: materialcode,
            build_type: build_type,
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
        let myModal_name1 = $("#myModal_name1 option:selected").val()
        let myModal_name2 = $("#myModal_name2 option:selected").val()
        let myModal_name = $("#myModal_name option:selected").val()
        let factoryName = '';
        if (myModal_name1) {
            factoryName = myModal_name1
        }
        if (myModal_name2) {
            factoryName = myModal_name2
        }
        if (myModal_name) {
            factoryName = myModal_name
        }
        let planname = $('#planname').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let materialcode = $('#materialcode').val();
        let build_type = $('#build_type').val();
        let drawing_no = $('#drawing_no').val();
        let preproductid = $('#preproductid').val();
        let obj = {
            factoryName: factoryName,
            planname: planname,
            preproductid: preproductid,
            building_no: building_no,
            floor_no: floor_no,
            materialcode: materialcode,
            build_type: build_type,
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
        let newPage = parseInt($('#jump_to').val());
        let myModal_name1 = $("#myModal_name1 option:selected").val()
        let myModal_name2 = $("#myModal_name2 option:selected").val()
        let myModal_name = $("#myModal_name option:selected").val()
        let factoryName = '';
        if (myModal_name1) {
            factoryName = myModal_name1
        }
        if (myModal_name2) {
            factoryName = myModal_name2
        }
        if (myModal_name) {
            factoryName = myModal_name
        }
        let planname = $('#planname').val();
        let building_no = $('#building_no').val();
        let floor_no = $('#floor_no').val();
        let materialcode = $('#materialcode').val();
        let build_type = $('#build_type').val();
        let drawing_no = $('#drawing_no').val();
        let preproductid = $('#preproductid').val();
        let obj = {
            factoryName: factoryName,
            planname: planname,
            preproductid: preproductid,
            building_no: building_no,
            floor_no: floor_no,
            materialcode: materialcode,
            build_type: build_type,
            drawing_no: drawing_no,
            pageCur: newPage,
            pageMax: pageMax
        }
        if (newPage == "" || isNaN(newPage))
            return;
        if (newPage > pageAll) {
            alert("超过最大页数")
            return
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
