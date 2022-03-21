<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <form name="query" class="form-inline" style="width:70%;height:15%;margin-left: 14%;padding-top:2%">
        <div class="form-group">
            <label>物料编码：</label><input type="text" name="materialcode" id="materialcode"
                                       style="" class="form-control">
        </div>
        <div class="form-group">
            <label>物料名称：</label><input type="text" name="materialname" id="materialname"
                                       style="" class="form-control">
        </div>
        <label>浇道状态：</label>
        <select id="pourState" class="form-control" style="width: 13%;">
            <option value="2"></option>
            <option value="0">待浇捣</option>
            <option value="1">已浇捣</option>
        </select>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:75%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>浇捣信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:14%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="cancelPour()">
                取消浇捣
            </button>
            <button type="button" style="position: absolute;right: 22%;top:14%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="Pour()">
                浇 捣
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class='tdStyle_title active' style="width: 5%"><input id="pre_checkbok" type="checkbox"></td>
                    <td class='tdStyle_title active' style="width: 15%">物料编码</td>
                    <td class='tdStyle_title active' style="width: 15%">物料名称</td>
                    <td class='tdStyle_title active' style="width: 15%">构建编号</td>
                    <td class='tdStyle_title active' style="width: 15%">线别</td>
                    <td class='tdStyle_title active' style="width: 15%">计划编号</td>
                    <td class='tdStyle_title active' style="width: 10%">浇捣状态</td>
                    <td class='tdStyle_title active' style="width: 10%">操作日期</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:40%;width:70%;height:10%;">
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

    window.onload = getTableData(1);


    function getTableData(newPage) {
        let materialcode = $('#materialcode').val();
        let materialname = $('#materialname').val();
        let pourState = $('#pourState').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            isPrint: "true",
            pourState: pourState,
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
            // console.log($("#archTableText td :checkbox"))
            $("#archTableText td :checkbox").each((index, elem) => {
                console.log(elem['disabled'])
                if (elem['disabled'] === false) {
                    $(elem).attr("checked", true)
                }
            })
            // $("#archTableText td :checkbox").prop("checked", true);
            pre = 1;
        } else {
            $("#archTableText td :checkbox").each((index, elem) => {
                console.log(elem['disabled'])
                if (elem['disabled'] === false) {
                    $(elem).attr("checked", false)
                }
            })
            // $("#archTableText td :checkbox").prop("checked", false);
            pre = 0;
        }

    });

    function Pour() {
        let obj = [];
        $('#archTableText').find('input:checked').each(function () {
            obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
        });
        if (obj.length === 0) {
            alert("请勾选！")
            return;
        }

        let str = '';
        let strData = [];
        obj.forEach((item, index) => {
            strData.push(jsonObj.find((item_) => {
                return item_.pid == parseInt(item)
            }))
        })
        if (strData.length !== 0) {
            strData.forEach((item) => {
                if (item['pourmade'] == "已浇捣") {
                    str += item['materialcode'] + ", "
                }
            })
        }

        if (str !== '') {
            alert("物料编码为:" + str + "的构建已经浇捣！");
            return;
        }

        let r = confirm("亲，确认浇捣！");
        if (r === false) {
            return;
        }
        $.post("${pageContext.request.contextPath}/Pour", {pids: JSON.stringify(obj)}, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getTableData(pageCur);
                document.getElementById('pre_checkbok').checked = false
                pre = 0;
            }
        });
    }

    function cancelPour() {
        let obj = [];
        $('#archTableText').find('input:checked').each(function () {
            obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
        });
        if (obj.length === 0) {
            alert("请勾选！")
            return;
        }


        let str = '';
        let strData = [];
        obj.forEach((item, index) => {
            strData.push(jsonObj.find((item_) => {
                return item_.pid == parseInt(item)
            }))
        })

        if (strData.length !== 0) {
            strData.forEach((item) => {
                if (item['pourmade'] == '未浇捣') {
                    str += item['materialcode'] + ", "
                }
            })
        }

        if (str !== '') {
            alert("物料编码为:" + str + "的构建未浇捣，请先浇捣！");
            return;
        }
        let r = confirm("亲，确认取消！");
        if (r === false) {
            return;
        }

        $.post("${pageContext.request.contextPath}/CancelPour", {pids: JSON.stringify(obj)}, function (result) {
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
        let disable = '';
        for (let i = 0; i < jsonObj.length; i++) {
            if (jsonObj[i]['pourmade'] === 1 && jsonObj[i]['inspect'] === 1) {
                disable = 'disabled'
            } else {
                disable = ''
            }
            jsonObj[i]['pourmade'] = jsonObj[i]['pourmade'] === 0 ? '未浇捣' : '已浇捣';
            jsonObj[i]['pourtime'] = jsonObj[i]['pourtime'] === undefined ? '--' : jsonObj[i]['pourtime'];
            str += "<tr><td class='tdStyle_body'><input type='checkbox' " + disable + " data-id=" + jsonObj[i]['pid'] + ">" +
                "</td><td class='tdStyle_body'>" + jsonObj[i]['materialcode'] +
                "</td><td class='tdStyle_body'>" + jsonObj[i]['materialname'] +
                "</td><td class='tdStyle_body'>" + jsonObj[i]['preproductid'] +
                "</td><td class='tdStyle_body'>" + jsonObj[i]['line'] +
                "</td><td class='tdStyle_body'>" + jsonObj[i]['plannumber'] +
                "</td><td class='tdStyle_body'>" + jsonObj[i]['pourmade'] +
                "</td><td class='tdStyle_body'>" + jsonObj[i]['pourtime'] +
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
        let materialcode = $('#materialcode').val();
        let materialname = $('#materialname').val();
        let pourState = $('#pourState').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            pourState: pourState,
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
        let pourState = $('#pourState').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            pourState: pourState,
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
        let materialcode = $('#materialcode').val();
        let materialname = $('#materialname').val();
        let pourState = $('#pourState').val();
        let obj = {
            materialcode: materialcode,
            materialname: materialname,
            pourState: pourState,
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
            for (let i = 1; i < 6; i++) {
                let k = i % 5;
                if (++m > pageAll) {
                    $('#a_' + k).text('.');
                } else {
                    $('#a_' + k).text(m);
                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m + ')');
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
