<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width: 100%">
    <button onclick="returnLastPage()" style="position: absolute;left: 4%;top: 4%" class="btn btn-primary btn-sm">返回</button>
    <form name="query" class="form-inline" style="width:85%;height:10%;margin-left: 8%;padding-top:2%">
        <div class="form-group">
            <label>项目名称：</label><input type="text" name="query_planname" disabled id="query_planname"
                                       style="" class="form-control">
        </div>
        <div class="form-group">
            <label>楼栋：</label><input type="text" name="query_build_no" id="query_build_no"
                                   disabled  class="form-control">
        </div>
        <div class="form-group">
            <label>楼层：</label><input type="text" name="query_floor_no" id="query_floor_no"
                                   disabled    class="form-control">
        </div>
    </form>
    <div style="width:85%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>批次信息</small></h3>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class='tdStyle_title active' style="width: 14%">物料编号</td>
                    <td class='tdStyle_title active' style="width: 14%">物料名称</td>
                    <td class='tdStyle_title active' style="width: 10%">规格</td>
                    <td class='tdStyle_title active' style="width: 10%">图号</td>
                    <td class='tdStyle_title active' style="width: 10%">构建类型</td>
                    <td class='tdStyle_title active' style="width: 10%">楼栋号</td>
                    <td class='table_tr_print tdStyle_title active' style="width: 10%">楼层号</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:30%;width:70%;height:10%;">
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
</div>
<script type="text/javascript">

    let count = 1;      //分页总页数
    let jsonObj = [];   //档案信息
    let pageCur = 1;    //分页当前页
    let pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let planname_old = null;

    let query_planname;
    let building_no;
    let floor_no;

    window.onload = getTableData(1);


    function returnLastPage() {
        window.history.go(-1);
    }

    function getTableData(newPage) {
        query_planname = decodeURIComponent(getQueryVariable('planname'))
        building_no = getQueryVariable('building_no')
        console.log(building_no)
        floor_no = getQueryVariable('floor_no')

        $('#query_planname').val(query_planname)
        $('#query_build_no').val(building_no)
        $('#query_floor_no').val(floor_no)
        let obj = {
            'planname': query_planname,
            'building_no': building_no,
            'floor_no': floor_no,
            'pageCur': newPage,
            'pageMax': pageMax
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetFloorNoDetail",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res !== undefined) {
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

    function goto(planname) {

    }

    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle_body' style='padding: 5px;' title='" + jsonObj[i]['materialcode'] + "'>" + jsonObj[i]['materialcode'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + jsonObj[i]['materialname'] + "'>" + jsonObj[i]['materialname'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + jsonObj[i]['standard'] + "'>" + jsonObj[i]['standard'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + jsonObj[i]['drawing_no'] + "'>" + jsonObj[i]['drawing_no'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + jsonObj[i]['build_type'] + "'>" + jsonObj[i]['build_type'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + jsonObj[i]['building_no'] + "'>" + jsonObj[i]['building_no'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + jsonObj[i]['floor_no'] + "'>" + jsonObj[i]['floor_no'] +
                "</td></tr>";
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
            url: "${pageContext.request.contextPath}/GetFloorNoDetail",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    $('#pop_planname').val(res.data[0].planname);
                }
            },
            error: function () {
                alert("查询失败！")
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
        let obj = {
            'planname': query_planname,
            'building_no': building_no,
            'floor_no': floor_no,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetFloorNoDetail",
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
            'planname': query_planname,
            'building_no': building_no,
            'floor_no': floor_no,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetFloorNoDetail",
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
        var newPage = $('#jump_to').val();
        if (newPage > pageAll) {
            alert("超过最大页数")
        }
        let obj = {
            'planname': query_planname,
            'building_no': building_no,
            'floor_no': floor_no,
            'pageCur': newPage,
            'pageMax': 10
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetFloorNoDetail",
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
